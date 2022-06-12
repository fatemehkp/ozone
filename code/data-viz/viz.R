
cuz <- c("All-Cause", "Cardiovascular", "IHD", "CHF", "CBV", 
         "Respiratory", "COPD", "Pneumonia", "Cancer", "Lung Cancer", 
         "Sepsis", "Type1 Diabetes", "Type2 Diabetes")


ggtheme.single <- theme_bw() + 
  theme(panel.spacing.y = unit(c(0,0.25, 0, 0, 0, 0.25, 0, 0, 0.25, 0, 0.25, 0.25, 0, 0, 0.25, 0, 0, 0.25),'lines'),
        panel.spacing.x = unit(0.25,'lines'),
        panel.border = element_rect(fill = NA, 'lines', color = "gray25"),
        strip.text.x = element_text(size = 14, color = 'black', 
                                    face = 'bold'),
        strip.text.y.left = element_text(size = 14, color = 'black', 
                                         face = 'bold', angle = 0, hjust = 0),
        strip.background = element_rect(fill = "#B9CFED"),
        axis.text.x = element_text(size = 12, color = 'black'),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 14, color = 'black', 
                                   face = 'bold')
  )

ggtheme.single <- theme_bw() + 
  theme(axis.text.x = element_text(size = 12, color = 'black'),
        axis.text.y =  element_text(size = 14, face = 'bold', color = 'black'),
        axis.ticks.y = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 14, color = 'black', 
                                   face = 'bold')
  )

plot.cols <- c("#EB2226","#FF8200","#9D178D","#075AAA","#01742F")

ggplot(data = out.main %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
                  filter(!Cause %in% c("URI","Non-Accidental", "Neurodegeneration", "ARDS")),
                aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
         geom_vline(xintercept = 1, linetype = 2, color = "black") +
         labs(x = "", y = "") +
         geom_segment(aes(x = HR.L, xend = HR.U, y = Value, yend = Value, color = Value),
                      size = 0.75, show.legend = T) + 
         geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
                    size = 3, show.legend = T) + 
         scale_color_manual(values = plot.cols) +
         scale_shape_identity() +
         scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
         facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
         ggtheme.single +
         guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                                     direction = "vertical"))

ggsave(here('output','plot','main - 5.jpeg'), width = 9, height = 12, dpi = 600)


plot.cols <- c("#EB2226")
ggplot(data = out.main %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz &
                  Value == "+ State + SES + PM2.5"),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Cause)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U), color = plot.cols,
                width = 0.2, cex = 1, alpha = 0.75) +
  geom_point(aes(x = HR, y = Cause, shape = sig), 
             size = 4, color = plot.cols, show.legend = F) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  scale_y_discrete(limits=rev) +
  #facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single 

ggsave(here('output','plot','main.jpeg'), width = 9, height = 12, dpi = 600)


ggtheme.single <- theme_bw() + 
  theme(panel.spacing.y = unit(c(0.25, 0, 0, 0, 0.25, 0, 0, 0.25, 0, 0.25, 0.25, 0),'lines'),
        panel.spacing.x = unit(0.25,'lines'),
        panel.border = element_rect(fill = NA, 'lines', color = "gray25"),
        strip.text.x = element_blank(),
        strip.text.y.left = element_text(size = 14, color = 'black', 
                                         face = 'bold', angle = 0, hjust = 0),
        strip.background = element_rect(fill = "#B9CFED"),
        axis.text.x = element_text(size = 12, color = 'black'),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 14, color = 'black', 
                                   face = 'bold')
  )


plot.cols <- c("#EB2226", "#075AAA")
ggplot(data = out.age %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) +
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','age.jpeg'), width = 9, height = 12, dpi = 600)



plot.cols <- c("#EB2226", "#075AAA")
ggplot(data = out.sex %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) +
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','sex.jpeg'), width = 9, height = 12, dpi = 600)


plot.cols <- c("#01742F", "#075AAA", "#EB2226")
ggplot(data = out.urbanicity %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) + 
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','urbanicity.jpeg'), width = 9, height = 12, dpi = 600)




plot.cols <- c("#01742F", "#075AAA", "#EB2226")
ggplot(data = out.sesUrban %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) + 
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.1, 1.2, 1.3, 1.4, 1.5))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','sesUrban.jpeg'), width = 9, height = 12, dpi = 600)

