type request
type response
@bs.new external makeXMLHttpRequest: unit => request = "XMLHttpRequest"
@bs.send external addEventListener: (request, string, unit => unit) => unit = "addEventListener"
@bs.get external response: request => response = "response"
@bs.send external open_: (request, string, string) => unit = "open"
@bs.send external send: request => unit = "send"
@bs.send external abort: request => unit = "abort"