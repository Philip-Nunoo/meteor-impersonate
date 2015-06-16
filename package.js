Package.describe({
  name: 'nunoo:impersonate',
  version: '0.0.1',
  summary: "Impersonate other users and provide assistance as admin.",
  git: 'https://github.com/Philip-Nunoo/meteor-impersonate.git',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  both = ['client','server']

  api.versionsFrom('1.1.0.2');
  api.use([
    'gwendall:body-events',
    'templating',
    'accounts-base'
  ], 'client');

  api.use([
    'coffeescript',
    'reactive-var',
  ], both);

  api.addFiles([
    'lib/server/impersonate.coffee'
  ], 'server');

  api.addFiles([
    'lib/client/impersonate.coffee'
  ], 'client');

  api.export('Impersonate');

  // api.addFiles('impersonate.js');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('nunoo:impersonate');
  api.addFiles('impersonate-tests.js');
});
