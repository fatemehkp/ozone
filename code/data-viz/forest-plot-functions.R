### Author: Fatemeh Kazemi - 10-06-2021

# Functions for plotting results of exposure ~ outcome analysis
# Hazard Ratio (HR) and 95% CI (HR.L, HR.U) (HR.Lower and HR.Upper)

library(tidyverse)
library(ggpubr)
library(RColorBrewer)


###############################################################################
##############################  Plot.Single  ##################################
###############################################################################

### Function *** Plot.Single ***
# Function Arguments: 
# dt : dataset that contains the HRs for each exposure and outcome
# ggtheme : customized theme


# Single Group Plot Function - Comp ----------------------------------------------
Plot.Single.lab <- function(dt, ggtheme){
  p <- ggplot(dt, aes(x = HR, xmin = HR.L, xmax = HR.U, y = Index)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "Hazard Ratio (95% CI) \n Solid shapes (point estimates) indicate statistically significant results at the 0.05 level", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Index, yend = Index),
                 color = plot.cols, size = 0.25, show.legend = F) + 
    geom_point(aes(x = HR, y = Index, shape = sig), 
               color = plot.cols, size = 1.5, show.legend = F) +
    scale_shape_identity() +
    scale_y_discrete(labels = Index.labels) +
    facet_wrap( ~ Cause, ncol = 5, scales = "fixed") +
    ggtheme
  return(p)
}





# Single Group Plot Function - Factor -------------------------------------
Plot.Single <- function(dt, ggtheme){
  p <- ggplot(dt, aes(x = HR, xmin = HR.L, xmax = HR.U, y = Index)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "Hazard Ratio (95% CI) \n Solid shapes (point estimates) indicate statistically significant results at the 0.05 level", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Index, yend = Index),
                 color = plot.cols, size = 0.25, show.legend = F) + 
    geom_point(aes(x = HR, y = Index, shape = sig), 
               color = plot.cols, size = 1.5, show.legend = F) +
    scale_shape_identity() +
    facet_wrap( ~ Cause, ncol = 5, scales = "fixed") +
    ggtheme
  return(p)
}


###############################################################################
##############################  Plot.Multi ####################################
###############################################################################

### Function *** Plot.Multi ***
# Plots subgroups with different colors and shapes
# Function Arguments: 
# dt : dataset that contains the HRs for each exposure, outcome and subgroups
# ggtheme : customized theme
# n : desired number of rows of legends




# Multiple Group Plot Function - Cmp --------------------------------------
Plot.Multi.lab <- function(dt, ggtheme, n) {
  
  dt$size.m <- ifelse(dt$sig == 18, 2.25, 1.5)
  
  p1 <- ggplot(data = filter(dt, Cause %in% cuz.top.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig, size = size.m), 
               show.legend = T) + 
    scale_shape_identity() +
    scale_size_identity() +
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed', 
               labeller = labeller(Index  = as_labeller(Index.labels, label_parsed))) +
    ggtheme +
    guides(color = guide_legend(override.aes = list(shape = guide.shapes),
                                nrow = n, byrow = T, reverse = T,
                                direction = "vertical"))
  
  p2 <- ggplot(data = filter(dt, Cause %in% cuz.bot.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "Hazard Ratio (95% CI) \n Solid shapes (point estimates) indicate statistically significant results at the 0.05 level", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig, size = size.m), 
               show.legend = T) + 
    scale_shape_identity() +
    scale_size_identity() +
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed', 
               labeller = labeller(Index  = as_labeller(Index.labels, label_parsed))) +
    ggtheme +
    guides(colour = guide_legend(override.aes = list(shape = guide.shapes),
                                 nrow = n, byrow = T, reverse = T, 
                                 direction = "vertical"))
  
  p <- ggarrange(p1, p2, common.legend =T, nrow = 2, legend = "bottom")
  return(p)
}





