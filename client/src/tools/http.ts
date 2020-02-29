/**
 * parse a path and return an object of key/vals representing query params
 * @param path a path string after `?` of a url
 */
export function queryString(path: string): {[key: string]: string} {
  const keyVals = path
    .replace('?', '')
    .split('&')
    .map(item => item.split('='));

  const result = {};

  for(const [key, value] of keyVals ) {
    result[decodeURIComponent(key)] = decodeURIComponent(value);
  }

  return result;
}