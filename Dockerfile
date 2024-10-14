# 🌟 Base image from DockerHub
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
WORKDIR /workspace
COPY . /workspace


# 📝 Add the first script as 'setup_env.sh'
RUN echo '#!/bin/bash\n\
cd /workspace\n\
git clone https://github.com/plaibook/ai_cad_point2cyl.git\n\
cd ai_cad_point2cyl\n\
conda create --name ai_cad_point2cyl python=3.8 -y\n\
conda init\n\
source ~/.bashrc\n\
conda activate ai_cad_point2cyl\n\
apt-get install -y g++\n\
pip install torch==1.8.1\n\
pip install -r requirements.txt\n\
echo "🎉 Done! Your conda environment is ready to use."' > /workspace/setup_env.sh

# 📝 Add the second script as 'download_data.sh'
RUN echo '#!/bin/bash\n\
sudo apt-get update\n\
sudo apt-get install -y wget tar\n\
wget http://download.cs.stanford.edu/orion/Point2Cyl/data.tar.gz\n\
mkdir -p data\n\
tar -xzf data.tar.gz -C data\n\
rm data.tar.gz\n\
mv data data_old\n\
mv data_old/data/ data\n\
rm -rf data_old' > /workspace/download_data.sh

# 🛠️ Make the scripts executable
RUN chmod +x /workspace/setup_env.sh /workspace/download_data.sh

# 🔄 Execute the setup script (install environment, clone repo, install dependencies)
RUN bash /workspace/setup_env.sh

# 🔄 Execute the data download and extraction script
RUN bash /workspace/download_data.sh

# 👾 Expose ports for Jupyter Notebook or other services
EXPOSE 22
EXPOSE 80
EXPOSE 8080

# 🎉 Container startup command (you can adjust this depending on your use case)
CMD ["/bin/bash"]
