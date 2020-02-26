const storageKey = 'token';
const storage = localStorage || shimStore();

export function setToken(token) {
  storage.setItem(storageKey, JSON.stringify(token));
}

export function getToken(): string {
  const token = storage.getItem(storageKey);
  
  return token && JSON.parse(token);
}

export function removeToken() {
  storage.removeItem(storageKey);
}

function shimStore() {
  console.warn("localstorage is disabled, login will not persist after this page is closed.");
  const store = {};

  return {
    getItem: (key) => store[key],
    setItem: (key, data) => store[key] = data
  }
}