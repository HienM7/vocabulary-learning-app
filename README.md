# Vocabulary Learning App

A Flutter progressive web app for building vocabulary.

## Demo

* Live demo (unstable): [VocabLearn demo app](https://vocab-learning-k.web.app/#/)
* Screenshots
  * Home Page (logged in)
  ![Home Page](https://trello-attachments.s3.amazonaws.com/6046fcc9a542f0318e02d253/6048d5ea093af035d4047374/9c5590b278a897f897edb9183e876eea/homepage.png)
  * Word List Page
  ![Word List Page](https://trello-attachments.s3.amazonaws.com/6046fcc9a542f0318e02d253/6048d5ea093af035d4047374/044923d324a5c02db7d79b66289bc4e3/listview.png)

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
    creator: "/users/BXdTNFyd2gajVD4JI4N5EKrVPLA3",
    created_at: "April 12, 2021 at 11:11:11 AM UTC+7",
    collaborators: [
      "/users/oTRDemURxOY9ZnC4XH9kpl9KafD3"
    ],
    words: [
      {
        id: "uejbmo9OdocqMP83KaHr",
        definition: "feline, puss, kitty, kitten",
        level: 1,
        created_at: "April 13, 2021 at 12:12:12 PM UTC+7",
        tags: [ "animal", "four-legged" ]
      }
    ]
  }
  ```

* User/Profile: `/users/BXdTNFyd2gajVD4JI4N5EKrVPLA3`
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
    user: "/users/BXdTNFyd2gajVD4JI4N5EKrVPLA3"
  }
  ```
  
* Game: `/games/Gpgd9QKV4G7E0nI8V5Gl`
  ```javascript
  {
    id: "Gpgd9QKV4G7E0nI8V5Gl",
    list: "/lists/ibOLQZDHV1Wz6vNzCy5L",
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
    created_at: "April 13, 2021 at 9:09:09 AM UTC+7"
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
| `/my/lists`  | My Lists page | The page showing the user's own lists         |
| `/my/lists/:id`  | My List Detail page | The page showing a word list of the user with details like words, meanings, etc., where `:id` is the list's id         |
| `/wordlists`  | Word Lists page | The page showing all public lists         |
| `/wordlists/:id`  | Word List Detail page | The page showing a (public or shared) word list with details like words, meanings, etc., where `:id` is the list's id         |
| `/wordlists/new`  | New Word List page | The page for creating a new word list         |
| `/users/:id`  | User page | The page showing a user's profile with the id `:id`         |
| `/quizgame`  | Practice page | The page providing the user with a MCQ game that helps him/her remember the words better         |
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

* CRUD vocabulary lists

* CRUD words in lists

* Share lists by links (view-only) and by adding collaborators (view & update)

* View and update profile

* Practice to remember vocabulary with games (multiple choice questions)
