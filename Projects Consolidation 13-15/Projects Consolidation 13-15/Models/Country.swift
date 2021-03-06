//
//  Country.swift
//  Projects Consolidation 13-15
//
//  Created by JEONGSEOB HONG on 2021/08/06.
//

import Foundation

// MARK: - CountryElement
struct Country: Codable {
    let name: String
    let topLevelDomain: [String]
    let alpha2Code, alpha3Code: String
    let callingCodes: [String]
    let capital: String
    let altSpellings: [String]
    let region: Region
    let subregion: String
    let population: Int
    let latlng: [Double]
    let demonym: String
    let area, gini: Double?
    let timezones, borders: [String]
    let nativeName: String
    let numericCode: String?
    let currencies: [Currency]
    let languages: [Language]
    let translations: Translations
    let flag: String
    let regionalBlocs: [RegionalBloc]
    let cioc: String?
}

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

// MARK: - Language
struct Language: Codable {
    let iso6391: String?
    let iso6392, name, nativeName: String

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

enum Region: String, Codable {
    case africa = "Africa"
    case americas = "Americas"
    case asia = "Asia"
    case empty = ""
    case europe = "Europe"
    case oceania = "Oceania"
    case polar = "Polar"
}

// MARK: - RegionalBloc
struct RegionalBloc: Codable {
    let acronym: Acronym
    let name: Name
    let otherAcronyms: [OtherAcronym]
    let otherNames: [OtherName]
}

enum Acronym: String, Codable {
    case al = "AL"
    case asean = "ASEAN"
    case au = "AU"
    case cais = "CAIS"
    case caricom = "CARICOM"
    case cefta = "CEFTA"
    case eeu = "EEU"
    case efta = "EFTA"
    case eu = "EU"
    case nafta = "NAFTA"
    case pa = "PA"
    case saarc = "SAARC"
    case usan = "USAN"
}

enum Name: String, Codable {
    case africanUnion = "African Union"
    case arabLeague = "Arab League"
    case associationOfSoutheastAsianNations = "Association of Southeast Asian Nations"
    case caribbeanCommunity = "Caribbean Community"
    case centralAmericanIntegrationSystem = "Central American Integration System"
    case centralEuropeanFreeTradeAgreement = "Central European Free Trade Agreement"
    case eurasianEconomicUnion = "Eurasian Economic Union"
    case europeanFreeTradeAssociation = "European Free Trade Association"
    case europeanUnion = "European Union"
    case northAmericanFreeTradeAgreement = "North American Free Trade Agreement"
    case pacificAlliance = "Pacific Alliance"
    case southAsianAssociationForRegionalCooperation = "South Asian Association for Regional Cooperation"
    case unionOfSouthAmericanNations = "Union of South American Nations"
}

enum OtherAcronym: String, Codable {
    case eaeu = "EAEU"
    case sica = "SICA"
    case unasul = "UNASUL"
    case unasur = "UNASUR"
    case uzan = "UZAN"
}

enum OtherName: String, Codable {
    case accordDeLibre??changeNordAm??ricain = "Accord de Libre-??change Nord-Am??ricain"
    case alianzaDelPac??fico = "Alianza del Pac??fico"
    case caribischeGemeenschap = "Caribische Gemeenschap"
    case communaut??Carib??enne = "Communaut?? Carib??enne"
    case comunidadDelCaribe = "Comunidad del Caribe"
    case j??miAtAdDuwalAlArab??yah = "J??mi??at ad-Duwal al-??Arab??yah"
    case leagueOfArabStates = "League of Arab States"
    case sistemaDeLaIntegraci??nCentroamericana = "Sistema de la Integraci??n Centroamericana,"
    case southAmericanUnion = "South American Union"
    case tratadoDeLibreComercioDeAm??ricaDelNorte = "Tratado de Libre Comercio de Am??rica del Norte"
    case umojaWaAfrika = "Umoja wa Afrika"
    case unieVanZuidAmerikaanseNaties = "Unie van Zuid-Amerikaanse Naties"
    case unionAfricaine = "Union africaine"
    case uni??oAfricana = "Uni??o Africana"
    case uni??oDeNa????esSulAmericanas = "Uni??o de Na????es Sul-Americanas"
    case uni??nAfricana = "Uni??n Africana"
    case uni??nDeNacionesSuramericanas = "Uni??n de Naciones Suramericanas"
    case ?????????????????????????????? = "?????????????? ????????????????"
    case ?????????????????????????????????? = "?????????? ?????????? ??????????????"
}

// MARK: - Translations
struct Translations: Codable {
    let de, es, fr, ja: String?
    let it: String?
    let br, pt: String
    let nl, hr: String?
    let fa: String
}


