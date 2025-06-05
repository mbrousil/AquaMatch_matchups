
# store google drive ids for download
drive_ids <- read_csv("SDD/in/siteSR_drive_ids.csv")

# check for directory
dump_dir <- "SDD/in/feathers/"

if (!dir.exists(dump_dir)) {
  dir.create(dump_dir)
}

# filter for DSWE1
DSWE1_ids <- drive_ids %>% 
  filter(grepl("_DSWE1_", name))

# download iteratively if file does not exist
walk2(.x = DSWE1_ids$name, 
      .y = DSWE1_ids$id,
      .f = function(.x, .y) {
        if (!file.exists(file.path(dump_dir, .x))) {
          drive_download(file = as_id(.y), 
                         path = file.path(dump_dir, .x))
        }
      })

# jot down file paths, these are pretty big and it's more efficient to load when
# making matches, not to pull all files into workspace
LS4_fp <- file.path(dump_dir, "siteSR_collated_sites_LT04_DSWE1_2025-02-24_export.csv")
LS5_fp <- file.path(dump_dir, "siteSR_collated_sites_LT05_DSWE1_2025-02-24_export.csv")
LS7_fp <- file.path(dump_dir, "siteSR_collated_sites_LE07_DSWE1_2025-02-24_export.csv")
LS8_fp <- file.path(dump_dir, "siteSR_collated_sites_LC09_DSWE1_2025-02-24_export.csv")
LS9_fp <- file.path(dump_dir, "siteSR_collated_sites_LC09_DSWE1_2025-02-24_export.csv")

# grab site ids with datestamp, arrange and grab the top one (most recent according 
# to the date)
site_drive_ids <- read_csv("SDD/in/RS_visible_sites_drive_ids.csv") %>% 
  filter(grepl("\\d{4}", name)) %>% 
  arrange(desc(name)) %>% 
  slice(1)

# check to see if that file has been downloaded, download if not
if (!file.exists(file.path(dump_dir, site_drive_ids$name))) {
  drive_download(file = as_id(site_drive_ids$id), 
                 path = file.path(dump_dir, site_drive_ids$name))
}

# load sites
rs_vis_sites <- read_rds(file.path(dump_dir, (site_drive_ids$name)))

# clean up workspace
rm(drive_ids, DSWE1_ids, site_drive_ids, dump_dir)