//
//  ContentView.swift
//  Memorize
//
//  Created by Wesley Marra on 06/08/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject
    var viewModel: EmojiMemoryGame
    
    var theme: String
    
    @State
    var level: Double = -1;
        
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
                    Text("Tempo gasto de acordo com a dificuldade: \(viewModel.statistic.spendTime)s")
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
                
                Button("Novo Jogo") {
                    withAnimation(.easeInOut) {
                        viewModel.newGame()
                    }
                    
                    level = -1
                }.padding()
                .background(viewModel.themeColor)
                .clipShape(Capsule())
                .foregroundColor(Color.white)
                .shadow(color: .gray, radius: 5, x: 2, y: 2)
            } else {
                if (level < 0) {
                    VStack {
                        Text("Escolha a dificuldade")
                            .font(.system(size: 30))
                            .bold()
                            .padding(20)
                        
                        Button("Fácil") {
                            level = 0
                        }.padding()
                        .background(viewModel.themeColor)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                        
                        Button("Normal") {
                            level = 1
                        }.padding()
                        .background(viewModel.themeColor)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                        .frame(width: 100, height: 100, alignment: .center)
                        
                        Button("Difícil") {
                            level = 2
                        }.padding()
                        .background(viewModel.themeColor)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                        .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    }
                }
                
                if (level >= 0) {
                    Grid(viewModel.cards) { card in
                        CardView(card: card, themeCornerRadius: viewModel.themeCornerRadius)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.choose(card: card, difficulty: level)
                                }
                            }
                    }
                }
            }
        }
        .foregroundColor(viewModel.themeColor)
        .navigationTitle(theme)
    }
}

struct CardView: View {
    
    var card: MemoryGame<String>.Card
    var themeCornerRadius: CGFloat
    
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
            .makeCard(isFaceUp: card.isFaceUp, cornerRadius: themeCornerRadius)
            .padding(4)
            .opacity(card.isMatched ? 0 : 1)
        }
    }
    
    
    private func fontSize(for size: CGSize) -> CGFloat {
        return min(size.width, size.height) * 0.6
    }
}
