# UI Inventory
Sistema de Inventário versátil e reutilizável criado para a engine GamemMaker

## Como usar?
O sistema é baseado em um constructor `InventoryManager()` intanciado no objeto que conterá o inventário (nesse caso, inicializado no obj_player)

O constructor aceita os seguintes argumentos:
- `name` - O nome a ser exibido no topo do inventário.
- `slots` - A quantidade total de slots para conter os itens.
- `columns` - A quantidade de columas para exibir os itens.
- `[config]` - Uma struct optional que pode ser usada para configurar diversos aspectos do menu, como estilo, tamanhos, sprites de background e controle de animação. Caso o valor não seja passado por essa struct, será usado o valor default dentro do constructor.

```gml
/// Create event
my_inventory = new InventoryManager("Player Inventory", 32, 8, {
  slotWidth: 32,
  slotHeight: 32,
});
```

Após isso, o inventário pode ser renderizado no evento de **Draw GUI** chamando o método `Draw()`

```gml
/// Draw GUI event
var _guiWidth = display_get_gui_width();
var _guiHeight = display_get_gui_height();

// Desenha o inventário centralizado na tela
my_inventory.Draw(_guiWidth * 0.5, _guiHeight * 0.5);
```

O sistema utiliza uma classe chamada `Slot` para armazenar as informações do item em questão, contendo os seguintes valores:
- `itemId` - Uma string única para identificar cada ítem dentro da base de dados.
- `itemCount` - A quantidade de itens contida dentro daquele slot.
- `itemData` - Uma struct contendo tags específicas, para itens do mesmo identificador, permitindo criar ítens com propriedades únicas (ferramentas com durabilidade, armas com modificador de dano, etc)

Itens podem ser adicionados ao inventário usando o método `AddItem()`

```gml
// Adiciona uma espada que recebei 68 de dano
my_inventory.AddItem("itemSword", 1, {damage:68});

// Adiciona 15 madeiras
my_inventory.AddItem("itemWood", 15);
```

Por final, o sistema utiliza uma classe `Item` para armazenar as informações intrínsecas de cada ítem, como nome, sprite, tamanho máximo da pilha, e a opção de fornecer métodos customizados, dispostos da seguinte maneira
- `name` - Nome do ítem a ser exibido.
- `desc` - Curta descrição do ítem ao passar com o mouse por cima.
- `sprite` - Sprite a ser utilizada para representar o ítem no inventário.
- `StackSize` - Quantidade máxima de itens que podem estar presentes em um mesmo slot.
- `[config]` - Uma struct optional que pode ser usada para configurar variáveis e métodos específicos, além de permitir sobreescrever métodos padão.

```gml
/// ItemDatabase

global.itemDatabase = {}
with (global.itemDatabase) {
  // Cria um novo item com o id "itemWood"
  itemWood = new Item("Wood", "Basic material", spr_wood, 64, {
    // A função OnUse() recebe a referência do slot contendo o ítem
    OnUse : function(_slot) {
      // Ao ser executado, o ítem exibe uma mensagem no console
      show_debug_message($"Player used a piece of wood!");
      // E consome um ítem da contage do slot
      _slot.SetCount(_slot.GetCount()-1);
    }
  })
}
```

A abstração em diferentes classes para diferentes aspectos do sistema permite fácil expansão e reutilização para diferentes jogos, com propriedades lógicas e visuais únicas e customizáveis.
