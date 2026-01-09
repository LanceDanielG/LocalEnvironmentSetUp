# 🚀 Envy
 
[![npm version](https://img.shields.io/npm/v/@lancedanielg/envy?color=brightgreen)](https://www.npmjs.com/package/@lancedanielg/envy)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![npm downloads](https://img.shields.io/npm/dt/@lancedanielg/envy)](https://www.npmjs.com/package/@lancedanielg/envy)
 
A powerful, dynamic tool to scaffold full-stack development environments with Docker. Automatically creates a standardized project structure with custom API, UI, and Database frameworks.
 
## ✨ Features
 
- **Multi-Language Support**: Laravel, Bun, Elixir, Java, Kotlin, .NET, Rust, Go, Python, Next.js, Astro, React, Vue, Svelte, Angular, etc.
- **Dynamic Database Selection**: PostgreSQL, MySQL, MariaDB, MongoDB, or Redis.
- **Granular Scaffolding**: Automatically selects the best `compose.yaml` for your project type.
 
---
 
## 📦 Option A: NPM / NPX (Recommended)
 
The easiest way to use the tool without downloading the repository manually.
 
### 💨 Zero-Install (NPX)
 
Run it instantly from any folder:
 
```bash
npx @lancedanielg/envy <PROJECT_NAME> <API_LANG> <UI_LANG> [DB_TYPE]
```
 
### 🌍 Global Install (NPM)
 
Install it permanently on your system:
 
```bash
npm install -g @lancedanielg/envy
envy <PROJECT_NAME> <API_LANG> <UI_LANG> [DB_TYPE]
```
 
---
 
## 🛠 Option B: Manual Installation (GitHub)
 
Best for users who want to modify the templates or prefer a manual setup.
 
1.  **Clone & Enter**:
 
    ```bash
    git clone https://github.com/LanceDanielG/LocalEnvironmentSetUp.git
    cd LocalEnvironmentSetUp
    ```
 
2.  **Install Globally**:
 
    ```bash
    chmod +x install.sh
    sudo ./install.sh
    ```
 
3.  **Usage**:
    You can now run `envy` from any folder.
 
---
 
## 📁 Supported Options
 
| Category           | Options                                                                                                        |
| :----------------- | :------------------------------------------------------------------------------------------------------------- |
| **API / Monolith** | `bun`, `elixir`, `kotlin`, `laravel`, `java`, `dotnet`, `nodejs`, `python`, `django`, `rust`, `golang`, `ruby` |
| **UI**             | `nextjs`, `astro`, `vue`, `react`, `angular`, `svelte`                                                         |
| **Database**       | `postgres`, `mysql`, `mariadb`, `mongo`, `redis`, `none`                                                       |
 
---
 
_Maintained by Dxcode_

