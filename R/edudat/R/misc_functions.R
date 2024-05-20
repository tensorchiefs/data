### misc functions ####

#' Open the documentation page for a dataset in the default web browser
#' 
#' @param df A data frame containing the dataset
#' @export
#' @examples
#' df <- load_data("challenger.csv")
#' show_data(df)
show_data = function(df) {
  dataset_name <- attr(df, "dataset_name")
  doc_url <- paste0("https://github.com/tensorchiefs/data/blob/main/docs/", dataset_name, ".md")
  # If using RStudio and prefer to open in the Viewer pane
  #if (rstudioapi::isAvailable()) {
  #  rstudioapi::viewer("https://github.com/tensorchiefs/data/blob/main/docs/challenger.md")
  #} else{
  browseURL(doc_url)
  #}
}

#' Show a mini help page in the RStudio Viewer pane
#' 
#' @export
show_mini_help <- function() {
  # Define the URL and the display text
  html_content <- "
  <html>
  <body>
  
  <h2>edudat package</h2>
  
  <b>Loading the data:</b>
  <pre>
  <code>
  df <- edudat::load_data('challenger.csv')
  plot_data(df)
  </code>
  </pre>
  
  <b>Info:</b>
  <pre>
  <code>
  edudat::list_cache_files()
  </code>
  </pre>
  
  For more see: 
  <a href='https://github.com/tensorchiefs/data/'>github.com/tensorchiefs/data/</a>
  or the 
  <a href='https://github.com/tensorchiefs/data/tree/main/docs'>docs</a> 
 
  
  </body>
  </html>"
  
  # Write the HTML content to a temporary file
  temp_file <- tempfile(fileext = ".html")
  writeLines(html_content, temp_file)
  
  # Open the HTML file in the Viewer pane
  if (rstudioapi::isAvailable()) {
    rstudioapi::viewer(temp_file)
  } else {
    # Alternative code or error handling for non-RStudio environment
    stop("This function requires RStudio to be running")
  }
  
}

