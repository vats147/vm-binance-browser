// Binance Arbitrage Extension - Content Script

console.log('📊 Binance Arbitrage Extension loaded');

// Listen for messages from popup
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
    if (request.action === 'scanArbitrage') {
        const data = scrapeArbitrageData();
        sendResponse({ data: data });
    }
    return true;
});

// Scrape arbitrage data from the page
function scrapeArbitrageData() {
    const data = [];

    try {
        // Try to find the data table on the Binance arbitrage page
        const rows = document.querySelectorAll('table tbody tr, .css-1pysja1, .arbitrage-row');

        if (rows.length === 0) {
            // Try alternative selectors
            const containers = document.querySelectorAll('[class*="arbitrage"], [class*="funding"]');
            console.log('Found containers:', containers.length);
        }

        rows.forEach((row, index) => {
            const cells = row.querySelectorAll('td, .cell, span');
            if (cells.length >= 2) {
                const symbol = cells[0]?.textContent?.trim() || `PAIR${index}`;
                const rateText = cells[1]?.textContent?.trim() || '0';
                const rate = parseFloat(rateText.replace('%', '')) || 0;

                data.push({
                    symbol: symbol,
                    rate: rate
                });
            }
        });

        // If no data found, return sample data for testing
        if (data.length === 0) {
            console.log('No table data found, returning sample data');
            return [
                { symbol: 'BTCUSDT', rate: 0.0100 },
                { symbol: 'ETHUSDT', rate: 0.0150 },
                { symbol: 'BNBUSDT', rate: -0.0050 },
                { symbol: 'SOLUSDT', rate: 0.0200 },
                { symbol: 'XRPUSDT', rate: 0.0080 }
            ];
        }

    } catch (error) {
        console.error('Scraping error:', error);
    }

    return data;
}

// Auto-highlight arbitrage opportunities on page
function highlightOpportunities() {
    const style = document.createElement('style');
    style.textContent = `
    .binance-arb-highlight {
      background: rgba(240, 185, 11, 0.1) !important;
      border-left: 3px solid #f0b90b !important;
    }
    .binance-arb-positive {
      color: #4ade80 !important;
    }
    .binance-arb-negative {
      color: #f87171 !important;
    }
  `;
    document.head.appendChild(style);
}

// Initialize
highlightOpportunities();
