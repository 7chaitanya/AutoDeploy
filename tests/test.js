const { handler } = require('../src/index');

test('should return success message', async () => {
  const response = await handler({});
  expect(response.statusCode).toBe(200);
  expect(JSON.parse(response.body).message).toBe("Demo Service is live!");
});