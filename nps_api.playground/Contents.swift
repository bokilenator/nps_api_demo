
import Foundation

let api_key = ""

//Data we're getting:
  //entranceFees
  //operatingHours
  //fullName
  //states
  //url
  //weatherInfo
  //image


// set search parameters
var search_state = "CA"
var search_park = ""
//search_park = "Yosemite" //uncomment to search by park name too

// create api url
let npsURL: NSURL = NSURL(string: "https://api.nps.gov/api/v1/parks?stateCode=\(search_state)&q=\(search_park)&api_key=\(api_key)&fields=fullName%2Cstates%2Curl%2CweatherInfo%2CoperatingHours%2CentranceFees%2Cimages")!

// collect data from api
let data = NSData(contentsOf: npsURL as URL)!
let swiftyjson = try JSON(data: data as Data)

print("Search Results:")

// print parks from api call
let total = swiftyjson["total"].int as! Int
for i in 0..<total {
  print("\n------------------------------------------------\n")
  let entrance_fees = swiftyjson["data"][i]["entranceFees"]
  let operating_hours = swiftyjson["data"][i]["operatingHours"][0]
  let full_name = swiftyjson["data"][i]["fullName"].string!
  let states = swiftyjson["data"][i]["states"].string!
  let coordinates = swiftyjson["data"][i]["latLong"].string!
  let url = swiftyjson["data"][i]["url"].string!
  let weatherInfo = swiftyjson["data"][i]["weatherInfo"].string!
  let image = swiftyjson["data"][i]["images"][0]["url"].string!
  
  print("Park name: \(full_name)")
  print("States: \(states)")
  print("URL: \(url)")
  print("Coordinates: \(coordinates)")
  print("\nEntrance fees:")
  print(entrance_fees)
  print("\nStandard hours:")
  print(operating_hours["standardHours"])
  print("\nExceptions:")
  print(operating_hours["exceptions"])
  print("\nWeather info:")
  print(weatherInfo)
  print("\nImage: \(image)")

}
