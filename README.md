# DateTime-4D

4D component for handling date-time values as a single value, with time zone
and daylight saving time support. Date calculations automatically update the
date when time operations cross a day boundary, such as when adding 24 hours.

## Contents

- `cs.DateTime`: date, time, formatting, UTC conversion, and time operations.
- `cs.TimeZone`: system time zone detection, lookup by Microsoft or IANA
  identifier, and time offset calculation.
- `Resources/TimeZone.json`: mapping of the time zones used by the component.

## Installation

Import the component into your 4D project, then use the classes with their
fully qualified names: `cs.DateTime` and `cs.TimeZone`.

## Quick start

```4d
// Current date and time with the automatically detected time zone
var $now : cs.DateTime
$now:=cs.DateTime.new()
ALERT($now.toISO())

// Date and time in a specific time zone
var $date:=!2025-11-05!
var $time:=?14:30:15?
var $dateTime:=cs.DateTime.new($date; $time; cs.TimeZone.new("Europe/Paris"))

ALERT($dateTime.toISO())
ALERT($dateTime.toUTC())
```

A time zone can be provided using its IANA identifier (`Europe/Paris`) or its
Microsoft identifier (`Romance Standard Time`). An unknown identifier falls
back to UTC.

## Main API

### `cs.DateTime`

- Properties: `date`, `time`, `timeZone`, `year`, `month`, `day`, `hour`,
  `minute`, `second`, `dayOfWeek`.
- Formatting: `toISO()`, `toUTC()`, `toShortDateString()`,
  `toLongDateString()`, `toShortTimeString()`, `toLongTimeString()`.
- Calculations: `addDays()`, `addMonths()`, `addYears()`, `addHours()`,
  `addMinutes()`, `addSeconds()`.
- Utilities: `IsLeapYear`, `isDaylightSavingTime`, `startAndEndOfWeek`,
  `minDate`, `maxDate`, `unixEpoch`.

```4d
Adding hours, minutes, or seconds automatically carries overflow into the date,
including for negative values.

// Create a DateTime object with specific date and time
var $dt:=cs.DateTime.new(!2026-03-15!; ?01:30:15?)
ALERT("Specific DateTime: "+$dt.toISO())
ALERT("UTC DateTime: "+$dt.toUTC())

// Create a DateTime object without parameters (current date and time)
var $dt1:=cs.DateTime.new()
ALERT("Current DateTime: "+$dt1.toISO())
ALERT("Is Daylight Saving Time: "+String($dt1.isDaylightSavingTime))
ALERT("Is leap year: "+String($dt1.IsLeapYear))

// Create a DateTime object with specific date and time
var $myDate:=!2025-11-05!
var $myTime:=?14:30:15?
var $dt2:=cs.DateTime.new($myDate; $myTime; cs.TimeZone.new("Europe/Paris"))
ALERT("Specific DateTime: "+$dt2.toISO())
ALERT("UTC DateTime: "+$dt2.toUTC())

// properties
ALERT("Year: "+String($dt2.year))
ALERT("Month: "+String($dt2.month))
ALERT("Day: "+String($dt2.day))
ALERT("Hour: "+String($dt2.hour))
ALERT("Minute: "+String($dt2.minute))
ALERT("Second: "+String($dt2.second))
ALERT("Day of the week: "+String($dt2.dayOfWeek))

// Formatting methods
ALERT("Short date: "+$dt2.toShortDateString())
ALERT("Long date: "+$dt2.toLongDateString())
ALERT("Short time: "+$dt2.toShortTimeString())
ALERT("Long time: "+$dt2.toLongTimeString())

// Temporal operations
$dt2.addDays(3)
ALERT("After +3 days: "+$dt2.toISO())
$dt2.addHours(2)
ALERT("After +2 hours: "+$dt2.toISO())
$dt2.addMinutes(15)
ALERT("After +15 minutes: "+$dt2.toISO())
$dt2.addSeconds(30)
ALERT("After +30 seconds: "+$dt2.toISO())
```

### `cs.TimeZone`

- `current`: detected time zone, or UTC if no time zone is available.
- `getOffset($date)`: returns the offset in the form `+02:00` or `Z`.
- `dateTimeWithOffset($date; $time)`: produces an ISO string with an offset.
- `toUTC($date; $time)`: returns a `cs.DateTime` object expressed in UTC.

```4d
// 1 Create an instance without parameters → should detect the system time zone
var $tz1:=cs.TimeZone.new()
ALERT("Detected current time zone: "+String($tz1.current.MicrosoftTimeZone))

// 2️ Create an instance with parameter "UTC" → force UTC
var $tzUTC:=cs.TimeZone.new("America/Metlakatla")
ALERT("UTC time zone: "+String($tzUTC.current.MicrosoftTimeZone))
```

