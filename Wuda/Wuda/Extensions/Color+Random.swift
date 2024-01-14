import Foundation
import SwiftUI

extension Color {
    
    public static var random: Color { Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)) }
    
}
