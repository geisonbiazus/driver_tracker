# Driver Tracker

Simple app to track driver's activities from farms.

The application can be accessed at the following address:

https://drivertracker.herokuapp.com/

There, you can find more information about its usage.

## Technical details

### Architecture

The application was developed following the [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) pattern. Which means it isn't coupled to any framework or database. By doing that, all tests run very fast since they don't depend on any external service. They are just ruby code.

In this application you will find the following object types:

- Interactors - Classes that implement the application business logic.
- Entities - Classes used to hold data and perform focused and independent business logic.
- Repositories - Classes responsible for saving and fetching data. They are in the [app/repositories](https://github.com/geisonbiazus/driver_tracker/tree/master/app/repositories) folder.

You can see all the application business logic is inside [lib/driver_tracker](https://github.com/geisonbiazus/driver_tracker/tree/master/lib/driver_tracker). The tests are in [spec/lib/driver_tracker](https://github.com/geisonbiazus/driver_tracker/tree/master/spec/lib/driver_tracker) folder.

Inside [app](https://github.com/geisonbiazus/driver_tracker/tree/master/app) folder, you can find the normal rails MVC files that are used to provide the application dependencies.

### Scaling

Instead of calculating the driver activity when generating the report, its activity is calculated at the moment the event is processed. The calculation process has an O(n) complexity for each event and it is better for performance storing it already calculated than doing it every time the report is generated.

The event processing is done via background job using sidekiq. If the requests volume increases the job workers can be easily scaled.

Another option for scaling the application is if the database becomes slow, there is the possibility to reprocess the events grouping then in a format ready to be displayed in the report. But it isn't implemented yet.

### TODO

- Better parameters validation
- Aditional resources. Right now there is no `Driver` resource. Only its ID is stored in the ActivityEvent.
- Allow `Company` to have more than one `field` polygon.
