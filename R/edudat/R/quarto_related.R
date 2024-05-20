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

