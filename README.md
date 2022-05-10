# HapticMap App

![illustration-of-somebody-using-hapticmap](https://user-images.githubusercontent.com/26303997/167565189-60b5c111-9689-42cd-abb3-f44b9d5f9a4f.jpg)

## Introduction
Mobility is one of the many challenges that blind or visually impaired people face. This application allows users to explore simplified indoor or outdoor venue maps by moving their fingers on the screen. Precise haptic feedback, sounds, and audio descriptions are given depending on the element under the finger. By doing so, users can understand any map even when being unable to see, enabling them to gain autonomy and confidence in their everyday lives. Users can also create itineraries with a list of ordered maps.

![app-screenshots](https://user-images.githubusercontent.com/26303997/167565001-6cdb65ac-831e-46bd-a3df-1cf5fd0eed54.jpg)
![app-screenshots-2](https://user-images.githubusercontent.com/26303997/167565430-73d03181-57a5-4627-95b3-ee112979d5fc.jpg)
![app-screenshots-3](https://user-images.githubusercontent.com/26303997/167565290-73f288f0-cfa9-448d-a8b3-e43f96516805.jpg)

## Origins of the Project
This project is the result of an [EPFL](https://www.epfl.ch/en/) master thesis completed by [Timothée Duran](https://www.linkedin.com/in/timotheeduran) at [ELCA](https://www.elca.ch), a Swiss company specialized in software development and based in Lausanne.

During this project, a collaboration with the [Swiss Association for the Blind and Visually Impaired SBV-FSA](https://sbv-fsa.ch/fr) has taken place, and the project has been transfered and open-sourced.

The thesis containing the results of a UX research as well as more information about this project can be found in the file `making-maps-accessible_master-thesis_timothee-duran.pdf`.

## Future of the Project
The [Swiss Association for the Blind and Visually Impaired](https://sbv-fsa.ch/fr) has to goal to take this project further and is currently developing a framework for use in existing apps. The goal is to represent any existing indoor or outdoor maps using haptic and audio feedback.

## Map Specifications
Maps are represented as simple images with colored shapes. Each shape represents an element on the map and the color defines the type of element; those will be interpreted by the app. Please refer to the specifications below when creating maps.

### Map Image Size
We recommend the following size:

* **390**px x **844**px
* **13.76**cm x **29.77**cm
* **5.42**in x **11.72**in

### Colors
Here are the predefined colors. You can also use custom colors to represent custom categories. In this case, open the map in the app and use the interface to set you custom categories.
![illustration-of-the-predefined-colors](https://user-images.githubusercontent.com/26303997/167565535-9518278b-821f-4666-b0ca-51060cbeb10d.jpg)

* `#ffffff`: Background
* `#bf211e`: Border
* `#19a368`: Destination
* `#858686`: Intersections
* `#1d49b9`: Itinerary
* `#ffcf00`: Pedestrian Crossing
* `#ed4c07`: Pedestrian Crossing with Lights
* `#0b0c0d`: Roads


