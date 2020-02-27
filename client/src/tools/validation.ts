/**
 * Generate a validator function
 * @param {*} rules a set of rules in format, {field: 'fieldname', required: true/false, min: minimum, max: maximum}
 */
export function validator(rules: any) {
  return (values) => {
    const errors = {};

    for(let rule of rules) {
      const fieldname = rule.field;
      const value = values[fieldname];

      if (rule.required && !value) {
        errors[fieldname] = 'Required'
      }

      if (rule.min && value < rule.min) {
        errors[fieldname] = `Minimum of ${rule.min} characters`
      }

      if (rule.max && value > rule.max) {
        errors[fieldname] = `Maximum of ${rule.max} characters`
      }
    }

    return errors;
  };
}