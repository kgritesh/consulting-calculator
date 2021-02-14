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


module CurrencyCmp = Belt.Id.MakeComparable({
    type t = currency
    let cmp = (a, b) => Pervasives.compare(a, b)
}) 

type currencyMapType = Belt.Map.t<CurrencyCmp.t, float, CurrencyCmp.identity> 

let makeCurrencyMap = () => Belt.Map.make(~id=module(CurrencyCmp))

let currencyRate: Belt.Map.t<CurrencyCmp.t, currencyMapType, CurrencyCmp.identity> = Belt.Map.fromArray(
    ~id=module(CurrencyCmp),
    supportedCurrencies -> Js.Array2.map(cur => (cur, makeCurrencyMap()))
)

let currencyRate = ref(currencyRate)

