##------------------------------------------------
## HEP C database
##------------------------------------------------
##------------------------------------------------
##------------------------------------------------

# load packages -----------------------------------------------------------
if (!require("pacman")) {
  install.packages("pacman") }

pacman::p_load(
  here, 
  rio, 
  janitor,
  gtsummary,
  tidyverse,
  flextable)

# Import data -------------------------------------------------------------
#--------------------------------------------------------------------------
dat <- import(here("MultiCentricCohortHepC_R_session_3.csv"))

# Explore data
str(dat)
names(dat)
View(head(dat))

# Create visit number and last visit number  ------------------------------
#--------------------------------------------------------------------------
dat <- dat %>%
  mutate(
    outc_end        = na_if(outc_end, ""),
    outc_end_reason = na_if(outc_end_reason, "")
    ) %>% 
  group_by(pat_id) %>% # grouping data
  mutate(
    visit_num = 1:n(), # create visit number
    visit_num_last = max(visit_num) # create last visit number
    ) %>%
  ungroup %>% # ungrouping data
  select(pat_id, redcap_event_name, visit_num, visit_num_last, everything())


# database with information at last consultation --------------------------
#--------------------------------------------------------------------------
dat_last_consultation <- dat %>%
  filter(visit_num == visit_num_last) %>% # keep the last visit
  select(pat_id, redcap_event_name, visit_num, visit_num_last, outc_end, outc_end_reason)

## Frequency tables
# outc_end
dat_last_consultation %>%
  tabyl(outc_end) %>%
  qflextable

# outc_end_reason
dat_last_consultation %>%
  tabyl(outc_end_reason) %>%
  qflextable

# outc_end_reason by outc_end
dat_last_consultation %>%
  tabyl(outc_end_reason, outc_end) %>%
  qflextable

# database with information at first consultation -------------------------
#--------------------------------------------------------------------------
dat_first_consultation <- dat %>%
  filter(visit_num == 1) %>% # keep the first visit (enrollment)
  select(pat_id, pat_enrolment_site)

## Frequency tables
# enrolment site
dat_first_consultation %>%
  tabyl(pat_enrolment_site) %>%
  qflextable


# Join database with information at first and last consultation -----------
#--------------------------------------------------------------------------
# using bind_cols
?bind_cols # have a look at the help

dat_last_first_1 <-
  bind_cols(
    dat_last_consultation,
    dat_first_consultation
    )
# warning: you have make sure 1: you have the same number of observation and that the dataset is ordered (sorted) with the same variable(s). This is the case in this example.  

# using left_join
?left_join # have a look at the help
dat_last_first_2 <- left_join(dat_last_consultation, dat_first_consultation, by = "pat_id")

## Frequency tables
# pat_enrolment_site
dat_last_first_2 %>%
  tabyl(pat_enrolment_site) %>%
  qflextable

# pat_enrolment_site by outc_end
dat_last_first_2 %>%
  tabyl(pat_enrolment_site, outc_end) %>%
  qflextable

# pat_enrolment_site by outc_end (gtsummary::tbl_summary)
dat_last_first_2 %>%
  select(pat_enrolment_site, outc_end) %>%
  tbl_summary(
    by = outc_end,
    percent = "row",
    label = list(pat_enrolment_site = "Enrolment site")) %>%
  add_overall() %>%
  modify_header(
    update = list(all_stat_cols() ~ "**{level}**<br>N = {n}",
                  stat_0 ~ "**Overall**<br>N = {N}")) %>%
  bold_labels()

# bind_rows: example ------------------------------------------------------
#--------------------------------------------------------------------------

# create database of consultations for patient 20000 and for patient 20001
dat_20000 <- dat %>% filter(pat_id == 20000)
dat_20001 <- dat %>% filter(pat_id == 20001)

dat_20000_20001 <- bind_rows(
  dat_20000, # database 1
  dat_20001, # database 2
  .id = "df_origin" # the column that identifies each input
)

