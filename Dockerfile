# 🐳 Base image from DockerHub
FROM pytorch/pytorch:2.4.0-cuda12.1-cudnn9-runtime

# 💾 Install essential dependencies
RUN apt-get update && apt-get install -y \
    git \
    nano \
    wget \
    tar \
    unzip \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 📂 Copy the project files into the container (workspace directory)
COPY . /workspace/ai_cad_point2cyl

# 🌐 Change working directory to the project directory
WORKDIR /workspace/ai_cad_point2cyl

# 📦 Download data (cached separately)
RUN wget http://download.cs.stanford.edu/orion/Point2Cyl/data.tar.gz

# 📂 Extract the downloaded data
RUN tar -xzf data.tar.gz

# 📦 Download DeepCAD data (cached separately)
RUN wget http://download.cs.stanford.edu/orion/point2cyl/DeepCAD.zip

# 📂 Unzip DeepCAD data
RUN unzip DeepCAD

# 🐍 Create a new conda environment and initialize conda
RUN conda create --name ai_cad_point2cyl python=3.8 -y && \
    conda init bash

# 🐍 Install packages using pip (conda environment reactivated each time)
RUN /bin/bash -c "source ~/.bashrc && conda activate ai_cad_point2cyl && \
    pip install torch==1.8.1 && \
    pip install -r requirements.txt"

# 🌳 Run the evaluation script (conda environment reactivated)
RUN /bin/bash -c "source ~/.bashrc && conda activate ai_cad_point2cyl && \
    python eval.py --logdir=results/Point2Cyl_without_sketch/ --dump_dir=dump/Point2Cyl_without_sketch/ --data_dir=data/"

# 👾 Expose ports for Jupyter Notebook or other services
EXPOSE 22
EXPOSE 80
EXPOSE 8080

# 🎉 Container startup command (you can adjust this depending on your use case)
CMD ["/bin/bash"]
