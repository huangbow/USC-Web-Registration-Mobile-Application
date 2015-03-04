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
import android.widget.NumberPicker;
import android.widget.RatingBar;
import android.widget.TextView;

public class Professor extends Fragment {

    ImageView ivIcon;
    TextView tvItemName;

    public static final String IMAGE_RESOURCE_ID = "iconResourceID";
    public static final String ITEM_NAME = "itemName";


    public Professor() {

    }

    String pRating;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.prof_activity, container,
                false);
        Bundle bundle=this.getArguments();
        final String code = bundle.getString("code");
        final int term1=bundle.getInt("term");
        final int weight=bundle.getInt("weight");
        final int tStart=bundle.getInt("tStart");
        final int tEnd=bundle.getInt("tEnd");
        final String tType=bundle.getString("tType");
        RatingBar ratingBar=(RatingBar)view.findViewById(R.id.ratingBar);



            //if rating value is changed,
            //display the current rating value in the result (textview) automatically
            ratingBar.setOnRatingBarChangeListener(new RatingBar.OnRatingBarChangeListener() {
                public void onRatingChanged(RatingBar ratingBar, float rating,
                                            boolean fromUser) {

                    pRating=String.valueOf(rating);

                }
            });






        Button set=(Button)view.findViewById(R.id.set);
        set.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Fragment fragment = null;
                Bundle args = new Bundle();
                fragment = new FragmentTwo();
                args.putInt("type",4);
                args.putInt("weight",weight);
                args.putString("code", code);
                args.putInt("term", term1);
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

}
