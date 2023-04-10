# PlatePal

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Brainstorm Favorite Apps
* Instagram
  * Feed of everyone's posts where users can comment/like
  * Explore page to see posts of people you don't follow
* Reddit
  * Ability to join subcommunities each with a specific topic
  * Points system that users can acheive through posting/commenting
* Apple Health
  * Ability to see statistics on your health/exercise
  * Ability to sync data from an apple watch to accurately measure statistics
* Pinterest
  * Ability to get ideas for specific topics and crafts
  * Ability to save pinterest posts to personal boards that can have a theme or individual purpose
  
### Our Top Ideas
* PlatePal: Social media app for meal prep and meal statistics
* ExerShare: Social media app for workouts and to keep your friends accountable
* Fashionder: Tinder-like app except for fashion ideas and clothing items

### Our Final Choice:
**PlatePal**

### Description
PlatePal is an iOS application that allows users to share the meals they eat throughout their day with other users. Their posts can include the nutrition details of the meal and a recipe. Additionally, there is a profile page that shows statistics about the average calories, protein, carbs, etc. that you as a user consume in your meals.

### App Evaluation
- **Category:** Social Media
- **Mobile:** uses camera and photo library
- **Story:** people do not currently have a way to easily share their meals and track their nutrition in a singular app
- **Market:** People interested in health, relatively niche group
- **Habit:** Users will want to post every meal so they will use this app ~3 times per day
- **Scope:** Not super technically challenging yet still interesting to build

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* ~~User can create a new account~~
* ~~User can login to an existing account~~
* ~~User can create a post~~
* ~~User can detail the contents of their meal and an API will calculate the nutrition facts~~
* ~~User can take a picture or choose a photo from their library to include in the post~~
* ~~User can view all other user's posts in their home feed~~
* ~~User can view statistics about their meals in the profile page~~
* ~~User can click on a post to see a more detailed view~~

**Optional Nice-to-have Stories**

* Users can like a post
* Users can comment on posts
* Users can follow another user (home feed would switch from all users to just those you follow)
* Users can see a graph of nutritional history in their profile page
* Users can upload a profile photo

### 2. Screen Archetypes

* Login Screen
   * User can login to an existing account
* Registration Screen
   * User can create a new account
* Home Feed Screen
    * User can view all other user's posts in their home feed
* Profile Screen
    * User can view statistics about their meals in the profile page
* Create Post Screen
    * User can create a post
    * User can detail the nutrition facts of their meal for their post
    * User can take a picture or choose a photo from their library to include in the post
* Post Detail Screen
    * User can click on a post to see a more detailed view

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed Tab
* Create Post Tab
* Profile Tab

**Flow Navigation** (Screen to Screen)

* Login Screen
   * => Registration Screen
   * => Home Feed Screen
* Registration Screen
   * => Login Screen
   * => Home Feed Screen
* Home Feed Screen
    * => Post Detail Screen
* Profile Screen
    * => None
* Create Post Screen
    * => Home Feed Screen
* Post Detail Screen
    * None

## Wireframes

![](https://i.imgur.com/0Vg16pO.png)

