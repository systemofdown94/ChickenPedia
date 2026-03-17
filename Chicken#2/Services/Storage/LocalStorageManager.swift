import Foundation

final class LocalStorageManager {
    
    static let instance = LocalStorageManager()
    
    private let defaults: UserDefaults
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder
    
    init(
        defaults: UserDefaults = .standard,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.defaults = defaults
        self.jsonEncoder = encoder
        self.jsonDecoder = decoder
    }
}

extension LocalStorageManager {
    func fetch<T: Codable>(_ type: T.Type, for key: StorageKey) async -> T? {
        guard let rawData = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        
        do {
            return try jsonDecoder.decode(type, from: rawData)
        } catch {
            return nil
        }
    }
}

extension LocalStorageManager {
    func store<T: Codable>(_ object: T, key: StorageKey) async {
        do {
            let encoded = try jsonEncoder.encode(object)
            defaults.set(encoded, forKey: key.rawValue)
        } catch {
            print("Storage encoding error:", error.localizedDescription)
        }
    }
}

extension LocalStorageManager {
    func clear(_ key: StorageKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
}
