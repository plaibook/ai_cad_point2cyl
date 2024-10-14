#!/bin/bash

# 🌐 Update and install necessary packages for downloading and extracting
sudo apt-get update
sudo apt-get install -y wget tar

# 📥 Download the tar.gz file from the provided URL
wget http://download.cs.stanford.edu/orion/Point2Cyl/data.tar.gz

# 📂 Extract the contents of the tar.gz file into the current directory
tar -xzf data.tar.gz

# 🧹 Clean up by removing the tar.gz file after extraction
rm data.tar.gz
