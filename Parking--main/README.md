# Parking-
# TouristApp
### Project Name: My Parking

#Project Description :
An application that facilitates booking through a parking lot and payment is made through the barcord on the site
#Features List:

- Feature 1 App can brows places of city 
- Feature 2 User can Saves time for the user
- Feature 3 User can Reducing congestion in the complex
- Feature 4 User can Easy to pay
- Feature 5 User can Change the App Language (Arabic & English).
- 

# Structure:
screens:
add screens/models/views/cells/support File / Localizable
- HomeVC.
- TabBar 
- Login Validation.
- SignInVC
- SignUpVC
- MainVC
- MapVC
- MyReservationVC

##models
- 
- Colors
- Model


##cells 
- Location Cell
- LocationImage Cell
- Home Cell
- CustomTextField View
- 

# Structure:
// Add your project screens/models/views/cells
screens:
- TabBar 
- Login Validation.
- SignInVC
- SignUpVC
- MainVC
- MapVC
- MyReservationVC
Models:
- Colors
- Modela
Cells:
-  Location Cell
- LocationImage Cell
- Home Cell
- CustomTextField View
- 


### User Stories:
As a user I want to login/Register, so that I can make account to use app
As a user I want to Sign out, so that I can login wth another account
As a user I want to search for places , so that I can find it easly
As a user I want to enter carname , so that i can enter number car,so that I can car name
As a user I want to Calculates entry time, so that I can Shows the user the time
As a user I want to Sign out and calculate the final price so that I can check and save it to visit any time, so that The user logs out
As a user I want to the location of the placescon the map , so that I can visit easly
As a user I want to watch video for places , so that I can see details for places


# Backlog:
 
User :
- see your Map
- see  location for places and photo for city 
- can see barcode
- can see Time Entry time
- can signOut
- can change language [Arabic , Envglish]
- can change appearance for the app [Dark , Light mode]


# React Router Routes (React App)

|      Component      |   Permission   |                Behavior                  |
|       :---          |     :---:      |                  ---:                    |
|     lunchScreen     |     public     |                Show Logo                 |
|       :---          |     :---:      |                  ---:                    |
|    RigesterPage     |     public     |  Rigester page, link to login,           | 
|                     |                |  navigate to homepage after Rigester.    |  
|       :---          |     :---:      |                  ---:                    |
|                     |                |      Login page, link to Rigester,       |
|     LoginPage       |     public     |      navigate to home page after login.  |
|                     |                |                                          |
|       :---          |     :---:      |                  ---:                    |
|                     |                | Home page, link to visitor List,         |
|    firstHomePage    |   user only    | navigate to photo place List after       |                                                                               | pressed on visitor button                |
|                     |                |                                          |
                                                                                  | 
|       :---          |     :---:      |                  ---:                    |
|                     |                | Enter carname and carnumber, |
|    firstHomePage    |   user only    | navigate to page time and date to enter             |      
                                                                                  |
|       :---          |     :---:      |                  ---:                    |
|                     |                | list choose any Location ,  |
|    Reservation   |   user only    |     navigate to barcode    |
|        :---         |     :---:      |                  ---:                    |
|                     |                |                                          |
|                     |                |                                          |
|       :---          |     :---:      |                  ---:                    |
|                     |                |                                          |
|                     |                |
|                     |                |                                          |
|                     |                |                                          |
|   mapPage           |     :---:      |   map Page, link to mapPage View         |
|                     |                |   navigate to location Place after       |
                      |                |     pressed on mapPage                   |
|       :---          |     :---:      |                  ---:                    |
|                     |                |                                          |
|                     |                |                |
|       :---          |     :---:      |                  ---:                    |
|                     |                | 
# Components:

 - Rigester $ LogIn Page 
 - Home Page (contains collection of pages)
 - Reservation 
 - MyReservation 
 - MapVC
 
 # Services
_ Auth Service: 
  - auth.rigester(user)
  - auth.login(user)
  - auth.logout(user)
_ Favourite Services.

# Links: 

_ repository Link:
https://github.com/mnoor11?tab=repositories


-

