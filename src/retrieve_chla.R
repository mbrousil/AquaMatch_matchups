# Adapted from https://portal.edirepository.org/nis/codegenerationdownload?filename=edi.1756.2.r

# Package ID: edi.1756.2 Cataloging System:https://pasta.edirepository.org.
# Data set title: AquaMatch Chlorophyll a Data from Water Quality Portal: ~1970-2024.
# Data set creator:  Matthew Brousil - Colorado State University 
# Data set creator:  Michael Meyer - United States Geological Survey 
# Data set creator:  Katie Willi - Colorado State University 
# Data set creator:  B Steele - Colorado State University 
# Data set creator:  Juan De La Torre - Colorado State University 
# Data set creator:  Matthew Ross - Colorado State University 
# Metadata Provider:  Juan De La Torre - Colorado State University 
# Metadata Provider:  Matthew Brousil - Colorado State University 
# Contact:  Matthew Brousil -  Colorado State University  - matthew.brousil@colostate.edu
# Contact:  Michael Meyer -  United States Geological Survey  - mfmeyer@usgs.gov
# Stylesheet v2.15 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu      

# Check for chla file, if it doesn't exist, load/format/save as feather file for
# future
if (!file.exists(file.path(edi_download_path, "edi_chla.feather"))) {
  
  options(HTTPUserAgent="EDI_CodeGen")
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/1756/2/c97458622bc2126fa6d6c84e183101cf" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl",extra=paste0(' -A "',getOption("HTTPUserAgent"),'"')))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  wqp_chla <-read.csv(infile1,header=F 
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
  
  if (class(wqp_chla$parameter)!="factor") wqp_chla$parameter<- as.factor(wqp_chla$parameter)
  if (class(wqp_chla$OrganizationIdentifier)!="factor") wqp_chla$OrganizationIdentifier<- as.factor(wqp_chla$OrganizationIdentifier)
  if (class(wqp_chla$MonitoringLocationIdentifier)!="factor") wqp_chla$MonitoringLocationIdentifier<- as.factor(wqp_chla$MonitoringLocationIdentifier)
  if (class(wqp_chla$MonitoringLocationTypeName)!="factor") wqp_chla$MonitoringLocationTypeName<- as.factor(wqp_chla$MonitoringLocationTypeName)
  if (class(wqp_chla$ResolvedMonitoringLocationTypeName)!="factor") wqp_chla$ResolvedMonitoringLocationTypeName<- as.factor(wqp_chla$ResolvedMonitoringLocationTypeName)                                   
  # attempting to convert wqp_chla$ActivityStartDate dateTime string to R date structure (date or POSIXct)                                
  tmpDateFormat<-"%Y-%m-%d"
  tmp1ActivityStartDate<-as.Date(wqp_chla$ActivityStartDate,format=tmpDateFormat)
  # Keep the new dates only if they all converted correctly
  if(nrow(wqp_chla[wqp_chla$ActivityStartDate != "",]) == length(tmp1ActivityStartDate[!is.na(tmp1ActivityStartDate)])){wqp_chla$ActivityStartDate <- tmp1ActivityStartDate } else {print("Date conversion failed for wqp_chla$ActivityStartDate. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  if (class(wqp_chla$ActivityStartTime.TimeZoneCode)!="factor") wqp_chla$ActivityStartTime.TimeZoneCode<- as.factor(wqp_chla$ActivityStartTime.TimeZoneCode)
  if (class(wqp_chla$harmonized_tz)!="factor") wqp_chla$harmonized_tz<- as.factor(wqp_chla$harmonized_tz)                                   
  # # attempting to convert wqp_chla$harmonized_local_time dateTime string to R date structure (date or POSIXct)                                
  # tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
  # tmp1harmonized_local_time<-as.POSIXct(wqp_chla$harmonized_local_time,format=tmpDateFormat)
  # # Keep the new dates only if they all converted correctly
  # if(nrow(wqp_chla[wqp_chla$harmonized_local_time != "",]) == length(tmp1harmonized_local_time[!is.na(tmp1harmonized_local_time)])){wqp_chla$harmonized_local_time <- tmp1harmonized_local_time } else {print("Date conversion failed for wqp_chla$harmonized_local_time. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  # attempting to convert wqp_chla$harmonized_utc dateTime string to R date structure (date or POSIXct)                                
  tmpDateFormat<-"%Y-%m-%dT%H:%M:%S"
  tmp1harmonized_utc<-as.POSIXct(wqp_chla$harmonized_utc,format=tmpDateFormat,tz='UTC')
  # Keep the new dates only if they all converted correctly
  if(nrow(wqp_chla[wqp_chla$harmonized_utc != "",]) == length(tmp1harmonized_utc[!is.na(tmp1harmonized_utc)])){wqp_chla$harmonized_utc <- tmp1harmonized_utc } else {print("Date conversion failed for wqp_chla$harmonized_utc. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  if (class(wqp_chla$ActivityStartDateTime)!="factor") wqp_chla$ActivityStartDateTime<- as.factor(wqp_chla$ActivityStartDateTime)
  if (class(wqp_chla$harmonized_top_depth_value)=="factor") wqp_chla$harmonized_top_depth_value <-as.numeric(levels(wqp_chla$harmonized_top_depth_value))[as.integer(wqp_chla$harmonized_top_depth_value) ]               
  if (class(wqp_chla$harmonized_top_depth_value)=="character") wqp_chla$harmonized_top_depth_value <-as.numeric(wqp_chla$harmonized_top_depth_value)
  if (class(wqp_chla$harmonized_top_depth_unit)!="factor") wqp_chla$harmonized_top_depth_unit<- as.factor(wqp_chla$harmonized_top_depth_unit)
  if (class(wqp_chla$harmonized_bottom_depth_value)=="factor") wqp_chla$harmonized_bottom_depth_value <-as.numeric(levels(wqp_chla$harmonized_bottom_depth_value))[as.integer(wqp_chla$harmonized_bottom_depth_value) ]               
  if (class(wqp_chla$harmonized_bottom_depth_value)=="character") wqp_chla$harmonized_bottom_depth_value <-as.numeric(wqp_chla$harmonized_bottom_depth_value)
  if (class(wqp_chla$harmonized_bottom_depth_unit)!="factor") wqp_chla$harmonized_bottom_depth_unit<- as.factor(wqp_chla$harmonized_bottom_depth_unit)
  if (class(wqp_chla$harmonized_discrete_depth_value)=="factor") wqp_chla$harmonized_discrete_depth_value <-as.numeric(levels(wqp_chla$harmonized_discrete_depth_value))[as.integer(wqp_chla$harmonized_discrete_depth_value) ]               
  if (class(wqp_chla$harmonized_discrete_depth_value)=="character") wqp_chla$harmonized_discrete_depth_value <-as.numeric(wqp_chla$harmonized_discrete_depth_value)
  if (class(wqp_chla$harmonized_discrete_depth_unit)!="factor") wqp_chla$harmonized_discrete_depth_unit<- as.factor(wqp_chla$harmonized_discrete_depth_unit)
  if (class(wqp_chla$depth_flag)!="factor") wqp_chla$depth_flag<- as.factor(wqp_chla$depth_flag)
  if (class(wqp_chla$mdl_flag)!="factor") wqp_chla$mdl_flag<- as.factor(wqp_chla$mdl_flag)
  if (class(wqp_chla$approx_flag)!="factor") wqp_chla$approx_flag<- as.factor(wqp_chla$approx_flag)
  if (class(wqp_chla$greater_flag)!="factor") wqp_chla$greater_flag<- as.factor(wqp_chla$greater_flag)
  if (class(wqp_chla$tier)!="factor") wqp_chla$tier<- as.factor(wqp_chla$tier)
  if (class(wqp_chla$field_flag)!="factor") wqp_chla$field_flag<- as.factor(wqp_chla$field_flag)
  if (class(wqp_chla$misc_flag)!="factor") wqp_chla$misc_flag<- as.factor(wqp_chla$misc_flag)
  if (class(wqp_chla$subgroup_id)!="factor") wqp_chla$subgroup_id<- as.factor(wqp_chla$subgroup_id)
  if (class(wqp_chla$harmonized_row_count)=="factor") wqp_chla$harmonized_row_count <-as.numeric(levels(wqp_chla$harmonized_row_count))[as.integer(wqp_chla$harmonized_row_count) ]               
  if (class(wqp_chla$harmonized_row_count)=="character") wqp_chla$harmonized_row_count <-as.numeric(wqp_chla$harmonized_row_count)
  if (class(wqp_chla$harmonized_units)!="factor") wqp_chla$harmonized_units<- as.factor(wqp_chla$harmonized_units)
  if (class(wqp_chla$harmonized_value)=="factor") wqp_chla$harmonized_value <-as.numeric(levels(wqp_chla$harmonized_value))[as.integer(wqp_chla$harmonized_value) ]               
  if (class(wqp_chla$harmonized_value)=="character") wqp_chla$harmonized_value <-as.numeric(wqp_chla$harmonized_value)
  if (class(wqp_chla$harmonized_value_cv)=="factor") wqp_chla$harmonized_value_cv <-as.numeric(levels(wqp_chla$harmonized_value_cv))[as.integer(wqp_chla$harmonized_value_cv) ]               
  if (class(wqp_chla$harmonized_value_cv)=="character") wqp_chla$harmonized_value_cv <-as.numeric(wqp_chla$harmonized_value_cv)
  if (class(wqp_chla$lat)=="factor") wqp_chla$lat <-as.numeric(levels(wqp_chla$lat))[as.integer(wqp_chla$lat) ]               
  if (class(wqp_chla$lat)=="character") wqp_chla$lat <-as.numeric(wqp_chla$lat)
  if (class(wqp_chla$lon)=="factor") wqp_chla$lon <-as.numeric(levels(wqp_chla$lon))[as.integer(wqp_chla$lon) ]               
  if (class(wqp_chla$lon)=="character") wqp_chla$lon <-as.numeric(wqp_chla$lon)
  if (class(wqp_chla$datum)!="factor") wqp_chla$datum<- as.factor(wqp_chla$datum)
  
  # Convert Missing Values to NA for non-dates
  
  wqp_chla$ActivityStartTime.TimeZoneCode <- as.factor(ifelse((trimws(as.character(wqp_chla$ActivityStartTime.TimeZoneCode))==trimws("NA")),NA,as.character(wqp_chla$ActivityStartTime.TimeZoneCode)))
  wqp_chla$ActivityStartDateTime <- as.factor(ifelse((trimws(as.character(wqp_chla$ActivityStartDateTime))==trimws("NA")),NA,as.character(wqp_chla$ActivityStartDateTime)))
  wqp_chla$harmonized_top_depth_value <- ifelse((trimws(as.character(wqp_chla$harmonized_top_depth_value))==trimws("NA")),NA,wqp_chla$harmonized_top_depth_value)               
  suppressWarnings(wqp_chla$harmonized_top_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_chla$harmonized_top_depth_value))==as.character(as.numeric("NA"))),NA,wqp_chla$harmonized_top_depth_value))
  wqp_chla$harmonized_bottom_depth_value <- ifelse((trimws(as.character(wqp_chla$harmonized_bottom_depth_value))==trimws("NA")),NA,wqp_chla$harmonized_bottom_depth_value)               
  suppressWarnings(wqp_chla$harmonized_bottom_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_chla$harmonized_bottom_depth_value))==as.character(as.numeric("NA"))),NA,wqp_chla$harmonized_bottom_depth_value))
  wqp_chla$harmonized_discrete_depth_value <- ifelse((trimws(as.character(wqp_chla$harmonized_discrete_depth_value))==trimws("NA")),NA,wqp_chla$harmonized_discrete_depth_value)               
  suppressWarnings(wqp_chla$harmonized_discrete_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_chla$harmonized_discrete_depth_value))==as.character(as.numeric("NA"))),NA,wqp_chla$harmonized_discrete_depth_value))
  wqp_chla$misc_flag <- as.factor(ifelse((trimws(as.character(wqp_chla$misc_flag))==trimws("NA")),NA,as.character(wqp_chla$misc_flag)))
  wqp_chla$harmonized_value_cv <- ifelse((trimws(as.character(wqp_chla$harmonized_value_cv))==trimws("NA")),NA,wqp_chla$harmonized_value_cv)               
  suppressWarnings(wqp_chla$harmonized_value_cv <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_chla$harmonized_value_cv))==as.character(as.numeric("NA"))),NA,wqp_chla$harmonized_value_cv))
  
  # Save the file for future runs
  write_feather(wqp_chla, file.path(edi_download_path, "edi_chla.feather"))
  return(wqp_chla)
  
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
  
  wqp_chla <- read_feather(file.path(edi_download_path, "edi_chla.feather"))
  return(wqp_chla)
  
}