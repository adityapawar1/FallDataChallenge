install.packages("gapminder")
library(gapminder)
data("gapminder")

summary(gapminder)
x <- mean(gapminder$gdpPercap)
x

attach(gapminder)
median(pop)
hist(lifeExp)
hist(lifeExp)
hist(log(pop))
boxplot(lifeExp ~ continent)
plot(lifeExp ~ log(gdpPercap))

install.packages("dplyr")
library(dplyr)

df1 <- gapminder %>%
  select(country, lifeExp) %>%
  filter(country == "South Africa" | 
           country == "Ireland")

t.test(data = df1, lifeExp ~ country)

install.packages("ggplot2")
library(ggplot2)

gapminder %>%
  filter(gdpPercap < 50000) %>%
  ggplot(aes(x=gdpPercap, y=lifeExp, col=continent, size=pop)) + 
  geom_point(alpha=0.3)+
  geom_smooth(method = lm)+
  facet_wrap(~continent)

lm(lifeExp ~ gdpPercap+pop)
  


  