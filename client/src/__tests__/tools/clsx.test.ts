import clsx from 'src/tools/clsx';

it("generates the classnames", () => {
  const result = clsx("a", "z" && false, {"b": false, "c": undefined, "d": null, "e": true});
  const expected = "a e";

  expect(result).toEqual(expected);
})