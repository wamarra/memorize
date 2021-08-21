//
//  ContentView.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject
    var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            if viewModel.gameHasEnded {
                Spacer()
                
                Text("Acabou o jogo")
                    .font(.system(size: 50))
                Text("Pontuação: \(viewModel.calculateScore) / 100")
                    .font(.system(size: 20)).bold().padding(20)
                
                Divider()
                
                Text("Estatística")
                    .font(.system(size: 15)).bold().padding(20)
               
                VStack(alignment: .leading) {
                    Text("Total de cartas: \(viewModel.statistic.cardsTotal)")
                        .font(.system(size: 12))
                    Text("Tempo total: \(viewModel.statistic.totalTime)s para solução")
                        .font(.system(size: 12))
                    Text("Tempo gasto: \(viewModel.statistic.spendTime)s")
                        .font(.system(size: 12))
                    Text("Pontuação atingida: \(viewModel.statistic.score) pontos")
                        .font(.system(size: 12))
                }
                
                (viewModel.calculateScore > 50 ?
                    Text("Parabéns :)")
                        .foregroundColor(.green)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.green.opacity(0.1))
                    .clipShape(Capsule()).padding(30) :
                    Text("Precisa melhorar ;)")
                        .foregroundColor(.red)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.red.opacity(0.1))
                    .clipShape(Capsule()).padding(30)
                )
               
                
                Spacer()
            } else {
                Grid(viewModel.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            withAnimation {
                                viewModel.choose(card: card)
                            }
                        }
                }
            }
            
            Button("Novo Jogo") {
                withAnimation(.easeInOut) {
                    viewModel.newGame()
                }
            }
        }
        .foregroundColor(Color.purple)
    }

}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    
    @State
    private var bonusTimeRemaining: Double = 0
    
    private func startTimerAnimation() {
        bonusTimeRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            bonusTimeRemaining = 0
        }
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //MAIS AO FUNDO
                
                Group {
                    if card.isConsumingBonusTime {
                        Timer(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-bonusTimeRemaining * 360 - 90))
                            .onAppear {
                                startTimerAnimation()
                            }
                    }else {
                        Timer(startAngle: Angle.degrees(-90), endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90))
                    }
                }
                .opacity(0.5)
                .padding(6)
                
                Text(card.content)
                    .font(.system(size: fontSize(for: geometry.size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    
                
                //MAIS À FRENTE
            }
            .makeCard(isFaceUp: card.isFaceUp)
            .padding(4)
            .opacity(card.isMatched ? 0 : 1)
        }
    }
    
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.6
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiMemoryGame())
    }
}
