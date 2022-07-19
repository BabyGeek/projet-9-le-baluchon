//
//  WeatherUnitTests.swift
//  LeBaluchonTests
//
//  Created by Paul Oggero on 19/07/2022.
//

@testable import LeBaluchon
import SwiftUI
import XCTest


class WeatherUnitTests: XCTestCase {
    var viewModel: WeatherViewModel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = WeatherViewModel()
    }

    func testGivenNewWhenCheckingShouldBeNilOrEmpty() throws {
        XCTAssertNil(viewModel.target)
        XCTAssertTrue(viewModel.favorites.isEmpty)
    }
    
    func testGivenWeatherWhenFetchingWeatherThenModelShouldBe30AtToulonAndImageCloudSun() throws {
        let url = Bundle.main.url(forResource: "weather", withExtension: "json")!

        viewModel.loadData(urlRequest: url) { (weather: Weather) in
            XCTAssertEqual(weather.main.temp, 30)
            XCTAssertEqual(weather.name, "Toulon")
            XCTAssertEqual(weather.weather.first!.symbol, Image(systemName: "cloud.sun"))
        } onFailure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenWeatherWhenFetchingOtherWeatherThenModelShouldBe34AtLongXuyenAndImageSun() throws {
        let url = Bundle.main.url(forResource: "other-weather", withExtension: "json")!

        viewModel.loadData(urlRequest: url) { (weather: Weather) in
            XCTAssertEqual(weather.main.temp, 34)
            XCTAssertEqual(weather.name, "Long Xuyen")
            XCTAssertEqual(weather.weather.first!.symbol, Image(systemName: "sun.max"))
        } onFailure: { error in
            XCTAssertNil(error)
        }
    }
    
    func testGivenArrayOfWeatherTypeIdsWhenGoingThoughtThenGetAllSymbolsPossibilities() {
        let ids = [201: Image(systemName: "cloud.bolt"),
                   301: Image(systemName: "cloud.drizzle"),
                   501: Image(systemName: "cloud.rain"),
                   601: Image(systemName: "cloud.snow"),
                   701: Image(systemName: "cloud.fog"),
                   800: Image(systemName: "sun.max"),
                   802: Image(systemName: "cloud"),
                   900: Image(systemName: "cloud.sun")]
        
        for (key, value) in ids {
            let weatherType = WeatherType(id: key, main: "test", description: "test", icon: "test")
            XCTAssertEqual(weatherType.symbol, value)
            
        }
    }
}