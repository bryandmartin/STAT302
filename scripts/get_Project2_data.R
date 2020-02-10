library(tidyverse)
# Data from voteview.com/data
# Read in Member Ideology and Members' Votes data, keep default names

# Member Ideology
idea_116 <- read_csv("../Data/HS116_members.csv") %>%
  filter(chamber == "House") %>%
  mutate(party_code = recode(party_code, 
                             `100` = "D", `200` = "R", `328` = "I")) %>%
  select(icpsr, state_abbrev, party_code, bioname, born)

# Members' Votes
votes_116 <- read_csv("../Data/HS116_votes.csv") %>% 
  filter(chamber == "House") %>%
  mutate(vote = recode(cast_code,
                       `1` = 1, `6` = -1, `7` = 0, `9` = 0)) %>%
  select(icpsr, vote, rollnumber)

# Join and pivot Data
house_116 <- left_join(votes_116, idea_116, 
                          by = "icpsr") %>%
  pivot_wider(id_cols = c(icpsr, state_abbrev, party_code, bioname, born),
              names_from = rollnumber,
              names_prefix = "rc",
              values_from = vote) %>%
  select(-icpsr)

# Member Ideology
idea_116 <- read_csv("../Data/HS116_members.csv") %>%
  filter(chamber == "Senate") %>%
  mutate(party_code = recode(party_code, 
                             `100` = "D", `200` = "R", `328` = "I")) %>%
  select(icpsr, state_abbrev, party_code, bioname, born)

# Members' Votes
votes_116 <- read_csv("../Data/HS116_votes.csv") %>% 
  filter(chamber == "Senate") %>%
  mutate(vote = recode(cast_code,
                       `1` = 1, `6` = -1, `7` = 0, `9` = 0)) %>%
  select(icpsr, vote, rollnumber)

# Join and pivot Data
senate_116 <- left_join(votes_116, idea_116, 
                       by = "icpsr") %>%
  pivot_wider(id_cols = c(icpsr, state_abbrev, party_code, bioname, born),
              names_from = rollnumber,
              names_prefix = "rc",
              values_from = vote) %>%
  select(-icpsr)

# Member Ideology
idea_90 <- read_csv("../Data/HS090_members.csv") %>%
  filter(chamber == "House") %>%
  mutate(party_code = recode(party_code, 
                             `100` = "D", `200` = "R", `328` = "I")) %>%
  select(icpsr, state_abbrev, party_code, bioname, born)

# Members' Votes
votes_90 <- read_csv("../Data/HS090_votes.csv") %>% 
  filter(chamber == "House") %>%
  filter(icpsr != 99903) %>%
  mutate(vote = recode(cast_code,
                       `1` = 1, `2` = 1, `3` = 1,
                       `4` = -1, `5` = -1, `6` = -1,
                       `7` = 0, `8` = 0, `9` = 0)) %>%
  select(icpsr, vote, rollnumber)

# Join and pivot Data
house_90 <- left_join(votes_90, idea_90, 
                         by = "icpsr") %>%
  pivot_wider(id_cols = c(icpsr, state_abbrev, party_code, bioname, born),
              names_from = rollnumber,
              names_prefix = "rc",
              values_from = vote) %>%
  select(-icpsr)

# Member Ideology
idea_90 <- read_csv("../Data/HS090_members.csv") %>%
  filter(chamber == "Senate") %>%
  mutate(party_code = recode(party_code, 
                             `100` = "D", `200` = "R", `328` = "I")) %>%
  select(icpsr, state_abbrev, party_code, bioname, born)

# Members' Votes
votes_90 <- read_csv("../Data/HS090_votes.csv") %>% 
  filter(chamber == "Senate") %>%
  filter(icpsr != 99903) %>%
  mutate(vote = recode(cast_code,
                       `1` = 1, `2` = 1, `3` = 1,
                       `4` = -1, `5` = -1, `6` = -1,
                       `7` = 0, `8` = 0, `9` = 0)) %>%
  select(icpsr, vote, rollnumber)

# Join and pivot Data
senate_90 <- left_join(votes_90, idea_90, 
                      by = "icpsr") %>%
  pivot_wider(id_cols = c(icpsr, state_abbrev, party_code, bioname, born),
              names_from = rollnumber,
              names_prefix = "rc",
              values_from = vote) %>%
  select(-icpsr)


write_csv(house_116, path = "../Data/house_116_raw.csv")
write_csv(house_90, path = "../Data/house_90_raw.csv")
write_csv(senate_116, path = "../Data/senate_116_raw.csv")
write_csv(senate_90, path = "../Data/senate_90_raw.csv")



