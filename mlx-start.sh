#!/bin/bash

/Users/murm/llm/mlx/bin/mlx_vlm.chat --model mlx-community/gemma-4-26b-a4b-it-8bit --kv-bits 4 --kv-quant-scheme turboquant --prefill-step-size 4096 --max-kv-size 32768 --max-tokens 16384
