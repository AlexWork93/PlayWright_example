const assert = require('assert');
const { Given, When, Then, After } = require('cucumber');
const { chromium } = require('playwright');
const path = require('path');
const config = require(path.resolve(__dirname, '../../config'));

let browser, page;

Given('I open the browser', async function () {
  browser = await chromium.launch({
    headless: config.headless,
  });
  page = await browser.newPage();
});

When('I navigate to {string}', async function (url) {
  if (!page) {
    throw new Error('Page is not initialized. Make sure "Given I open the browser" is executed.');
  }
  await page.goto(url);
});

Then('the page title should be {string}', async function (expectedTitle) {
  if (!page) {
    throw new Error('Page is not initialized. Make sure "Given I open the browser" is executed.');
  }
  await page.waitForSelector('h1', { timeout: 5000 });
  const title = await page.title();
  assert.strictEqual(title, expectedTitle, `Expected title: ${expectedTitle}, Actual title: ${title}`);
});

After(async function () {
  // Close the browser after all scenarios
  if (browser) {
    await browser.close();
  }
});