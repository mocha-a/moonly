'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"flutter_bootstrap.js": "e6d11f527f8bad7696572525b0632e72",
"index.html": "e7feae40474170588d9e9cef802c885c",
"/": "e7feae40474170588d9e9cef802c885c",
"version.json": "8af3590e167c33e507c3d7dba6134547",
"assets/assets/moon.svg": "49ddb9eba26204550e81850a0ec58418",
"assets/assets/logo_moon.svg": "d15c20479f6b29d762031901659f75f1",
"assets/assets/splash.gif": "b4f2a36424af63aea2b5135f1aebc480",
"assets/assets/no_data.svg": "522322e86171c0b0644284bec6d8e823",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/fonts/MaterialIcons-Regular.otf": "f9364b14accb6670ca400e9edff86a56",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.json": "c0d8c965a7d632fc7c77ee11ad7d2a44",
"assets/AssetManifest.bin": "37767b01de922c0015e2e42e0ce6daac",
"assets/AssetManifest.bin.json": "ee5262ac88d0ad1ac260d5dcbfb7496a",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "9a214a69b312ea06fb3295418f03fc05",
"icons/Icon-192.png": "c868bf2abc8f90360aa8d4ba20bd9341",
"icons/Icon-512.png": "19eb2bf50b4fe5290c3b8c4888e66b3f",
"icons/Icon-maskable-192.png": "c868bf2abc8f90360aa8d4ba20bd9341",
"icons/Icon-maskable-512.png": "19eb2bf50b4fe5290c3b8c4888e66b3f",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/refs/heads/main": "423470ab31f8b3859127ec1c686c3bb5",
".git/refs/remotes/origin/main": "423470ab31f8b3859127ec1c686c3bb5",
".git/objects/9a/c2d92679fc80625684dc2b98d3a7bbf5507995": "0811a72d9054e900c58342073a874d09",
".git/objects/83/78d6b08ae6b0f479267c435e02e1e92c540a46": "3600de19bd088a319538af7ad6ef0aec",
".git/objects/a1/97760e6359390f2cdc37f28112ce277d34611d": "e83a1a81aef59e1e01dfc1e83232e9b6",
".git/objects/4e/073c96cf42c0d04b5e56700689d01de497250a": "360f84422597e4dab1b68e89f65e71ce",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/6f/093e59bb6558f9a11ee50c2ad55c6c6d9aaa0f": "c656ea99902558484f21b18648bbc0a3",
".git/objects/44/48e500fa624ba461b65f20b6d45d0b1fe1f2d6": "11c5ba194519619e08bfc6602ad37a5d",
".git/objects/0c/e9f65d20f9759e825ba3b7b5eb7793521b307e": "46a7da2a49b08b32b857f8a00763a5ba",
".git/objects/ae/c4088c977c98eebabe0e003850da931520495a": "765848e39682d0f525c6d0b5faa12bf3",
".git/objects/59/c48411d29e9dc50cd85765e8614aee5736e661": "96cbc5c47106ced9e6b117fac12ec202",
".git/objects/23/63c5d7d2bfb2643f24c50757776eee559530d2": "85833bef4d997d2e0b49a51907759cd2",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/d6/c5c85dc758e2852fca905a4f05224eb924984b": "962b1573783e35e28ea754fe5f80bace",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/48/8fc548ef9cc91d516e12382fee3a5885c14e2b": "5ff864b362505736209f8e25b95c56c6",
".git/objects/06/16bf3951fdeddbf6ac3debbe2ef72094fe0e8b": "de766f3215bf974b7e0b67d8555988c9",
".git/objects/5e/5169642d14e59eba68e92658ed0177f8b1c945": "03d688c963d76867bbece288900616a3",
".git/objects/ef/2e3adeda3d39f82d571fe6232fbd7e1e5a1550": "67c19228618fa2cc627635041d868808",
".git/objects/41/7ac74b006aa6c3fe1f33be18e64d78d435c2e1": "149ab61aaca08fff72d8b71d77cc68e9",
".git/objects/b1/c76dcbe3102f337eed90642c44bf123336a158": "ecbb0789693ccdff7386518a451ce16a",
".git/objects/14/c5c272465e27950478649208a6aa4d81a1ca81": "b9ff28de29aea8401cc5ab564650d566",
".git/objects/14/d1fdb109212a75918c2219838741224d24abb4": "518b17194b2ae596e099b7688df1722f",
".git/objects/dd/4728e48649f3c2d27a099cca12557e304460ea": "44712b065b5fd33bd478800a5390b87c",
".git/objects/db/83a2919adbe13ac9d3370b71abdae4cee3bf32": "c4751e04b352d541d3811e60161a27f5",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/2e/2eb986292e384912cf0f8a965f3ecc32629793": "67bb38f39bb2d1712d7a0c3ce1357bb2",
".git/objects/4c/51fb2d35630595c50f37c2bf5e1ceaf14c1a1e": "a20985c22880b353a0e347c2c6382997",
".git/objects/8e/3c7d6bbbef6e7cefcdd4df877e7ed0ee4af46e": "025a3d8b84f839de674cd3567fdb7b1b",
".git/objects/3a/6d79910d88538fa369c45ae3b7a3b613375ac1": "a65f2ac218d2f097ba1fcbc304af6e99",
".git/objects/16/15f4ce4a45a2d09189bb86077277e8367daece": "8f1bdaeb84a50f5b90e39487edbc4a56",
".git/objects/22/fb6bbdc315b2e0d3e9b97a75091ac3f94ede81": "5434d00fb338654abd18498e0920523f",
".git/index": "4ec455b6a07829e44a769d61b84e673a",
".git/COMMIT_EDITMSG": "952ed55677c272edce7cc9cf3f4f806a",
".git/logs/HEAD": "91c46c8f50f6f162ae27c9211c00f0ea",
".git/logs/refs/heads/main": "4f7e8b78bfc181d9d09555def06a6125",
".git/logs/refs/remotes/origin/main": "8b879db717fd05e4c5a88710df7e51f5",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/config": "da51fe0708f26f2edbdd93a77ad7390f",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"main.dart.js": "91ab13e3c3af4876af54f50b7d1ca49b",
"manifest.json": "a05830c9dbfc6600010a70b9a4916eb5",
"favicon.png": "e8fb18eb8f0fb4f7267cf2e870b0a8a8"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
