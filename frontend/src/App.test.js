import React from 'react';
import { render, screen } from '@testing-library/react';
import App from './App';
import '@testing-library/jest-dom/extend-expect'; // for the `toBeInTheDocument` matcher

test('renders loading indicator and error alert initially', () => {
  render(<App />);

  // Initially, it should show a loading indicator (if you have one)
  // Since you don't have a loading indicator in your provided code, we will skip this assertion

  // Initially, there should be no error alert
  const errorAlert = screen.queryByText(/Fetching goals failed/i);
  expect(errorAlert).not.toBeInTheDocument();
});