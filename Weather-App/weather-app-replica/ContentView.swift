//
//  ContentView.swift
//  weather-app-replica
//
//  Created by Zayah Cortright on 9/27/25.
//

import SwiftUI

struct WeatherDay: Identifiable {
    let id = UUID()
    var day: String
    var conditionDay: String
    var low: Int
    var high: Int
}

struct WeatherHour: Identifiable {
    let id = UUID()
    var time: String
    var conditionHour: String
    var temp: Int
}

struct ContentView: View {
    @State private var backgroundColors: [[Color]] = [[.blue, .black], [.yellow, .red]]
    @State private var locations: [String] = ["Chapel Hill"]
    @State private var temperatures: [Int] = [75]
    
    // dummy weather values for now and the hours proceeding
    @State public var WeatherHours: [WeatherHour] = [
        WeatherHour(time: "Now", conditionHour: "sun.max.fill", temp: 54),
        WeatherHour(time: "1PM", conditionHour: "sun.max.fill", temp: 55),
        WeatherHour(time: "2PM", conditionHour: "sun.max.fill", temp: 57),
        WeatherHour(time: "3PM", conditionHour: "cloud.sun.fill", temp: 53),
        WeatherHour(time: "4PM", conditionHour: "sun.max.fill", temp: 55),
        WeatherHour(time: "5PM", conditionHour: "cloud.sun.fill", temp: 51),
        WeatherHour(time: "6PM", conditionHour: "cloud.sun.fill", temp: 49)
    ]
    
    // dummy weather values for the days (bottom)
    @State public var WeatherDays: [WeatherDay] = [
        WeatherDay(day: "Today", conditionDay: "cloud.fill", low: 45, high: 57),
        WeatherDay(day: "Mon", conditionDay: "sun.max.fill", low: 54, high: 70),
        WeatherDay(day: "Tue", conditionDay: "cloud.rain.fill", low: 43, high: 52),
        WeatherDay(day: "Wed", conditionDay: "cloud.fill", low: 33, high: 45),
        WeatherDay(day: "Thu", conditionDay: "sun.max.fill", low: 28, high: 32),
        WeatherDay(day: "Fri", conditionDay: "cloud.fill", low: 25, high: 33),
        WeatherDay(day: "Sat", conditionDay: "snow", low: 23, high: 30)
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: backgroundColors[0], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
                        
            VStack {
                Text(locations[0])
                    .foregroundColor(.white)
                    .font(.system(size: 50))
                
                Text("\(WeatherHours[0].temp)°")
                    .foregroundColor(.white)
                    .font(.system(size: 100))
                
                Text("Sunny")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("H:\(WeatherDays[0].high)° L:\(WeatherDays[0].low)°")
                    .foregroundColor(.white.opacity(0.9))
                    .font(.system(size: 18))
                    .padding(.bottom, 40)
                
                Spacer()
                
                HourlySection(WeatherHours: $WeatherHours)
                
                DailySection(WeatherDays: $WeatherDays)
            }
            .padding(.top, 100)
        }
    }
}

#Preview {
    ContentView()
}

struct HourlySection: View {
    @Binding var WeatherHours: [WeatherHour]
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("Hourly Forecast", systemImage: "clock")
                .foregroundColor(.white.opacity(0.9))
                .font(.system(size: 15, weight: .semibold))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(WeatherHours) { hour in
                        VStack(spacing: 10) {
                            Text(hour.time)
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                            
                            Image(systemName: hour.conditionHour)
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 20))
                            
                            Text("\(hour.temp)°")
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}
    

struct DailySection: View {
    @Binding var WeatherDays: [WeatherDay]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("7-Day Forecast", systemImage: "calendar")
                .foregroundColor(.white.opacity(0.9))
                .font(.system(size: 15, weight: .semibold))
            
            ForEach(WeatherDays) { day in
                HStack {
                    Text(day.day)
                        .foregroundColor(.white)
                        .frame(width: 70, alignment: .leading)
                    
                    Image(systemName: day.conditionDay)
                        .symbolRenderingMode(.multicolor)
                        .frame(width: 25)
                    
                    Spacer()
                    
                    Text("\(day.low)°")
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 40, alignment: .trailing)
                    
                    // temp bar / placeholder for a gradient... out of time
                    Rectangle()
                        .fill(.white.opacity(0.25))
                        .frame(width: 120, height: 4)
                        .cornerRadius(2)
                    
                    Text("\(day.high)°")
                        .foregroundColor(.white.opacity(0.9))
                        .frame(width: 40, alignment: .leading)
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}
