# Data Repository

Dieses Repository enthält Datensätze sowie R- und Python-Pakete für den Unterricht in Statistik und Data Science.

## Struktur

- `data/`: Enthält die CSV-Daten.
- `R/`: Enthält das R-Package `edudat`.
- `python/`: Enthält das Python-Package `edudat`.

## Installation und Nutzung

### R

1. **Installation des R-Pakets**:
   - Installieren Sie das `devtools`-Paket, falls noch nicht vorhanden:
     ```R
     install.packages("devtools")
     ```

   - Installieren Sie das `edudat`-Paket direkt von GitHub:
     ```R
     devtools::install_github("oduerr/data/R/edudat")
     ```

2. **Verwendung des R-Pakets**:
   - Laden Sie das `edudat`-Paket und die Datensätze:
     ```R
     library(edudat)
     df1 <- load_data("dataset1.csv")
     df2 <- load_data("dataset2.csv")
     ```

### Python

1. **Installation des Python-Pakets**:
   - Installieren Sie das `edudat`-Paket direkt von GitHub:
     ```bash
     pip install git+https://github.com/oduerr/data.git#subdirectory=python/edudat
     ```

2. **Verwendung des Python-Pakets**:
   - Laden Sie die CSV-Daten in Python:
     ```python
     from edudat import load_data

     df1 = load_data("dataset1.csv")
     df2 = load_data("dataset2.csv")
     ```

## Datensätze

Die folgenden Datensätze sind im Repository enthalten:

- `dataset1.csv`: Eine Beschreibung von dataset1.
- `dataset2.csv`: Eine Beschreibung von dataset2.

## Beitrag leisten



## Lizenz

Dieses Projekt ist unter der GPL-3.0-Lizenz lizenziert - siehe die [LICENSE](LICENSE)-Datei für Details.
