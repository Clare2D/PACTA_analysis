# Website basic Graph Code

# Libraries
library(grid)
library(ggplot2)
library(ggthemes)
library(dplyr)
library(reshape2)
library(gridExtra)
library(scales)
library(stringr)
library(extrafont)
library(tidyr)
library(knitr)
library(RColorBrewer)
library(matrixStats)
library(rworldmap)
library(ggmap)
library(cowplot)
library(ggrepel)
library(readxl)
library(tidyverse)
library(ggforce) 
library(sitools) 
library(countrycode)

if (rstudioapi::isAvailable()) {
  working_location <- dirname(rstudioapi::getActiveDocumentContext()$path)
} else {
  working_location <- getwd()
}

# Set Reporting Parameters
options(r2dii_config = paste0(par_file_path,"/ReportParameters.yml"))

set_report_parameters(paste0(par_file_path,"/ReportParameters.yml"))

# Set the variables for plotting
graph_values()

# List of Portfolios to print
portfolio_overview <- read_csv(paste0(proc_input_path, "/",project_name,"_overview_portfolio.csv"), col_types = set_col_types(grouping_variables, "cclddd"))
portfolio_overview$investor_name <- clean_punctuation(portfolio_overview$investor_name)
portfolio_overview$portfolio_name <- clean_punctuation(portfolio_overview$portfolio_name)
report_list <- get_report_list(portfolio_overview)


template <- readLines(paste0(getwd(),"/Templates/",templateversion,".tex"),encoding = "UTF-8")
translate_labels(Language)

if(has_sb){SB.Values = GetSovBondCoverage()}

i=1



for (i in 4:nrow(report_list)){
  
  investor_name_select <- report_list$investor_name[i]
  portfolio_name_select <- report_list$portfolio_name[i]
  investor_type <- report_list$Type[i]

  print(paste0(i, " of ", nrow(report_list)))
  
  #######################
  ### Read in Results ###
  ########################
  set_initial_variables()
  test_list <- create_test_list()
  
  results_call()
  
  #########################
  ### REPORT GENERATION ###
  #########################
  report_handle <- graph_name("00",ParameterFile)
  create_results_folder(project_name,investor_name_select,portfolio_name_select,report_handle)
  
  ReportFigures()
  
  if(has_sb){
    SovereignBondFigures()    
  }

  # ReportGeneration()
  
  
  
}
  






