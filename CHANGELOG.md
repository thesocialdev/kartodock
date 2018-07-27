Changelog
=========


v0.1.0
------
- Fix the Workspace Dockerfile to have appropriate tools to handle OSM data loading
- Creating a Dockerfile for every service under the stack
- Creating Workspace service to handle OSM data loading and other setup tools that might be needed
  - Still needs some work to complete
- Adding services needed to run Kartotherian stack: Redis, Cassandra, Kartotherian, PostgreSQL + PostGis with OSM data loaded
- Adding services to manipulate CartoCSS projects: Kosmtik, Mapbox Studio Classic
  - Still needs some work to complete