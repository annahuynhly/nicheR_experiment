
library("terra")
library("geodata")

??geodata::worldclim_global

dat <- geodata::worldclim_global(var = "bio", res = 10)

saveRDS(dat, "data/worldclim_bio.rds")

dat <- readRDS("data/worldclim_bio.rds")

dat <- terra::unwrap(dat)

p <- plot(dat[[1]])

# masked version
#lat <- c(-56.557, -55.795,-51.779,
#         -24.092, -6.357, 10.857,   12.794, -1.177, -19.114, -49.167,
#         -54.726)
#lon <- c(-69.852, -61.442,  -56.279,
#         -40.239, -32.577,  -60.488,  -75.52, -83.498, -72.822, -77.514,
#         -75.403)
#x <- cbind(lon, lat)

# remove
lon <- c(-82, -34, -34, -82, -82)
lat <- c(-56, -56,  13,  13, -56)
x <- cbind(lon, lat)
polygon(x, col=rgb(1, 0, 0,0.5), border='red')

############# 
sa_ext <- ext(-82, -34, -56, 13)
bio1_sa <- crop(dat[[1]], sa_ext)
terra::plot(bio1_sa)

#############
sa_ext <- ext(-82, -34, -56, 13)
bio1_sa <- mask(dat[[1]], sa_ext)
terra::plot(bio1_sa)




