theme_journey_time <- theme_bw() +
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
