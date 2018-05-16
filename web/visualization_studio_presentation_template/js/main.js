var pres = new PresentationMaker();

//function to setup a presentation based on html organization and css classes
function PresentationMaker() {
  //select all scenes and media groups per css class assignment
  this.scenes = document.querySelectorAll(".scene");
  this.subScenes = Array.from(document.querySelectorAll(".sub-scene"));
  var scenes = Array.from(this.scenes);
  var subScenes = this.subScenes;

  //variables for holding current and last scenes
  var currentScene = this.currentScene;
  var lastScene = this.lastScene;

  //enable testing?
  var testing = this.testing = false;

  //hide all scenes and media at start
  scenes.map(function(d) { return d.classList.add("hidden"); });
  subScenes.map(function(d) { return d.classList.add("hidden"); });

  //parse content from each scene
  this.sceneOrganization = scenes.map(function(d) {
    return {
      "scene": d,
      "walls": d.children,
      "subScenes": d.getElementsByClassName("sub-scene")
    };
  });
  var sceneOrg = this.sceneOrganization;

  //function to change to a specific scene indicated by 'goToScene'
  this.changeScene = function(goToScene) {
    //first check if requested scene exists
    if (goToScene > scenes.length - 1 || goToScene < 0) {
      return;
    } else {
      lastScene = currentScene;
      currentScene = goToScene;
      //if there is a previus scene hide it
      if (lastScene !== undefined) {
        sceneOrg[lastScene].scene.classList.add("hidden");
      }
      console.log("last scene: " + lastScene, "current scene: " + currentScene);

      var newScene = sceneOrg[goToScene];
      if (newScene.scene.classList.contains("hidden")) {
        newScene.scene.classList.remove("hidden");
        if (newScene.subScenes.length !== 0) {
          newScene.subScenes[0].classList.remove("hidden");
        }
      }

    }
  };

  this.changeSubScene = function(direction) {
    //Get array of all media groups from current scene
    var subSceneList = Array.from(sceneOrg[currentScene].subScenes);

    //find the first hidden media group in the scene
    var nextSubSceneIndex = subSceneList.findIndex(function(d) {
      return d.classList.contains("hidden");
    });
    //if moving forward through slides and not at last scene
    if (direction === "forward") {
      //if at end of scene
      if (
        currentScene < scenes.length - 1 && nextSubSceneIndex === -1 ||
        subSceneList.length === 0
      ) {
        //move to next scene
        this.changeScene(currentScene + 1);
      // if not at end of scene
    } else if (nextSubSceneIndex !== -1) {
        //un-hide next media group
        subSceneList[nextSubSceneIndex].classList.remove("hidden");
      }
    //if moving back through slides and not on first scene
    } else if (direction === "back") {
      //if at the begining of the scene
      if (
        currentScene > 0 && nextSubSceneIndex === 0 ||
        subSceneList.length === 0
      ) {
        //move back one scene
        this.changeScene(currentScene - 1);
    //else hide last un-hidden media group
    } else if (nextSubSceneIndex !== 0) {
        //test if at end of scene and set index to last un-hidden media group
        nextSubSceneIndex = nextSubSceneIndex === -1 ?
          subSceneList.length - 1 : nextSubSceneIndex - 1;
        //hide last un-hidden media group
        subSceneList[nextSubSceneIndex].classList.add("hidden");
      }
    }
  };

  //This function cycles through scenes/sub-scenes
  function goThroughMedia(e) {
    //check for correct input type to move forward/backward through media
    if (e.type === "keydown") {
      if (e.keyCode === 39) {
        e.preventDefault();
        stepForward();
      } else if (e.keyCode === 37) {
        e.preventDefault();
        stepBack();
      }
    } else if (e.type === "click") {
      stepForward();
    } else if (e.type === "touchstart") {
      touchStartX = e.changedTouches[0].clientX;
    } else if (e.type === "touchend") {
      touchEndX = e.changedTouches[0].clientX;
      if (touchEndX - touchStartX < 0) {
        e.preventDefault();
        stepForward();
      } else if (touchEndX - touchStartX > 0) {
        e.preventDefault();
        stepBack();
      }
    }

    //step forward through slides
    function stepForward() {
      pres.changeSubScene("forward");
    }

    //step back through slides
    function stepBack() {
      pres.changeSubScene("back");
    }
  }

  var touchStartX, touchEndX;
  window.addEventListener("click", goThroughMedia, false);
  window.addEventListener("keydown", goThroughMedia, false);
  window.addEventListener("touchstart", goThroughMedia, false);
  window.addEventListener("touchend", goThroughMedia, false);

  //initialize at scene with currentScene
  currentScene = lastScene = 0;
  this.changeScene(currentScene);

  //toggle testing on/off and add elements if first time initializing testing
  var firstTest = true;
  this.testing = function(onOff) {
    if (firstTest) {
      addTestingElements();
      firstTest = false;
    }

    function addTestingElements() {
      var testingDiv = document.createElement("div");
      testingDiv.classList.add("testing", "hidden");

      var wallPos = ["left", "center", "right"];
      for (i = 1; i < 5; i++) {
        for (j = 1; j < 4; j++) {
          var testingWall = document.createElement("div");
          testingWall.classList.add(
            "wall-" + i + "-" + wallPos[j - 1],
            "screen-width-1",
            "test-wall"
          );

          var p = document.createElement("p");
          p.textContent = "Wall " + i + ", Screen " + j;

          testingWall.appendChild(p);
          testingDiv.appendChild(testingWall);
        }
      }

      document.body.appendChild(testingDiv);
    }

    if (onOff) {
      document.querySelector(".testing").classList.remove("hidden");
    } else document.querySelector(".testing").classList.add("hidden");
  };
}
