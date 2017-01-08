app = angular.module('folio.Locale', ['pascalprecht.translate'])

app.config(['$translateProvider', ($translateProvider) ->
  $translateProvider.translations('en', {
    #nav
    'nav-commercial': 'Commercial work'
    'nav-hobby': 'Hobby projects'
    'nav-code': '++'
    'nav-contact': 'contact'
    #frontpage
    'welcome': 'Welcome to my portfolio!'
    'intro' : "Hi, I'm Maxime. Some will say I'm a designer, others will call me a software developer. Truth is, I'm just a builder; I like to make things. My favorite thing is when I get to make things that other people can experience. This is what I'm all about. My infatuation with crafting experiences is what got me into level design. The Team Fortress 2 community has been my testbed of choice for many different design experiments but also a phenomenal place to iterate on gameplay ideas and develop great experiences. It's where I got my start as a level designer... it's where the story began!"
    #maps
    'wanttoplay': 'Want to play it?'
    'instructions': 'Instructions'
    'install-1': 'Install and log into the Steam client'
    'install-2': 'Install Team Fortress 2 (free to play)'
    'install-3': 'Install The map by subscribing on the workshop'
    'install-4': 'Load the map ingame'
    #contact
    'contact' : 'Want to get in touch?'
    'contactblurb': "There's a lot of places where you can reach me, you'll find most of them here."
    'contacttrue' : '(The only true way to my heart is via email tho)'
    'findme': 'Find me around the web!'
    'contactme': 'Contact me!'
    'languages': 'in french or english'
    'address' : '1981, Tillemont street'
  })
  $translateProvider.translations('fr', {
    #nav
    'nav-commercial': 'Commercial work'
    'nav-hobby': 'Projets personnels'
    'nav-code': '++'
    'nav-contact': 'contact'
    #frontpage
    'welcome': 'Bienvenu sur mon portfolio!'
    'intro' : "Hi, I'm Maxime. Some will say I'm a designer, others will call me a software developer. Truth is, I'm just a builder; I like to make things. My favorite thing is when I get to make things that other people can experience. This is what I'm all about. My infatuation with crafting experiences is what got me into level design. The Team Fortress 2 community has been my testbed of choice for many different design experiments but also a phenomenal place to iterate on gameplay ideas and develop great experiences. It's where I got my start as a level designer... it's where the story began!"
    #maps
    'wanttoplay': 'vous voulez y jouer?'
    'instructions': 'Instructions'
    'install-1': 'Installez et logez vous dans le client Steam'
    'install-2': 'Installez Team Fortress 2 (gratuit)'
    'install-3': 'Installez le niveau en vous abonnant sur le workshop'
    'install-4': 'chargez le niveau dans le jeu'
    #contact
    'contact': 'Vous voulez me rejoindre?'
    'contactblurb': "Il y a plusieurs endroits pour me rejoindre, vous trouverez la majorité d'entre eux ici."
    'contacttrue' : "(Parcontre, le vrai chemin vers mon coeur, c'est par email)"
    'findme': 'Trouvez moi sur le web!'
    'contactme': 'Contactez moi!'
    'languages': 'en francais ou en anglais'
    'address' : '1981, rue Tillemont'
  })
  $translateProvider.preferredLanguage('en')
])
