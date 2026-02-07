# Flight Booking System ✈️

A flight seat reservation system built with **Ruby on Rails 8**. Users can view available seats and book flight tickets in real-time.

![Flight Booking System](./example.jpg)

## Features

- **Flight Management** - Create and manage flight information
- **Seat Management** - Handle seat availability across cabin classes
- **Seat Reservation** - Users can reserve seats in their preferred cabin
- **Booking System** - Complete ticketing workflow
- **Ticket Generation** - Automatic ticket creation from bookings
- **REST API** - Full API for frontend integration
- **Multi-cabin Support** - Support for Economy, Business, First Class, etc.

## Requirements

- Ruby >= 3.2.0
- Rails >= 8.0.0
- Node.js >= 18.0.0
- SQLite3 (dev) / PostgreSQL (prod)

## Installation

```bash
# Clone and setup
git clone <repository-url>
cd rails-flight-booking
bundle install

# Database setup
./bin/rails db:create
./bin/rails db:migrate

# Run development server
./bin/dev
```

The app will be available at `http://localhost:3000`

## API Endpoints

### Get Flight Seats
```bash
GET /api/flight-seat/<flight_id>
Content-Type: application/json
Headers: { Authorization: "bearer <token>" }

{
  "message": "ok",
  "data": {
    "flight_code": "AAAX",
    "departure_airport": "AMQ",
    "arrival_airport": "GCK",
    "departure_time": "2026-02-06T10:32:36.749Z",
    "arrival_time": "2026-02-06T11:02:36.749Z",
    "cabins": [
      {
        "cabin_code": "Y",
        "cabin_class": "ECONOMY",
        "rows": {
          "start": 1,
          "end": 30
        },
        "seat_by_aisle_columns": [
          ["A","B", "C"],
          ["D", "E", "F"]
        ]
      }
    ],
    "seat_inventory": [
      {
        "seat_code": "A13",
        "cabin_code": "Y",
        "availability_state": "LOCKED"
      }
    ]
  }
}
```


### Reserve Seat
```bash
POST /api/flight-seat/reservation
Content-Type: application/json
Headers: { Authorization: "bearer <token>" }

{
  "flight_id": 1,
  "seat_code": "A12",
  "passenger_name": "John Doe"
}
```

## Models

- **Aircraft** - Aircraft information
- **Flight** - Flight routes and schedules
- **Seat** - Individual aircraft seats
- **Booking** - User seat reservations
- **Ticket** - Generated tickets from bookings
- **User** - Application users
- **AircraftCabin** - Cabin classes and capacity


## Deployment

### Using Kamal
```bash
./bin/kamal deploy
```

### Using Docker
```bash
docker build -t rails-flight-booking .
docker run -p 3000:3000 rails-flight-booking
```

## Environment Variables

```
RAILS_ENV=production
DATABASE_URL=postgresql://user:pass@host/db
RAILS_DB_USERNAME=user
RAILS_DB_PASSWORD=pass
```

## License

MIT License
