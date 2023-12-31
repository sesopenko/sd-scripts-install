#!/bin/bash
pyenv_output=$(pyenv which python)
# Check if "sd-scripts" is present in the output
if [[ $pyenv_output != *sd-scripts* ]]; then
    echo "Error: run pyenv activate sd-scripts first."
    exit 1
fi
pip install torch==2.1.0+cu121 torchvision==0.16+cu121 --index-url https://download.pytorch.org/whl/cu121
# this speeds things up:
pip install xformers==0.0.22
# I've seen it pop up that triton was required for optimizations
pip install triton

# check if cuda works now

cuda_available=$(python cudatest)
# Check if "sd-scripts" is present in the output
if [[ $pyenv_output != *cuda is available* ]]; then
    echo "Cuda is not available. Check over your console output to see what went wrong."
    echo "You can try deleting and re-creating your pyenv environment and running it from"
    echo "scratch carefully."
    exit 1
fi