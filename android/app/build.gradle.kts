import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Resolve signing credentials from either environment variables (CI / GitHub Actions
// secrets) or a local, gitignored android/key.properties file.
val releaseKeystoreFile: File? = System.getenv("KEYSTORE_PATH")?.let { File(it) }
        ?: file("../key.properties").let { propsFile ->
            if (propsFile.exists()) {
                val props = Properties().apply {
                    load(FileInputStream(propsFile))
                }
                File(props.getProperty("storeFile"))
            } else {
                null
            }
        }

val resolvedReleaseStorePassword: String? = System.getenv("KEYSTORE_STORE_PASSWORD")
        ?: file("../key.properties").takeIf { it.exists() }?.let {
            Properties().apply { load(FileInputStream(it)) }.getProperty("storePassword")
        }

val resolvedReleaseKeyPassword: String? = System.getenv("KEYSTORE_KEY_PASSWORD")
        ?: file("../key.properties").takeIf { it.exists() }?.let {
            Properties().apply { load(FileInputStream(it)) }.getProperty("keyPassword")
        }

val resolvedReleaseKeyAlias: String? = System.getenv("KEYSTORE_KEY_ALIAS")
        ?: file("../key.properties").takeIf { it.exists() }?.let {
            Properties().apply { load(FileInputStream(it)) }.getProperty("keyAlias")
        }

val hasReleaseConfig = releaseKeystoreFile != null && releaseKeystoreFile!!.exists() &&
        resolvedReleaseStorePassword != null && resolvedReleaseKeyPassword != null &&
        resolvedReleaseKeyAlias != null

android {
    namespace = "com.flyfulfarms.app"
    compileSdk = 35
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    signingConfigs {
        if (hasReleaseConfig) {
            create("release") {
                storeFile = releaseKeystoreFile
                storePassword = resolvedReleaseStorePassword
                keyAlias = resolvedReleaseKeyAlias
                keyPassword = resolvedReleaseKeyPassword
            }
        }
    }

    defaultConfig {
        applicationId = "com.flyfulfarms.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Fall back to debug signing only when release credentials are unavailable.
            val releaseConfig = signingConfigs.findByName("release")
            if (releaseConfig != null) {
                signingConfig = releaseConfig
            } else {
                signingConfig = signingConfigs.getByName("debug")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
