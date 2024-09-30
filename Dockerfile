# 使用官方的 Python 基础镜像
FROM python:3.11.10-bullseye

# 设置环境变量
ENV LC_ALL=C.UTF-8 LANG=C.UTF-8

# 安装必要的依赖
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装 JupyterLab
RUN pip install jupyterlab

# 暴露端口
EXPOSE 8888

# 设置工作目录
WORKDIR /home/jovyan

# 添加一个默认用户
RUN useradd -m jovyan && \
    mkdir -p /home/jovyan/.local /home/jovyan/.jupyter /home/jovyan/workspace && \
    chown -R jovyan:jovyan /home/jovyan


# 切换到默认用户
USER jovyan

# 以默认用户身份运行 JupyterLab 并指定工作空间
CMD ["jupyter", "lab", "--ip", "0.0.0.0", "--port", "8888", "--notebook-dir", "/home/jovyan/workspace", "--no-browser", "--config=/home/jovyan/.jupyter/jupyter_lab_config.py"]
