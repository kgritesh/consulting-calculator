open XMLHttpRequest

type latestRatesResponse = {
    rates: Js.Dict.t<float>
}

@bs.scope("JSON") @bs.val
external parseResponse: response => latestRatesResponse = "parse"

@bs.scope("localStorage") @bs.val
external setItem : (string, option<string>) => unit = "setItem"

@bs.scope("localStorage") @bs.val
external getItem : (string) => Js.Nullable.t<string> = "getItem"


let getRatesFromCache = (src) => {
    let result = Js.Nullable.toOption(getItem(src))
    switch result {
    | None => None
    | Some(val) => Some(parseResponse(val))
    }
}

let saveRatesCache = (src: string, rates: latestRatesResponse) => {
    let rateStr = Js.Json.stringifyAny(rates)    
    setItem(src, rateStr)
}


let fetch = (~src: string, ~callback) => {     
    switch getRatesFromCache(src) {
    | Some(rateResponse) => callback(rateResponse.rates, None)
    | None => {
        let request = makeXMLHttpRequest()
    
        request->addEventListener("load", () => {
            let response = request->response->parseResponse
            callback(response.rates, None)
        })
        request->addEventListener("error", (error) => {
            callback(Js.Dict.empty(), Some(error))
        })    

        request->open_("GET", `https://api.exchangeratesapi.io/latest?base=${src}`)
        request->send
    }
    }
}