# TerraformSpotifyPlaylist
Creating Multiple Spotify Playlists Using Terraform

1. Create ```provider.tf``` in VS Code

2. Search ```provider terraform``` in browser . Go into registry and get a ```spotify provider```

3. in ```Documentation``` get the API Key => String that is a Oauth2 Proxy API Key (Need to connect to spotify account)

4. In ```provider.tf```, define the Spotify provider:
```bash
provider "spotify" {
  api_key = "?"
}
```
5. Need API Key

To interact with Spotify's API, you need a Client ID and Client Secret.

6. Start with App Creation

	i.   Go to the [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/).
	
    ii.  Log in with your Spotify account.
	
    iii. Click on "Create an App"
  
	  iv.  Fill in the required details and create the app.

    | Name                          | Description |
    | ---                           | --- |
    | My Playlist through Terraform | Create multiple Spotify playlists using Terraform. |
    - *Redirect URIs: [http://localhost:27228/spotify_callback](http://localhost:27228/spotify_callback**)
	
	Click on Settings and note down the **Client ID** and**Client Secret**.

	5. Enter Details
      Create a file named .env to store your Spotify application's Client ID and Secret:
```bash
SPOTIFY_CLIENT_ID=<your_spotify_client_id>
SPOTIFY_CLIENT_SECRET=<your_spotify_client_secret>
```

​
	6. Run the Spotify Auth App and Get the API Key ,Make sure Docker Desktop is running, and start the authorization proxy server: got it from (https://github.com/conradludgate/terraform-      provider-spotify/pkgs/container/spotify-auth-proxy)


```bash
docker run --rm -it -p 27228:27228 --env-file .env ghcr.io/conradludgate/spotify-auth-proxy
```
You should get “Authorization Successful” Message.

**FOR STORING API KEY SAFELY**

Create ```terraform.tfvars```
```bash 
api_key = "String"
```
Create ```variables.tf```
```bash
variable "api_key" {
  type = string
}
```
NOTE: Make sure the container is running throught the process(open a new terminal for next steps)

8. Continue Creating Terraform Code
   
9. Initialize and Apply Terraform Configuration
    
   Create  a ```playlist.tf```
   ```bash
   resource "spotify_playlist" "Bollywood" {
    name = "Bollywood"
    tracks = ["5jAi1HXmSUd5poIEOQkYSy"] #This is the track ID when a song is selected in spotify(got it from the link)
     }
    ```
Initialize the Terraform configuration:
```bash 
terraform init
```

​
Apply the Terraform configuration:
```bash
terraform apply
```

NOTE: It is simple to create playlist this way but it is tedious to get the tracks id for each song to be added in the playlist. So we are going to use a "Data Block" in ```playlist.tf```
```bash
#Data Block [using Terraform with a Spotify provider to search for tracks by Eminem]
data "spotify_search_track" "eminem" {
  artist = "Eminem"
}
#add 3 eminem songs in slimshady playlist
resource "spotify_playlist" "slimshady" {
  name = "slim shady"
  tracks = [data.spotify_search_track.eminem .tracks[0].id ,
            data.spotify_search_track.eminem .tracks[1].id,
            data.spotify_search_track.eminem .tracks[2].id]
}
```
