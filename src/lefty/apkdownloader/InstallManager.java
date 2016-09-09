package lefty.apkdownloader;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Environment;
import android.util.Log;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.UUID;

public class InstallManager extends AsyncTask<String, String, String> {

    private Context context;

    public InstallManager(Context context){
        this.context = context;
    }
    @Override
    protected String doInBackground(String... f_url) {
        String url = f_url[0];
        return downloadFile(url);
    }

    @Override
    protected void onPostExecute(String file_url) {

        Log.d("InstallManager", "File Downloaded");

        try{
            downloadApk(file_url);
        }catch (Exception e){

        }

    //PrefManager.getInstance(context).isInstalling(false);

    }


    private void downloadApk(String url) {

        File file  = new File(url);

        if(file.exists()) {

            Log.d("InstallManager", "Installing APK");

            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setDataAndType(Uri.fromFile(file), "application/vnd.android.package-archive");
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            context.startActivity(intent);
        }
    }


private String downloadFile(String fileURL){

    try {
        fileURL = getFinalURL(fileURL);
    }catch (Exception e){
        e.printStackTrace();
    }

    Log.d("InstallManager", "Downloding FIle");
    final File mMap = new File(Environment.getExternalStorageDirectory() + File.separator + "download_1");

    mMap.mkdir();
    File _temp = null;

    try {
        String map_name = getUUID() + ".apk";
        _temp = new File(mMap, map_name);

        InputStream is = new URL(fileURL).openStream();
        OutputStream os = new FileOutputStream(_temp);
        copyStream(is, os);
        os.close();
    } catch (Exception e) {
        // TODO: handle exception
        e.printStackTrace();
    }

    return _temp.getPath();
}

    public static void copyStream(InputStream is, OutputStream os)
            throws Exception {
        final int buffer_size = 1024;
        byte[] bytes = new byte[buffer_size];
        for (;;) {
            Log.d("InstallManager", "Downloding...");
            int count = is.read(bytes, 0, buffer_size);
            if (count == -1)
                break;
            os.write(bytes, 0, count);
        }
    }
    public static String getUUID(){
        return UUID.randomUUID().toString();
    }

    public static String getFinalURL(String url) throws IOException {
        HttpURLConnection con = (HttpURLConnection) new URL(url).openConnection();
        con.setInstanceFollowRedirects(false);
        con.connect();
        con.getInputStream();

        if (con.getResponseCode() == HttpURLConnection.HTTP_MOVED_PERM || con.getResponseCode() == HttpURLConnection.HTTP_MOVED_TEMP) {
            String redirectUrl = con.getHeaderField("Location");
            return getFinalURL(redirectUrl);
        }
        return url;
    }

}