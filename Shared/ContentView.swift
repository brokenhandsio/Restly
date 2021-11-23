//
//  ContentView.swift
//  Shared
//
//  Created by Tim Condon on 17/11/2021.
//

import SwiftUI

@MainActor
struct ContentView: View {
    @State private var urlString: String = "https://"
    @State private var httpMethod: String = "GET"
    @State private var responseHeaders: String = ""
    @State private var responseBody: String = ""

    var body: some View {
        VStack {
            Spacer()
            TextField("URL", text: $urlString)
                .keyboardType(.URL)
                .textContentType(.URL)
                .textCase(.lowercase)
                .autocapitalization(.none)
            HStack {
                Text("HTTP Method")
                Menu("GET") {
                    Button("GET") {}
                    Button("POST") {}
                    Button("PUT") {}
                    Button("PATCH") {}
                    Button("HEAD") {}
                }
            }
            Button("Send Request", action: {
                let requestSender = RequestSender()
                Task {
                    let (data, response) = try await requestSender.sendRequest(to: urlString, method: httpMethod)
                    if let bodyString = String(data: data, encoding: .utf8) {
                        responseBody = bodyString
                    }
                    responseHeaders = response.description
                }
            })
                .padding()
            Text("Response:")
            TextEditor(text: $responseHeaders)
                .font(.system(.body, design: .monospaced))
            Text("Response body:")
            TextEditor(text: $responseBody)
                .font(.system(.body, design: .monospaced))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
