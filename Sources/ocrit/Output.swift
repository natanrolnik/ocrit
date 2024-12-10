import ArgumentParser
import Foundation
import PathKit

enum Output {
    case disk(Path)
    case stdOutput
}

extension Output: ExpressibleByArgument {
    init?(argument: String) {
        if argument == "-" || argument.isEmpty {
            self = .stdOutput
        } else {
            let path = Path(argument).absolute()
            self = .disk(path)
        }
    }
}

extension Output {
    var path: Path? {
        switch self {
        case let .disk(path): path
        default: nil
        }
    }

    var isStdOutput: Bool {
        switch self {
        case .stdOutput: true
        default: false
        }
    }
}

extension Path: @retroactive ExpressibleByArgument {
    public init?(argument: String) {
        self = Path(argument).absolute()
    }
}
