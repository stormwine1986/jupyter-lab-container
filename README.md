构建命令
```bash
docker build -t jupyterlab:3.11.10-bullseye .
```

创建持久卷
```bash
docker volume create jupyter-lab-ws
```

启动容器
```bash
docker run --rm --gpus all \
	-v jupyter-lab-ws:/root/workspace \
	-v ~/models:/mnt/models
	-p 8888:8888 \
	jupyterlab:3.11.10-bullseye
```
