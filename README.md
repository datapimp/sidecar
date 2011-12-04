Sidecar
=======

Sidecar is a utility which runs along side your rails server in development.  It runs your tests when files change, it pushes CSS changes directly to your browser, it pushes Javascript changes to your browser.  It allows you to evaluate ruby code from your editor within the running rails environment.  

It comes with Vim plugins for highlighting snippets of CSS or Javascript and applying them live in the browser.  It allows you to run single specs / tests from within vim, evalutes ruby code from your editor from inside the running rails environment, etc.

Starting the development server
===============================
rackup config.ru -s thin -E production

Contributing to sidecar
=======================
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Copyright
=========

Copyright (c) 2011 Jonathan Soeder. See LICENSE.txt for
further details.

