require('MyClass')
defineClass('MyClass', {
    test: function() {
//        self.ORIGtest();
        self.super().description();
        console.log("jspatch log")
    }
});