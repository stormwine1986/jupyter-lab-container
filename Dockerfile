# 使用官方的 Python 基础镜像
FROM python:3.11.10-bullseye

# 设置环境变量
ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    npm \
    && rm -rf /var/lib/apt/lists/*

# 安装 JupyterLab
RUN pip install jupyterlab ipywidgets

# 安装 PyTorch
RUN pip install torch torchvision torchaudio

# 暴露端口
EXPOSE 8888

# 设置工作目录
WORKDIR /root

# 创建必要的目录
RUN mkdir -p /root/.local /root/.jupyter /root/workspace /mnt/models


# 以 root 用户身份运行 JupyterLab 并指定工作空间
CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--notebook-dir", "/root/workspace", "--no-browser", "--allow-root"]

# 挂载工作空间和 Hugging Face 的缓存目录
VOLUME /root/workspace
VOLUME /mnt/models
