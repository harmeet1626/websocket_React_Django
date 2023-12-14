// EmojiInput.js

import React from 'react';
import { Picker } from 'emoji-mart';
// import 'emoji-mart/css/emoji-mart.css';
import { EmojiInput } from 'react-input-emoji';

const EmojiInputComponent = ({ message, setMessage, handleKeyPress }) => {
  const addEmoji = (emoji) => {
    // Append the selected emoji to the existing message
    setMessage(message + emoji);
  };

  return (
    <div>
      <EmojiInput
        value={message}
        onChange={(text) => setMessage(text)}
        placeholder="Type your message..."
        onKeyPress={handleKeyPress}
        cleanOnEnter
      />

      {/* Emoji Picker */}
      <Picker
        onSelect={(emoji) => addEmoji(emoji.native)}
        style={{ position: 'absolute', bottom: '50px', right: '10px' }}
      />
    </div>
  );
};

export default EmojiInputComponent;
