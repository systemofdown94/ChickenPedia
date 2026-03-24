import UIKit

final class ImageDiskRepository {
    
    static let instance = ImageDiskRepository()
    
    private let folderName = "StoredImages"
    private let manager = FileManager.default
    private let rootDirectory: URL
    
    private init() {
        
        let docs = manager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        rootDirectory = docs.appendingPathComponent(folderName, isDirectory: true)
        
        ensureDirectory()
    }
    
    private func ensureDirectory() {
        
        var isDirectory: ObjCBool = false
        
        if !manager.fileExists(atPath: rootDirectory.path, isDirectory: &isDirectory) || !isDirectory.boolValue {
            
            do {
                try manager.createDirectory(
                    at: rootDirectory,
                    withIntermediateDirectories: true
                )
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    private func path(for identifier: UUID) -> URL {
        rootDirectory.appendingPathComponent("\(identifier.uuidString).png")
    }
    
    
    @discardableResult
    func store(_ image: UIImage, id: UUID = UUID()) async -> UUID? {
        
        let location = path(for: id)
        
        guard let binary = image.pngData() else {
            return nil
        }
        
        do {
            try binary.write(to: location, options: .atomic)
            return id
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    func fetchImage(id: UUID) async -> UIImage? {
        
        let location = path(for: id)
        
        guard manager.fileExists(atPath: location.path) else {
            return nil
        }
        
        return UIImage(contentsOfFile: location.path)
    }
    
    
    func removeImage(id: UUID) async {
        
        let location = path(for: id)
        
        guard manager.fileExists(atPath: location.path) else {
            return
        }
        
        do {
            try manager.removeItem(at: location)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func containsImage(id: UUID) -> Bool {
        manager.fileExists(atPath: path(for: id).path)
    }
}
