<script lang="ts">
	import Monaco from "$lib/components/Monaco.svelte";
	import type monaco from "monaco-editor";
	import type { PageServerData } from "./$types";

  export let data: PageServerData;
  console.log(data);

  let evalMonaco: monaco.editor.IStandaloneCodeEditor;
  let evalOutMonaco: monaco.editor.IStandaloneCodeEditor;

</script>

<div class="size-full flex flex-col items-center" >
  <div class="self-start">
  <h1>{data.node.name}</h1>
  <p>#{data.node.id}</p>
  </div>

  <div class="size-full flex flex-col items-center">
    
    <div class="flex flex-col w-full h-3/4 p-3 bg-slate-800 rounded-xl">
      <button on:click={async () => {

        const code = evalMonaco.getValue()
        const res = await fetch(`/api/admin/nodes/${data.node.id}/eval`, {
          method: "POST",
          body: code
        })

        let resText = await res.text()

        if (res.status !== 200) {
          resText = `Error: ${res.status} ${resText}`
        }
        evalOutMonaco.setValue(resText)
      }
        }>Eval</button>
      <div class="size-full flex pb-5 flex-row">
        <div class="w-1/2 h-full items-center overflow-hidden">
          <h3>Input</h3>
          <Monaco bind:editor={evalMonaco} language={"lua"} code={'return "a"'}/>
        </div>

        <div class="w-1/2 h-full items-center overflow-hidden">
          <h3>Output</h3>
          <Monaco bind:editor={evalOutMonaco} language={"json"} code={'"Output will show here"'}/>
        </div>
      </div>
    </div>
  </div>
  
</div>