#!/bin/bash

# 1) threshold mask to the relevant number (60% in this case)
fslmaths juelich_thr60_cmamyg_l.nii.gz -thr 60 juelich_thr60_cmamyg_l.nii.gz
fslmaths juelich_thr60_lbamyg_l.nii.gz -thr 60 juelich_thr60_lbamyg_l.nii.gz
fslmaths juelich_thr60_supamyg_l.nii.gz -thr 60 juelich_thr60_supamyg_l.nii.gz

fslmaths juelich_thr60_cmamyg_r.nii.gz -thr 60 juelich_thr60_cmamyg_r.nii.gz
fslmaths juelich_thr60_lbamyg_r.nii.gz -thr 60 juelich_thr60_lbamyg_r.nii.gz
fslmaths juelich_thr60_supamyg_r.nii.gz -thr 60 juelich_thr60_supamyg_r.nii.gz

# 2) find the maximum value for each voxel, separately in each hemisphere:
fslmaths juelich_thr60_cmamyg_l.nii.gz -max juelich_thr60_supamyg_l.nii.gz -max juelich_thr60_lbamyg_l.nii.gz maxmask_thr60_amyg_l.nii.gz
fslmaths juelich_thr60_cmamyg_r.nii.gz -max juelich_thr60_supamyg_r.nii.gz -max juelich_thr60_lbamyg_r.nii.gz maxmask_thr60_amyg_r.nii.gz

# 3) add 1 to the max mask
fslmaths maxmask_thr60_amyg_l.nii.gz -add 1 maxmask+1_thr60_amyg_l.nii.gz 
fslmaths maxmask_thr60_amyg_r.nii.gz -add 1 maxmask+1_thr60_amyg_r.nii.gz 

#4) threshold the max mask to more then 1 so that out of mask voxels will not be considered
fslmaths maxmask+1_thr60_amyg_l.nii.gz -thr 1.1 maxmask+1_thr60_amyg_l.nii.gz
fslmaths maxmask+1_thr60_amyg_r.nii.gz -thr 1.1 maxmask+1_thr60_amyg_r.nii.gz

#5) substract the max values mask from each mask
fslmaths maxmask+1_thr60_amyg_l.nii.gz -sub juelich_thr60_cmamyg_l.nii.gz juelich_thr60_cmamyg_l_max.nii.gz
fslmaths maxmask+1_thr60_amyg_l.nii.gz -sub juelich_thr60_lbamyg_l.nii.gz juelich_thr60_lbamyg_l_max.nii.gz
fslmaths maxmask+1_thr60_amyg_l.nii.gz -sub juelich_thr60_supamyg_l.nii.gz juelich_thr60_supamyg_l_max.nii.gz 

fslmaths maxmask+1_thr60_amyg_r.nii.gz -sub juelich_thr60_cmamyg_r.nii.gz juelich_thr60_cmamyg_r_max.nii.gz
fslmaths maxmask+1_thr60_amyg_r.nii.gz -sub juelich_thr60_lbamyg_r.nii.gz juelich_thr60_lbamyg_r_max.nii.gz
fslmaths maxmask+1_thr60_amyg_r.nii.gz -sub juelich_thr60_supamyg_r.nii.gz juelich_thr60_supamyg_r_max.nii.gz 

#6) remove all values higher than 1 (indicating that there is another nucleus with higher probability)
fslmaths juelich_thr60_cmamyg_l_max.nii.gz -uthr 1 juelich_thr60_cmamyg_l_max.nii.gz
fslmaths juelich_thr60_lbamyg_l_max.nii.gz -uthr 1 juelich_thr60_lbamyg_l_max.nii.gz
fslmaths juelich_thr60_supamyg_l_max.nii.gz -uthr 1 juelich_thr60_supamyg_l_max.nii.gz

fslmaths juelich_thr60_cmamyg_r_max.nii.gz -uthr 1 juelich_thr60_cmamyg_r_max.nii.gz
fslmaths juelich_thr60_lbamyg_r_max.nii.gz -uthr 1 juelich_thr60_lbamyg_r_max.nii.gz
fslmaths juelich_thr60_supamyg_r_max.nii.gz -uthr 1 juelich_thr60_supamyg_r_max.nii.gz

#7) the masks are already binarized, but binarize it officially just to be on the safe side
fslmaths juelich_thr60_cmamyg_l_max.nii.gz -bin juelich_thr60_cmamyg_l_max.nii.gz
fslmaths juelich_thr60_lbamyg_l_max.nii.gz -bin juelich_thr60_lbamyg_l_max.nii.gz
fslmaths juelich_thr60_supamyg_l_max.nii.gz -bin juelich_thr60_supamyg_l_max.nii.gz

fslmaths juelich_thr60_cmamyg_r_max.nii.gz -bin juelich_thr60_cmamyg_r_max.nii.gz
fslmaths juelich_thr60_lbamyg_r_max.nii.gz -bin juelich_thr60_lbamyg_r_max.nii.gz
fslmaths juelich_thr60_supamyg_r_max.nii.gz -bin juelich_thr60_supamyg_r_max.nii.gz

#8) create bilateral mask for each nucleus
fslmaths juelich_thr60_cmamyg_l_max.nii.gz -add juelich_thr60_cmamyg_r_max.nii.gz juelich_thr60_cmamyg_bilateral_max.nii.gz
fslmaths juelich_thr60_lbamyg_l_max.nii.gz -add juelich_thr60_lbamyg_r_max.nii.gz juelich_thr60_lbamyg_bilateral_max.nii.gz
fslmaths juelich_thr60_supamyg_l_max.nii.gz -add juelich_thr60_supamyg_r_max.nii.gz juelich_thr60_supamyg_bilateral_max.nii.gz