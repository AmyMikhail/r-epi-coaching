######################################
# Converting from Islamic calendar
######################################


# Load packages -----------------------------------------------------------

# Load the tidyverse packages:
pacman::p_load(tidyverse)

# Install and load the package that will convert to/from different calendars:
pacman::p_load_gh("cran/ConvCalendar")


# Example data ------------------------------------------------------------

# Create some example data (linelist with hijiri dates):

df <- data.frame(id = c(1,2,3,4,5), 
                 date_hijiri = c(
                   "04/05/1444",
                   "20/02/1445",
                   "15/03/1445",
                   "26/04/1445",
                   "27/07/1445"
                 ))



# Prepare dates for conversion --------------------------------------------

# Dates have to be separated into day, month, year:
df <- df %>% 
  
  # First convert the hijiri dates to r date format with lubridate::dmy
  mutate(date_hijiri = dmy(date_hijiri)) %>% 
  
  # Next use the functions year, month and day to separate the date elements:
  mutate_at(vars(date_hijiri), 
            list(
              year_hijiri = year,      # Add column for hijiri year
              month_hijiri = month,    # Add column for hijiri month
              day_hijiri = day))       # Add column for hijiri day


# Convert dates to gregorian ----------------------------------------------

df <- df %>% 
  
  # Create another new column with the gregorian dates:
  mutate(date_greg = as.Date(
    
    # Now convert the hijiri day, month and year to gregorian:
    ConvCalendar::OtherDate(
      day = day_hijiri,
      month = month_hijiri,
      year = year_hijiri, 
      calendar = "islamic"
    )
  ))


# Combine into function ---------------------------------------------------

hij2greg <- function(hijiri_dates){
  
  # Create data.frame to hold intermediate values:
  df = data.frame(date_hijiri = hijiri_dates) %>% 
    
    # Convert raw dates to R date format with lubridate functions:
    mutate(date_hijiri = dmy(date_hijiri)) %>% 
    
    # Split date into separate year, month and day columns:
    mutate_at(
      
      vars(date_hijiri), 
      list(
        year_hijiri = year,     
        month_hijiri = month,   
        day_hijiri = day)
      
      ) %>%    
    
    # Convert the hijiri day, month and year to gregorian date:
    mutate(date_greg = as.Date(
      
      ConvCalendar::OtherDate(
        
        day = day_hijiri,
        month = month_hijiri,
        year = year_hijiri, 
        calendar = "islamic"
        
      ))) %>% 
    
    # Pull out the converted dates:
    pull(date_greg)
  
  # Return the converted dates:
  return(df)

}

# Now try function on original df raw hijiri dates:
df <- df %>% 
  
  mutate(date_greg = hij2greg(date_hijiri))

