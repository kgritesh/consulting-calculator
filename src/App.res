open Models

@react.component
let make = ()   => {   
  let (rate, setRate) = React.useState(_ => {
    value: float_of_int(0),
    currency: USD,
    duration: Hourly
  })  

  let onSubmit = (values: consultingRate) => {
    setRate(_prev =>values)
  }

  <div className="bg-blue-50 w-full flex justify-center items-center py-8 h-screen">
    <div
      className="w-11/12 p-12 sm:w-8/12 md:w-6/12 lg:w-1/2  
        mx-auto py-10 bg-white flex-col justify-center items-center rounded-3xl shadow hover:shadow-md duration-4 min-h-1/2">
      <header className="flex flex-column justify-center self-center h-24">
        <h2 className="p-2.5 text-blue-500 text-3xl"> {React.string("Rate Calculator")} </h2>
      </header>
      <div className="md:grid md:grid-cols-2 md:gap-12">
        <ConsultingForm onSubmit={onSubmit} />
        <ConsultingRates rate={rate}  />
      </div>
    </div>
  </div>
}
