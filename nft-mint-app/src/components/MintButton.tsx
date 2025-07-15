import { useActiveAccount, TransactionButton } from "thirdweb/react";
import { claimTo } from "thirdweb/extensions/erc1155";
import { getContract, createThirdwebClient } from "thirdweb";
import { polygon } from "thirdweb/chains";
import { EDITION_DROP_ADDRESS } from "../constants";

const client = createThirdwebClient({ clientId: import.meta.env.VITE_TEMPLATE_CLIENT_ID });

export function MintButton() {
  const account = useActiveAccount();

  const contract = getContract({
    client,
    chain: polygon,
    address: EDITION_DROP_ADDRESS,
  });

  return (
    <TransactionButton
      transaction={() =>
        claimTo({
          contract,
          to: account?.address || "",
          tokenId: 0n,
          quantity: 1n,
        })
      }
      disabled={!account}
      onTransactionConfirmed={() => {
        const confirmed = window.confirm("🎉 ミント成功しました！\nアプリに戻りますか？");
        if (confirmed) {
          window.location.href = "https://fishdrip.jp/";
        }
      }}
      onError={(err) => alert("❌ エラー（ミント失敗しました。）：" + err.message)}

      //gasless={{
      //  provider: "openzeppelin",
      //  relayerUrl: import.meta.env.VITE_OPENZEPPELIN_RELAYER_URL,
      //  relayerForwarderAddress: "0x64CD353384109423a966dCd3Aa30D884C9b2E057",
      //}}
    >
      Mint NFT

    </TransactionButton>
  );
}
