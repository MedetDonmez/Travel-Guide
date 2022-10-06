// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation
import UIKit


struct HotelCellViewModel {
    var name: String
    var desc: String
    var imageURL: String?
    var details: String?
}

// MARK: - Hotels
struct Hotels: Decodable {
    let result: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    let body: Body?
    let common: Common?
}

// MARK: - Body
struct Body: Decodable {
    let header: String?
    let query: Query?
    let searchResults: SearchResults?
    let sortResults: SortResults?
    let filters: Filters?
    let pointOfSale: BodyPointOfSale?
    let miscellaneous: Miscellaneous?
    let pageInfo: PageInfo?
}

// MARK: - Filters
struct Filters: Decodable {
    let applied: Bool?
    let name: Name?
    let starRating: StarRating?
    let guestRating: GuestRating?
    let landmarks: Landmarks?
    let neighbourhood, accommodationType, facilities, accessibility: Accessibility?
    let themesAndTypes: Accessibility?
    let price: FiltersPrice?
    let paymentPreference: PaymentPreference?
    let welcomeRewards: WelcomeRewards?
}

// MARK: - Accessibility
struct Accessibility: Decodable {
    let applied: Bool?
    let items: [AccessibilityItem]?
}

// MARK: - AccessibilityItem
struct AccessibilityItem: Decodable {
    let label, value: String?
}

// MARK: - GuestRating
struct GuestRating: Decodable {
    let range: GuestRatingRange?
}

// MARK: - GuestRatingRange
struct GuestRatingRange: Decodable {
    let min, max: Max?
}

// MARK: - Max
struct Max: Decodable {
    let defaultValue: Int?
}

// MARK: - Landmarks
struct Landmarks: Decodable {
    let selectedOrder: [String?]?
    let items: [AccessibilityItem]?
    let distance: [Int?]?
}

// MARK: - Name
struct Name: Decodable {
    let item: NameItem?
    let autosuggest: Autosuggest?
}

// MARK: - Autosuggest
struct Autosuggest: Decodable {
    let additionalURLParams: AdditionalURLParams?
}

// MARK: - AdditionalURLParams
struct AdditionalURLParams: Decodable {
    let resolvedLocation, qDestination, destinationID: String?
}

// MARK: - NameItem
struct NameItem: Decodable {
    let value: String?
}

// MARK: - PaymentPreference
struct PaymentPreference: Decodable {
    let items: [AccessibilityItem]?
}

// MARK: - FiltersPrice
struct FiltersPrice: Decodable {
    let label: String?
    let range: PriceRange?
    let multiplier: Int?
}

// MARK: - PriceRange
struct PriceRange: Decodable {
    let min, max: Max?
    let increments: Int?
}

// MARK: - StarRating
struct StarRating: Decodable {
    let applied: Bool?
    let items: [StarRatingItem]?
}

// MARK: - StarRatingItem
struct StarRatingItem: Decodable {
    let value: Int?
}

// MARK: - WelcomeRewards
struct WelcomeRewards: Decodable {
    let label: String?
    let items: [AccessibilityItem]?
}

// MARK: - Miscellaneous
struct Miscellaneous: Decodable {
    let pageViewBeaconURL: String?
    let showLegalInfoForStrikethroughPrices: Bool?
    let legalInfoForStrikethroughPrices: String?
}

// MARK: - PageInfo
struct PageInfo: Decodable {
    let pageType: String?
}

// MARK: - BodyPointOfSale
struct BodyPointOfSale: Decodable {
    let currency: Currency?
}

// MARK: - Currency
struct Currency: Decodable {
    let code, symbol, separators, format: String?
}

// MARK: - Query
struct Query: Decodable {
    let destination: Destination?
}

// MARK: - Destination
struct Destination: Decodable {
    let id, value, resolvedLocation: String?
}

