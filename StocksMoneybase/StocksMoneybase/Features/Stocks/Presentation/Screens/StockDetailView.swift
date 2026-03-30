import SwiftUI


struct StockDetailView: View {
    @StateObject var viewModel: StockDetailViewModel
    
    var body: some View {
        List {
            if let detail = viewModel.detail {
                Section("Overview") {
                    metricRow(title: "Symbol", value: detail.identity.symbol ?? "-")
                    metricRow(title: "Name", value: detail.identity.longName ?? detail.identity.shortName ?? "-")
                    metricRow(title: "Exchange", value: detail.market.fullExchangeName ?? "-")
                    metricRow(title: "Region", value: "-") // Add if available
                    metricRow(title: "Market State", value: "-") // Add if available
                    // Add other overview metrics as needed
                }
                
                Section("Price") {
                    metricRow(title: "Current Price", value: number(detail.pricing.currentPrice))
                    metricRow(title: "Previous Close", value: number(detail.pricing.previousClose))
                    metricRow(title: "Chart Previous Close", value: number(detail.pricing.chartPreviousClose))
                }
                
                Section("Stats") {
                    metricRow(title: "Day High", value: number(detail.range.dayHigh))
                    metricRow(title: "Day Low", value: number(detail.range.dayLow))
                    metricRow(title: "52 Week High", value: number(detail.range.fiftyTwoWeekHigh))
                    metricRow(title: "52 Week Low", value: number(detail.range.fiftyTwoWeekLow))
                    metricRow(title: "Regular Market Volume", value: number(detail.volume.regularMarketVolume))
                }
                
                Section("Market Info") {
                    metricRow(title: "Exchange", value: detail.market.exchangeName ?? "-")
                    metricRow(title: "TimeZone", value: detail.market.timezone ?? "-")
                    metricRow(title: "GMT Offset", value: number(detail.market.gmtOffset))
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                Text("No details available.")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle(viewModel.detail?.identity.shortName ?? viewModel.initialName)
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
    
    private func number(_ value: Double?) -> String {
        guard let value else { return "-" }
        return value.formatted(.number.precision(.fractionLength(2)))
    }
    
    private func number(_ value: Int?) -> String {
        guard let value else { return "-" }
        return value.formatted(.number.grouping(.automatic))
    }
}
