package webapp.usc.team.uscwebapp;

/**
 * Created by Shashank on 2/19/2015.
 */
import android.app.AlertDialog;
import android.app.Fragment;
import android.app.FragmentManager;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.PopupMenu;
import android.widget.ProgressBar;
import android.widget.TextView;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.ExpandableListView;
import android.widget.ExpandableListView.OnChildClickListener;
import android.widget.ExpandableListView.OnGroupClickListener;
import android.widget.ExpandableListView.OnGroupCollapseListener;
import android.widget.ExpandableListView.OnGroupExpandListener;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONObject;


public class FragmentTwo   extends Fragment {

    ImageView ivIcon;
    TextView tvItemName;

    public static final String IMAGE_RESOURCE_ID = "iconResourceID";
    public static final String ITEM_NAME = "itemName";
    String courseId, iRating, title, desc, minU, min, max, maxU, section, dFlag, sectionId, term, session, btime, etime, iday, day, location, registered, instructor, addBy, dropBy, pFlag, pSecFlag;
    ExpandableListViewAdapterCourses listAdapter;
    ExpandableListView expListView;
    List<String> listDataHeader;
    HashMap<String, List<String>> listDataChild;
    String code, json1, tType = "", pRating;
    int type, term1, weight, tStart, tEnd;

    String string,username;
    ProgressBar spinner;
    AlertDialog levelDialog;
    String url,url1;
    int cid[]=new int[2];
    CharSequence[] items={};
    List<String> listItems = new ArrayList<String>();
    public FragmentTwo() {

    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        Bundle bundle = this.getArguments();
        code = bundle.getString("code");
        type = bundle.getInt("type");
        term1 = bundle.getInt("term");
        weight = bundle.getInt("weight");
        tStart = bundle.getInt("tStart");
        tEnd = bundle.getInt("tEnd");
        tType = bundle.getString("tType");
        string = bundle.getString("string");
        pRating = bundle.getString("pRating");
        username=bundle.getString("userName");
        final View view = inflater.inflate(R.layout.activity_courses, container, false);
        spinner = (ProgressBar)view.findViewById(R.id.progressBar1);
        Button button = (Button) view.findViewById(R.id.button3);
        Button button1 = (Button) view.findViewById(R.id.button2);
        final EditText editText = (EditText) view.findViewById(R.id.textView);

        editText.setText(string);
        //filter button

        //search button
        // get the listview
        expListView = (ExpandableListView) view.findViewById(R.id.lvExp);
        spinner.setVisibility(View.VISIBLE);
        if (type == 1) {

            int course, seats, termCode;
            URLConnectionReader urlConnectionReader = new URLConnectionReader();
            json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code);
            try {
                listDataHeader = new ArrayList<String>();
                listDataChild = new HashMap<String, List<String>>();
                JSONObject jsonobject = new JSONObject("{" + '"' + "list" + '"' + ":" + json1 + "}");
                JSONArray jsonarray = jsonobject.getJSONArray("list");
                if(jsonarray.length()==0)
                {
                    prepareListData();
                }
                for (int i = 0; i < jsonarray.length(); i++) {
                    JSONObject json_data = jsonarray.getJSONObject(i);
                    courseId = json_data.getString("uCourseID");
                    course = json_data.getInt("courseID");
                    title = json_data.getString("title");
                    desc = json_data.getString("description");
                    minU = json_data.getString("minUnits");
                    maxU = json_data.getString("maxUnits");
                    section = json_data.getString("section");
                    dFlag = json_data.getString("dFlag");
                    List<String> top250 = new ArrayList<String>();
                    if (minU.equals(maxU))
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU);
                    else
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU + "-" + maxU);
                    top250.add("Description: " + desc);
                    JSONObject jsonobject1 = new JSONObject("{" + '"' + "section" + '"' + ":" + section + "}");
                    JSONArray jsonarray1 = jsonobject1.getJSONArray("section");
                    for (int j = 0; j < jsonarray1.length(); j++) {
                        JSONObject json_data1 = jsonarray1.getJSONObject(j);
                        termCode = json_data1.getInt("termCode");
                        min = json_data1.getString("minUnits");
                        max = json_data1.getString("maxUnits");
                        sectionId = json_data1.getString("uSectionID");
                        session = json_data1.getString("session");
                        btime = json_data1.getString("bTime");
                        etime = json_data1.getString("eTime");
                        iday = json_data1.getString("iDay");
                        day = json_data1.getString("day");
                        location = json_data1.getString("location");
                        registered = json_data1.getString("registered");
                        seats = json_data1.getInt("seats");
                        instructor = json_data1.getString("instructor");
                        iRating = json_data1.getString("iRating");
                        addBy = json_data1.getString("addBy");
                        dropBy = json_data1.getString("dropBy");
                        pFlag = json_data1.getString("pFlag");
                        pSecFlag = json_data1.getString("pSecFlag");
                        if (termCode % 10 == 1)
                            term = "Spring";
                        else if (termCode % 10 == 2)
                            term = "Summer";
                        else
                            term = "Fall";
                        termCode = termCode / 10;
                        if (min.equals(max))
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n" + "  Drop By: " + dropBy + "\n      Registered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                        else
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "-" + max + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n  Drop By: " + dropBy + "\nRegistered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                    }
                    listDataChild.put(listDataHeader.get(i), top250);

                }


