# Defold Realtime Multiplayer example with Colyseus

This project was created starting from the [Photon realtime example](https://github.com/defold/extension-photon-realtime) and modified to use self-hosted [Colyseus](https://colyseus.io/) as a backend.

<img src="https://colyseus.io/images/logos/logo-light-color.png" width="400">

# Example

<img src="/media/example.gif" width="400" height="320">

# Note

Currently only tested on Ubuntu 22.04.2 LTS.
This is generally a "beta" version, as it needs polish and simplification (e.g. using server state schema instead of passing data all around), treat it just as an example.
Project assumes you have [npm](https://www.npmjs.com/) already.
Prepared by Paweł Jarosz.

## Running the server

1. Create server:
   ```sh
   mdkir server
   cd server
   npm create colyseus-app@latest .
   ```
   When prompted, choose a recommended version (Typescript) and then:
   ```sh
   npm install
   ```

2. Start the server:
   ```sh
   npm start
   ```

The server listens by default on `ws://localhost:2567`.
The Defold client in this example will connect to this endpoint.
You can preview a default client in browser at this address.

If something won't be working check [Colyseus Defold FAQ](https://docs.colyseus.io/getting-started/defold)

3. Define custom room:

Example uses two rooms: lobby and default realtime room.
Add the second room and define onCreate, onJoin and onLeave callbacks.

If you don't want to modify server code on your own and if you created recommended Typescript version as above, you can just copy the modified `media/MyRoom.ts` and `media/app.config.ts` from this repository and paste it in your server's `src` directory (`src/rooms/MyRoom.ts` and `src/app.config.ts` respectively).

If you change some code on server side - close the server and restart it after using `npm start` again.

## Defold Tic-Tac-Toe example with Colyseus

If you want to see another example of how to use Colyseus with Defold check out:

[https://forum.defold.com/t/colyseus-tic-tac-toe-multiplayer-example/31449](https://forum.defold.com/t/colyseus-tic-tac-toe-multiplayer-example/31449)
