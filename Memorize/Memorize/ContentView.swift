/**
 
 ContentView.swift
 Memorize
 Created by Kenn Villegas on 8/3/24.
 
 */
import SwiftUI

struct ContentView: View {
	
	@State var cardCount = 2
	let zodiacIcons: [String] = ["♈️" ,"♉️" ,"♊️" ,"♋️" ,"♌️" ,"♍️" ,"♎️" ,"♏️" ,"♐️" ,"♑️" ,"♒️" ,"♓️"]
	
	var body: some View {
		ScrollView {
			Text("Zodiac")
				.font(.largeTitle)
				.fontWeight(.bold)
			cards
			Spacer()
			cardButtons
			.font(.largeTitle)
			.foregroundColor(.blue)
		}
//		.foregroundColor(Color.blue)
		.padding()
	}
	
	var cardButtons: some View {
		HStack {
			addButton
			Spacer()
			removeButton
		}

	}
	
	func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
		Button(action: { cardCount += offset } , label: { Image(systemName: symbol)}) .disabled(cardCount + offset < 1 || cardCount + offset > zodiacIcons.count )
	}

	var addButton: some View {
		cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
		.padding(.leading)
	}

	var removeButton: some View {
		cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
		.padding(.trailing)
	}
	
	var cards: some View {
		LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
			ForEach(0..<cardCount, id: \.self) {index in
				CardView(content: zodiacIcons[index])
					.aspectRatio(2/3, contentMode: .fit)
			}
			.foregroundColor(.purple)
		}
	}

}

struct CardView : View {
	let content: String
	@State var isFaceUp: Bool = true
	
	var body: some View {
		ZStack(content: {
			
			let cardBox = RoundedRectangle(cornerRadius: 12) // Circle()
			Group {
				cardBox .foregroundColor(.white)
				cardBox .strokeBorder(lineWidth: 2)
				Text(content).font(.largeTitle)
			}
			cardBox.fill() .opacity(isFaceUp ? 0 : 1)
		})
		.onTapGesture(perform: {
			isFaceUp.toggle()
		})
	}
}

#Preview {
	ContentView()
}

