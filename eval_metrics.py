import os
import numpy as np
from skimage import io, metrics
import lpips
import cv2  # For resizing images
import torch
import tifffile

# Load LPIPS model
lpips_model = lpips.LPIPS(net='vgg')

# Define file paths
filepath = './datasets/Synthetic/interp_CodedIllumination_evaluation_static/'
raw_image_path = './raw/datasets/Synthetic/'

# Get list of files
filelist = [f for f in os.listdir(filepath) if f.endswith('.txt')]

for filename in filelist:
    full_filename = os.path.join(filepath, filename)
    sample_name = os.path.splitext(filename)[0]
    
    # Load TFI image
    tfi_path = os.path.join(filepath, sample_name, 'IEI_Recon.tif')
    tfirecon = io.imread(tfi_path)[207]
    tfirecon = 255 - tfirecon
    tfirecon = tfirecon.astype(np.float32) / 255.0  # Normalize to [0, 1]

    # Determine raw image name
    raw_name = sample_name.split('_eqja')[0]
    raw_image_file = os.path.join(raw_image_path, raw_name + '.png')
    print(raw_name)
    # Load and resize raw image
    rawimage = io.imread(raw_image_file)
    rawimage = 255 - rawimage
    rawimage = rawimage.astype(np.float32) / 255.0  # Normalize to [0, 1]
    rawimage = cv2.resize(rawimage, (512, int(rawimage.shape[0] * 512 // rawimage.shape[1])))
    
    # Compute SSIM
    ssim_val = metrics.structural_similarity(tfirecon, rawimage, gaussian_weights=True, sigma=1.5, use_sample_covariance=False, data_range=1.0)
    print(f'SSIM value is {ssim_val:.4f}')
    
    # Compute MSE
    mse_val = metrics.mean_squared_error(tfirecon, rawimage)
    print(f'MSE value is {mse_val:.4f}')
    
    # Convert to torch tensors for LPIPS
    tfirecon_tensor = torch.from_numpy(tfirecon).unsqueeze(0).unsqueeze(0).float()  # Add batch and channel dimensions
    rawimage_tensor = torch.from_numpy(rawimage).unsqueeze(0).unsqueeze(0).float()  # Add batch and channel dimensions
    # Compute LPIPS
    with torch.no_grad():
        lpips_val = lpips_model(tfirecon_tensor, rawimage_tensor)
    print(f'LPIPS value is {lpips_val.item():.4f} \n')
