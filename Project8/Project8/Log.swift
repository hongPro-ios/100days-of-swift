//
//  Log.swift
//  Project8
//
//  Created by JEONGSEOB HONG on 2021/07/16.
//

import Foundation

enum Log {
    enum LogLevel {
        case info
        case warning
        case error
        
        fileprivate var prefix: String {
            switch self {
            case .info: return "INFO ℹ️"
            case .warning: return "WARN ⚠️"
            case .error: return "ALERT ❌"
            }
        }
    }
    
    struct Context {
        let file: String
        let function: String
        let line: Int
        var description: String {
            "\((file as NSString).lastPathComponent):\(line) \(function))"
        }
    }
    
    fileprivate static func handleLong(level: LogLevel, str: String, shouldLogContext: Bool, context: Context) {
        let logComponents = ["[\(level.prefix)]", str]
        
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext { fullString += " -> \(context.description)"}
        
        #if DEBUG
        print(fullString)
        #endif
    }
    
    static func info(_ str: String, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLong(level: .info, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }

    static func warning(_ str: StaticString, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLong(level: .warning, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
    
    static func error(_ str: StaticString, shouldLogContext: Bool = true, file: String = #file, function: String = #function, line: Int = #line) {
        let context = Context(file: file, function: function, line: line)
        Log.handleLong(level: .error, str: str.description, shouldLogContext: shouldLogContext, context: context)
    }
}



