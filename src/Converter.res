open XMLHttpRequest

type currency = 
    | USD
    | INR

type duration = 
    | Daily
    | Hourly
    | Weekly
    | Monthly
    | Yearly

type rec rate = {
    value: float,
    currency: currency,
    duration: duration
}

let months_in_year = 12
let weeks_in_year = 52
let days_in_year = weeks_in_year * 5
let hours_in_year = days_in_year * 8
let supported_currency = [USD, INR]

let durationToString = (dur) => {
    switch dur {
       | Daily => "Daily"
       | Hourly => "Hourly"
       | Weekly => "Weekly"
       | Monthly => "Monthly"
       | Yearly => "Yearly"
   }
}

let currencyToString = (cur) => {
    switch  cur {
    | USD => "USD"
    | INR => "INR"
    }
}

let currencyToSymbol = (cur) => {
    switch  cur {
    | USD => "$"
    | INR => "₹"
    }
}

let converfromYearly = (src: rate, dest_type: duration) => {
   let divider = switch dest_type {
    | Hourly => hours_in_year   
    | Daily => days_in_year
    | Weekly => weeks_in_year
    | Monthly => months_in_year
    | Yearly => 1
   } 
   {value: src.value /. float_of_int(divider), currency: src.currency, duration: dest_type}
}  

let convertToYearly = (src: rate) => {
    let multiplier = switch  src.duration {
    | Hourly => hours_in_year   
    | Daily => days_in_year
    | Weekly => weeks_in_year
    | Monthly => months_in_year
    | Yearly => 1
    }
    {value: src.value *. float_of_int(multiplier), currency: src.currency, duration: Yearly}
}

type latestRatesResponse = {
    "rates": Js.Dict.t<string>
}

@bs.scope("JSON") @bs.val
external parseResponse: response => latestRatesResponse = "parse"

let fetchCurrencyExchangeRates = (src: string, dest: array<string>, ~callback) => {
    let request = makeXMLHttpRequest()
    request->addEventListener("load", () => {
        let response = request->response->parseResponse
        let result = {
            response["rates"]->
                Js.Dict.keys -> 
                Js.Array2.filter((val) => dest->Js.Array2.includes(val)) ->
                Js.Array2.reduce(
                    (obj, key) =>{
                        obj -> Js.Dict.set(key, Js.Dict.get(response["rates"], key))
                        obj
                    } 
                    , Js.Dict.empty()
                )        
        }
        callback(Some(result), None)
    })
    request->addEventListener("error", (error) => {
        Js.log("Error logging here")
        callback(None, Some(error))
    })    
    request->open_("GET", `https://api.exchangeratesapi.io/latest?base=USD&base=${src}`)
    request->send
}

