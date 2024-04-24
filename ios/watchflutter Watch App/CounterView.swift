//
//  ContentView.swift
//  watchflutter Watch App
//
//  Created by Leandro Pontes Berleze on 23/04/24.
//

import SwiftUI

struct CounterView: View {
    @ObservedObject var viewModel: CounterViewModel
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
                .font(.largeTitle)
            Spacer()
            HStack{
                Image(systemName: "minus.circle")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(.title)
                    .onTapGesture {
                        viewModel.decrement()
                    }
                Spacer()
                Image(systemName: "plus.circle")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .font(.title)
                    .onTapGesture {
                        viewModel.increment()
                    }
            }
        }
        .padding()
    }
}

#Preview {
    CounterView(viewModel: CounterViewModel())
}
