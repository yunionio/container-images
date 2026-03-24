FROM registry.cn-beijing.aliyuncs.com/cloudpods/comfyui-boot:cu128-slim

# 安装插件
RUN cd /default-comfyui-bundle/ComfyUI/custom_nodes && git clone https://github.com/romandev-codex/ComfyUI-Downloader.git && \
	cd ComfyUI-Downloader && pip install -r requirements.txt

USER root
WORKDIR /root
ENV CLI_ARGS=""
CMD ["bash","/runner-scripts/entrypoint.sh"]
