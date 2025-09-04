import { Room, Client } from "@colyseus/core";

interface PlayerInfo {
  sessionId: string;
  player_nr: number;
}

export class MyRoom extends Room {
  private players = new Map<string, PlayerInfo>();
  private nextNr = 1;
  maxClients = 4;

  onCreate(options: any) {
    // Server is passing data changes in realtime to connected players
    const dataChangesTypes = ["pos", "turn", "move", "attack", "jump"] as const;
    for (const type of dataChangesTypes) {
      this.onMessage(type, (client, payload) => {
        this.broadcast(type, { clientId: client.sessionId, ...payload }, { except: client });
      });
    }
  }

  onJoin(client: Client, options: any) {
    console.log(client.sessionId, "joined!");
    // Give the joined client a unique player number and remember
    const info: PlayerInfo = { sessionId: client.sessionId, player_nr: this.nextNr++ };
    this.players.set(client.sessionId, info);

    // Send the joined client a list of all players in room
    const playersList = Array.from(this.players.values());
    client.send("players", playersList);

    // broadcast that this player joined room
    this.broadcast("player_join", info, { except: client });
  }

  onLeave(client: Client, consented: boolean) {
    console.log(client.sessionId, "left!");
    const info = this.players.get(client.sessionId);
    if (info) {
      this.players.delete(client.sessionId);
      this.broadcast("player_leave", info);
    }
  }

  onDispose() {
    console.log("room", this.roomId, "disposing...");
  }

}
