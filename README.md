# dekh-bhai / dekh-bro

**Start your question with `/dekh-bhai` or `/dekh-bro`.** Your coding agent then explains it like the friend who taught you the whole syllabus the night before the exam.

No slop. No overwhelm. No anxiety.

## Usage

Same prompt, same facts, same fix. Only the explaining changes.

**Without `/dekh-bhai`** (Eww..)

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

**With `/dekh-bhai`**

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

<details>
<summary><strong>One more, where the answer is "do nothing"</strong></summary>

**Without `/dekh-bhai`** (Eww..)

```diff
@@ do I need to do anything about this dependabot alert? @@

- This advisory affects postcss versions prior to 8.4.31 and is categorised as
- moderate severity. Reviewing the dependency graph, postcss is reachable only
- through your build toolchain and is therefore not present in the runtime
- bundle shipped to end users. The theoretical attack vector requires an...
-
-                                                      [ 14 more lines ]
```

**With `/dekh-bhai`**

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

</details>

More in [`examples.md`](skills/dekh-bhai/examples.md).

## Install (30 seconds)

```bash
npx skills@latest add dewanshparashar/dekh-bhai
```

That is it. It covers Claude Code, Codex, Cursor, Gemini CLI, Copilot, OpenCode, Zed, Amp, Droid and a dozen others, and asks which ones you want. Then start any message with `/dekh-bhai`. On agents with no slash commands, plain `dekh-bhai` at the front of the message works the same.

<details>
<summary><strong>Claude Code, as a plugin</strong></summary>

```
/plugin marketplace add dewanshparashar/dekh-bhai
/plugin install dekh-bhai@dekh-bhai
```

Gives you real slash commands: `/dekh-bhai`, `/dekh-bro`, `/undekh-bhai`.

</details>

<details>
<summary><strong>Claude app and ChatGPT</strong></summary>

Run `./scripts/package.sh` and upload the zips from `dist/` in skill settings. There are no slash commands in the apps, so ask for it by name: "use dekh-bhai mode".

</details>

<details>
<summary><strong>Anything else</strong></summary>

Paste [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md) into the system prompt, `AGENTS.md`, or a Cursor rule. Nothing in it is agent-specific.

</details>

## Reference

| Skill | What it does |
| --- | --- |
| [`dekh-bhai`](skills/dekh-bhai/SKILL.md) | Explains the thing. Short, one analogy that matches the real mechanics, exact command at the end. |
| [`dekh-bro`](skills/dekh-bro/SKILL.md) | Same skill, other name. Use whichever you say out loud. |
| [`undekh-bhai`](skills/undekh-bhai/SKILL.md) | Back to the normal tone. |

> [!TIP]
> Keep `undekh-bhai` in reach. The tone is for explaining things to you in chat, never for anything you commit or send.

## What it will not do

- **Touch anything written for other people.** Commits, PR text, code, comments and docs stay in normal English. Nobody reviews a PR written in slang.
- **Trade accuracy for a laugh.** It changes how things are explained, never what gets done. "Pata nahi bhai, check karke batata hoon" is allowed where a confident guess is not.
- **Drop the specifics.** Short means fewer words, never fewer facts. Every answer ends with a command, a path or a literal name.
- **Dumb down the vocabulary.** `idempotent` stays `idempotent`. The analogy explains the word, it never renames it, so you can still read the docs and follow the standup. Ask what it means and you get the same treatment for the word itself.
- **Fire on its own.** It stays off until you ask for it.

## Editing

The tone lives in [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md), kept short because a loaded skill costs context every turn. One rule worth keeping if you add your own analogies: it has to match the real mechanics. A wrong analogy that gets a laugh is worse than no analogy.

## License

MIT
