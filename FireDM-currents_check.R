library(tidyverse)

fpath <- c("~/nrcan-cfs-fire/FireDMs/")
dm_cat <- read_csv(paste0(fpath,"dm_wildfire_aidb_nir2023.csv"))
dm_fir <- read_csv(paste0(fpath,"FireDM-currents.csv"))[,-1] # Remove index column

# 1. Source names check -----------------------------------------------
# Source name present in dm_cat but not in dm_fire
setdiff(
  unique(dm_cat$Source),
  unique(dm_fir$Source)
)
# In dm_fir but not in dm_cbm
setdiff(
  unique(dm_fir$Source),
  unique(dm_cat$Source)
)
# The 'R' id not capitalize on cat data. Let's fix that.
dm_cat$Source <- gsub("roots", "Roots", dm_cat$Source)
# Only peat differs now which is expected.

# 2. Sink names check -----------------------------------------------------------
setdiff(
  unique(dm_cat$Sink),
  unique(dm_fir$Sink)
)

setdiff(
  unique(dm_fir$Sink),
  unique(dm_cat$Sink)
)

# Several differences on the sink. Let's look at the notes.
dm_fir %>% filter(Sink %in% c("Softwood Merchantable", "Softwood Foliage", "Softwood Other")) %>% select(Sink:Notes) %>% unique() %>% View
dm_fir %>% filter(Sink %in% c("Hardwood Merchantable", "Hardwood Foliage", "Hardwood Other")) %>% select(Sink:Notes) %>% unique() %>% View
dm_fir %>% filter(str_detect(Sink, "Coarse|Fine")) %>% select(Sink:Notes) %>% unique() %>% View
# These are based on data that shows live biomass remains. It changes the previous
# assumption that all biomass is burned. So these need to be included as sink now.

dm_fir %>% filter(str_detect(Sink, "Soil|soil")) %>% select(Sink:Notes) %>% unique() %>% View
# Different terminologies ("DOM" vs "Soil C"), Will temporarely assume differences
# are just inconsistencies while coding.

dm_fir$Sink <- gsub("Above Ground Very Fast soil C", "Aboveground Very Fast DOM", dm_fir$Sink)
dm_fir$Sink <- gsub("Below Ground Very Fast soil C", "Belowground Very Fast DOM", dm_fir$Sink)
dm_fir$Sink <- gsub("Above Ground Fast soil C", "Aboveground Fast DOM", dm_fir$Sink)
dm_fir$Sink <- gsub("Below Ground Fast soil C", "Belowground Fast DOM", dm_fir$Sink)
dm_fir$Sink <- gsub("roots", "Roots", dm_fir$Sink)
dm_fir$Sink <- gsub("Medium Soil C", "Medium DOM", dm_fir$Sink)
dm_fir$Sink <- gsub("Above Ground slow soil C", "Aboveground Slow DOM", dm_fir$Sink)
dm_fir$Sink <- gsub("Below Ground Slow soil C", "Belowground Slow DOM", dm_fir$Sink)
# Great!

# 3. Checking row (Source) sums for each DM -----------------------------------------------

# CUrrent DM
dm_cat_sum <- dm_cat %>% 
  group_by(SPUID, Source) %>% 
  summarise(TotalProportion = sum(Proportion))
dm_cat_sum %>% arrange(TotalProportion)
# Adding up nicely on CAT tables. Problem is with the FIRE tables.

# New DMs
dm_fir_sum <- dm_fir %>% 
  group_by(Ecozone, Source, SeverityClass) %>% 
  summarise(TotalProportion = sum(Value)) 
dm_fir_sum %>% arrange(TotalProportion)
# Some rows are not adding up. Let's flag errors by thresholds.

# 4. Investigating rows not adding up to 1 ---------------------------------------
dm_fir_sum <- dm_fir_sum %>% 
  mutate(
    PropThr = ifelse(TotalProportion >= 0.99990, ">= 0.99990", ifelse(
                     TotalProportion <= 0.99000, "<= 0.99000", "> 0.99 and < 0.9999")),
    PropThr = factor(PropThr, levels = c(">= 0.99990", "> 0.99 and < 0.9999", "<= 0.99000" )),
    SeverityClass = factor(SeverityClass, levels = c("High", "Mod", "Low")))

dm_fir_sum$PropThr %>% table
##2023-03-15 update - no issues, all 897 rows sum to >=0.9999

# 5. Visualizing size of missing proportions -------------------------------------
# Ordering sources by amount of missing proportions - lower to higher.
src_ord <- dm_fir_sum %>% 
  group_by(Source) %>% 
  summarise(AvgTotalProportion = mean(TotalProportion, na.rm = TRUE)) %>% 
  arrange(-AvgTotalProportion) %>% 
  select(Source)

dm_fir_sum$Source <- factor(dm_fir_sum$Source, levels = src_ord$Source)

# Let's visualize those missing proportions now.
# Averaging across severity classes
dm_fir_sum %>% 
  group_by(Ecozone, Source) %>% 
  summarise(AvgTotalProportion = mean(TotalProportion, na.rm = TRUE)) %>% 
  mutate(PropThr = ifelse(AvgTotalProportion >= 0.99990, ">= 0.99990", ifelse(
    AvgTotalProportion <= 0.99000, "<= 0.99000", "> 0.99 and < 0.9999")
  ),
  PropThr = factor(PropThr, levels = c(">= 0.99990", "> 0.99 and < 0.9999", "<= 0.99000" ))
  ) %>% 
  ggplot(aes(reorder(Ecozone, -AvgTotalProportion), 1-AvgTotalProportion, fill = PropThr)) + 
  geom_col(position = "dodge", show.legend = TRUE) +
  geom_hline(yintercept = 0) +
  facet_wrap(Source~., scales = "free_y") +
  scale_fill_manual(values = c("grey70", "grey40", "black")) + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 75, hjust = 1, vjust=1),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        strip.background = element_rect(fill = "grey90")) + 
  labs(y = "Difference to 1",
       x = "Ecozone",
       fill = "Thresholds", title = "Averaged across severity class")

# Details across severity classes
ggplot(filter(dm_fir_sum, !is.na(PropThr), PropThr != ">= 0.99990"),
       aes(reorder(SeverityClass, -TotalProportion), 1-TotalProportion, fill = PropThr)) + 
  geom_col(position = "dodge", show.legend = TRUE) +
  facet_grid(Source~Ecozone,
             scales = "free",
             # nrow = 10,
             labeller = labeller(Source = label_wrap_gen(width = 10))) +
  scale_fill_manual(values = c("grey40", "black")) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.5),
        panel.spacing = unit(0.1, "lines"),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank()) +
  labs(y = "Difference to 1", x = "Severity",
       fill = "Thresholds", title = "Totals for all sources and provinces with errors higher than 0.0001. Note the scales.")
