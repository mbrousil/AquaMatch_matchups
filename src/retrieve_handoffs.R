# Get handoffs from Google Drive (if needed) and bring into environment

in_url <- "https://drive.google.com/file/d/15EgslBH4rKyzE-4LOA__sIU84NepGX5p/view?usp=drive_link"

if (!file.exists(file.path(handoff_download_path, "collated_handoffs.csv"))) {
  
  drive_download(file = in_url, 
                 path = file.path(handoff_download_path, "collated_handoffs.csv"))
  
  handoffs <- read_csv(file.path(handoff_download_path, "collated_handoffs.csv"))
  
} else { 
  
  handoffs <- read_csv(file.path(handoff_download_path, "collated_handoffs.csv"))
  
}
