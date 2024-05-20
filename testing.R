# Sources all for fast delelopment without building
SOURCE = FALSE
if (SOURCE){
  source("R/edudat/R/edudat.R")
  source("R/edudat/R/df_utils.R")
  source("R/edudat/R/internal.R")
  source("R/edudat/R/misc_functions.R")
  source("R/edudat/R/quarto_related.R")
  source("R/edudat/R/edudat-methods.R")
} else{
  library(edudat)
}


# Load the Challenger dataset from the package
df <- load_data("challenger.csv", verbose = TRUE)
class(df)
attributes(df)
summary(df)
cat(show_code(df))
plot(df) #Using Default plot method
source_extra_code(df, verbose = TRUE)
plot(df) + ggtitle("Challenger dataset")
to_celcius(df$Temp)

# Load the Iris dataset from Zenodo
df <- load_data("https://zenodo.org/records/1319069/files/iris.csv", verbose = TRUE)
attributes(df)
source_extra_code(df, verbose = TRUE) #No extra code


# Load the larger dataset from Zenodo (via YAML file)
df <- load_data("zenodo.5126651.bl.yaml", verbose = TRUE)
attributes(df)

# Load the Abodauern dataset from the package (in csv.gz)
df <- load_data("abodauer.csv.gz", verbose = TRUE)
attributes(df)
print(show_code(df))
