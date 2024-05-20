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

