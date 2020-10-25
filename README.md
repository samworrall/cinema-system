# cinema-system

A system to process a text file of cinema bookings, returning a list of those that did not pass validations.

## Brief

A cinema has a theatre of 100 rows. Each row has 50 seats. Customer bookings are processed on a first come first served basis.
A booking request must meet a set of criteria to be considered valid. These criteria are as follows:
- The number of seats must be 5 or fewer.
- All seats must be adjacent and on the same row.
- All seats that are requested must still be available.
- Accepting the booking would not leave a single seat gap.

Write a system to process a file of booking requests and determines the number of bookings which are rejected.

## Approach

I began by jotting down in a notebook the key rules when it came to validating booking requests. I also outlined some key objects
that I believed would be necessary in divvying out responsiblity. This translated to to:
- BookingParser: Responsible for parsing a file of booking requests and outputting usable/readable objects.
- CinemaSystem: Responsible for holding the state of the theatre.
- BookingValidator: Responsible for all the nitty gritty business logic. Holds all the validattion rules.
- ProcessBookingRequests: Responsible for tying everything together in a neat, callable  service object.

I took a TDD approach, but also went back where necessary to add test coverage. I used RSpec for my test suite; and rubocop for
linting purposes. I would say that the bulk of the code was completed in around 2 - 2.5 hours; but I spent a good amount of time
afterwards trying to work out why I was only getting back 9 invalid bookings rather than 10 (the number which the tech test brief
stated I should get back). After checking through the edge cases again and again, I've decided that there's a strong possibility
that the given number 10 was wrong, or the sample data was changed before being given to me. I will note that both data files had
trailing commas when the brief explicitly mentioned that they didn't.

## Room to improve

- It's always nice to include some file validation that raises user friendly exceptions if trying to validate an empty file and such.
- There's some repeated logic in the validator, such as calculating the number of seats, which could be its own method.

## How to run

Open an irb with the `process_booking_requests` file required
```
$ irb -r './lib/process_booking_requests.rb'
```

Once inside, simply use the object's `call` method, passing to it your text file of booking requests

```
| invalid_booking_requests = ProcessBookingRequests.call('booking_requests')
```

This will return an array of invalid booking requests. To get the exact number, simply call `.length` on the return value

```
| invalid_booking_requests.length
```
