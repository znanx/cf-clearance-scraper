const { connect } = require("puppeteer-real-browser")

async function createBrowser() {
    try {
        if (global.finished === true) return

        global.browser = null

        const { browser } = await connect({
            headless: true, // Chromium native headless
            turnstile: true,
            disableXvfb: true, // Wajib true di Koyeb
            executablePath: process.env.CHROME_PATH, // Pastikan Chromium dipakai
            connectOption: {
                defaultViewport: null,
                args: ['--no-sandbox', '--disable-setuid-sandbox']
            }
        })

        global.browser = browser

        browser.on('disconnected', async () => {
            if (global.finished === true) return
            console.log('Browser disconnected')
            await new Promise(resolve => setTimeout(resolve, 3000))
            await createBrowser()
        })

    } catch (e) {
        console.log(e.message)
        if (global.finished === true) return
        await new Promise(resolve => setTimeout(resolve, 3000))
        await createBrowser()
    }
}
createBrowser()
