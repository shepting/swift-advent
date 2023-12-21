import Foundation

public func output(_ command: String, log_command: Bool = false, log_output: Bool = false) -> String {
    // In the future check ProcessInfo.processInfo.environment["DEBUG_TASKS"]
    // to see if we should log all of the tasks being run
    if log_command {
        debug(command)
    }

    let process = processToRun(command)

    do {
        try process.run()
    } catch let error as NSError {
        log("\(error)")
    } catch {
        print("Failed")
    }

    let outPipe: Pipe = process.standardOutput as! Pipe
    let errorPipe: Pipe = process.standardError as! Pipe

    let outputData = outPipe.fileHandleForReading.readDataToEndOfFile()
    let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(decoding: outputData, as: UTF8.self)
    let error = String(decoding: errorData, as: UTF8.self)
    if !error.isEmpty {
        warning(error)
    }
    if log_output {
        print(output)
    }

    return output
}

public func run(_ command: String, log_command: Bool = true, log_output: Bool = true) {
    _ = output(command, log_command: log_command, log_output: log_output)
}

func processToRun(_ command: String) -> Process {
    let arguments = ["-c"] + [command]
    let command = "/bin/bash"

    let process: Process = Process()
    process.executableURL = URL(fileURLWithPath:command)
    process.arguments = arguments
    process.terminationHandler = { (process) in
        // Finished running command
        // print("\ndidFinish: \(!process.isRunning)")
    }

    // Set up STDOUT and STDERR pipes
    let outputPipe = Pipe()
    let errorPipe = Pipe()
    process.standardOutput = outputPipe
    process.standardError = errorPipe

    return process
}
