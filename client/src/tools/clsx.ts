/**
 * Construct class names conditionally
 */
export default function clsx(...args) {
  return args.filter(a => a)
  .join(" ");
}