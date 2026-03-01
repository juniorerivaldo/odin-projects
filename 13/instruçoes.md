# Passo a Passo para criar Snake em Odin com Raylib

Baseado no seu estilo de código, aqui está um guia conceitual sem código:

## 1. **Estrutura de Dados Principal**

Você vai precisar de:

- **Snake** (a cobra)
  - Uma lista/array dinâmico de posições (cada segmento da cobra é uma posição no grid)
  - Direção atual de movimento
  - Tamanho do grid (ex: cada célula tem 20x20 pixels)
  
- **Food** (comida)
  - Posição no grid (x, y)
  - Precisa spawnar em posições aleatórias que não colidam com a cobra

- **Game_State** (similar ao que você já tem)
  - Telas: MENU, GAMEPLAY, GAMEOVER
  - Score
  - Velocidade do jogo (pode aumentar conforme come)

## 2. **Sistema de Grid**

Diferente do seu projeto atual (movimento livre), Snake usa **movimento baseado em grid**:

- Defina o tamanho da tela em células (ex: 40x30 células de 20px cada)
- A cobra se move célula por célula, não pixel por pixel
- Use um **timer/intervalo** para controlar quando a cobra se move (ex: a cada 0.1s ela avança uma célula)

## 3. **Lógica de Movimento da Cobra**

A cobra funciona como uma **fila**:
- Adiciona uma nova cabeça na direção do movimento
- Remove a cauda (último segmento)
- Quando come: adiciona cabeça mas NÃO remove a cauda (cresce)

**Direção**: Use um vetor como {1,0}, {-1,0}, {0,1}, {0,-1} para as 4 direções

**Input**: 
- Teclas direcionais ou WASD mudam a direção
- **IMPORTANTE**: Não permitir voltar na direção oposta (ex: se está indo pra direita, não pode ir pra esquerda)

## 4. **Sistema de Colisão**

Você precisa verificar 3 tipos de colisão:

1. **Comida**: Se a cabeça da cobra está na mesma posição da comida
   - Aumenta score
   - Spawna nova comida
   - Cobra cresce (não remove cauda no próximo frame)

2. **Paredes**: Se a cabeça saiu dos limites do grid
   - Game Over

3. **Auto-colisão**: Se a cabeça colidiu com algum segmento do próprio corpo
   - Game Over

## 5. **Fluxo de Update (parecido com seu código)**

```
UPDATE:
- Diminuir timer de movimento
- Se timer <= 0:
  - Calcular nova posição da cabeça baseado na direção
  - Verificar colisões
  - Atualizar array da cobra (adicionar cabeça, remover cauda)
  - Resetar timer
  
- Capturar input de direção (W,A,S,D)
- Verificar condições de spawn de comida
```

## 6. **Renderização**

Você já sabe fazer bem isso:
- Desenhar cada segmento da cobra como retângulos
- Desenhar a comida
- Desenhar UI (score, etc)
- Usar cores diferentes para cabeça vs corpo (opcional)

## 7. **Diferenças do seu Projeto Atual**

| Seu Projeto 12 | Snake |
|----------------|-------|
| Movimento contínuo (dt) | Movimento discreto (grid) |
| Objetos caindo | Cobra crescendo |
| Colisão simples | Colisão consigo mesma |
| Spawn aleatório vertical | Spawn aleatório em grid vazio |

## 8. **Sugestão de Implementação Incremental**

1. Criar grid e desenhar células
2. Criar cobra com 3 segmentos iniciais
3. Fazer ela se mover automaticamente
4. Adicionar controle de direção
5. Adicionar comida e detecção de comer
6. Adicionar crescimento
7. Adicionar colisões (paredes e corpo)
8. Adicionar telas e score (você já domina isso!)

## 9. **Dicas de Implementação**

### Grid Position vs Screen Position
- Mantenha as posições da cobra em coordenadas de grid (ex: {5, 10})
- Converta para pixels na hora de desenhar (ex: grid_x * cell_size)

### Array Dinâmico da Cobra
```
Exemplo conceitual:
snake_body = [{5,10}, {4,10}, {3,10}]  // 3 segmentos
```
- Índice 0 é sempre a cabeça
- Último índice é a cauda

### Timer de Movimento
- Similar ao seu `spawn_timer`
- Controla quando a cobra "pula" para próxima célula
- Pode diminuir para aumentar velocidade conforme score aumenta

### Spawn de Comida
- Gere posição aleatória no grid
- Verifique se não está em cima da cobra
- Se estiver, gere outra posição

## 10. **Conceitos Importantes**

### Grid Movement
Em vez de:
```
position.x += velocity * dt  // movimento fluido
```

Use:
```
grid_position.x += direction.x  // movimento discreto
```

### Queue Behavior (Comportamento de Fila)
A cobra é essencialmente uma fila:
- **Enqueue** (adicionar): Nova cabeça na frente
- **Dequeue** (remover): Cauda no final
- Quando come: Não faz dequeue (cresce)

### Validação de Direção
```
Não permitir:
- Direita → Esquerda
- Esquerda → Direita
- Cima → Baixo
- Baixo → Cima
```

## 11. **Estrutura de Arquivos Sugerida**

Baseado no seu estilo:

```
game_13/
  ├── main.odin          // Loop principal, game states
  └── src/
      ├── snake.odin     // Lógica da cobra
      └── food.odin      // Lógica da comida (opcional)
```

## 12. **Referências Úteis**

- **Conceito de Grid**: Em vez de `rect.x += velocidade * dt`, você usa índices inteiros `grid_pos.x++`
- **Array Dinâmico**: Você já usa no `falling_objects`, vai usar similar para os segmentos
- **Queue Behavior**: A cobra é uma fila - adiciona na frente, remove atrás
- **Grid Collision**: Comparar posições inteiras (x, y) em vez de usar `CheckCollisionRecs`

## 13. **Checklist de Features**

- [ ] Grid system funcionando
- [ ] Cobra renderizando
- [ ] Movimento automático
- [ ] Controle de direção (WASD)
- [ ] Comida spawning
- [ ] Detecção de comer
- [ ] Crescimento da cobra
- [ ] Colisão com paredes
- [ ] Auto-colisão
- [ ] Sistema de score
- [ ] Telas (Menu, Gameplay, Game Over)
- [ ] Aumentar velocidade com score (opcional)

---

## Conclusão

Você já tem boa base! A principal diferença é trocar movimento fluido por movimento em "passos" no grid. O resto é lógica similar ao que já fez. 

**Principais desafios novos:**
1. Sistema de grid
2. Lógica de fila para a cobra
3. Auto-colisão

**O que você já domina:**
1. Game states
2. Renderização
3. Timers
4. Arrays dinâmicos
5. Detecção de colisão básica

Boa sorte! 🐍
