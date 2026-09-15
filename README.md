# dekh-bhai / dekh-bro

Makes your coding agent help you understand things like the friend who made you study the entire syllabus the night before the exam.

Short, Hinglish, one analogy that actually maps to the mechanics, and the exact command at the end. `dekh-bhai` or `dekh-bro` turns it on, `undekh-bhai` turns it off.

## Usage

Same prompt, same facts, same fix.

```diff
@@ explain what's going on in this ticket @@

- Based on the description and the attached logs, the ticket reports account
- balances going negative under concurrent load. The underlying cause appears
- to be a race condition in the withdrawal path. Specifically, two concurrent
- requests read the account balance before either of them has committed its
- write, so both observe a balance of 1000 and both proceed...
-
-                                                       [ 9 more lines ]
```

```diff
@@ /dekh-bhai explain what's going on in this ticket @@

+ Dekh bhai, ticket keh raha hai balance minus mein ja raha hai. Do bande ek hi
+ ATM se ek hi account khaali kar rahe hain, same second pe. Dono ko 1000 dikha,
+ dono ne 1000 nikaal liya, account ab -1000 🤦
+
+ Mental model: do haath ek cheez pe ek saath, matlab gadbad.
+
+ Tu bas updateBalance() ki query ko SELECT ... FOR UPDATE bana de,
+ src/wallet.ts:42. Ek time pe ek banda andar.
```

Sometimes the honest answer is that there is nothing to do, and you get that in one line instead of four paragraphs:

```diff
@@ /dekh-bhai do I need to do anything about this dependabot alert? @@

+ Dekh bhai, isme tujhe kuch nahi karna. Ye postcss wala alert sirf build ke
+ time ka hai, prod bundle mein jaata hi nahi. Ghar ka darwaza khula nahi hai,
+ godown ka hai, aur godown mein bhi taala laga hua hai.
+
+ Bas PM ko message kar de ki ticket close kar de.
+
+ Dashboard saaf chahiye toh package.json mein "overrides": { "postcss":
+ "8.4.31" } daal de, 30 second ka kaam.
```

More in [`examples.md`](skills/dekh-bhai/examples.md).

## Install

### Claude Code

```
/plugin marketplace add dewanshparashar/dekh-bhai
/plugin install dekh-bhai@dekh-bhai
```

Then `/dekh-bhai`, `/dekh-bro` and `/undekh-bhai`.

### Codex CLI

```bash
git clone https://github.com/dewanshparashar/dekh-bhai.git
mkdir -p ~/.codex/skills
ln -s "$PWD/dekh-bhai/skills/"* ~/.codex/skills/
```

Restart Codex, confirm with `/skills`, then use `$dekh-bhai`. Some builds read `~/.agents/skills` instead, so link there if it does not show up.

### Claude app and ChatGPT

Run `./scripts/package.sh` and upload the zips from `dist/` in skill settings. There is no slash command in the apps, so ask for it by name: "use dekh-bhai mode".

### Any other agent

Paste [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md) into the system prompt, `AGENTS.md`, or a Cursor rule. Nothing in it is agent-specific.

## What it will not do

- **Touch anything written for other people.** Commits, PR text, code, comments and docs stay in normal English. Nobody reviews a PR written in slang.
- **Trade accuracy for a laugh.** It changes how things are explained, never what gets done. "Pata nahi bhai, check karke batata hoon" is allowed where a confident guess is not.
- **Drop the specifics.** Short means fewer words, never fewer facts. Every answer ends with a command, a path or a literal name.
- **Fire on its own.** It stays off until you ask for it.

## Editing

The tone lives in [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md), kept short because a loaded skill costs context every turn. One rule worth keeping if you add your own analogies: it has to match the real mechanics. A wrong analogy that gets a laugh is worse than no analogy.

## License

MIT
