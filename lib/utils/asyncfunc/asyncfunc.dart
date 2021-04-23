Function asyncFunction(Function func, {props}) =>
    () async => props != null ? await func(props) : await func();
