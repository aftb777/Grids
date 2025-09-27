//
//  ContentView.swift
//  Grids
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Grid {
                GridRow {
                    Text("Exercise Name")
                        .fontWeight(.bold)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                        .frame(maxWidth: .infinity)
                    Text("Reps")
                        .fontWeight(.bold)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                    Text("Sets")
                        .fontWeight(.bold)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                    Text("Completion")
                        .fontWeight(.bold)
                        .font(.system(size: 15, weight: .semibold, design: .default))
                }
                
                Divider()
                
                GridRow {
                    Text("Bench Press")
                    Text("10")
                    Text("3")
                    Text("100%")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
