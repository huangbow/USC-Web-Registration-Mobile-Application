package webapp.usc.team.uscwebapp;

/**
 * Created by Shashank on 2/19/2015.
 */
import android.app.Fragment;
import android.app.FragmentManager;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import org.json.JSONObject;

public class UserProfileEdit extends Fragment {

    ImageView ivIcon;
    TextView tvItemName;

    public static final String IMAGE_RESOURCE_ID = "iconResourceID";
    public static final String ITEM_NAME = "itemName";


public UserProfileEdit(){

}
    String username,token,name,major,degree;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        final View view = inflater.inflate(R.layout.user_profile_edit, container,
                false);
        Bundle bundle=this.getArguments();
        username=bundle.getString("userName");
        token=bundle.getString("token");
        EditText editText=(EditText)view.findViewById(R.id.editText);
        EditText editText1=(EditText)view.findViewById(R.id.editText1);
        EditText editText2=(EditText)view.findViewById(R.id.editText2);
        try {
            URLConnectionReader urlConnectionReader = new URLConnectionReader();
            String json1 = urlConnectionReader.URLreader("student/fetch?username=" + username + "&auth=" + token);

            JSONObject jsonobject1 = new JSONObject(json1);
            JSONObject responseObject = jsonobject1.getJSONObject("responseObject");
            name = responseObject.optString("name","");
            major=responseObject.optString("major","");
            degree=responseObject.optString("degree","");
            major=major.equals("null")?"":major;
            name=name.equals("null")?"":name;
            degree=degree.equals("null")?"":degree;
        }catch(Exception e){e.printStackTrace();}

        editText.setText(name);

        editText1.setText(major);

        editText2.setText(degree);
        final ImageButton button = (ImageButton) view.findViewById(R.id.buttonAdd2);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                EditText editText=(EditText)view.findViewById(R.id.editText);
                EditText editText1=(EditText)view.findViewById(R.id.editText1);
                EditText editText2=(EditText)view.findViewById(R.id.editText2);
                name=editText.getText().toString();

                major=editText1.getText().toString();

                degree=editText2.getText().toString();
                URLConnectionReader urlConnectionReader=new URLConnectionReader();

                urlConnectionReader.URLreader("student/update?username="+username+"&auth="+token+"&major="+major+"&degree="+degree+"&name="+name);
                Fragment fragment = null;
                Bundle args = new Bundle();
                args.putString("userName",username);
                args.putString("token",token);
                fragment = new FragmentOne();
                fragment.setArguments(args);
                FragmentManager frgManager = getFragmentManager();
                frgManager.beginTransaction().replace(R.id.content_frame, fragment)
                        .commit();
                }
        });
/*
        ivIcon = (ImageView) view.findViewById(R.id.frag1_icon);
        tvItemName = (TextView) view.findViewById(R.id.frag1_text);

        tvItemName.setText(getArguments().getString(ITEM_NAME));
        ivIcon.setImageDrawable(view.getResources().getDrawable(
                getArguments().getInt(IMAGE_RESOURCE_ID)));*/
        return view;
    }

}