package com.example.law_app

import android.os.Bundle
import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.analytics.Analytics
import com.microsoft.appcenter.crashes.Crashes
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Initialize App Center
        AppCenter.start(
            application, 
            ""884aed5c-d4d3-437d-acf5-6fb224e3d728"", 
            Analytics::class.java, 
            Crashes::class.java
        )
    }
}
