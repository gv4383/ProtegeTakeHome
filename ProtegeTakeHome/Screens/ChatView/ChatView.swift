//
//  ChatView.swift
//  ProtegeTakeHome
//
//  Created by Goyo Vargas on 9/22/22.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    
    var body: some View {
        if viewModel.isFetchingInitialMessages {
            PTHLoadingView()
                .task {
                    do {
                        try await viewModel.fetchInitialMessages()
                    } catch {
                        print(PTHError.unableToFetchMessages)
                    }
                }
        } else {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    PTHScrollView {
                        LazyVStack(spacing: 16) {
                            if viewModel.isFetchingPreviousMessages {
                                HStack {
                                    PTHLoadingView()
                                }
                                .frame(maxWidth: .infinity)
                            }
                            
                            ForEach(Array(viewModel.chatMessages.enumerated()), id: \.1) { (i, message) in
                                if i > 0 {
                                    let previousMessageDate = viewModel.chatMessages[i - 1].date
                                    let timeOneHourAfterLastMessage = Calendar.current.date(byAdding: .hour, value: 1, to: previousMessageDate)!
                                    
                                    if message.date > timeOneHourAfterLastMessage {
                                        PTHDateLabelView(date: message.date)
                                    }
                                }
                                
                                if message.sender == viewModel.primaryMessenger {
                                    PTHPrimaryMessageContainerView(messageText: message.content)
                                } else {
                                    PTHSecondaryMessageContainerView(messageText: message.content)
                                }
                            }
                        }
                        .padding()
                    }
                    .onAppear {
                        proxy.scrollTo(viewModel.chatMessages[viewModel.chatMessages.endIndex - 1])
                    }
                    .onChange(of: viewModel.lastMessageId) { _ in
                        if viewModel.isFetchingPreviousMessages {
                            // Keeps scroll view position when fetching older messages
                            
                            proxy.scrollTo(viewModel.chatMessages[viewModel.previousFirstMessageIndex], anchor: .center)
                            viewModel.isFetchingPreviousMessages = false
                        } else {
                            // Scroll to latest message when new message is sent/received
                            
                            withAnimation {
                                proxy.scrollTo(viewModel.chatMessages[viewModel.chatMessages.endIndex - 1])
                            }
                        }
                    }
                    .refreshable {
                        do {
                            try await viewModel.fetchPreviousMessages()
                        } catch {
                            print(PTHError.unableToFetchMessages)
                        }
                    }
                }
                
                PTHMessageInputBar(sendMessageAction: viewModel.sendMessage)
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationTitle(viewModel.contactName)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatView()
        }
    }
}
