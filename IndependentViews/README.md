# Independent Views

Experimenting with views that have no dependency to external model or types.

This is accomplished by letting the views define:

* the structure of the data they render
* the type of Msgs (events really) that they can emit

Pros:

* views are independent from other modules, need not import the whole universe, this has a certain elegance

Cons:

* instead of having a central location where all your app Msgs are defined, you now have to look at the views
* you have to wrap view Msgs in a super Msg type, which can be a bit cumbersome
