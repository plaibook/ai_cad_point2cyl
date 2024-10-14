#!/bin/bash

# 🌐 Update and install necessary packages for downloading and extracting
sudo apt-get update
sudo apt-get install -y wget tar

# 📥 Download the tar.gz file from the provided URL
wget http://download.cs.stanford.edu/orion/Point2Cyl/data.tar.gz

# 📦 Create the 'data' directory if it doesn't exist
mkdir -p data

# 📂 Extract the contents of the tar.gz file into the 'data' directory
tar -xzf data.tar.gz -C data

# 🧹 Clean up by removing the tar.gz file after extraction
rm data.tar.gz

mv data data_old
mv data_old/data/ data
rm -rf data_old
