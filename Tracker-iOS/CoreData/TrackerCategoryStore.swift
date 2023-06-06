import UIKit
import CoreData

protocol TrackerCategoryStoreDelegate: AnyObject {
    func didUpdate()
}

final class TrackerCategoryStore: NSObject {
    // MARK: - Properties
    
    weak var delegate: TrackerCategoryStoreDelegate?
    var categoriesCoreData: [TrackerCategoryCD] {
        fetchedResultsController.fetchedObjects ?? []
    }
    
    var categories = [TrackerCategory]()
    
    private let context: NSManagedObjectContext
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TrackerCategoryCD> = {
        let fetchRequest = NSFetchRequest<TrackerCategoryCD>(entityName: "TrackerCategoryCD")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \TrackerCategoryCD.createdAt, ascending: true)
        ]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self
        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }()

    // MARK: - Lifecycle
    convenience override init() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        try! self.init(context: context)
    }
    
    init(context: NSManagedObjectContext) throws {
        self.context = context
        super.init()
        
        try setupCategories(with: context)
    }
    
    // MARK: - Methods
    func categoryCD(with id: UUID) throws -> TrackerCategoryCD {
        let request = NSFetchRequest<TrackerCategoryCD>(entityName: "TrackerCategoryCD")
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCategoryCD.categoryId), id.uuidString)
        let category = try context.fetch(request)
        return category[0]
    }
    
    func makeCategory(from coreData: TrackerCategoryCD) throws -> TrackerCategory {
        guard
            let idString = coreData.categoryId,
            let id = UUID(uuidString: idString),
            let label = coreData.label
        else { throw StoreError.decodeError }
        return TrackerCategory(id: id,label: label)
    }
    
    private func setupCategories(with context: NSManagedObjectContext) throws {
        let checkRequest = TrackerCategoryCD.fetchRequest()
        let result = try context.fetch(checkRequest)
        
        guard result.count == 0 else {
            categories = try result.map({ try makeCategory(from: $0) })
            return
        }
        
        let _ = [
            TrackerCategory(label: "Домашний уют"),
            TrackerCategory(label: "Радостные мелочи"),
            TrackerCategory(label: "Самочувствие"),
            TrackerCategory(label: "Важное"),
            TrackerCategory(label: "Привычки"),
            TrackerCategory(label: "Спорт")
        ].map { category in
            let categoryCD = TrackerCategoryCD(context: context)
            categoryCD.categoryId = category.id.uuidString
            categoryCD.createdAt = Date()
            categoryCD.label = category.label
            return categoryCD
        }
        
        try context.save()
    }
}

// MARK: - EXTENSIONS
extension TrackerCategoryStore {
    enum StoreError: Error {
        case decodeError
    }
}

//MARK: - NSFetchedResultsControllerDelegate
extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.didUpdate()
    }
}
