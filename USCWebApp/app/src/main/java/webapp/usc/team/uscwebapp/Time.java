package webapp.usc.team.uscwebapp;

/**
 * Created by Shashank on 2/19/2015.
 */
import android.app.Fragment;
import android.app.FragmentManager;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.TimePicker;

public class Time extends Fragment {

    ImageView ivIcon;
    TextView tvItemName;

    public static final String IMAGE_RESOURCE_ID = "iconResourceID";
    public static final String ITEM_NAME = "itemName";
String tType;
    int tStart,tEnd;
    TimePicker timePicker1,timePicker2;
    public Time() {

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        Bundle bundle = this.getArguments();
        final String code = bundle.getString("code");
        final int term1=bundle.getInt("term");
        final int weight=bundle.getInt("weight");
        final String pRating=bundle.getString("pRating");
        final View view = inflater.inflate(R.layout.time_picker, container,
                false);


        Button days=(Button)view.findViewById(R.id.set);
        days.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                RadioGroup radioGroup=(RadioGroup)view.findViewById(R.id.tType);
                RadioButton radioButton;
                int selectedId = radioGroup.getCheckedRadioButtonId();
                radioButton = (RadioButton) view.findViewById(selectedId);
                tType=(String)radioButton.getText();
                timePicker1=(TimePicker)view.findViewById(R.id.timePicker);
                timePicker2=(TimePicker)view.findViewById(R.id.timePicker1);
                tStart=Integer.parseInt(Integer.toString(timePicker1.getCurrentHour())+Integer.toString(timePicker1.getCurrentMinute()));
                tEnd=Integer.parseInt(Integer.toString(timePicker2.getCurrentHour())+Integer.toString(timePicker2.getCurrentMinute()));
                System.out.println(tStart);
                Fragment fragment = null;
                Bundle args = new Bundle();
                fragment = new FragmentTwo();
                args.putInt("type",3);
                args.putInt("weight",weight);
                args.putString("code", code);
                args.putInt("term",term1);
                args.putInt("tStart",tStart);
                args.putInt("tEnd",tEnd);
                args.putString("tType", tType);
                args.putString("pRating",pRating);
                fragment.setArguments(args);
                FragmentManager frgManager = getFragmentManager();
                frgManager.beginTransaction().replace(R.id.content_frame, fragment)
                        .commit();
            }
        });

       /* ivIcon = (ImageView) view.findViewById(R.id.frag3_icon);
        tvItemName = (TextView) view.findViewById(R.id.frag3_text);

        tvItemName.setText(getArguments().getString(ITEM_NAME));
        ivIcon.setImageDrawable(view.getResources().getDrawable(
                getArguments().getInt(IMAGE_RESOURCE_ID)));*/
        return view;
    }
    private static String pad(int c) {
        if (c >= 10)
            return String.valueOf(c);
        else
            return "0" + String.valueOf(c);
    }

}
