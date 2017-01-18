app = angular.module('folio.Locale', ['pascalprecht.translate'])

app.config(['$translateProvider', ($translateProvider) ->
  $translateProvider.translations('en', {
    #nav
    'nav-title': 'Level Designer'
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
    'install-3-warn': 'I\'m only making sure the link opens in the steam client.'
    'install-3-alt': '-Alternatively, subscribe'
    'install-3-alt2': 'from your bowser.'
    'install-4': 'Load the map ingame'
    'install-4-warn': '-This link might not work if the game client is already open'
    'install-4-alt': '-Alternatively, you can load the map from the main menu with "Start playing", and then "Create server". Find the map you\'re looking for in the dropdown menu and proceed forward.'
    'install-warn': "-This link may be reported as potentially harmful by your browser. These types of links can indeed be dangerous but there's nothing fishy hidden in this one."
    #blurbs
    'vanguard': 'Initially designed as a control point map for competitive play, Vanguard was an attempt at making a map focused around fast paced gameplay. The design of the map allows it to perform nicely in public play as well as in competitive environments. The goal was to make a map that rewards aggressive gameplay and good positioning. The result is a fast paced and punishing map that often results in a great back and forth game between the opposing teams.'
    'occult': 'Featuring a completely new visual theme, the control point of this map is an old relic with unknown powers. We don’t know why Blue and Red are fighting over it but it looks important! They have no idea what that thing has in store for them however. I consider this map to be one of my finest work for the technical achievement it represents. The map features many special effects of my own including complex animations, particle systems and textures that use source’s shaders at their fullest.'
    'hadal': 'Lorem Ipsum'
    'effigy': 'Lorem Ipsum'
    #quotes
    'toughbreak': 'Added to Team Fortress 2 as part of the '
    'toughbreak2': '"Tough Break" update'
    'pcgamer': '"Great TF2 community map"'
    #contact
    'contact' : 'Want to get in touch?'
    'contactblurb': "There's a lot of places where you can reach me, you'll find most of them here."
    'contacttrue' : '(The only true way to my heart is via email tho)'
    'findme': 'Find me around the web!'
    'contactme': 'Contact me!'
    'languages': 'in french or english'
    'address' : '1981, Tillemont street'
    'status': 'Status:'
    'available': 'Available'
    'unavailable': 'Unavailable'
    'hire': 'for hire'
    'contract': 'for contract'
    'cv': 'Add this one to the pile!'
  })
  $translateProvider.translations('fr', {
    #nav
    'nav-title': 'Concepteur de niveau'
    'nav-commercial': 'Travail commercial'
    'nav-hobby': 'Projets personnels'
    'nav-code': '++'
    'nav-contact': 'contact'
    #frontpage
    'welcome': 'Bienvenu sur mon portfolio!'
    'intro' : "Hi, I'm Maxime. Some will say I'm a designer, others will call me a software developer. Truth is, I'm just a builder; I like to make things. My favorite thing is when I get to make things that other people can experience. This is what I'm all about. My infatuation with crafting experiences is what got me into level design. The Team Fortress 2 community has been my testbed of choice for many different design experiments but also a phenomenal place to iterate on gameplay ideas and develop great experiences. It's where I got my start as a level designer... it's where the story began!"
    #maps
    'wanttoplay': 'Vous voulez y jouer?'
    'instructions': 'Instructions'
    'install-1': 'Installez et logez vous dans le client Steam'
    'install-2': 'Installez Team Fortress 2 (gratuit)'
    'install-3': 'Installez le niveau en vous abonnant sur le workshop'
    'install-4': 'Chargez le niveau dans le jeu'
    #quotes
    'toughbreak': 'Ajouter à Team Fortress 2 avec la mise à jour '
    'toughbreak2': '"Tough Break"'
    'pcgamer': '"Great TF2 community map"'
    #contact
    'contact': 'Vous voulez me rejoindre?'
    'contactblurb': "Il y a plusieurs endroits pour me rejoindre, vous trouverez la majorité d'entre eux ici."
    'contacttrue' : "(Parcontre, le vrai chemin vers mon coeur, c'est par email)"
    'findme': 'Trouvez moi sur le web!'
    'contactme': 'Contactez moi!'
    'languages': 'en français ou en anglais'
    'address' : '1981, rue Tillemont'
    'status': 'Statut:'
    'available': 'Disponible'
    'unavailable': 'Non Disponible'
    'hire': 'pour emplois'
    'contract': 'pour contrat'
    'cv': 'Un autre pour la pile!'
  })
  $translateProvider.preferredLanguage('en')
])
