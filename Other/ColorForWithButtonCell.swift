import UIKit

enum ColorForCellWithButton: CaseIterable {
    
    case red
    case blue
    case yellow
    case green
    case purple
    case brown
    case cyan
    case magenta
    case lightGray
    
    var uiColor: UIColor {
        
        switch self {
            
        case .red: return .red
        case .blue: return .blue
        case .yellow: return .yellow
        case .green: return .green
        case .purple: return .purple
        case .brown: return .brown
        case .cyan: return .cyan
        case .magenta: return .magenta
        case .lightGray: return .lightGray
        }
    }
}


