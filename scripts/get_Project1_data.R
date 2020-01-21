# https://fivethirtyeight.com/features/designing-the-best-board-game-on-the-planet/
#devtools::install_github("9thcirclegames/bgg-analysis")

require("bggAnalysis")
require("tidyverse")
require("splitstackshape")
board_games <- BoardGames %>% 
  janitor::clean_names() %>% 
  set_names(~str_replace(.x, "details_", "")) %>% 
  set_names(~str_replace(.x, "attributes_boardgame", "")) %>% 
  set_names(~str_replace(.x, "stats_", "")) %>% 
  select(game_id:average, usersrated, averageweight) %>%
  select(-artist, -description, -image, -thumbnail, -compilation, -designer,
         -expansion, -family, -implementation, -integration, -publisher,
         -attributes_total) %>%
  rename(average_rating = average) %>%
  rename(users_rated = usersrated) %>%
  rename(average_complexity = averageweight)

write_csv(board_games, path = "../Data/board_game_raw.csv")


  # cSplit("category") %>%
  # cSplit("mechanic")

