# dat_sel <- dat %>%
#   select(pat_id, redcap_event_name, num_visit) %>%
#   slice_max(tibble(pat_id, num_visit), n = 1)
