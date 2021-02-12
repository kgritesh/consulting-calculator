%%raw(`import './App.css';`)

@module("./logo.svg") external logo: string = "default"

@react.component
let make = ()   => {   
  let callback = (rates, error) => {
    Js.log2(rates, error)
  }

  Converter.fetchCurrencyExchangeRates(~callback, "USD", ["INR"]) 
  <div className="bg-blue-50 w-full flex justify-center items-center py-8 h-screen">
    <div
      className="w-11/12 p-12 sm:w-8/12 md:w-6/12 lg:w-1/2  
        mx-auto py-10 bg-white flex-col justify-center items-center rounded-3xl shadow hover:shadow-md duration-4 min-h-1/2">
      <header className="flex flex-column justify-center self-center h-24">
        <h2 className="p-2.5 text-blue-500 text-3xl"> {React.string("Rate Calculator")} </h2>
      </header>
      <div className="md:grid md:grid-cols-2 md:gap-12">
        <div className="md:col-span-1">
          <form className="mx-auto w-full">
            <label className="block font-medium text-gray-700"> {React.string("Rate")} </label>
            <div className="mt-2 relative rounded-md shadow-sm">
              <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                <span className="text-gray-500 sm:text-sm"> {React.string("$")} </span>
              </div>
              <input
                type_="text"
                name="price"
                id="price"
                className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md"
                placeholder="0.00"
              />
              <div className="absolute inset-y-0 right-0 flex items-center">
                <label className="sr-only"> {React.string("Currency")} </label>
                <select
                  id="currency"
                  name="currency"
                  className="focus:ring-indigo-500 focus:border-indigo-500 h-full py-0 pl-2 pr-7 border-transparent bg-transparent text-gray-500 sm:text-sm rounded-md">
                  <option> {React.string("USD")} </option> <option> {React.string("INR")} </option>
                </select>
              </div>        
            </div>
            <div className="mt-4">
              <label className="block font-medium text-gray-700"> {React.string("Duration")} </label>
              <select
                id="duration"
                name="duration"
                className="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                <option> {React.string("Hourly")} </option> 
                <option> {React.string("Daily")} </option>
                <option> {React.string("Weekly")} </option>
                <option> {React.string("Monthly")} </option>
                <option> {React.string("Yearly")} </option>
              </select>
            </div>
            <div className="mt-4">
              <label className="block font-medium text-gray-700"> {React.string("Availability")} </label>
              <div className="mt-2 relative rounded-md shadow-sm">                  
                <input
                  type_="number"
                  name="availability"
                  id="availability"
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
        <div className="md:col-span-1 h-full w-full">
          <div>
            <label className="block font-medium  text-gray-700"> {React.string("Currency")} </label>
            <select
              id="dest_currency"
              name="dest_currency"
              className="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm 
                        focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 "
            >
              <option> {React.string("USD")} </option> <option> {React.string("INR")} </option>
            </select>
          </div>
          <div className="mt-2">
            <label className="block font-medium text-gray-700"> {React.string("Daily Rate")} </label>
            <div className="mt-2 relative rounded-md shadow-sm">                  
              <input
                type_="number"
                name="availability"
                id="availability"
                className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-12 sm:text-sm border-gray-300 rounded-md"
              />        
              <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                <span className="text-gray-500 sm:text-sm"> {React.string("$")} </span>
              </div>
            </div>
          </div>
          <div className="mt-2">
            <label className="block font-medium text-gray-700"> {React.string("Daily Rate")} </label>
            <div className="mt-2 relative rounded-md shadow-sm">                  
              <input
                type_="number"
                name="availability"
                id="availability"
                className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-12 sm:text-sm border-gray-300 rounded-md"
              />        
              <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                <span className="text-gray-500 sm:text-sm"> {React.string("$")} </span>
              </div>
            </div>
          </div>
          <div className="mt-2">
            <label className="block font-medium text-gray-700"> {React.string("Daily Rate")} </label>
            <div className="mt-2 relative rounded-md shadow-sm">                  
              <input
                type_="number"
                name="availability"
                id="availability"
                className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-12 sm:text-sm border-gray-300 rounded-md"
              />        
              <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                <span className="text-gray-500 sm:text-sm"> {React.string("$")} </span>
              </div>
            </div>
          </div>
          <div className="mt-2">
            <label className="block font-medium text-gray-700"> {React.string("Daily Rate")} </label>
            <div className="mt-2 relative rounded-md shadow-sm">                  
              <input
                type_="number"
                name="availability"
                id="availability"
                className="focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-12 sm:text-sm border-gray-300 rounded-md"
              />        
              <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none">
                <span className="text-gray-500 sm:text-sm"> {React.string("$")} </span>
              </div>
            </div>
          </div>                    
        </div>
      </div>
    </div>
  </div>
}
