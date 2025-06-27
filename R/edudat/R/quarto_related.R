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

#' Generate R and Python code showing how to load a dataset, which is needed in quarto documents
#'
#' @param df The edudat dataset, including 'download_url' and 'source' in the attributes
#' @return No return value, called for side effects. Outputs formatted R and Python code for loading the data.
#' @export
#' @examples 
#' 
#' ```{r, echo=FALSE, eval=TRUE, message=FALSE, results='asis'} 
#' library(edudat)
#' df = load_data('abodauer.csv.gz') 
#' attributes = attributes(df)
#' show_loading(attributes(df))
#' ```
show_loading <- function(df, show_python = FALSE) {
  attributes <- attributes(df)
  r_code <-  sprintf("df <- read.csv(\"%s\")", attributes$download_url)
  r_code2 <- sprintf("df <- edudat::load_data(\"%s\")", attributes$source)
  
  if (knitr::is_html_output()) {
    cat(
      "## Copy & Paste this code to load the data into R:\n\n",
      "<pre><code class='language-r'>\n",
      r_code,
      "\n</code></pre>\n\n",
      "## Copy & Paste this code to load the data into Python (need pandas as pd):\n\n",
      "<pre><code class='language-python'>\n",
      py_code,
      "\n</code></pre>\n",
      sep = ""
    )
  } else if (knitr::is_latex_output()) {
    if (show_python) {
      cat(
        "\\begin{framed}\n",
        "Loading: \\newline \n",
        "\\footnotesize\n",  # Make the text smaller
        "Copy and Paste this code to load the data into R:\n\n",
        "\\begin{verbatim}\n",
        r_code,
        "\n\\end{verbatim}\n\n",
        "Using the edudat package (see https://github.com/tensorchiefs/data/):\n\n",
        "\\begin{verbatim}\n",
        r_code2,
        "\n\\end{verbatim}\n\n",
        "Copy and Paste this code to load the data into Python (need pandas as pd):\n\n",
        "\\begin{verbatim}\n",
        py_code,
        "\n\\end{verbatim}\n",
        "\\end{framed}\n",
        sep = ""
      )
    }else {
      cat(
        "\\begin{framed}\n",
        "Loading: \\newline \n",
        "\\footnotesize\n",  # Make the text smaller
        "Copy and Paste this code to load the data into R:\n\n",
        "\\begin{verbatim}\n",
        r_code,
        "\n\\end{verbatim}\n\n",
        "Using the edudat package (see https://github.com/tensorchiefs/data/):\n\n",
        "\\begin{verbatim}\n",
        r_code2,
        "\n\\end{verbatim}\n\n",
        "\\end{framed}\n",
        sep = ""
      )
      }#Phython
    } #Latex
  else {
    cat("Output format not supported.")
  }
}

