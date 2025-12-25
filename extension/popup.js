// Binance Arbitrage Extension - Popup Script

document.addEventListener('DOMContentLoaded', () => {
    const statusDot = document.getElementById('statusDot');
    const statusText = document.getElementById('statusText');
    const pairsCount = document.getElementById('pairsCount');
    const oppCount = document.getElementById('oppCount');
    const scanBtn = document.getElementById('scanBtn');
    const openBinance = document.getElementById('openBinance');
    const loader = document.getElementById('loader');
    const arbitrageData = document.getElementById('arbitrageData');
    const dataTable = document.getElementById('dataTable');

    // Check connection status
    checkConnection();

    // Scan button click
    scanBtn.addEventListener('click', async () => {
        loader.style.display = 'block';
        arbitrageData.style.display = 'none';
        scanBtn.disabled = true;
        scanBtn.textContent = '⏳ Scanning...';

        try {
            // Send message to content script
            const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });

            if (tab && tab.url && tab.url.includes('binance.com')) {
                chrome.tabs.sendMessage(tab.id, { action: 'scanArbitrage' }, (response) => {
                    if (response && response.data) {
                        displayData(response.data);
                    } else {
                        showError('No data received. Make sure you are on the Binance arbitrage page.');
                    }
                });
            } else {
                showError('Please open the Binance Arbitrage Data page first.');
            }
        } catch (error) {
            console.error('Scan error:', error);
            showError('Error scanning. Please try again.');
        }

        setTimeout(() => {
            loader.style.display = 'none';
            scanBtn.disabled = false;
            scanBtn.textContent = '🔍 Scan Arbitrage Data';
        }, 3000);
    });

    // Open Binance button
    openBinance.addEventListener('click', () => {
        chrome.tabs.create({
            url: 'https://www.binance.com/en-IN/futures/funding-history/perpetual/arbitrage-data'
        });
    });

    function checkConnection() {
        chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
            if (tabs[0] && tabs[0].url && tabs[0].url.includes('binance.com')) {
                statusDot.classList.remove('inactive');
                statusText.textContent = 'Connected to Binance';
                pairsCount.textContent = '0';
                oppCount.textContent = '0';
            } else {
                statusDot.classList.add('inactive');
                statusText.textContent = 'Not on Binance page';
                pairsCount.textContent = '--';
                oppCount.textContent = '--';
            }
        });
    }

    function displayData(data) {
        arbitrageData.style.display = 'block';
        dataTable.innerHTML = '';

        if (Array.isArray(data) && data.length > 0) {
            pairsCount.textContent = data.length;
            let opportunities = 0;

            data.forEach(item => {
                const row = document.createElement('tr');
                const rateClass = item.rate >= 0 ? 'positive' : 'negative';
                const apr = (item.rate * 3 * 365).toFixed(2);

                if (Math.abs(item.rate) > 0.01) opportunities++;

                row.innerHTML = `
          <td>${item.symbol}</td>
          <td class="${rateClass}">${item.rate.toFixed(4)}%</td>
          <td class="${rateClass}">${apr}%</td>
        `;
                dataTable.appendChild(row);
            });

            oppCount.textContent = opportunities;
        } else {
            dataTable.innerHTML = '<tr><td colspan="3">No data found</td></tr>';
        }
    }

    function showError(message) {
        loader.style.display = 'none';
        arbitrageData.style.display = 'block';
        dataTable.innerHTML = `<tr><td colspan="3" style="color: #f87171;">${message}</td></tr>`;
    }
});
