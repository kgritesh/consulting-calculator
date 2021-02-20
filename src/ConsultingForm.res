open Models

type rec formValues = {
    amount: int,
    currency: currency,
    duration: duration,
    availability: int
}

type formFields = 
    | Amount
    | Currency
    | Duration
    | Availability

@react.component
let make = (~onSubmit: (consultingRate)=> unit)   => {   

    let (formValues, setFormValues) = React.useState(_ => {
        amount: 30,
        currency: USD,
        duration: Hourly,
        availability: 75
    })
    
    let formValToInt = (val) => int_of_string(
        if val == "" {
            "0"
        } else {
            val
        }
    )

    let updateFormValues = (field, event: ReactEvent.Form.t) => {
        let val = (event->ReactEvent.Form.target)["value"]
        switch field {
        | Amount => setFormValues(_prev => {...formValues, amount: formValToInt(val)})
        | Currency => setFormValues(_prev => {...formValues, currency: val -> Converter.currencyFromString})
        | Duration => setFormValues(_prev => {...formValues, duration: val -> Converter.durationFromString})
        | Availability => setFormValues(_prev => {...formValues, availability: formValToInt(val)})            
        }           
    }

    let submitHandler = (event) => {
        event -> ReactEvent.Form.preventDefault
        let consRate = {
            currency: formValues.currency,
            duration: formValues.duration,
            value: float_of_int(formValues.amount * formValues.availability) /. 100.0

        }
        onSubmit(consRate)
    }

    <div className="md:col-span-1">
      <form className="mx-auto w-full" onSubmit={submitHandler}>
        <label className="block font-medium text-gray-700"> {React.string("Rate")} </label>
        <div className="mt-2 relative rounded-md shadow-sm">
        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <span className="text-gray-500 sm:text-sm"> 
                {React.string(formValues.currency->Converter.currencyToSymbol)} 
            </span>
        </div>
        <input
            type_="number"
            name="price"
            id="price"
            onChange={updateFormValues(Amount)}                        
            value={string_of_int(formValues.amount)}
            className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md"
            placeholder="0.00"
        />
        <div className="absolute inset-y-0 right-0 flex items-center">
            <label className="sr-only"> {React.string("Currency")} </label>
            <select
                id="currency"
                name="currency"              
                value={formValues.currency->Converter.currencyToString}
                onChange={updateFormValues(Currency)}
                className="focus:ring-indigo-500 focus:border-indigo-500 h-full py-0 pl-2 
                           pr-7 border-transparent bg-transparent text-gray-500 sm:text-sm rounded-md">
                    {
                        supportedCurrencies -> Js.Array2.map(cur => {
                            <option key={Converter.currencyToString(cur)}> 
                                {React.string(Converter.currencyToString(cur))} 
                            </option>
                        }) -> React.array
                    }
            </select>
        </div>        
        </div>
        <div className="mt-4">
            <label className="block font-medium text-gray-700"> {React.string("Duration")} </label>
            <select
                id="duration"
                name="duration"
                onChange={updateFormValues(Duration)}                        
                value={Converter.durationToString(formValues.duration)}            
                className="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none 
                        focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                    {
                        supportedDurations -> Js.Array2.filter(
                            dur => dur != Yearly
                        )  -> Js.Array2.map(dur => {
                            <option key={Converter.durationToString(dur)}> 
                                {React.string(Converter.durationToString(dur))} 
                            </option>
                        }) -> React.array
                    }      
            </select>
            </div>
        <div className="mt-4">
            <label className="block font-medium text-gray-700"> {React.string("Availability")} </label>
            <div className="mt-2 relative rounded-md shadow-sm">                  
                <input
                    type_="number"
                    name="availability"
                    id="availability"
                    onChange={updateFormValues(Availability)}                        
                    value={string_of_int(formValues.availability)}                
                    className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-12 sm:text-sm border-gray-300 rounded-md"
                    placeholder="75"
                />        
                <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                    <span className="text-gray-500 sm:text-sm"> {React.string("%")} </span>
                </div>
            </div>
        </div>
        <button
        type_="submit"
        className="w-full py-3 mt-10 bg-gray-800 rounded-sm
            font-medium text-white uppercase
            focus:outline-none hover:bg-gray-700 hover:shadow-none">
        {React.string("Calculate")}
        </button>
      </form>          
    </div>
}