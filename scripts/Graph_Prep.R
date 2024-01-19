library(patchwork)

## Set color, etc characteristics for points, etc.
clr_pt <- "gray10"
clr_bar <- clr_pt
clr_bkgline <- "gray85"
clr_comp <- "red3"
fill_bar <- "aquamarine2"
fill_wo <- c("No"="white","Yes"="gray50")
fill_tile <- c(low="aquamarine",high="aquamarine4")
lty_comp <- "dashed"
lwd_comp <- 0.5

## Set some constants for axes
brks_date <- "2 weeks"
lbls_date <- "%b-%d"
expy_bar <- expansion(mult=c(0,0.02))
expy_barlbl <- expansion(mult=c(0,0.05))

## Create custom themes for main and tile graphs
theme_journey_main <- theme_bw() +
  theme(
    plot.title=element_text(face="bold",size=rel(1.25)),
    plot.title.position="plot",
    axis.title=element_text(face="bold",size=rel(1.1)),
    panel.grid.major=element_line(color="gray90",linetype="dashed",linewidth=rel(0.25)),
    panel.grid.minor=element_blank(),
    legend.margin=margin(t=1,r=1,b=1,l=1,unit="mm"),
    legend.key.size=unit(2,units="mm"),
    panel.spacing=unit(1,unit="mm"),
    strip.background=element_rect(fill="black",color="black"),
    strip.text=element_text(color="white",face="bold",
                            size=rel(1.5),margin=margin(t=1,b=1,r=1,l=1,unit="mm"))
  )
  
theme_journey_tile <- theme_minimal() +
  theme(
    plot.title=element_text(face="bold",size=rel(1.25)),
    plot.title.position="plot",
    axis.text=element_text(face="bold",size=rel(1)),
    axis.title=element_blank(),
    legend.position="none",
    aspect.ratio=1
  )

theme_set(theme_journey_main)