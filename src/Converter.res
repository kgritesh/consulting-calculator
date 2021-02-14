
open Models


let months_in_year = 12
let weeks_in_year = 52
let days_in_year = weeks_in_year * 5
let hours_in_year = days_in_year * 8
let supported_currency = [USD, INR]

exception NotFound(string)

let durationToString = (dur) => {
    switch dur {
       | Daily => "Daily"
       | Hourly => "Hourly"
       | Weekly => "Weekly"
       | Monthly => "Monthly"
       | Yearly => "Yearly"
   }
}

let durationFromString = (dur) => {
    switch dur {
    | "Daily" => Daily
    | "Hourly" => Hourly
    | "Weekly" => Weekly
    | "Monthly" => Monthly
    | "Yearly" => Yearly
    | _ => raise(NotFound(`No matching duration found: ${dur}`))
    }
}

let currencyToString = (cur) => {
    switch  cur {
    | USD => "USD"
    | INR => "INR"
    }
}

let currencyFromString = (cur) => {
    switch cur {
    | "USD" => USD
    | "INR" => INR
    | _ => raise(NotFound(`No matching currency found: ${cur}`))
    }
}


let currencyToSymbol = (cur) => {
    switch  cur {
    | USD => "$"
    | INR => j`₹`
    }
}

let converfromYearly = (src: consultingRate, targetDuration: duration) => {
   let divider = switch targetDuration {
    | Hourly => hours_in_year   
    | Daily => days_in_year
    | Weekly => weeks_in_year
    | Monthly => months_in_year
    | Yearly => 1
   } 
   {value: src.value /. float_of_int(divider), currency: src.currency, duration: targetDuration}
}  

let convertToYearly = (src: consultingRate) => {
    let multiplier = switch  src.duration {
    | Hourly => hours_in_year   
    | Daily => days_in_year
    | Weekly => weeks_in_year
    | Monthly => months_in_year
    | Yearly => 1
    }
    {value: src.value *. float_of_int(multiplier), currency: src.currency, duration: Yearly}
}

let getCurrencyMap = (rateMapping: Js.Dict.t<float>) => {
    let currencyMap = makeCurrencyMap()
    rateMapping -> Js.Dict.entries -> Js.Array2.reduce(
        (currencyMap, (k, v)) =>  {
            switch(currencyFromString(k)) {
            | cur => Belt.Map.set(currencyMap, cur, v)
            | exception _ => currencyMap 
            }
            
        }, currencyMap
    )
}



let fetchExchangeRates =  (srcCurrency: currency, ~callback) => {
    let curStr = currencyToString(srcCurrency)
    ExchangeRates.fetch(~src=curStr, ~callback=(rates, error) => {
        switch error {
        | None => callback(getCurrencyMap(rates), None)
        | Some(err) =>  callback(makeCurrencyMap(), Some(err))
        }        
    })
}

let getExchangeRate = (srcCurrency: currency, targetCurrency: currency, ~callback) => {

    switch Belt.Map.get(currencyRate.contents, srcCurrency) {
        | None => {
            Js.log(`Currency Map doestn have ${srcCurrency -> currencyToString}, Fetching`)
            fetchExchangeRates(srcCurrency, ~callback=(currencyMap, err) => {
                switch err {
                    | Some (err) => callback(-1.0, Some(err))
                    | None => {
                        currencyRate.contents = Belt.Map.set(currencyRate.contents, srcCurrency, currencyMap)
                        let exchangeRate = currencyMap -> Belt.Map.get(targetCurrency)->Belt.Option.getExn                   
                        callback(exchangeRate, None)                    
                    }     
                }
            })
        }
        | Some(currencyMap) => {
            let exchangeRate = currencyMap -> Belt.Map.get(targetCurrency)->Belt.Option.getExn                                
            callback(exchangeRate, None)
        }
    }
}



/* @bs.scope("JSON") @bs.val
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

 */