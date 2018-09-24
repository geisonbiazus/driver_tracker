# Driver Tracker

Simple app to track driver's activities from drivers on farms. 
Based on data sent from mobile devices every 2 seconds, it generates an activity report based on the data sent.

Sent payload example:

```json
{  
   "company_id":123,
   "driver_id":456,
   "timestamp":"yyyy-MM-dd'T'HH:mm:ss",
   "latitude":52.234234,
   "longitude":13.23324,
   "accuracy":12.0,
   "speed":123.45
}
```

The report classifies the data into the following:

1. **Driving** - The driver is driving on the road. This means that the speed is more than 5 km/h and the location is not part of predefined fields (geofenced) 

1. **Stopped** - The driver is stoped on the road. This means that the speed is less than 5 km/h and the location is not part of predefined fields (geofenced) 

1. **Cultivating** - The driver is working on a field. This means that the speed is more than 1 km/h and the location is part of predefined fields (geofenced) 

1. **Repairing** - The driver is repairing a machine on a field. This means that the speed is less than 1 km/h and the location is part of predefined fields (geofenced)

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

Another option is to move the logic of discovering if the driver is inside the polygon to the database. Postgres and Elasticsearch have this function. Normally I prefer to express all the business logic in code unless I have a good reason not to.

### TODO

- Better parameters validation
- Aditional resources. Right now there is no `Driver` resource. Only its ID is stored in the ActivityEvent.
- Allow `Company` to have more than one `field` polygon.
