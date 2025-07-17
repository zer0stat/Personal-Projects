// number of words in a "page"
const CONVERSION = 275;

// grabs list of fics
const fics = document.getElementById("result").children;

// grabs each fic in list
for (let i = 0; i < fics.length; i++) {

    // finds the element for the page count
    let pages_data = fics[i].querySelector(".fa-book").parentNode;
    pages_data = pages_data.querySelector("span");

    // processes the page count into an ordered array of digits
    temp_data = pages_data.innerHTML.split(" ");
    temp_data = Number(temp_data[0]) * CONVERSION
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
    pages_data.innerHTML = temp_data;
}