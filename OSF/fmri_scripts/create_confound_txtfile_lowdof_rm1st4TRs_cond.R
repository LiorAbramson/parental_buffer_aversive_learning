
# This script creates a confound.txt file from the fmriprep *desc-confound_regressors.tsv file
# It creates regressors separately for each scan (cond1, cond2). 
# It removes the first 4 TRs from the file (dummy TRs)

# Nuisance regressors to include: 
# a) mean global CSF and mean global WM
# c) 12 motion regressors (6 motion + their derivatives)
# d) all censored frames

# load libraries
  library(tidyverse)

# create placeholder for task. Change this line according to whether you want to process (cond1 or cond2)
  task <- "task-cond2"

# read in data file
  df <- read_tsv(paste0("confound_",task,".tsv"))

#clean dataframe
  df_clean <- df %>%
  # select columns of interest
    select(# average WM and CSF signals in derived masks
         csf,
         white_matter,
         # 12 motion parameters
         trans_x,
         trans_x_derivative1,
         trans_y,
         trans_y_derivative1,
         trans_z,
         trans_z_derivative1,
         rot_x,
         rot_x_derivative1,
         rot_y,
         rot_y_derivative1,
         rot_z,
         rot_z_derivative1,
         # each motion outlier (FD > 0.9) 
         starts_with("motion_outlier")) %>% 
  # replace the n/a's with 0's for motion derivatives
    mutate(trans_x_derivative1 = ifelse(trans_x_derivative1 == "n/a", 0, trans_x_derivative1),
           trans_y_derivative1 = ifelse(trans_y_derivative1 == "n/a", 0, trans_y_derivative1),
           trans_z_derivative1 = ifelse(trans_z_derivative1 == "n/a", 0, trans_z_derivative1),
           rot_x_derivative1 = ifelse(rot_x_derivative1 == "n/a", 0, rot_x_derivative1),
           rot_y_derivative1 = ifelse(rot_y_derivative1 == "n/a", 0, rot_y_derivative1),
           rot_z_derivative1 = ifelse(rot_z_derivative1 == "n/a", 0, rot_z_derivative1))

#remove the first 4 dummy TRs
  df_clean_rm1st4TRs <- df_clean[-c(1:4),]

# remove columns of censored frames that reflect the first 4 dummy TRs 
# (i.e., columns that equals exactly zero because the 1 that indicates the frame is censored was deleted in the previous row)    
  which_remove <- c()
  for (i in 15:ncol(df_clean_rm1st4TRs)) {
    if (sum(df_clean_rm1st4TRs[,i]) == 0){which_remove<-c(which_remove,i)}
  	}
  df_clean_rm1st4TRs <- df_clean_rm1st4TRs[,-which_remove]



# save cleaned dataframe as a .txt file with tab separated values
  write.table(df_clean, file = paste0("confound_lowdof_",task,".txt"), 
            sep = "\t", # specify tab separated values
            col.names = F, # removes names of columns
            row.names = F, # removes names of rows (in this case, numbers)
            quote = F) # removes quotes around values in the first row


# save cleaned dataframe without the first 4 TRs as a .txt file with tab separated values 
  write.table(df_clean_rm1st4TRs, file = paste0("confound_lowdof_",task,"_rm1st4TRs.txt"),
            sep = "\t", # specify tab separated values
            col.names = F, # removes names of columns
            row.names = F, # removes names of rows (in this case, numbers)
            quote = F) # removes quotes around values in the first row
