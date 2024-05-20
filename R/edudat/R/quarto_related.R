#' Generate R and Python code to load a data frame
#'
#' @param df A data frame containing the dataset
#' @return A string containing the R and Python code to load the data
#' @examples
#' code_str <- show_code(df)
show_code <- function(df) {
  download_url <- attr(df, "download_url")
  
  code_str <- paste(
    "# Copy&Paste this code to load the data into R:\n",
    "df <- read.csv(\"", download_url, "\", stringsAsFactors = FALSE)\n",
    "# Copy&Paste this code to load the data into Python (need pandas as pd):\n",
    "df = pd.read_csv(\"", download_url, "\")",
    sep = ""
  )
  
  return(code_str)
}




#### Using Functions defined in quarto document ####

#' Plot data using the function defined in the Quarto document
#'
#' @param df A data frame containing the dataset
#' @export
#' @examples
#' df <- load_data("challenger.csv")
#' plot_data(df)
plot_data <- function(df) {
  # Throw unsupported error if the dataset is not from the package
  stop("Unsupported currently needs refactoring")

  
  # Get the name of the dataset from the attribute
  dataset_name <- attr(df, "dataset_name")
  quarto_file = load_quarto_file(paste0(dataset_name, ".qmd")) 
  if (file.exists(quarto_file)) {
    execute_quarto_chunk(quarto_file, "plot_function")
  } else {
    stop("Quarto document not found: ", quarto_file)
  }
}

