# Added a line (261) to Introduction.Rmd
pkgs_to_install <- readr::read_rds("pkgs_to_install.rds") %>%
  dplyr::pull(package)

remotes::install_github("hadley/emo")
#new_pkgs <- package_vector[!(package_vector %in% installed.packages())]
#install.packages(new_pkgs, repos = "https://cloud.r-project.org")

install.packages(pkgs_to_install[!(pkgs_to_install %in% installed.packages())],
                 repos = "https://cloud.r-project.org")

system("brew cask install inconsolata")
system("brew cask install font-andale-mono")



# Older way. Above is easier
pkgs <- c("bookdown", "lobstr", "sloop", "DBI", "RSQLite", "dbplyr",
          "profvis", "bench")

install.packages(pkgs, repos = "https://cloud.r-project.org")
remotes::install_github("hadley/emo")

###

#install.packages("qdapRegex")
library(purrr)
library(readr)
library(qdapRegex)
library(magrittr)
library(stringr)
rmd_files <- list.files(pattern = ".Rmd", full.names = TRUE)
rmds_input <- map(rmd_files, read_lines)
package_search_results <- map(rmds_input,
                              rm_between,
                              left = c("library(", "require("),
                              right = c(")", ")"),
                              extract = TRUE)
messy_package_vector <- map(package_search_results, unlist) %>%
  unlist()
package_vector <- messy_package_vector %>%
  str_replace_all('\"', "") %>%
  unique() %>%
  sort()
package_vector <- package_vector[
  package_vector != "" & !str_detect(package_vector, "character.only")
  ]

# package_search_results2 <- map(rmds_input, str_match_all, pattern = ".*::.*")
# messy_package_vector2 <- map(package_search_results2, unlist) %>%
#   unlist()
# package_vector2 <- messy_package_vector2 %>%
#   str_replace_all('\"', "") %>%
#   unique() %>%
#   sort()
# package_vector2
#
# get_package_name <- function(string_vector){
#   str_match_all(string_vector, pattern = ".*::") %>%
#     str_replace_all("::", "") %>%
#     str_squish()
# }
#
# new_pkgs2 <- map_chr(package_vector2, get_package_name)

