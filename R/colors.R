#' Complete list of palettes
#'
#' Use \code{\link{water_pal}} to construct palettes of desired length.
#'
#' @export
water_palettes <- list(
  bardo = c("#8eb2de", "#0066a4", "#002151"),
  cwqmc = c("#dbeff9", "#a5daee", "#6ac9e3", "#0fb5d7", "#1a98b6"),
  cwqmcdark = c("#f3f3f4", "#6994a1", "#529eb1", "#137b8b", "#0a7487"),
  tribalbanner = c("#54273b", "#f8e19d", "#e18f43", "#dd6646", "#c71f42", "#1d94aa"),
  tribalheader = c("#632a37", "#e4dfc4", "#21434f", "#8aa6be", "#a0891a", "#88604a"),
  wbregions = c("#f9b5a3", "#f2d6a2", "#8bcfb7", "#aaa0b1", "#c7d6ee", "#ffd65d", "#f89f6d", "#f6a3bf", "#57bed3"),
  datasalmon = c("#1b313c", "#759cc2", "#7f2525", "#b72329", "#e2b29c", "#f3e9d2", "#00332a", "#a3b29d"),
  logogradient = c("#00418B", "#8A4998", "#D7578A", "#FF8070", "#FFBA5D", "#F9F871"),
  drought = c("#ffff00", "#fbd37e", "#ffaa01", "#e60000", "#700100")
)

#' A California Water Boards palette generator
#'
#' These are color palettes based on art and iconography from the California 
#' State Water Resources Control Board. 
#'
#' @param n Number of colors desired. Unfortunately most palettes now only
#'   have 4 or 5 colors. F. Color schemes are derived from the raw_images 
#'   folder in this package, with the help of mycolorpicker and mycolor.space.
#'   If omitted, uses all colours.
#' @param name Name of desired palette. Choices are:
#'   \code{bardo}, \code{cwqmc},  \code{cwqmcdark}, \code{tribalbanner}, 
#'   \code{tribalheader},  \code{wbregions}, \code{datasalmon}, 
#'   \code{logogradient}, \code{drought}
#' @param type Either "continuous" or "discrete". Use continuous if you want
#'   to automatically interpolate between colours.
#'   @importFrom graphics rgb rect par image text
#' @return A vector of colours.
#' @export
#' @keywords colors
#' @examples
#' water_pal("cwqmc")
#' water_pal("tribalbanner")
#' water_pal("wbregions")
#' water_pal("wbregions", 3)
#'
#' # If you need more colours than normally found in a palette, you
#' # can use a continuous palette to interpolate between existing
#' # colours
#' pal <- water_pal(21, name = "bardo", type = "continuous")
#' image(volcano, col = pal)
water_pal <- function(name, n, type = c("discrete", "continuous")) {
  type <- match.arg(type)
  
  pal <- water_palettes[[name]]
  if (is.null(pal))
    stop("Palette not found.")
  
  if (missing(n)) {
    n <- length(pal)
  }
  
  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }
  
  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )
  structure(out, class = "palette", name = name)
}

#' @export
#' @importFrom graphics rect par image text
#' @importFrom grDevices rgb
print.palette <- function(x, ...) {
  n <- length(x)
  old <- par(mar = c(0.5, 0.5, 0.5, 0.5))
  on.exit(par(old))
  
  image(1:n, 1, as.matrix(1:n), col = x,
        ylab = "", xaxt = "n", yaxt = "n", bty = "n")
  
  rect(0, 0.9, n + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text((n + 1) / 2, 1, labels = attr(x, "name"), cex = 1, family = "serif")
}

#' heatmap
#'
#' A heatmap example
