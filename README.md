# Multi-HMR: Multi-Person Whole-Body Human Mesh Recovery in a Single Shot

<p align="center">
  <img src="assets/visu1.gif" alt="Multi-HMR illustration 1" width="48%"/>
  <img src="assets/visu2.gif" alt="Multi-HMR illustration 2" width="48%"/>
</p>

### original repogitory : [here](https://github.com/naver/multi-hmr)

## Overview

Multi-HMR is a single-shot model for multi-person and expressive human mesh recovery from a single RGB image. It reconstructs multiple humans in 3D and renders side and bird’s-eye views.

## Docker Setup

This repository provides a Docker environment for running Multi-HMR.

### 1. Build the Docker Image

Make sure your `build.sh` script is correctly set up (it should point to the proper Dockerfile). Then run:

```bash
./build.sh
```

### 2. Run the Docker Container

Launch the container with GPU support using:

```bash
./run.sh
```

This script uses the NVIDIA Container Toolkit settings and launches a container with GPU support.

### 3. Run the Demo

Inside the container, execute the following command to run the demo:

```bash
python3.9 demo.py \
    --img_folder example_data \
    --out_folder demo_out \
    --extra_views 1 \
    --model_name multiHMR_896_L
```

The first run will download necessary models and caches. Pre-trained checkpoints will be stored in `$HOME/models/multiHMR`.

## Pre-trained Models

Pre-trained models are available at:

[Google Drive Models Folder](https://drive.google.com/drive/u/0/folders/1I00Nx9x6pzk3lG63Nj49ympRK2KCFVYV)　＊Only authorized persons may download.

Place the downloaded checkpoint files into `$HOME/models/multiHMR/multi-HMR_modules/models`.

## Training

### Training on BEDLAM
To train Multi-HMR on BEDLAM training data with a single GPU, run:

```bash
CUDA_VISIBLE_DEVICES=1 python3.9 train.py \
    --backbone dinov2_vits14 \
    --img_size 336 \
    -j 4 \
    --batch_size 32 \
    --iter 10000 \
    --max_iter 500000 \
    --name multi-hmr_s_336
```

*Tip:* To decrease data-loading time, use the flags `--extension jpg --res 1280`.

### Evaluation
To evaluate a pretrained checkpoint on BEDLAM-val, EHF-test, and 3DPW-test, run:

```bash
CUDA_VISIBLE_DEVICES=0 python3.9 train.py \
    --eval_only 1 \
    --backbone dinov2_vitl14 \
    --img_size 896 \
    --val_data EHF THREEDPW BEDLAM \
    --val_split test test validation \
    --val_subsample 1 20 25 \
    --pretrained models/multiHMR/multiHMR_896_L.pt
```

Check the logs or use TensorBoard to monitor results.

## SMPLX Model

Download the SMPLX neutral model from [SMPLify](http://smplify.is.tue.mpg.de) (registration required) and place `SMPLX_NEUTRAL.npz` in `./models/smplx/`.

## License

This code is distributed under the [CC BY-NC-SA 4.0 License](Multi-HMR_License.txt).
