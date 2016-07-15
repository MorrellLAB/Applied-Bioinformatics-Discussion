#!/usr/bin/env Rscript

############################################################
##########          Start editing here            ##########
############################################################
#   Finish the function to plot Thetas values
plotThetas <- function(window.center, thetas, label = 'Thetas', color = 'red'){
    return(NULL)
}

############################################################
##########          Leave this alone              ##########
############################################################
Thetas <- read.table(file = 'ANGSD-wrapper_sample.thetas', header = TRUE, as.is = TRUE)
Thetas$Watterson <- Thetas$tW / Thetas$nSites
Thetas$Pairwise <- Thetas$tP / Thetas$nSites

############################################################
##########          Start editing here            ##########
############################################################
#   Plot the values for Watterson's Theta,
#   Pairwise Theta, and Tajima's D using
#   the function you wrote
plotThetas(label = "Watterson's Theta")
plotThetas(label = "Pairwise Theta")
plotThetas(label = "Tajima's D")
