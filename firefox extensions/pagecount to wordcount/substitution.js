// number of words in a "page"
const CONVERSION = 275;

/**
 * This script activates on the search page of royalroad.com and grabs the html element
 * with the different books data. Then it loops through each one finding the text
 * that displays the page count. It converts it to a word count and rearranges itself
 * into a pretty format with comma seperation. Job done, grab a beer.
 */

// grabs list of fics
let fics = document.getElementById("result");
if (fics != null) {
    fics = fics.children;
} else {
    fics = document.querySelector(".fiction-list").children;
}

// grabs each fic in list
for (let i = 0; i < fics.length; i++) {

    // finds the element for the page count
    let pages_data = fics[i].querySelector(".fa-book").parentNode;
    pages_data = pages_data.querySelector("span");

    // processes the page count into an ordered array of digits
    temp_data = pages_data.textContent.split(" ");
    temp_data = temp_data[0].replaceAll(",","");
    temp_data = Number(temp_data) * CONVERSION
    temp_data = temp_data.toString().split("");

    // processes array into a number divided by commas every third digit
    let pretty_number = "";
    for (let i = 0; i < temp_data.length; i++) {
        if ((i % 3) == 0 && i != 0) {
            pretty_number = "," + pretty_number;
        }
        pretty_number = temp_data[temp_data.length - i - 1] + pretty_number;
    }
    temp_data = pretty_number + " words";
    
    // replaces the page count with new word count
    pages_data.textContent = temp_data;
}