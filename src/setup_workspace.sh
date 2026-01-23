#!/bin/bash

# 1. WALIDACJA ARGUMENTÓW
if [ "$#" -lt 1 ]; then
    echo "❌ Błąd: Podaj nazwę katalogu roboczego."
    echo "Użycie: $0 <katalog> [słowa_kluczowe...]"
    exit 1
fi

TARGET_DIR="$1"

# 2. PRZYGOTOWANIE KATALOGU ROBOCZEGO
if [ ! -d "$TARGET_DIR" ]; then
    echo "📂 Tworzenie katalogu głównego: $TARGET_DIR"
    mkdir -p "$TARGET_DIR"
else
    echo "📂 Katalog główny '$TARGET_DIR' już istnieje."
fi

# Jeśli brak słów kluczowych, kończymy
if [ "$#" -eq 1 ]; then
    echo "✅ Gotowe (brak repozytoriów do pobrania)."
    exit 0
fi

shift # Usuwamy nazwę katalogu z listy argumentów
cd "$TARGET_DIR" || { echo "❌ Błąd wejścia do katalogu"; exit 1; }

# 3. PĘTLA PO REPOZYTORIACH
echo "⬇️  Przetwarzanie..."

for KEYWORD in "$@"; do
    REPO_URL=""

    # --- MAPOWANIE ---
    case "$KEYWORD" in
        "amazon")
            REPO_URL="git@github.com:rmiq-net/amazon-integration-service.git"
            ;;
        "walmart")
            REPO_URL="git@github.com:rmiq-net/walmart-integration-service.git"
            ;;
        "demo")
            REPO_URL="git@github.com:rmiq-net/demo-service.git"
            ;;
        "catalog")
            REPO_URL="git@github.com:rmiq-net/catalog-service.git"
            ;;
        "common")
            REPO_URL="git@github.com:rmiq-net/common-libs.git"
            ;;
        "instacart")
            REPO_URL="git@github.com:rmiq-net/instacart-integration-service.git"
            ;;
        "wiremock")
            REPO_URL="git@github.com:rmiq-net/wiremock-deploy.git"
            ;;
        "campaign")
            REPO_URL="git@github.com:rmiq-net/campaign-service.git"
            ;;
        *)
            echo "⚠️  Nieznane słowo kluczowe: '$KEYWORD'. Pomijam."
            ;;
    esac

    # --- LOGIKA KLONOWANIA ---
    if [ -n "$REPO_URL" ]; then
        # Wyciągamy nazwę folderu z URL (np. 'amazon-integration-service')
        REPO_DIR_NAME=$(basename "$REPO_URL" .git)

        if [ -d "$REPO_DIR_NAME" ]; then
            echo "⏭️  Pominięto: Katalog '$REPO_DIR_NAME' już istnieje."
        else
            echo "📥 Klonowanie: $REPO_DIR_NAME ($KEYWORD)..."
            git clone "$REPO_URL"
        fi
    fi
done

antigravity --new-window "$TARGET_DIR"

echo "🎉 Zakończono!"
