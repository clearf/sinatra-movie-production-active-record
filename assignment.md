## Create a web app to help movie producers manage a production

#### Objectives

* Refine CRUD skills
<<<<<<< HEAD
* Integrate the use of primary keys by tying together different data
* Implement basic CSS.
=======
* Use ActiveRecord to integrate foreign keys to link different data.
>>>>>>> d2045a22c06761a1dfbc7dba531272a90ab69742

#### Story

* You are a making a web app for movie producers to manage a production.
* There are three distinct pieces of data that need to be tied together
  * Tasks
  * People
  * Movies
* A user should be able to manage ToDo tasks
  * In addition to name and descriptions, tasks should have:
    * a contat person to whom they can be assigned
    * a movie to which they are related
* A user shoudl be able to see task details "at a glance" on the task list page. 
* A user should be able to manage movies:
  * A release date
  * A director (A person)
* Users should have CRUD interactions with Tasks, People, and Movies
* Users should be able to assign contact people and movie without typing in an ID number
  * Instead, they should be able to select from a drop down box.
* Users should have a pleasant asthetic experience. 

##### *Bonus*
  * In addition to seeing the people and movies associated with each todo, consider adding views to show: 
    * Every ToDo task associated with a particular movie
    * Every ToDo task associated with a particular person

##### *Double Bonus*
  * Integrate with the IMDB API to pull in info about *real* movies!
   

#### Task
* Create a Sinatra application that fulfills the needs of the user story listed above
* Use ActiveRecord to store information into a database. 
  Do *not* use raw postrgres
* Create a few CSS rule, using element, class, and ID selectors
  * Focus on functionality, and then CSS. 
* Comment your code carefully, noting which sinatra request fulfills each part of the story. 
* Submit many commits, each with good comments. 

