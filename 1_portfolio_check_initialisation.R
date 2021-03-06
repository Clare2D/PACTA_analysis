## Project Initialisation
rm(list=ls())

options(encoding = "UTF-8") 

library(tidyr)
library(dplyr)
library(scales)
library(reshape2)
library(tidyverse)
library(readxl)
library(tidyselect)


if (rstudioapi::isAvailable()) {
  working_location <- dirname(rstudioapi::getActiveDocumentContext()$path)
} else {
  working_location <- getwd()
}

working_location <- gsub("�","",working_location)
working_location <- paste0(working_location, "/")
setwd(working_location)

library(r2dii.utils)

# TODO: check encodings

source("0_portfolio_test.R", encoding = "windows-1252")
source("0_graphing_functions.R", encoding = "windows-1252")
source("0_reporting_functions.R", encoding = "windows-1252")
source("0_portfolio_input_check_functions.R", encoding = "windows-1252")
source("0_global_functions.R", encoding = "windows-1252")
source("0_sda_approach.R", encoding = "windows-1252")

project_name <- "PACTA_2020_TESTS_CJ"
twodii_internal <- TRUE
# TRUE or FALSE: TRUE means that the code is running on a 2dii laptop with dropbox connection

#####################################################################
###ONLY FOR EXTERNAL PROJECTS (twodii_internal <- FALSE):
# Variables must exist for internal projects
project_location_ext <- "C:/WS/PACTA/ExternalTest/Inputs"
data_location_ext <- "C:/WS/PACTA/Data/02_DataExchange200225/07_AnalysisInputs/2019Q4_250220"
#####################################################################

create_project_folder(project_name, twodii_internal, project_location_ext)

set_project_paths(project_name, twodii_internal, project_location_ext)

copy_files(project_name)

options(r2dii_config = paste0(par_file_path,"/AnalysisParameters.yml"))

set_global_parameters(paste0(par_file_path,"/AnalysisParameters.yml"))

analysis_inputs_path <- set_analysis_inputs_path(twodii_internal, data_location_ext, dataprep_timestamp)

