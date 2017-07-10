# Chatwa

Jamaican Patois, known locally as Patois (Patwa or Patwah) and called Jamaican Creole by linguists, is an English-based creole language with West African influences (a majority of loan words of Akan origin) spoken primarily in Jamaica and the Jamaican diaspora. [Wikipedia Link](https://en.wikipedia.org/wiki/Jamaican_Patois)

Chatwa is word guessing game based on Jamaican Patois. The main user interface presents the User with a hint in standard english and a grid of letters to choose from for the user to guess the answer. The app uses the [Jamaican Patty](https://en.wikipedia.org/wiki/Jamaican_patty), a pastry popular in Jamaica, as a form of In-App currency for users to use to get hints for the answer. The user can use a number of patties in exchange for a letter in the answer and the user can also use the share icon in the navigation bar to share a screenshot with their friends asking for help. Once the users guesses the answer correctly, they receive a patty for their efforts and is presented with a screen letting them know their success. 

The game has three main screens

## Home Screen
![Home Screenshot](https://raw.githubusercontent.com/JavonDavis/Chatwa/master/Screenshots/IMG_1689.PNG)

This is the screen the user is first presented with when the app opens. The user can either choose to tap the play button or the instructions. 

### Tapping the play button
Tapping the play initiates a network request if a connection exists, or uses any data stored locally if there is no network connection. 

### Tapping the instructions button
Tapping this button presents the following dialog giving the user instructions on how to play game.

![Instructions Screenshot](https://raw.githubusercontent.com/JavonDavis/Chatwa/master/Screenshots/IMG_1690.PNG)

## Main Screen
![Main Screen](https://raw.githubusercontent.com/JavonDavis/Chatwa/master/Screenshots/IMG_1691.PNG)

The main screen has a number of UI elements.

### The navigation bar

The navigation bar has the back button to the far left, level # in the center, the number of patties to the right of that and then an action button farthest right side for users to share a screenshot with their friends. 

### The main game interface (in the center)

The "?" button on the top left allows users to guess letters using patties. If the user chooses to get a letter using patties a random letter in the answer is removed from the grid and permanently presented in the answer row with a Blue background. 

The hint is then presented in Standard english with the tiles showing the number of letters in the answer directly below.

### The grid (at the bottom of the screen)

A 14 tile 2 row grid is presented at the bottom showing the user various options for letters that could make up the answer. The user taps these tiles to move them up to the answer section filling available slots, until all slots are full. The user can also tap a tile from the answer section to remove it, if they don't believe it is a part of the answer. Once all slots are full and the answer is correct the app will transition to the success screen.  


## Success Screen

![Success Screen](https://raw.githubusercontent.com/JavonDavis/Chatwa/master/Screenshots/IMG_1692.PNG)

This screen has a few elements as well

### The navigation bar

The navigation bar has an action button to farthest right side for users to share a screenshot of their success with their friends. 

### Main Section

This section 
* Congratuales the user
* shows them the hint and the answer
* Indicates the number of patties the user has just received. 

The user the taps "AWOH" to proceed to the next level. 

## Features Implemented
* Rounds being loaded over network from Firebase
* Core Data used to store all levels
* User defaults used to store the level the user is at
* User defaults is used to store letters purchased with patties
* Grid, Hint and Answer tiles presented properly
* USer can store screenshots usign action button

## Features I want to implement after a successful Review
* In-app purchases of Patties
* Game center Integration

## Notes
* To help the reviewer interact with the app properly and also to demonstrate the ability to use a second UIControl a UIStepper has been added to increase/decrease the number of patties.
