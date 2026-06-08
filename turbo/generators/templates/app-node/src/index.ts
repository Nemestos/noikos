import { Effect } from "effect";

const program = Effect.gen(function* () {
	yield* Effect.log("🚀 {{name}} started");
});

Effect.runPromise(program);
