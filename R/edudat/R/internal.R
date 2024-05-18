# Internal function to execute specific code chunks from Quarto documents
execute_quarto_chunk <- function(file, chunk_name) {
  lines <- readLines(file)
  in_chunk <- FALSE
  code_lines <- c()
  
  for (line in lines) {
    if (grepl(paste0("```{r ", chunk_name), line)) {
      in_chunk <- TRUE
      next
    }
    if (in_chunk && grepl("```", line)) {
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
