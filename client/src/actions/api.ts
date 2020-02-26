import { getToken } from "../tools/sessionStore";

const API = process.env.REACT_APP_API_URL || '/';
const SOCKET_URL = '/';

function headers() {
  const token = getToken();

  return {
    Accept: 'application/json',
    'Content-Type': 'application/json',
    Authorization: `Bearer: ${token}`
  }
}

function parseResponse(response) {
  return response.json().then((json) => {
    if (!response.ok) {
      return Promise.reject(json)
    }

    return json
  });
}

function queryString(params) {
  const query = Object.keys(params)
    .map(k => `${encodeURIComponent(k)}=${encodeURIComponent(params[k])}`)
    .join('&');

  return `${query.length ? '?' : ''}${query}`
}

function concat(...params) {
  return params.join('');
}

export default {
  URL: API,
  SOCKET_URL,
  get(url, params = {}) {
    return fetch(concat(API, url, queryString(params)), {
      method: 'GET',
      headers: headers()
    })
    .then(parseResponse)
  },

  post(url, data) {
    const body = JSON.stringify(data);

    return fetch(concat(API, url), {
      method: 'POST',
      headers: headers(),
      body
    })
    .then(parseResponse)
  },

  patch(url, data) {
    const body = JSON.stringify(data);

    return fetch(concat(API, url), {
      method: 'PATCH',
      headers: headers(),
      body
    })
    .then(parseResponse)
  },

  delete(url, params = {}) {
    return fetch(concat(API, url, queryString(params)), {
      method: 'DELETE',
      headers: headers()
    })
    .then(parseResponse)
  },

  /**
   * replaces parts of url with parameters, e.g. /rooms/:roomId, must have roomId as a key in params
   * @param {*} url 
   * @param {*} params dictionary of parameters to replace
   */
  path(url, params) {
    for(let key in params) {
      if (!params.hasOwnProperty(key)) continue;
      url = url.replace(':' + key, params[key])
    }

    return url;
  }
}