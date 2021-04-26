# Vocabulary Learning App

A Flutter progressive web app for building vocabulary.

[![App Build & Deploy](https://github.com/HienM7/vocabulary-learning-app/actions/workflows/firebase_deploy.yml/badge.svg?branch=master)](https://github.com/HienM7/vocabulary-learning-app/actions/workflows/firebase_deploy.yml)

[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/HienM7/vocabulary-learning-app)](#)

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

## Demo

* Live demo: [VocabLearn demo app](https://vocablearn-g3.web.app/#/)
* Screenshots
  * Home Page (for logged-in users)
 
  ![Home Page](https://lh3.googleusercontent.com/Ez2pKK4exHvvqc3VlplwbBHgVAMaUjHgC-3SHSKqeGr_GN9SwLzGsiCFE7VQ29Jg0BKuZuiGfUReV00xFC_C1plNvRuyr0SRD-HsU9rb1biOyGuQa6hIPrWy6LbZsh2Hh45b3gwyi5s)
  
  * Profile Page
  
  ![Profile Page](https://lh4.googleusercontent.com/YkGS4PFEaHmk1BtcWTDM4-f5v_kbmqaIIY37ElRYogv7EuMUGI45yCK8bfaeRzj47DK2x_ITjrSbLACMGMGHywNKMDQVqCmDDSGVMvP2mGI29b29Hwj-Vx-6NvIgV4QdvvCOOCF8tIg)
  
  * Word List Page

  ![Word List Page](https://lh5.googleusercontent.com/dSumORsMjNbGCFfLNcRTA-sPvs5iY6Kmqdkz436132b4AFDxFENxC2J_oKOeNxDsc5Y2n6Vm-hXDHYCjduEPlb2Sv3LbpzJiwLRLygiBbpvTyjy9CKwsrW4XeSFnslR3FvkxT---bZM)
  
  * Quiz Game Page
  
  ![Quiz Game Page](https://lh4.googleusercontent.com/jsU0fs9D9hPcJZe3Uh3GQNAENrK3qRqIeOsQ4wPCLj18gRH4ytjrcJiNdu5Ba6gXqZnJF157MvoOZeKlafahntN2rX150AZ2kBi4oGerdZe7AXhf-Slakl-EF-4uKZBHvjxPkzWEl-8)
  
  * Notification Page
  
  ![Notification Page](https://lh3.googleusercontent.com/jufF9jtUtuMizRLnKTKRO05cR346OX87gbd6sZrcP8jYMv729-TTcOZOiPx5UBGLV9M5XY_QpyAFybEKbYLHkKjZXmpUGiVoM6gtdc7mNIW3p5Kkt1R473X7v8dRfSb-jxMpoDD_h_E)

## Installation and Setup

* Install essential tools
    * Git
    * VS Code
    * Flutter extension for VS Code

* Install dev tools
    * Android Studio (no emulator needed)
    * Node.js
    * Flutter

* Sign up Firebase account and create a project

* Init and configure the project for Firebase

* Go to Firebase Firestore and create a database

## Database collections (examples)

* Word list: `/lists/ibOLQZDHV1Wz6vNzCy5L`
  ```javascript
  {
    id: "ibOLQZDHV1Wz6vNzCy5L",
    name: "Default list name",
    description: "Sample list description.",
    creator_id: "BXdTNFyd2gajVD4JI4N5EKrVPLA3",
    created_at: "April 12, 2021 at 11:11:11 AM UTC+7",
    collab_ids: [
      "oTRDemURxOY9ZnC4XH9kpl9KafD3"
    ],
    tags: [ "animal", "four-legged" ],
    words: [
      {
        id: "uejbmo9OdocqMP83KaHr",
        definition: "feline, puss, kitty, kitten",
        level: 1,
        created_at: "April 13, 2021 at 12:12:12 PM UTC+7"
      }
    ]
  }
  ```

* User / Profile: `/profiles/BXdTNFyd2gajVD4JI4N5EKrVPLA3`
  ```javascript
  {
    code: "VN"
    created_at: "April 7, 2021 at 1:01:01 AM UTC+7",
    dial_code: "+84",
    display_name: "John Doe",
    email: "johndoe@gmail.com",
    first_language: "Indian",
    introduction: "Hi, my name is John Doe. Just call me John.",
    name: "John Doe",
    user_id: "BXdTNFyd2gajVD4JI4N5EKrVPLA3"
  }
  ```
  
* Game: `/quizgames/Gpgd9QKV4G7E0nI8V5Gl`
  ```javascript
  {
    id: "Gpgd9QKV4G7E0nI8V5Gl",
    list_id: "ibOLQZDHV1Wz6vNzCy5L",
    rem_word_ids: [
      "uejbmo9OdocqMP83KaHr"
    ],
    created_at: "April 13, 2021 at 10:10:10 AM UTC+7"
  }
  ```

* Notification: `/notifs/lCj3cx6ynsd8FuIFhCPt`
  ```javascript
  {
    content: "Joe invited you to collab on his list Abc.",
    type: "invite",
    seen: false,
    actions: [ "accept", "decline" ],
    created_at: "April 13, 2021 at 9:09:09 AM UTC+7",
    sender_id: "BXdTNFyd2gajVD4JI4N5EKrVPLA3",
    receiver_ids: [
      "oTRDemURxOY9ZnC4XH9kpl9KafD3"
    ]
    action_data: {
      list_id: "ibOLQZDHV1Wz6vNzCy5L"
    }
  }
  ```

## Sitemap

| Path | Page | Description |
| ---  | :---:| ---         |
| `/`, `/home`  | Landing page | The home page for users who is not logged in        |
| `/homepage`  | Home page | The home page for users who is logged in         |
| `/login`  | Login page | The login page         |
| `/signup`  | Signup page | The signup page         |
| `/my/profile`  | Profile page | The page showing the user's profile         |
| `/my/profile/update`  | Update Profile page | The page allowing the user to edit his/her profile         |
| `/my/notifications`  | Notification page | The page listing all notifications of the user         |
| `/my/lists`  | My Lists page | The page showing the user's own lists         |
| `/my/lists/:id`  | My List Detail page | The page showing a word list of the user with details like words, meanings, etc., where `:id` is the list's id         |
| `/wordlists`  | Word Lists page | The page showing all public lists         |
| `/wordlists/:id`  | Word List Detail page | The page showing a (public or shared) word list with details like words, meanings, etc., where `:id` is the list's id         |
| `/wordlists-show/:id_encoded`  | Word List Detail page | The page showing a (public or shared) word list with details like words, meanings, etc., where `:id_encoded` is the list's id encoded in base64 (for sharing purposes)        |
| `/wordlists/new`  | New Word List page | The page for creating a new word list         |
| `/users/:id`  | User page | The page showing a user's profile with the id `:id`         |
| `/quizgame/:id`  | Practice page | The page providing the user with a MCQ game that helps him/her remember the words better         |
| `/changepass`  | Password Change page | The page where the user can change his/her password |

## Testing

* For frontend app (Flutter)
    * Run `flutter run -d chrome`

* For backend app / API (using Firebase + Firestore):
    * API client (Postman / curl)

## Deployment

* Manual deployment
    * `flutter build web`
    * `firebase deploy`

* Deployment with Github Actions
    * Add FIREBASE_TOKEN and PROJECT_ID to Github secrets / environment variables (details in [this comment](https://github.com/HienM7/vocabulary-learning-app/pull/15#issuecomment-812800236))
    * The workflow will be triggered on push for the `master` branch, releasing a new version of the app

## App features

* Authentication with email verification

* CRUD vocabulary lists

* CRUD words in lists

* Share lists by links (view-only permission) and by adding collaborators (view & update permissions)

* View and update profile

* Practice to remember vocabulary with quiz games (multiple choice questions)

* Dark theme
