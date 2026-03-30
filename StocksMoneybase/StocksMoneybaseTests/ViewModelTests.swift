import Testing
@testable import StocksMoneybase

@Suite("View Models")
struct ViewModelTests {

    @Test("List view model returns all items when search text is empty")
    @MainActor
    func listViewModelEmptySearch() {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
        let viewModel = StockListViewModel(useCase: useCase)
        viewModel.stocks = [makeStock(symbol: "AAPL", shortName: "Apple")]
        viewModel.searchText = "   "

        #expect(viewModel.filteredStocks.count == 1)
    }

    @Test("List view model filters by shortName case-insensitively")
    @MainActor
    func listViewModelFiltersByShortName() {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
        let viewModel = StockListViewModel(useCase: useCase)
        viewModel.stocks = [
            makeStock(symbol: "AAPL", shortName: "Apple Inc."),
            makeStock(symbol: "MSFT", shortName: "Microsoft")
        ]
        viewModel.searchText = "apple"

        #expect(viewModel.filteredStocks.count == 1)
        #expect(viewModel.filteredStocks.first?.symbol == "AAPL")
    }

    @Test("List view model filters by exchange name when shortName is nil")
    @MainActor
    func listViewModelFiltersByExchangeNameFallback() {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([]))
        let viewModel = StockListViewModel(useCase: useCase)
        viewModel.stocks = [makeStock(symbol: "^DJI", shortName: nil, fullExchangeName: "Dow Jones")]
        viewModel.searchText = "dow"

        #expect(viewModel.filteredStocks.count == 1)
    }

    @Test("List view model loads summaries successfully")
    @MainActor
    func listViewModelLoadSuccess() async {
        let stocks = [makeStock(symbol: "NVDA", shortName: "NVIDIA")]
        let useCase = GetMarketSummaryUseCaseMock(result: .success(stocks))
        let viewModel = StockListViewModel(useCase: useCase)

        await viewModel.loadMarketSummaries()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.stocks.count == 1)
        #expect(viewModel.stocks.first?.symbol == "NVDA")
        #expect(useCase.callCount == 1)
    }

    @Test("List view model keeps data empty when load fails")
    @MainActor
    func listViewModelLoadFailure() async {
        let useCase = GetMarketSummaryUseCaseMock(result: .failure(MockError.someFailure))
        let viewModel = StockListViewModel(useCase: useCase)

        await viewModel.loadMarketSummaries()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.stocks.isEmpty)
        #expect(useCase.callCount == 1)
    }

    @Test("Detail view model loads matching symbol")
    @MainActor
    func detailViewModelLoadSuccess() async {
        let stocks = [
            makeStock(symbol: "AAPL", shortName: "Apple"),
            makeStock(symbol: "MSFT", shortName: "Microsoft")
        ]
        let useCase = GetMarketSummaryUseCaseMock(result: .success(stocks))
        let viewModel = StockDetailViewModel(symbol: "MSFT", initialName: "Microsoft", useCase: useCase)

        await viewModel.loadDetail()

        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorMessage == nil)
        #expect(viewModel.detail?.symbol == "MSFT")
        #expect(useCase.callCount == 1)
    }

    @Test("Detail view model sets not found message when symbol missing")
    @MainActor
    func detailViewModelSymbolNotFound() async {
        let useCase = GetMarketSummaryUseCaseMock(result: .success([makeStock(symbol: "TSLA", shortName: "Tesla")]))
        let viewModel = StockDetailViewModel(symbol: "META", initialName: "Meta", useCase: useCase)

        await viewModel.loadDetail()

        #expect(viewModel.detail == nil)
        #expect(viewModel.errorMessage?.contains("META") == true)
    }

    @Test("Detail view model sets user-friendly error message on failure")
    @MainActor
    func detailViewModelLoadFailure() async {
        let useCase = GetMarketSummaryUseCaseMock(result: .failure(MockError.someFailure))
        let viewModel = StockDetailViewModel(symbol: "AAPL", initialName: "Apple", useCase: useCase)

        await viewModel.loadDetail()

        #expect(viewModel.detail == nil)
        #expect(viewModel.errorMessage == "Unable to load stock details. Pull to retry.")
        #expect(viewModel.isLoading == false)
    }
}
