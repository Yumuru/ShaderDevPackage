using System.Collections;
using System.Collections.Generic;
using UnityEngine;
#if UNITY_EDITOR
using UnityEditor;

public class SceneSetter : EditorWindow {
  [MenuItem("Editor/SceneSetter")]
  static void Open() {
    GetWindow<SceneSetter>("SceneSetter");
  }

  void OnGUI() {
    if (GUILayout.Button("Set Black Skybox")) {
      var sceneSetterResource = (SceneSetterResource) Resources.Load("SceneSetterResource", typeof(SceneSetterResource));
      RenderSettings.skybox = sceneSetterResource.skybox_black;
      Resources.UnloadAsset(sceneSetterResource);
    }
    if (GUILayout.Button("Set White Skybox")) {
      var sceneSetterResource = (SceneSetterResource) Resources.Load("SceneSetterResource", typeof(SceneSetterResource));
      RenderSettings.skybox = sceneSetterResource.skybox_white;
      Resources.UnloadAsset(sceneSetterResource);
    }
  }
}
#endif
