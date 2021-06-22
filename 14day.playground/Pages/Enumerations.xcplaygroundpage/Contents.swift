enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}

func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .cloud:
        return "dislike"
    case .rain:
        return "dislike"
    case .wind(let speed) where speed < 10:
        return "wind speed \(speed)"
    case .snow:
        return "love"
    default:
        return "default"
    }
    
}
getHaterStatus(weather: .wind(speed: 9))



