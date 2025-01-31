resource "spotify_playlist" "Bollywood" {
    name = "Bollywood"
    tracks = ["5jAi1HXmSUd5poIEOQkYSy"]
  
}
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
