// tests/app.test.js
const request = require('supertest');
const express = require('express');

const app = express();

// Sample route for testing
app.get('/test', (req, res) => {
  res.status(200).send('Hello, world!');
});

describe('GET /test', () => {
  it('should return Hello, world!', async () => {
    const response = await request(app).get('/test');
    expect(response.status).toBe(200);
    expect(response.text).toBe('Hello, world!');
  });
});
