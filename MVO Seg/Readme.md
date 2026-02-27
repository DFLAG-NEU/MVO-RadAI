## Stage I: MVOSeg

The MVOSeg module (Stage I) is based on the official PyTorch implementation of **LVPSegNet**, a previously published work for segmentation on LGE-CMR (including microvascular obstruction, MVO).  
Upstream codebase and documentation are available here:

- **LVPSegNet (official)**: https://github.com/DFLAG-NEU/LVPSegNet

> **Note**  
> We integrate LVPSegNet as an upstream segmentation component within our workflow, together with additional preprocessing and downstream radiomics/survival modeling.

---

## Acknowledgements

This project incorporates components adapted from **LVPSegNet**. Please refer to the original repository for details:  
https://github.com/DFLAG-NEU/LVPSegNet