# Multiple Group Plot Function - Fac --------------------------------------
Plot.Multi <- function(dt, ggtheme, n) {
  
  dt$size.m <- ifelse(dt$sig == 18, 2.25, 1.5)
  
  p1 <- ggplot(data = filter(dt, Cause %in% cuz.top.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig, size = size.m), 
               show.legend = T) + 
    scale_shape_identity() +
    scale_size_identity() +
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(color = guide_legend(override.aes = list(shape = guide.shapes),
                                nrow = n, byrow = T, reverse = T, 
                                direction = "vertical"))
  
  p2 <- ggplot(data = filter(dt, Cause %in% cuz.bot.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "Hazard Ratio (95% CI) \n Solid shapes (point estimates) indicate statistically significant results at the 0.05 level", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig, size = size.m), 
               show.legend = T) + 
    scale_shape_identity() +
    scale_size_identity() +
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(colour = guide_legend(override.aes = list(shape = guide.shapes),
                                 nrow = n, byrow = T, reverse = T, 
                                 direction = "vertical"))
  
  p <- ggarrange(p1, p2, common.legend =T, nrow = 2, legend = "bottom")
  return(p)
}





###############################################################################
############################  Plot.Multi.Color  ###############################
###############################################################################

### Function *** Plot.Multi.Color ***
# Plots subgroups with different colors
# Function Arguments: 
# dt : dataset that contains the HRs for each exposure, outcome and subgroups
# ggtheme : customized theme
# n : desired number of rows of legends

### Multiple Group Plot Function
Plot.Multi.Color <- function(dt, ggtheme, n) {
  
  p1 <- ggplot(data = filter(dt, Cause %in% cuz.top.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig), 
               size = 1.5, show.legend = T) + 
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    scale_shape_identity() +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(color = guide_legend(nrow = n, byrow = T, reverse = T,
                                direction = "vertical")) 
  
  p2 <- ggplot(data = filter(dt, Cause %in% cuz.bot.row),
               aes(x = HR, xmin = HR.L, xmax = HR.U, y = Tag)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    labs(x = "", y = "") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Tag, yend = Tag, color = Tag),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Tag, color = Tag, shape = sig), 
               size = 1.5, show.legend = T) + 
    scale_color_manual(
      labels = plot.labs, 
      values = plot.cols) +
    scale_shape_identity() +
    facet_grid(Index ~ Cause,  scales = "free_x", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme +
    guides(color = guide_legend(nrow = n, byrow = T, reverse = T, 
                                 direction = "vertical"))
  
  p <- ggarrange(p1, p2, common.legend =T, nrow = 2, legend = "bottom")
  return(p)
}




###############################################################################
############################  Plot.Matrix  ###############################
###############################################################################

### Function *** Plot.Matrix ***
# Plots subgroups with different colors
# Function Arguments: 
# dt : dataset that contains the HRs for each exposure, outcome and subgroups
# cmp : component of interest
# title : 
# ggtheme : customized theme


### Matrix Plot Function
Plot.Matrix <- function(dt, cmp, title, ggtheme) {
  
  p <- ggplot(data = dt %>%  filter(Index == cmp),
              aes(x = HR, xmin = HR.L, xmax = HR.U, y = Cause)) +
    geom_vline(xintercept = 1, linetype = 2, color = "black") +
    geom_segment(aes(x = HR.L, xend = HR.U, y = Cause, yend = Cause, color = Cause),
                 size = 0.25, show.legend = T) + 
    geom_point(aes(x = HR, y = Cause, shape = sig, color = Cause),
               size = 2, show.legend = T) + 
    scale_shape_identity() +
    #scale_size_identity() +
    #scale_color_manual(
    # labels = plot.labs, 
    #values = plot.cols) +
    scale_color_manual(values = brewer.pal(n=10, "Paired")) +
    #scale_color_tableau(palette = "Tableau 10") +
    labs(x = "Hazard Ratio (95% CI) \n Solid shapes (point estimates) indicate statistically significant results at the 0.05 level", y = "") +
    ggtitle(title) +
    facet_grid(Buffer ~ Window,  scales = "fixed", switch = 'y',
               shrink = T, space = 'fixed') +
    ggtheme.matrix + 
    guides(color = guide_legend(ncol = 1, byrow = T, reverse = T,
                                direction = "vertical"))
  return(p)
}

