library(tidyverse)
# Data from voteview.com/data

# Member Ideology
idea_116 <- read_csv("../Data/HS116_members.csv") %>%
  filter(chamber %in% c("House", "Senate")) %>%
  mutate(party_code = recode(party_code, 
                             `100` = "D", `200` = "R", `328` = "I")) %>%
  select(congress, chamber, icpsr, state_abbrev, party_code, bioname, born)

# Members' Votes
votes_116 <- read_csv("../Data/HS116_votes.csv") %>% 
  mutate(vote = recode(cast_code,
                       `1` = 1, `6` = -1, `7` = 0, `9` = 0)) %>%
  select(congress, chamber, icpsr, vote, rollnumber)

# Join and pivot Data
congress_116 <- left_join(votes_116, idea_116, 
                          by = c("icpsr", "congress", "chamber")) %>%
  pivot_wider(id_cols = c(congress, icpsr, chamber, state_abbrev,
                          party_code, bioname, born),
              names_from = rollnumber,
              names_prefix = "vote",
              values_from = vote) %>%
  select(-icpsr)

# Member Ideology
idea_90 <- read_csv("../Data/HS090_members.csv") %>%
  filter(chamber %in% c("House", "Senate")) %>%
  mutate(party_code = recode(party_code, 
                             `100` = "D", `200` = "R", `328` = "I")) %>%
  select(congress, chamber, icpsr, state_abbrev, party_code, bioname, born)

# Members' Votes
votes_90 <- read_csv("../Data/HS090_votes.csv") %>% 
  mutate(vote = recode(cast_code,
                       `1` = 1, `2` = 1, `3` = 1,
                       `4` = -1, `5` = -1, `6` = -1,
                       `7` = 0, `8` = 0, `9` = 0)) %>%
  select(congress, chamber, icpsr, vote, rollnumber)

# Join and pivot Data
congress_90 <- left_join(votes_90, idea_90, 
                         by = c("icpsr", "congress", "chamber")) %>%
  pivot_wider(id_cols = c(congress, icpsr, chamber, state_abbrev,
                          party_code, bioname, born),
              names_from = rollnumber,
              names_prefix = "vote",
              values_from = vote) %>%
  select(-icpsr)


write_csv(congress_116, path = "../Data/congress_116_raw.csv")
write_csv(congress_90, path = "../Data/congress_90_raw.csv")



