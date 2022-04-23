PImage img;
int[][] struct = {{1, 1, 1, 1, 1},
                  {1, 1, 1, 1, 1},
                  {1, 1, 1, 1, 1}};
PImage eroded_img;
PImage dilated_img;
int loc;

void setup(){
  size(940, 480);
  img = loadImage("bin_img3.jpg");
  eroded_img = createImage(img.width, img.height, RGB);
  dilated_img = createImage(img.width, img.height, RGB);
  //image(img, 0, 0, width/2, height/2);
}


void draw(){
  erode(img, eroded_img);
  dilate(img, dilated_img);
  image(img, 0, 0, width/3, height);
  image(eroded_img, width/3, 0, width/3, height);
  image(dilated_img, 2*width/3, 0, width/3, height);
}

/* Erosion */
void erode(PImage input, PImage output){
  for(int x = 0; x < input.width; x++){
    for(int y = 0; y < input.height; y++){
      loc = x + y * input.width;
      boolean isIncluded = true;
      search:
      for(int offx = -1; offx < 1; offx++){
        for(int offy = -1; offy < 1; offy++){
          int offloc = (x + offx) + (y + offy)*input.width;
          if((x + offx) > input.width || (x + offx) < 0 ||
             (y + offy) > input.height || (y + offy) < 0){
              isIncluded = false;
              break search;
          }else if(struct[offx+1][offy+1] == 1 && img.pixels[offloc] != color(255)){
              isIncluded = false;
          }
        }
      }
      if(isIncluded){
        output.pixels[loc] = color(255);
      }else{
        output.pixels[loc] = color(0);
      }
    }
  }
}

/* Dilatation */
void dilate(PImage input, PImage output){
  for(int x = 0; x < input.width; x++){
    for(int y = 0; y < input.height; y++){
      loc = x + y * input.width;
      boolean isIncluded = false;
      search:
      for(int offx = -1; offx < 1; offx++){
        for(int offy = -1; offy < 1; offy++){
          int offloc = (x + offx) + (y + offy)*input.width;
          if((x + offx) > input.width  || (x + offx) < 0 ||
             (y + offy) > input.height || (y + offy) < 0){
              isIncluded = false;
              break search;
          }else if(struct[offx+1][offy+1] == 1 && img.pixels[offloc] == color(255)){
              isIncluded = true;
          }
        }
      }
      if(isIncluded){
        output.pixels[loc] = color(255);
      }else{
        output.pixels[loc] = color(0);
      }
    }
  }
}
