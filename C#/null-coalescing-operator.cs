// https://stackoverflow.com/questions/446835/what-do-two-question-marks-together-mean-in-c

// It's the null coalescing operator,

FormsAuth = formsAuth ?? new FormsAuthenticationWrapper();

// expands to:

FormsAuth = formsAuth != null ? formsAuth : new FormsAuthenticationWrapper();

// which further expands to:

if(formsAuth != null)
    FormsAuth = formsAuth;
else
    FormsAuth = new FormsAuthenticationWrapper();