                /*


                    listDataHeader.add(schoolName);
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
                        System.out.println(depts.get(departmentCode));

                    }
                    listDataChild.put(listDataHeader.get(count), top250);
                    count++;
                }
*/

            } catch (Exception e) {
                e.printStackTrace();
                prepareListData();
            }

        }
        // preparing list data
        else if (type == 2) {

            int course, seats, termCode;
            URLConnectionReader urlConnectionReader = new URLConnectionReader();
            if (tType == null && pRating == null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?day=" + weight);
            else if (tType != null && pRating == null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?day=" + weight + "&tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType);
            else if (tType == null && pRating != null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?day=" + weight + "&pRating=" + pRating);
            else
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?day=" + weight + "&tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType + "&pRating=" + pRating);
            try {
                listDataHeader = new ArrayList<String>();
                listDataChild = new HashMap<String, List<String>>();
                JSONObject jsonobject = new JSONObject("{" + '"' + "list" + '"' + ":" + json1 + "}");
                JSONArray jsonarray = jsonobject.getJSONArray("list");
                if(jsonarray.length()==0)
                {
                    prepareListData();
                }
                for (int i = 0; i < jsonarray.length(); i++) {
                    JSONObject json_data = jsonarray.getJSONObject(i);
                    courseId = json_data.getString("uCourseID");
                    course = json_data.getInt("courseID");
                    title = json_data.getString("title");
                    desc = json_data.getString("description");
                    minU = json_data.getString("minUnits");
                    maxU = json_data.getString("maxUnits");
                    section = json_data.getString("section");
                    dFlag = json_data.getString("dFlag");
                    List<String> top250 = new ArrayList<String>();
                    if (minU.equals(maxU))
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU);
                    else
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU + "-" + maxU);
                    top250.add("Description: " + desc);
                    JSONObject jsonobject1 = new JSONObject("{" + '"' + "section" + '"' + ":" + section + "}");
                    JSONArray jsonarray1 = jsonobject1.getJSONArray("section");
                    for (int j = 0; j < jsonarray1.length(); j++) {
                        JSONObject json_data1 = jsonarray1.getJSONObject(j);
                        termCode = json_data1.getInt("termCode");
                        min = json_data1.getString("minUnits");
                        max = json_data1.getString("maxUnits");
                        sectionId = json_data1.getString("uSectionID");
                        session = json_data1.getString("session");
                        btime = json_data1.getString("bTime");
                        etime = json_data1.getString("eTime");
                        iday = json_data1.getString("iDay");
                        day = json_data1.getString("day");
                        location = json_data1.getString("location");
                        registered = json_data1.getString("registered");
                        seats = json_data1.getInt("seats");
                        instructor = json_data1.getString("instructor");
                        iRating = json_data1.getString("iRating");
                        addBy = json_data1.getString("addBy");
                        dropBy = json_data1.getString("dropBy");
                        pFlag = json_data1.getString("pFlag");
                        pSecFlag = json_data1.getString("pSecFlag");
                        if (termCode % 10 == 1)
                            term = "Spring";
                        else if (termCode % 10 == 2)
                            term = "Summer";
                        else
                            term = "Fall";
                        termCode = termCode / 10;
                        if (min.equals(max))
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n" + "  Drop By: " + dropBy + "\n      Registered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                        else
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "-" + max + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n  Drop By: " + dropBy + "\nRegistered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                    }
                    listDataChild.put(listDataHeader.get(i), top250);
                }


                /*


                    listDataHeader.add(schoolName);
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
                        System.out.println(depts.get(departmentCode));

                    }
                    listDataChild.put(listDataHeader.get(count), top250);
                    count++;
                }
*/

            } catch (Exception e) {
                e.printStackTrace();
                prepareListData();
            }


        } else if (type == 3) {


            int course, seats, termCode;
            URLConnectionReader urlConnectionReader = new URLConnectionReader();
            if (weight != 0 && pRating != null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?day=" + weight + "&tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType + "&pRating=" + pRating);

            else if (weight == 0 && pRating != null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType + "&pRating=" + pRating);
            else if (weight != 0 && pRating == null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType + "&weight=" + weight);
            else
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType);
            try {
                listDataHeader = new ArrayList<String>();
                listDataChild = new HashMap<String, List<String>>();
                JSONObject jsonobject = new JSONObject("{" + '"' + "list" + '"' + ":" + json1 + "}");
                JSONArray jsonarray = jsonobject.getJSONArray("list");
                if(jsonarray.length()==0)
                {
                    prepareListData();

                }
                for (int i = 0; i < jsonarray.length(); i++) {
                    JSONObject json_data = jsonarray.getJSONObject(i);
                    courseId = json_data.getString("uCourseID");
                    course = json_data.getInt("courseID");
                    title = json_data.getString("title");
                    desc = json_data.getString("description");
                    minU = json_data.getString("minUnits");
                    maxU = json_data.getString("maxUnits");
                    section = json_data.getString("section");
                    dFlag = json_data.getString("dFlag");
                    List<String> top250 = new ArrayList<String>();
                    if (minU.equals(maxU))
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU);
                    else
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU + "-" + maxU);
                    top250.add("Description: " + desc);
                    JSONObject jsonobject1 = new JSONObject("{" + '"' + "section" + '"' + ":" + section + "}");
                    JSONArray jsonarray1 = jsonobject1.getJSONArray("section");
                    for (int j = 0; j < jsonarray1.length(); j++) {
                        JSONObject json_data1 = jsonarray1.getJSONObject(j);
                        termCode = json_data1.getInt("termCode");
                        min = json_data1.getString("minUnits");
                        max = json_data1.getString("maxUnits");
                        sectionId = json_data1.getString("uSectionID");
                        session = json_data1.getString("session");
                        btime = json_data1.getString("bTime");
                        etime = json_data1.getString("eTime");
                        iday = json_data1.getString("iDay");
                        day = json_data1.getString("day");
                        location = json_data1.getString("location");
                        registered = json_data1.getString("registered");
                        seats = json_data1.getInt("seats");
                        instructor = json_data1.getString("instructor");
                        iRating = json_data1.getString("iRating");
                        addBy = json_data1.getString("addBy");
                        dropBy = json_data1.getString("dropBy");
                        pFlag = json_data1.getString("pFlag");
                        pSecFlag = json_data1.getString("pSecFlag");
                        if (termCode % 10 == 1)
                            term = "Spring";
                        else if (termCode % 10 == 2)
                            term = "Summer";
                        else
                            term = "Fall";
                        termCode = termCode / 10;
                        if (min.equals(max))
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n" + "  Drop By: " + dropBy + "\n      Registered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                        else
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "-" + max + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n  Drop By: " + dropBy + "\nRegistered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                    }
                    listDataChild.put(listDataHeader.get(i), top250);
                }


                /*


                    listDataHeader.add(schoolName);
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
                        System.out.println(depts.get(departmentCode));

                    }
                    listDataChild.put(listDataHeader.get(count), top250);
                    count++;
                }
*/

            } catch (Exception e) {
                e.printStackTrace();
                prepareListData();
            }
        } else if (type == 4) {



            int course, seats, termCode;
            URLConnectionReader urlConnectionReader = new URLConnectionReader();
            if (weight != 0 && tType != null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?day=" + weight + "&tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType + "&pRating=" + pRating);
            else if (weight == 0 && tType != null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?tStart=" + tStart + "&tEnd=" + tEnd + "&tType=" + tType + "&pRating=" + pRating);
            else if (weight != 0 && tType == null)
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?weight=" + weight + "&pRating=" + pRating);
            else
                json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?pRating=" + pRating);

            try {
                listDataHeader = new ArrayList<String>();
                listDataChild = new HashMap<String, List<String>>();
                JSONObject jsonobject = new JSONObject("{" + '"' + "list" + '"' + ":" + json1 + "}");
                JSONArray jsonarray = jsonobject.getJSONArray("list");
                if(jsonarray.length()==0)
                {
                    prepareListData();
                }
                for (int i = 0; i < jsonarray.length(); i++) {
                    JSONObject json_data = jsonarray.getJSONObject(i);
                    courseId = json_data.getString("uCourseID");
                    course = json_data.getInt("courseID");
                    title = json_data.getString("title");
                    desc = json_data.getString("description");
                    minU = json_data.getString("minUnits");
                    maxU = json_data.getString("maxUnits");
                    section = json_data.getString("section");
                    dFlag = json_data.getString("dFlag");
                    List<String> top250 = new ArrayList<String>();
                    if (minU.equals(maxU))
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU);
                    else
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU + "-" + maxU);
                    top250.add("Description: " + desc);
                    JSONObject jsonobject1 = new JSONObject("{" + '"' + "section" + '"' + ":" + section + "}");
                    JSONArray jsonarray1 = jsonobject1.getJSONArray("section");
                    for (int j = 0; j < jsonarray1.length(); j++) {
                        JSONObject json_data1 = jsonarray1.getJSONObject(j);
                        termCode = json_data1.getInt("termCode");
                        min = json_data1.getString("minUnits");
                        max = json_data1.getString("maxUnits");
                        sectionId = json_data1.getString("uSectionID");
                        session = json_data1.getString("session");
                        btime = json_data1.getString("bTime");
                        etime = json_data1.getString("eTime");
                        iday = json_data1.getString("iDay");
                        day = json_data1.getString("day");
                        location = json_data1.getString("location");
                        registered = json_data1.getString("registered");
                        seats = json_data1.getInt("seats");
                        instructor = json_data1.getString("instructor");
                        iRating = json_data1.getString("iRating");
                        addBy = json_data1.getString("addBy");
                        dropBy = json_data1.getString("dropBy");
                        pFlag = json_data1.getString("pFlag");
                        pSecFlag = json_data1.getString("pSecFlag");
                        if (termCode % 10 == 1)
                            term = "Spring";
                        else if (termCode % 10 == 2)
                            term = "Summer";
                        else
                            term = "Fall";
                        termCode = termCode / 10;
                        if (min.equals(max))
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n" + "  Drop By: " + dropBy + "\n      Registered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                        else
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "-" + max + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n  Drop By: " + dropBy + "\nRegistered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                    }
                    listDataChild.put(listDataHeader.get(i), top250);
                }


                /*


                    listDataHeader.add(schoolName);
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
                        System.out.println(depts.get(departmentCode));

                    }
                    listDataChild.put(listDataHeader.get(count), top250);
                    count++;
                }
*/

            } catch (Exception e) {
                e.printStackTrace();
                prepareListData();
            }
        } else if (type == 0) {

            int course, seats, termCode;
            URLConnectionReader urlConnectionReader = new URLConnectionReader();
            json1 = urlConnectionReader.URLreader("course/search/" + term1 + "/" + code + "?cName=" + string);

            try {
                listDataHeader = new ArrayList<String>();
                listDataChild = new HashMap<String, List<String>>();
                JSONObject jsonobject = new JSONObject("{" + '"' + "list" + '"' + ":" + json1 + "}");
                JSONArray jsonarray = jsonobject.getJSONArray("list");
                for (int i = 0; i < jsonarray.length(); i++) {
                    JSONObject json_data = jsonarray.getJSONObject(i);
                    courseId = json_data.getString("uCourseID");
                    course = json_data.getInt("courseID");
                    title = json_data.getString("title");
                    desc = json_data.getString("description");
                    minU = json_data.getString("minUnits");
                    maxU = json_data.getString("maxUnits");
                    section = json_data.getString("section");
                    dFlag = json_data.getString("dFlag");
                    List<String> top250 = new ArrayList<String>();
                    if (minU.equals(maxU))
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU);
                    else
                        listDataHeader.add(courseId + " : " + title + " Units: " + minU + "-" + maxU);
                    top250.add("Description: " + desc);
                    JSONObject jsonobject1 = new JSONObject("{" + '"' + "section" + '"' + ":" + section + "}");
                    JSONArray jsonarray1 = jsonobject1.getJSONArray("section");
                    for (int j = 0; j < jsonarray1.length(); j++) {
                        JSONObject json_data1 = jsonarray1.getJSONObject(j);
                        termCode = json_data1.getInt("termCode");
                        min = json_data1.getString("minUnits");
                        max = json_data1.getString("maxUnits");
                        sectionId = json_data1.getString("uSectionID");
                        session = json_data1.getString("session");
                        btime = json_data1.getString("bTime");
                        etime = json_data1.getString("eTime");
                        iday = json_data1.getString("iDay");
                        day = json_data1.getString("day");
                        location = json_data1.getString("location");
                        registered = json_data1.getString("registered");
                        seats = json_data1.getInt("seats");
                        instructor = json_data1.getString("instructor");
                        iRating = json_data1.getString("iRating");
                        addBy = json_data1.getString("addBy");
                        dropBy = json_data1.getString("dropBy");
                        pFlag = json_data1.getString("pFlag");
                        pSecFlag = json_data1.getString("pSecFlag");
                        if (termCode % 10 == 1)
                            term = "Spring";
                        else if (termCode % 10 == 2)
                            term = "Summer";
                        else
                            term = "Fall";
                        termCode = termCode / 10;
                        if (min.equals(max))
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n" + "  Drop By: " + dropBy + "\n      Registered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                        else
                            top250.add("Term: " + term + " " + termCode + "\n" + " Section: " + sectionId + "\n" + "Units: " + min + "-" + max + "\n" + " Loaction:" + location
                                    + "\n" + "Seats: " + seats + "\n" + "Instructor: " + instructor + "\n" + "Days: " + day + "\n" + "Add By: " + addBy + "\n  Drop By: " + dropBy + "\nRegistered Students: " + registered + "\n"
                                    + "\n" + "Timings: " + btime + " to " + etime);
                    }
                    listDataChild.put(listDataHeader.get(i), top250);
                }


                /*


                    listDataHeader.add(schoolName);
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
                        System.out.println(depts.get(departmentCode));

                    }
                    listDataChild.put(listDataHeader.get(count), top250);
                    count++;
                }
*/

            } catch (Exception e) {
                prepareListData();
            }

        }
        spinner.setVisibility(View.GONE);
        button1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                string = editText.getText().toString();
                Fragment fragment = null;
                Bundle args = new Bundle();
                args.putInt("term", term1);
                args.putString("code", code);
                args.putInt("type", 0);
                args.putString("string", string);
                fragment = new FragmentTwo();
                fragment.setArguments(args);
                FragmentManager frgManager = getFragmentManager();
                frgManager.beginTransaction().replace(R.id.content_frame, fragment)
                        .commit();
            }
        });


        button.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                PopupMenu popupMenu = new PopupMenu(getActivity(), v);
                popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                    public boolean onMenuItemClick(MenuItem item) {
                        switch (item.getItemId()) {
                            case R.id.dept:
                               /* Toast.makeText(getActivity(), "Department", Toast.LENGTH_SHORT).show();*/
                                Fragment fragment2 = null;
                                Bundle args2 = new Bundle();
                                fragment2 = new Department();
                                fragment2.setArguments(args2);
                                FragmentManager frgManager2 = getFragmentManager();
                                frgManager2.beginTransaction().replace(R.id.content_frame, fragment2)
                                        .commit();

                                return true;
                            case R.id.day:
                               /* Toast.makeText(getActivity(), "Day  ", Toast.LENGTH_SHORT).show();*/
                                Fragment fragment = null;
                                Bundle args = new Bundle();
                                args.putInt("term", term1);
                                args.putString("code", code);
                                args.putString("pRating", pRating);
                                args.putString("pRating", pRating);
                                args.putInt("tStart", tStart);
                                args.putInt("tEnd", tEnd);
                                args.putString("tType", tType);
                                fragment = new Days();
                                fragment.setArguments(args);
                                FragmentManager frgManager = getFragmentManager();
                                frgManager.beginTransaction().replace(R.id.content_frame, fragment)
                                        .commit();
                                return true;
                            case R.id.time:
                                /*Toast.makeText(getActivity(), "Time", Toast.LENGTH_SHORT).show();*/
                                Fragment fragment1 = null;
                                Bundle args1 = new Bundle();
                                fragment1 = new Time();
                                args1.putInt("term", term1);
                                args1.putString("code", code);
                                args1.putInt("weight", weight);
                                args1.putString("pRating", pRating);

                                fragment1.setArguments(args1);
                                FragmentManager frgManager1 = getFragmentManager();
                                frgManager1.beginTransaction().replace(R.id.content_frame, fragment1)
                                        .commit();
                                return true;
                            case R.id.term:
                                /*Toast.makeText(getActivity(), "Time", Toast.LENGTH_SHORT).show();*/
                                Fragment fragment3 = null;
                                Bundle args3 = new Bundle();
                                fragment3 = new Term();
                                fragment3.setArguments(args3);
                                FragmentManager frgManager3 = getFragmentManager();
                                frgManager3.beginTransaction().replace(R.id.content_frame, fragment3)
                                        .commit();
                                return true;
                            case R.id.professor:
                                /*Toast.makeText(getActivity(), "Time", Toast.LENGTH_SHORT).show();*/
                                Fragment fragment4 = null;
                                Bundle args4 = new Bundle();
                                fragment4 = new Professor();
                                args4.putInt("term", term1);
                                args4.putString("code", code);
                                args4.putInt("weight", weight);
                                args4.putInt("tStart", tStart);
                                args4.putInt("tEnd", tEnd);
                                args4.putString("tType", tType);
                                fragment4.setArguments(args4);
                                FragmentManager frgManager4 = getFragmentManager();
                                frgManager4.beginTransaction().replace(R.id.content_frame, fragment4)
                                        .commit();
                                return true;
                        }
                        return true;
                    }
                });
                popupMenu.inflate(R.menu.context_menu);
                popupMenu.show();


            /*    Fragment fragment = null;
                Bundle args = new Bundle();
                fragment = new Filter();
                fragment.setArguments(args);
                FragmentManager frgManager = getFragmentManager();
                frgManager.beginTransaction().replace(R.id.content_frame, fragment)
                        .commit();*/
            }
        });
        // Listview Group click listener
        expListView.setOnGroupClickListener(new OnGroupClickListener() {


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
        expListView.setOnGroupExpandListener(new OnGroupExpandListener() {

            @Override
            public void onGroupExpand(int groupPosition) {
               /* Toast.makeText(getActivity(),
                        listDataHeader.get(groupPosition) + " Expanded",
                        Toast.LENGTH_SHORT).show();*/
            }
        });

        // Listview Group collasped listener
        expListView.setOnGroupCollapseListener(new OnGroupCollapseListener() {

            @Override
            public void onGroupCollapse(int groupPosition) {
               /* Toast.makeText(getActivity(),
                        listDataHeader.get(groupPosition) + " Collapsed",
                        Toast.LENGTH_SHORT).show();
*/
            }
        });

        // Listview on child click listener
        expListView.setOnChildClickListener(new OnChildClickListener() {

            @Override
            public boolean onChildClick(ExpandableListView parent, View v,
                                        int groupPosition, int childPosition, long id) {
                // TODO Auto-generated method stub


                DialogInterface.OnClickListener dialogClickListener = new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        switch (which) {
                            case DialogInterface.BUTTON_POSITIVE:


                                URLConnectionReader urlConnectionReader=new URLConnectionReader();
                                url=urlConnectionReader.URLreader("calendar/"+username+"/getAll");
                                try {
                                    JSONObject jsonobject = new JSONObject("{" + '"' + "list" + '"' + ":" + url + "}");
                                    JSONArray jsonarray = jsonobject.getJSONArray("list");
                                    if(jsonarray.length()==0){
                                        URLConnectionReader urlConnectionReader1=new URLConnectionReader();
                                        url1=urlConnectionReader1.URLreader("calendar/"+username+"/create");
                                        JSONObject jsonobject1 = new JSONObject(url1);
                                        cid[0]=jsonobject1.getInt("calendarID");
                                        listItems.add("Calendar 1");
                                    }
                                    else
                                    {

                                        for (int i = 0; i < jsonarray.length(); i++) {
                                            JSONObject json_data = jsonarray.getJSONObject(i);
                                            cid[i]=json_data.getInt("calendarID");
                                            listItems.add("Calendar "+i);

                                        }
                                    }
                                    items = listItems.toArray(new CharSequence[listItems.size()]);
                                    listItems.clear();
                                    AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                                    builder.setTitle("List Of Calendars");

                                    builder.setSingleChoiceItems(items, -1, new DialogInterface.OnClickListener() {
                                        public void onClick(DialogInterface dialog, int item) {


                                            switch(item)
                                            {
                                                case 0:
                                                    String url2;
                                                    URLConnectionReader urlConnectionReader=new URLConnectionReader();
                                                    url2=urlConnectionReader.URLreader("calendar/"+username+"/"+cid[0]+"?section="+section);
                                                    break;
                                                case 1:

                                                    URLConnectionReader urlConnectionReader1=new URLConnectionReader();
                                                    url2=urlConnectionReader1.URLreader("calendar/"+username+"/"+cid[1]+"?section="+section);
                                                    break;
                                                case 2:

                                                    URLConnectionReader urlConnectionReader2=new URLConnectionReader();
                                                    url2=urlConnectionReader2.URLreader("calendar/"+username+"/"+cid[2]+"?section="+section);
                                                    break;

                                            }

                                            levelDialog.dismiss();
                                        }
                                    });
                                    levelDialog = builder.create();
                                    levelDialog.show();

                                }catch (Exception e){e.printStackTrace();}


                                 //retrieve calendars


                                break;

                            case DialogInterface.BUTTON_NEGATIVE:

                                break;
                        }
                    }
                };

                AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
                builder.setMessage("Do you want to add this course to the calendar?").setPositiveButton("Yes", dialogClickListener)
                        .setNegativeButton("No", dialogClickListener).show();


                return false;
            }
        });

        /*ivIcon=(ImageView)view.findViewById(R.id.frag2_icon);
        tvItemName=(TextView)view.findViewById(R.id.frag2_text);

        tvItemName.setText(getArguments().getString(ITEM_NAME));
        ivIcon.setImageDrawable(view.getResources().getDrawable(
                getArguments().getInt(IMAGE_RESOURCE_ID)));*/
        listAdapter = new ExpandableListViewAdapterCourses(getActivity(), listDataHeader, listDataChild);

        // setting list adapter
        expListView.setAdapter(listAdapter);
        return view;
    }

    private void prepareListData() {
        listDataHeader = new ArrayList<String>();
        listDataChild = new HashMap<String, List<String>>();

        // Adding child data
        listDataHeader.add("Sorry! No Results Found.");

        // Adding child data
        List<String> top250 = new ArrayList<String>();
        top250.add("The query made could be invalid or the course may not be offered this term. \n Please try again.");


        listDataChild.put(listDataHeader.get(0), top250); // Header, Child data

    }






    @Override
    public void onResume() {
        super.onResume();

        getView().setFocusableInTouchMode(true);
        getView().requestFocus();
        getView().setOnKeyListener(new View.OnKeyListener() {
            @Override
            public boolean onKey(View v, int keyCode, KeyEvent event) {

                if (event.getAction() == KeyEvent.ACTION_UP && keyCode == KeyEvent.KEYCODE_BACK){
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