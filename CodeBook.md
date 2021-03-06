### Code Book

# Overview
This code book outlines details about the original data, data transformations 
performed by the R script, and data frames created as the result.

# The Original Source
The script creates a tidy, condensed version of the University of California Irvine's (UCI's)
dataset for Human Activity Recognition (HAR) using smartphones that can be used for further research and analysis.
The original UCI HAR Dataset is a public domain dataset built from the recordings of subjects performing activities
of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensor
(see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

It is assumed that the following files from original data are reviewed
prior to proceeding further:
```
  ./UCI HAR Dataset
     README
     features_info
```     
# List of Data Transformations

1. read 'features.txt' into a vector `x(ind,colName)`

2. read both 'test\X_test.txt' and 'train\X_train.txt',
 assign the colun names from the vector `x`
 while filtering only colums with names containing a substrings 'mean' or 'std' 
 then rbind both parts into a dataframe

3. tidy up column names - replace strings of `from`-vector with respective values of `to`
```
 from <- c('^t','^f','Acc','Gyro','Mag','[()]','BodyBody','-',"\\.\\.")
   to <- c('Time.','Frequency.','Accelerometer.','Gyroscope.','Magnitude.','','Body','.','.')
```

For example, the original column `tGravityAcc-mean()-X` becomes `Time.GravityAccelerometer.mean.X`.

4. read up activity id's from both sets; 
 read up activity labels; 
 merge id's and labels for activity; 
 read up subject id's from both sets; 
 create 1st data frame `df` by joining frames `df,acdf,subj` at once by `rowid` ;
 then dropping `rowid,Activity_id` 

5. create 2nd data frame 'df_mean' by  
 calculating mean() of all df-variables but those used to group by Subject_id and Activity

# Data Frame Details: 'df'
```
str(df)
 Casses ‘data.table’ and 'data.frame':  10299 obs. of  81 variables:
  Time.BodyAccelerometer.mean.X                     : num  0.257 0.286 0.275 0.27 0.275 ...
  Time.BodyAccelerometer.mean.Y                     : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
  Time.BodyAccelerometer.mean.Z                     : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
  Time.BodyAccelerometer.std.X                      : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
  Time.BodyAccelerometer.std.Y                      : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
  Time.BodyAccelerometer.std.Z                      : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
  Time.GravityAccelerometer.mean.X                  : num  0.936 0.927 0.93 0.929 0.927 ...
  Time.GravityAccelerometer.mean.Y                  : num  -0.283 -0.289 -0.288 -0.293 -0.303 ...
  Time.GravityAccelerometer.mean.Z                  : num  0.115 0.153 0.146 0.143 0.138 ...
  Time.GravityAccelerometer.std.X                   : num  -0.925 -0.989 -0.996 -0.993 -0.996 ...
  Time.GravityAccelerometer.std.Y                   : num  -0.937 -0.984 -0.988 -0.97 -0.971 ...
  Time.GravityAccelerometer.std.Z                   : num  -0.564 -0.965 -0.982 -0.992 -0.968 ...
  Time.BodyAccelerometer.Jerk.mean.X                : num  0.072 0.0702 0.0694 0.0749 0.0784 ...
  Time.BodyAccelerometer.Jerk.mean.Y                : num  0.04575 -0.01788 -0.00491 0.03227 0.02228 ...
  Time.BodyAccelerometer.Jerk.mean.Z                : num  -0.10604 -0.00172 -0.01367 0.01214 0.00275 ...
  Time.BodyAccelerometer.Jerk.std.X                 : num  -0.907 -0.949 -0.991 -0.991 -0.992 ...
  Time.BodyAccelerometer.Jerk.std.Y                 : num  -0.938 -0.973 -0.971 -0.973 -0.979 ...
  Time.BodyAccelerometer.Jerk.std.Z                 : num  -0.936 -0.978 -0.973 -0.976 -0.987 ...
  Time.BodyGyroscope.mean.X                         : num  0.11998 -0.00155 -0.04821 -0.05664 -0.05999 ...
  Time.BodyGyroscope.mean.Y                         : num  -0.0918 -0.1873 -0.1663 -0.126 -0.0847 ...
  Time.BodyGyroscope.mean.Z                         : num  0.1896 0.1807 0.1542 0.1183 0.0787 ...
  Time.BodyGyroscope.std.X                          : num  -0.883 -0.926 -0.973 -0.968 -0.975 ...
  Time.BodyGyroscope.std.Y                          : num  -0.816 -0.93 -0.979 -0.975 -0.978 ...
  Time.BodyGyroscope.std.Z                          : num  -0.941 -0.968 -0.976 -0.963 -0.968 ...
  Time.BodyGyroscope.Jerk.mean.X                    : num  -0.2049 -0.1387 -0.0978 -0.1022 -0.0918 ...
  Time.BodyGyroscope.Jerk.mean.Y                    : num  -0.1745 -0.0258 -0.0342 -0.0447 -0.029 ...
  Time.BodyGyroscope.Jerk.mean.Z                    : num  -0.0934 -0.0714 -0.06 -0.0534 -0.0612 ...
  Time.BodyGyroscope.Jerk.std.X                     : num  -0.901 -0.962 -0.984 -0.984 -0.988 ...
  Time.BodyGyroscope.Jerk.std.Y                     : num  -0.911 -0.956 -0.988 -0.99 -0.992 ...
  Time.BodyGyroscope.Jerk.std.Z                     : num  -0.939 -0.981 -0.976 -0.981 -0.982 ...
  Time.BodyAccelerometer.Magnitude.mean             : num  -0.867 -0.969 -0.976 -0.974 -0.976 ...
  Time.BodyAccelerometer.Magnitude.std              : num  -0.705 -0.954 -0.979 -0.977 -0.977 ...
  Time.GravityAccelerometer.Magnitude.mean          : num  -0.867 -0.969 -0.976 -0.974 -0.976 ...
  Time.GravityAccelerometer.Magnitude.std           : num  -0.705 -0.954 -0.979 -0.977 -0.977 ...
  Time.BodyAccelerometer.JerkMagnitude.mean         : num  -0.93 -0.974 -0.982 -0.983 -0.987 ...
  Time.BodyAccelerometer.JerkMagnitude.std          : num  -0.896 -0.941 -0.971 -0.975 -0.989 ...
  Time.BodyGyroscope.Magnitude.mean                 : num  -0.796 -0.898 -0.939 -0.947 -0.957 ...
  Time.BodyGyroscope.Magnitude.std                  : num  -0.762 -0.911 -0.972 -0.97 -0.969 ...
  Time.BodyGyroscope.JerkMagnitude.mean             : num  -0.925 -0.973 -0.987 -0.989 -0.99 ...
  Time.BodyGyroscope.JerkMagnitude.std              : num  -0.894 -0.944 -0.984 -0.986 -0.99 ...
  Frequency.BodyAccelerometer.mean.X                : num  -0.919 -0.961 -0.992 -0.993 -0.992 ...
  Frequency.BodyAccelerometer.mean.Y                : num  -0.918 -0.964 -0.965 -0.968 -0.969 ...
  Frequency.BodyAccelerometer.mean.Z                : num  -0.789 -0.957 -0.967 -0.967 -0.98 ...
  Frequency.BodyAccelerometer.std.X                 : num  -0.948 -0.984 -0.995 -0.996 -0.995 ...
  Frequency.BodyAccelerometer.std.Y                 : num  -0.925 -0.97 -0.974 -0.977 -0.967 ...
  Frequency.BodyAccelerometer.std.Z                 : num  -0.636 -0.942 -0.962 -0.969 -0.978 ...
  Frequency.BodyAccelerometer.meanFreq.X            : num  0.0111 0.3521 0.1804 0.0627 -0.0189 ...
  Frequency.BodyAccelerometer.meanFreq.Y            : num  0.12125 0.17455 0.13346 0.26172 -0.00998 ...
  Frequency.BodyAccelerometer.meanFreq.Z            : num  -0.5229 -0.3207 0.1827 0.1518 0.0952 ...
  Frequency.BodyAccelerometer.Jerk.mean.X           : num  -0.9 -0.944 -0.991 -0.991 -0.991 ...
  Frequency.BodyAccelerometer.Jerk.mean.Y           : num  -0.937 -0.969 -0.973 -0.972 -0.98 ...
  Frequency.BodyAccelerometer.Jerk.mean.Z           : num  -0.924 -0.973 -0.972 -0.97 -0.983 ...
  Frequency.BodyAccelerometer.Jerk.std.X            : num  -0.924 -0.962 -0.992 -0.992 -0.994 ...
  Frequency.BodyAccelerometer.Jerk.std.Y            : num  -0.943 -0.98 -0.971 -0.975 -0.979 ...
  Frequency.BodyAccelerometer.Jerk.std.Z            : num  -0.948 -0.981 -0.972 -0.981 -0.989 ...
  Frequency.BodyAccelerometer.Jerk.meanFreq.X       : num  0.451 0.473 0.271 0.277 0.18 ...
  Frequency.BodyAccelerometer.Jerk.meanFreq.Y       : num  0.1372 0.1672 -0.2722 -0.0383 -0.1392 ...
  Frequency.BodyAccelerometer.Jerk.meanFreq.Z       : num  -0.1803 -0.2431 -0.0825 0.0218 0.1009 ...
  Frequency.BodyGyroscope.mean.X                    : num  -0.824 -0.923 -0.973 -0.972 -0.976 ...
  Frequency.BodyGyroscope.mean.Y                    : num  -0.808 -0.926 -0.981 -0.981 -0.98 ...
  Frequency.BodyGyroscope.mean.Z                    : num  -0.918 -0.968 -0.972 -0.967 -0.969 ...
  Frequency.BodyGyroscope.std.X                     : num  -0.903 -0.927 -0.973 -0.967 -0.974 ...
  Frequency.BodyGyroscope.std.Y                     : num  -0.823 -0.932 -0.977 -0.972 -0.977 ...
  Frequency.BodyGyroscope.std.Z                     : num  -0.956 -0.97 -0.979 -0.965 -0.97 ...
  Frequency.BodyGyroscope.meanFreq.X                : num  0.184 0.0181 -0.4791 -0.497 -0.4275 ...
  Frequency.BodyGyroscope.meanFreq.Y                : num  -0.0593 -0.2273 -0.2101 -0.4999 -0.2781 ...
  Frequency.BodyGyroscope.meanFreq.Z                : num  0.4381 -0.1517 0.0493 -0.2589 -0.2913 ...
  Frequency.BodyAccelerometer.Magnitude.mean        : num  -0.791 -0.954 -0.976 -0.973 -0.978 ...
  Frequency.BodyAccelerometer.Magnitude.std         : num  -0.711 -0.96 -0.984 -0.982 -0.979 ...
  Frequency.BodyAccelerometer.Magnitude.meanFreq    : num  -0.4835 0.2035 0.3425 0.3312 0.0711 ...
  Frequency.BodyAccelerometer.JerkMagnitude.mean    : num  -0.895 -0.945 -0.971 -0.972 -0.987 ...
  Frequency.BodyAccelerometer.JerkMagnitude.std     : num  -0.896 -0.934 -0.97 -0.978 -0.99 ...
  Frequency.BodyAccelerometer.JerkMagnitude.meanFreq: num  -0.0354 -0.4912 0.1407 0.1486 0.4222 ...
  Frequency.BodyGyroscope.Magnitude.mean            : num  -0.771 -0.924 -0.975 -0.976 -0.977 ...
  Frequency.BodyGyroscope.Magnitude.std             : num  -0.797 -0.917 -0.974 -0.971 -0.97 ...
  Frequency.BodyGyroscope.Magnitude.meanFreq        : num  -0.0474 -0.0315 -0.1688 -0.2856 -0.3491 ...
  Frequency.BodyGyroscope.JerkMagnitude.mean        : num  -0.89 -0.952 -0.986 -0.986 -0.99 ...
  Frequency.BodyGyroscope.JerkMagnitude.std         : num  -0.907 -0.938 -0.983 -0.986 -0.991 ...
  Frequency.BodyGyroscope.JerkMagnitude.meanFreq    : num  0.0716 -0.4012 0.0629 0.1167 -0.1217 ...
  Activity                                          : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
  Subject_id                                        : int  2 2 2 2 2 2 2 2 2 2 ...
```

# Data Frame Details: 'df_mean'
```
str(df_mean)
 Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame': 180 obs. of  81 variables:
  Subject_id                                        : int  1 1 1 1 1 1 2 2 2 2 ...
  Activity                                          : chr  "LAYING" "SITTING" "STANDING" "WALKING" ...
  Time.BodyAccelerometer.mean.X                     : num  0.222 0.261 0.279 0.277 0.289 ...
  Time.BodyAccelerometer.mean.Y                     : num  -0.04051 -0.00131 -0.01614 -0.01738 -0.00992 ...
  Time.BodyAccelerometer.mean.Z                     : num  -0.113 -0.105 -0.111 -0.111 -0.108 ...
  Time.BodyAccelerometer.std.X                      : num  -0.928 -0.977 -0.996 -0.284 0.03 ...
  Time.BodyAccelerometer.std.Y                      : num  -0.8368 -0.9226 -0.9732 0.1145 -0.0319 ...
  Time.BodyAccelerometer.std.Z                      : num  -0.826 -0.94 -0.98 -0.26 -0.23 ...
  Time.GravityAccelerometer.mean.X                  : num  -0.249 0.832 0.943 0.935 0.932 ...
  Time.GravityAccelerometer.mean.Y                  : num  0.706 0.204 -0.273 -0.282 -0.267 ...
  Time.GravityAccelerometer.mean.Z                  : num  0.4458 0.332 0.0135 -0.0681 -0.0621 ...
  Time.GravityAccelerometer.std.X                   : num  -0.897 -0.968 -0.994 -0.977 -0.951 ...
  Time.GravityAccelerometer.std.Y                   : num  -0.908 -0.936 -0.981 -0.971 -0.937 ...
  Time.GravityAccelerometer.std.Z                   : num  -0.852 -0.949 -0.976 -0.948 -0.896 ...
  Time.BodyAccelerometer.Jerk.mean.X                : num  0.0811 0.0775 0.0754 0.074 0.0542 ...
  Time.BodyAccelerometer.Jerk.mean.Y                : num  0.003838 -0.000619 0.007976 0.028272 0.02965 ...
  Time.BodyAccelerometer.Jerk.mean.Z                : num  0.01083 -0.00337 -0.00369 -0.00417 -0.01097 ...
  Time.BodyAccelerometer.Jerk.std.X                 : num  -0.9585 -0.9864 -0.9946 -0.1136 -0.0123 ...
  Time.BodyAccelerometer.Jerk.std.Y                 : num  -0.924 -0.981 -0.986 0.067 -0.102 ...
  Time.BodyAccelerometer.Jerk.std.Z                 : num  -0.955 -0.988 -0.992 -0.503 -0.346 ...
  Time.BodyGyroscope.mean.X                         : num  -0.0166 -0.0454 -0.024 -0.0418 -0.0351 ...
  Time.BodyGyroscope.mean.Y                         : num  -0.0645 -0.0919 -0.0594 -0.0695 -0.0909 ...
  Time.BodyGyroscope.mean.Z                         : num  0.1487 0.0629 0.0748 0.0849 0.0901 ...
  Time.BodyGyroscope.std.X                          : num  -0.874 -0.977 -0.987 -0.474 -0.458 ...
  Time.BodyGyroscope.std.Y                          : num  -0.9511 -0.9665 -0.9877 -0.0546 -0.1263 ...
  Time.BodyGyroscope.std.Z                          : num  -0.908 -0.941 -0.981 -0.344 -0.125 ...
  Time.BodyGyroscope.Jerk.mean.X                    : num  -0.1073 -0.0937 -0.0996 -0.09 -0.074 ...
  Time.BodyGyroscope.Jerk.mean.Y                    : num  -0.0415 -0.0402 -0.0441 -0.0398 -0.044 ...
  Time.BodyGyroscope.Jerk.mean.Z                    : num  -0.0741 -0.0467 -0.049 -0.0461 -0.027 ...
  Time.BodyGyroscope.Jerk.std.X                     : num  -0.919 -0.992 -0.993 -0.207 -0.487 ...
  Time.BodyGyroscope.Jerk.std.Y                     : num  -0.968 -0.99 -0.995 -0.304 -0.239 ...
  Time.BodyGyroscope.Jerk.std.Z                     : num  -0.958 -0.988 -0.992 -0.404 -0.269 ...
  Time.BodyAccelerometer.Magnitude.mean             : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
  Time.BodyAccelerometer.Magnitude.std              : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
  Time.GravityAccelerometer.Magnitude.mean          : num  -0.8419 -0.9485 -0.9843 -0.137 0.0272 ...
  Time.GravityAccelerometer.Magnitude.std           : num  -0.7951 -0.9271 -0.9819 -0.2197 0.0199 ...
  Time.BodyAccelerometer.JerkMagnitude.mean         : num  -0.9544 -0.9874 -0.9924 -0.1414 -0.0894 ...
  Time.BodyAccelerometer.JerkMagnitude.std          : num  -0.9282 -0.9841 -0.9931 -0.0745 -0.0258 ...
  Time.BodyGyroscope.Magnitude.mean                 : num  -0.8748 -0.9309 -0.9765 -0.161 -0.0757 ...
  Time.BodyGyroscope.Magnitude.std                  : num  -0.819 -0.935 -0.979 -0.187 -0.226 ...
  Time.BodyGyroscope.JerkMagnitude.mean             : num  -0.963 -0.992 -0.995 -0.299 -0.295 ...
  Time.BodyGyroscope.JerkMagnitude.std              : num  -0.936 -0.988 -0.995 -0.325 -0.307 ...
  Frequency.BodyAccelerometer.mean.X                : num  -0.9391 -0.9796 -0.9952 -0.2028 0.0382 ...
  Frequency.BodyAccelerometer.mean.Y                : num  -0.86707 -0.94408 -0.97707 0.08971 0.00155 ...
  Frequency.BodyAccelerometer.mean.Z                : num  -0.883 -0.959 -0.985 -0.332 -0.226 ...
  Frequency.BodyAccelerometer.std.X                 : num  -0.9244 -0.9764 -0.996 -0.3191 0.0243 ...
  Frequency.BodyAccelerometer.std.Y                 : num  -0.834 -0.917 -0.972 0.056 -0.113 ...
  Frequency.BodyAccelerometer.std.Z                 : num  -0.813 -0.934 -0.978 -0.28 -0.298 ...
  Frequency.BodyAccelerometer.meanFreq.X            : num  -0.1588 -0.0495 0.0865 -0.2075 -0.3074 ...
  Frequency.BodyAccelerometer.meanFreq.Y            : num  0.0975 0.0759 0.1175 0.1131 0.0632 ...
  Frequency.BodyAccelerometer.meanFreq.Z            : num  0.0894 0.2388 0.2449 0.0497 0.2943 ...
  Frequency.BodyAccelerometer.Jerk.mean.X           : num  -0.9571 -0.9866 -0.9946 -0.1705 -0.0277 ...
  Frequency.BodyAccelerometer.Jerk.mean.Y           : num  -0.9225 -0.9816 -0.9854 -0.0352 -0.1287 ...
  Frequency.BodyAccelerometer.Jerk.mean.Z           : num  -0.948 -0.986 -0.991 -0.469 -0.288 ...
  Frequency.BodyAccelerometer.Jerk.std.X            : num  -0.9642 -0.9875 -0.9951 -0.1336 -0.0863 ...
  Frequency.BodyAccelerometer.Jerk.std.Y            : num  -0.932 -0.983 -0.987 0.107 -0.135 ...
  Frequency.BodyAccelerometer.Jerk.std.Z            : num  -0.961 -0.988 -0.992 -0.535 -0.402 ...
  Frequency.BodyAccelerometer.Jerk.meanFreq.X       : num  0.132 0.257 0.314 -0.209 -0.253 ...
  Frequency.BodyAccelerometer.Jerk.meanFreq.Y       : num  0.0245 0.0475 0.0392 -0.3862 -0.3376 ...
  Frequency.BodyAccelerometer.Jerk.meanFreq.Z       : num  0.02439 0.09239 0.13858 -0.18553 0.00937 ...
  Frequency.BodyGyroscope.mean.X                    : num  -0.85 -0.976 -0.986 -0.339 -0.352 ...
  Frequency.BodyGyroscope.mean.Y                    : num  -0.9522 -0.9758 -0.989 -0.1031 -0.0557 ...
  Frequency.BodyGyroscope.mean.Z                    : num  -0.9093 -0.9513 -0.9808 -0.2559 -0.0319 ...
  Frequency.BodyGyroscope.std.X                     : num  -0.882 -0.978 -0.987 -0.517 -0.495 ...
  Frequency.BodyGyroscope.std.Y                     : num  -0.9512 -0.9623 -0.9871 -0.0335 -0.1814 ...
  Frequency.BodyGyroscope.std.Z                     : num  -0.917 -0.944 -0.982 -0.437 -0.238 ...
  Frequency.BodyGyroscope.meanFreq.X                : num  -0.00355 0.18915 -0.12029 0.01478 -0.10045 ...
  Frequency.BodyGyroscope.meanFreq.Y                : num  -0.0915 0.0631 -0.0447 -0.0658 0.0826 ...
  Frequency.BodyGyroscope.meanFreq.Z                : num  0.010458 -0.029784 0.100608 0.000773 -0.075676 ...
  Frequency.BodyAccelerometer.Magnitude.mean        : num  -0.8618 -0.9478 -0.9854 -0.1286 0.0966 ...
  Frequency.BodyAccelerometer.Magnitude.std         : num  -0.798 -0.928 -0.982 -0.398 -0.187 ...
  Frequency.BodyAccelerometer.Magnitude.meanFreq    : num  0.0864 0.2367 0.2846 0.1906 0.1192 ...
  Frequency.BodyAccelerometer.JerkMagnitude.mean    : num  -0.9333 -0.9853 -0.9925 -0.0571 0.0262 ...
  Frequency.BodyAccelerometer.JerkMagnitude.std     : num  -0.922 -0.982 -0.993 -0.103 -0.104 ...
  Frequency.BodyAccelerometer.JerkMagnitude.meanFreq: num  0.2664 0.3519 0.4222 0.0938 0.0765 ...
  Frequency.BodyGyroscope.Magnitude.mean            : num  -0.862 -0.958 -0.985 -0.199 -0.186 ...
  Frequency.BodyGyroscope.Magnitude.std             : num  -0.824 -0.932 -0.978 -0.321 -0.398 ...
  Frequency.BodyGyroscope.Magnitude.meanFreq        : num  -0.139775 -0.000262 -0.028606 0.268844 0.349614 ...
  Frequency.BodyGyroscope.JerkMagnitude.mean        : num  -0.942 -0.99 -0.995 -0.319 -0.282 ...
  Frequency.BodyGyroscope.JerkMagnitude.std         : num  -0.933 -0.987 -0.995 -0.382 -0.392 ...
  Frequency.BodyGyroscope.JerkMagnitude.meanFreq    : num  0.176 0.185 0.334 0.191 0.19 ...
```
