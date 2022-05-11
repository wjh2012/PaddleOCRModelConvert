#! /bin/bash
set -e errexit

function echoColor() {
    echo -e "\033[32m${1}\033[0m"
}

#=============参数配置=============================
# 测试图像，用于比较转换前后是否一致
test_img_path="doc/imgs_words_en/word_10.png"

echoColor ">>> Download the pretrain model"
cd pretrained_models
wget https://paddleocr.bj.bcebos.com/PP-OCRv2/chinese/ch_PP-OCRv2_rec_infer.tar
tar xvf ch_PP-OCRv2_rec_infer.tar && rm ch_PP-OCRv2_rec_infer.tar
cd ..
echoColor ">>> Download finished"

# 下载好的推理模型地址
save_inference_path="pretrained_models/ch_PP-OCRv2_rec_infer"

# 转换识别模型对应的字典
rec_char_dict_path="ppocr/utils/ppocr_keys_v1.txt"
#==============================================

save_onnx_path="convert_model/${save_inference_path##*/}.onnx"

# inference → onnx
echoColor ">>> starting inference → onnx"
paddle2onnx --model_dir ${save_inference_path} \
            --model_filename inference.pdmodel \
            --params_filename inference.pdiparams \
            --save_file ${save_onnx_path} \
            --opset_version 12
echoColor ">>> finished converted"

# onnx → dynamic onnx
echoColor ">>> strarting change it to dynamic model"
python change_dynamic.py --onnx_path ${save_onnx_path} \
                         --type_model "rec"
echoColor ">>> finished converted"

# verity onnx
echoColor ">>> starting verity consistent"
python tools/infer/predict_rec_vertify_same.py --image_dir=${test_img_path} \
                                               --rec_model_dir=${save_inference_path} \
                                               --onnx_path ${save_onnx_path} \
                                               --rec_char_dict_path ${rec_char_dict_path} \
                                               --use_gpu False
echoColor ">>> finished converted"

echoColor ">>> The final model has been saved "${save_onnx_path}
