import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("agent_settled", (_event, ctx) => {
    if (ctx.mode === "tui" && process.env.TMUX && process.stdout.isTTY) {
      process.stdout.write("\x07");
    }
  });
}
