const chromium = require('chrome-aws-lambda');
const util = require('util');

exports.handler = async (event) => {
  let browser = null;

  try {
    browser = await chromium.puppeteer.launch({
      args: chromium.args,
      defaultViewport: chromium.defaultViewport,
      executablePath: await chromium.executablePath,
      headless: chromium.headless,
    });

    const page = await browser.newPage();
    await page.goto(event.url);

    const title = await page.title();
    console.log(`Title: ${title}`);
  } catch (error) {
    console.error(util.inspect(error));
    throw error;
  } finally {
    if (browser !== null) {
      await browser.close();
    }
  }
};
