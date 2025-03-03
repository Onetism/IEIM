# IEIM
This is the source code for the manuscript "Inter-event Interval Microscopy for Event Cameras".

## Environment
tifffile \
Pytorch \
OpenCV  \
scikit-image \
lpips 

Install the [Matlab](https://www.mathworks.com/products/matlab.html)  for your system. 

## Datasets preparation
See [IEIMat](https://pan.baidu.com/s/18AUvgvH9kNfdgtEAyQxXpQ?pwd=an20)

## IEI reconstruction on real data 
The real dataset for IEIM can be downloaded [here](https://pan.baidu.com/s/1VERuyxhpIfi7CeiKR77n-w?pwd=yqur) and should be extracted to the `datasets` directory. Run the `IEI_real.m` script in MATLAB. 
The results will be automatically saved in the corresponding path of the original data.

## IEI reconstruction on synthetic data
The synthetic dataset for IEIM can be downloaded [here](https://pan.baidu.com/s/1Qhazr5ODy91UOWaNQmWQww?pwd=1yn3) and should be extracted to the `datasets` directory. Run the `IEI_sim.m` script in MATLAB. 
The results will be automatically saved in the corresponding path of the original data.

## Eval metrics on synthetic data

```
python eval_metrics.py
```
