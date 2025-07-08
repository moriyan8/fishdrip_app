import {
  ConnectButton,
  useActiveAccount,
  useReadContract,
  useSendTransaction,
} from "thirdweb/react";
import { getContract } from "thirdweb";
import { editionDropAbi } from "thirdweb/abi";
import { createThirdwebClient } from "thirdweb";
//import { useState } from "react";

const client = createThirdwebClient({
  clientId: import.meta.env.VITE_THIRDWEB_CLIENT_ID,
});

const CONTRACT_ADDRESS = import.meta.env.VITE_CONTRACT_ADDRESS!;
const TOKEN_ID = 0;

export default function App() {
  const account = useActiveAccount();

  const contract = getContract({
    client,
    chain: 137,
    address: CONTRACT_ADDRESS,
    abi: editionDropAbi,
  });

  const { data: uri } = useReadContract({
    contract,
    method: "uri",
    params: [TOKEN_ID],
  });

  const claimTx = useSendTransaction({
    contract,
    method: "claim",
  });

  const handleMint = () => {
    if (!account) return alert("ウォレットを接続してください");
    claimTx.mutate({
      params: [account.address, TOKEN_ID, 1, "0x"],
    });
  };

  return (
    <div style={{ textAlign: "center", padding: "2rem" }}>
      <h1>🎣 FishDrip NFT ミントページ</h1>

      <ConnectButton client={client} />

      {uri && (
        <>
          <p>メタデータURI: {uri}</p>
          <button
            onClick={handleMint}
            style={{
              padding: "1rem 2rem",
              marginTop: "1rem",
              backgroundColor: "#4caf50",
              color: "white",
              border: "none",
              cursor: "pointer",
            }}
          >
            🎁 ミントする
          </button>
        </>
      )}
    </div>
  );
}
