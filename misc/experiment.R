
# For the "easy" GSOC test.

## loading the packages
library("terra")
library("geodata")

??geodata::worldclim_global

## downloading the correct data
dat <- geodata::worldclim_global(var = "bio", res = 10)

saveRDS(dat, "data/worldclim_bio.rds")

dat <- readRDS("data/worldclim_bio.rds")

dat <- terra::unwrap(dat)

p <- plot(dat[[1]])

############# cropping
sa_ext <- ext(-82, -34, -56, 13)
bio1_sa <- crop(dat[[1]], sa_ext)
terra::plot(bio1_sa)

############# masking
sa_ext <- ext(-82, -34, -56, 13)
bio1_sa <- mask(dat[[1]], sa_ext)
terra::plot(bio1_sa)


# extra; just covering with a red box, experimental.
lon <- c(-82, -34, -34, -82, -82)
lat <- c(-56, -56,  13,  13, -56)
x <- cbind(lon, lat)
polygon(x, col=rgb(1, 0, 0,0.5), border='red')


