---
title: "Sputnik project, first update"
date: 2018-05-19T00:18:23Z
markup: mmark
---

# Sputnik: a web app to look at your data

This is the first of a series of blog updates about my Google Summer of Code project. I'll be working during Summer on a Julia based web app for data analysis and visualizations. So far I have the core structure and am exploring ways to make the interface more intuitive and user-friendly.

## Loading the data

To load the data, I'm using a simple file picker dialog or a dropdown menu to choose among previously saved datasets:

![load](../../images/load.png)

## Filtering the data

To filter the data, I distinguish between categorical variables, where the user can select using checkboxes which values to accept, and continuous variables, where the user can specify a condition with Julia code:

![filter](../../images/filter.png)

## Styling the data

To style the data, I allow the user to choose which variables will be used as "aesthetics" with toggle switches. If a variable is selected, the user can choose which attribute to style with a dropdown menu:

![style](../../images/style.png)
