function recipe_key(a, b) {
    return string(min(a,b)) + "_" + string(max(a,b));
}