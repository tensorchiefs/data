# Load the necessary packages
library(quarto)
library(magrittr)
library(yaml)
library(edudat)

# Define the source and destination directories
source_dir <- "data"
destination_dir <- "docs"

# Define the base URL for the GitHub link
base_url <- "https://github.com/tensorchiefs/data/tree/docs/data/"

# Create the destination directory if it does not exist
if (!dir.exists(destination_dir)) {
  dir.create(destination_dir, recursive = TRUE)
}

# Get the current date in a human-readable format
rendered_date <- format(Sys.Date(), "%B %d, %Y")

# List all .qmd files in the source directory
qmd_files <- list.files(source_dir, pattern = "\\.qmd$", full.names = TRUE)

# Function to create custom header
create_custom_header <- function(qmd_basename, attributes) {
  #qmd_basename e.g. "abodauer.qmd"
  load_name <- attributes$source
  link <- paste0(base_url, qmd_basename)
  
  header <- paste0(
    "Rendered from [", qmd_basename, "](", link, ")\n\n",
    "This file can be loaded using edudat with:\n\n",
    "```r\n",
    "df = load_data('", load_name, "')\n",
    "```\n\n"
  )
  return(header)
}

# Function to prepend header to a .qmd file
prepend_header <- function(file, header) {
  content <- readLines(file)
  modified_content <- c(header, content)
  writeLines(modified_content, file)
}

# Function to extract title from YAML front matter
extract_title <- function(file) {
  content <- readLines(file)
  yaml_lines <- content[grepl("^---$", content)][1:2]
  yaml_content <- paste(content[seq(grep("^---$", content)[1] + 1, grep("^---$", content)[2] - 1)], collapse = "\n")
  yaml_parsed <- yaml::yaml.load(yaml_content)
  return(yaml_parsed$title)
}

# Initialize a list to hold information for the Readme.md
readme_content <- list("### Created on ", rendered_date, "\n\n")

# Copy each .qmd file to the destination directory, modify it, and render it
for (qmd_file in qmd_files) {
  #qmd_file <- qmd_files[1]
  # Get the base filename without the path
  qmd_basename <- basename(qmd_file)
  name = gsub("\\.qmd$", "", qmd_basename)
  
  # YAML file path
  attributes <- get_yaml_attributes(name)
  
  # Load the data into a data frame
  #df = load_data(attributes$source)
  
  # Extract the title from the .qmd file
  title <- extract_title(qmd_file)
  
  # Construct the full destination path for the .qmd file
  dest_qmd_file <- file.path(destination_dir, qmd_basename)
  
  # Copy the .qmd file to the destination directory, overwriting if it exists
  file.copy(qmd_file, dest_qmd_file, overwrite = TRUE)
  
  # Create and prepend the custom header to the copied .qmd file
  header_content <- create_custom_header(qmd_basename, attributes)
  prepend_header(dest_qmd_file, header_content)
  
  # Print message indicating which file is being rendered
  cat("Rendering:", qmd_basename, "\n")
  
  # Render the .qmd file in the destination directory to GitHub markdown format
  quarto::quarto_render(input = dest_qmd_file, output_format = "gfm")
  
  # Remove the .qmd file from the destination directory after rendering
  file.remove(dest_qmd_file)
  
  # Create the load command for the readme
  load_command <- paste0("`df = load_data('", gsub("\\.qmd$", ".csv", qmd_basename), "')`")
  
  # Add entry to the Readme.md content with the title and load command on one line
  readme_content <- c(
    readme_content,
    paste0("- [", title, "](./", gsub("\\.qmd$", ".md", qmd_basename), ") - ", load_command, "\n")
  )
}

# Write the Readme.md file
readme_path <- file.path(destination_dir, "Readme.md")
writeLines(unlist(readme_content), readme_path)

cat("Rendering completed. Readme.md file created.\n")
