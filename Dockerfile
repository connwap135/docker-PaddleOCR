# Version: 1.0.0
FROM hub.baidubce.com/paddlepaddle/paddle:2.0.0rc0

# PaddleOCR base on Python3.7
RUN pip3.7 install --upgrade pip -i https://mirror.baidu.com/pypi/simple

RUN python3.7 -m pip install paddlepaddle==2.0.0rc0 -i https://mirror.baidu.com/pypi/simple

RUN pip3.7 install paddlehub --upgrade -i https://mirror.baidu.com/pypi/simple

RUN mkdir -p /home && cd /home

RUN git clone https://gitee.com/paddlepaddle/PaddleOCR.git

RUN cd /home/PaddleOCR &&  pip3.7 install -r requirments.txt -i https://mirror.baidu.com/pypi/simple

RUN mkdir -p /home/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/server/det/ch_ppocr_server_v1.1_det_infer.tar /home/PaddleOCR/inference
RUN tar xf /home/PaddleOCR/inference/ch_ppocr_server_v1.1_det_infer.tar -C /home/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/server/rec/ch_ppocr_server_v1.1_rec_infer.tar /home/PaddleOCR/inference
RUN tar xf /home/PaddleOCR/inference/ch_ppocr_server_v1.1_rec_infer.tar -C /home/PaddleOCR/inference

ADD https://paddleocr.bj.bcebos.com/20-09-22/cls/ch_ppocr_mobile_v1.1_cls_infer.tar /home/PaddleOCR/inference
RUN tar xf /home/PaddleOCR/inference/ch_ppocr_mobile_v1.1_cls_infer.tar -C /home/PaddleOCR/inference

RUN cd /home/PaddleOCR &&export PYTHONPATH=/home/PaddleOCR && hub install deploy/hubserving/ocr_system/
EXPOSE 8866
WORKDIR /home/PaddleOCR

CMD ["/bin/bash","-c","export PYTHONPATH=/home/PaddleOCR &&  hub serving start -m ocr_system"]