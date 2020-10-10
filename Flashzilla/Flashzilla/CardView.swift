//
//  CardView.swift
//  Flashzilla
//
//  Created by Ginger on 09/10/2020.
//

import SwiftUI
import CoreHaptics

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    let card: Card
    @Binding var retryWrongAnswers: Bool
    var removal: ((_ answer: Bool) -> Void)? = nil
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                            //.fill(offset.width > 0 ? Color.green : Color.red)
                            .fill(offset.width == 0 ? Color.white : (offset.width > 0 ? Color.green : Color.red))
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.title)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.title)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 150)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                    self.feedback.prepare()
                }
            
                .onEnded { _ in
                    if abs(self.offset.width) > 100 {
                        let answer: Bool
                        if self.offset.width > 0 {
                            answer = true
                            self.feedback.notificationOccurred(.success)
                        } else {
                            answer = false
                            if (self.retryWrongAnswers) {
                                self.offset = .zero
                            }
                            self.isShowingAnswer = false
                            self.feedback.notificationOccurred(.error)
                        }
                        // remove the card
                        self.removal?(answer)
                    } else {
                        self.offset = .zero
                    }
                }
        )
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .animation(.spring())
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example, retryWrongAnswers: .constant(false))
    }
}
