# [Run2Gether](http://r2g.herokuapp.com)

A web app that seeks to connect runners in the area based on their proximity, experience, and availability so they can *run together*.

![Run2Gether Homepage](https://github.com/catkhuu/Run2Gether/blob/master/public/r2g_homepage.jpg)

## Contributing 
We're always looking for eager developers with a passion for running to contribute. Checkout our ToDo list and [Issues](https://github.com/catkhuu/Run2Gether/issues) for features we're looking to integrate, and bugs that need fixing. 

#####*Please fork and clone this repository before submitting a pull request*

## Setup and Installation 
In your terminal, clone the repository: ```` git clone https://github.com/catkhuu/Run2Gether.git ````

####Bundle 
  ```
  bundle install
  ```
  
   We use PostgreSQL, but feel free to swap this out for SQLite in your gem file before bundling.

####Create database 
  ``` 
  bundle exec rake db:create
  ``` 

####Run migrations 
  ``` 
  bundle exec rake db:migrate 
  ```

####Start your server 
  ```
  rails s 
  ``` 

Visit localhost:3000 in your browser 

## Technologies 
Ruby on Rails web app with JQuery and Ajax to enhance the user's experience. We used the Google Maps API and Ruby Geocoder and Area gems to generate our runner's meetingpoints. Materialize framework used for styling and mobile responsiveness. 

## Contributors 
**Run2Gether** is maintained by [Catherine Khuu](https://github.com/catkhuu/), [Lindsay Kelly](https://github.com/lindsaymkelly/), [Matt Critelli](https://github.com/mattcritelli/), and [Miles McArdle-Coe](https://github.com/Kndekaru/). 

## ToDo
Checkout our ToDo list [here](https://github.com/catkhuu/Run2Gether/blob/master/todo.md)

See [our other projects](https://github.com/catkhuu/Run2Gether/blob/master/community.md) or [hire](https://github.com/catkhuu/Run2Gether/blob/master/hire.md) us to work on your product. 






