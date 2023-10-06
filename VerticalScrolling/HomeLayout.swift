//
//  HomeLayout.swift
//  VerticalScrolling
//
//  Created by Saikiran Panuganti on 01/10/23.
//

import Foundation

// MARK: - Welcome
struct HomeLayoutModel: Codable {
    let txRef: String
    let data: HomeLayoutData
}

// MARK: - WelcomeData
struct HomeLayoutData: Codable {
    let header, footer: Footer
    let sideMenu: SideMenu
    let content: HomeLayoutCarouselModel
}

// MARK: - PurpleContent
struct HomeLayoutCarouselModel: Codable {
    let carouselsV1: [HomeLayoutCarousel]

    enum CodingKeys: String, CodingKey {
        case carouselsV1 = "carousels_v1"
    }
}

// MARK: - CarouselsV1
struct HomeLayoutCarousel: Codable {
    let id, type: String
    let active, pagination, guestModeActive, newActive: Bool
    let feedType: String
    let dataSources: [String]?
    let mixpanelCarouselType: String?
    let mixpanelKey: String?
    let referrerType: ReferrerType?
    let autoSlider: Bool?
    let autoTrailer: [String]?
    let titleResourceKey: String?
    let maxItems: Int?
    let filters: [Filter]?
    let sortingOptions: [SortingOption]?
    let newType: String?
    let excludeForOperators: [String]?
    let data: CarouselsV1Data?

    enum CodingKeys: String, CodingKey {
        case id, type, active, pagination, guestModeActive, newActive, feedType, dataSources, mixpanelCarouselType, mixpanelKey, referrerType, autoSlider, autoTrailer
        case titleResourceKey = "title_resource_key"
        case maxItems, filters, sortingOptions
        case newType = "New_Type"
        case excludeForOperators, data
    }
}

// MARK: - CarouselsV1Data
struct CarouselsV1Data: Codable {
    let channelName, packageName, contentType: String?
    let showImageAsTitle: Bool?
    let content: [ContentElement]?
}

// MARK: - ContentElement
struct ContentElement: Codable {
    let subscriptionGUID: String?
    let imageUrls: [ImageURL]?
    let id, filterName: String?
    let type: TypeEnum?
    let titleResourceKey: String?
    let active: Bool?
    let backgroundImage: String?
    let backgroundImagePDF: String?
    let backgroundImageNew: String?
    let backgroundImagePDFNew: String?
    let dataSources: [String]?
    let sortingOptions: [SortingOption]?
    let filters: [Filter]?

    enum CodingKeys: String, CodingKey {
        case subscriptionGUID = "subscriptionGuid"
        case imageUrls, id, filterName, type
        case titleResourceKey = "title_resource_key"
        case active
        case backgroundImage = "background_image"
        case backgroundImagePDF = "background_image_pdf"
        case backgroundImageNew = "background_image_new"
        case backgroundImagePDFNew = "background_image_pdf_new"
        case dataSources, sortingOptions, filters
    }
}

// MARK: - Filter
struct Filter: Codable {
    let id, titleResourceKey: String
    let type: TypeEnum
    let filterName, mixpanelKey: String
    let active, pagination: Bool
    let dataSources: [String]
    let filterDefault: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case titleResourceKey = "title_resource_key"
        case type, filterName, mixpanelKey, active, pagination, dataSources
        case filterDefault = "default"
    }
}

enum TypeEnum: String, Codable {
    case category = "CATEGORY"
    case portrait = "PORTRAIT"
    case user = "USER"
}

// MARK: - ImageURL
struct ImageURL: Codable {
    let url: String
    let key: ImageURLKey
    let width, height: Int
}

enum ImageURLKey: String, Codable {
    case background = "background"
    case title = "title"
}

// MARK: - SortingOption
struct SortingOption: Codable {
    let key: SortingOptionKey
    let value: Value
    let sortingOptionDefault: Bool?
    let titleResourceKey: TitleResourceKey

    enum CodingKeys: String, CodingKey {
        case key, value
        case sortingOptionDefault = "default"
        case titleResourceKey = "title_resource_key"
    }
}

enum SortingOptionKey: String, Codable {
    case latest = "latest"
    case oldest = "oldest"
    case recentlyAdded = "recently_added"
    case title = "title"
}

enum TitleResourceKey: String, Codable {
    case sortingAToZ = "sorting_a_to_z"
    case sortingLatest = "sorting_latest"
    case sortingOldest = "sorting_oldest"
    case sortingRecently = "sorting_recently"
}

enum Value: String, Codable {
    case sortAddedDesc = "sort=added|desc"
    case sortTitle = "sort=title"
    case sortYearAsc = "sort=year|asc"
    case sortYearDesc = "sort=year|desc"
}

enum ReferrerType: String, Codable {
    case nA = "N/A"
}

// MARK: - Footer
struct Footer: Codable {
}

// MARK: - SideMenu
struct SideMenu: Codable {
    let show: Bool
}
