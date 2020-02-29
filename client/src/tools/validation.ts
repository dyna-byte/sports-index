/**
 * Generate a validator function
 * @param {*} rules a set of field rules and their validators
 */
export function validator(rules: {field: string, validators: ((data: string) => string | undefined)[]}[]) {
  return (values) => {
    const errors = {};

    for(const rule of rules) {
      const fieldname = rule.field;
      const value = values[fieldname];

      for (const val of rule.validators) {
        const error = val(value);

        if (error) {
           errors[fieldname] = error;
           break;
        }
      }
    }

    return errors;
  };
}

const commonRegs = {
  email: /^\S+@\S+\.\S+$/
};

export const validators = {
  required: () =>  (data) => {
    return data ? undefined : "Required" 
  },
  min: (min) => (data) => {
    return data && (data.length >= min)
      ? undefined
      : `Minimum of ${min} characters`;
  },
  max: (max) => (data) => {
    return data && (data.length < max)
      ? undefined
      : `Maximum of ${max} characters`;
  },
  pattern: (pattern: RegExp, error?: string) => (data) => 
    pattern.test(data)
      ? undefined
      : (error || `Does not match ${pattern}`)
  ,
  email: () => validators.pattern(commonRegs.email, "Invalid Email"),
}