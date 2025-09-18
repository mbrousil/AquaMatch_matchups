# Adapted from https://portal.edirepository.org/nis/codegenerationdownload?filename=edi.2048.2.r

# Package ID: edi.2048.2 Cataloging System:https://pasta.edirepository.org.
# Data set title: AquaMatch Total Suspended Solids from Water Quality Portal ~1970-2025.
# Data set creator:  Matthew Brousil - Colorado State University 
# Data set creator:  Michael Meyer - United States Geological Survey 
# Data set creator:  Katie Willi - Colorado State University 
# Data set creator:  B Steele - Colorado State University 
# Data set creator:  John Gardner - The University of North Carolina at Chapel Hill 
# Data set creator:  Matthew Ross - Colorado State University 
# Metadata Provider:  Matthew Brousil - Colorado State University 
# Contact:  Matthew Brousil -  Colorado State University  - matthew.brousil@colostate.edu
# Contact:  Michael Meyer -  United States Geological Survey  - mfmeyer@usgs.gov
# Stylesheet v2.15 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu      

if (!file.exists(file.path(edi_download_path, "edi_tss.feather"))) {
  
  options(HTTPUserAgent="EDI_CodeGen")
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/2048/2/b258b13368563cdc63113e2a972a42db" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl",extra=paste0(' -A "',getOption("HTTPUserAgent"),'"')))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  wqp_tss <-read.csv(infile1,header=F 
                     ,skip=1
                     ,sep=","  
                     ,quot='"' 
                     , col.names=c(
                       "parameter",     
                       "OrganizationIdentifier",     
                       "MonitoringLocationIdentifier",     
                       "MonitoringLocationTypeName",     
                       "ResolvedMonitoringLocationTypeName",     
                       "ActivityStartDate",     
                       "ActivityStartTime.Time",     
                       "ActivityStartTime.TimeZoneCode",     
                       "harmonized_tz",     
                       "harmonized_local_time",     
                       "harmonized_utc",     
                       "ActivityStartDateTime",     
                       "harmonized_top_depth_value",     
                       "harmonized_top_depth_unit",     
                       "harmonized_bottom_depth_value",     
                       "harmonized_bottom_depth_unit",     
                       "harmonized_discrete_depth_value",     
                       "harmonized_discrete_depth_unit",     
                       "depth_flag",     
                       "mdl_flag",     
                       "approx_flag",     
                       "greater_flag",     
                       "tier",     
                       "field_flag",     
                       "misc_flag",     
                       "subgroup_id",     
                       "harmonized_row_count",     
                       "harmonized_units",     
                       "harmonized_value",     
                       "harmonized_value_cv",     
                       "lat",     
                       "lon",     
                       "datum"    ), check.names=TRUE)
  
  unlink(infile1)
  
  # Fix any interval or ratio columns mistakenly read in as nominal and nominal columns read as numeric or dates read as strings
  
  if (class(wqp_tss$parameter)!="factor") wqp_tss$parameter<- as.factor(wqp_tss$parameter)
  if (class(wqp_tss$OrganizationIdentifier)!="factor") wqp_tss$OrganizationIdentifier<- as.factor(wqp_tss$OrganizationIdentifier)
  if (class(wqp_tss$MonitoringLocationIdentifier)!="factor") wqp_tss$MonitoringLocationIdentifier<- as.factor(wqp_tss$MonitoringLocationIdentifier)
  if (class(wqp_tss$MonitoringLocationTypeName)!="factor") wqp_tss$MonitoringLocationTypeName<- as.factor(wqp_tss$MonitoringLocationTypeName)
  if (class(wqp_tss$ResolvedMonitoringLocationTypeName)!="factor") wqp_tss$ResolvedMonitoringLocationTypeName<- as.factor(wqp_tss$ResolvedMonitoringLocationTypeName)                                   
  # attempting to convert wqp_tss$ActivityStartDate dateTime string to R date structure (date or POSIXct)                                
  tmpDateFormat<-"%Y-%m-%d"
  tmp1ActivityStartDate<-as.Date(wqp_tss$ActivityStartDate,format=tmpDateFormat)
  # Keep the new dates only if they all converted correctly
  if(nrow(wqp_tss[wqp_tss$ActivityStartDate != "",]) == length(tmp1ActivityStartDate[!is.na(tmp1ActivityStartDate)])){wqp_tss$ActivityStartDate <- tmp1ActivityStartDate } else {print("Date conversion failed for wqp_tss$ActivityStartDate. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  if (class(wqp_tss$ActivityStartTime.TimeZoneCode)!="factor") wqp_tss$ActivityStartTime.TimeZoneCode<- as.factor(wqp_tss$ActivityStartTime.TimeZoneCode)
  if (class(wqp_tss$harmonized_tz)!="factor") wqp_tss$harmonized_tz<- as.factor(wqp_tss$harmonized_tz)                                   
  # # attempting to convert wqp_tss$harmonized_local_time dateTime string to R date structure (date or POSIXct)                                
  # tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
  # tmp1harmonized_local_time<-as.POSIXct(wqp_tss$harmonized_local_time,format=tmpDateFormat)
  # # Keep the new dates only if they all converted correctly
  # if(nrow(wqp_tss[wqp_tss$harmonized_local_time != "",]) == length(tmp1harmonized_local_time[!is.na(tmp1harmonized_local_time)])){wqp_tss$harmonized_local_time <- tmp1harmonized_local_time } else {print("Date conversion failed for wqp_tss$harmonized_local_time. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  # attempting to convert wqp_tss$harmonized_utc dateTime string to R date structure (date or POSIXct)                                
  tmpDateFormat<-"%Y-%m-%dT%H:%M:%S"
  tmp1harmonized_utc<-as.POSIXct(wqp_tss$harmonized_utc,format=tmpDateFormat,tz='UTC')
  # Keep the new dates only if they all converted correctly
  if(nrow(wqp_tss[wqp_tss$harmonized_utc != "",]) == length(tmp1harmonized_utc[!is.na(tmp1harmonized_utc)])){wqp_tss$harmonized_utc <- tmp1harmonized_utc } else {print("Date conversion failed for wqp_tss$harmonized_utc. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  if (class(wqp_tss$ActivityStartDateTime)!="factor") wqp_tss$ActivityStartDateTime<- as.factor(wqp_tss$ActivityStartDateTime)
  if (class(wqp_tss$harmonized_top_depth_value)=="factor") wqp_tss$harmonized_top_depth_value <-as.numeric(levels(wqp_tss$harmonized_top_depth_value))[as.integer(wqp_tss$harmonized_top_depth_value) ]               
  if (class(wqp_tss$harmonized_top_depth_value)=="character") wqp_tss$harmonized_top_depth_value <-as.numeric(wqp_tss$harmonized_top_depth_value)
  if (class(wqp_tss$harmonized_top_depth_unit)!="factor") wqp_tss$harmonized_top_depth_unit<- as.factor(wqp_tss$harmonized_top_depth_unit)
  if (class(wqp_tss$harmonized_bottom_depth_value)=="factor") wqp_tss$harmonized_bottom_depth_value <-as.numeric(levels(wqp_tss$harmonized_bottom_depth_value))[as.integer(wqp_tss$harmonized_bottom_depth_value) ]               
  if (class(wqp_tss$harmonized_bottom_depth_value)=="character") wqp_tss$harmonized_bottom_depth_value <-as.numeric(wqp_tss$harmonized_bottom_depth_value)
  if (class(wqp_tss$harmonized_bottom_depth_unit)!="factor") wqp_tss$harmonized_bottom_depth_unit<- as.factor(wqp_tss$harmonized_bottom_depth_unit)
  if (class(wqp_tss$harmonized_discrete_depth_value)=="factor") wqp_tss$harmonized_discrete_depth_value <-as.numeric(levels(wqp_tss$harmonized_discrete_depth_value))[as.integer(wqp_tss$harmonized_discrete_depth_value) ]               
  if (class(wqp_tss$harmonized_discrete_depth_value)=="character") wqp_tss$harmonized_discrete_depth_value <-as.numeric(wqp_tss$harmonized_discrete_depth_value)
  if (class(wqp_tss$harmonized_discrete_depth_unit)!="factor") wqp_tss$harmonized_discrete_depth_unit<- as.factor(wqp_tss$harmonized_discrete_depth_unit)
  if (class(wqp_tss$depth_flag)!="factor") wqp_tss$depth_flag<- as.factor(wqp_tss$depth_flag)
  if (class(wqp_tss$mdl_flag)!="factor") wqp_tss$mdl_flag<- as.factor(wqp_tss$mdl_flag)
  if (class(wqp_tss$approx_flag)!="factor") wqp_tss$approx_flag<- as.factor(wqp_tss$approx_flag)
  if (class(wqp_tss$greater_flag)!="factor") wqp_tss$greater_flag<- as.factor(wqp_tss$greater_flag)
  if (class(wqp_tss$tier)!="factor") wqp_tss$tier<- as.factor(wqp_tss$tier)
  if (class(wqp_tss$field_flag)!="factor") wqp_tss$field_flag<- as.factor(wqp_tss$field_flag)
  if (class(wqp_tss$misc_flag)!="factor") wqp_tss$misc_flag<- as.factor(wqp_tss$misc_flag)
  if (class(wqp_tss$subgroup_id)!="factor") wqp_tss$subgroup_id<- as.factor(wqp_tss$subgroup_id)
  if (class(wqp_tss$harmonized_row_count)=="factor") wqp_tss$harmonized_row_count <-as.numeric(levels(wqp_tss$harmonized_row_count))[as.integer(wqp_tss$harmonized_row_count) ]               
  if (class(wqp_tss$harmonized_row_count)=="character") wqp_tss$harmonized_row_count <-as.numeric(wqp_tss$harmonized_row_count)
  if (class(wqp_tss$harmonized_units)!="factor") wqp_tss$harmonized_units<- as.factor(wqp_tss$harmonized_units)
  if (class(wqp_tss$harmonized_value)=="factor") wqp_tss$harmonized_value <-as.numeric(levels(wqp_tss$harmonized_value))[as.integer(wqp_tss$harmonized_value) ]               
  if (class(wqp_tss$harmonized_value)=="character") wqp_tss$harmonized_value <-as.numeric(wqp_tss$harmonized_value)
  if (class(wqp_tss$harmonized_value_cv)=="factor") wqp_tss$harmonized_value_cv <-as.numeric(levels(wqp_tss$harmonized_value_cv))[as.integer(wqp_tss$harmonized_value_cv) ]               
  if (class(wqp_tss$harmonized_value_cv)=="character") wqp_tss$harmonized_value_cv <-as.numeric(wqp_tss$harmonized_value_cv)
  if (class(wqp_tss$lat)=="factor") wqp_tss$lat <-as.numeric(levels(wqp_tss$lat))[as.integer(wqp_tss$lat) ]               
  if (class(wqp_tss$lat)=="character") wqp_tss$lat <-as.numeric(wqp_tss$lat)
  if (class(wqp_tss$lon)=="factor") wqp_tss$lon <-as.numeric(levels(wqp_tss$lon))[as.integer(wqp_tss$lon) ]               
  if (class(wqp_tss$lon)=="character") wqp_tss$lon <-as.numeric(wqp_tss$lon)
  if (class(wqp_tss$datum)!="factor") wqp_tss$datum<- as.factor(wqp_tss$datum)
  
  # Convert Missing Values to NA for non-dates
  
  wqp_tss$ActivityStartTime.TimeZoneCode <- as.factor(ifelse((trimws(as.character(wqp_tss$ActivityStartTime.TimeZoneCode))==trimws("NA")),NA,as.character(wqp_tss$ActivityStartTime.TimeZoneCode)))
  wqp_tss$ActivityStartDateTime <- as.factor(ifelse((trimws(as.character(wqp_tss$ActivityStartDateTime))==trimws("NA")),NA,as.character(wqp_tss$ActivityStartDateTime)))
  wqp_tss$harmonized_top_depth_value <- ifelse((trimws(as.character(wqp_tss$harmonized_top_depth_value))==trimws("NA")),NA,wqp_tss$harmonized_top_depth_value)               
  suppressWarnings(wqp_tss$harmonized_top_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_tss$harmonized_top_depth_value))==as.character(as.numeric("NA"))),NA,wqp_tss$harmonized_top_depth_value))
  wqp_tss$harmonized_top_depth_unit <- as.factor(ifelse((trimws(as.character(wqp_tss$harmonized_top_depth_unit))==trimws("NA")),NA,as.character(wqp_tss$harmonized_top_depth_unit)))
  wqp_tss$harmonized_bottom_depth_value <- ifelse((trimws(as.character(wqp_tss$harmonized_bottom_depth_value))==trimws("NA")),NA,wqp_tss$harmonized_bottom_depth_value)               
  suppressWarnings(wqp_tss$harmonized_bottom_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_tss$harmonized_bottom_depth_value))==as.character(as.numeric("NA"))),NA,wqp_tss$harmonized_bottom_depth_value))
  wqp_tss$harmonized_bottom_depth_unit <- as.factor(ifelse((trimws(as.character(wqp_tss$harmonized_bottom_depth_unit))==trimws("NA")),NA,as.character(wqp_tss$harmonized_bottom_depth_unit)))
  wqp_tss$harmonized_discrete_depth_value <- ifelse((trimws(as.character(wqp_tss$harmonized_discrete_depth_value))==trimws("NA")),NA,wqp_tss$harmonized_discrete_depth_value)               
  suppressWarnings(wqp_tss$harmonized_discrete_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_tss$harmonized_discrete_depth_value))==as.character(as.numeric("NA"))),NA,wqp_tss$harmonized_discrete_depth_value))
  wqp_tss$harmonized_discrete_depth_unit <- as.factor(ifelse((trimws(as.character(wqp_tss$harmonized_discrete_depth_unit))==trimws("NA")),NA,as.character(wqp_tss$harmonized_discrete_depth_unit)))
  wqp_tss$misc_flag <- as.factor(ifelse((trimws(as.character(wqp_tss$misc_flag))==trimws("NA")),NA,as.character(wqp_tss$misc_flag)))
  wqp_tss$harmonized_value_cv <- ifelse((trimws(as.character(wqp_tss$harmonized_value_cv))==trimws("NA")),NA,wqp_tss$harmonized_value_cv)               
  suppressWarnings(wqp_tss$harmonized_value_cv <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_tss$harmonized_value_cv))==as.character(as.numeric("NA"))),NA,wqp_tss$harmonized_value_cv))
  
  # Save the file for future runs
  write_feather(wqp_tss, file.path(edi_download_path, "edi_tss.feather"))
  return(wqp_tss)
  
  # Clean up workspace
  rm(infile1, 
     inUrl1, 
     tmp1ActivityStartDate, 
     # tmp1harmonized_local_time, 
     tmp1harmonized_utc, 
     tmpDateFormat)
  
  gc()
  
  # If the file does exist, just read in
} else { 
  
  wqp_tss <- read_feather(file.path(edi_download_path, "edi_tss.feather"))
  return(wqp_tss)
  
}

