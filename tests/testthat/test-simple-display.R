context("Simple display")
require(trelliscope)

vdbPath <- file.path(tempdir(), "vdb")

# divide the ddf by the variable "site"
bySite <- divide(barley, by = "site")

# simple dotplot panel function
pf <- function(x)
   dotplot(variety ~ yield, data = x)

# simple cognostics function
cf <- function(x) {
   list(
      meanYield = cogMean(x$yield, desc = "mean yield"),
      range = cogRange(x$yield, desc = "yield range"),
      min = cog(min(x$yield), desc = "min yield"),
      max = cog(max(x$yield), desc = "min yield")
   )
}

test_that("vdbConn works", {
   vdbConn(vdbPath, autoYes = TRUE)
})

test_that("makeDisplay works", {
   makeDisplay(bySite,
      name = "variety_vs_yield",
      desc = "test display with barley data",
      panelFn = pf, cogFn = cf,
      width = 400, height = 400,
      lims = list(x = "same", y = "free")
   )

   expect_true(file.exists(file.path(vdbPath, "displays", "common", "variety_vs_yield", "displayObj.Rdata")))
})

# view()


