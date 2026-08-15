//  Copyright (c) 2025-2026 Psummerland2 LLC.
//  All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at https://mozilla.org/MPL/2.0.lied. See the License for the specific language governing permissions andlimitations under
// the License.

import CmdArgLibCore
import Foundation

public typealias ParameterName = String
public typealias TypeName = String
public typealias Alias = String

public struct CommandNodeConfiguration<StateElement:Sendable>: Sendable, Codable {

    public init(from decoder: any Decoder) throws
    {
        self.init()
    }

    public func encode(to encoder: any Encoder) throws
    {
        // Encode an empty object.
        _ = encoder.singleValueContainer()
    }

    public struct Embellishment: Sendable, Codable {
        public let name: ParameterName
        public let label: LabelSpec?
        public let typeName: TypeName?

        /// Add a custom label and or typename for use in error screens, helpscreens, manpages, etc
        public static func embellish(
            _ name: ParameterName,
            label: LabelSpec? = nil,
            typeName: TypeName? = nil) -> Embellishment
        {
            .init(name: name, label: label, typeName: typeName)
        }
    }

    public let commandName: String
    public let shadowGroups: [String]
    public let embellishments: [Embellishment]
    public let commandSynopsis: String
    public let children: [CommandNode<StateElement>]
    
    public init(commandName: String = "",
                shadowGroups: [String] = [],
                embellishments: [Embellishment] = [],
                commandSynopsis: String? = nil,
                children: [CmdArgLibCore.CommandNode<StateElement>] = [])
    {
        self.commandName = commandName
        self.shadowGroups = shadowGroups
        self.embellishments = embellishments
        self.commandSynopsis = commandSynopsis ?? commandName
        self.children = children
    }
}

protocol ArrayType {
    static var elementType: Any.Type { get }
}

extension Array: ArrayType {
    static var elementType: Any.Type { Element.self }
}

protocol OptionalType {
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalType {
    static var wrappedType: Any.Type { Wrapped.self }
}