// MARK: - SearchResults
struct SearchResults: Decodable {
    let totalCount: Int?
    let results: [Result]?
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Decodable {
    let currentPage: Int?
    let pageGroup: String?
    let nextPageStartIndex, nextPageNumber: Int?
    let nextPageGroup: String?
}

// MARK: - Result
struct Result: Decodable {
    let id: Int?
    let name: String?
    let starRating: Double?
    let urls: Badging?
    let address: Address?
    let guestReviews: GuestReviews?
    let landmarks: [Landmark]?
    let geoBullets: [String?]?
    let ratePlan: RatePlan?
    let neighbourhood: String?
    let deals, messaging, badging: Badging?
    let pimmsAttributes: String?
    let coordinate: Coordinate?
    let providerType: String?
    let supplierHotelID: Int?
    let vrBadge: String?
    let isAlternative: Bool?
    let optimizedThumbUrls: OptimizedThumbUrls?
}

// MARK: - Address
struct Address: Decodable {
    let streetAddress, extendedAddress, locality, postalCode: String?
    let region: String?
    let countryName: String?
    let countryCode: String?
    let obfuscate: Bool?
}

// MARK: - Badging
struct Badging: Decodable {
}

// MARK: - Coordinate
struct Coordinate: Decodable {
    let lat, lon: Double?
}

// MARK: - GuestReviews
struct GuestReviews: Decodable {
    let unformattedRating: Double?
    let rating: String?
    let total, scale: Int?
    let badge, badgeText: String?
}

// MARK: - Landmark
struct Landmark: Decodable {
    let label: String?
    let distance: String?
}

enum Label: Decodable {
    case cityCenter
    case timesSquare
}

// MARK: - OptimizedThumbUrls
struct OptimizedThumbUrls: Decodable {
    let srpDesktop: String?
}

//enum ProviderType: Decodable {
//    case local
//    case multisource
//}

// MARK: - RatePlan
struct RatePlan: Decodable {
    let price: RatePlanPrice?
    let features: Features?
}

// MARK: - Features
struct Features: Decodable {
    let paymentPreference, noCCRequired: Bool?
}

// MARK: - RatePlanPrice
struct RatePlanPrice: Decodable {
    let current: String?
    let exactCurrent: Double?
    let old: String?
}

// MARK: - SortResults
struct SortResults: Decodable {
    let options: [Option]?
    let distanceOptionLandmarkID: Int?
}

// MARK: - Option
struct Option: Decodable {
    let label, itemMeta: String?
    let choices: [OptionChoice]?
    let enhancedChoices: [EnhancedChoice]?
    let selectedChoiceLabel: String?
}

// MARK: - OptionChoice
struct OptionChoice: Decodable {
    let label, value: String?
    let selected: Bool?
}

// MARK: - EnhancedChoice
struct EnhancedChoice: Decodable {
    let label, itemMeta: String?
    let choices: [EnhancedChoiceChoice]?
}

// MARK: - EnhancedChoiceChoice
struct EnhancedChoiceChoice: Decodable {
    let label: String?
    let id: Int?
}

// MARK: - Common
struct Common: Decodable {
    let pointOfSale: CommonPointOfSale?
    let tracking: Tracking?
}

// MARK: - CommonPointOfSale
struct CommonPointOfSale: Decodable {
    let numberSeparators, brandName: String?
}

// MARK: - Tracking
struct Tracking: Decodable {
    let omniture: Omniture?
}

// MARK: - Omniture
struct Omniture: Decodable {
    let sProp33, sProp32, sProp74, sProducts: String?
    let sEVar16, sEVar40, sEVar41, sEVar63: String?
    let sEVar42, sEVar4, sEVar43, sEVar2: String?
    let sEVar24, sEVar7, sServer, sEVar6: String?
    let sProp29, sProp27, sEVar9, sEVar69: String?
    let sCurrencyCode, sEVar26, sEVar29, sProp9: String?
    let sEVar95, sProp7, sEVar31, sEVar32: String?
    let sEVar33, sEVar34, sEVar13, sEvents: String?
    let sProp18, sProp5, sProp15, sProp3: String?
    let sProp14, sProp36, sEVar93, sProp2: String?
}
