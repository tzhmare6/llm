#!/bin/bash
export OPENAI_API_BASE=http://localhost:11080/v1
export OPENAI_API_KEY=not-needed

# Name der Screen-Session
SESSION_NAME="mlx"
OWU_SESSION_NAME="owu"

# Prüfen, ob die Screen-Session für mlx bereits existiert
if screen -list | grep -q "\.$SESSION_NAME"; then
    echo "Session '$SESSION_NAME' existiert bereits. Starte OWN..."
else
    echo "Session '$SESSION_NAME' nicht gefunden. Erstelle Session und starte mlx_lm-Server..."
    # Erstellt eine neue, abgetrennte (detached) Session und führt den Server darin aus
    screen -d -m -S "$SESSION_NAME" /Users/murm/llm/mlx/bin/mlx_vlm.server --model mlx-community/gemma-4-26b-a4b-it-8bit --kv-bits 4 --kv-quant-scheme turboquant --prefill-step-size 4096 --vision-cache-size 10 --max-num-seqs 2 --max-kv-size 65536 --max-tokens 16384 --port 11080 --host 0.0.0.0
    
    # Kurze Pause, damit der Server Zeit hat zu initialisieren
    sleep 3
fi

# OWU starten
# Prüfen, ob die Screen-Session für owu bereits existiert
if screen -list | grep -q "\.$OWU_SESSION_NAME"; then
    echo "Session '$OWU_SESSION_NAME' existiert bereits. Starte OWN..."
else
    echo "Session '$OWU_SESSION_NAME' nicht gefunden. Erstelle Session und starte Open-WebUI-Server..."
    # Erstellt eine neue, abgetrennte (detached) Session und führt den Server darin aus
    screen -d -m -S "$OWU_SESSION_NAME" /Users/murm/llm/owu/bin/open-webui serve --port 11081

    # Kurze Pause, damit der Server Zeit hat zu initialisieren
    sleep 3
fi
