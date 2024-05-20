#' Convert a data frame to a Stan data list
#'
#' This function takes a data frame, looks for a column named 'y', and creates 
#' a data list for Stan. If no column named 'y' is found, it uses the last column 
#' as the response variable and issues a warning. The name for the number of covariates 
#' can be customized.
#'
#' @param df A data frame containing the covariates and response variable.
#' @param covariate_count_name A string specifying the name for the number of covariates (default is "K").
#' @return A list suitable for use with Stan, containing the number of observations (N),
#' the number of covariates, the response variable (y), and the covariates matrix (x).
#' @examples
#' # Create a sample data frame
#' df <- data.frame(
#'   x1 = rnorm(100),
#'   x2 = rnorm(100),
#'   x3 = rnorm(100),
#'   y = rnorm(100)
#' )
#' # Convert the data frame to Stan data list
#' stan_data <- as.stan_data(df)
#' # Convert the data frame to Stan data list with custom covariate count name
#' stan_data <- as.stan_data(df, covariate_count_name = "p")
#' @export
as.stan_data <- function(df, covariate_count_name = "K") {
  # Check if the data frame contains a column named "y"
  if ("y" %in% colnames(df)) {
    response_var <- df$y
    covariates <- df[, setdiff(names(df), "y")]
  } else {
    # Issue a warning if "y" is not found and use the last column as the response variable
    warning("No column named 'y' found. Using the last column as the response variable.")
    response_var <- df[, ncol(df)]
    covariates <- df[, -ncol(df)]
  }
  
  # Convert covariates to a matrix
  covariates_matrix <- as.matrix(covariates)
  
  # Create the data list for Stan
  stan_data <- list(
    N = nrow(df),            # Number of observations
    y = response_var,        # Response variable
    x = covariates_matrix    # Covariates matrix
  )
  
  # Add the number of covariates with the specified name
  stan_data[[covariate_count_name]] <- ncol(covariates_matrix)
  
  return(stan_data)
}
