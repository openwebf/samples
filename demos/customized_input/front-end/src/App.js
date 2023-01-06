import './App.css';
import { useEffect, useRef } from 'react';

function App() {
  const flutterInput = useRef();

  function handleEnteryKeyboard() {
    console.log('The Enter keyboard pressed');
  }

  useEffect(() => {
    flutterInput.current.addEventListener('enterkeyboard', handleEnteryKeyboard);
    return () => {
      flutterInput.current.removeEventListener('enterkeyboard', handleEnteryKeyboard);
    };
  }, []); 

  return (
    <div className="App">
      <header className="App-header">
        <p>
          This demo shows how to use the flutter customized html element and interact with React.js
        </p>
        <div className="container">
          <flutter-input
            ref={flutterInput}
          />
        </div>
      </header>
    </div>
  );
}

export default App;
