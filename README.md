# dekh-bhai

An explain-mode for coding agents. Turn it on and the agent stops talking like documentation and starts talking like the friend who explained your whole syllabus the night before the exam: Hinglish, short, one real-life analogy, and a straight answer to *tujhe karna kya hai*. Exam-night triage, so the thing you actually need comes first and the rest gets cut.

```
Dekh bhai, race condition matlab do bande ek hi ATM se ek hi account khaali
kar rahe hain, same second pe. Dono ko balance 1000 dikha, dono ne 1000
nikaal liya, account ab -1000.

Mental model: do haath ek cheez pe ek saath, matlab gadbad.

Tu bas updateBalance() pe lock laga de, src/wallet.ts:42.
```

Two skills:

| Skill | Does |
| --- | --- |
| `dekh-bhai` | Turns the tone on for the rest of the session |
| `undekh-bhai` | Turns it off and restores the agent's normal voice |

## What it does not touch

The tone applies to explanations in chat and nothing else. Commit messages, PR titles and descriptions, code, comments, docs and config stay in normal professional English, by rule, inside the skill itself. You should never end up reviewing a PR described in slang.

It also changes only *how* things are explained, never *what* the agent does. Same rigour, same verification, and "pata nahi bhai, check karke batata hoon" is an allowed answer where a confident guess is not.

## Install

Both skills are plain [Agent Skills](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview): a folder with a `SKILL.md`. Claude and Codex read the same format, so `skills/` works everywhere without a per-agent variant.

### Claude Code

```bash
/plugin marketplace add dewanshparashar/dekh-bhai
/plugin install dekh-bhai@dekh-bhai
```

Then `/dekh-bhai` and `/undekh-bhai`.

### Codex CLI

```bash
git clone https://github.com/dewanshparashar/dekh-bhai.git
ln -s "$PWD/dekh-bhai/skills/dekh-bhai"   ~/.codex/skills/dekh-bhai
ln -s "$PWD/dekh-bhai/skills/undekh-bhai" ~/.codex/skills/undekh-bhai
```

Restart Codex, confirm with `/skills`, then invoke with `$dekh-bhai`. Some Codex builds read `~/.agents/skills` instead of `~/.codex/skills`; if `/skills` does not list it, symlink into the other path.

### Claude app (web, desktop, mobile)

```bash
./scripts/package.sh
```

Upload `dist/dekh-bhai.zip` and `dist/undekh-bhai.zip` at **Settings > Customize > Skills > + > Upload a skill**. Code execution has to be enabled under Settings > Capabilities. Then just ask for it by name: *"use dekh-bhai mode"*.

### ChatGPT and Codex app

Same zips. Add them as skills and select with `@`.

### Any other agent

Paste the body of [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md) into the system prompt, custom instructions, `AGENTS.md`, or a Cursor rule. There is nothing agent-specific in it.

## A caveat on the apps

In the CLIs this is a real toggle: `/dekh-bhai` turns it on, `/undekh-bhai` turns it off. In the native apps, skills load when the model judges them relevant rather than on a slash command, so the mode is more of a request than a switch. If it drifts back to normal mid-conversation, say "dekh bhai mode" again.

## Editing the tone

Everything lives in [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md), deliberately short so it costs little context once loaded. Extra worked examples sit in [`examples.md`](skills/dekh-bhai/examples.md), which loads only when needed.

Two rules worth keeping if you edit it. The analogy has to match the real mechanics, because a wrong analogy that gets a laugh is worse than no analogy. And short means fewer words, never fewer facts: if something is genuinely risky, it stays in even when it makes the answer longer.

## License

MIT
