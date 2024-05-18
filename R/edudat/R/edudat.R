#### Using Functions defined in quarto document ####

#' Plot data using the function defined in the Quarto document
#'
#' @param df A data frame containing the dataset
#' @export
#' @examples
#' df <- load_data("challenger.csv")
#' plot_data(df)
plot_data <- function(df) {
  # Get the name of the dataset from the attribute
  dataset_name <- attr(df, "dataset_name")
  quarto_file = load_quarto_file(paste0(dataset_name, ".qmd")) 
  if (file.exists(quarto_file)) {
    execute_quarto_chunk(quarto_file, "plot_function")
  } else {
    stop("Quarto document not found: ", quarto_file)
  }
}


#### Data Handling ####

#' Get the cache directory based on the operating system
#'
#' @return The path to the cache directory
get_cache_dir <- function() {
  if (.Platform$OS.type == "windows") {
    return(normalizePath(file.path(Sys.getenv("USERPROFILE"), ".edudat_cache"), winslash = "/", mustWork = FALSE))
  } else {
    return(normalizePath(file.path(Sys.getenv("HOME"), ".edudat_cache"), winslash = "/", mustWork = FALSE))
  }
}

#' Cache a file from a URL if it doesn't already exist locally
#'
#' @param name Name of the file (e.g., "challenger.csv")
#' @param url URL from where to download the file
#' @param verbose Logical indicating whether to print messages
#' @return The path to the cached file
#' @export
cache_file <- function(name, url, verbose = FALSE) {
  cache_dir <- get_cache_dir()
  
  # Create the directory if it does not exist
  if (!dir.exists(cache_dir)) {
    dir.create(cache_dir, recursive = TRUE)
  }
  
  file_path <- file.path(cache_dir, name)
  
  if (!file.exists(file_path)) {
    if (verbose) {
      message("Downloading ", name, " from ", url, "...")
    }
    download.file(url, file_path, mode = "wb")
  } else {
    if (verbose) {
      message("Loading ", name, " from cache...")
    }
  }
  
  return(file_path)
}

#' Load dataset from GitHub and cache it locally
#'
#' @param name Name of the dataset (e.g., "challenger.csv")
#' @param verbose Logical indicating whether to print messages
#' @return A data frame containing the dataset
#' @export
load_data <- function(name, verbose = FALSE) {
  # Throw an error if the file name does not end with ".csv"
  if (!grepl(".csv$", name)) {
    stop("Invalid file format. Currently only CSV Files are supported.")
  }
  
  # URL for downloading the dataset
  download_url <- paste0("https://raw.githubusercontent.com/tensorchiefs/data/main/data/", name)
  
  # Cache the file and get the path
  file_path <- cache_file(name, download_url, verbose)
  
  # Load the data into a data frame
  df = read.csv(file_path, stringsAsFactors = FALSE)
  
  # Adding the dataset name as an attribute i.e. strip .csv or .csv.gz
  name = gsub(".csv.gz", "", name)
  name = gsub(".csv", "", name)
  attr(df, "dataset_name") <- name
  
  return (df)
}

#' Load the Quarto documentation file from repository and cache it locally
#' 
#' @param name Name of the Quarto file (e.g., "challenger.qmd")
#' @param verbose Logical indicating whether to print messages
#' @return The path to the cached Quarto file
#' @export
load_quarto_file <- function(name, verbose = FALSE) {
  # Throw an error if the file name does not end with ".qmd"
  if (!grepl(".qmd$", name)) {
    stop("Invalid file format. Currently only Quarto Markdown Files are supported.")
  }
  
  # URL for downloading the Quarto file
  download_url <- paste0("https://raw.githubusercontent.com/tensorchiefs/data/main/data/", name)
  
  # Cache the file and get the path
  file_path <- cache_file(name, download_url, verbose)
  
  return (file_path)
}


#' List all cached files, including their sizes and local locations, and print total data size
#'
#' @return A data frame with details of the cached files
#' @export
list_cache_files <- function() {
  cache_dir <- get_cache_dir()
  
  # List all files in the cache directory
  files <- list.files(cache_dir, full.names = TRUE)
  
  # Get file details
  file_details <- data.frame(
    Name = basename(files),
    Size = file.info(files)$size,
    Path = files,
    stringsAsFactors = FALSE
  )
  
  # Calculate total size of all cached files
  total_size <- sum(file_details$Size)
  
  # Print total size
  message("Total cache size: ", format(total_size, big.mark = ",", scientific = FALSE), " bytes")
  
  return(file_details)
}

