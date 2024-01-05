import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';

export const fetchGroups = createAsyncThunk('groupList/fetchGroups', async (token) => {
    try {
        const apiUrl = process.env.REACT_APP_API_BASE_URL;
        const response = await fetch(`http://${apiUrl}UserGroup/`, {
            headers: {
                Authorization: token
            }
        });
        const data = await response.json();
        return data;
    } catch (error) {
        throw error;
    }
});

const groupListing = createSlice({
    name: 'groupList',
    initialState: {
        data: [],
        status: 'idle', 
        error: null,
    },
    reducers: {},
    extraReducers: (builder) => {
        builder
            .addCase(fetchGroups.pending, (state) => {
                state.status = 'loading';
            })
            .addCase(fetchGroups.fulfilled, (state, action) => {
                state.status = 'succeeded';
                state.data = action.payload;
            })
            .addCase(fetchGroups.rejected, (state, action) => {
                state.status = 'failed';
                state.error = action.error.message;
            });
    },
});

export default groupListing.reducer;

