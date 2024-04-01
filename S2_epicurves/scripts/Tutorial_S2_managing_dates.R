#---------------------------------------------------------------
#---------------------------------------------------------------
# R session - 2 - Managing dates
#---------------------------------------------------------------
#---------------------------------------------------------------

# Install packages
#---------------------------------------------------------------
pacman::p_load(
  here,
  tidyverse,
  scales,
  janitor,
  lubridate,
  aweek,
  tsibble,
  ISOweek,
  flextable,
)

# Explore functions to manage date
#---------------------------------------------------------------

## ymd: create a date from string in the format year, month, and day components
my_date <- lubridate::ymd("2021-12-27")
my_date

## day : to get the day of the month 
lubridate::day(my_date)

## wday : to get the day of the week
 # by default you'll have a number (1 for Sunday, 2 for Monday, etc)
 # if you want the label indicate the parameter: label = T
lubridate::wday(my_date, label = T)

## format(x, format = "") : Date-time Conversion Functions to and from Character
  # x = a date 
  # format = how you want to format the date 
 # see the description in the help here:
 # https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/strptime

## format with "%j" => Day of year as decimal number (001--366).
format(my_date, "%j")
## format with "%U" => Week number, Sunday start
format(my_date, "%U")
## format with "%U" => Week number, Monday start
format(my_date, "%W")

## yearweek: to get the epiweek with year and week
 # by default week start a Monday, it can be changed with the parameter week_start 
tsibble::yearweek(my_date)

## as.Date on a yearweek:  get the date of start of the week
as.Date(tsibble::yearweek(my_date))

## date2week (similar to the function yearweek): to get the epiweek with year and week
 # by default week start a Monday, it can be changed with the parameter week_start 
aweek::date2week(my_date, floor_day =T)

## floor_date : takes a date-time object and rounds it down to the nearest boundary of the specified time unit
 # in our case the unit is week, and the nearest boundary is the start day of the week 
lubridate::floor_date(my_date)

## epiweek: Week number, Sunday start
lubridate::epiweek(my_date)

## isoweek: Week number, Sunday start
lubridate::isoweek(my_date)

# Create a table using all the functions to manage dates
#---------------------- -----------------------------------------

my_table_dates <-
  tibble(
    dates = seq.Date(
      from = as.Date("2023-12-27"),
      to = as.Date("2024-01-11"),
      by = "days")) %>%
  mutate(
    lubridate_day     = lubridate::day(dates),
    lubridate_wday    = lubridate::wday(dates, label = T),
    format_j          = format(dates, "%j"),
    format_U          = format(dates, "%U"),
    format_W          = format(dates, "%W"),
    yearweek          = tsibble::yearweek(dates),
    as.Date_yearweek  = as.Date(tsibble::yearweek(dates)),
    date2week         = aweek::date2week(dates),
    floor_date        = lubridate::floor_date(dates),
    epiweek           = lubridate::epiweek(dates),
    isoweek           = lubridate::isoweek(dates)
    )

View(my_table_dates)

