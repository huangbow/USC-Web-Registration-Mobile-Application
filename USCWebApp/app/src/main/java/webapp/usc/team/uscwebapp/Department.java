package webapp.usc.team.uscwebapp;

/**
 * Created by Shashank on 2/19/2015.
 */
import android.app.Fragment;
import android.app.FragmentManager;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ExpandableListView;
import android.widget.ImageView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.simple.parser.JSONParser;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class Department extends Fragment {

    ImageView ivIcon;
    TextView tvItemName;
String json1;
    public static final String IMAGE_RESOURCE_ID = "iconResourceID";
    public static final String ITEM_NAME = "itemName";
    String username;
    int term=20151;

    public Department() {

    }
    ExpandableListAdapter listAdapter;
    ExpandableListView expListView;
    List<String> listDataHeader;
    List<String> listDataHeader1;
    HashMap<String, List<String>> listDataChild;
    HashMap<String, List<String>> listDataChild1;
    ProgressBar spinner;
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.department_activity, container,
                false);
        spinner = (ProgressBar)view.findViewById(R.id.progressBar1);

        Bundle bundle = this.getArguments();
        term = bundle.getInt("term");
        username=bundle.getString("userName");
        if(0==bundle.getInt("term"))
            term=20151;
        expListView = (ExpandableListView)view.findViewById(R.id.lvExp);

try {
    spinner.setVisibility(View.VISIBLE);
    URLConnectionReader urlConnectionReader = new URLConnectionReader();
    json1 = urlConnectionReader.URLreader("misc/dept");
    //System.out.println(json1);



    JSONObject jsonobject = new JSONObject(json1);
    Iterator<String> iter=jsonobject.keys();
    listDataHeader = new ArrayList<String>();
    listDataHeader1 = new ArrayList<String>();
    listDataChild = new HashMap<String, List<String>>();
    listDataChild1 = new HashMap<String, List<String>>();
    int count=0;
    while(iter.hasNext()){


        String schoolCode=iter.next();
        JSONObject depts = jsonobject.getJSONObject(schoolCode).getJSONObject("departments");
        String schoolName = jsonobject.getJSONObject(schoolCode).getString("name");

        listDataHeader.add(schoolName);
        listDataHeader1.add(schoolName);
        Iterator<String> iter1=depts.keys();
        List<String> top250 = new ArrayList<String>();
        List<String> code = new ArrayList<String>();
        while(iter1.hasNext()){
            String departmentCode = iter1.next();
            //departmentCode - is department code like CSCI
            //depts.get(departmentCode) - is department name like Computer Science
            String departmentName=(String) depts.get(departmentCode);
            top250.add(departmentName);
            code.add(departmentCode);
        }
        listDataChild.put(listDataHeader.get(count), top250);
        listDataChild1.put(listDataHeader1.get(count), code);
        count++;
    }


} catch(Exception e){e.printStackTrace();}


        expListView.setOnGroupClickListener(new ExpandableListView.OnGroupClickListener() {



            @Override
            public boolean onGroupClick(ExpandableListView parent, View v,
                                        int groupPosition, long id) {
                // Toast.makeText(getApplicationContext(),
                // "Group Clicked " + listDataHeader.get(groupPosition),
                // Toast.LENGTH_SHORT).show();
                return false;
            }
        });

        // Listview Group expanded listener
        expListView.setOnGroupExpandListener(new ExpandableListView.OnGroupExpandListener() {

            @Override
            public void onGroupExpand(int groupPosition) {
               /* Toast.makeText(getActivity(),
                        listDataHeader.get(groupPosition) + " Expanded",
                        Toast.LENGTH_SHORT).show();*/
            }
        });

        // Listview Group collasped listener
        expListView.setOnGroupCollapseListener(new ExpandableListView.OnGroupCollapseListener() {

            @Override
            public void onGroupCollapse(int groupPosition) {
                /*Toast.makeText(getActivity(),
                        listDataHeader.get(groupPosition) + " Collapsed",
                        Toast.LENGTH_SHORT).show();*/

            }
        });

        // Listview on child click listener
        expListView.setOnChildClickListener(new ExpandableListView.OnChildClickListener() {

            @Override
            public boolean onChildClick(ExpandableListView parent, View v,
                                        int groupPosition, int childPosition, long id) {
                // TODO Auto-generated method stub
                /*Toast.makeText(
                        getActivity(),
                        listDataHeader.get(groupPosition)
                                + " : "
                                + listDataChild.get(
                                listDataHeader.get(groupPosition)).get(
                                childPosition)+"Code:"+ listDataChild1.get(
                                listDataHeader1.get(groupPosition)).get(
                                childPosition), Toast.LENGTH_SHORT)
                        .show();*/
                Fragment fragment = null;
                Bundle args = new Bundle();
                args.putInt("type",1);
                args.putString("code",listDataChild1.get(listDataHeader1.get(groupPosition)).get(childPosition));
                args.putInt("term",term);
                args.putString("userName",username);
                fragment = new FragmentTwo();
                fragment.setArguments(args);
                FragmentManager frgManager = getFragmentManager();
                frgManager.beginTransaction().replace(R.id.content_frame, fragment)
                        .commit();
                return false;
            }
        });



       /* ivIcon = (ImageView) view.findViewById(R.id.frag3_icon);
        tvItemName = (TextView) view.findViewById(R.id.frag3_text);

        tvItemName.setText(getArguments().getString(ITEM_NAME));
        ivIcon.setImageDrawable(view.getResources().getDrawable(
                getArguments().getInt(IMAGE_RESOURCE_ID)));*/
        listAdapter = new ExpandableListAdapter(getActivity(), listDataHeader, listDataChild);
        expListView.setAdapter(listAdapter);
        spinner.setVisibility(View.GONE);
        return view;
    }

}
