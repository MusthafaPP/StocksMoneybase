import SwiftUI

struct MarketSummaryDetailView: View {
    @StateObject var viewModel: MarketSummaryDetailViewModel
    
    var body: some View {
        List {
            if let detail = viewModel.detail {
                Section("Overview") {
                    metricRow(title: "Symbol", value: detail.symbol)
                    metricRow(title: "Name", value: detail.shortName ?? detail.fullExchangeName)
                    metricRow(title: "Exchange", value: detail.fullExchangeName)
                    metricRow(title: "Region", value: detail.region ?? "-")
                    metricRow(title: "Market State", value: detail.marketState ?? "-")
                }
                
                Section("Price") {
                    metricRow(title: "Current Price", value: detail.regularMarketPrice?.fmt ?? "-")
                    metricRow(title: "Previous Close", value: detail.regularMarketPreviousClose?.fmt ?? "-")
                }
                
                Section("Stats") {
                    metricRow(title: "Quote Type", value: detail.quoteType ?? "-")
                    metricRow(title: "Tradeable", value: yesNo(detail.tradeable))
                    metricRow(title: "Price Hint", value: number(detail.priceHint))
                    metricRow(title: "Source Interval", value: number(detail.sourceInterval))
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                Text("No details available.")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(viewModel.detail?.shortName ?? viewModel.initialName)
        .navigationBarTitleDisplayMode(.inline)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .task {
            if viewModel.detail == nil {
                await viewModel.loadDetail()
            }
        }
        .refreshable {
            await viewModel.loadDetail()
        }
    }
    
    @ViewBuilder
    private func metricRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
        }
    }
    
    private func number(_ value: Int?) -> String {
        guard let value else { return "-" }
        return value.formatted(.number.grouping(.automatic))
    }
    
    private func yesNo(_ value: Bool?) -> String {
        guard let value else { return "-" }
        return value ? "Yes" : "No"
    }
}
