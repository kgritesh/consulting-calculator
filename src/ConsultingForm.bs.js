// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as React from "react";
import * as Models from "./Models.bs.js";
import * as Converter from "./Converter.bs.js";
import * as Caml_format from "bs-platform/lib/es6/caml_format.js";

function ConsultingForm(Props) {
  var onSubmit = Props.onSubmit;
  var match = React.useState(function () {
        return {
                amount: 30,
                currency: /* USD */0,
                duration: /* Hourly */0,
                availability: 75
              };
      });
  var setFormValues = match[1];
  var formValues = match[0];
  var formValToInt = function (val) {
    return Caml_format.caml_int_of_string(val === "" ? "0" : val);
  };
  var updateFormValues = function (field, $$event) {
    var val = $$event.target.value;
    switch (field) {
      case /* Amount */0 :
          return Curry._1(setFormValues, (function (_prev) {
                        return {
                                amount: formValToInt(val),
                                currency: formValues.currency,
                                duration: formValues.duration,
                                availability: formValues.availability
                              };
                      }));
      case /* Currency */1 :
          return Curry._1(setFormValues, (function (_prev) {
                        return {
                                amount: formValues.amount,
                                currency: Converter.currencyFromString(val),
                                duration: formValues.duration,
                                availability: formValues.availability
                              };
                      }));
      case /* Duration */2 :
          return Curry._1(setFormValues, (function (_prev) {
                        return {
                                amount: formValues.amount,
                                currency: formValues.currency,
                                duration: Converter.durationFromString(val),
                                availability: formValues.availability
                              };
                      }));
      case /* Availability */3 :
          return Curry._1(setFormValues, (function (_prev) {
                        return {
                                amount: formValues.amount,
                                currency: formValues.currency,
                                duration: formValues.duration,
                                availability: formValToInt(val)
                              };
                      }));
      
    }
  };
  var submitHandler = function ($$event) {
    $$event.preventDefault();
    return Curry._1(onSubmit, {
                value: Math.imul(formValues.amount, formValues.availability) / 100.0,
                currency: formValues.currency,
                duration: formValues.duration
              });
  };
  return React.createElement("div", {
              className: "md:col-span-1"
            }, React.createElement("form", {
                  className: "mx-auto w-full",
                  onSubmit: submitHandler
                }, React.createElement("label", {
                      className: "block font-medium text-gray-700"
                    }, "Rate"), React.createElement("div", {
                      className: "mt-2 relative rounded-md shadow-sm"
                    }, React.createElement("div", {
                          className: "absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none"
                        }, React.createElement("span", {
                              className: "text-gray-500 sm:text-sm"
                            }, Converter.currencyToSymbol(formValues.currency))), React.createElement("input", {
                          className: "focus:ring-indigo-500 focus:border-indigo-500 block w-full pl-7 pr-12 sm:text-sm border-gray-300 rounded-md",
                          id: "price",
                          name: "price",
                          placeholder: "0.00",
                          type: "number",
                          value: String(formValues.amount),
                          onChange: (function (param) {
                              return updateFormValues(/* Amount */0, param);
                            })
                        }), React.createElement("div", {
                          className: "absolute inset-y-0 right-0 flex items-center"
                        }, React.createElement("label", {
                              className: "sr-only"
                            }, "Currency"), React.createElement("select", {
                              className: "focus:ring-indigo-500 focus:border-indigo-500 h-full py-0 pl-2 \n                           pr-7 border-transparent bg-transparent text-gray-500 sm:text-sm rounded-md",
                              id: "currency",
                              name: "currency",
                              value: Converter.currencyToString(formValues.currency),
                              onChange: (function (param) {
                                  return updateFormValues(/* Currency */1, param);
                                })
                            }, Models.supportedCurrencies.map(function (cur) {
                                  return React.createElement("option", {
                                              key: Converter.currencyToString(cur)
                                            }, Converter.currencyToString(cur));
                                })))), React.createElement("div", {
                      className: "mt-4"
                    }, React.createElement("label", {
                          className: "block font-medium text-gray-700"
                        }, "Duration"), React.createElement("select", {
                          className: "mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none \n                        focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm",
                          id: "duration",
                          name: "duration",
                          value: Converter.durationToString(formValues.duration),
                          onChange: (function (param) {
                              return updateFormValues(/* Duration */2, param);
                            })
                        }, Models.supportedDurations.filter(function (dur) {
                                return dur !== /* Yearly */4;
                              }).map(function (dur) {
                              return React.createElement("option", {
                                          key: Converter.durationToString(dur)
                                        }, Converter.durationToString(dur));
                            }))), React.createElement("div", {
                      className: "mt-4"
                    }, React.createElement("label", {
                          className: "block font-medium text-gray-700"
                        }, "Availability"), React.createElement("div", {
                          className: "mt-2 relative rounded-md shadow-sm"
                        }, React.createElement("input", {
                              className: "focus:ring-indigo-500 focus:border-indigo-500 block w-full pr-12 sm:text-sm border-gray-300 rounded-md",
                              id: "availability",
                              name: "availability",
                              placeholder: "75",
                              type: "number",
                              value: String(formValues.availability),
                              onChange: (function (param) {
                                  return updateFormValues(/* Availability */3, param);
                                })
                            }), React.createElement("div", {
                              className: "absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none"
                            }, React.createElement("span", {
                                  className: "text-gray-500 sm:text-sm"
                                }, "%")))), React.createElement("button", {
                      className: "w-full py-3 mt-10 bg-gray-800 rounded-sm\n            font-medium text-white uppercase\n            focus:outline-none hover:bg-gray-700 hover:shadow-none",
                      type: "submit"
                    }, "Calculate")));
}

var make = ConsultingForm;

export {
  make ,
  
}
/* react Not a pure module */
