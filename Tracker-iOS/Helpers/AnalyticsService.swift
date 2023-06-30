import Foundation
import YandexMobileMetrica

struct AnalyticsService {
    static func activate() {
        guard let configuration = YMMYandexMetricaConfiguration(apiKey: "f21f5c7f-e1e1-439a-b113-24c1cea87aad") else { return }
        
        YMMYandexMetrica.activate(with: configuration)
    }
    
    func report(event: Events, params : [AnyHashable : Any]) {
        YMMYandexMetrica.reportEvent(event.rawValue, parameters: params, onFailure: { error in
            print("REPORT ERROR: %@", error.localizedDescription)
        })
    }
}

//MARK: - Enums for analitics

enum Events: String, CaseIterable {
    case open = "open"
    case close = "close"
    case click = "click"
}

enum Items: String, CaseIterable {
    case add_track = "add_track"
    case track = "track"
    case filter = "filter"
    case edit = "edit"
    case delete = "delete"
}
