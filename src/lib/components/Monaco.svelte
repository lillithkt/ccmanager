<script lang="ts">
  import type monaco from 'monaco-editor';
  import editorWorker from 'monaco-editor/esm/vs/editor/editor.worker?worker';
  import cssWorker from 'monaco-editor/esm/vs/language/css/css.worker?worker';
  import htmlWorker from 'monaco-editor/esm/vs/language/html/html.worker?worker';
  import jsonWorker from 'monaco-editor/esm/vs/language/json/json.worker?worker';
  import tsWorker from 'monaco-editor/esm/vs/language/typescript/ts.worker?worker';
  import { onMount } from 'svelte';

  let divEl: HTMLDivElement|null = null;
  export let editor: monaco.editor.IStandaloneCodeEditor | null = null;
  export let language: string = 'javascript';
  export let code: string = ['function x() {', '\tconsole.log("Hello world!");', '}'].join('\n');
  let Monaco;

  onMount(() => {
      // @ts-ignore
      self.MonacoEnvironment = {
          getWorker: function (_moduleId: any, label: string) {
              if (label === 'json') {
                  return new jsonWorker();
              }
              if (label === 'css' || label === 'scss' || label === 'less') {
                  return new cssWorker();
              }
              if (label === 'html' || label === 'handlebars' || label === 'razor') {
                  return new htmlWorker();
              }
              if (label === 'typescript' || label === 'javascript') {
                  return new tsWorker();
              }
              return new editorWorker();
          }
      };

      (async () => {
          Monaco = await import('monaco-editor');
          editor = Monaco.editor.create(divEl!, {
              value: code,
              language,
              theme: 'vs-dark',
          });
      })();

      return () => {
          editor?.dispose();
      };
  });
</script>

<div bind:this={divEl} class="monaco" />

<style>
  .monaco {
      height: 100%;
  }
</style>