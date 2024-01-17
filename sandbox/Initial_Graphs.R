



## Stress level
ggplot() +
  geom_line(data=df,mapping=aes(x=date,y=stress_lvl),color="gray85") +
  geom_point(data=df,mapping=aes(x=date,y=stress_lvl,fill=workoutday),
             color="gray10",pch=21) +
  geom_vline(data=dfComp,mapping=aes(xintercept=date),
             color="red",linetype="dotted",linewidth=1) +
  scale_y_continuous(breaks=1:5,
                     labels=stringr::str_wrap(levels(df$fstress_lvl),width=10)) +
  scale_x_date(breaks="2 weeks",date_labels="%b-%d") +
  scale_fill_manual(values=c("No"="white","Yes"="gray50")) +
  labs(title="Stress Level",
       subtitle="Open points are rest days, red lines are competitions") +
  theme_journey +
  theme(axis.title=element_blank(),
        legend.position="none")

stressdays <- sum(!is.na(df$stress_src))

ggplot(data=df,mapping=aes(x=fstress_lvl)) +
  geom_bar(mapping=aes(y=after_stat(count)/sum(after_stat(count))),
           color="gray10",fill="gray80") +
  scale_y_continuous(name=str_glue("Percentage of {n} Days"),
                     expand=expansion(mult=c(0,0.02)),
                     labels=scales::percent_format()) +
  scale_x_discrete(labels=str_wrap(levels(df$fstress_lvl),width=12)) +
  labs(title="Stress Level") +
  theme_journey +
  theme(axis.title.x=element_blank())

dfstress <- df |> 
  summarize(Relationship=sum(stress_relationship=="Yes"),
            Family=sum(stress_family=="Yes"),
            Friends=sum(stress_friends=="Yes"),
            Lonely=sum(stress_lonely=="Yes"),
            School=sum(stress_school=="Yes"),
            Work=sum(stress_work=="Yes"),
            Track=sum(stress_track=="Yes"),
            Tired=sum(stress_tired=="Yes")) |>
  tidyr::pivot_longer(cols=Relationship:Tired,names_to="Source",values_to="Days") |>
  mutate(Perc=Days/stressdays*100)

ggplot(data=dfstress,mapping=aes(x=Source,y=Perc)) +
  geom_bar(stat="identity",color="gray10",fill="gray80") +
  scale_y_continuous(name=str_glue("% of {stressdays} Days with Stress"),
                     expand=expansion(mult=c(0,0.02))) +
  scale_x_discrete(name="Source of Stress",limits=dfstress$Source) +
  theme_journey

