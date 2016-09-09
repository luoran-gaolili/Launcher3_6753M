//package lefty.ApiCalls;
//
//import android.content.Context;
//import android.content.SharedPreferences;
//import android.os.AsyncTask;
//import android.telephony.TelephonyManager;
//import android.text.TextUtils;
//
//import com.google.android.gms.gcm.GcmPubSub;
//import com.google.android.gms.gcm.GoogleCloudMessaging;
//import com.google.android.gms.iid.InstanceID;
//import com.google.gson.Gson;
//
//import java.io.IOException;
//import java.util.HashMap;
//
//import lefty.CommonsUtils;
//import lefty.GetPublicationsTask;
//import lefty.models.VersionData;
//
///**
// * Created by tajinder on 21/6/16.
// */
//public class GcmCall extends AsyncTask<Void, Void, Boolean> {
//    private static final String TAG = "RegIntentService";
//    private static final String[] TOPICS = {"global"};
//    Context mContext;
//    String token = "";
//    SharedPreferences pref;
//    GetPublicationsTask.TaskCallbacks mCallbacks;
//    String mAppType = "";
//
//    public GcmCall(Context context, GetPublicationsTask.TaskCallbacks callbacks) {
//        mCallbacks = callbacks;
//        mContext = context;
//        pref = mContext.getSharedPreferences(CommonsUtils.SHARED_PREF_NAME, mContext.MODE_PRIVATE);
//    }
//
//    @Override
//    protected void onPreExecute() {
//        super.onPreExecute();
//    }
//
//    @Override
//    protected Boolean doInBackground(Void... params) {
//        InstanceID instanceID = InstanceID.getInstance(mContext);
//        try {
//            token = instanceID.getToken(CommonsUtils.GCM_SENDER_KEY, GoogleCloudMessaging.INSTANCE_ID_SCOPE, null);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        if (!TextUtils.isEmpty(token)) {
//            saveTokenInPref(token);
//        }
//
//        String response = "";
//        String device_id = "";
//        String device_token = "";
//        try {
//            //device_id = mContext.getSharedPreferences(CommonsUtils.SHARED_PREF_NAME, mContext.MODE_PRIVATE).getString("deviceId", "");
//            TelephonyManager tm = (TelephonyManager) mContext.getSystemService(Context.TELEPHONY_SERVICE);
//            device_id = tm.getDeviceId();
//            if (TextUtils.isEmpty(device_id)) {
//                device_id = CommonsUtils.getSecureDeviceId(mContext);
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            if (TextUtils.isEmpty(device_id)) {
//                device_id = CommonsUtils.getSecureDeviceId(mContext);
//            }
//        }
//        device_token = mContext.getSharedPreferences(CommonsUtils.SHARED_PREF_NAME, mContext.MODE_PRIVATE).getString(CommonsUtils.SHARED_PREF_TOKEN_KEY, "");
//
//        String PhoneModel = "";
//        try {
//            PhoneModel = android.os.Build.MODEL;
//        } catch (Exception e) {
//            e.printStackTrace();
//            PhoneModel = "";
//        }
//        HashMap<String, String> mMap = new HashMap<>();
//        mMap.put("device_id", device_id);
//        mMap.put("device_model", PhoneModel);
//        mMap.put("device_token", device_token);
//        try {
//            response = CommonsUtils.requestWebService(CommonsUtils.GET_VERSION, mMap);
//            if (!TextUtils.isEmpty(response) && CommonsUtils.isJSONValid(response)) {
//                Gson gson = new Gson();
//                VersionData vData = gson.fromJson(response, VersionData.class);
//                if (vData != null) {
//                    if (vData.getSuccess()) {
//                        mAppType = vData.getData().getApplicationType();
//                        String apkURL = vData.getData().getNewspoint();
//                        if (!TextUtils.isEmpty(apkURL)) {
//                            saveNewspointAPK_inPref(apkURL);
//                        }
//
//                        if (!TextUtils.isEmpty(mAppType)) {
//                            return true;
//                        }
//
//                    }
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//        subscribeTopics(token);
//
//        return false;
//    }
//
//    @Override
//    protected void onPostExecute(Boolean aBoolean) {
//        super.onPostExecute(aBoolean);
//        if (aBoolean) {
//            mCallbacks.onSucess(mAppType);
//        } else {
//            mCallbacks.onFailure();
//        }
//
//
//    }
//
//    // [START subscribe_topics]
//    private void subscribeTopics(String token) {
//        GcmPubSub pubSub = GcmPubSub.getInstance(mContext);
//        for (String topic : TOPICS) {
//            try {
//                pubSub.subscribe(token, "/topics/" + topic, null);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//    }
//
//    void saveTokenInPref(String token) {
//        SharedPreferences.Editor editor = pref.edit();
//        editor.putString(CommonsUtils.SHARED_PREF_TOKEN_KEY, token);
//        editor.commit();
//    }
//
//    void saveNewspointAPK_inPref(String apkURL) {
//        SharedPreferences.Editor editor = pref.edit();
//        editor.putString(CommonsUtils.SHARED_PREF_NEWSPOINT_KEY, apkURL);
//        editor.commit();
//    }
//
//
//}


package lefty.ApiCalls;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.text.TextUtils;

import com.google.android.gms.gcm.GcmPubSub;
import com.google.android.gms.gcm.GoogleCloudMessaging;
import com.google.android.gms.iid.InstanceID;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.HashMap;

import lefty.CommonsUtils;
import lefty.GetPublicationsTask;
import lefty.models.VersionData;

/**
 * Created by tajinder on 21/6/16.
 */
public class GcmCall extends AsyncTask<Void, Void, Boolean> {
    private static final String TAG = "RegIntentService";
    private static final String[] TOPICS = {"global"};
    Context mContext;
    String token = "";
    SharedPreferences pref;
    GetPublicationsTask.TaskCallbacks mCallbacks;
    String mAppType = "";

    public GcmCall(Context context, GetPublicationsTask.TaskCallbacks callbacks) {
        mCallbacks = callbacks;
        mContext = context;
        pref = mContext.getSharedPreferences(CommonsUtils.SHARED_PREF_NAME, mContext.MODE_PRIVATE);
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    @Override
    protected Boolean doInBackground(Void... params) {
        InstanceID instanceID = InstanceID.getInstance(mContext);
        try {
            token = instanceID.getToken(CommonsUtils.GCM_SENDER_KEY, GoogleCloudMessaging.INSTANCE_ID_SCOPE, null);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (!TextUtils.isEmpty(token)) {
            saveTokenInPref(token);
        }

        String response = "";
        String device_id = "";
        String device_token = "";
        try {
            device_id = mContext.getSharedPreferences(CommonsUtils.SHARED_PREF_NAME, mContext.MODE_PRIVATE).getString("deviceId", "");
            if (TextUtils.isEmpty(device_id)) {
                device_id = CommonsUtils.getSecureDeviceId(mContext);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        device_token = mContext.getSharedPreferences(CommonsUtils.SHARED_PREF_NAME, mContext.MODE_PRIVATE).getString(CommonsUtils.SHARED_PREF_TOKEN_KEY, "");

        String PhoneModel = "";
        try {
            PhoneModel = android.os.Build.MODEL;
        } catch (Exception e) {
            e.printStackTrace();
            PhoneModel = "";
        }
        HashMap<String, String> mMap = new HashMap<>();
        mMap.put("device_id", device_id);
        mMap.put("device_model", PhoneModel);
        mMap.put("device_token", device_token);
        try {
            response = CommonsUtils.requestWebService(CommonsUtils.GET_VERSION, mMap);
            if (!TextUtils.isEmpty(response) && CommonsUtils.isJSONValid(response)) {
                Gson gson = new Gson();
                VersionData vData = gson.fromJson(response, VersionData.class);
                if (vData != null) {
                    if (vData.getSuccess()) {
                        mAppType = vData.getData().getApplicationType();
                        String apkURL = vData.getData().getNewspoint();
                        if (!TextUtils.isEmpty(apkURL)) {
                            saveNewspointAPK_inPref(apkURL);
                        }

                        if (!TextUtils.isEmpty(mAppType)) {
                            return true;
                        }

                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        subscribeTopics(token);

        return false;
    }

    @Override
    protected void onPostExecute(Boolean aBoolean) {
        super.onPostExecute(aBoolean);
        if (aBoolean) {
            mCallbacks.onSucess(mAppType);
        } else {
            mCallbacks.onFailure();
        }


    }

    // [START subscribe_topics]
    private void subscribeTopics(String token) {
        GcmPubSub pubSub = GcmPubSub.getInstance(mContext);
        for (String topic : TOPICS) {
            try {
                pubSub.subscribe(token, "/topics/" + topic, null);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    void saveTokenInPref(String token) {
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(CommonsUtils.SHARED_PREF_TOKEN_KEY, token);
        editor.commit();
    }

    void saveNewspointAPK_inPref(String apkURL) {
        SharedPreferences.Editor editor = pref.edit();
        editor.putString(CommonsUtils.SHARED_PREF_NEWSPOINT_KEY, apkURL);
        editor.commit();
    }


}
