library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(ncdf4)
library(ncdf4.helpers)
library(PCICt)
for (i in 0:18)
{
climate_filepath <- paste0("C:/Users/A/OneDrive/Desktop/Climate_new/","pr_MNA-44_ICHEC-EC-EARTH_rcp45_r12i1p1_SMHI-RCA4_v1_day_",2006+5*i,"0101-",2010+5*i,"1231",".nc")
climate_output <- nc_open(climate_filepath)
climate_output
rlon <- ncvar_get(climate_output, varid = "rlon")
rlat <- ncvar_get(climate_output, varid = "rlat")

climate_output$dim$time$units
climate_output$dim$time$calendar
pr_time <- nc.get.time.series(climate_output, v = "pr",
                               time.dim.name = "time")
pr_time[c(1:3, length(pr_time) - 2:0)]
pr <- ncvar_get(climate_output, "pr")


pr <- nc.get.var.subset.by.axes(climate_output, "pr",
                                 axis.indices = list(X = 123,
                                                     Y = 87))

matruh <- nc.get.var.subset.by.axes(climate_output, "pr",
                                          axis.indices = list(X = 123,
                                                     Y = 87))

library("writexl")
values = seq(from = as.Date("2006-01-01"), to = as.Date("2010-12-31"), by = 'day')
df <- data.frame(day = c(values), pr = c(matruh[1:1826]))

write_xlsx(df,paste0("C:/Users/A/OneDrive/Desktop/Climate_new/excel/","pr_MNA-44_ICHEC-EC-EARTH_rcp45_r12i1p1_SMHI-RCA4_v1_day_",2006+5*i,"0101-",2010+5*i,"1231",".xlsx"))
}
