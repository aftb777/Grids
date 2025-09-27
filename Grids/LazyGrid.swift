//
//  LazyGrid.swift
//  Grids
//

import SwiftUI

struct LazyGrid: View {
    
    let column = [
        GridItem(.flexible(minimum: 50, maximum: 50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        GridItem(.fixed(50)),
        //GridItem(.adaptive(minimum: 50, maximum: 50))
    ]
    var body: some View {
        VStack {
            LazyVGrid(columns: column) {
                ForEach(0...50, id: \.self) {index in
                    Color.red
                        .frame(width: 50, height: 50)
                }
            }
            
            // same LazyHStack it will take row as input
        }
    }
}

#Preview {
    LazyGrid()
}
