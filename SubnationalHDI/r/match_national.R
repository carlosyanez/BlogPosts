hdi_nat <- hdi_nat %>% mutate(shapeGroup=ifelse(shapeGroup=="XKO","XKX",shapeGroup))

processed6 <- hdi_nat %>% left_join((levels %>% select(shapeGroup,level)),by="shapeGroup") %>%
  filter(is.na(level)) %>%
  mutate(region=shapeName,matching_method="national") %>%
  select(source_id,region,shapeGroup,
         hdi,continent,healthindex,incindex,  
         edindex, lifexp, gnic, esch, msch, pop,
         level,matching_method) %>% 
  filter(!(shapeGroup %in% c("TWN","ATA")))
raster::crs(processed6) <- "+proj=lcc +lat_1=48 +lat_2=33 +lon_0=-100 +datum=WGS84"
processed_complete <- rbind(processed_complete,processed6)

processed_complete <- processed_complete %>% mutate(label=paste(shapeGroup," - ", region,": ",hdi),
                                                    id = row_number()) 
raster::crs(processed_complete) <- "+proj=lcc +lat_1=48 +lat_2=33 +lon_0=-100 +datum=WGS84"
