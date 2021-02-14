type currency = 
    | USD
    | INR

type duration = 
    | Hourly
    | Daily
    | Weekly
    | Monthly
    | Yearly

type rec consultingRate = {
    value: float,
    currency: currency,
    duration: duration
}

let supportedCurrencies: array<currency> = [USD, INR]
let supportedDurations = [Hourly, Daily, Weekly, Monthly, Yearly]
