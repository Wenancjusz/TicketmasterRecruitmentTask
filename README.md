# Ticketmaster Discovery API App
The app allows user to explore and discover events happening in Poland using the Ticketmaster Discovery V2 API.

## Features
**Event List Screen**

Displays a list of events with the following basic information for each event:

- Event Name,
- Event Date,
- City,
- Venue Name,
- Event Image.


**Event Details Screen**

Shows detailed information about a selected event, including:

- Event Name,
- Performer(s),
- Event Date and Time,
- Event Type,
- Precise Location (Country, City, Venue Name, Address),
- Price Range,
- Photo Gallery of the Event,
- Seating Map Image.


## Setup Instructions
To run the app locally, you need to obtain an API key from Ticketmaster's Developer Portal and configure the app to use it.

### 1. Obtain Your API Key
Go to the Ticketmaster Developer Portal.
Sign in or create an account.
Create a new application to generate your API key.
Once generated, you'll have an API key that is required to fetch event data.

### 2. Add Your API Key to the App
Download or clone the repository to your local machine.
Locate the Constants.swift file in the Utilities/Constants folder of the project.
Open the Constants.swift file and insert your API key as the value for the apiKey constant.

### 3. Run the App
Open the project in Xcode.
Build and run the app on your device or simulator.
The app should now fetch event data from the Ticketmaster API and display it on the main screen and detailed view.
