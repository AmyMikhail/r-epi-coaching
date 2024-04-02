pacman::p_load(
  here,        # find your files
  rio,
  readxl,      # read in data
  skimr,
  tidyverse,
  ggrepel,
  scales,
  janitor,     # clean data
  gtsummary,   # tables
  knitr,       # create output docs
  flextable,   # table styling
  lubridate,   # handle dates
  parsedate,   # guessing dates
  tsibble,     # epiweeks
  sitrep,      # MSF field epi functions
)

df <- read.csv("ist_awd 1.csv")

df <- df %>%
  mutate(
    year_month = dmy(paste0("01-", year_month)))

df_long <- df %>%
  select(-month_total) %>%
  pivot_longer(
    cols = c('oca', 'ocb', 'ocp'),
    names_to = "section",
    values_to = "counts")

ggplot() +
  geom_col(data = df_long, aes(x = year_month, y = counts, fill = section), position = "dodge") +
  geom_line(data = df, aes(x = year_month, y = month_total, color = ""), size = 1.5) +
  geom_text(data = df, aes(x = year_month, y = month_total, label = month_total), vjust = -0.5, color = "black", size = 3, position = position_dodge(width = 0.9))+
  labs(
    title = "Number of monthly AWD cases",
    x = "Calendar month",
    y = "Number of cases",
    caption = "Data source: EWARS",
    color = "Monthly Total",
    fill = "Section") +
  theme_classic() +
  theme(legend.position = "bottom")+
  scale_x_date(
    date_breaks = "1 months",
    labels = scales::label_date_short(),
    limits = range(df$year_month))+ 
  scale_color_manual(values = "orange") +
  scale_fill_manual(values = c("darkblue", "red3", "turquoise"))
