// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.js";
import * as Js_dict from "bs-platform/lib/es6/js_dict.js";
import * as Caml_option from "bs-platform/lib/es6/caml_option.js";

var days_in_year = 260;

var hours_in_year = (days_in_year << 3);

var supported_currency = [
  /* USD */0,
  /* INR */1
];

function durationToString(dur) {
  switch (dur) {
    case /* Daily */0 :
        return "Daily";
    case /* Hourly */1 :
        return "Hourly";
    case /* Weekly */2 :
        return "Weekly";
    case /* Monthly */3 :
        return "Monthly";
    case /* Yearly */4 :
        return "Yearly";
    
  }
}

function currencyToString(cur) {
  if (cur) {
    return "INR";
  } else {
    return "USD";
  }
}

function currencyToSymbol(cur) {
  if (cur) {
    return "\xe2\x82\xb9";
  } else {
    return "$";
  }
}

function converfromYearly(src, dest_type) {
  var divider;
  switch (dest_type) {
    case /* Daily */0 :
        divider = days_in_year;
        break;
    case /* Hourly */1 :
        divider = hours_in_year;
        break;
    case /* Weekly */2 :
        divider = 52;
        break;
    case /* Monthly */3 :
        divider = 12;
        break;
    case /* Yearly */4 :
        divider = 1;
        break;
    
  }
  return {
          value: src.value / divider,
          currency: src.currency,
          duration: dest_type
        };
}

function convertToYearly(src) {
  var match = src.duration;
  var multiplier;
  switch (match) {
    case /* Daily */0 :
        multiplier = days_in_year;
        break;
    case /* Hourly */1 :
        multiplier = hours_in_year;
        break;
    case /* Weekly */2 :
        multiplier = 52;
        break;
    case /* Monthly */3 :
        multiplier = 12;
        break;
    case /* Yearly */4 :
        multiplier = 1;
        break;
    
  }
  return {
          value: src.value * multiplier,
          currency: src.currency,
          duration: /* Yearly */4
        };
}

function fetchCurrencyExchangeRates(src, dest, callback) {
  var request = new XMLHttpRequest();
  request.addEventListener("load", (function (param) {
          var response = JSON.parse(request.response);
          var result = Object.keys(response.rates).filter(function (val) {
                  return dest.includes(val);
                }).reduce((function (obj, key) {
                  obj[key] = Js_dict.get(response.rates, key);
                  return obj;
                }), {});
          return Curry._2(callback, Caml_option.some(result), undefined);
        }));
  request.addEventListener("error", (function (error) {
          console.log("Error logging here");
          return Curry._2(callback, undefined, Caml_option.some(error));
        }));
  request.open("GET", "https://api.exchangeratesapi.io/latest?base=USD&base=" + src);
  request.send();
  
}

var months_in_year = 12;

var weeks_in_year = 52;

export {
  months_in_year ,
  weeks_in_year ,
  days_in_year ,
  hours_in_year ,
  supported_currency ,
  durationToString ,
  currencyToString ,
  currencyToSymbol ,
  converfromYearly ,
  convertToYearly ,
  fetchCurrencyExchangeRates ,
  
}
/* No side effect */