library(yaml)
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

#' Load dataset from various sources and cache it locally
#'
#' @param source Name of the dataset (e.g., "challenger.csv", "nyt.yaml", "https://zenodo.org/records/1319069/files/iris.csv")
#' @param verbose Logical indicating whether to print messages
#' @param show_code Logical indicating whether to just show code, 
#' so that the data can be loaded w/o the package
#' @return A data frame containing the dataset
#' @export
#' 
#' @examples
#' df <- load_data("challenger.csv") # Load the Challenger dataset from the package
#' df <- load_data("https://zenodo.org/records/1319069/files/iris.csv") # Load the Iris dataset from Zenodo
#' df <- load_data("nyt.yaml", show_code = TRUE) # Load the NYT dataset with instructions provided yaml file
load_data <- function(source, verbose = FALSE, show_code = FALSE) {

  save_attributes_to_yaml <- function(attributes_list, file_path) {
    write_yaml(attributes_list, file_path)
    if (verbose) message("Attributes saved to ", file_path)
  }
  
  get_data_file_extension <- function(source) {
    if (grepl(".csv$", source)) {
      return("csv")
    } else if (grepl(".csv.gz$", source)) {
      return("csv.gz")
    } else {
      stop(paste0("Invalid Extension in", source))
    }
  }
  
  attributes <- list()
  data_file_extension = NULL
 
  if (grepl("^https?://", source)) { # Source is a URL
    download_url <- source
    name <- basename(source)
  } else if (grepl(".csv$", source) || grepl(".csv.gz$", source)) { # Source is internal CSV file
    download_url <- paste0("https://raw.githubusercontent.com/tensorchiefs/data/main/data/", source)
    name <- source
  } else if (grepl(".yaml$", source)) { # Check if the source is a YAML file
    source_url <- paste0("https://raw.githubusercontent.com/tensorchiefs/data/main/data/", source)
    attributes <- yaml::read_yaml(source_url)
    download_url <- attributes$source
    name <- source #basename(download_url)
  } else {
    stop("Invalid source")
  }
  
  data_file_extension = get_data_file_extension(download_url)
  
  # Remove the file extension from the name
  name <- gsub("\\.csv\\.gz$", "", name)
  name <- gsub("\\.csv$", "", name)
  name <- gsub("\\.yaml$", "", name)
  
  # Cache the file and get the path
  file_path <- cache_file(paste0(name, ".", data_file_extension), download_url, verbose)
  # Load the data into a data frame
  df = read.csv(file_path, stringsAsFactors = FALSE)
  
  # Adding attributes to the data frame
  attr(df, "dataset_name") <- name
  attr(df, "download_url") <- download_url
  
  # Save the attributes to a YAML file
  attributes = c(attributes, list(dataset_name = name, download_url = download_url))
  file_path <- file.path(get_cache_dir(), paste0(name,".yaml"))
  save_attributes_to_yaml(attributes, file_path)
  
  # Show the code if requested, by printing the data frame
  if (show_code) {
    message("# Copy&Paste this code to load the data into R:")
    message("df <- read.csv(\"", download_url, "\", stringsAsFactors = FALSE)")
    message("# Copy&Paste this code to load the data into Python (need pandas as pd)")
    message("df = pd.read_csv(\"", download_url, "\")")
  }
  
  return (df)
}

#' Load the Quarto documentation file from repository and cache it locally
#' 
#' @param name Name of the Quarto file (e.g., "challenger.qmd" or "test.csv.gz")
#' @param verbose Logical indicating whether to print messages
#' @return The path to the cached Quarto file
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










