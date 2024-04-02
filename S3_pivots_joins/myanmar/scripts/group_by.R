## group_by
# difference beween:
#  - summarize
#  - mutate

# group_by and summarize
dat_summarize <- dat %>%
  group_by(pat_id) %>% # grouping data
  summarize(
    visit_tot = n()
  ) %>%
  ungroup

# group_by and mutate
dat_mutate <- dat %>%
  group_by(pat_id) %>% # grouping data
  mutate(
    visit_tot = n()
  ) %>%
  ungroup

# mutate alone
dat_mutate_alone <- dat %>%
  mutate(
    visit_tot = n()
  )

View(
dat_mutate %>%
  filter(pat_id %in% c(20000, 20006)) %>%
  select(pat_id, visit_tot, everything())
)

View(
  dat_mutate_alone %>%
    filter(pat_id %in% c(20000, 20006)) %>%
    select(pat_id, visit_tot, everything())
)



