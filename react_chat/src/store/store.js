// store.js
import { configureStore } from '@reduxjs/toolkit';
import counterReducer from './counterSlice';
import groupListing from './chatListing'

const store = configureStore({
  reducer: {
    counter: counterReducer,
    groupList: groupListing
  },
});

export default store;
