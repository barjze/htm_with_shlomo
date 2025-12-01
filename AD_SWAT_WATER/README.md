# AD_HTM_SWAT_WATER

Do the following to install and run the code used to create results for:
"The use of HTM and TSSE Encoder for Online Anomaly Detection in Industrial Cyber-Physical Systems" paper.

 
SWAT dataset
============
- request the dataset from https://itrust.sutd.edu.sg/itrust-labs_datasets/dataset_info/
- download SWAT.A1 & A2_Dec 2015 version.

Tools needed to run the code
============================
- 7-zip
- Excel
- Python 3.9.6
- GIT for source control
- Pycharm (2024.1.1) as Python IDE
- Visual Studio 2019 as C++ IDE  (use C++11)
- Matlab R2021a as matlab IDE
- Beyond Compare (for file comparison, you can use any other tool for that)
 
Installation
============
- install the tools from the list above.
- download HTM from https://github.com/romanma9999/htm.core.git 
- compile from the source using the instructions provided in the repo readme (also see RomanReadMe.txt in HTM.core main dir)
  also see HTM installation instructions in https://github.com/htm-community/htm.core/
- please create a Python project for htm in Pycharm with a Python 3.9 interpreter. 
- unpack swat dataset to main\swat directory

After HTM code compilation, make sure htm.core package version 2.1.196 installed in the Python project packages.

RUN
=== 
- run "parse_SWAT_and_prepare_HTM_data.m" from main\matlab dir
- run_learn_mixed_diff.bat from main directory
- run_learn_mixed_abs.bat from main directory
- the "swat_htm_results_learn_mixed_"abs,diff".xlsx"  files are created in \main dir 
  those excel files contain the anomaly detection summary of the results for (Ak,Dk),(dAk,Dk) feature channels. 
 

 

 

 