### Internal Functions (not exposed) #####
execute_quarto_chunk <- function(file, chunk_name) {
  lines <- readLines(file)
  in_chunk <- FALSE
  code_lines <- c()
  for (line in lines) {
    #print(line)
    pattern <- "```\\{r plot_data.*"
    if (grepl(pattern, line)){
      in_chunk <- TRUE
      next
    } 
    if (in_chunk && grepl("```", line, fixed = TRUE)) {
      in_chunk <- FALSE
      break
    }
    if (in_chunk) {
      code_lines <- c(code_lines, line)
    }
  }
  
  if (length(code_lines) > 0) {
    code <- paste(code_lines, collapse = "\n")
    eval(parse(text = code))
  } else {
    message("Chunk not found: ", chunk_name)
  }
}


#' Rendering the information provided in the Quarto document
#' 
#' @param df A data frame containing the dataset
#' @examples
#' df <- load_data("challenger.csv")
#' render_info(df)
# info_data <- function(df) {
#   # Get the name of the dataset from the attribute
#   dataset_name <- attr(df, "dataset_name")
#   quarto_file = load_quarto_file(paste0(dataset_name, ".qmd")) 
#   library(quarto)
#   quarto::(quarto_file)
#   if (file.exists(quarto_file)) {
#     execute_quarto_chunk(quarto_file, "info")
#   } else {
#     stop("Quarto document not found: ", quarto_file)
#   }
# }