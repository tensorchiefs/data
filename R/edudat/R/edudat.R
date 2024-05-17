#' Load dataset from GitHub and cache locally
#'
#' @param name Name of the dataset (e.g., "dataset1.csv")
#' @return A data frame containing the dataset
#' @export
load_data <- function(name) {
  data_dir <- file.path(tempdir(), "edudat_cache")
  if (!dir.exists(data_dir)) {
    dir.create(data_dir)
  }
  
  file_path <- file.path(data_dir, name)
  if (!file.exists(file_path)) {
    download_url <- paste0("https://raw.githubusercontent.com/oduerr/data/main/data/", name)
    download.file(download_url, file_path)
  }
  
  read.csv(file_path, stringsAsFactors = FALSE)
}
