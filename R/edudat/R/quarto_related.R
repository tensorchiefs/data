#' Generate R and Python code to load a data frame
#'
#' @param df A data frame containing the dataset
#' @return A string containing the R and Python code to load the data
#' @export
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

