## Final Project: FriskyFoods

# Purpose:

- FriskyFoods tackles “meal indecision.”
- When you’re feeling frisky for some food, and are unsure what to make with common ingredients around the house, users are able to “roll the dice” and find something new.
- The core idea is to take pressure off deciding what to cook, and find delicious recipes that the user may have forgotten about.

# Features:

- Users can tap any food genre to get a randomly suggested recipe—essentially “rolling the dice” within whatever category they’re craving.
- The user is able to pick out what they like and “favorite” the recipe, effectively adding it to a collection on a separate page.
- I included transitions and animations throughout the UI for fun, and believe that they add to its appeal!

# Obstacles and Future Additions:

- Originally, I wanted to make FriskyFoods an app that allows the user to input their ingredients, then get a random recipe out of it. However, given that this project required an API endpoint, I went ahead and made it simpler, just allowing the user to find random, simple recipes of different genres.
- - In the future, I want to implement the ability for user to input their ingredients, then call ChatGPT to create a recipe for them. It is much easier to hand the parsing of input to an AI, rather than first getting separate inputs from the user then using a full-text search to find recipes in the API database that may or may not work
- I had a difficult time implementing the API. I found it straightforward to get the Service file running, though using its outputs and creating callbacks to it on clicks of buttons or favorites was difficult.
- - Furthermore, the API I ended up being limited, only having 30 entries to it. I don’t think that it will be massively difficult to switch APIs, though for the purpose of this app, I found that it offers an adequate proof of concept.
