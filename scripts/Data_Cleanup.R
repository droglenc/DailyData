library(tidyverse)

tmp <- data.frame(orig=names(readxl::read_excel("data/Tracking Myself Spreadsheet.xlsx",
                                                n_max=1))) |>
  mutate(new=c("Timestamp",
               "training",
               "stress_lvl",
               "stress_src",
               "body_feel",
               "eat_habits",
               "pre_snacks",
               "electrolytes",
               "alcohol",
               "sleep",
               "emotional_reg",
               "pr",
               "have_fun",
               "events",
               "lift",
               "period",
               "focus"))

df <- readxl::read_excel("data/Tracking Myself Spreadsheet.xlsx",
                         skip=1,col_names=tmp$new) |>
  rename(time=Timestamp) |>
  mutate(mon=lubridate::month(time,label=TRUE,abbr=TRUE),
         day=lubridate::day(time),
         yr=lubridate::year(time),
         hr=lubridate::hour(time),
         day=ifelse(hr<5,day-1,day), # adjust for after midnight entries
         date=paste(mon,day,yr,sep="-"),
         date=as.Date(date,format="%b-%d-%Y"),
         workoutday=factor(ifelse(grepl("Rest",training),"No Workout","Workout"),
                           levels=c("No Workout","Workout")),
         compday=factor(ifelse(grepl("Competition",training),"Yes","No"),
                        levels=c("No","Yes")),
         training=factor(training,levels=c("Rest (little/no activity)",
                                           "Rest day (moderate to high activity)",
                                           "Sprints",
                                           "Jumps",
                                           "Competition"),
                         labels=c("Rest (inactive)",
                                  "Rest (active)",
                                  "Sprints",
                                  "Jumps",
                                  "Competition")),
         fsleep=case_when(
           sleep <=6 ~ "\u2264 6 h",
           sleep >=9 ~ "\u2265 9 h",
           TRUE ~ paste(sleep,"h")
         ),
         fsleep=factor(fsleep,levels=c("\u2264 6 h","7 h","8 h","\u2265 9 h")),
         fstress_lvl=factor(stress_lvl,levels=1:5,
                            labels=c("Tears, hanging on",
                                     "Tough, but getting through",
                                     "Tough, but things done",
                                     "Great day, some spots",
                                     "Happy, under control")),
         fstress_lvlZ=factor(stress_lvl,levels=1:5,
                             labels=c("Tough","Tough","Tough",
                                     "Great day, some spots",
                                     "Happy, under control")),
         stress_relationship=ifelse(grepl("Hans",stress_src),"Yes","No"),
         stress_family=ifelse(grepl("Family",stress_src),"Yes","No"),
         stress_friends=ifelse(grepl("Friends",stress_src),"Yes","No"),
         stress_lonely=ifelse(grepl("Lonely",stress_src),"Yes","No"),
         stress_school=ifelse(grepl("School",stress_src),"Yes","No"),
         stress_work=ifelse(grepl("Work",stress_src),"Yes","No"),
         stress_track=ifelse(grepl("Track",stress_src),"Yes","No"),
         stress_tired=ifelse(grepl("Tired",stress_src),"Yes","No"),
         fbody_feel=factor(body_feel,levels=1:5,
                           labels=c("Sick/Injured/Can't",
                                    "Sore, need trainer",
                                    "Fine, getting it done",
                                    "Good, some kinks",
                                    "Amazing, could PR")),
         fbody_feelZ=factor(body_feel,levels=1:5,
                            labels=c("Need trainer or Can't","Need trainer or Can't",
                                     "Fine, getting it done",
                                     "Good, some kinks",
                                     "Amazing, could PR")),
         feat_habits=factor(eat_habits,levels=1:4,
                            labels=c("Not good, not 3 meals",
                                     "Not good, but 3 meals",
                                     "3 meals, but upset",
                                     "3 meals, and balanced")),
         feat_habitsZ=factor(eat_habits,levels=1:4,
                            labels=c("Not good","Not good",
                                     "3 meals, but upset",
                                     "3 meals, and balanced")),
         pre_snacks=factor(pre_snacks,levels=c("No","Only for 1 workout out","Yes"),
                           labels=c("No","Only for 1 workout","Yes")),
         electrolytesb=factor(ifelse(grepl("Yes",electrolytes),"Yes","No"),
                              levels=c("No","Yes")),
         felectrolytes=factor(electrolytes,
                              levels=c("No",
                                       "Yes, during practice",
                                       "Yes, after practice",
                                       "Yes, only after 1 practice out of two"),
                              labels=c("No",
                                       "During practice",
                                       "After practice",
                                       "After 1 of 2 practices")),
         alcoholb=factor(ifelse(grepl("Yes",alcohol),"Alcohol","No Alcohol"),
                         levels=c("No Alcohol","Alcohol")),
         alcohol=factor(alcohol,levels=c("No","Yes (<2)","Yes (>2)")),
         femotional_reg=factor(emotional_reg,levels=1:5,
                               labels=c("Breakdown",
                                        "Some good",
                                        "Some bad",
                                        "Mostly good",
                                        "Flow state")),
         pr=factor(pr,levels=c("No","Season Best","Lifetime PR")),
         have_fun=factor(have_fun,levels=c("No","Sometimes","Yes")),
         lift=factor(lift,levels=c("No","Yes"),labels=c("Did not lift","Lifted")),
         period=factor(period,levels=c("No","Yes"),labels=c("Off","On")),
         focus=factor(focus,levels=1:5,
                      labels=c("Elsewhere",
                               "Trying to visualize",
                               "Some focus",
                               "Mostly focused",
                               "Flow state")),
         ev_triple=ifelse(grepl("Triple",events),"Yes","No"),
         ev_long=ifelse(grepl("Long",events),"Yes","No"),
         ev_mult=ifelse(grepl(",",events),"Yes","No")) |>
  select(date,yr,mon,day,
         workoutday,compday,training,lift,
         fstress_lvl,fstress_lvlZ,starts_with("stress"),
         body_feel,fbody_feel,fbody_feelZ,period,sleep,fsleep,
         eat_habits,feat_habits,feat_habitsZ,pre_snacks,
         felectrolytes,electrolytesb,alcohol,alcoholb,
         events,ev_triple,ev_long,ev_mult,
         pr,emotional_reg,femotional_reg,have_fun,focus)

dfComp <- df |>
  filter(compday=="Yes")

n <- nrow(df)
