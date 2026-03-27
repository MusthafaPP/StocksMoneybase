import Testing
@testable import StocksMoneybase

//@Suite("Stock Mapper")
//struct StockMapperTests {
//    @Test("Normalizes change % when fmt has no percent sign") {
//        let item = makeItemWithChangePercent(
//            symbol: "AAPL",
//            shortName: "Apple",
//            changeRaw: 1.23,
//            changeFmt: "1.23"
//        )
//
//        let stock = StockMapper.mapToStock(item)
//        #expect(stock.changePercentText == "+1.23%")
//    }
//
//    @Test("Keeps fmt when it already contains %") {
//        let item = makeItemWithChangePercent(
//            symbol: "TSLA",
//            shortName: "Tesla",
//            changeRaw: -2.5,
//            changeFmt: "-2.5%"
//        )
//
//        let stock = StockMapper.mapToStock(item)
//        #expect(stock.changePercentText == "-2.5%")
//    }
//
//    @Test("Builds change % from raw when fmt is missing") {
//        let item = makeItemWithChangePercent(
//            symbol: "MSFT",
//            shortName: "Microsoft",
//            changeRaw: -4.5,
//            changeFmt: nil
//        )
//
//        let stock = StockMapper.mapToStock(item)
//        #expect(stock.changePercentText == "-4.5%")
//    }
//}
//


import Testing
@testable import StocksMoneybase

@Suite("Stock Mapper")
struct StockMapperTests {
    
    // MARK: - Tests
    
    @Test("Normalizes change % when fmt has no percent sign")
    func normalizesChangePercentWithoutSymbol() {
        let item = makeItemWithChangePercent(
            symbol: "AAPL",
            shortName: "Apple",
            changeRaw: 1.23,
            changeFmt: "1.23"
        )

        let stock = StockMapper.mapToStock(item)
        #expect(stock.changePercentText == "+1.23%")
    }

    @Test("Keeps fmt when it already contains %")
    func keepsExistingPercentFormat() {
        let item = makeItemWithChangePercent(
            symbol: "TSLA",
            shortName: "Tesla",
            changeRaw: -2.5,
            changeFmt: "-2.5%"
        )

        let stock = StockMapper.mapToStock(item)
        #expect(stock.changePercentText == "-2.5%")
    }

    @Test("Builds change % from raw when fmt is missing")
    func buildsPercentFromRaw() {
        let item = makeItemWithChangePercent(
            symbol: "MSFT",
            shortName: "Microsoft",
            changeRaw: -4.5,
            changeFmt: nil
        )

        let stock = StockMapper.mapToStock(item)
        #expect(stock.changePercentText == "-4.5%")
    }
}

//
//// MARK: - Test Helpers
//
//private func makeItemWithChangePercent(
//    symbol: String,
//    shortName: String,
//    changeRaw: Double,
//    changeFmt: String?
//) -> Item {
//    Item(
//        symbol: symbol,
//        shortName: shortName,
//        regularMarketChangePercent: RegularMarketChangePercent(
//            raw: changeRaw,
//            fmt: changeFmt
//        )
//    )
//}
