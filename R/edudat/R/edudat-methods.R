#' Print method for edudat class
#'
#' @param x An edudat object
#' @export
print.edudat <- function(x, ...) {
  cat("This is an edudat object\n")
  cat("Dataset name: ", attr(x, "dataset_name"), "\n")
  cat("Download URL: ", attr(x, "download_url"), "\n")
  NextMethod("print", x)
}

#' Summary method for edudat class
#'
#' @param object An edudat object
#' @export
summary.edudat <- function(object, ...) {
  cat("Summary for edudat object\n")
  cat("Dataset name: ", attr(object, "dataset_name"), "\n")
  cat("Download URL: ", attr(object, "download_url"), "\n")
  NextMethod("summary", object)
}

#### Maybe Sourcing is Enough ###
#' #' Plot method for edudat class
#' #'
#' #' @param x An edudat object
#' #' @export
#' plot.edudat <- function(df, ..., verbose = FALSE) {
#'   name <- attr(df, "dataset_name")
#'   # Checking if quarto file exists
#'   quarto_file = load_quarto_file(paste0(name, ".qmd"), verbose = verbose)
#'   code = extract_code_from_quarto(file = quarto_file, chunk_name = "extra")
#'   if (!is.null(code)) {
#'     eval(parse(text = code))
#'     #cat(code)
#'     if (exists("plot")) {
#'       plot_result <- plot(df, ...)
#'       return(plot_result)
#'     } else if (verbose) {
#'       message("No plot function found in the Quarto file")
#'     }
#'   } else if (verbose) {
#'     message("No code found in the Quarto file no chunk named 'extra' found.")
#'   }
#'   # Fallback to the standard plot function
#'   if (verbose) message("Using default plot function")
#'   base::plot(df,...)
#' }

#' Source code from a Quarto file
#'
#' This function extracts and evaluates code from a specified chunk in a Quarto file, named 'extra'.
#'
#' @param df An edudat object containing the dataset.
#' @param verbose A logical value indicating whether to print messages.
#' @return A character vector of the names of newly added objects, invisibly if none.
#' @export
#' 
#' @examples
#' df <- load_data("challenger.csv", verbose = TRUE)
#' source_extra_code(df, verbose = TRUE)
#' to_celcius(df$Temp)
source_extra_code <- function(df, verbose = FALSE) {
  name <- attr(df, "dataset_name")
  # Capture existing functions before evaluation
  old_objects <- ls(envir = .GlobalEnv)
  # Checking if quarto file exists
  quarto_file = load_quarto_file(paste0(name, ".qmd"), verbose = verbose)
  if (!is.null(quarto_file)) {
    code <- extract_code_from_quarto(file = quarto_file, chunk_name = "extra", verbose = verbose)
    if (!is.null(code)) {
      eval(parse(text = code), envir = .GlobalEnv)
      
      # Capture new functions after evaluation
      all_objects <- ls(envir = .GlobalEnv)
      added_objects <- setdiff(all_objects, old_objects)
      # Identify the newly added functions
      if (verbose) {
        if (length(added_objects) > 0) {
          message("New Objects added: ", added_objects)
        } else {
          message("No new Objects were loaded.")
        }
      }
      return(added_objects)
    } else if (verbose) {
      message("No code found in the Quarto file, no chunk named 'extra' found.")
    }
  } else if (verbose) {
    message("Quarto file not found: ", paste0(name, ".qmd"))
  }
  return(invisible(NULL))
}


### Internal Functions #####
extract_code_from_quarto <- function(file, chunk_name, verbose=FALSE) {
  lines <- readLines(file)
  in_chunk <- FALSE
  code_lines <- c()
  for (line in lines) {
    #print(line)
    pattern <- paste0("```\\{r ", chunk_name, ".*")
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
    if (verbose) {
      message("Executing chunk: ", chunk_name)
      message("Code: ", code)
    }
    return(code)
  } else {
    message("Chunk not found: ", chunk_name)
    return(NULL)
  }
}