plot.cols <- c("#FF8200", "#075AAA", "#EB2226", "#01742F")
ggplot(data = out.region %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) + 
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.1, 1.2, 1.3, 1.4, 1.5))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','region.jpeg'), width = 9, height = 12, dpi = 600)



plot.cols <- c("#01742F", "#075AAA", "#EB2226")
ggplot(data = out.buffer %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) + 
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','bufferzone.jpeg'), width = 9, height = 12, dpi = 600)




plot.cols <- c("#01742F", "#075AAA", "#EB2226")
ggplot(data = out.ses.exp %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) + 
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.1, 1.2, 1.3, 1.4, 1.5))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','exposure-non-pm-adjusted.jpeg'), width = 9, height = 12, dpi = 600)




plot.cols <- c("#01742F", "#075AAA", "#EB2226")
ggplot(data = out.pm.exp %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(!Cause %in% c("URI","Non-Accidental", "Neurodegeneration", "ARDS")),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_segment(aes(x = HR.L, xend = HR.U, y = Value, yend = Value, color = Value),
               size = 0.75, show.legend = T) + 
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','exposure-pm-adjusted.jpeg'), width = 9, height = 12, dpi = 600)

plot.cols <- c("#EB2226", "#075AAA")
ggplot(data = out.exposure %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16)),
                Value = factor(Value, levels = c("1-hr Max", "8-hr Max", 
                                                 "24-hr Average"))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Subgroup)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) + 
  geom_point(aes(x = HR, y = Subgroup, color = Subgroup, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.1, 1.2, 1.3, 1.4, 1.5))  +
  facet_grid(Cause ~ Value, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','exposure.jpeg'), width = 10, height = 12, dpi = 600)



plot.cols <- c("#EB2226", "#075AAA")
ggplot(data = out.brfss %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16))) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value), 
                width = 0.2, cex = 1, alpha = 0.75) +
  geom_point(aes(x = HR, y = Value, color = Value, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','brfss.jpeg'), width = 9, height = 12, dpi = 600)




ggtheme.single <- theme_bw() + 
  theme(panel.spacing.y = unit(c(0.25, 0, 0, 0, 0.25, 0, 0, 0.25, 0, 0.25, 0.25, 0),'lines'),
        panel.spacing.x = unit(0.25,'lines'),
        panel.border = element_rect(fill = NA, 'lines', color = "gray25"),
        strip.text.x = element_text(size = 14, color = 'black', 
                                         face = 'bold'),
        strip.text.y.left = element_text(size = 14, color = 'black', 
                                         face = 'bold', angle = 0, hjust = 0),
        strip.background = element_rect(fill = "#B9CFED"),
        axis.text.x = element_text(size = 12, color = 'black'),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 14, color = 'black', 
                                   face = 'bold'),
        legend.position = "bottom"
  )

plot.cols <- c("#EB2226", "#075AAA")
plot.labs <- c(" >  75 | Male ","<= 75 | Female")

#labels = c("                          | White", " >  75 | Male      | Hispanic","<= 75 | Female  | Black", "                          | Asian"), 

ggplot(data = out.age %>% 
         add_row(out.sex) %>% 
         mutate(sig = ifelse(HR.U < 1 , 16, #16-prtc
                             ifelse((HR.L<=1 & HR.U>=1), 1, 16)),
                Value.comb = case_when(Value %in% c("Male", ">75") ~ "a",
                                       T ~ "b")) %>% 
         filter(Cause %in% cuz),
       aes(x = HR, xmin = HR.L, xmax = HR.U, y = Value.comb)) +
  geom_vline(xintercept = 1, linetype = 2, color = "black") +
  labs(x = "", y = "") +
  geom_errorbar(aes(xmin = HR.L, xmax = HR.U, color = Value.comb), 
                width = 0.2, cex = 1, alpha = 0.75) +
  geom_point(aes(x = HR, y = Value.comb, color = Value.comb, shape = sig), 
             size = 3, show.legend = T) + 
  scale_color_manual(labels = plot.labs,
                     values = plot.cols) +
  scale_shape_identity() +
  scale_x_continuous(breaks=c(1, 1.05, 1.1, 1.15, 1.2, 1.25))  +
  facet_grid(Cause ~ Subgroup, switch='y', scales='free', shrink=TRUE, space='free') +
  ggtheme.single +
  guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                              direction = "vertical"))

ggsave(here('output','plot','age-sex.jpeg'), width = 9, height = 12, dpi = 600)
