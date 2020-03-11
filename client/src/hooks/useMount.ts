import React, { useEffect } from "react";

/**
 * executes the passed in function on first load and returns a loading
 * tracker until the promise completes.
 * @param fn: () => Promise
 */
export default function useMount(fn: () => Promise<any>): { isLoading: boolean, error: any} {
  const [isLoading, setLoading] = React.useState(true);
  const [error, setError] = React.useState(null);

  useEffect(() => {
    fn()
    .catch((err) => setError(err))
    .finally(() => setLoading(false))
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [])

  return { isLoading, error }
}