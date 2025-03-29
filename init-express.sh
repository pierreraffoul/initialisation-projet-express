#!/bin/bash

# Création du dossier du projet
mkdir -p $1
cd $1

# Initialisation du projet Node.js
npm init -y

# Installation des dépendances
npm install express typescript @types/express @types/node ts-node nodemon morgan @types/morgan

# Création du fichier tsconfig.json
cat > tsconfig.json << EOL
{
  "compilerOptions": {
    "target": "es6",
    "module": "commonjs",
    "outDir": "./dist",
    "rootDir": "./src",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules"]
}
EOL

# Création du fichier .gitignore
cat > .gitignore << EOL
node_modules/
dist/
.env
.DS_Store
EOL

# Création du dossier src et du fichier principal
mkdir -p src
cat > src/index.ts << EOL
import express, { Request, Response } from 'express';
import morgan from 'morgan';

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(morgan('dev'));

// Route de bienvenue
app.get('/', (req: Request, res: Response) => {
  res.json({ message: 'Bienvenue sur l\'API Express avec TypeScript!' });
});

app.listen(port, () => {
  console.log(\`Serveur démarré sur le port \${port}\`);
  console.log('Visitez http://localhost:' + port);
});
EOL

# Mise à jour du package.json pour les scripts
npm pkg set scripts.start="node dist/index.js"
npm pkg set scripts.dev="nodemon src/index.ts"
npm pkg set scripts.build="tsc"

# Création d'un README.md
cat > README.md << EOL
# Projet Express TypeScript

Ce projet est une API REST construite avec Express et TypeScript.

## Installation

\`\`\`bash
npm install
\`\`\`

## Scripts disponibles

- \`npm run dev\`: Lance le serveur en mode développement avec nodemon
- \`npm run build\`: Compile le code TypeScript
- \`npm start\`: Lance le serveur en production

## Structure du projet

- \`src/\`: Contient le code source TypeScript
- \`dist/\`: Contient le code JavaScript compilé
EOL

echo "Projet Express avec TypeScript initialisé avec succès!"
echo "Pour commencer, exécutez:"
echo "cd $1"
echo "npm run dev" 
