#!/bin/bash

# --- KONFIGURACJA ---
# Nazwa aplikacji, w której ma się otworzyć katalog (dokładna nazwa z macOS)
OPEN_APP="antigravity"

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
        "account")        REPO_URL="git@github.com:rmiq-net/account-service.git" ;;
        "agent")          REPO_URL="git@github.com:rmiq-net/agent-service.git" ;;
        "amazon")         REPO_URL="git@github.com:rmiq-net/amazon-integration-service.git" ;;
        "audit")          REPO_URL="git@github.com:rmiq-net/audit-service.git" ;;
        "auth")           REPO_URL="git@github.com:rmiq-net/auth-service.git" ;;
        "campaign")       REPO_URL="git@github.com:rmiq-net/campaign-service.git" ;;
        "catalog")        REPO_URL="git@github.com:rmiq-net/catalog-service.git" ;;
        "common")         REPO_URL="git@github.com:rmiq-net/common-libs.git" ;;
        "demo")           REPO_URL="git@github.com:rmiq-net/demo-service.git" ;;
        "infrastructure") REPO_URL="git@github.com:rmiq-net/infrastructure.git" ;;
        "instacart")      REPO_URL="git@github.com:rmiq-net/instacart-integration-service.git" ;;
        "pentaleap")      REPO_URL="git@github.com:rmiq-net/pentaleap-integration-service.git" ;;
        "reporting")      REPO_URL="git@github.com:rmiq-net/reporting-service.git" ;;
        "rmiq-deploy")    REPO_URL="git@github.com:rmiq-net/rmiq-deploy.git" ;;
        "stripe")         REPO_URL="git@github.com:rmiq-net/stripe-integration-service.git" ;;
        "target")         REPO_URL="git@github.com:rmiq-net/target-integration-service.git" ;;
        "ui")             REPO_URL="git@github.com:rmiq-net/ui.git" ;;
        "walmart")        REPO_URL="git@github.com:rmiq-net/walmart-integration-service.git" ;;
        "wiremock")       REPO_URL="git@github.com:rmiq-net/wiremock-deploy.git" ;;
        "workflow")       REPO_URL="git@github.com:rmiq-net/workflow-service.git" ;;
        *)                echo "⚠️  Nieznane słowo kluczowe: '$KEYWORD'. Pomijam." ;;
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

# 4. OTWIERANIE W GRAVITY
echo "🚀 Otwieranie workspace w $OPEN_APP..."

# 'open -a' to komenda macOS. Kropka '.' oznacza "otwórz obecny katalog".
open -a "$OPEN_APP" .

echo "🎉 Zakończono!"
