#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

command -v whois >/dev/null 2>&1 || {
  echo "❌ whois не знайдено. Встанови його через: pkg install whois"
  exit 1
}


# 🛡️ UzvarUA WHOIS Lookup Module
# 📦 Автор: Роббі & Copilot
# 🕒 Версія: v1.0

clear
echo -e "\n🌐 WHOIS Lookup — UzvarUA Style"
echo -e "🔍 Введи домен для аналізу (наприклад: github.com):"

read -r domain || {
  echo "Не зміг прочитати домен"
  exit 1
}

[[ -z "$domain" ]] && {
  echo "Не домен не може бути порожнім"
  exit 1
}

echo -e "\n📡 Виконується WHOIS-запит для: $domain\n"
whois_output=$(whois "$domain")

# 🧠 Витягуємо дату створення
creation_date=$(echo "$whois_output" | grep -iE 'Creation Date:' | head -n 1 | awk '{print $NF}')

# 📄 Створюємо Markdown-звіт
report="uzvar-whois-$domain.md"
{
  echo "# 🌐 WHOIS Звіт: $domain"
  echo "- 📅 Дата створення: \`$creation_date\`"
  echo "- 🕵️‍♂️ Витягнуто: \`$(date '+%Y-%m-%d %H:%M:%S')\`"
  echo "- 🧰 Інструмент: UzvarUA Whois Lookup"
  echo ""
  echo "## 🔍 Повний WHOIS:"
  echo '```'
  echo "$whois_output"
  echo '```'
} > "$report"

echo -e "\n✅ Звіт збережено у: $report"
echo -e "📖 Переглянь його у Markdown-редакторі або через \`cat $report\`\n"
