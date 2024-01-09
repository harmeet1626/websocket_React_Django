import { configureStore } from '@reduxjs/toolkit';
import groupListing from './chatListing'

const store = configureStore({
  reducer: {
    groupList: groupListing
  },
});

export default store;
