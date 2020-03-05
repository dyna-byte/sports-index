/**
 * Construct class names conditionally
 */
export default function clsx(...args: any[]): string {
  console.log(args);
  return args
  .flatMap(transformArg)
  .filter(a => a)
  .join(" ");
}

function transformArg(arg): string | undefined | (string | undefined)[] {
  switch(typeof(arg)) {
    case 'string':
      return arg;
    case 'object':
      return transformObject(arg)
    default:
      return undefined;
  }
}

function transformObject(obj) {
  return Object.keys(obj)
  .map(k => obj[k] ? k : undefined)
}
