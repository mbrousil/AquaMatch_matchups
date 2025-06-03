# Created by use_targets()

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(crew)

# Set general configuration setting: -----------------------------

general_config <- "default"


# Set up crew controller for multicore processing ------------------------

controller_cores <- crew_controller_local(
  workers = parallel::detectCores()-1,
  seconds_idle = 12
)


# Set target options: ---------------------------------------

tar_option_set(
  # packages that {targets} need to run for this workflow
  packages = c("tidyverse", "sf"),
  memory = "transient",
  garbage_collection = TRUE,
  # set up crew controller
  controller = controller_cores
)


# Define targets workflow -------------------------------------------------

# and load the global functions
tar_source("src/")

# The list of targets/steps
config_targets <- list(
  
  # General config ----------------------------------------------------------
  
  # Grab configuration information for the workflow run (config.yml)
  tar_target(
    name = p0_siteSR_config,
    # The config package does not like to be used with library()
    command = config::get(config = general_config),
    cue = tar_cue("always")
  ),
  
  # Check for other pipelines -----------------------------------------------
  
  # Grab location of the local {targets} WQP download pipeline OR error if
  # the location doesn't exist yet
  tar_target(
    name = p0_AquaMatch_harmonize_WQP_directory,
    command = if(dir.exists(p0_siteSR_config$harmonize_repo_directory)) {
      p0_siteSR_config$harmonize_repo_directory
    } else {
      # Throw an error if the pipeline does not exist
      stop("The WQP download pipeline is not at the location specified in the 
           config.yml file. Check the location specified as `harmonize_repo_directory`
           in the config.yml file and rerun the pipeline.")
    },
    cue = tar_cue("always")
  ),
  
  # Grab location of the local {targets} WQP download pipeline OR error if
  # the location doesn't exist yet
  tar_target(
    name = p0_AquaMatch_siteSR_WQP_directory,
    command = if(dir.exists(p0_siteSR_config$siteSR_repo_directory)) {
      p0_siteSR_config$siteSR_repo_directory
    } else {
      # Throw an error if the pipeline does not exist
      stop("The siteSR download pipeline is not at the location specified in the 
           config.yml file. Check the location specified as `siteSR_repo_directory`
           in the config.yml file and rerun the pipeline.")
    },
    cue = tar_cue("always")
  ),
  
  # Check for folder structure ----------------------------------------------
  
  tar_target(
    name = p0_check_dir_structure,
    command = if (!dir.exists("in/")) {dir.create("in/")},
    cue = tar_cue("always")
  ),
  
  # Retrieve Drive IDs from linked repositories -------------------------------
  
  # site locations from siteSR pipeline
  tar_file_read(
    name = a_all_site_locs_Drive_id,
    command = {
      file.path(p0_AquaMatch_siteSR_WQP_directory,
                "a_compile_sites/out/all_site_locations_drive_id.csv")
    },
    cue = tar_cue("always"),
    read = read_csv(file = !!.x)
  ),
  
  # Google Drive IDs of exported files from the download/harmonize pipeline
  
  tar_file_read(
    name = p3_chla_drive_ids,
    command = {
      file.path(p0_AquaMatch_harmonize_WQP_directory,
             "3_harmonize/out/chl_drive_ids.csv") 
    },
    cue = tar_cue("always"),
    read = read_csv(file = !!.x)
  ),
  
  tar_file_read(
    name = p3_sdd_drive_ids,
    command = {
      file.path(p0_AquaMatch_harmonize_WQP_directory,
             "3_harmonize/out/sdd_drive_ids.csv") 
    },
    cue = tar_cue("always"),
    read = read_csv(file = !!.x)
  ),
  
  tar_file_read(
    name = p3_doc_drive_ids,
    command = {
      file.path(p0_AquaMatch_harmonize_WQP_directory,
             "3_harmonize/out/doc_drive_ids.csv") 
    },
    cue = tar_cue("always"),
    read = read_csv(file = !!.x)
  ),
  
  tar_file_read(
    name = p3_tss_drive_ids,
    command = {
      file.path(p0_AquaMatch_harmonize_WQP_directory,
             "3_harmonize/out/tss_drive_ids.csv") 
    },
    cue = tar_cue("always"),
    read = read_csv(file = !!.x)
  ),
  
  # tar_file_read(
  #   name = p3_tc_drive_ids,
  #   command = {
  #     file.path(p0_AquaMatch_harmonize_WQP_directory,
  #            "3_harmonize/out/tc_drive_ids.csv") 
  #   },
  #   cue = tar_cue("always"),
  #   read = read_csv(file = !!.x)
  # ),
  
  # Download files from Google Drive ----------------------------------------
  
  # siteSR site list
  tar_target(
    name = a_all_site_locations,
    command = {
      p0_check_dir_structure
      retrieve_target(target = "a_all_site_locations",
                      id_df = a_all_site_locs_Drive_id,
                      local_folder = "in/",
                      google_email = p0_siteSR_config$google_email,
                      date_stamp = p0_siteSR_config$siteSR_site_version_date)
    },
    cue = tar_cue("always"),
    packages = c("tidyverse", "googledrive")
  ),
  
  # chlorophyll site list
  tar_target(
    name = p3_chla_harmonized_site_info,
    command = {
      p0_check_dir_structure
      retrieve_target(target = "p3_chla_harmonized_site_info",
                      id_df = p3_chla_drive_ids,
                      local_folder = "in/",
                      google_email = p0_siteSR_config$google_email,
                      date_stamp = p0_siteSR_config$chla_version_date) 
    },
    cue = tar_cue("always"),
    packages = c("tidyverse", "googledrive")
  ),
  
  # SDD site list
  tar_target(
    name = p3_sdd_harmonized_site_info,
    command = {
      p0_check_dir_structure
      retrieve_target(target = "p3_sdd_harmonized_site_info",
                      id_df = p3_sdd_drive_ids,
                      local_folder = "in/",
                      google_email = p0_siteSR_config$google_email,
                      date_stamp = p0_siteSR_config$sdd_version_date)
    },
    cue = tar_cue("always"),
    packages = c("tidyverse", "googledrive")
  ),
  
  # DOC site list
  tar_target(
    name = p3_doc_harmonized_site_info,
    command = {
      p0_check_dir_structure
      retrieve_target(target = "p3_doc_harmonized_site_info",
                      id_df = p3_doc_drive_ids,
                      local_folder = "in/",
                      google_email = p0_siteSR_config$google_email,
                      date_stamp = p0_siteSR_config$doc_version_date)
    },
    cue = tar_cue("always"),
    packages = c("tidyverse", "googledrive")
  ),  
  
  # TSS site list
  tar_target(
    name = p3_tss_harmonized_site_info,
    command = {
      p0_check_dir_structure
      retrieve_target(target = "p3_tss_harmonized_site_info",
                      id_df = p3_tss_drive_ids,
                      local_folder = "in/",
                      google_email = p0_siteSR_config$google_email,
                      date_stamp = p0_siteSR_config$tss_version_date)
    },
    cue = tar_cue("always"),
    packages = c("tidyverse", "googledrive")
  )
  
  # # TC site list
  # tar_target(
  #   name = p3_tc_harmonized_site_info,
  #   command = {
  #     p0_check_dir_structure
  #     retrieve_target(target = "p3_tc_harmonized_site_info",
  #                     id_df = p3_tc_drive_ids,
  #                     local_folder = "in/",
  #                     google_email = p0_siteSR_config$google_email,
  #                     date_stamp = p0_siteSR_config$tss_version_date)
  #   },
  #   packages = c("tidyverse", "googledrive")
  # )
  
)

# # Full targets list
# c(config_targets)
