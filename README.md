# docker-PaddleOCR

## 构建:
```
docker build -f "Dockerfile" --force-rm -t paddle_ocr  --label "created-by=visual-studio-Code" $PWD
```
## 拉取:
```
docker pull connwap135/paddle_ocr:latest
```
## 运行：
```
docker run --name ppdocr -p 8866:8866 -d paddle_ocr:latest
推荐--Memory reservation(内存回收)
docker run  -it -m 4G --memory-reservation 4G --name ppdocr -p 8866:8866 -d paddle_ocr:latest
```
