import UIKit

struct Tracker: Identifiable {
     let id: UUID
     let label: String
     let emoji: String
     let color: UIColor
     let schedule: [WeekDay]?

     init(id: UUID = UUID(), label: String, emoji: String, color: UIColor, schedule: [WeekDay]?) {
         self.id = id
         self.label = label
         self.emoji = emoji
         self.color = color
         self.schedule = schedule
     }
 }
