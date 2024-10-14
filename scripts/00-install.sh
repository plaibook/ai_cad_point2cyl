#!/bin/bash

# 📂 Navigate to the workspace directory
cd /workspace

# 🔄 Clone the GitHub repository
git clone https://github.com/plaibook/ai_cad_point2cyl.git
cd ai_cad_point2cyl

# 🐍 Create a new conda environment with Python 3.8
conda create --name ai_cad_point2cyl python=3.8 -y

# ⚙️ Initialize conda for the current shell
conda init

# 🔄 Source the .bashrc to apply conda changes
source ~/.bashrc

# 🚀 Activate the newly created environment
conda activate ai_cad_point2cyl

# 📥 Install dependencies
apt-get install -y g++

# 🐍 Install packages
pip install torch==1.8.1
pip install -r requirements.txt

# 🎉 Done! Your conda environment is ready to use.
