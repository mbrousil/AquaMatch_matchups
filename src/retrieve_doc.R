# Adapted from https://portal.edirepository.org/nis/codegenerationdownload?filename=edi.1809.1.r

# Package ID: edi.1809.1 Cataloging System:https://pasta.edirepository.org.
# Data set title: AquaMatch Dissolved Organic Carbon Data from Water Quality Portal: ~1970-2024.
# Data set creator:  Matthew Brousil - Colorado State University 
# Data set creator:  Michael Meyer - United States Geological Survey 
# Data set creator:  Katie Willi - Colorado State University 
# Data set creator:  B Steele - Colorado State University 
# Data set creator:  Matthew Ross - Colorado State University 
# Metadata Provider:  Matthew Brousil - Colorado State University 
# Contact:  Matthew Brousil -  Colorado State University  - matthew.brousil@colostate.edu
# Contact:  Michael Meyer -  United States Geological Survey  - mfmeyer@usgs.gov
# Stylesheet v2.15 for metadata conversion into program: John H. Porter, Univ. Virginia, jporter@virginia.edu      

# Check for doc file, if it doesn't exist, load/format/save as feather file for
# future
if (!file.exists(file.path(edi_download_path, "edi_doc.feather"))) {
  
  options(HTTPUserAgent="EDI_CodeGen")
  
  inUrl1  <- "https://pasta.lternet.edu/package/data/eml/edi/1809/1/c50dc72b8ea5cb6605abb613b105429a" 
  infile1 <- tempfile()
  try(download.file(inUrl1,infile1,method="curl",extra=paste0(' -A "',getOption("HTTPUserAgent"),'"')))
  if (is.na(file.size(infile1))) download.file(inUrl1,infile1,method="auto")
  
  wqp_doc <-read.csv(infile1,header=F 
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
  
  if (class(wqp_doc$parameter)!="factor") wqp_doc$parameter<- as.factor(wqp_doc$parameter)
  if (class(wqp_doc$OrganizationIdentifier)!="factor") wqp_doc$OrganizationIdentifier<- as.factor(wqp_doc$OrganizationIdentifier)
  if (class(wqp_doc$MonitoringLocationIdentifier)!="factor") wqp_doc$MonitoringLocationIdentifier<- as.factor(wqp_doc$MonitoringLocationIdentifier)
  if (class(wqp_doc$MonitoringLocationTypeName)!="factor") wqp_doc$MonitoringLocationTypeName<- as.factor(wqp_doc$MonitoringLocationTypeName)
  if (class(wqp_doc$ResolvedMonitoringLocationTypeName)!="factor") wqp_doc$ResolvedMonitoringLocationTypeName<- as.factor(wqp_doc$ResolvedMonitoringLocationTypeName)                                   
  # attempting to convert wqp_doc$ActivityStartDate dateTime string to R date structure (date or POSIXct)                                
  tmpDateFormat<-"%Y-%m-%d"
  tmp1ActivityStartDate<-as.Date(wqp_doc$ActivityStartDate,format=tmpDateFormat)
  # Keep the new dates only if they all converted correctly
  if(nrow(wqp_doc[wqp_doc$ActivityStartDate != "",]) == length(tmp1ActivityStartDate[!is.na(tmp1ActivityStartDate)])){wqp_doc$ActivityStartDate <- tmp1ActivityStartDate } else {print("Date conversion failed for wqp_doc$ActivityStartDate. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  if (class(wqp_doc$ActivityStartTime.TimeZoneCode)!="factor") wqp_doc$ActivityStartTime.TimeZoneCode<- as.factor(wqp_doc$ActivityStartTime.TimeZoneCode)
  if (class(wqp_doc$harmonized_tz)!="factor") wqp_doc$harmonized_tz<- as.factor(wqp_doc$harmonized_tz)                                   
  # attempting to convert wqp_doc$harmonized_local_time dateTime string to R date structure (date or POSIXct)                                
  tmpDateFormat<-"%Y-%m-%d %H:%M:%S" 
  tmp1harmonized_local_time<-as.POSIXct(wqp_doc$harmonized_local_time,format=tmpDateFormat)
  # Keep the new dates only if they all converted correctly
  if(nrow(wqp_doc[wqp_doc$harmonized_local_time != "",]) == length(tmp1harmonized_local_time[!is.na(tmp1harmonized_local_time)])){wqp_doc$harmonized_local_time <- tmp1harmonized_local_time } else {print("Date conversion failed for wqp_doc$harmonized_local_time. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  # attempting to convert wqp_doc$harmonized_utc dateTime string to R date structure (date or POSIXct)                                
  tmpDateFormat<-"%Y-%m-%dT%H:%M:%S"
  tmp1harmonized_utc<-as.POSIXct(wqp_doc$harmonized_utc,format=tmpDateFormat,tz='UTC')
  # Keep the new dates only if they all converted correctly
  if(nrow(wqp_doc[wqp_doc$harmonized_utc != "",]) == length(tmp1harmonized_utc[!is.na(tmp1harmonized_utc)])){wqp_doc$harmonized_utc <- tmp1harmonized_utc } else {print("Date conversion failed for wqp_doc$harmonized_utc. Please inspect the data and do the date conversion yourself.")}                                                                    
  
  if (class(wqp_doc$ActivityStartDateTime)!="factor") wqp_doc$ActivityStartDateTime<- as.factor(wqp_doc$ActivityStartDateTime)
  if (class(wqp_doc$harmonized_top_depth_value)=="factor") wqp_doc$harmonized_top_depth_value <-as.numeric(levels(wqp_doc$harmonized_top_depth_value))[as.integer(wqp_doc$harmonized_top_depth_value) ]               
  if (class(wqp_doc$harmonized_top_depth_value)=="character") wqp_doc$harmonized_top_depth_value <-as.numeric(wqp_doc$harmonized_top_depth_value)
  if (class(wqp_doc$harmonized_top_depth_unit)!="factor") wqp_doc$harmonized_top_depth_unit<- as.factor(wqp_doc$harmonized_top_depth_unit)
  if (class(wqp_doc$harmonized_bottom_depth_value)=="factor") wqp_doc$harmonized_bottom_depth_value <-as.numeric(levels(wqp_doc$harmonized_bottom_depth_value))[as.integer(wqp_doc$harmonized_bottom_depth_value) ]               
  if (class(wqp_doc$harmonized_bottom_depth_value)=="character") wqp_doc$harmonized_bottom_depth_value <-as.numeric(wqp_doc$harmonized_bottom_depth_value)
  if (class(wqp_doc$harmonized_bottom_depth_unit)!="factor") wqp_doc$harmonized_bottom_depth_unit<- as.factor(wqp_doc$harmonized_bottom_depth_unit)
  if (class(wqp_doc$harmonized_discrete_depth_value)=="factor") wqp_doc$harmonized_discrete_depth_value <-as.numeric(levels(wqp_doc$harmonized_discrete_depth_value))[as.integer(wqp_doc$harmonized_discrete_depth_value) ]               
  if (class(wqp_doc$harmonized_discrete_depth_value)=="character") wqp_doc$harmonized_discrete_depth_value <-as.numeric(wqp_doc$harmonized_discrete_depth_value)
  if (class(wqp_doc$harmonized_discrete_depth_unit)!="factor") wqp_doc$harmonized_discrete_depth_unit<- as.factor(wqp_doc$harmonized_discrete_depth_unit)
  if (class(wqp_doc$depth_flag)!="factor") wqp_doc$depth_flag<- as.factor(wqp_doc$depth_flag)
  if (class(wqp_doc$mdl_flag)!="factor") wqp_doc$mdl_flag<- as.factor(wqp_doc$mdl_flag)
  if (class(wqp_doc$approx_flag)!="factor") wqp_doc$approx_flag<- as.factor(wqp_doc$approx_flag)
  if (class(wqp_doc$greater_flag)!="factor") wqp_doc$greater_flag<- as.factor(wqp_doc$greater_flag)
  if (class(wqp_doc$tier)!="factor") wqp_doc$tier<- as.factor(wqp_doc$tier)
  if (class(wqp_doc$field_flag)!="factor") wqp_doc$field_flag<- as.factor(wqp_doc$field_flag)
  if (class(wqp_doc$misc_flag)!="factor") wqp_doc$misc_flag<- as.factor(wqp_doc$misc_flag)
  if (class(wqp_doc$subgroup_id)!="factor") wqp_doc$subgroup_id<- as.factor(wqp_doc$subgroup_id)
  if (class(wqp_doc$harmonized_row_count)=="factor") wqp_doc$harmonized_row_count <-as.numeric(levels(wqp_doc$harmonized_row_count))[as.integer(wqp_doc$harmonized_row_count) ]               
  if (class(wqp_doc$harmonized_row_count)=="character") wqp_doc$harmonized_row_count <-as.numeric(wqp_doc$harmonized_row_count)
  if (class(wqp_doc$harmonized_units)!="factor") wqp_doc$harmonized_units<- as.factor(wqp_doc$harmonized_units)
  if (class(wqp_doc$harmonized_value)=="factor") wqp_doc$harmonized_value <-as.numeric(levels(wqp_doc$harmonized_value))[as.integer(wqp_doc$harmonized_value) ]               
  if (class(wqp_doc$harmonized_value)=="character") wqp_doc$harmonized_value <-as.numeric(wqp_doc$harmonized_value)
  if (class(wqp_doc$harmonized_value_cv)=="factor") wqp_doc$harmonized_value_cv <-as.numeric(levels(wqp_doc$harmonized_value_cv))[as.integer(wqp_doc$harmonized_value_cv) ]               
  if (class(wqp_doc$harmonized_value_cv)=="character") wqp_doc$harmonized_value_cv <-as.numeric(wqp_doc$harmonized_value_cv)
  if (class(wqp_doc$lat)=="factor") wqp_doc$lat <-as.numeric(levels(wqp_doc$lat))[as.integer(wqp_doc$lat) ]               
  if (class(wqp_doc$lat)=="character") wqp_doc$lat <-as.numeric(wqp_doc$lat)
  if (class(wqp_doc$lon)=="factor") wqp_doc$lon <-as.numeric(levels(wqp_doc$lon))[as.integer(wqp_doc$lon) ]               
  if (class(wqp_doc$lon)=="character") wqp_doc$lon <-as.numeric(wqp_doc$lon)
  if (class(wqp_doc$datum)!="factor") wqp_doc$datum<- as.factor(wqp_doc$datum)
  
  # Convert Missing Values to NA for non-dates
  
  wqp_doc$ActivityStartTime.TimeZoneCode <- as.factor(ifelse((trimws(as.character(wqp_doc$ActivityStartTime.TimeZoneCode))==trimws("NA")),NA,as.character(wqp_doc$ActivityStartTime.TimeZoneCode)))
  wqp_doc$ActivityStartDateTime <- as.factor(ifelse((trimws(as.character(wqp_doc$ActivityStartDateTime))==trimws("NA")),NA,as.character(wqp_doc$ActivityStartDateTime)))
  wqp_doc$harmonized_top_depth_value <- ifelse((trimws(as.character(wqp_doc$harmonized_top_depth_value))==trimws("NA")),NA,wqp_doc$harmonized_top_depth_value)               
  suppressWarnings(wqp_doc$harmonized_top_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_doc$harmonized_top_depth_value))==as.character(as.numeric("NA"))),NA,wqp_doc$harmonized_top_depth_value))
  wqp_doc$harmonized_bottom_depth_value <- ifelse((trimws(as.character(wqp_doc$harmonized_bottom_depth_value))==trimws("NA")),NA,wqp_doc$harmonized_bottom_depth_value)               
  suppressWarnings(wqp_doc$harmonized_bottom_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_doc$harmonized_bottom_depth_value))==as.character(as.numeric("NA"))),NA,wqp_doc$harmonized_bottom_depth_value))
  wqp_doc$harmonized_discrete_depth_value <- ifelse((trimws(as.character(wqp_doc$harmonized_discrete_depth_value))==trimws("NA")),NA,wqp_doc$harmonized_discrete_depth_value)               
  suppressWarnings(wqp_doc$harmonized_discrete_depth_value <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_doc$harmonized_discrete_depth_value))==as.character(as.numeric("NA"))),NA,wqp_doc$harmonized_discrete_depth_value))
  wqp_doc$misc_flag <- as.factor(ifelse((trimws(as.character(wqp_doc$misc_flag))==trimws("NA")),NA,as.character(wqp_doc$misc_flag)))
  wqp_doc$harmonized_value_cv <- ifelse((trimws(as.character(wqp_doc$harmonized_value_cv))==trimws("NA")),NA,wqp_doc$harmonized_value_cv)               
  suppressWarnings(wqp_doc$harmonized_value_cv <- ifelse(!is.na(as.numeric("NA")) & (trimws(as.character(wqp_doc$harmonized_value_cv))==as.character(as.numeric("NA"))),NA,wqp_doc$harmonized_value_cv))
  
  # Save the file for future runs
  write_feather(wqp_doc, file.path(edi_download_path, "edi_doc.feather"))
  
  # Clean up workspace
  rm(infile1, 
     inUrl1, 
     tmp1ActivityStartDate, 
     tmp1harmonized_local_time, 
     tmp1harmonized_utc, 
     tmpDateFormat)
  
  gc()
  
  # If the file does exist, just read in
} else { 
  
  wqp_doc <- read_feather(file.path(edi_download_path, "edi_doc.feather"))
  
}


