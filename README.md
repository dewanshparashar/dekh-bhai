# dekh-bhai / dekh-bro

Makes your coding agent help you understand things like the friend who made you study the entire syllabus the night before the exam.

Short, Hinglish, one analogy that actually maps to the mechanics, and the exact command at the end. `dekh-bhai` or `dekh-bro` turns it on, `undekh-bhai` turns it off.

## Examples

### explain what's going on in this ticket

**Without:**

> Based on the description and the attached logs, the ticket reports account balances going negative under concurrent load. The underlying cause appears to be a race condition in the withdrawal path.
>
> Specifically, two concurrent requests read the account balance before either of them has committed its write. Both therefore observe a balance of 1000 and both proceed with a withdrawal of 1000. The second write overwrites the first rather than accounting for it, so the two withdrawals are effectively applied to the same starting state and the balance settles at -1000.
>
> Resolving this requires serializing access to the critical section so that only one transaction can read and modify the balance at a time. The usual options are a database-level lock (`SELECT ... FOR UPDATE`), an application-level mutex, or an atomic conditional update that rejects the write if the balance has changed. Which of these is appropriate depends on whether your deployment runs a single process or several.

**With `/dekh-bhai`:**

> Dekh bhai, ticket keh raha hai balance minus mein ja raha hai. Do bande ek hi ATM se ek hi account khaali kar rahe hain, same second pe. Dono ko 1000 dikha, dono ne 1000 nikaal liya, account ab -1000 🤦 Isko race condition bolte hain.
>
> Mental model: do haath ek cheez pe ek saath, matlab gadbad.
>
> Tu bas `updateBalance()` ki query ko `SELECT ... FOR UPDATE` bana de, `src/wallet.ts:42`. Ek time pe ek banda andar.

### why is this endpoint so slow?

**Without:**

> There are a few possible contributors to the latency you are observing, but the most significant one appears to be in `src/feed.ts`. The loop beginning at line 88 invokes `getUser()` once per item in the feed. With the current page size of 200, that results in 200 sequential database round trips for a single request, and since each round trip carries its own network and query-planning overhead, the cost compounds quickly.
>
> Several secondary factors may also be worth investigating. Connection pool saturation under concurrent load could introduce queuing delay, and a missing index on the lookup column would make each individual query slower than necessary.
>
> The conventional remedy for this pattern, commonly referred to as the N+1 query problem, is to collect the identifiers first and issue a single batched query. That said, I would recommend profiling to confirm the hypothesis before making changes.

**With `/dekh-bhai`:**

> Simple hai. Tera page database se 200 baar poochh raha hai, jabki ek hi baar mein sab aa sakta tha. Kirane ki dukaan 200 chakkar, har baar ek cheez 🤦
>
> Mental model: loop ke andar database call dikhe toh yahi bimaari hai. Naam hai N+1.
>
> `getUser()` ko loop se bahar nikaal, `getUsersByIds(ids)` se ek query maar, `src/feed.ts:88`. 2s se 120ms.

### do I need to do anything about this dependabot alert?

**Without:**

> The alert refers to a moderate-severity advisory in `postcss`, in which a specially crafted stylesheet can trigger excessive backtracking during parsing and lead to a denial of service.
>
> In your project, `postcss` is present as a transitive dependency of `tailwindcss`, which is declared under `devDependencies`. It is therefore exercised at build time and is not included in the production bundle, which meaningfully limits the exposure. Realistically, an attacker would need to get untrusted CSS into your build pipeline for this to be reachable.
>
> You may nonetheless wish to resolve it in order to clear the alert from your dashboard. The two usual approaches are bumping `tailwindcss` to a release that depends on a patched `postcss`, or pinning the patched version directly via an `overrides` entry. Whether to prioritise this now depends on your team's policy regarding moderate, development-only advisories.

**With `/dekh-bhai`:**

> Dekh bhai, isme tujhe kuch nahi karna. Ye `postcss` wala alert sirf build ke time ka hai, prod bundle mein jaata hi nahi. Ghar ka darwaza khula nahi hai, godown ka hai, aur godown mein bhi already taala laga hua hai.
>
> Bas PM ko message kar de ki ticket close kar de.
>
> Dashboard saaf chahiye toh `package.json` mein `"overrides": { "postcss": "8.4.31" }` daal de, 30 second ka kaam.

Same facts, same fixes, all six answers correct. Three of them you can act on in ten seconds.

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

- **Touch anything written for other people.** Commit messages, PR titles and descriptions, code, comments, docs and config stay in normal English. Nobody ends up reviewing a PR written in slang.
- **Trade accuracy for a laugh.** The tone changes how things are explained, never what gets done. "Pata nahi bhai, check karke batata hoon" is an allowed answer where a confident guess is not.
- **Drop the specifics.** Short means fewer words, never fewer facts. Every answer ends with a command, a path, or a literal name you can act on.
- **Fire on its own.** It stays off until you ask for it.

## Editing

The tone lives in [`skills/dekh-bhai/SKILL.md`](skills/dekh-bhai/SKILL.md), kept short because a loaded skill costs context on every turn. Extra worked examples sit in [`examples.md`](skills/dekh-bhai/examples.md) and load only when needed.

One rule worth keeping if you add your own analogies: the analogy has to match the real mechanics. A wrong analogy that gets a laugh is worse than no analogy.

## License

MIT
