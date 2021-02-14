open Models

@react.component
let make = (~rate: consultingRate) => {
  let yearlyRate = rate -> Converter.convertToYearly
  Js.log2("Yearly Rate", yearlyRate)
  let (targetCurrency, setTargetCurrency) = React.useState(_ => USD)    
  let updateTargetCurrency = (event) => {
    let val = (event->ReactEvent.Form.target)["value"]
    setTargetCurrency(_prev => val -> Converter.currencyFromString)
  }
  let getRateForDuration = (dur) => {
    let durRate = Converter.converfromYearly(yearlyRate, dur)
    durRate.value
  } 

  <div className="md:col-span-1 h-full w-full">
    <div>
      <label className="block font-medium  text-gray-700"> {React.string("Currency")} </label>
      <select
        id="targetCurrency"
        name="targetCurrency"
        value={targetCurrency->Converter.currencyToString}
        onChange={updateTargetCurrency}
        className="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm 
                        focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 ">
          {
              supportedCurrencies -> Js.Array2.map(cur => {
                  <option key={Converter.currencyToString(cur)}> 
                      {React.string(Converter.currencyToString(cur))} 
                  </option>
              }) -> React.array
          }
      </select>
    </div>
    <React.Fragment>
      {
        supportedDurations -> Js.Array2.filter(
            dur => dur != rate.duration
        ) -> Js.Array2.map((dur) => {
          <div className="mt-2">
            <label className="block font-medium text-gray-700"> 
                {React.string(`${Converter.durationToString(dur)} Rate`)} 
            </label>
            <div className="mt-2 relative rounded-md shadow-sm">
              <input
                type_="number"
                name={dur->Converter.durationToString}
                key={{dur->Converter.durationToString}}
                disabled=true
                value={Js.Float.toFixedWithPrecision(dur -> getRateForDuration, ~digits=2)}
                className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-12 sm:text-sm border-gray-300 rounded-md"
              />
              <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                <span className="text-gray-500 sm:text-sm"> {React.string(targetCurrency -> Converter.currencyToSymbol)} </span>
              </div>
            </div>
          </div>          
        }) -> React.array
      }
    </React.Fragment>
  </div>
}
