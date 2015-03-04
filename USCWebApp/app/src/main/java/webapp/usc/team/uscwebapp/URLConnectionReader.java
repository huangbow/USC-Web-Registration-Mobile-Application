package webapp.usc.team.uscwebapp;
import android.os.AsyncTask;
import android.os.StrictMode;

import java.net.*;
import java.io.*;

public class URLConnectionReader  extends AsyncTask<String, Void, String> {
    private String inputLine;
    String json="";

    public String URLreader(String url) {
        try {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
            url=url.replaceAll(" ","%20");
            URL oracle = new URL("http://52.1.208.251/"+url);

            URLConnection yc = oracle.openConnection();
            if(url.contains("student/") || url.contains("calendar/")) {
                yc.setDoOutput(true);
            }
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    yc.getInputStream()));

            while ((inputLine = in.readLine()) != null)
                json=json+inputLine;
            in.close();

        }
        catch(Exception e){
            e.printStackTrace();
        }
        return json;
    }
    protected String doInBackground(String... arg0) {
        return null;
    }

}