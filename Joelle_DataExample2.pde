//Attempt to make flashlight example using NYTimes API
//Don't know which primitive to use to replace the pixel values from the ImageFlashlight example.

// Make sure to paste in your API Key here
String apiKey = "ACCC28957E154290A3B474081C0485FD:5:68338337";
// Assuming you got the API Key for Article search, all of your search requests are going to start out with this URL String
String baseURL = "http://api.nytimes.com/svc/search/v2/articlesearch,json?q=";

JSONArray articles;
PFont font;
color c = 255;
int posx = 0;
int posy = 0;

void setup() {
  size(400, 910);
  articles = getFemArticles();
  font = loadFont("Oswald-Light-48.vlw");
  loadPixels();

  textFont(font, 20);
  for (int i = 0 ; i < articles.size(); i++) {
    //    println(articles.getJSONObject(i).getJSONObject("docs").getString("abstract"));
    fill(c);
    text(articles.getString(i), posx, posy);
    while (posy < height) {
      posy +=20;
    }
  }
};

void draw() {
  background(1);
  for (int x = 0; x < width; x++ ) {
    for (int y = 0; y < height; y++ ) {
      int loc = x + y*width;

      char r = char(articles.getInt(loc));

      float distance = dist(x, y, mouseX, mouseY);

      float adjustBrightness = (50-distance)/50;
      int R = int(r);
      R *= adjustBrightness;

      R = constrain(R, 0, 255);

      c = color(R);
      int p = articles.getInt(loc);
      p = c;
    }
  }
};

JSONArray getFemArticles() {

  String request = baseURL + "black+women&begin_date=20131025&end_date=20131030&api-key=" + apiKey;

  try {

    // Load the search results into a JSONObject so Processing can parse the JSON data structure
    JSONObject nytData = loadJSONObject(request);
    int results = nytData.getJSONObject("response").getJSONObject("meta").getInt("hits");

    return nytData.getJSONObject("docs").getJSONArray("abstract");
  }
  catch (Exception e) {
    println ("There was an error parsing the JSONObject.");
  }
  return new JSONArray();
};

