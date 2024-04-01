#############################################
# Ebola outbreak case study
# 
#############################################

## Load the dataset 'combined' from the folder 'data\clean\backup' (linelist_combined_20141201.rds)
#---------------------------------------------------------------------
#---------------------------------------------------------------------
combined <- import(here::here("data", "clean", "backup", "linelist_combined_20141201.rds"))

## Making an EPICURVE
#---------------------------------------------------------------------

## simple epidemic curve, default setting
ggplot(                     # open the plot
  data = combined,          # open the database
  mapping = aes(
    x = date_onset          # chose variable(s) to include
  )) +
  geom_histogram()          # choose the geometry histogram

## simple epidemic curve,  binwidth = 1 (each bar = 1 day)
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(binwidth = 1) # specify the bin width

## simple epidemic curve,  binwidth = 7 (each bar = 7 days)
 # but... we don't know when start the bin 
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(binwidth = 7) # specify the bin width


## simple epidemic curve, using parameter breaks to define the break points for the histogram bins

# first date of onset
min(combined$date_onset, na.rm = T)
# last date of onset
max(combined$date_onset, na.rm = T)

# first day of the week of the week of the first date of onset
floor_date(min(combined$date_onset, na.rm = T),
           unit = "week",
           week_start = 1)
# first day of the week of the following week of the last date of onset
ceiling_date(max(combined$date_onset, na.rm = T),
           unit = "week",
           week_start = 1)

# break points for the histogram bin
 # => sequence of dates with first day of the week of all weeks from the week with the first date of onset to the week with the last date of onset  
ebola_weeks <- 
  seq.Date(
    from = floor_date(min(combined$date_onset, na.rm = T),
                      unit = "week",
                      week_start = 1),
    to   = ceiling_date(max(combined$date_onset, na.rm = T),
                        unit = "week",
                        week_start = 1),
    by   = "weeks"
  )

# simple epidemic curve, using parameter breaks to define the break points for the histogram bins 
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(
    breaks = ebola_weeks # specify the break points for the histogram bins
  )

## simple epidemic curve with break points and x-axis with month using scale_x_date
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(
    breaks = ebola_weeks
  ) +
scale_x_date(
    date_breaks = "1 months") # specify the labels on the x axis (date), appears every month

## simple epidemic curve with break points and x-axis with month using scale_x_date
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(
    breaks = ebola_weeks
  ) +
  scale_x_date(
    date_breaks = "1 months",  # specify the labels on the x axis (date): a label every month
    date_labels = "%B")        # specify the format of the labels : Abbreviated month name

## simple epidemic curve with break points and x-axis with month and month using scale_x_date and label_date_short
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(
    breaks = ebola_weeks
  ) +
  scale_x_date(
    date_breaks = "1 months",           # specify the labels on the x axis (date): a label every month
    labels = scales::label_date_short() # automatically constructs a short format string sufficient to uniquely identify labels
  )

## same as previous changing color of lines around bars and color of fill within bars
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(
    breaks = ebola_weeks,
    color = "darkblue",     # color of lines around bars
    fill = "lightblue"      # color of fill within bars
  ) +
  scale_x_date(
    date_breaks = "1 months",
    labels = scales::label_date_short()
  )

## same as previous adding labels for titles

# sets the labels using labs()

ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(
    breaks = ebola_weeks,
    color = "darkblue",     # color of lines around bars
    fill = "lightblue"      # color of fill within bars
  ) +
  scale_x_date(
    date_breaks = "1 months",
    labels = scales::label_date_short()
    ) +
  labs(x = "Date",                                                  # title of x-axis
       y = "Cases (n)",                                             # title of y-axis
       title = "Cases by week of onset",                            # graphic title
       subtitle = str_glue("Source: MSF data from {Sys.Date()}"))   # graphic sub-title

## same as previous with simplify plot background using theme_bw()
ggplot(
  data = combined,
  mapping = aes(
    x = date_onset
  ))+
  geom_histogram(
    breaks = ebola_weeks,
    color = "darkblue",     # color of lines around bars
    fill = "lightblue"      # color of fill within bars
  ) +
  scale_x_date(
    date_breaks = "2 weeks",
    labels = scales::label_date_short()
  ) +
  theme_bw()+                # simplify plot background
  lab_epi 

