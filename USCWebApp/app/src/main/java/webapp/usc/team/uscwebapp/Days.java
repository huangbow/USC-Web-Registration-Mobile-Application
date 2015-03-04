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
import android.widget.CheckBox;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

public class Days extends Fragment {

    ImageView ivIcon;
    TextView tvItemName;

    public static final String IMAGE_RESOURCE_ID = "iconResourceID";
    public static final String ITEM_NAME = "itemName";

    public Days() {

    }
int weight=0;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        Bundle bundle = this.getArguments();
        final String code = bundle.getString("code");
        final int term1=bundle.getInt("term");
        final String pRating=bundle.getString("pRating");
        final int tStart=bundle.getInt("tStart");
        final int tEnd=bundle.getInt("tEnd");
        final String tType=bundle.getString("tType");
        View view = inflater.inflate(R.layout.day_picker, container,
                false);

        final CheckBox monday = (CheckBox) view.findViewById(R.id.monday);
        final CheckBox tuesday = (CheckBox) view.findViewById(R.id.tuesday);
        final CheckBox wednesday = (CheckBox) view.findViewById(R.id.wednesday);
        final CheckBox thursday = (CheckBox) view.findViewById(R.id.thursday);
        final CheckBox friday = (CheckBox) view.findViewById(R.id.friday);
        final CheckBox saturday = (CheckBox) view.findViewById(R.id.saturday);




        Button set=(Button)view.findViewById(R.id.set);
        set.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Fragment fragment = null;
                Bundle args = new Bundle();
                if(monday.isChecked())
                    weight=weight+1;
                else if(tuesday.isChecked())
                    weight=weight+2;
                else if(wednesday.isChecked())
                    weight=weight+4;
                else if(thursday.isChecked())
                    weight=weight+8;
                else if(friday.isChecked())
                    weight=weight+16;
                else if(saturday.isChecked())
                    weight=weight+32;
                fragment = new FragmentTwo();
                args.putInt("type",2);
                args.putInt("weight",weight);
                args.putString("code", code);
                args.putInt("term",term1);
                args.putInt("tStart",tStart);
                args.putInt("tEnd",tEnd);
                args.putString("tType",tType);
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

}
