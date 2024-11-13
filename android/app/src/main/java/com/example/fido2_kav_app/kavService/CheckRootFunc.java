package com.example.fido2_kav_app.kavService;

import android.content.Context;
import android.util.Log;

import com.kavsdk.KavSdk;
import com.kavsdk.antivirus.Antivirus;
import com.kavsdk.antivirus.AntivirusInstance;
import com.kavsdk.license.SdkLicense;
import com.kavsdk.license.SdkLicenseException;
import com.kavsdk.rootdetector.RootDetector;

import java.io.File;
import java.io.IOException;

import io.flutter.plugin.common.MethodChannel;

public class CheckRootFunc {
    private static final String TAG = "CheckRootFunc";
    private static Antivirus mAntivirusComponent;
    private static Context mContext;

    public CheckRootFunc(Context context) {
        mContext = context; // Initialize context
    }

    // Method to check root status
    public static void isDeviceRooted(Context context, MethodChannel.Result result) {
        mContext = context; // Ensure mContext is properly initialized

        try {
            initializeSdk(context); // Initialize SDK here

            boolean isRootedDevice = RootDetector.getInstance().checkRoot();
            String status = isRootedDevice ? "YES" : "NO";
            result.success(status);
        } catch (SdkLicenseException | IOException e) {
            Log.e(TAG, "Root detection failed: " + e.getMessage());
            result.error("ERROR", "Root detection failed: " + e.getMessage(), null);
        }
    }

    // Method to initialize the SDK and antivirus component
    private static void initializeSdk(Context context) throws SdkLicenseException, IOException {
        mAntivirusComponent = AntivirusInstance.getInstance();
        File basesPath = context.getDir("bases", Context.MODE_PRIVATE);
        KavSdk.initSafe(mContext, basesPath, null, getNativeLibsPath());

        SdkLicense license = KavSdk.getLicense();
        if (!license.isValid()) {
            license.activate(null);
        }

        File scanTmpDir = context.getDir("scan_tmp", Context.MODE_PRIVATE);
        File monitorTmpDir = context.getDir("monitor_tmp", Context.MODE_PRIVATE);
        mAntivirusComponent.initAntivirus(mContext,
                scanTmpDir.getAbsolutePath(), monitorTmpDir.getAbsolutePath());
    }

    private static String getNativeLibsPath() {
        // Your implementation to get native libs path
        return null;
    }
}