import { ConnectButton } from "thirdweb/react";
import { MintButton } from "./components/MintButton";
import { client } from "./client";

export function App() {
  return (
    <main className="p-10 flex flex-col items-center gap-8">
      <ConnectButton
        client={client}
        appMetadata={{
          name: "FishDrip Mint App",
          url: "https://example.com",
        }}
      />
      <MintButton />
    </main>
  );
}
