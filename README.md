### PaddleOCR release/v2.4 相关模型转换
- 本仓库主要是针对性地将[PaddleOCR/release/v2.4](https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.4/doc/doc_ch/models_list.md)转换为onnx模型
- 搭配[RapidOCR](https://github.com/RapidAI/RapidOCR)中相关推理代码使用更佳
- **该项目是文本识别模型的转换，文本检测和方向分类部分并没有显示给出，不过可以参考shell脚本，也可以自行写出**

### TODO
- [ ] 最新出的[release/v2.5](https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.5/doc/doc_ch/models_list.md)相关模型，尝试转换整理

### 运行环境
- 操作系统： Linux / Mac
- 安装依赖包:
    ```bash
    pip install -r requirements.txt -i https://pypi.douban.com/simple/
    ```

### 使用步骤
1. 从[这里](https://github.com/PaddlePaddle/PaddleOCR/blob/release/2.4/doc/doc_ch/models_list.md)下载自己需要转换文本识别模块的**inference**或者**pretrained**模型，保存到`pretrained_models`目录下
2. 配置并运行一下脚本
   **Note: 注意配置里面相应参数**
    - 如果下载的是推理模型
        ```shell
        bash rec_inference_to_onnx.sh
        ```
    - 如果是预训练模型
        ```shell
        bash rec_pretrain_to_onnx.sh
        ```
3. 最终转换后的模型会在`convert_model`目录下
4. 可以移步到[RapidOCR部分的python目录](https://github.com/RapidAI/RapidOCR/tree/main/python/onnxruntime_infer)，替换相应模型即可