


# load packages (install first if needed)
library(dplyr)
library(ggplot2)
library(ggalt)
library(ggforce)


data("mtcars")
mtcars$am<-as.factor(mtcars$am)
names(mtcars)

# plot points only
ggplot(mtcars,aes(x=hp,y=mpg,color=am))+geom_point()+theme_bw()

#Convex hulls
#Convex hulls are one of the most common methods for grouping points. Convex hulls have a formal geometric definition, but basically they are like stretching a rubber band around the outermost points in the group. We can now calculate the convex hulls for many groups using ggforce.

# calculating convex hulls
#plot with hull
ggplot(mtcars,aes(x=hp,y=mpg,color=am))+
  geom_mark_hull(concavity = 5,expand=0,radius=0,aes(fill=am))+
  geom_point()+
  theme_bw()

#with convex hulls and fills for each group
#Convex hulls often include large areas with no points in them. Tweaking the parameters can give us a tighter hull with nice round corners.

# rounded and more concave hull
ggplot(mtcars,aes(x=hp,y=mpg,color=am))+
  geom_mark_hull(expand=0.01,aes(fill=am))+
  geom_point()+
  theme_bw()

#Ellipses
# Another common alternative is to group points using ellipses. We can plot the ellpises with ggforce, although ggplot::stat_ellipse is also an option.

# plot with ellipse
ggplot(mtcars,aes(x=hp,y=mpg,color=am))+
  geom_mark_ellipse(expand = 0,aes(fill=am))+
  geom_point()+
  theme_bw()

#Encircle
# This option is what I ended up using for my own figures. It usesgeom_encircle, a new geometry provided in the ggalt package. This geom uses polynomial splines to draw nice smoothed polygons around the groups of points. It has flexible options for color, fill, and the smoothness of the polygons that it draws. This method is nice for highlighting groups visually and indicate cohesion, and not necessarily for performing any further analyses on the polygons themselves (e.g. using the areas or the amount of overlap for other subsequent tests).

# plot with spline encirclement
ggplot(mtcars,aes(x=hp,y=mpg,color=am))+geom_point()+
  geom_encircle(expand=0)+ theme_bw()

