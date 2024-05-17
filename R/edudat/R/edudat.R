#' Load dataset from GitHub and cache it locally
#'
#' @param name Name of the dataset (e.g., "challenger.csv")
#' @param verbose Logical indicating whether to print messages
#' @return A data frame containing the dataset
#' @export
load_data <- function(name, verbose = FALSE) {
  # Determine the home directory based on the operating system
  if (.Platform$OS.type == "windows") {
    data_dir <- normalizePath(file.path(Sys.getenv("USERPROFILE"), ".edudat_cache"), winslash = "/", mustWork = FALSE)
  } else {
    data_dir <- normalizePath(file.path(Sys.getenv("HOME"), ".edudat_cache"), winslash = "/", mustWork = FALSE)
  }
  
  # Create the directory if it does not exist
  if (!dir.exists(data_dir)) {
    dir.create(data_dir, recursive = TRUE)
  }
  
  file_path <- file.path(data_dir, name)
  if (!file.exists(file_path)) {
    if (verbose) {
      message("Downloading ", name, " from GitHub...")
    }
    download_url <- paste0("https://raw.githubusercontent.com/tensorchiefs/data/main/data/", name)
    download.file(download_url, file_path, mode = "wb")
  } else {
    if (verbose) {
      message("Loading ", name, " from cache...")
    }
  }
  read.csv(file_path, stringsAsFactors = FALSE)
}
