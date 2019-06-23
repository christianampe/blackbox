//
//  Created by Christian Ampe on 6/23/19.
//

public protocol BlackboxFeature: CustomStringConvertible, Equatable {
    
    /// A flag determining whether a given feature's print statements should be shown in the console.
    var shouldLog: Bool { get }
}
