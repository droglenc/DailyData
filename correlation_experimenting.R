xtabs(~fstress_lvl+fsleep1,data=df)

tmp <- df |>
  filter(!is.na(fsleep1)) |>
  group_by(fsleep1,fstress_lvl,.drop=FALSE) |>
  summarize(freq=n()) |>
  mutate(perc=freq/sum(freq)*100) |>
  ungroup()

tmp1 <- tmp |>
  group_by(fsleep1) |>
  summarize(n=sum(freq)) |>
  mutate(lbl=paste0(fsleep1,"\n(n=",n," d)"))

ggplot(data=tmp,mapping=aes(x=fsleep1,y=fstress_lvl,fill=perc)) +
  geom_tile() +  
  scale_fill_gradient2(low="aquamarine",high="aquamarine4") +  
  geom_text(aes(label=paste0(round(perc,0),"%"))) +  
  scale_y_discrete(expand=expansion(mult=0),
                   labels=str_wrap(levels(tmp$fstress_lvl),width=12)) +  
  scale_x_discrete(expand=expansion(mult=0),position="top",
                   labels=tmp1$lbl) +  
  theme_journey_tile +  
  labs(title="Previous Day's Sleep and Stress Level",
       subtitle="% in stress level for each sleep amount")





cor.test(as.numeric(df2$stress_lvl),df2$sleep1,method="kendall",use="pairwise.complete.obs")
cor.test(as.numeric(df2$stress_lvl),df2$sleep2,method="kendall",use="pairwise.complete.obs")

cor.test(df2$sleep,df2$sleep1,method="kendall",use="pairwise.complete.obs")

         