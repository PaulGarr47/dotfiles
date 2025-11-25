#!/bin/bash

# Get the GPU utilization from nvidia-smi

GPU_UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

# Output JSON for Waybar

echo '{"text": "'"${GPU_UTIL}"'%"}' 
