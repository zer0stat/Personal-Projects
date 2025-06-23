import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

public class logSearch {

    public static int capacity = 650000;

    public static void main(String[] args) {
        HashMap<String, ArrayList<String>> data = readFile();
        Object[] keys = data.keySet().toArray();
        Random r = new Random();

        Scanner user = new Scanner(System.in);
        System.out.println(keys.toString());
        String ID;
        int action;
        Object key;
        running:
            while (true) {
                System.out.println("1: Search ID\n2: Random ID\n3: Exit program");
                action = user.nextInt();
                switch (action) {
                    case 1:
                        ID = user.next();
                        System.out.println("");
                        System.out.println(ID);
                        for (String i : data.get(ID)) {
                            System.out.println(i);
                        }
                        break;
                    case 2:
                        key = keys[r.nextInt(keys.length)];
                        System.out.println("User ID: " + key + "\n");
                        ArrayList<String> logs = data.get(key);
                        for (String i : logs) {
                            System.out.println(i);
                        }
                        break;
                    case 3:
                        break running;
                }
                System.out.println("\n");
            }
        user.close();
        
    }

    public static HashMap<String, ArrayList<String>> readFile() {
        HashMap<String, ArrayList<String>> data = new HashMap<String, ArrayList<String>>(capacity);
        try {
            for (int i = 1; i < 10; i++) {
                File logs = new File("user-ct-test-collection-0" + i + ".txt");
                Scanner reader = new Scanner(logs);
                while (reader.hasNextLine()) {
                    String temp = reader.nextLine();
                    String[] splitData = temp.split("\t");
                    if (data.containsKey(splitData[0])) {
                        data.get(splitData[0]).add(splitData[1] + " " + splitData[2]);
                    } else {
                        ArrayList<String> entries = new ArrayList<String>();
                        entries.add(splitData[1] + " " + splitData[2]);
                        data.put(splitData[0], entries);
                    }
                }
                reader.close();
            }
            File logs = new File("user-ct-test-collection-10.txt");
                Scanner reader = new Scanner(logs);
                while (reader.hasNextLine()) {
                    String temp = reader.nextLine();
                    String[] splitData = temp.split("\t");
                    if (data.containsKey(splitData[0])) {
                        data.get(splitData[0]).add(splitData[1] + " " + splitData[2]);
                    } else {
                        ArrayList<String> entries = new ArrayList<String>();
                        entries.add(splitData[1] + " " + splitData[2]);
                        data.put(splitData[0], entries);
                    }
                }
                reader.close();
            
        } catch (FileNotFoundException e) {
            System.out.println("error");
        }
        return data;
    }
}
