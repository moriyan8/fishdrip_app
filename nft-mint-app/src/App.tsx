import { ConnectButton } from "thirdweb/react";
import { MintButton } from "./components/MintButton";
import { client } from "./client";
import { wallets } from "./wallets";

export function App() {
  return (
    <main className="p-10 flex flex-col items-center gap-8">
      <h2 className="text-white text-2xl font-bold drop-shadow-lg">NFT free mint!</h2>
      <img
        src="/assets/nft1.jpeg"
        alt="NFT Preview"
        className="w-64 h-64 object-cover rounded-xl shadow-md"
      />
      <ConnectButton
        client={client}
        wallets={wallets}
        connectModal={{ size: "compact" }}
      />
      <MintButton />
    </main>
  );
}
