# dekh-bhai / dekh-bro

Makes your coding agent help you understand things like the friend who made you study the entire syllabus the night before the exam.

```
                  .-""""""-.
                .'          '.
     _  _  _   /              \
    | || || | |                |
  _ | || || | |    .-.    .-.  |        dekh bhai
 |  | || || | |                |        ---------
 |          | |     .-''-.     |        ruk, main samjhata hoon
 |          | |                |
  \        /  \              /
   '------'    '.          .'
                  '-.______.-'
```

Short, Hinglish, one analogy, straight to what you have to do. Same question, same facts, both answers correct:

<table>
<tr><th width="50%">Before</th><th width="50%">After</th></tr>
<tr valign="top">
<td>

This is a race condition. Two concurrent requests read the account balance before either of them writes, so both observe a balance of 1000 and both proceed with a withdrawal of 1000. The second write overwrites the first rather than accounting for it, which leaves the balance at -1000.

To fix it you need to serialize access to the critical section. The usual options are a database-level lock (`SELECT ... FOR UPDATE`), an application-level mutex, or an atomic conditional update. Which one is appropriate depends on whether your deployment runs a single process or several.

</td>
<td>

Dekh bhai, race condition matlab do bande ek hi ATM se ek hi account khaali kar rahe hain, same second pe. Dono ko balance 1000 dikha, dono ne 1000 nikaal liya, account ab -1000.

Mental model: do haath ek cheez pe ek saath, matlab gadbad.

Tu bas `updateBalance()` pe lock laga de, `src/wallet.ts:42`.

</td>
</tr>
</table>

`dekh-bhai` or `dekh-bro` turns it on, `undekh-bhai` turns it off. Same thing, use whichever you type faster.

Chat only. Commits, PRs, code and docs stay in normal English, so nobody reviews a PR written in slang.

## Install

**Claude Code**

```
/plugin marketplace add dewanshparashar/dekh-bhai
/plugin install dekh-bhai@dekh-bhai
```

**Codex CLI**

```bash
git clone https://github.com/dewanshparashar/dekh-bhai.git
mkdir -p ~/.codex/skills
ln -s "$PWD/dekh-bhai/skills/"* ~/.codex/skills/
```

Restart, check `/skills`, use `$dekh-bhai`. Kuch builds `~/.agents/skills` padhte hain, wahan link kar dena agar na dikhe.

**Claude app / ChatGPT**

Run `./scripts/package.sh`, upload the zips from `dist/` in skill settings, then just say "use dekh-bhai mode". No slash command there, so it is a request and not a switch.

**Anything else**

Paste [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md) into the system prompt. Nothing in it is agent-specific.

## Editing

Tone lives in [`SKILL.md`](skills/dekh-bhai/SKILL.md), extra examples in [`examples.md`](skills/dekh-bhai/examples.md). Two rules: the analogy must match the real mechanics, and short means fewer words, never fewer facts.

There is a drawn version of the hand in [`assets/`](assets/dekh-bhai.svg) if you want it as the repo social preview.

MIT
