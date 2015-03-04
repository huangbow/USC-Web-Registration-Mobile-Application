package webapp.usc.team.uscwebapp;

/**
 * Created by Shashank on 2/19/2015.
 */
import android.app.AlertDialog;
import android.app.Fragment;
import android.app.FragmentManager;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.TextView;

import org.json.JSONObject;

public class FragmentOne extends Fragment {

    ImageView ivIcon;
    TextView tvItemName;

    public static final String IMAGE_RESOURCE_ID = "iconResourceID";
    public static final String ITEM_NAME = "itemName";

    public FragmentOne() {

    }
String name,major,degree,username,token;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.user_profile, container,
                false);
        Bundle bundle=this.getArguments();
        username=bundle.getString("userName");
        token=bundle.getString("token");
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
        TextView editText=(TextView)view.findViewById(R.id.editText);
        editText.setText(name);
        TextView editText1=(TextView)view.findViewById(R.id.editText1);
        editText1.setText(major);
        TextView editText2=(TextView)view.findViewById(R.id.editText2);
        editText2.setText(degree);

/*
        ivIcon = (ImageView) view.findViewById(R.id.frag1_icon);
        tvItemName = (TextView) view.findViewById(R.id.frag1_text);

        tvItemName.setText(getArguments().getString(ITEM_NAME));
        ivIcon.setImageDrawable(view.getResources().getDrawable(
                getArguments().getInt(IMAGE_RESOURCE_ID)));*/
        final ImageButton button = (ImageButton) view.findViewById(R.id.buttonAdd);
        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Fragment fragment = null;
                Bundle args = new Bundle();
                args.putString("userName",username);
                args.putString("token",token);
                fragment = new UserProfileEdit();
                fragment.setArguments(args);
                FragmentManager frgManager = getFragmentManager();
                frgManager.beginTransaction().replace(R.id.content_frame, fragment)
                        .commit();}
            });
                return view;
            }
    @Override
    public void onResume() {
        super.onResume();

        getView().setFocusableInTouchMode(true);
        getView().requestFocus();
        getView().setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {

                if (event.getAction() == KeyEvent.ACTION_UP && keyCode == KeyEvent.KEYCODE_BACK) {
                    DialogInterface.OnClickListener dialogClickListener = new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            switch (which) {
                                case DialogInterface.BUTTON_POSITIVE:
                                    Intent intent = new Intent(getActivity(), Login.class);
                                    startActivity(intent);
                                    break;

                                case DialogInterface.BUTTON_NEGATIVE:

                                    break;
                            }
                        }
                    };

                    AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                    builder.setMessage("Do you want to log out?").setPositiveButton("Yes", dialogClickListener)
                            .setNegativeButton("No", dialogClickListener).show();

                    return true;
                }
                return false;
            }
        });
    }

        }