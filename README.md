# Wyck - A Weather App

![](https://lh3.googleusercontent.com/_O2mCcWhvlNSBcOqn__KY7UQDr4lFUjoHFKc7-MiLFwRlbnilpKnncK3FA9da_-9QA=w1440-h620)

### A Weather App that provides the accurate weather information of the user's current location and other locations too.


### Information about the app:

```
Wyck - A weather app gives accurate weather data of your current Location.

It will also allows you to search the Weather Data of other Cities.

The UI is so Beautiful and Easy to Use .

The User interface change as per the User time and gives the real time weather data.

This app gives information about Temperature, Wind Speed, The timing of Sunset and Sunrise. This app also gives the information about the condition of Sky.
```

## Screenshot 📱
![](https://lh3.googleusercontent.com/H5oRJMclwrYn2lBuVz4AptBh4Wa4Api7kO_OKa9pkj7thH2q-qw8DzOZLgiCJ421k_fo=w1440-h620)
![](https://lh3.googleusercontent.com/HGh-lq5L6UoglDfN4OnKx1TKLoKSrVwBy9MqZBmTfw4gZloHslPlxH85gqqYLrT5grc=w1440-h620)
![](https://lh3.googleusercontent.com/VRrgZO8rvRUEHW9KGPygK954w-Ay_7Ymv2ZVz8srCOjTdXHNoEEzEVK482M31z5g9u0=w1440-h620)
![](https://lh3.googleusercontent.com/17TEUzvGQ9g7D6xOYtnHBk6DduWadvzecQAvzulZr_QMKg-sUbrjppsdKcrHX54qhLg=w1440-h620)

### Show some ❤️ and star the repo to support the project
![](https://github-images.s3.amazonaws.com/help/bootcamp/Bootcamp-Fork.png)

# Building the project 📽

Missing Key.Properties file ❌❌

If you try to build the project straight away, you'll get an error complaining that a key.properties file is missing and Exit 🚪

You have to create your own key and run it (You can follow following steps😉).

1. Open \android\app\build.gradle file and paste following lines without comments.
```
//keystoreProperties.load(new FileInputStream(keystorePropertiesFile))

signingConfigs {
// release {
// keyAlias keystoreProperties['keyAlias']
// keyPassword keystoreProperties['keyPassword']
// storeFile file(keystoreProperties['storeFile'])
// storePassword keystoreProperties['storePassword']
// }
}
buildTypes {
// release {
// signingConfig signingConfigs.release
// }
}
```

2.Open \android\local.properties and add -
```
flutter.versionName=1.0.0
flutter.versionCode=1
flutter.buildMode=release
```


Or you can follow from the Official Doc.https://flutter.dev/docs/deployment/android.


<p>
<a href="https://play.google.com/store/apps/details?id=com.NakumsDtech.waller"><img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" alt="Waller"></a>
</p>

❤ Found this project useful?
If you found this project useful, then please consider giving it a ⭐ on Github and sharing it with your friends via social media.

### LinkedIn Profile
<p>
<a href="https://www.linkedin.com/in/dhruv-nakum-4b1054176/"><img src="https://imageog.flaticon.com/icons/png/512/174/174857.png?size=100x100f&pad=10,10,10,10&ext=png&bg=FFFFFFFF" alt="Waller"></a>
</p>
