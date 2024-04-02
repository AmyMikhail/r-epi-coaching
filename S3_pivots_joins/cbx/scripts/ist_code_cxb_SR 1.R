# Assuming your data is stored in a data frame named 'ist_awd'

#LOAD IN DATASETS FOR EACH DISEASE TYPE (Note: must be cleaned using the cleaning scripts) - ideally all on the same day:


## Install required packages for this template

required_packages <- c("ggplot2",    # Graphing functions
                       "tsibble",
                       "rio",        # read in Excel files
                       "remotes",
                       "tidyr",
                       "readxl")     # read data from different excel sheet

library(ggplot2)
library(tidyr)
library(readxl)

# data import -------------------------------------------------------------

read_excel("C:/Users/cxb-epidem2/OneDrive - MSF/01 CXB Coordination/08_Epidemiology/cox_bazar/6_sitrep/2024/intersectional epi sitrep/ist_epi/ist_cox_bazar/ist_awd_2.xls")


# Fig: 1 ------------------------------------------------------------------

# Specify the file path and sheet name
file_path <- "ist_cox_bazar/ist_awd_2.xls"
sheet_name <- "ist_awd_1"

data <- read_excel("ist_cox_bazar/ist_awd_2.xls", sheet = "ist_awd_1")

# check column names and the structure of the data
head(data)   

# check column names
colnames(data)

# Convert year_month column to a Date type
data$year_month <- as.Date(paste0("01-", data$year_month), format = "%d-%b-%y")


# Create a ggplot with clustered columns and a line graph
ggplot(data, aes(x = year_month)) +
  geom_col(aes(y = oca, fill = "OCA"), position = position_dodge(width = 0.5), width = 5, alpha = 2) +
  geom_col(aes(y = ocb, fill = "OCB"), position = position_dodge(width = 0.5), width = 5, alpha = 3) +
  geom_col(aes(y = ocp, fill = "OCP"), position = position_dodge(width = 0.5), width = 5, alpha = 1) +
  geom_line(aes(y = month_total, group = 1, color = "Total"), size = 1.5) +
  geom_text(aes(y = month_total, label = month_total), vjust = -0.5, size = 3, position = position_dodge(width = 0.9)) +  # Add data labels for the line
  
  
  # Customize labels and theme
  labs(title = "Epidemiological Curve",
       x = "",
       y = "Number of cases",
       caption = "Data source: EWARS",
       fill = "",
       color = "") +
  scale_fill_manual(name = NULL,
                    values = c("OCA" = "darkblue", "OCB" = "red3", "OCP" = "turquoise")) +
  scale_color_manual(values = c("Total" = "orange")) +
  #theme_minimal() +
  theme_classic() +      # to make the borders nicer 
  theme(legend.position = "bottom") +
  #theme(legend.position = c(0.8, 0.8))+  # this is for positioning the legend to the top right corner
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8, face = "bold"))+
  theme(axis.text.y = element_text(face = "bold", size = 8),
        #axis.title.x = element_text(size = 9),
        axis.title.y = element_text(size = 9),
        title = element_text(size = 10)) 

#facet_wrap(~ variable, scales = "free_y", ncol = 1)



# Fig: 2 ------------------------------------------------------------------

# Specify the file path and sheet name
file_path <- "ist_cox_bazar/ist_awd_2.xls"
sheet_name <- "ist_RDT+_cholera"

# import data from other sheet  
data_1 <- read_excel("ist_cox_bazar/ist_awd_2.xls", sheet = "ist_RDT+_cholera")

# check column names and the structure od the data
head(data_1)   

# check column names
colnames(data_1)

# Convert year_month column to a Date type
data_1$year_month <- as.Date(paste0("01-", data_1$year_month), format = "%d-%b-%y")


# Create a ggplot with clustered columns and a line graph
ggplot(data_1, aes(x = year_month)) +
  geom_col(aes(y = oca, fill = "OCA"), position = position_dodge(width = 0.5), width = 5, alpha = 2) +
  geom_col(aes(y = ocb, fill = "OCB"), position = position_dodge(width = 0.5), width = 5, alpha = 3) +
  geom_col(aes(y = ocp, fill = "OCP"), position = position_dodge(width = 0.5), width = 5, alpha = 1) +
  geom_line(aes(y = month_total, group = 1, color = "Total"), size = 1.5) +
  geom_text(aes(y = month_total, label = month_total), vjust = -0.5, size = 3, position = position_dodge(width = 0.9)) +  # Add data labels for the line
  
  
  # Customize labels and theme
  labs(title = "Epidemiological Curve",
       x = "",
       y = "Number of cases",
       caption = "Data source: EWARS",
       fill = "",
       color = "") +
  scale_fill_manual(name = NULL,
                    values = c("OCA" = "darkblue", "OCB" = "red3", "OCP" = "turquoise")) +
  scale_color_manual(values = c("Total" = "orange")) +
  #theme_minimal() +
  theme_classic() +      # to make the borders nicer 
  theme(legend.position = "bottom") +
  #theme(legend.position = c(0.8, 0.8))+  # this is for positioning the legend to the top right corner
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1, size = 8, face = "bold"))+
  theme(axis.text.y = element_text(face = "bold", size = 8),
        #axis.title.x = element_text(size = 9),
        axis.title.y = element_text(size = 9),
        title = element_text(size = 10)) 
#facet_wrap(~ variable, scales = "free_y", ncol = 1)

