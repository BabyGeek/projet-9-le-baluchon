//
//  WeatherUnitTests.swift
//  LeBaluchonTests
//
//  Created by Paul Oggero on 19/07/2022.
//

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
        XCTAssertNil(viewModel.error)
        XCTAssertTrue(viewModel.favorites.isEmpty)
    }

    func testGivenWeatherWhenFetchingWeatherThenModelShouldBe30AtToulonAndImageCloudSun() throws {
        let url = Bundle.main.url(forResource: "weather", withExtension: "json")!
        let expectation = XCTestExpectation()

        viewModel.loadData(urlRequest: url) { (weather: Weather) in
            XCTAssertEqual(weather.main.temp, 30)
            XCTAssertEqual(weather.name, "Toulon")
            XCTAssertEqual(weather.weather.first!.symbol, Image(systemName: "cloud.sun"))
            expectation.fulfill()
        } onFailure: { _ in
            //
        }

        wait(for: [expectation], timeout: 3)
    }

    func testGivenWeatherWhenFetchingOtherWeatherThenModelShouldBe34AtLongXuyenAndImageSun() throws {
        let url = Bundle.main.url(forResource: "other-weather", withExtension: "json")!
        let expectation = XCTestExpectation()

        viewModel.loadData(urlRequest: url) { (weather: Weather) in
            XCTAssertEqual(weather.main.temp, 34)
            XCTAssertEqual(weather.name, "Long Xuyen")
            XCTAssertEqual(weather.weather.first!.symbol, Image(systemName: "sun.max"))
            expectation.fulfill()
        } onFailure: { _ in
            //
        }

        wait(for: [expectation], timeout: 3)
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

    func testGivenWeatherMainObjectWhenInitializeWithValuesThenGetTempShouldReturnMeasurementStringWithValueCalled() {
        let weather = WeatherMain(temp: 33.8, tempMin: 25.7, tempMax: 42, pressure: 200, humidity: 90)

        XCTAssertEqual(weather.getTemp(type: .temp),
                       MeasurementFormatter().string(from:
                                                        Measurement(value: weather.temp,
                                                                    unit: UnitTemperature.celsius)))
        XCTAssertEqual(weather.getTemp(type: .tempMax),
                       MeasurementFormatter().string(from:
                                                        Measurement(value: weather.tempMax,
                                                                    unit: UnitTemperature.celsius)))
        XCTAssertEqual(weather.getTemp(type: .tempMin),
                       MeasurementFormatter().string(from:
                                                        Measurement(value: weather.tempMin,
                                                                    unit: UnitTemperature.celsius)))
    }
}
