import { Effect } from "effect";

const program = Effect.gen(function* () {
	yield* Effect.log("🚀 api started");
});

Effect.runPromise(program);
