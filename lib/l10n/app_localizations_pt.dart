// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonOk => 'OK';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonRename => 'Renomear';

  @override
  String get commonCopy => 'Copiar';

  @override
  String get commonCut => 'Recortar';

  @override
  String get commonPaste => 'Colar';

  @override
  String get commonUndo => 'Desfazer';

  @override
  String get commonRedo => 'Refazer';

  @override
  String get commonSelectAll => 'Selecionar Tudo';

  @override
  String get languageSettingsTitle => 'Região e Idioma';

  @override
  String get languageSettingsDisplayLanguage => 'Idioma de Exibição';

  @override
  String get languageSettingsDescription =>
      'O idioma dos menus, das exibições e das mensagens do BaoCode. As alterações são aplicadas imediatamente.';

  @override
  String languageSettingsFollowSystemCurrent(String language) {
    return 'Seguir o Sistema ($language)';
  }

  @override
  String languageSettingsDisplayLanguageLabel(String name) {
    return 'Idioma de Exibição: $name';
  }

  @override
  String get cmdCategoryFile => 'Arquivo';

  @override
  String get cmdCategoryView => 'Exibir';

  @override
  String get cmdCategoryTerminal => 'Terminal';

  @override
  String get cmdCategoryGo => 'Ir';

  @override
  String get cmdCategoryPreferences => 'Preferências';

  @override
  String get cmdCategoryDeveloper => 'Desenvolvedor';

  @override
  String get cmdCategoryEditor => 'Editor';

  @override
  String get cmdCategoryHelp => 'Ajuda';

  @override
  String get cmdCategoryList => 'Lista';

  @override
  String get composerSetMode => 'Definir Modo';

  @override
  String get composerPickModel => 'Escolher Modelo';

  @override
  String get interactionHintChoose => '1-9 para escolher';

  @override
  String interactionHintContinue(String keybinding) {
    return '$keybinding para continuar';
  }

  @override
  String interactionHintBack(String keybinding) {
    return '$keybinding para voltar';
  }

  @override
  String interactionHintSkip(String keybinding) {
    return '$keybinding para pular';
  }

  @override
  String get cmdCategoryChat => 'Chat';

  @override
  String get cmdCategoryTasks => 'Tarefas';

  @override
  String get cmdChatNewAgent => 'Novo Chat';

  @override
  String get cmdChatClosePane => 'Fechar Painel';

  @override
  String get cmdChatCloseTab => 'Fechar Chat';

  @override
  String get cmdChatNextAgent => 'Abrir Próximo Agente';

  @override
  String get cmdChatPreviousAgent => 'Abrir Agente Anterior';

  @override
  String cmdChatOpenAgentAtIndex(int index) {
    return 'Abrir Agente no Índice $index';
  }

  @override
  String cmdChatFocusPane(int index) {
    return 'Focar no Painel $index';
  }

  @override
  String get cmdChatFocusNextPane => 'Focar no Próximo Painel';

  @override
  String get cmdChatFocusPreviousPane => 'Focar no Painel Anterior';

  @override
  String get cmdChatSearch => 'Pesquisar';

  @override
  String get cmdChatSearchAgents => 'Pesquisar Agentes';

  @override
  String get cmdChatOpenIde => 'Abrir no Fast Ide';

  @override
  String get cmdChatFocusInput => 'Focar na Entrada do Chat';

  @override
  String get cmdChatFocusList => 'Focar na Lista de Chats';

  @override
  String get cmdChatFind => 'Localizar no Chat';

  @override
  String get cmdChatCancel => 'Cancelar';

  @override
  String get cmdChatAcceptTool => 'Aceitar';

  @override
  String get cmdChatSkipTool => 'Pular';

  @override
  String get cmdChatToggleContextPanel => 'Alternar Painel de Contexto';

  @override
  String get cmdChatRenameAgent => 'Renomear Agente';

  @override
  String get cmdChatCloseSubagent => 'Voltar do Subagente';

  @override
  String get cmdChatSubmit => 'Enviar';

  @override
  String get cmdChatCancelEdit => 'Cancelar Edição';

  @override
  String get cmdChatShowPreviousPrompt => 'Mostrar Prompt Anterior';

  @override
  String get cmdChatShowNextPrompt => 'Mostrar Próximo Prompt';

  @override
  String get cmdChatAcceptPromptSuggestion => 'Aceitar Prompt Sugerido';

  @override
  String get cmdChatOpenModePicker => 'Abrir Seletor de Modo';

  @override
  String get cmdChatNextMode => 'Alternar para o Próximo Modo';

  @override
  String get cmdChatOpenModelPicker => 'Abrir Seletor de Modelo';

  @override
  String get cmdChatAttachContext => 'Adicionar Contexto…';

  @override
  String get cmdChatPasteRaw => 'Colar como Texto Sem Formatação';

  @override
  String get cmdChatSelectNextSuggestion => 'Selecionar Próxima Sugestão';

  @override
  String get cmdChatSelectPrevSuggestion => 'Selecionar Sugestão Anterior';

  @override
  String get cmdChatAcceptSelectedSuggestion => 'Aceitar Sugestão Selecionada';

  @override
  String get cmdChatHideSuggestWidget => 'Ocultar Sugestões';

  @override
  String get cmdChatInteractionFocusNext => 'Focar na Próxima Opção';

  @override
  String get cmdChatInteractionFocusPrevious => 'Focar na Opção Anterior';

  @override
  String get cmdChatInteractionBack => 'Voltar à Pergunta Anterior';

  @override
  String get cmdChatInteractionToggle => 'Alternar Opção';

  @override
  String get cmdChatInteractionAccept => 'Continuar';

  @override
  String get cmdChatInteractionDismiss => 'Dispensar';

  @override
  String get cmdOpenFilePreserveFocus => 'Abrir Arquivo, Mantendo o Foco';

  @override
  String ideSearchProject(String name) {
    return 'Pesquisar $name';
  }

  @override
  String get idePanelProblems => 'Problemas';

  @override
  String get idePanelReferences => 'Referências';

  @override
  String get idePanelTerminal => 'Terminal';

  @override
  String get cmdScmFocus => 'Focar na Exibição de Alterações';

  @override
  String get cmdScmAcceptInput => 'Aceitar Entrada';

  @override
  String get cmdScmClearValidation => 'Limpar Validação';

  @override
  String get cmdGitCheckout => 'Fazer Checkout para...';

  @override
  String get cmdScmClearInput => 'Limpar Entrada';

  @override
  String get cmdCategoryGit => 'Git';

  @override
  String get cmdProblemsFocus =>
      'Focar em Problemas (Erros, Avisos, Informações)';

  @override
  String get cmdProblemsOpen => 'Abrir';

  @override
  String get cmdProblemsCopyMessage => 'Copiar Mensagem';

  @override
  String get cmdReferencesNext => 'Ir para a Próxima Referência';

  @override
  String get cmdReferencesPrevious => 'Ir para a Referência Anterior';

  @override
  String get cmdCategoryReferences => 'Referências';

  @override
  String get cmdTerminalFocusFind => 'Focar em Localizar';

  @override
  String get cmdTerminalHideFind => 'Ocultar Localizar';

  @override
  String get cmdTerminalToggleFindRegex => 'Alternar Localizar Usando Regex';

  @override
  String get cmdTerminalToggleFindWholeWord =>
      'Alternar Localizar Usando Palavra Inteira';

  @override
  String get cmdTerminalToggleFindCaseSensitive =>
      'Alternar Localizar Diferenciando Maiúsculas e Minúsculas';

  @override
  String get cmdTerminalSearchWorkspace => 'Pesquisar no Workspace';

  @override
  String get cmdTerminalCopySelection => 'Copiar Seleção';

  @override
  String get cmdTerminalCopyAndClearSelection => 'Copiar e Limpar Seleção';

  @override
  String get cmdTerminalPaste => 'Colar no Terminal Ativo';

  @override
  String get cmdTerminalPasteSelection => 'Colar Seleção no Terminal Ativo';

  @override
  String get cmdTerminalClearSelection => 'Limpar Seleção';

  @override
  String get cmdTerminalScrollDown => 'Rolar para Baixo (Linha)';

  @override
  String get cmdTerminalScrollDownPage => 'Rolar para Baixo (Página)';

  @override
  String get cmdTerminalScrollToBottom => 'Rolar até o Final';

  @override
  String get cmdTerminalScrollUp => 'Rolar para Cima (Linha)';

  @override
  String get cmdTerminalScrollUpPage => 'Rolar para Cima (Página)';

  @override
  String get cmdTerminalScrollToTop => 'Rolar até o Topo';

  @override
  String get cmdTerminalSendSequence => 'Enviar Sequência';

  @override
  String get cmdTerminalKillAll => 'Encerrar Todos os Terminais';

  @override
  String get cmdFindInFiles => 'Localizar nos Arquivos';

  @override
  String get cmdReplaceInFiles => 'Substituir nos Arquivos';

  @override
  String get cmdFocusNextSearchResult =>
      'Focar no Próximo Resultado da Pesquisa';

  @override
  String get cmdFocusPreviousSearchResult =>
      'Focar no Resultado da Pesquisa Anterior';

  @override
  String get cmdToggleSearchCaseSensitive =>
      'Alternar Diferenciação de Maiúsculas e Minúsculas';

  @override
  String get cmdToggleSearchWholeWord => 'Alternar Palavra Inteira';

  @override
  String get cmdToggleSearchRegex => 'Alternar Regex';

  @override
  String get cmdToggleSearchPreserveCase =>
      'Alternar Preservar Maiúsculas e Minúsculas';

  @override
  String get cmdSearchFocusNextInput => 'Focar na Próxima Entrada';

  @override
  String get cmdSearchFocusPreviousInput => 'Focar na Entrada Anterior';

  @override
  String get cmdFocusSearchFromResults =>
      'Focar na Pesquisa a partir dos Resultados';

  @override
  String get cmdSearchFocusList => 'Focar na Lista';

  @override
  String get cmdSearchOpenMatch => 'Abrir Correspondência';

  @override
  String get cmdCloseReplaceWidget => 'Fechar Widget de Substituição';

  @override
  String get cmdCancelSearch => 'Cancelar Pesquisa';

  @override
  String get cmdToggleQueryDetails => 'Alternar Detalhes da Consulta';

  @override
  String get cmdCategoryQuickInput => 'Entrada Rápida';

  @override
  String get wbQuickEditors => 'Digite o nome de um editor para abri-lo.';

  @override
  String get quickOpenNoMatchingEditors => 'Nenhum editor correspondente';

  @override
  String get cmdQuickInputFocusNext => 'Focar no Próximo';

  @override
  String get cmdQuickInputFocusPrevious => 'Focar no Anterior';

  @override
  String get cmdQuickInputFocusNextPage => 'Focar na Próxima Página';

  @override
  String get cmdQuickInputFocusPreviousPage => 'Focar na Página Anterior';

  @override
  String get cmdQuickInputAccept => 'Aceitar';

  @override
  String get cmdQuickInputAcceptInBackground => 'Aceitar em Segundo Plano';

  @override
  String get cmdQuickInputHide => 'Ocultar';

  @override
  String get cmdCloseQuickOpen => 'Fechar Abertura Rápida';

  @override
  String get cmdAcceptSelectedQuickOpenItem =>
      'Aceitar Item Selecionado da Abertura Rápida';

  @override
  String get cmdFocusQuickOpen => 'Focar na Abertura Rápida';

  @override
  String get cmdQuickOpenSelectNext => 'Selecionar Próximo na Abertura Rápida';

  @override
  String get cmdQuickOpenSelectPrevious =>
      'Selecionar Anterior na Abertura Rápida';

  @override
  String get cmdQuickOpenNavigateNext =>
      'Navegar para o Próximo na Abertura Rápida';

  @override
  String get cmdQuickOpenNavigatePrevious =>
      'Navegar para o Anterior na Abertura Rápida';

  @override
  String get cmdQuickOpenNavigateNextInFilePicker =>
      'Navegar para o Próximo no Seletor de Arquivos';

  @override
  String get cmdQuickOpenNavigatePreviousInFilePicker =>
      'Navegar para o Anterior no Seletor de Arquivos';

  @override
  String get cmdQuickOpenNavigateNextInEditorPicker =>
      'Navegar para o Próximo no Seletor de Editores';

  @override
  String get cmdQuickOpenNavigatePreviousInEditorPicker =>
      'Navegar para o Anterior no Seletor de Editores';

  @override
  String get cmdQuickOpenPreviousEditor =>
      'Abrir Rapidamente o Editor Anterior';

  @override
  String get cmdShowAllEditors => 'Mostrar Todos os Editores por Aparência';

  @override
  String get cmdShowEditorsInActiveGroup =>
      'Mostrar Editores no Grupo Ativo por Mais Recentemente Usados';

  @override
  String get cmdShowAllEditorsByMostRecentlyUsed =>
      'Mostrar Todos os Editores por Mais Recentemente Usados';

  @override
  String get cmdQuickOpenPreviousRecentlyUsedEditor =>
      'Abrir Rapidamente o Editor Usado Anteriormente';

  @override
  String get cmdQuickOpenLeastRecentlyUsedEditor =>
      'Abrir Rapidamente o Editor Menos Recentemente Usado';

  @override
  String get cmdQuickOpenPreviousRecentlyUsedEditorInGroup =>
      'Abrir Rapidamente o Editor Usado Anteriormente no Grupo';

  @override
  String get cmdQuickOpenLeastRecentlyUsedEditorInGroup =>
      'Abrir Rapidamente o Editor Menos Recentemente Usado no Grupo';

  @override
  String get cmdOpenPreviousEditorFromHistory =>
      'Abrir Rapidamente o Editor Anterior do Histórico';

  @override
  String get cmdOpenNextRecentlyUsedEditor =>
      'Abrir Próximo Editor Usado Recentemente';

  @override
  String get cmdOpenPreviousRecentlyUsedEditor =>
      'Abrir Editor Usado Recentemente Anterior';

  @override
  String get cmdOpenNextRecentlyUsedEditorInGroup =>
      'Abrir Próximo Editor Usado Recentemente no Grupo';

  @override
  String get cmdOpenPreviousRecentlyUsedEditorInGroup =>
      'Abrir Editor Usado Recentemente Anterior no Grupo';

  @override
  String get cmdNextEditorInGroup => 'Abrir Próximo Editor no Grupo';

  @override
  String get cmdPreviousEditorInGroup => 'Abrir Editor Anterior no Grupo';

  @override
  String get cmdFirstEditorInGroup => 'Abrir Primeiro Editor no Grupo';

  @override
  String get cmdCloseEditorsInGroup => 'Fechar Todos os Editores no Grupo';

  @override
  String get cmdCloseEditorsToTheLeft => 'Fechar Editores à Esquerda no Grupo';

  @override
  String get cmdNavigateToLastEditLocation =>
      'Ir para o Último Local de Edição';

  @override
  String get cmdNavigateLast => 'Ir para o Anterior';

  @override
  String get cmdOpenUserSettings => 'Abrir Configurações do Usuário';

  @override
  String get cmdToggleMaximizedPanel => 'Alternar Painel Maximizado';

  @override
  String get cmdFocusPanel => 'Focar no Painel';

  @override
  String get cmdClosePanel => 'Ocultar Painel';

  @override
  String get cmdFocusSideBar => 'Focar na Barra Lateral Primária';

  @override
  String get cmdCloseSidebar => 'Ocultar Barra Lateral Primária';

  @override
  String get cmdCloseChat => 'Ocultar Chat';

  @override
  String get cmdFocusActiveEditorGroup => 'Focar no Grupo de Editores Ativo';

  @override
  String get cmdFocusFirstEditorGroup => 'Focar no Primeiro Grupo de Editores';

  @override
  String get cmdFocusLastEditorGroup => 'Focar no Último Grupo de Editores';

  @override
  String get cmdListFocusDown => 'Focar para Baixo';

  @override
  String get cmdListFocusUp => 'Focar para Cima';

  @override
  String get cmdListFocusPageDown => 'Focar Página para Baixo';

  @override
  String get cmdListFocusPageUp => 'Focar Página para Cima';

  @override
  String get cmdListFocusFirst => 'Focar no Primeiro';

  @override
  String get cmdListFocusLast => 'Focar no Último';

  @override
  String get cmdListExpand => 'Expandir';

  @override
  String get cmdListCollapse => 'Recolher';

  @override
  String get cmdListSelect => 'Selecionar';

  @override
  String get cmdListToggleExpand => 'Alternar Expansão';

  @override
  String get cmdListExpandSelectionDown => 'Expandir Seleção para Baixo';

  @override
  String get cmdListExpandSelectionUp => 'Expandir Seleção para Cima';

  @override
  String get cmdListSelectAll => 'Selecionar Tudo';

  @override
  String get cmdListClear => 'Limpar Seleção';

  @override
  String get cmdEditorCursorLeft => 'Cursor para a Esquerda';

  @override
  String get cmdEditorCursorLeftSelect => 'Selecionar Cursor para a Esquerda';

  @override
  String get cmdEditorCursorRight => 'Cursor para a Direita';

  @override
  String get cmdEditorCursorRightSelect => 'Selecionar Cursor para a Direita';

  @override
  String get cmdEditorCursorUp => 'Cursor para Cima';

  @override
  String get cmdEditorCursorUpSelect => 'Selecionar Cursor para Cima';

  @override
  String get cmdEditorCursorDown => 'Cursor para Baixo';

  @override
  String get cmdEditorCursorDownSelect => 'Selecionar Cursor para Baixo';

  @override
  String get cmdEditorCursorPageUp => 'Cursor Página para Cima';

  @override
  String get cmdEditorCursorPageUpSelect =>
      'Selecionar Cursor Página para Cima';

  @override
  String get cmdEditorCursorPageDown => 'Cursor Página para Baixo';

  @override
  String get cmdEditorCursorPageDownSelect =>
      'Selecionar Cursor Página para Baixo';

  @override
  String get cmdEditorCursorHome => 'Cursor para Home';

  @override
  String get cmdEditorCursorHomeSelect => 'Selecionar Cursor até Home';

  @override
  String get cmdEditorCursorEnd => 'Cursor para End';

  @override
  String get cmdEditorCursorEndSelect => 'Selecionar Cursor até End';

  @override
  String get cmdEditorCursorLineStart => 'Cursor para o Início da Linha';

  @override
  String get cmdEditorCursorLineStartSelect =>
      'Selecionar Cursor até o Início da Linha';

  @override
  String get cmdEditorCursorLineEnd => 'Cursor para o Fim da Linha';

  @override
  String get cmdEditorCursorLineEndSelect =>
      'Selecionar Cursor até o Fim da Linha';

  @override
  String get cmdEditorCursorTop => 'Cursor para o Topo';

  @override
  String get cmdEditorCursorTopSelect => 'Selecionar Cursor até o Topo';

  @override
  String get cmdEditorCursorBottom => 'Cursor para o Final';

  @override
  String get cmdEditorCursorBottomSelect => 'Selecionar Cursor até o Final';

  @override
  String get cmdEditorCursorColumnSelectLeft =>
      'Seleção de Coluna para a Esquerda';

  @override
  String get cmdEditorCursorColumnSelectRight =>
      'Seleção de Coluna para a Direita';

  @override
  String get cmdEditorCursorColumnSelectUp => 'Seleção de Coluna para Cima';

  @override
  String get cmdEditorCursorColumnSelectDown => 'Seleção de Coluna para Baixo';

  @override
  String get cmdEditorCursorColumnSelectPageUp =>
      'Seleção de Coluna Página para Cima';

  @override
  String get cmdEditorCursorColumnSelectPageDown =>
      'Seleção de Coluna Página para Baixo';

  @override
  String get cmdEditorScrollLineUp => 'Rolar Linha para Cima';

  @override
  String get cmdEditorScrollLineDown => 'Rolar Linha para Baixo';

  @override
  String get cmdEditorScrollPageUp => 'Rolar Página para Cima';

  @override
  String get cmdEditorScrollPageDown => 'Rolar Página para Baixo';

  @override
  String get cmdEditorCancelSelection => 'Cancelar Seleção';

  @override
  String get cmdEditorLineBreakInsert => 'Inserir Quebra de Linha';

  @override
  String get cmdEditorTab => 'Tab';

  @override
  String get cmdEditorOutdent => 'Remover Recuo';

  @override
  String get cmdEditorDeleteLeft => 'Excluir à Esquerda';

  @override
  String get cmdEditorDeleteRight => 'Excluir à Direita';

  @override
  String get cmdEditorCursorWordLeft => 'Cursor Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordLeftSelect =>
      'Selecionar Cursor Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordStartLeft =>
      'Cursor Início da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordStartLeftSelect =>
      'Selecionar Cursor Início da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordEndLeft => 'Cursor Fim da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordEndLeftSelect =>
      'Selecionar Cursor Fim da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordRight => 'Cursor Palavra à Direita';

  @override
  String get cmdEditorCursorWordRightSelect =>
      'Selecionar Cursor Palavra à Direita';

  @override
  String get cmdEditorCursorWordStartRight =>
      'Cursor Início da Palavra à Direita';

  @override
  String get cmdEditorCursorWordStartRightSelect =>
      'Selecionar Cursor Início da Palavra à Direita';

  @override
  String get cmdEditorCursorWordEndRight => 'Cursor Fim da Palavra à Direita';

  @override
  String get cmdEditorCursorWordEndRightSelect =>
      'Selecionar Cursor Fim da Palavra à Direita';

  @override
  String get cmdEditorCursorWordPartLeft =>
      'Cursor Parte da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordPartLeftSelect =>
      'Selecionar Cursor Parte da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordPartStartLeft =>
      'Cursor Início da Parte da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordPartStartLeftSelect =>
      'Selecionar Cursor Início da Parte da Palavra à Esquerda';

  @override
  String get cmdEditorCursorWordPartRight =>
      'Cursor Parte da Palavra à Direita';

  @override
  String get cmdEditorCursorWordPartRightSelect =>
      'Selecionar Cursor Parte da Palavra à Direita';

  @override
  String get cmdEditorDeleteWordLeft => 'Excluir Palavra à Esquerda';

  @override
  String get cmdEditorDeleteWordRight => 'Excluir Palavra à Direita';

  @override
  String get cmdEditorDeleteWordStartLeft =>
      'Excluir Início da Palavra à Esquerda';

  @override
  String get cmdEditorDeleteWordEndLeft => 'Excluir Fim da Palavra à Esquerda';

  @override
  String get cmdEditorDeleteWordStartRight =>
      'Excluir Início da Palavra à Direita';

  @override
  String get cmdEditorDeleteWordEndRight => 'Excluir Fim da Palavra à Direita';

  @override
  String get cmdEditorDeleteWordPartLeft =>
      'Excluir Parte da Palavra à Esquerda';

  @override
  String get cmdEditorDeleteWordPartRight =>
      'Excluir Parte da Palavra à Direita';

  @override
  String get cmdEditorSmartSelectGrow => 'Expandir Seleção';

  @override
  String get cmdEditorFormat => 'Formatar Seleção ou Documento';

  @override
  String get cmdEditorJumpToNextSnippetPlaceholder =>
      'Ir para o Próximo Espaço Reservado do Snippet';

  @override
  String get cmdEditorJumpToPrevSnippetPlaceholder =>
      'Ir para o Espaço Reservado Anterior do Snippet';

  @override
  String get cmdEditorLeaveSnippet => 'Sair do Snippet';

  @override
  String get cmdEditorLeaveEditorMessage => 'Dispensar Mensagem';

  @override
  String get cmdEditorNextMatchFindAction => 'Localizar Próxima';

  @override
  String get cmdEditorPreviousMatchFindAction => 'Localizar Anterior';

  @override
  String get cmdEditorNextSelectionMatchFindAction =>
      'Localizar Próxima Seleção';

  @override
  String get cmdEditorPreviousSelectionMatchFindAction =>
      'Localizar Seleção Anterior';

  @override
  String get cmdEditorFindWithSelection => 'Localizar com Seleção';

  @override
  String get cmdEditorCloseFindWidget => 'Fechar Widget de Localização';

  @override
  String get cmdEditorToggleFindCaseSensitive =>
      'Alternar Diferenciar Maiúsculas e Minúsculas';

  @override
  String get cmdEditorToggleFindWholeWord =>
      'Alternar Coincidir Palavra Inteira';

  @override
  String get cmdEditorToggleFindRegex => 'Alternar Usar Expressão Regular';

  @override
  String get cmdEditorReplaceOne => 'Substituir Um';

  @override
  String get cmdEditorReplaceAll => 'Substituir Tudo';

  @override
  String get cmdEditorSelectAllMatches =>
      'Selecionar Todas as Correspondências';

  @override
  String get cmdEditorMarkerNext =>
      'Ir para o Próximo Problema (Erro, Aviso, Informação)';

  @override
  String get cmdEditorMarkerPrev =>
      'Ir para o Problema Anterior (Erro, Aviso, Informação)';

  @override
  String get cmdEditorShowContextMenu => 'Mostrar Menu de Contexto do Editor';

  @override
  String get cmdEditorAcceptSelectedSuggestion =>
      'Aceitar Sugestão Selecionada';

  @override
  String get cmdEditorAcceptAlternativeSelectedSuggestion =>
      'Aceitar Sugestão Selecionada (Alternativa)';

  @override
  String get cmdEditorHideSuggestWidget => 'Ocultar Widget de Sugestões';

  @override
  String get cmdEditorSelectNextSuggestion => 'Selecionar Próxima Sugestão';

  @override
  String get cmdEditorSelectPrevSuggestion => 'Selecionar Sugestão Anterior';

  @override
  String get cmdEditorSelectNextPageSuggestion =>
      'Selecionar Próxima Página de Sugestões';

  @override
  String get cmdEditorSelectPrevPageSuggestion =>
      'Selecionar Página Anterior de Sugestões';

  @override
  String get cmdEditorToggleSuggestionDetails =>
      'Alternar Detalhes da Sugestão';

  @override
  String get cmdEditorCloseParameterHints => 'Fechar Dicas de Parâmetro';

  @override
  String get cmdEditorShowPrevParameterHint =>
      'Mostrar Dica de Parâmetro Anterior';

  @override
  String get cmdEditorShowNextParameterHint =>
      'Mostrar Próxima Dica de Parâmetro';

  @override
  String get cmdEditorAcceptRenameInput => 'Aceitar Renomeação';

  @override
  String get cmdEditorCancelRenameInput => 'Cancelar Renomeação';

  @override
  String get cmdEditorJoinLines => 'Unir Linhas';

  @override
  String get cmdEditorDuplicateSelection => 'Duplicar Seleção';

  @override
  String get cmdEditorInsertCursorAtEndOfEachLineSelected =>
      'Adicionar Cursores ao Final das Linhas';

  @override
  String get cmdEditorSmartSelectExpand => 'Expandir Seleção';

  @override
  String get cmdEditorSmartSelectShrink => 'Reduzir Seleção';

  @override
  String get cmdEditorWordHighlightNext =>
      'Ir para o Próximo Destaque de Símbolo';

  @override
  String get cmdEditorWordHighlightPrev =>
      'Ir para o Destaque de Símbolo Anterior';

  @override
  String get cmdEditorFold => 'Dobrar';

  @override
  String get cmdEditorUnfold => 'Desdobrar';

  @override
  String get cmdEditorToggleFold => 'Alternar Dobra';

  @override
  String get cmdEditorFoldRecursively => 'Dobrar Recursivamente';

  @override
  String get cmdEditorUnfoldRecursively => 'Desdobrar Recursivamente';

  @override
  String get cmdEditorToggleFoldRecursively => 'Alternar Dobra Recursivamente';

  @override
  String get cmdEditorFoldAll => 'Dobrar Tudo';

  @override
  String get cmdEditorUnfoldAll => 'Desdobrar Tudo';

  @override
  String get cmdEditorFoldAllBlockComments =>
      'Dobrar Todos os Comentários de Bloco';

  @override
  String get cmdEditorFoldAllMarkerRegions => 'Dobrar Todas as Regiões';

  @override
  String get cmdEditorUnfoldAllMarkerRegions => 'Desdobrar Todas as Regiões';

  @override
  String get cmdEditorFoldAllExcept => 'Dobrar Tudo Exceto os Selecionados';

  @override
  String get cmdEditorUnfoldAllExcept =>
      'Desdobrar Tudo Exceto os Selecionados';

  @override
  String get cmdEditorGoToDeclaration => 'Ir para Declaração';

  @override
  String get cmdEditorReferenceSearchTrigger => 'Espiar Referências';

  @override
  String cmdEditorFoldLevel(int level) {
    return 'Dobrar Nível $level';
  }

  @override
  String get cmdShowAllCommands => 'Mostrar Todos os Comandos';

  @override
  String get cmdQuickOpen => 'Ir para o Arquivo…';

  @override
  String get cmdGotoLine => 'Ir para Linha/Coluna…';

  @override
  String get cmdChangeEol => 'Alterar Sequência de Fim de Linha';

  @override
  String get cmdFind => 'Localizar';

  @override
  String get cmdReplace => 'Substituir';

  @override
  String get cmdSave => 'Salvar';

  @override
  String get cmdSaveAll => 'Salvar Tudo';

  @override
  String get cmdToggleAutoSave => 'Alternar Salvamento Automático';

  @override
  String get cmdCloseEditor => 'Fechar Editor';

  @override
  String get cmdCloseOtherEditors => 'Fechar Outros Editores';

  @override
  String get cmdCloseEditorsToTheRight => 'Fechar Editores à Direita';

  @override
  String get cmdCloseSavedEditors => 'Fechar Editores Salvos';

  @override
  String get cmdCloseAllEditors => 'Fechar Todos os Editores';

  @override
  String get cmdReopenClosedEditor => 'Reabrir Editor Fechado';

  @override
  String get cmdNextEditor => 'Abrir Próximo Editor';

  @override
  String get cmdPreviousEditor => 'Abrir Editor Anterior';

  @override
  String cmdOpenEditorAtIndex(int index) {
    return 'Abrir Editor no Índice $index';
  }

  @override
  String get cmdToggleSidebar =>
      'Alternar Visibilidade da Barra Lateral Primária';

  @override
  String get cmdToggleChat => 'Alternar Chat';

  @override
  String get cmdToggleFullScreen => 'Alternar Tela Inteira';

  @override
  String get cmdZoomIn => 'Ampliar';

  @override
  String get cmdZoomOut => 'Reduzir';

  @override
  String get cmdZoomReset => 'Redefinir Zoom';

  @override
  String get cmdToggleWordWrap => 'Alternar Quebra de Linha';

  @override
  String get menuWordWrap => 'Quebra de Linha';

  @override
  String get cmdTogglePanel => 'Alternar Visibilidade do Painel';

  @override
  String get cmdToggleTerminal => 'Alternar Terminal';

  @override
  String get cmdNewTerminal => 'Criar Novo Terminal';

  @override
  String get cmdKillTerminal => 'Encerrar a Instância de Terminal Ativa';

  @override
  String get cmdRenameTerminal => 'Renomear...';

  @override
  String get cmdFocusNextTerminal => 'Focar no Próximo Grupo de Terminais';

  @override
  String get cmdFocusPreviousTerminal => 'Focar no Grupo de Terminais Anterior';

  @override
  String get cmdFocusTerminal => 'Focar no Terminal';

  @override
  String get cmdRunTask => 'Executar Tarefa';

  @override
  String get cmdRunBuildTask => 'Executar Tarefa de Build';

  @override
  String get cmdRunTestTask => 'Executar Tarefa de Teste';

  @override
  String get cmdRerunTask => 'Executar Novamente a Última Tarefa';

  @override
  String get cmdRestartTask => 'Reiniciar Tarefa em Execução';

  @override
  String get cmdTerminateTask => 'Encerrar Tarefa';

  @override
  String get cmdShowTaskLog => 'Mostrar Log da Tarefa';

  @override
  String get cmdConfigureTask => 'Configurar Tarefa';

  @override
  String get cmdShowExplorer => 'Mostrar Explorador';

  @override
  String get cmdShowSearch => 'Mostrar Pesquisa';

  @override
  String get cmdShowSourceControl => 'Mostrar Controle de Código-Fonte';

  @override
  String get cmdShowExtensions => 'Mostrar Extensões';

  @override
  String get cmdRevealActiveFileInExplorer =>
      'Revelar Arquivo Ativo na Exibição do Explorador';

  @override
  String get cmdRefreshExplorer => 'Atualizar Explorador';

  @override
  String get cmdCollapseExplorerFolders => 'Recolher Pastas no Explorador';

  @override
  String get cmdCopyPathOfActiveFile => 'Copiar Caminho do Arquivo Ativo';

  @override
  String get cmdCopyRelativePathOfActiveFile =>
      'Copiar Caminho Relativo do Arquivo Ativo';

  @override
  String get cmdGotoSymbol => 'Ir para o Símbolo no Editor...';

  @override
  String get cmdToggleProblems => 'Alternar Problemas';

  @override
  String get cmdShowOutline => 'Mostrar Estrutura de Tópicos';

  @override
  String get cmdNextProblemInFiles =>
      'Ir para o Próximo Problema nos Arquivos (Erro, Aviso, Informação)';

  @override
  String get cmdPreviousProblemInFiles =>
      'Ir para o Problema Anterior nos Arquivos (Erro, Aviso, Informação)';

  @override
  String get cmdGoBack => 'Voltar';

  @override
  String get cmdGoForward => 'Avançar';

  @override
  String get cmdColorTheme => 'Tema de Cores';

  @override
  String get cmdTurnOnFormatOnSave => 'Ativar Formatar ao Salvar';

  @override
  String get cmdTurnOffFormatOnSave => 'Desativar Formatar ao Salvar';

  @override
  String get cmdRetryLanguageServices =>
      'Tentar Novamente os Serviços de Linguagem';

  @override
  String get cmdBackToChat => 'Voltar ao Chat';

  @override
  String get cmdOpenSettings => 'Abrir Configurações';

  @override
  String get cmdOpenKeyboardShortcuts => 'Abrir Atalhos de Teclado';

  @override
  String get cmdOpenLspSettings =>
      'Abrir Configurações do Servidor de Linguagem (JSON)';

  @override
  String get cmdJumpToBracket => 'Ir para o Colchete';

  @override
  String get cmdUndo => 'Desfazer';

  @override
  String get cmdRedo => 'Refazer';

  @override
  String get cmdCut => 'Recortar';

  @override
  String get cmdCopy => 'Copiar';

  @override
  String get cmdPaste => 'Colar';

  @override
  String get cmdSelectAll => 'Selecionar Tudo';

  @override
  String get cmdToggleLineComment => 'Alternar Comentário de Linha';

  @override
  String get cmdToggleBlockComment => 'Alternar Comentário de Bloco';

  @override
  String get cmdMoveLineUp => 'Mover Linha para Cima';

  @override
  String get cmdMoveLineDown => 'Mover Linha para Baixo';

  @override
  String get cmdCopyLineUp => 'Copiar Linha para Cima';

  @override
  String get cmdCopyLineDown => 'Copiar Linha para Baixo';

  @override
  String get cmdDeleteLine => 'Excluir Linha';

  @override
  String get cmdInsertLineBelow => 'Inserir Linha Abaixo';

  @override
  String get cmdInsertLineAbove => 'Inserir Linha Acima';

  @override
  String get cmdIndentLine => 'Recuar Linha';

  @override
  String get cmdOutdentLine => 'Remover Recuo da Linha';

  @override
  String get cmdExpandLineSelection => 'Expandir Seleção de Linha';

  @override
  String get cmdDeleteAllLeft => 'Excluir Tudo à Esquerda';

  @override
  String get cmdDeleteAllRight => 'Excluir Tudo à Direita';

  @override
  String get cmdAddSelectionToNextFindMatch =>
      'Adicionar Seleção à Próxima Correspondência';

  @override
  String get cmdMoveSelectionToNextFindMatch =>
      'Mover Última Seleção para a Próxima Correspondência';

  @override
  String get cmdSelectHighlights =>
      'Selecionar Todas as Ocorrências da Correspondência';

  @override
  String get cmdChangeAll => 'Alterar Todas as Ocorrências';

  @override
  String get cmdInsertCursorAbove => 'Adicionar Cursor Acima';

  @override
  String get cmdInsertCursorBelow => 'Adicionar Cursor Abaixo';

  @override
  String get cmdRemoveSecondaryCursors => 'Remover Cursores Secundários';

  @override
  String get cmdCursorUndo => 'Desfazer Cursor';

  @override
  String get cmdTransformToUppercase => 'Transformar em Maiúsculas';

  @override
  String get cmdTransformToLowercase => 'Transformar em Minúsculas';

  @override
  String get cmdDetectIndentation => 'Detectar Recuo pelo Conteúdo';

  @override
  String get cmdGoToDefinition => 'Ir para Definição';

  @override
  String get cmdGoToTypeDefinition => 'Ir para Definição de Tipo';

  @override
  String get cmdGoToImplementations => 'Ir para Implementações';

  @override
  String get cmdGoToReferences => 'Ir para Referências';

  @override
  String get cmdRenameSymbol => 'Renomear Símbolo';

  @override
  String get cmdFormatDocument => 'Formatar Documento';

  @override
  String get cmdFormatSelection => 'Formatar Seleção';

  @override
  String get cmdQuickFix => 'Correção Rápida...';

  @override
  String get cmdRefactor => 'Refatorar...';

  @override
  String get cmdSourceAction => 'Ação de Origem...';

  @override
  String get cmdTriggerSuggest => 'Disparar Sugestão';

  @override
  String get cmdTriggerParameterHints => 'Disparar Dicas de Parâmetro';

  @override
  String get cmdShowHover => 'Mostrar ou Focar Dica ao Passar o Mouse';

  @override
  String get quickOpenRecentlyOpened => 'abertos recentemente';

  @override
  String get quickOpenFiles => 'arquivos';

  @override
  String get quickOpenLoadingFiles => 'Carregando arquivos…';

  @override
  String get quickOpenSearchingFiles => 'Pesquisando arquivos…';

  @override
  String get quickOpenNoFiles => 'Nenhum arquivo neste projeto';

  @override
  String get quickOpenNoMatchingResults => 'Nenhum resultado correspondente';

  @override
  String get quickOpenRecentlyUsed => 'usados recentemente';

  @override
  String get quickOpenOtherCommands => 'outros comandos';

  @override
  String get quickOpenNoMatchingCommands => 'Nenhum comando correspondente';

  @override
  String get gotoLineNoEditor =>
      'Abra um editor de texto primeiro para ir para uma linha.';

  @override
  String gotoLineCurrent(int line, int character, int lineCount) {
    return 'Linha atual: $line, Caractere: $character. Digite um número de linha entre 1 e $lineCount para navegar.';
  }

  @override
  String gotoLineLine(int line) {
    return 'Ir para a linha $line.';
  }

  @override
  String gotoLineLineAndCharacter(int line, int character) {
    return 'Ir para a linha $line e o caractere $character.';
  }

  @override
  String get menuFile => 'Arquivo';

  @override
  String get menuEdit => 'Editar';

  @override
  String get menuView => 'Exibir';

  @override
  String get menuHelp => 'Ajuda';

  @override
  String get menuApplication => 'Menu do Aplicativo';

  @override
  String get menuOpenFolder => 'Abrir Pasta…';

  @override
  String get menuCloseWindow => 'Fechar Janela';

  @override
  String get menuAutoSave => 'Salvamento Automático';

  @override
  String get menuBackToChat => 'Voltar ao Chat';

  @override
  String get menuShowSidebar => 'Mostrar Barra Lateral';

  @override
  String get menuHideSidebar => 'Ocultar Barra Lateral';

  @override
  String get menuKeepOnTop => 'Manter no Topo';

  @override
  String get menuContextPanel => 'Painel de Contexto';

  @override
  String get menuAboutBaoCode => 'Sobre o BaoCode';

  @override
  String get windowShowSidebar => 'Mostrar barra lateral';

  @override
  String get windowHideSidebar => 'Ocultar barra lateral';

  @override
  String get chatTerminalHide => 'Ocultar terminal';

  @override
  String get cmdToggleSidePanel => 'Alternar Painel Lateral';

  @override
  String get cmdToggleSidePanelPosition => 'Alternar Posição do Painel Lateral';

  @override
  String get cmdSidePanelChanges => 'Mostrar Alterações do Agente';

  @override
  String get cmdSidePanelFiles => 'Mostrar Arquivos do Agente';

  @override
  String get cmdSidePanelTerminal => 'Mostrar Terminais do Agente';

  @override
  String get cmdSidePanelCloseTab => 'Fechar Aba do Painel Lateral';

  @override
  String get sidePanelFiles => 'Arquivos';

  @override
  String get sidePanelTerminal => 'Terminal';

  @override
  String get sidePanelBrowser => 'Navegador';

  @override
  String get browserNotConnected =>
      'Nenhum navegador conectado. Adicione a extensão do BaoCode ao Chrome (ou Edge, Brave, Arc) e os agentes poderão usar as abas que você compartilhar com eles.';

  @override
  String get browserNoSharedTab =>
      'Nenhuma aba compartilhada ainda. Peça a um agente para abrir uma página ou clique em BaoCode na barra de ferramentas do navegador para compartilhar a aba em primeiro plano.';

  @override
  String get browserOtherApp => 'Outro BaoCode está conectado ao navegador.';

  @override
  String get browserSharedTabs => 'Abas Compartilhadas';

  @override
  String get browserReload => 'Recarregar';

  @override
  String get browserShowInBrowser => 'Mostrar no Navegador';

  @override
  String get browserDetached =>
      'O navegador deixou de permitir que o BaoCode veja esta aba.';

  @override
  String get browserReconnect => 'Reconectar';

  @override
  String get browserShowInPanel => 'Mostrar no Painel Lateral';

  @override
  String get browserWatchTitle => 'Observando você no navegador';

  @override
  String get browserWatchHint =>
      'Faça isso na aba do BaoCode no seu navegador. Quando terminar, clique em Concluir aqui ou no botão do BaoCode na barra de ferramentas do navegador.';

  @override
  String browserWatchSteps(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count etapas gravadas',
      one: '1 etapa gravada',
      zero: 'Nada gravado ainda',
    );
    return '$_temp0';
  }

  @override
  String get browserWatchCancel => 'Cancelar';

  @override
  String get browserWatchDone => 'Concluir';

  @override
  String browserWatchedStep(String kind) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'click': 'Clicou',
      'input': 'Definiu',
      'key': 'Pressionou',
      'submit': 'Enviou',
      'navigate': 'Foi para',
      'closed': 'Fechou a aba',
      'other': 'Fez',
    });
    return '$_temp0';
  }

  @override
  String browserTraceReveal(String app) {
    return 'Mostrar o trace em $app (solte-o no painel Performance do DevTools para analisar com mais detalhes)';
  }

  @override
  String browserStepDone(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'tabs': 'Listou as abas',
      'open': 'Abriu',
      'navigate': 'Foi para',
      'back': 'Voltou',
      'forward': 'Avançou',
      'reload': 'Recarregou',
      'snapshot': 'Leu a página',
      'screenshot': 'Tirou uma captura de tela',
      'click': 'Clicou',
      'type': 'Digitou',
      'press': 'Pressionou',
      'scroll': 'Rolou',
      'evaluate': 'Executou',
      'close': 'Fechou a aba',
      'console': 'Leu o console',
      'network': 'Listou as requisições',
      'request': 'Leu a requisição',
      'performance': 'Fez profiling',
      'recordStart': 'Iniciou o profiling',
      'recordStop': 'Fez profiling',
      'emulate': 'Emulou',
      'watch': 'Observou você',
      'act': 'Agiu',
      'inspect': 'Inspecionou',
      'sources': 'Leu as fontes',
      'breakpoints': 'Definiu pontos de interrupção',
      'debugger': 'Depurou',
      'intercept': 'Interceptou requisições',
      'storage': 'Leu os dados do site',
      'dialog': 'Respondeu à caixa de diálogo',
      'coverage': 'Mediu a cobertura',
      'memory': 'Mediu a memória',
      'history': 'Leu o histórico de depuração',
      'other': 'Usou o navegador',
    });
    return '$_temp0';
  }

  @override
  String browserStepRunning(String action) {
    String _temp0 = intl.Intl.selectLogic(action, {
      'tabs': 'Listando as abas',
      'open': 'Abrindo',
      'navigate': 'Indo para',
      'back': 'Voltando',
      'forward': 'Avançando',
      'reload': 'Recarregando',
      'snapshot': 'Lendo a página',
      'screenshot': 'Tirando uma captura de tela',
      'click': 'Clicando',
      'type': 'Digitando',
      'press': 'Pressionando',
      'scroll': 'Rolando',
      'evaluate': 'Executando',
      'close': 'Fechando a aba',
      'console': 'Lendo o console',
      'network': 'Listando as requisições',
      'request': 'Lendo a requisição',
      'performance': 'Fazendo profiling',
      'recordStart': 'Iniciando o profiling',
      'recordStop': 'Fazendo profiling',
      'emulate': 'Emulando',
      'watch': 'Observando você',
      'act': 'Agindo',
      'inspect': 'Inspecionando',
      'sources': 'Lendo as fontes',
      'breakpoints': 'Definindo pontos de interrupção',
      'debugger': 'Depurando',
      'intercept': 'Interceptando requisições',
      'storage': 'Lendo os dados do site',
      'dialog': 'Respondendo à caixa de diálogo',
      'coverage': 'Medindo a cobertura',
      'memory': 'Medindo a memória',
      'history': 'Lendo o histórico de depuração',
      'other': 'Usando o navegador',
    });
    return '$_temp0';
  }

  @override
  String get sidePanelPlan => 'Plano';

  @override
  String get sidePanelOpenInFiles => 'Abrir em Arquivos';

  @override
  String get sidePanelNoTerminals => 'Nenhum comando em segundo plano';

  @override
  String get sidePanelTaskCompleted => 'Concluída';

  @override
  String get sidePanelTaskFailed => 'Falhou';

  @override
  String get sidePanelWaitingOutput => 'Aguardando saída';

  @override
  String get sidePanelOutputUnavailable => 'Saída indisponível';

  @override
  String get sidePanelShow => 'Mostrar painel lateral';

  @override
  String get sidePanelHide => 'Ocultar painel lateral';

  @override
  String get sidePanelMoveLeft => 'Mover para a Esquerda da Conversa';

  @override
  String get sidePanelMoveRight => 'Mover para a Direita da Conversa';

  @override
  String get sidePanelChanges => 'Alterações';

  @override
  String get sidePanelOpenFile => 'Abrir no painel lateral';

  @override
  String get sidePanelOpenDiff => 'Mostrar alterações no painel lateral';

  @override
  String get sidePanelOpenInIde => 'Abrir no Fast Ide';

  @override
  String get sidePanelCloseTab => 'Fechar';

  @override
  String get sidePanelPreview => 'Visualização';

  @override
  String get sidePanelSource => 'Código-fonte';

  @override
  String get commandOpenDetails => 'Abrir detalhes';

  @override
  String get sidePanelNoOriginal =>
      'O arquivo antes das alterações do agente não é conhecido: exibindo como está.';

  @override
  String get sidePanelUnchanged => 'Sem diferenças';

  @override
  String get sidePanelDeleted => 'O agente excluiu este arquivo.';

  @override
  String get sidePanelTerminals => 'Terminais';

  @override
  String get sidePanelRevealInFiles => 'Mostrar em Arquivos';

  @override
  String get sidePanelAddToChat => 'Adicionar ao Chat';

  @override
  String get termClearTask => 'Limpar';

  @override
  String get termClearEndedTasks => 'Limpar Todas as Tarefas Encerradas';

  @override
  String get sidePanelBackgroundTasks => 'Tarefas em Segundo Plano';

  @override
  String get sidePanelSelectFile => 'Selecione um arquivo para visualizá-lo';

  @override
  String get sidePanelSelectTerminal =>
      'Selecione uma tarefa em segundo plano para ver a saída';

  @override
  String get sidePanelNoFolder => 'Esta conversa não tem pasta de projeto';

  @override
  String get sidePanelSearchFiles => 'Pesquisar os arquivos do projeto';

  @override
  String get sidePanelCloseSearch => 'Fechar a pesquisa';

  @override
  String get sidePanelShowList => 'Mostrar Lista';

  @override
  String get sidePanelHideList => 'Ocultar Lista';

  @override
  String get windowMinimize => 'Minimizar';

  @override
  String get windowMaximize => 'Maximizar';

  @override
  String get windowRestore => 'Restaurar';

  @override
  String get windowClose => 'Fechar';

  @override
  String get aboutDescription =>
      'Os agentes executam o Claude Code como um processo local; o que eles fazem — mensagens, ferramentas, diffs e painéis — é exibido aqui.';

  @override
  String get agentUntitled => 'Novo Chat';

  @override
  String agentImageTitle(String name) {
    return 'Imagem: $name';
  }

  @override
  String get agentImageUntitled => 'Imagem';

  @override
  String get sidebarNewAgent => 'Novo Chat';

  @override
  String get sidebarGroupingProject => 'Projeto';

  @override
  String get sidebarGroupingDate => 'Data';

  @override
  String get sidebarGroupingStatus => 'Status';

  @override
  String get sidebarByProject => 'Por projeto';

  @override
  String get sidebarByDate => 'Por data';

  @override
  String get sidebarByStatus => 'Por status';

  @override
  String get sidebarTimeNow => 'agora';

  @override
  String sidebarTimeMinutes(int count) {
    return '${count}min';
  }

  @override
  String sidebarTimeHours(int count) {
    return '${count}h';
  }

  @override
  String sidebarTimeDays(int count) {
    return '${count}d';
  }

  @override
  String sidebarTimeWeeks(int count) {
    return '${count}sem';
  }

  @override
  String sidebarMonthDay(String month, int day) {
    String _temp0 = intl.Intl.selectLogic(month, {
      '1': '$day jan',
      '2': '$day fev',
      '3': '$day mar',
      '4': '$day abr',
      '5': '$day mai',
      '6': '$day jun',
      '7': '$day jul',
      '8': '$day ago',
      '9': '$day set',
      '10': '$day out',
      '11': '$day nov',
      '12': '$day dez',
      'other': '$day/$month',
    });
    return '$_temp0';
  }

  @override
  String get sidebarPinned => 'Fixados';

  @override
  String get sidebarToday => 'Hoje';

  @override
  String get sidebarYesterday => 'Ontem';

  @override
  String get sidebarPrevious7Days => 'Últimos 7 dias';

  @override
  String get sidebarOlder => 'Mais antigos';

  @override
  String get sidebarNeedsInput => 'Precisa de resposta';

  @override
  String get sidebarRunning => 'Em execução';

  @override
  String get sidebarUnread => 'Não lidos';

  @override
  String sidebarHoverModel(String model) {
    return 'Modelo: $model';
  }

  @override
  String get sidebarDone => 'Concluídos';

  @override
  String get sidebarArchived => 'Arquivados';

  @override
  String get sidebarOpenFolder => 'Abrir pasta…';

  @override
  String get sidebarAgents => 'Agentes';

  @override
  String get sidebarCollapseAll => 'Recolher Tudo';

  @override
  String get sidebarExpandAll => 'Expandir Tudo';

  @override
  String get sidebarNoMatchingAgents => 'Nenhum agente correspondente';

  @override
  String get sidebarNoAgentsYet => 'Nenhum agente ainda';

  @override
  String get sidebarHideArchived => 'Ocultar arquivados';

  @override
  String sidebarArchivedCount(int count) {
    return 'Arquivados · $count';
  }

  @override
  String get sidebarDeleteAgentTitle => 'Excluir agente?';

  @override
  String sidebarDeleteAgentMessage(String title) {
    return '“$title” e a conversa dele serão removidos.';
  }

  @override
  String get sidebarDeleteAgentsTitle => 'Excluir agentes?';

  @override
  String sidebarDeleteAgentsMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Os $count agentes e as conversas deles serão excluídos',
      one: 'O agente e a conversa dele serão excluídos',
    );
    return '$_temp0, inclusive dos kernels. Esta ação não pode ser desfeita.';
  }

  @override
  String sidebarDeleteAgentMessageKernel(String title, String kernel) {
    return '“$title” e a conversa dele serão excluídos, inclusive de $kernel. Esta ação não pode ser desfeita.';
  }

  @override
  String get sidebarSearchAgents => 'Pesquisar agentes…';

  @override
  String get ideChatHistory => 'Histórico de Agentes';

  @override
  String get ideChatShowArchived => 'Mostrar agentes arquivados';

  @override
  String get ideChatNoAgents => 'Nenhum agente neste projeto';

  @override
  String sidebarNewAgentIn(String project) {
    return 'Novo chat em $project';
  }

  @override
  String get newChatRemoteGroup => 'Remoto';

  @override
  String get newChatOpenRemoteDetail => 'Uma pasta em um host via SSH';

  @override
  String get newChatWorkingFolder => 'Pasta de trabalho';

  @override
  String get newChatNoFolder => 'Sem pasta';

  @override
  String get newChatNoFolderDetail => 'Trabalha na pasta Desktop';

  @override
  String newChatOpenFrom(String app) {
    return 'Abrir de $app';
  }

  @override
  String get sidebarPin => 'Fixar';

  @override
  String get sidebarUnpin => 'Desafixar';

  @override
  String get sidebarArchive => 'Arquivar';

  @override
  String get sidebarUnarchive => 'Desarquivar';

  @override
  String sidebarPinCount(int count) {
    return 'Fixar $count Agentes';
  }

  @override
  String sidebarUnpinCount(int count) {
    return 'Desafixar $count Agentes';
  }

  @override
  String sidebarArchiveCount(int count) {
    return 'Arquivar $count Agentes';
  }

  @override
  String sidebarUnarchiveCount(int count) {
    return 'Desarquivar $count Agentes';
  }

  @override
  String sidebarDeleteCount(int count) {
    return 'Excluir $count Agentes…';
  }

  @override
  String get sidebarCopySessionId => 'Copiar ID da sessão';

  @override
  String sidebarOpenStash(int id) {
    return 'Abrir Stash #$id';
  }

  @override
  String get sidebarFork => 'Fork';

  @override
  String sidebarShowMore(int count) {
    return 'Mostrar mais ($count)';
  }

  @override
  String get sidebarShowLess => 'Mostrar menos';

  @override
  String get sidebarNewAgentHere => 'Novo Chat Aqui';

  @override
  String sidebarRevealIn(String app) {
    return 'Mostrar em $app';
  }

  @override
  String get sidebarSortByTime => 'Ordenar por Hora';

  @override
  String get sidebarArchiveAll => 'Arquivar Tudo';

  @override
  String get sidebarUnarchiveAll => 'Desarquivar Tudo';

  @override
  String get sidebarDeleteArchived => 'Excluir Todos os Arquivados…';

  @override
  String get sidebarDeleteArchivedTitle => 'Excluir agentes arquivados?';

  @override
  String sidebarDeleteArchivedMessage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Os $count agentes arquivados e as conversas deles serão excluídos',
      one: 'O agente arquivado e a conversa dele serão excluídos',
    );
    return '$_temp0, inclusive dos kernels. Esta ação não pode ser desfeita.';
  }

  @override
  String get sidebarRemoveFromList => 'Remover da Lista';

  @override
  String get sidebarDropToPin => 'Solte aqui para fixar';

  @override
  String get sidebarMoreActions => 'Mais Ações…';

  @override
  String get sidebarChangeIcon => 'Alterar Ícone…';

  @override
  String sidebarProjectIcon(String project) {
    return 'Alterar ícone de $project';
  }

  @override
  String get iconPickerEmoji => 'Emoji';

  @override
  String get iconPickerIcons => 'Ícones';

  @override
  String get iconPickerCustom => 'Personalizado';

  @override
  String get iconPickerRemove => 'Remover';

  @override
  String get iconPickerSearch => 'Pesquisar…';

  @override
  String get iconPickerRandom => 'Aleatório';

  @override
  String get iconPickerRecent => 'Recentes';

  @override
  String get iconPickerNoResults => 'Nenhum resultado';

  @override
  String get iconPickerDefaultColor => 'Cor padrão';

  @override
  String get iconPickerUpload => 'Enviar uma imagem';

  @override
  String get iconPickerUploadHint =>
      'Envie, solte ou cole uma imagem: PNG, JPG, WebP, GIF ou SVG, até 5 MB';

  @override
  String get iconPickerDropHere => 'Solte a imagem aqui';

  @override
  String get iconPickerUploaded => 'Enviados';

  @override
  String get iconPickerDeleteFromLibrary => 'Excluir da Biblioteca';

  @override
  String get iconPickerBrands => 'Logotipos';

  @override
  String get iconPickerSiteIcon => 'Usar o ícone do site';

  @override
  String iconPickerSiteIconNone(String host) {
    return 'Nenhum ícone encontrado em $host';
  }

  @override
  String get iconUploadTooLarge => 'O arquivo é maior que 5 MB';

  @override
  String get iconUploadUnsupported =>
      'Não é uma imagem PNG, JPG, WebP, GIF ou SVG';

  @override
  String get iconUploadUnreadable => 'Não foi possível ler o arquivo';

  @override
  String get emojiGroupSmileys => 'Carinhas e Emoções';

  @override
  String get emojiGroupPeople => 'Pessoas e Corpo';

  @override
  String get emojiGroupAnimals => 'Animais e Natureza';

  @override
  String get emojiGroupFood => 'Comidas e Bebidas';

  @override
  String get emojiGroupTravel => 'Viagens e Lugares';

  @override
  String get emojiGroupActivities => 'Atividades';

  @override
  String get emojiGroupObjects => 'Objetos';

  @override
  String get emojiGroupSymbols => 'Símbolos';

  @override
  String get emojiGroupFlags => 'Bandeiras';

  @override
  String get workspaceBackToChat => 'Voltar ao chat';

  @override
  String get workspaceNotEnoughRoom => 'Espaço insuficiente nesta tela';

  @override
  String get workspaceWindowGrows => 'A janela cresce para caber';

  @override
  String get workspaceCopyPath => 'Copiar caminho';

  @override
  String workspaceOpenIn(String app) {
    return 'Abrir em $app';
  }

  @override
  String get workspaceChooseEditor => 'Escolher editor';

  @override
  String get workspaceFinder => 'Finder';

  @override
  String get workspaceFileExplorer => 'File Explorer';

  @override
  String get workspaceFileManager => 'Gerenciador de Arquivos';

  @override
  String get workspaceTerminalApp => 'Terminal';

  @override
  String get workspaceWindowsTerminal => 'Windows Terminal';

  @override
  String get workspaceKeepOnTopUnavailable =>
      'Manter no topo está disponível no aplicativo desktop';

  @override
  String get workspaceUnpinWindow => 'Desafixar janela';

  @override
  String get workspacePinWindow => 'Fixar janela no topo';

  @override
  String get chatConversation => 'Conversa';

  @override
  String get chatBackEsc => 'Voltar (Esc)';

  @override
  String get chatBack => 'Voltar';

  @override
  String get statusRunningInBackground => 'Executando em segundo plano';

  @override
  String chatToolCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ferramentas',
      one: '1 ferramenta',
    );
    return '$_temp0';
  }

  @override
  String chatTokens(String tokens) {
    return '$tokens tokens';
  }

  @override
  String durationSeconds(int seconds) {
    return '${seconds}s';
  }

  @override
  String durationMinutesSeconds(int minutes, int seconds) {
    return '${minutes}min ${seconds}s';
  }

  @override
  String durationHoursMinutes(int hours, int minutes) {
    return '${hours}h ${minutes}min';
  }

  @override
  String get agentStateRunningInBackground => 'executando em segundo plano';

  @override
  String get agentStateRunning => 'em execução';

  @override
  String get agentStateDone => 'concluído';

  @override
  String get agentStateFailed => 'falhou';

  @override
  String chatSubagentSemantics(String description, String status) {
    return 'Subagente $description, $status';
  }

  @override
  String get chatOpensItsConversation => 'Abre a conversa dele';

  @override
  String get chatLoadEarlier => 'Carregar mensagens anteriores';

  @override
  String get chatStop => 'Parar';

  @override
  String get chatKeepRunningHint =>
      'Mantém em execução e deixa o agente continuar';

  @override
  String get chatBackground => 'Segundo plano';

  @override
  String get stepThinking => 'Pensando';

  @override
  String get stepThought => 'Pensou';

  @override
  String get stepBriefly => 'brevemente';

  @override
  String get toolReading => 'Lendo';

  @override
  String get toolRead => 'Leu';

  @override
  String get toolGrepping => 'Executando grep em';

  @override
  String get toolGrepped => 'Executou grep em';

  @override
  String get toolListing => 'Listando';

  @override
  String get toolListed => 'Listou';

  @override
  String get toolSearching => 'Pesquisando';

  @override
  String get toolSearched => 'Pesquisou';

  @override
  String get toolEditing => 'Editando';

  @override
  String get toolEdited => 'Editou';

  @override
  String get toolRunning => 'Executando';

  @override
  String get toolRan => 'Executou';

  @override
  String get toolFetching => 'Buscando';

  @override
  String get toolFetched => 'Buscou';

  @override
  String get toolAgent => 'Agente';

  @override
  String get toolUpdatingTodos => 'Atualizando tarefas';

  @override
  String get toolUpdatedTodos => 'Atualizou tarefas';

  @override
  String get toolSending => 'Dizendo';

  @override
  String get toolSent => 'Disse';

  @override
  String get toolAsking => 'Perguntando';

  @override
  String get toolAsked => 'Perguntou';

  @override
  String get toolQuestionSkipped => 'Pergunta ignorada';

  @override
  String get toolUsing => 'Usando';

  @override
  String get toolUsed => 'Usou';

  @override
  String get toolGeneratingImage => 'Gerando imagem';

  @override
  String get toolGeneratedImage => 'Imagem gerada';

  @override
  String get toolImageFailed => 'Imagem não gerada';

  @override
  String get toolImageWaiting => 'Gerar imagem';

  @override
  String get imagePickTitle => 'Escolha o modelo para gerá-la';

  @override
  String get imagePickGenerate => 'Gerar';

  @override
  String get imagePickDecline => 'Ignorar';

  @override
  String get imageSetDefault => 'Definir como padrão';

  @override
  String get imageDefaultSet => 'Definido como modelo de imagem padrão';

  @override
  String get toolProposingGoal => 'Propondo uma meta';

  @override
  String get toolProposedGoal => 'Propôs uma meta';

  @override
  String get goalAdopt => 'Definir como meta';

  @override
  String get goalAdopted => 'Meta definida';

  @override
  String get goalLabel => 'Meta';

  @override
  String get goalWorking => 'Em andamento';

  @override
  String get goalWaiting => 'Aguardando';

  @override
  String get goalNeedsYou => 'Aguardando você';

  @override
  String get goalMet => 'Atingida';

  @override
  String get goalFailed => 'Não pode ser atingida';

  @override
  String goalChecks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'verificada $count vezes',
      one: 'verificada uma vez',
    );
    return '$_temp0';
  }

  @override
  String get goalLastCheck => 'Última verificação';

  @override
  String get goalEdit => 'Editar meta';

  @override
  String get goalClear => 'Limpar meta';

  @override
  String get goalClearConfirm => 'Limpar esta meta?';

  @override
  String get goalSet => 'Definir meta';

  @override
  String get goalDismiss => 'Dispensar';

  @override
  String get goalStopsTurn =>
      'Interrompe este turno para entrar em vigor agora';

  @override
  String imageChip(int number) {
    return 'Imagem $number';
  }

  @override
  String imageReferenceRemoved(int number) {
    return '[Imagem $number]';
  }

  @override
  String pastedTextChip(int number) {
    return 'Texto colado #$number';
  }

  @override
  String pastedTextGone(String path) {
    return 'Este texto colado não está mais em $path.';
  }

  @override
  String pastedTextLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '+$count linhas',
      one: '+1 linha',
    );
    return '$_temp0';
  }

  @override
  String get imageCopy => 'Copiar Imagem';

  @override
  String stepsRead(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'leu $count arquivos',
      one: 'leu 1 arquivo',
    );
    return '$_temp0';
  }

  @override
  String stepsSearched(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'pesquisou $count padrões',
      one: 'pesquisou 1 padrão',
    );
    return '$_temp0';
  }

  @override
  String stepsListed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'listou $count diretórios',
      one: 'listou 1 diretório',
    );
    return '$_temp0';
  }

  @override
  String stepsFetched(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'buscou $count páginas',
      one: 'buscou 1 página',
    );
    return '$_temp0';
  }

  @override
  String stepsRan(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'executou $count comandos',
      one: 'executou 1 comando',
    );
    return '$_temp0';
  }

  @override
  String stepsBrowsed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'deu $count passos no navegador',
      one: 'deu 1 passo no navegador',
    );
    return '$_temp0';
  }

  @override
  String stepsUsed(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'usou $count ferramentas',
      one: 'usou 1 ferramenta',
    );
    return '$_temp0';
  }

  @override
  String get stepsSeparator => ', ';

  @override
  String stepsThought(String duration) {
    return 'pensou $duration';
  }

  @override
  String get turnCopy => 'Copiar resposta';

  @override
  String get turnCopied => 'Copiado';

  @override
  String turnSpeed(String speed) {
    return '$speed tok/s';
  }

  @override
  String turnTokens(String tokens) {
    return '$tokens tokens';
  }

  @override
  String turnTokensHint(String input, String output) {
    return 'Este turno: leu $input (cache incluído), escreveu $output';
  }

  @override
  String get turnSpeedHint => 'Velocidade média de saída';

  @override
  String get turnOutputTokensHint => 'Escrito até agora neste turno';

  @override
  String get turnSpeedLiveHint =>
      'Velocidade de saída, medida nos últimos 2 segundos';

  @override
  String get turnDurationHint => 'Tempo que este turno levou';

  @override
  String get turnCostHint => 'Custo deste turno';

  @override
  String turnWorked(String duration) {
    return 'Trabalhou por $duration';
  }

  @override
  String get planCardLabel => 'Plano';

  @override
  String planCardRound(int round) {
    return 'v$round';
  }

  @override
  String get planDrafting => 'Elaborando';

  @override
  String get planAwaiting => 'Pronto para começar';

  @override
  String get planApproved => 'Aprovado';

  @override
  String get planSentBack => 'Devolvido';

  @override
  String get planStart => 'Iniciar';

  @override
  String get planStartHint => 'Sair do modo Plano e executar este plano';

  @override
  String get planStartMessage => 'Execute o plano';

  @override
  String turnFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
    );
    return '$_temp0';
  }

  @override
  String toolLines(String range) {
    return 'Linhas $range';
  }

  @override
  String get commandStarted => 'Iniciado';

  @override
  String get commandInBackground => 'em segundo plano';

  @override
  String get commandCopyCommand => 'Copiar comando';

  @override
  String get commandCopyOutput => 'Copiar saída';

  @override
  String get commandMoveToBackground => 'Mover para segundo plano';

  @override
  String get commandMore => 'Mais';

  @override
  String get chatSubagent => 'Subagente';

  @override
  String get chatLoadingHistory => 'Carregando conversa…';

  @override
  String get activityCompacting => 'Compactando conversa';

  @override
  String get activityPlanning => 'Planejando o próximo passo';

  @override
  String get activityMusings =>
      'Ponderando\nRemoendo ideias\nCoando ideias\nCogitando\nFerventando\nMarinando\nMexendo e remexendo\nEntendendo a fundo\nPensando no assunto\nLigando os pontos\nSeguindo um palpite\nPreparando um plano\nChocando um plano\nPesando as opções\nDesembaraçando os fios\nPastoreando tokens\nInvocando o contexto\nConsultando o patinho de borracha\nLendo a borra do café\nRabiscando num guardanapo\nRabiscando nas margens\nEspremendo os olhos para o diff\nContando parênteses\nFazendo amizade com o compilador\nNegociando com os tipos\nDomando casos extremos\nRastreando a pilha\nFolheando a documentação\nExplorando o código\nOrganizando os patinhos\nSacudindo a bola 8 mágica\nAquecendo os neurônios\nDobrando pensamentos\nAmarrando a mônada\nConsultando o oráculo\nMexendo a panela\nLustrando o plano';

  @override
  String activityMusingsCommand(String name) {
    return 'Examinando a saída de $name\nDigerindo o que $name disse\nVasculhando a saída de $name\nConcordando com $name';
  }

  @override
  String activityMusingsCommandFailed(String name) {
    return 'Encarando o erro de $name\nPerguntando a $name o que deu errado\nDesembaraçando a reclamação de $name\nConsolando $name';
  }

  @override
  String activityMusingsRead(String name) {
    return 'Folheando $name\nConhecendo $name\nPuxando fios em $name\nLendo nas entrelinhas de $name';
  }

  @override
  String activityMusingsEdit(String name) {
    return 'Admirando o novo $name\nConferindo $name de novo\nTorcendo para $name ainda compilar\nDando uma olhada em $name';
  }

  @override
  String activityMusingsSearch(String name) {
    return 'Garimpando resultados de $name\nPeneirando correspondências de $name\nSeguindo pistas de $name';
  }

  @override
  String activityMusingsFolder(String name) {
    return 'Fuçando em $name\nFazendo a chamada em $name\nAvaliando $name';
  }

  @override
  String activityMusingsWeb(String name) {
    return 'Tomando notas de $name\nDigerindo $name';
  }

  @override
  String activityMusingsAgent(String name) {
    return 'Colhendo o relatório de $name\nCorrigindo o dever de casa de $name\nRevendo as descobertas de $name';
  }

  @override
  String activityMusingsMcp(String name) {
    return 'Abrindo a resposta de $name\nVendo o que $name devolveu';
  }

  @override
  String get activityMusingsBrowser =>
      'Espiando a página\nExaminando a captura de tela';

  @override
  String get activityMusingsImage =>
      'Admirando a imagem novinha\nImplicando com a nova imagem';

  @override
  String get activityMusingsDenied =>
      'Procurando outro caminho\nPegando o caminho mais longo';

  @override
  String get composerCommands => 'Comandos';

  @override
  String get composerMentions => 'Arquivos e conversas';

  @override
  String get composerPlaceholder =>
      'Planeje, pesquise, construa qualquer coisa  ·  solte ou cole arquivos  / para comandos';

  @override
  String composerApprovalTitle(String agent) {
    return 'Como $agent deve obter aprovação?';
  }

  @override
  String get composerApprovalDefault => 'Pedir aprovação';

  @override
  String get composerApprovalDefaultDetail =>
      'Pergunta antes de editar e executar comandos';

  @override
  String get composerApprovalAcceptEdits => 'Aceitar edições';

  @override
  String get composerApprovalAcceptEditsDetail =>
      'Edita arquivos livremente, pergunta antes de comandos';

  @override
  String get composerApprovalAuto => 'Aprovar por mim';

  @override
  String get composerApprovalAutoDetail =>
      'Executa o que é seguro, bloqueia o que parece arriscado';

  @override
  String get composerApprovalDontAsk => 'Não perguntar';

  @override
  String get composerApprovalDontAskDetail =>
      'Nega tudo que não foi pré-aprovado';

  @override
  String get composerApprovalFullAccess => 'Acesso total';

  @override
  String get composerApprovalFullAccessDetail =>
      'Sem verificações: edições e comandos são executados sem perguntar';

  @override
  String get composerContextUsage => 'Uso do contexto';

  @override
  String get composerSend => 'Enviar  ↵';

  @override
  String get composerStop => 'Parar';

  @override
  String get composerSettingContext => 'Contexto';

  @override
  String get composerSettingEffort => 'Esforço';

  @override
  String get composerNoResults => 'Nenhum resultado';

  @override
  String stripOpen(String name) {
    return 'Abrir $name';
  }

  @override
  String stripRunningElapsed(int seconds) {
    return 'Em execução · ${seconds}s';
  }

  @override
  String stripFilesChanged(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos alterados',
      one: '1 arquivo alterado',
    );
    return '$_temp0';
  }

  @override
  String stripAgentsRunning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count subagentes em execução',
      one: '1 subagente em execução',
    );
    return '$_temp0';
  }

  @override
  String stripTasksRunning(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count tarefas em segundo plano em execução',
      one: '1 tarefa em segundo plano em execução',
    );
    return '$_temp0';
  }

  @override
  String get stripUndoAll => 'Desfazer tudo';

  @override
  String get stripKeepAll => 'Manter tudo';

  @override
  String get stripKeep => 'Manter';

  @override
  String get stripUndo => 'Desfazer';

  @override
  String get agentKeepFile => 'Manter arquivo';

  @override
  String get agentUndoFile => 'Desfazer arquivo';

  @override
  String get agentPreviousChange => 'Alteração anterior';

  @override
  String get agentNextChange => 'Próxima alteração';

  @override
  String get agentMoreActions => 'Mais ações';

  @override
  String get stripChangeAdded => 'Adicionado';

  @override
  String get stripChangeModified => 'Modificado';

  @override
  String get stripChangeDeleted => 'Excluído';

  @override
  String get stripChangeConflict =>
      'Alterado novamente desde que o agente o deixou, então Desfazer não conseguiu remover a alteração do agente. Desfaça manualmente e depois mantenha.';

  @override
  String get stripChangeShared =>
      'Outro agente estava trabalhando neste projeto ao mesmo tempo: parte desta alteração pode ser dele.';

  @override
  String get stripChangeUntracked =>
      'O estado anterior não é conhecido (está ignorado ou grande demais e o agente não informou, ou fica fora do projeto): pode ser mantido, não desfeito.';

  @override
  String get stripChangesDiff => 'Alterações do Agente';

  @override
  String get usageUsed => 'Usado';

  @override
  String get usageContextWindow => 'Janela de contexto';

  @override
  String usageTokensSummary(String used, String total, String percent) {
    return '$used / $total tokens · $percent%';
  }

  @override
  String get usageReservedForCompaction => 'Reservado para compactação';

  @override
  String get usagePromptCache => 'Cache de prompt';

  @override
  String usageCacheLast(String read, String written, String uncached) {
    return 'Última requisição: $read lidos · $written gravados · $uncached sem cache';
  }

  @override
  String usageCacheOverall(String percent) {
    return 'chat principal $percent%';
  }

  @override
  String usageCacheConversation(String read, String written, String percent) {
    return 'Conversa principal: $read lidos · $written gravados · $percent% de acerto';
  }

  @override
  String get usageCacheExcludes =>
      'Sem contar subagentes, compactação ou requisições paralelas da CLI';

  @override
  String get usagePlanUsage => 'Uso do plano';

  @override
  String get usageThisSession => 'Esta sessão';

  @override
  String get usageCheckingLimits => 'Verificando limites…';

  @override
  String get usageLimitsUnavailable =>
      'Os limites estão indisponíveis no momento; reabra isto mais tarde para tentar novamente.';

  @override
  String get usageLimitsAfterMessage =>
      'Os limites são atualizados com a conversa; aparecem após uma mensagem.';

  @override
  String usageResets(String when) {
    return 'redefine $when';
  }

  @override
  String usageInMinutes(int minutes) {
    return 'em ${minutes}min';
  }

  @override
  String usageInHours(int hours) {
    return 'em ${hours}h';
  }

  @override
  String usageInHoursMinutes(int hours, int minutes) {
    return 'em ${hours}h ${minutes}min';
  }

  @override
  String usageInDays(int days) {
    return 'em ${days}d';
  }

  @override
  String usageInDaysHours(int days, int hours) {
    return 'em ${days}d ${hours}h';
  }

  @override
  String healthStopped(String name) {
    return '$name parou';
  }

  @override
  String healthFolderGone(String folder) {
    return 'A pasta do projeto não existe mais: $folder';
  }

  @override
  String get healthHideDetails => 'Ocultar detalhes';

  @override
  String get markdownDetails => 'Detalhes';

  @override
  String get healthDetails => 'Detalhes';

  @override
  String get healthRetry => 'Tentar novamente';

  @override
  String get interactionOther => 'Outro';

  @override
  String get interactionTypeYourAnswer => 'Digite sua resposta';

  @override
  String get interactionAllowOnce => 'Permitir uma vez';

  @override
  String get interactionDeny => 'Negar';

  @override
  String get interactionDenyHint => 'Diga ao agente o que fazer em vez disso';

  @override
  String interactionStepOf(int step, int total) {
    return '$step / $total';
  }

  @override
  String get interactionSkip => 'Pular';

  @override
  String get interactionSubmit => 'Enviar';

  @override
  String get interactionNext => 'Próximo';

  @override
  String get interactionBack => 'Voltar';

  @override
  String get interactionCollapse => 'Recolher';

  @override
  String get interactionExpand => 'Expandir';

  @override
  String interactionMoreLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '… mais $count linhas',
      one: '… mais 1 linha',
    );
    return '$_temp0';
  }

  @override
  String get mcpServers => 'Servidores MCP';

  @override
  String mcpConnectedOf(int connected, int total) {
    return '$connected de $total conectados';
  }

  @override
  String get mcpRefresh => 'Atualizar';

  @override
  String get mcpNoServers =>
      'Nenhum servidor MCP configurado para este projeto.';

  @override
  String get mcpConnected => 'Conectado';

  @override
  String get mcpConnecting => 'Conectando…';

  @override
  String get mcpFailed => 'Falhou';

  @override
  String get mcpNeedsSignIn => 'Requer login';

  @override
  String get mcpDisabled => 'Desativado';

  @override
  String get mcpReconnect => 'Reconectar';

  @override
  String get mcpSignIn => 'Entrar';

  @override
  String get mcpEnable => 'Ativar';

  @override
  String get mcpDisable => 'Desativar';

  @override
  String get mcpTest => 'Testar conexão';

  @override
  String get mcpTestAll => 'Testar todos';

  @override
  String get mcpViewLog => 'Ver log';

  @override
  String mcpExitCode(int code) {
    return 'Encerrou com o código $code';
  }

  @override
  String mcpTimedOut(int seconds) {
    return 'Sem resposta em $seconds segundos';
  }

  @override
  String get mcpLog => 'Saída (stderr)';

  @override
  String get mcpNoLog => 'Não escreveu nada.';

  @override
  String get mcpSignInHint =>
      'Entre pelo painel de servidores MCP de um chat, ou com /mcp.';

  @override
  String get mcpProbeNote =>
      'Iniciado e saudado com o initialize do MCP, como o `claude mcp list` verifica.';

  @override
  String todoCount(int done, int total) {
    return 'Tarefas $done/$total';
  }

  @override
  String queuedMessages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count na fila',
      one: '1 na fila',
    );
    return '$_temp0 · enviadas quando o agente terminar';
  }

  @override
  String queuedImages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count imagens',
      one: '1 imagem',
    );
    return '$_temp0';
  }

  @override
  String get queuedEdit => 'Retomar para editar';

  @override
  String get queuedSendNow => 'Parar o agente e enviar agora';

  @override
  String get queuedRemove => 'Remover da fila';

  @override
  String get stopConfirmMessage => 'Parar o agente?';

  @override
  String stopConfirmDetail(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'As $count tarefas em execução em segundo plano também serão interrompidas.',
      one: 'A tarefa em execução em segundo plano também será interrompida.',
    );
    return '$_temp0';
  }

  @override
  String get stopConfirmStop => 'Parar';

  @override
  String get tabClose => 'Fechar';

  @override
  String get tabCloseOthers => 'Fechar outras';

  @override
  String get tabCloseToTheRight => 'Fechar à direita';

  @override
  String get tabCloseSaved => 'Fechar salvas';

  @override
  String get tabCloseAll => 'Fechar todas';

  @override
  String get fileLinkOpen => 'Abrir';

  @override
  String get fileLinkOpenInPanel => 'Abrir no painel lateral';

  @override
  String get fileLinkPreview => 'Visualizar';

  @override
  String get fileLinkOpenInBrowser => 'Abrir no navegador';

  @override
  String get tabCopyPath => 'Copiar caminho';

  @override
  String get tabCopyRelativePath => 'Copiar caminho relativo';

  @override
  String get tabRevealInExplorerView => 'Revelar no Explorer';

  @override
  String get tabMoreActions => 'Mais ações…';

  @override
  String get markdownShowPreview => 'Visualizar';

  @override
  String get markdownShowSource => 'Markdown';

  @override
  String get markdownFindInSource =>
      'Localizar não está disponível na visualização: mostrando o código-fonte Markdown.';

  @override
  String markdownPasteFolder(String name) {
    return 'Pastas não podem ser coladas em um documento: $name';
  }

  @override
  String get markdownPasteLargeTitle => 'Copiar um arquivo grande?';

  @override
  String markdownPasteLargeMessage(String name, String size) {
    return '$name tem $size. Copiar ao lado do documento?';
  }

  @override
  String get markdownPasteLargeConfirm => 'Copiar';

  @override
  String markdownPasteFailed(String name, String error) {
    return 'Não foi possível colar $name: $error';
  }

  @override
  String get markdownPasteMoved =>
      'O documento mudou durante a colagem: os links foram adicionados ao final dele.';

  @override
  String tabCloseNamed(String name) {
    return 'Fechar $name';
  }

  @override
  String tabDeleted(String name) {
    return '$name (excluído)';
  }

  @override
  String get commonDismiss => 'Dispensar';

  @override
  String layoutTogglePrimarySideBar(String keybinding) {
    return 'Alternar barra lateral primária ($keybinding)';
  }

  @override
  String layoutTogglePanel(String keybinding) {
    return 'Alternar painel ($keybinding)';
  }

  @override
  String layoutToggleChat(String keybinding) {
    return 'Alternar chat ($keybinding)';
  }

  @override
  String get dialogCloseDialog => 'Fechar caixa de diálogo';

  @override
  String get menuDismissMenu => 'Dispensar menu';

  @override
  String get notificationsHide => 'Ocultar notificações';

  @override
  String get notificationsNone => 'Nenhuma notificação';

  @override
  String get notificationsNoNew => 'Nenhuma notificação nova';

  @override
  String notificationsNew(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count novas notificações',
      one: '1 nova notificação',
    );
    return '$_temp0';
  }

  @override
  String get notificationsCenterNoNew => 'NENHUMA NOTIFICAÇÃO NOVA';

  @override
  String get notificationsCenterTitle => 'NOTIFICAÇÕES';

  @override
  String get notificationsClearAll => 'Limpar todas as notificações';

  @override
  String get notificationsCollapse => 'Recolher notificação';

  @override
  String get notificationsExpand => 'Expandir notificação';

  @override
  String get notificationsMoreActions => 'Mais ações...';

  @override
  String get notificationsClear => 'Limpar notificação';

  @override
  String notificationsSource(String source) {
    return 'Origem: $source';
  }

  @override
  String explorerCannotReadFolder(String error) {
    return 'Não é possível ler a pasta: $error';
  }

  @override
  String get explorerNameRequired =>
      'É necessário informar um nome de arquivo ou pasta.';

  @override
  String get explorerNameStartsWithSlash =>
      'Um nome de arquivo ou pasta não pode começar com uma barra.';

  @override
  String explorerNameExists(String name) {
    return 'Já existe um arquivo ou pasta $name neste local. Escolha um nome diferente.';
  }

  @override
  String explorerNameInvalid(String name) {
    return 'O nome $name não é válido como nome de arquivo ou pasta. Escolha um nome diferente.';
  }

  @override
  String get explorerNameWhitespace =>
      'Espaço em branco no início ou no fim do nome do arquivo ou pasta.';

  @override
  String get explorerMoveToTrash => 'Mover para a lixeira';

  @override
  String explorerDeleteFolderUnsaved(int count, String name) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Você está excluindo a pasta $name com alterações não salvas em $count arquivos. Deseja continuar?',
      one:
          'Você está excluindo a pasta $name com alterações não salvas em 1 arquivo. Deseja continuar?',
    );
    return '$_temp0';
  }

  @override
  String explorerDeleteFileUnsaved(String name) {
    return 'Você está excluindo $name com alterações não salvas. Deseja continuar?';
  }

  @override
  String get explorerChangesLost =>
      'Suas alterações serão perdidas se você não as salvar.';

  @override
  String explorerConfirmDeleteFolder(String name) {
    return 'Tem certeza de que deseja excluir \'$name\' e seu conteúdo?';
  }

  @override
  String explorerConfirmDeleteFile(String name) {
    return 'Tem certeza de que deseja excluir \'$name\'?';
  }

  @override
  String get explorerRestoreFromTrash =>
      'Você pode restaurar este arquivo da lixeira.';

  @override
  String explorerConfirmPermanentDeleteFolder(String name) {
    return 'Tem certeza de que deseja excluir permanentemente \'$name\' e seu conteúdo?';
  }

  @override
  String explorerConfirmPermanentDeleteFile(String name) {
    return 'Tem certeza de que deseja excluir permanentemente \'$name\'?';
  }

  @override
  String get explorerIrreversible => 'Esta ação é irreversível!';

  @override
  String get explorerRestoreWithUndo =>
      'Você pode restaurar este arquivo usando o comando Desfazer.';

  @override
  String get explorerDeleteFilesUnsaved =>
      'Você está excluindo arquivos com alterações não salvas. Deseja continuar?';

  @override
  String explorerConfirmDeleteMultiple(int count) {
    return 'Tem certeza de que deseja excluir os seguintes $count arquivos/diretórios e seu conteúdo?';
  }

  @override
  String explorerConfirmPermanentDeleteMultiple(int count) {
    return 'Tem certeza de que deseja excluir permanentemente os seguintes $count arquivos/diretórios e seu conteúdo?';
  }

  @override
  String get explorerRestoreFilesFromTrash =>
      'Você pode restaurar estes arquivos da lixeira.';

  @override
  String get explorerRestoreFilesWithUndo =>
      'Você pode restaurar estes arquivos usando o comando Desfazer.';

  @override
  String explorerMoreFilesNotShown(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '...$count arquivos adicionais não mostrados',
      one: '...1 arquivo adicional não mostrado',
    );
    return '$_temp0';
  }

  @override
  String get explorerTrashFailed =>
      'Falha ao excluir usando a lixeira. Deseja excluir permanentemente?';

  @override
  String get explorerDeletePermanently => 'Excluir permanentemente';

  @override
  String get explorerPasteIntoAncestor =>
      'O arquivo a colar é um ancestral da pasta de destino';

  @override
  String explorerUploading(int done, int total) {
    return 'Carregando arquivos... $done/$total';
  }

  @override
  String explorerDownloading(int done, int total) {
    return 'Baixando arquivos... $done/$total';
  }

  @override
  String get explorerPreparingTransfer => 'Preparando arquivos...';

  @override
  String composerCopyToHostFailed(String error) {
    return 'Não foi possível copiar os arquivos para o host remoto: $error';
  }

  @override
  String get explorerNewFile => 'Novo arquivo...';

  @override
  String get explorerNewFolder => 'Nova pasta...';

  @override
  String get explorerRevealInFinder => 'Revelar no Finder';

  @override
  String get explorerFindInFolder => 'Localizar na pasta...';

  @override
  String get explorerOpenInTerminal => 'Abrir no terminal';

  @override
  String get explorerRename => 'Renomear...';

  @override
  String get findNoResults => 'Nenhum resultado';

  @override
  String findMatchOf(String current, String total) {
    return '$current de $total';
  }

  @override
  String get findFind => 'Localizar';

  @override
  String get findMatchCase => 'Diferenciar maiúsculas/minúsculas';

  @override
  String get findWholeWord => 'Palavra inteira';

  @override
  String get findRegularExpression => 'Expressão regular';

  @override
  String get findPreviousMatch => 'Ocorrência anterior';

  @override
  String get findNextMatch => 'Próxima ocorrência';

  @override
  String get findClose => 'Fechar localizar';

  @override
  String get findReplace => 'Substituir';

  @override
  String get findReplaceMatch => 'Substituir ocorrência';

  @override
  String get findReplaceAll => 'Substituir tudo';

  @override
  String get findToggleReplace => 'Alternar substituição';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsSectionLanguage => 'Região e idioma';

  @override
  String get settingsSectionKeyboard => 'Atalhos de teclado';

  @override
  String get settingsSectionDataDirectory => 'Diretório de dados';

  @override
  String get settingsSectionGeneral => 'Geral';

  @override
  String get settingsGroupPreferences => 'Preferências';

  @override
  String get settingsGroupAdvanced => 'Avançado';

  @override
  String get generalSettingsTitle => 'Geral';

  @override
  String get generalSettingsCommitAttribution => 'Atribuição de commits';

  @override
  String get generalSettingsCommitAttributionDescription =>
      'Quem recebe o crédito pelos commits e pull requests que um agente escreve. Vale para agentes iniciados após uma mudança; por enquanto, apenas Claude Code.';

  @override
  String get generalSettingsClaudeCore => 'Núcleo';

  @override
  String get generalSettingsClaudeCoreDescription =>
      'Claude Code CLI: o programa da própria Anthropic, com o login e a configuração desta máquina; escolha-o para usar uma assinatura do Claude. Integrado: vem com o BaoCode e usa apenas os modelos adicionados em Configurações → Modelos. O CLI é o padrão, baixado para você se esta máquina não tiver um. As mudanças valem para novas sessões.';

  @override
  String get generalSettingsClaudeCoreBuiltin => 'Integrado';

  @override
  String get generalSettingsClaudeCoreCli => 'Claude Code CLI';

  @override
  String get generalSettingsQueuedMessages =>
      'Mensagens enviadas durante o trabalho';

  @override
  String get generalSettingsQueuedMessagesDescription =>
      'Quando uma mensagem enviada enquanto o agente ainda trabalha é processada. Vale para mensagens enviadas após uma mudança; por enquanto, apenas Claude Code.';

  @override
  String get generalSettingsQueuedAfterTurn => 'Após a tarefa atual';

  @override
  String get generalSettingsQueuedDuringTurn => 'Juntar-se à tarefa atual';

  @override
  String get generalSettingsPromptSuggestions => 'Sugerir próximo prompt';

  @override
  String get generalSettingsPromptSuggestionsDescription =>
      'Após cada turno, uma sugestão em cinza para a sua próxima mensagem, aceita com Tab. Cada uma é uma requisição extra com toda a conversa; desative para economizar tokens. Vale a partir da próxima mensagem; apenas Claude Code.';

  @override
  String generalSettingsCommitAttributionLabel(String name) {
    return 'Atribuição de commits: $name';
  }

  @override
  String get generalSettingsAttributionAgent => 'Seguir o agente';

  @override
  String get generalSettingsAttributionAgentDetail =>
      'A do próprio agente, por exemplo a do Claude Code, ou a atribuição definida no seu ~/.claude/settings.json.';

  @override
  String get generalSettingsAttributionNone => 'Nenhuma';

  @override
  String get generalSettingsAttributionNoneDetail =>
      'Nada é adicionado aos commits ou pull requests.';

  @override
  String get settingsSectionNotifications => 'Notificações';

  @override
  String get notificationsSettingsTitle => 'Notificações';

  @override
  String get notificationsEnabled =>
      'Notificar quando um agente precisar de mim';

  @override
  String get notificationsEnabledDescription =>
      'Uma notificação do sistema e um som quando um agente fizer uma pergunta ou terminar. O ícone do app conta os agentes que aguardam você ou ainda não foram vistos, de qualquer forma.';

  @override
  String get notificationsEvents => 'Notificar quando um agente';

  @override
  String get notificationsEventNeedsInput => 'Precisar da sua resposta';

  @override
  String get notificationsEventNeedsInputDetail =>
      'Ele faz uma pergunta, pede permissão ou pede a aprovação do plano.';

  @override
  String get notificationsEventFinished => 'Terminar um turno';

  @override
  String get notificationsEventFinishedDetail =>
      'Ele terminou e aguarda a sua próxima mensagem.';

  @override
  String get notificationsWhen => 'Quando';

  @override
  String get notificationsWhenDescription =>
      'Se deve notificar sobre o agente que você está olhando, na janela em primeiro plano.';

  @override
  String get notificationsWhenUnfocused =>
      'Quando eu não estiver olhando para ele';

  @override
  String get notificationsWhenAlways => 'Sempre';

  @override
  String notificationsWhenLabel(String name) {
    return 'Notificar: $name';
  }

  @override
  String get notificationsSound => 'Som';

  @override
  String get notificationsSoundMicrowave => 'Ding do micro-ondas';

  @override
  String get notificationsSoundManOhYeah => 'man-oh-yeah';

  @override
  String get notificationsSoundGulpGulpGulpGulp => 'Gulp Gulp Gulp Gulp';

  @override
  String get notificationsSoundNone => 'Nenhum';

  @override
  String get notificationsSoundChoose => 'Escolher um arquivo…';

  @override
  String notificationsSoundLabel(String name) {
    return 'Som: $name';
  }

  @override
  String get notificationsSoundPlay => 'Reproduzir';

  @override
  String get traySettings => 'Bandeja';

  @override
  String get trayEnabledMacOS => 'Mostrar o ícone na barra de menus';

  @override
  String get trayEnabledWindows => 'Mostrar o ícone na bandeja do sistema';

  @override
  String get trayEnabledDescription =>
      'Fechar a janela a oculta ali e os agentes continuam rodando; o menu mostra os agentes que aguardam você e encerra o app.';

  @override
  String get trayShow => 'Mostrar o BaoCode';

  @override
  String get trayWaiting => 'Aguardando você';

  @override
  String trayWaitingCount(int count) {
    return '$count aguardando';
  }

  @override
  String trayRunning(int count) {
    return '$count em execução';
  }

  @override
  String get trayQuit => 'Sair do BaoCode';

  @override
  String get attentionNeedsInput => 'Precisa da sua resposta';

  @override
  String get attentionFinished => 'Concluído';

  @override
  String get attentionPlanReady => 'Plano pronto para revisão';

  @override
  String get placeholderBinary =>
      'O arquivo não é exibido no editor de texto porque é binário ou usa uma codificação de texto sem suporte.';

  @override
  String placeholderTooLarge(String size) {
    return 'O arquivo não é exibido no editor de texto porque é muito grande ($size).';
  }

  @override
  String get placeholderNotFound =>
      'Não foi possível abrir o editor porque o arquivo não foi encontrado.';

  @override
  String get placeholderUnexpected =>
      'Não foi possível abrir o editor devido a um erro inesperado.';

  @override
  String get placeholderOpenAnyway => 'Abrir mesmo assim';

  @override
  String get changeOpenWith => 'Abrir com';

  @override
  String get openInDefaultApp => 'Abrir no app padrão';

  @override
  String openInDefaultAppFailed(String name) {
    return 'Não foi possível abrir \'$name\' no app padrão.';
  }

  @override
  String get placeholderTryAgain => 'Tentar novamente';

  @override
  String fileErrorConflict(String path) {
    return 'O arquivo mudou no disco. Reabra-o antes de salvar: $path';
  }

  @override
  String fileErrorNotFound(String path) {
    return 'Arquivo não encontrado: $path';
  }

  @override
  String fileErrorBinary(String path) {
    return 'Arquivos binários não podem ser editados: $path';
  }

  @override
  String fileErrorTooLarge(String path) {
    return 'Arquivos acima de 5 MB não podem ser editados: $path';
  }

  @override
  String fileErrorExists(String name) {
    return 'Já existe um arquivo ou pasta $name neste local.';
  }

  @override
  String get themeDefaultLight => 'Claro padrão';

  @override
  String get themeDefaultDark => 'Escuro padrão';

  @override
  String get themeLightThemes => 'temas claros';

  @override
  String get themeDarkThemes => 'temas escuros';

  @override
  String get themeHighContrastThemes => 'temas de alto contraste';

  @override
  String get themeSelectPlaceholder =>
      'Selecionar tema de cores (detecção do modo de cores do sistema desativada)';

  @override
  String get dateNow => 'agora';

  @override
  String dateAgo(String time) {
    return 'há $time';
  }

  @override
  String dateIn(String time) {
    return 'em $time';
  }

  @override
  String dateSeconds(String full, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count segundos',
      one: '$count segundo',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count s',
      one: '$count s',
    );
    String _temp2 = intl.Intl.selectLogic(full, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String dateMinutes(String full, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos',
      one: '$count minuto',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count min',
      one: '$count min',
    );
    String _temp2 = intl.Intl.selectLogic(full, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String dateHours(String full, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas',
      one: '$count hora',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count h',
      one: '$count h',
    );
    String _temp2 = intl.Intl.selectLogic(full, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String dateDays(String full, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '$count dia',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '$count dia',
    );
    String _temp2 = intl.Intl.selectLogic(full, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String dateWeeks(String full, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas',
      one: '$count semana',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sem',
      one: '$count sem',
    );
    String _temp2 = intl.Intl.selectLogic(full, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String dateMonths(String full, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses',
      one: '$count mês',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses',
      one: '$count mês',
    );
    String _temp2 = intl.Intl.selectLogic(full, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String dateYears(String full, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anos',
      one: '$count ano',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anos',
      one: '$count ano',
    );
    String _temp2 = intl.Intl.selectLogic(full, {
      'true': '$_temp0',
      'other': '$_temp1',
    });
    return '$_temp2';
  }

  @override
  String get commonRefresh => 'Atualizar';

  @override
  String get commonMoreActions => 'Mais ações...';

  @override
  String get commonCollapseAll => 'Recolher tudo';

  @override
  String get commonYes => 'Sim';

  @override
  String get gitStatusIndexModified => 'Índice modificado';

  @override
  String get gitStatusModified => 'Modificado';

  @override
  String get gitStatusIndexAdded => 'Índice adicionado';

  @override
  String get gitStatusIndexDeleted => 'Índice excluído';

  @override
  String get gitStatusDeleted => 'Excluído';

  @override
  String get gitStatusIndexRenamed => 'Índice renomeado';

  @override
  String get gitStatusIndexCopied => 'Índice copiado';

  @override
  String get gitStatusUntracked => 'Não rastreado';

  @override
  String get gitStatusIgnored => 'Ignorado';

  @override
  String get gitStatusIntentToAdd => 'Intenção de adicionar';

  @override
  String get gitStatusIntentToRename => 'Intenção de renomear';

  @override
  String get gitStatusTypeChanged => 'Tipo alterado';

  @override
  String get gitStatusBothDeleted => 'Conflito: excluído por ambos';

  @override
  String get gitStatusAddedByUs => 'Conflito: adicionado por nós';

  @override
  String get gitStatusDeletedByThem => 'Conflito: excluído por eles';

  @override
  String get gitStatusAddedByThem => 'Conflito: adicionado por eles';

  @override
  String get gitStatusDeletedByUs => 'Conflito: excluído por nós';

  @override
  String get gitStatusBothAdded => 'Conflito: adicionado por ambos';

  @override
  String get gitStatusBothModified => 'Conflito: modificado por ambos';

  @override
  String get gitIgnoredInGit => 'Ignorado no Git';

  @override
  String get gitBlameNotCommittedYet => 'Ainda não commitado';

  @override
  String get gitContainsEmphasizedItems => 'Contém itens em destaque';

  @override
  String get gitChangeIndex => 'Índice';

  @override
  String get gitChangeWorkingTree => 'Árvore de trabalho';

  @override
  String get gitChangeDeleted => 'Excluído';

  @override
  String get gitChangeTheirs => 'Deles';

  @override
  String get gitChangeOurs => 'Nossa';

  @override
  String get gitChangeUntracked => 'Não rastreado';

  @override
  String get gitChangeIntentToAdd => 'Intenção de adicionar';

  @override
  String get gitChangeTypeChanged => 'Tipo alterado';

  @override
  String get scmTitle => 'Controle de código-fonte';

  @override
  String get scmNoProviders =>
      'Nenhum provedor de controle de código-fonte registrado.';

  @override
  String get scmInstallGit =>
      'Instale o Git, um sistema popular de controle de código-fonte, para rastrear alterações no código e colaborar com outras pessoas.';

  @override
  String get scmNoRepository =>
      'A pasta aberta no momento não tem um repositório Git. Você pode inicializar um repositório, o que habilitará os recursos de controle de código-fonte baseados no Git.';

  @override
  String get scmInitializeRepository => 'Inicializar repositório';

  @override
  String get scmChanges => 'Alterações';

  @override
  String scmTooManyChanges(int count) {
    final intl.NumberFormat countNumberFormat =
        intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return 'Este repositório tem alterações demais: apenas as primeiras $countString são mostradas, e mudanças em arquivos não as atualizam mais. Use Atualizar para lê-las novamente.';
  }

  @override
  String get scmGroupMerge => 'Alterações de merge';

  @override
  String get scmGroupStaged => 'Alterações staged';

  @override
  String get scmGraph => 'Grafo';

  @override
  String get scmCommit => 'Commit';

  @override
  String get scmCommitChanges => 'Fazer commit das alterações';

  @override
  String get scmCommitAmend => 'Commit (Amend)';

  @override
  String get scmCommitStaged => 'Commit dos staged';

  @override
  String get scmCommitAll => 'Commit de tudo';

  @override
  String get scmCommitStagedAmend => 'Commit dos staged (Amend)';

  @override
  String get scmCommitAllAmend => 'Commit de tudo (Amend)';

  @override
  String get scmUndoLastCommit => 'Desfazer último commit';

  @override
  String get scmGraphBranches => 'Branches exibidas';

  @override
  String get scmGraphCurrentBranch => 'Branch atual';

  @override
  String get scmGraphAllBranches => 'Todas as branches';

  @override
  String get scmGoToCurrent => 'Ir para o item atual do histórico';

  @override
  String get scmViewAndSort => 'Exibir e ordenar';

  @override
  String get scmViewAsList => 'Exibir como lista';

  @override
  String get scmViewAsTree => 'Exibir como árvore';

  @override
  String get scmSortByName => 'Ordenar alterações por nome';

  @override
  String get scmSortByPath => 'Ordenar alterações por caminho';

  @override
  String get scmSortByStatus => 'Ordenar alterações por status';

  @override
  String get scmStageChanges => 'Fazer stage das alterações';

  @override
  String get scmUnstageChanges => 'Remover stage das alterações';

  @override
  String get scmDiscardChanges => 'Descartar alterações';

  @override
  String get scmStageAllMerge => 'Fazer stage de todas as alterações de merge';

  @override
  String get scmStageAll => 'Fazer stage de todas as alterações';

  @override
  String get scmUnstageAll => 'Remover stage de todas as alterações';

  @override
  String get scmDiscardAll => 'Descartar todas as alterações';

  @override
  String get scmOpenFile => 'Abrir arquivo';

  @override
  String get scmOpenChanges => 'Abrir alterações';

  @override
  String get scmOpenFileHead => 'Abrir arquivo (HEAD)';

  @override
  String get scmAddToGitignore => 'Adicionar ao .gitignore';

  @override
  String get scmInput => 'Entrada do controle de código-fonte';

  @override
  String scmMessagePlaceholder(String keybinding) {
    return 'Mensagem ($keybinding para fazer commit)';
  }

  @override
  String scmMessagePlaceholderBranch(String keybinding, String branch) {
    return 'Mensagem ($keybinding para fazer commit em \"$branch\")';
  }

  @override
  String get scmGenerateCommitMessage => 'Gerar mensagem de commit';

  @override
  String get scmCancelGenerateCommitMessage =>
      'Cancelar geração da mensagem de commit';

  @override
  String get scmNoChangesToGenerate =>
      'Não há alterações para gerar uma mensagem de commit.';

  @override
  String get scmPublishBranch => 'Publicar branch';

  @override
  String scmPublishBranchNamed(String branch) {
    return 'Publicar branch \"$branch\"';
  }

  @override
  String scmPublishingBranchNamed(String branch) {
    return 'Publicando branch \"$branch\"...';
  }

  @override
  String get scmSyncChanges => 'Sincronizar alterações';

  @override
  String get scmSynchronizeChanges => 'Sincronizar alterações';

  @override
  String get scmSynchronizingChanges => 'Sincronizando alterações...';

  @override
  String get scmFetch => 'Fetch';

  @override
  String get scmFetchFromAllRemotes => 'Fetch de todos os remotos';

  @override
  String get scmPull => 'Pull';

  @override
  String get scmPush => 'Push';

  @override
  String scmPullCommits(int count, String upstream) {
    return 'Fazer pull de $count commits de $upstream';
  }

  @override
  String scmPushCommits(int count, String upstream) {
    return 'Fazer push de $count commits para $upstream';
  }

  @override
  String scmPullPushCommits(int behind, int ahead, String upstream) {
    return 'Fazer pull de $behind e push de $ahead commits entre $upstream';
  }

  @override
  String scmConfirmSync(String upstream) {
    return 'Esta ação fará pull e push de commits de e para \"$upstream\".';
  }

  @override
  String get scmDontShowAgain => 'OK, não mostrar novamente';

  @override
  String get scmNoRemotes =>
      'Seu repositório não tem remotos configurados para publicação.';

  @override
  String get scmProvideMessage => 'Forneça uma mensagem de commit';

  @override
  String get scmNoStagedChanges =>
      'Não há alterações em stage para fazer commit.\n\nDeseja fazer stage de todas as suas alterações e fazer commit delas diretamente?';

  @override
  String get scmAlways => 'Sempre';

  @override
  String get scmNever => 'Nunca';

  @override
  String get scmNoChangesToCommit => 'Não há alterações para fazer commit.';

  @override
  String get scmCreateEmptyCommit => 'Criar commit vazio';

  @override
  String get scmCantUndo =>
      'Não é possível desfazer porque HEAD não aponta para nenhum commit.';

  @override
  String get scmConfirmUndoMerge =>
      'O último commit foi um commit de merge. Tem certeza de que deseja desfazê-lo?';

  @override
  String get scmUndoMergeCommit => 'Desfazer commit de merge';

  @override
  String get scmIrreversibleFile =>
      'Isto é IRREVERSÍVEL!\nEste arquivo será PERDIDO PARA SEMPRE se você continuar.';

  @override
  String get scmIrreversibleFiles =>
      'Isto é IRREVERSÍVEL!\nEstes arquivos serão PERDIDOS PARA SEMPRE se você continuar.';

  @override
  String get scmIrreversibleWorkingSet =>
      'Isto é IRREVERSÍVEL!\nSeu conjunto de trabalho atual será PERDIDO PARA SEMPRE se você continuar.';

  @override
  String scmConfirmDeleteUntracked(String name) {
    return 'Tem certeza de que deseja EXCLUIR o seguinte arquivo não rastreado: \'$name\'?';
  }

  @override
  String scmConfirmDeleteUntrackedCount(int count) {
    return 'Tem certeza de que deseja EXCLUIR os $count arquivos não rastreados?';
  }

  @override
  String get scmRestoreFilesFromTrash =>
      'Você pode restaurar estes arquivos da lixeira.';

  @override
  String get scmDeleteFile => 'Excluir arquivo';

  @override
  String scmDeleteAllFiles(int count) {
    return 'Excluir todos os $count arquivos';
  }

  @override
  String scmConfirmRestore(String name) {
    return 'Tem certeza de que deseja restaurar \'$name\'?';
  }

  @override
  String scmConfirmRestoreAll(int count) {
    return 'Tem certeza de que deseja restaurar TODOS os $count arquivos?';
  }

  @override
  String scmConfirmDiscard(String name) {
    return 'Tem certeza de que deseja descartar as alterações em \'$name\'?';
  }

  @override
  String scmConfirmDiscardAll(int count) {
    return 'Tem certeza de que deseja descartar TODAS as alterações em $count arquivos?';
  }

  @override
  String get scmRestoreFile => 'Restaurar arquivo';

  @override
  String scmRestoreAllFiles(int count) {
    return 'Restaurar todos os $count arquivos';
  }

  @override
  String get scmDiscardFile => 'Descartar arquivo';

  @override
  String scmDiscardAllFiles(int count) {
    return 'Descartar todos os $count arquivos';
  }

  @override
  String scmDiscardTrackedFiles(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Descartar todos os $count arquivos rastreados',
      one: 'Descartar 1 arquivo rastreado',
    );
    return '$_temp0';
  }

  @override
  String get scmCopyCommitHash => 'Copiar hash do commit';

  @override
  String get scmCopyCommitMessage => 'Copiar mensagem do commit';

  @override
  String get scmIncomingChanges => 'Alterações de entrada';

  @override
  String get scmOutgoingChanges => 'Alterações de saída';

  @override
  String scmCommitDate(
    String month,
    String day,
    String year,
    String hour,
    String minute,
    String period,
  ) {
    String _temp0 = intl.Intl.selectLogic(month, {
      '1': 'janeiro',
      '2': 'fevereiro',
      '3': 'março',
      '4': 'abril',
      '5': 'maio',
      '6': 'junho',
      '7': 'julho',
      '8': 'agosto',
      '9': 'setembro',
      '10': 'outubro',
      '11': 'novembro',
      '12': 'dezembro',
      'other': '$month',
    });
    String _temp1 = intl.Intl.selectLogic(period, {'am': 'AM', 'other': 'PM'});
    return '$day de $_temp0 de $year às $hour:$minute $_temp1';
  }

  @override
  String get gitCheckoutBranchTag => 'Fazer checkout de branch/tag...';

  @override
  String get gitSelectBranchOrTag =>
      'Selecione uma branch ou tag para fazer checkout';

  @override
  String get gitSelectBranchDetached =>
      'Selecione uma branch para fazer checkout no modo desanexado';

  @override
  String get gitCreateBranch => 'Criar nova branch...';

  @override
  String get gitCreateBranchFrom => 'Criar nova branch a partir de...';

  @override
  String get gitCheckoutDetached => 'Fazer checkout desanexado...';

  @override
  String get gitBranches => 'branches';

  @override
  String get gitRemoteBranches => 'branches remotas';

  @override
  String get gitTags => 'tags';

  @override
  String gitRemoteBranchAt(String commit) {
    return 'Branch remota em $commit';
  }

  @override
  String gitTagAt(String commit) {
    return 'Tag em $commit';
  }

  @override
  String get gitSelectRefToBranchFrom =>
      'Selecione uma ref para criar a branch';

  @override
  String get gitBranchName => 'Nome da branch';

  @override
  String get gitProvideBranchName => 'Forneça um nome para a nova branch';

  @override
  String gitBranchExists(String name) {
    return 'A branch \"$name\" já existe';
  }

  @override
  String gitNewBranchWillBe(String name) {
    return 'A nova branch será \"$name\"';
  }

  @override
  String get timelineCopyCommitId => 'Copiar ID do commit';

  @override
  String get timelineNoEditor =>
      'O editor ativo não pode fornecer informações da linha do tempo.';

  @override
  String get timelineNotConfigured =>
      'Nenhuma informação da linha do tempo foi fornecida. O controle de código-fonte não foi configurado.';

  @override
  String timelineLoading(String name) {
    return 'Carregando linha do tempo de $name...';
  }

  @override
  String get timelineNone =>
      'Nenhuma informação da linha do tempo foi fornecida.';

  @override
  String get timelineLoadMore => 'Carregar mais';

  @override
  String timelineYou(String time) {
    return 'Você, $time';
  }

  @override
  String get commonExpandAll => 'Expandir tudo';

  @override
  String get searchTitle => 'Pesquisar';

  @override
  String get searchClearResults => 'Limpar resultados da pesquisa';

  @override
  String searchMatchCase(String keybinding) {
    return 'Diferenciar maiúsculas/minúsculas ($keybinding)';
  }

  @override
  String searchMatchWholeWord(String keybinding) {
    return 'Palavra inteira ($keybinding)';
  }

  @override
  String searchUseRegExp(String keybinding) {
    return 'Usar expressão regular ($keybinding)';
  }

  @override
  String searchPreserveCase(String keybinding) {
    return 'Preservar maiúsculas/minúsculas ($keybinding)';
  }

  @override
  String get searchReplace => 'Substituir';

  @override
  String get searchReplaceAll => 'Substituir tudo';

  @override
  String searchReplaceKeys(String keybinding) {
    return 'Substituir ($keybinding)';
  }

  @override
  String searchReplaceAllKeys(String keybinding) {
    return 'Substituir tudo ($keybinding)';
  }

  @override
  String get searchDismiss => 'Dispensar';

  @override
  String searchDismissKeys(String keybinding) {
    return 'Dispensar ($keybinding)';
  }

  @override
  String get searchCopyAll => 'Copiar tudo';

  @override
  String get searchToggleReplace => 'Alternar substituição';

  @override
  String get searchToggleDetails => 'Alternar detalhes da pesquisa';

  @override
  String get searchFilesToInclude => 'arquivos a incluir';

  @override
  String get searchFilesToExclude => 'arquivos a excluir';

  @override
  String get searchIncludeExample => 'ex.: *.ts, src/**/include';

  @override
  String get searchExcludeExample => 'ex.: *.ts, src/**/exclude';

  @override
  String get searchUseExcludeSettings =>
      'Usar configurações de exclusão e arquivos de ignorar';

  @override
  String get searchLimitHit =>
      'O conjunto de resultados contém apenas um subconjunto de todas as correspondências. Seja mais específico na pesquisa para restringir os resultados.';

  @override
  String searchResultCount(int matches, int files) {
    String _temp0 = intl.Intl.pluralLogic(
      matches,
      locale: localeName,
      other: '$matches resultados',
      one: '1 resultado',
    );
    String _temp1 = intl.Intl.pluralLogic(
      files,
      locale: localeName,
      other: '$files arquivos',
      one: '1 arquivo',
    );
    return '$_temp0 em $_temp1';
  }

  @override
  String searchNoResultsIncludeExclude(String include, String exclude) {
    return 'Nenhum resultado encontrado em \'$include\' excluindo \'$exclude\'';
  }

  @override
  String searchNoResultsInclude(String include) {
    return 'Nenhum resultado encontrado em \'$include\'';
  }

  @override
  String searchNoResultsExclude(String exclude) {
    return 'Nenhum resultado encontrado excluindo \'$exclude\'';
  }

  @override
  String get searchNoResults =>
      'Nenhum resultado encontrado. Revise suas configurações de exclusões e verifique seus arquivos gitignore';

  @override
  String searchOccurrences(int occurrences, int files) {
    String _temp0 = intl.Intl.pluralLogic(
      occurrences,
      locale: localeName,
      other: '$occurrences ocorrências',
      one: '1 ocorrência',
    );
    String _temp1 = intl.Intl.pluralLogic(
      files,
      locale: localeName,
      other: '$files arquivos',
      one: '1 arquivo',
    );
    return '$_temp0 em $_temp1';
  }

  @override
  String searchConfirmReplace(String counts) {
    return 'Substituir $counts?';
  }

  @override
  String searchConfirmReplaceWith(String counts, String value) {
    return 'Substituir $counts por \'$value\'?';
  }

  @override
  String searchReplaced(String counts) {
    return '$counts substituído(s).';
  }

  @override
  String searchReplacedWith(String counts, String value) {
    return '$counts substituído(s) por \'$value\'.';
  }

  @override
  String get extTitle => 'Extensões';

  @override
  String get extTitleInstalled => 'Extensões: instaladas';

  @override
  String get extTitleRecommended => 'Extensões: recomendadas';

  @override
  String get extTitleMarketplace => 'Extensões: Marketplace';

  @override
  String get extFilter => 'Filtrar extensões...';

  @override
  String get extInstalled => 'Instaladas';

  @override
  String get extRecommended => 'Recomendadas';

  @override
  String get extClearSearch => 'Limpar Resultados da Pesquisa de Extensões';

  @override
  String get extSearchPlaceholder => 'Pesquisar Extensões no Marketplace';

  @override
  String get extNoneFound => 'Nenhuma extensão encontrada.';

  @override
  String get extInstall => 'Instalar';

  @override
  String get extUninstall => 'Desinstalar';

  @override
  String get extInstalling => 'Instalando';

  @override
  String get extUninstalling => 'Desinstalando';

  @override
  String get extManage => 'Gerenciar';

  @override
  String get extCopyId => 'Copiar ID da Extensão';

  @override
  String extInstallError(String id, String error) {
    return 'Erro ao instalar a extensão \'$id\'. $error';
  }

  @override
  String extUninstallError(String id, String error) {
    return 'Erro ao desinstalar a extensão \'$id\'. $error';
  }

  @override
  String get extLanguageServer => 'Servidor de linguagem';

  @override
  String extLanguageServerFor(String languages) {
    return 'Servidor de linguagem para $languages';
  }

  @override
  String extMissingRuntime(String id, String runtime) {
    return 'Instalar \'$id\' exige $runtime, que não foi encontrado. Instale $runtime e tente novamente.';
  }

  @override
  String extUnavailable(String id) {
    return '\'$id\' não foi encontrado no PATH e não pode ser instalado automaticamente.';
  }

  @override
  String langStarting(String id) {
    return '$id: iniciando…';
  }

  @override
  String langStartingTooltip(String id) {
    return 'Iniciando $id';
  }

  @override
  String langRunning(String id) {
    return '$id está em execução';
  }

  @override
  String langRestarting(String id) {
    return '$id: reiniciando…';
  }

  @override
  String get langClickToRestart => 'Clique para reiniciar agora';

  @override
  String langFailed(String id) {
    return '$id falhou';
  }

  @override
  String get langClickToRetry => 'Clique para tentar novamente';

  @override
  String langInstallingItem(String id) {
    return 'Instalando $id…';
  }

  @override
  String langInstallingTooltip(String id) {
    return 'Instalando $id';
  }

  @override
  String langNoneFound(String kind) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'definition': 'Nenhuma definição encontrada',
      'typeDefinition': 'Nenhuma definição de tipo encontrada',
      'implementation': 'Nenhuma implementação encontrada',
      'other': 'Nenhuma referência encontrada',
    });
    return '$_temp0';
  }

  @override
  String langNoneFoundFor(String kind, String word) {
    String _temp0 = intl.Intl.selectLogic(kind, {
      'definition': 'Nenhuma definição encontrada para \'$word\'',
      'typeDefinition': 'Nenhuma definição de tipo encontrada para \'$word\'',
      'implementation': 'Nenhuma implementação encontrada para \'$word\'',
      'other': 'Nenhuma referência encontrada para \'$word\'',
    });
    return '$_temp0';
  }

  @override
  String get langReferences => 'Referências';

  @override
  String langReferencesTo(String word) {
    return 'Referências a \'$word\'';
  }

  @override
  String get langDefinitions => 'Definições';

  @override
  String get langTypeDefinitions => 'Definições de Tipo';

  @override
  String get langImplementations => 'Implementações';

  @override
  String get langCantRename => 'O elemento não pode ser renomeado.';

  @override
  String langRenameFailed(String error) {
    return 'Falha ao renomear: $error';
  }

  @override
  String get langNoResult => 'Nenhum resultado.';

  @override
  String get langRenameCancelled =>
      'A renomeação foi cancelada porque o documento foi alterado.';

  @override
  String get langRenameNotApplied => 'Não foi possível aplicar a renomeação.';

  @override
  String get langNoSelectionFormatter =>
      'Nenhum formatador para seleções neste arquivo.';

  @override
  String get langNoFormatter => 'Nenhum formatador para este arquivo.';

  @override
  String langNoFormatterInstall(String id, String language) {
    return 'Nenhum formatador para este arquivo. Instale o servidor de linguagem \'$id\' para formatar arquivos $language.';
  }

  @override
  String get langNoRefactorings => 'Nenhuma refatoração disponível';

  @override
  String get langNoSourceActions => 'Nenhuma ação de origem disponível';

  @override
  String get langNoCodeActions => 'Nenhuma ação de código disponível';

  @override
  String get langCodeActionNotApplied =>
      'Não foi possível aplicar a ação de código.';

  @override
  String get langShowCodeActions => 'Mostrar Ações de Código';

  @override
  String get langLoading => 'Carregando...';

  @override
  String get langNoSuggestions => 'Nenhuma sugestão.';

  @override
  String get langPreferred => 'Preferida';

  @override
  String get langRenameHint => 'Enter para Renomear, Escape para Cancelar';

  @override
  String get symbolsNoEditor =>
      'Para ir a um símbolo, primeiro abra um editor de texto com informações de símbolos.';

  @override
  String get symbolsLoading => 'Carregando símbolos…';

  @override
  String get symbolsNone => 'Nenhum símbolo no editor';

  @override
  String get symbolsNoMatching => 'Nenhum símbolo de editor correspondente';

  @override
  String get outlineTitle => 'ESTRUTURA DE TÓPICOS';

  @override
  String get outlineNoEditor =>
      'O editor ativo não pode fornecer informações de estrutura de tópicos.';

  @override
  String get outlineNoSymbols => 'Nenhum símbolo encontrado no documento.';

  @override
  String get outlineLoading => 'Carregando símbolos do documento…';

  @override
  String get panelProblems => 'PROBLEMAS';

  @override
  String get panelReferences => 'REFERÊNCIAS';

  @override
  String get panelTerminal => 'TERMINAL';

  @override
  String get panelClose => 'Fechar Painel';

  @override
  String get panelTerminalUnavailable => 'O terminal não está disponível.';

  @override
  String get problemsNone => 'Nenhum problema foi detectado no workspace.';

  @override
  String problemsPosition(int line, int column) {
    return '[Ln $line, Col $column]';
  }

  @override
  String referencesPosition(int line, int column) {
    return 'Ln $line, Col $column';
  }

  @override
  String get referencesNone =>
      'Nenhuma referência ainda: use Ir para Referências (⇧F12).';

  @override
  String referencesSummary(String title, int count, int files) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count resultados',
      one: '1 resultado',
    );
    String _temp1 = intl.Intl.pluralLogic(
      files,
      locale: localeName,
      other: '$files arquivos',
      one: '1 arquivo',
    );
    return '$title — $_temp0 em $_temp1';
  }

  @override
  String get termRename => 'Renomear...';

  @override
  String get termKillTerminal => 'Encerrar Terminal';

  @override
  String get termNewTerminal => 'Novo Terminal';

  @override
  String termNewTerminalKeys(String keybinding) {
    return 'Novo Terminal ($keybinding)';
  }

  @override
  String get termLaunchProfile => 'Iniciar Perfil...';

  @override
  String termProfileDefault(String name) {
    return '$name (Padrão)';
  }

  @override
  String get termSelectDefaultProfile => 'Selecionar Perfil Padrão';

  @override
  String get termSelectProfileToCreate =>
      'Selecione o perfil de terminal a criar';

  @override
  String get termChooseDefaultProfile =>
      'Selecione seu perfil de terminal padrão';

  @override
  String get termProfilesGroup => 'perfis';

  @override
  String get termProfilesDetected => 'detectados';

  @override
  String get cmdTerminalNewWithProfile => 'Criar Novo Terminal (Com Perfil)';

  @override
  String get termKill => 'Encerrar';

  @override
  String termKillKeys(String keybinding) {
    return 'Encerrar ($keybinding)';
  }

  @override
  String get termRenameEmpty =>
      'Se nenhum nome for informado, ele será redefinido para o valor padrão';

  @override
  String get termRenameLabel =>
      'Digite o nome do terminal. Pressione Enter para confirmar ou Escape para cancelar.';

  @override
  String get termRerunCommand => 'Executar Comando Novamente';

  @override
  String get termCopyCommand => 'Copiar Comando';

  @override
  String get termCopyOutput => 'Copiar Saída';

  @override
  String get termClear => 'Limpar';

  @override
  String get termPasteAsOneLine => 'Colar em uma linha';

  @override
  String termPasteConfirm(int count) {
    return 'Tem certeza de que deseja colar $count linhas de texto no terminal?';
  }

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonDontSave => 'Não Salvar';

  @override
  String wbConfirmSave(String name) {
    return 'Deseja salvar as alterações feitas em $name?';
  }

  @override
  String wbHeadNotAvailable(String name) {
    return 'A versão HEAD de \"$name\" não está disponível.';
  }

  @override
  String wbRecommendServer(String id, String language) {
    return 'Deseja instalar o servidor de linguagem recomendado \'$id\' para a linguagem $language?';
  }

  @override
  String get wbDontShowAgainServer =>
      'Não Mostrar Novamente para este Servidor de Linguagem';

  @override
  String get wbQuickCommands => 'Digite o nome de um comando para executar.';

  @override
  String get wbQuickSymbols => 'Digite o nome de um símbolo para ir até ele.';

  @override
  String get wbQuickFiles =>
      'Pesquisar arquivos por nome (acrescente : para ir a uma linha ou > para executar um comando)';

  @override
  String get quickInputEntry =>
      'Pressione \'Enter\' para confirmar sua entrada ou \'Escape\' para cancelar';

  @override
  String quickInputEntryWithPrompt(String prompt) {
    return '$prompt (Pressione \'Enter\' para confirmar ou \'Escape\' para cancelar)';
  }

  @override
  String wbChordWaiting(String chord) {
    return '($chord) foi pressionado. Aguardando a segunda tecla do acorde...';
  }

  @override
  String wbChordNotCommand(String chord, String keypress) {
    return 'A combinação de teclas ($chord, $keypress) não é um comando.';
  }

  @override
  String get wbExplorer => 'Explorador';

  @override
  String get wbSearchFiles => 'Pesquisar arquivos';

  @override
  String wbPendingChanges(int count) {
    return '$count alterações pendentes';
  }

  @override
  String get wbOutline => 'Estrutura de Tópicos';

  @override
  String get wbTimeline => 'Linha do Tempo';

  @override
  String get wbPinTimeline => 'Fixar a Linha do Tempo Atual';

  @override
  String get wbUnpinTimeline => 'Desafixar a Linha do Tempo Atual';

  @override
  String get wbNoProblems => 'Nenhum Problema';

  @override
  String wbProblemCounts(int errors, int warnings) {
    return 'Erros: $errors, Avisos: $warnings';
  }

  @override
  String wbProblemCountsInfos(int errors, int warnings, int infos) {
    return 'Erros: $errors, Avisos: $warnings, Informações: $infos';
  }

  @override
  String wbSelectedCount(int count) {
    return '($count selecionados)';
  }

  @override
  String get wbGoToLineColumn => 'Ir para Linha/Coluna';

  @override
  String wbSpaces(int size) {
    return 'Espaços: $size';
  }

  @override
  String wbTabSize(int size) {
    return 'Tamanho da Tabulação: $size';
  }

  @override
  String get wbIndentation => 'Indentação';

  @override
  String get wbEncoding => 'Codificação';

  @override
  String get wbEolMixed => 'Misto';

  @override
  String get wbSelectEol => 'Selecionar Sequência de Fim de Linha';

  @override
  String get wbEditorReadOnly => 'O editor de código ativo é somente leitura.';

  @override
  String get wbLanguageMode => 'Modo de Linguagem';

  @override
  String get shownImage => 'Imagem';

  @override
  String get shownReadOnly => 'Somente leitura';

  @override
  String get languageModeAuto => 'Detectar Automaticamente';

  @override
  String get languageModePlaceholder => 'Selecionar Modo de Linguagem';

  @override
  String get languageModeChange => 'Alterar Modo de Linguagem';

  @override
  String get editorCommandPalette => 'Paleta de Comandos...';

  @override
  String get editorStartTyping => 'Comece a digitar…';

  @override
  String editorEditLanguage(String language) {
    return 'Editar $language…';
  }

  @override
  String get workspaceClosePane => 'Fechar painel';

  @override
  String get workspaceLoadingProjects => 'Carregando projetos…';

  @override
  String get workspaceDesktopOnly =>
      'Os agentes são executados no app para desktop';

  @override
  String get workspaceDesktopOnlyDetail =>
      'O Claude Code é executado como um processo local, que um navegador não consegue iniciar.';

  @override
  String get workspaceOpenProjectFolder => 'Abrir uma pasta de projeto';

  @override
  String get workspaceOpenProjectFolderDetail =>
      'As sessões do Claude Code dela aparecem na barra lateral; novos agentes são executados nela.';

  @override
  String settingsFileError(String file, String error) {
    return 'Não foi possível aplicar $file: $error. O que foi lido por último dele continua em vigor até que seja corrigido.';
  }

  @override
  String get cmdLastEditorInGroup => 'Abrir Último Editor no Grupo';

  @override
  String get cmdToggleFormatOnSave => 'Alternar Formatação ao Salvar';

  @override
  String get cmdToggleGitBlameEditorDecoration =>
      'Alternar Decoração do Git Blame no Editor';

  @override
  String get kbSourceDefault => 'Padrão';

  @override
  String get kbSourceUser => 'Usuário';

  @override
  String get kbKeymap => 'Mapa de Teclas';

  @override
  String kbKeymapLabel(String name) {
    return 'Mapa de Teclas: $name';
  }

  @override
  String get kbNone => 'Nenhum';

  @override
  String get kbImport => 'Importar do VS Code/Cursor…';

  @override
  String kbWhenNotParse(String error) {
    return 'A cláusula when não pôde ser interpretada ($error): este atalho nunca é aplicado.';
  }

  @override
  String kbUnknownContextKeys(int count, String keys) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'O BaoCode não conhece as chaves de contexto $keys: este atalho nunca é aplicado.',
      one:
          'O BaoCode não conhece a chave de contexto $keys: este atalho nunca é aplicado.',
    );
    return '$_temp0';
  }

  @override
  String kbChangeFailed(String error) {
    return 'Não foi possível alterar os atalhos de teclado ($error). Abra keybindings.json e verifique se há erros.';
  }

  @override
  String get kbCopyCommandId => 'Copiar ID do Comando';

  @override
  String get kbCopyCommandTitle => 'Copiar Título do Comando';

  @override
  String get kbChangeKeybindingEllipsis => 'Alterar Atalho de Teclado…';

  @override
  String get kbAddKeybindingEllipsis => 'Adicionar Atalho de Teclado…';

  @override
  String get kbChangeKeybinding => 'Alterar Atalho de Teclado';

  @override
  String get kbAddKeybinding => 'Adicionar Atalho de Teclado';

  @override
  String get kbRemoveKeybinding => 'Remover Atalho de Teclado';

  @override
  String get kbResetKeybinding => 'Redefinir Atalho de Teclado';

  @override
  String get kbChangeWhen => 'Alterar Expressão When';

  @override
  String get kbShowSame => 'Mostrar Mesmos Atalhos de Teclado';

  @override
  String get kbRecordingPlaceholder =>
      'Gravando Teclas. Pressione Escape para sair';

  @override
  String get kbSearchPlaceholder =>
      'Digite para pesquisar nos atalhos de teclado';

  @override
  String get kbSearchLabel => 'Pesquisar atalhos de teclado';

  @override
  String kbRecordKeys(String keybinding) {
    return 'Gravar Teclas ($keybinding)';
  }

  @override
  String get kbRecordingKeys => 'Gravando Teclas';

  @override
  String get kbColumnCommand => 'Comando';

  @override
  String get kbColumnKeybinding => 'Atalho de Teclado';

  @override
  String get kbColumnWhen => 'When';

  @override
  String get kbColumnSource => 'Origem';

  @override
  String get kbWhenLabel => 'Expressão when';

  @override
  String get kbNoneFound => 'Nenhum atalho de teclado encontrado';

  @override
  String kbCannotReadKey(String key) {
    return 'O BaoCode não consegue ler a tecla “$key”: este atalho nunca é aplicado.';
  }

  @override
  String get kbNotSupported => 'Não suportado';

  @override
  String get kbNotSupportedHover =>
      'O BaoCode não tem este comando: o atalho é mantido, mas não faz nada.';

  @override
  String get kbPressKeys =>
      'Pressione a combinação de teclas desejada e depois pressione Enter.';

  @override
  String get kbChordTo => 'acorde para';

  @override
  String kbExistingCommands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comandos existentes têm este atalho de teclado',
      one: '1 comando existente tem este atalho de teclado',
    );
    return '$_temp0';
  }

  @override
  String get dataDirFullPath => 'Escolha um caminho completo.';

  @override
  String get dataDirInUse => 'Esta é a pasta em uso.';

  @override
  String get dataDirInsideCurrent =>
      'A nova pasta não pode ficar dentro da pasta em uso.';

  @override
  String get dataDirContainsCurrent =>
      'A nova pasta não pode conter a pasta em uso.';

  @override
  String dataDirCannotMake(String error) {
    return 'Não foi possível criar a pasta: $error';
  }

  @override
  String dataDirNotThere(String path) {
    return 'A pasta $path não existe.';
  }

  @override
  String dataDirNotFolder(String path) {
    return '$path não é uma pasta.';
  }

  @override
  String dataDirNotWritable(String path) {
    return 'Não é possível gravar arquivos em $path.';
  }

  @override
  String get dataDirRevealInFileExplorer => 'Mostrar no File Explorer';

  @override
  String get dataDirRevealInFileManager => 'Mostrar no Gerenciador de Arquivos';

  @override
  String get dataDirChecking => 'Verificando a pasta…';

  @override
  String get dataDirAlreadyHolds => 'A pasta já contém dados do BaoCode';

  @override
  String get dataDirMoveBack =>
      'Mover os dados do BaoCode de volta para a pasta padrão?';

  @override
  String get dataDirMoveHere => 'Mover os dados do BaoCode para esta pasta?';

  @override
  String get dataDirUseAsIsDetail =>
      'Após reiniciar, o BaoCode usa os dados que estão lá como estão; nada é copiado, e a pasta atual mantém os seus.';

  @override
  String get dataDirCopyDetail =>
      'O BaoCode copia para lá suas configurações, atalhos de teclado, servidores de linguagem e estado, e usa essa pasta após reiniciar.';

  @override
  String get dataDirOtherFiles =>
      'A pasta contém outros arquivos: eles permanecem, ao lado dos do próprio BaoCode.';

  @override
  String get dataDirUseItsData => 'Usar os Dados Dela';

  @override
  String get dataDirCopyAndSwitch => 'Copiar e Trocar';

  @override
  String get dataDirCopying => 'Copiando…';

  @override
  String dataDirCopyingProgress(int done, int total) {
    return 'Copiando… $done de $total arquivos';
  }

  @override
  String dataDirMoveFailed(String error) {
    return 'Não foi possível mover os dados: $error';
  }

  @override
  String dataDirMoveInUse(String path) {
    return '$path está em uso por outro programa. Feche esse programa e tente novamente.';
  }

  @override
  String get dataDirRestartTitle =>
      'Reinicie o BaoCode para usar a nova pasta de dados';

  @override
  String dataDirRestartDetail(String current, String next) {
    return 'O BaoCode continua usando $current até reiniciar. A próxima inicialização usa $next e oferece remover o que sobrou na pasta antiga.';
  }

  @override
  String get dataDirTheNewFolder => 'a nova pasta';

  @override
  String get quitConfirmMessage => 'Sair do BaoCode?';

  @override
  String get quitConfirmDetail =>
      'Os agentes e terminais em execução serão interrompidos.';

  @override
  String get quitConfirmQuit => 'Sair';

  @override
  String get dataDirQuitNow => 'Sair Agora';

  @override
  String get dataDirLater => 'Depois';

  @override
  String dataDirSetByEnv(String variable) {
    return 'Definida pela variável de ambiente $variable.';
  }

  @override
  String dataDirSetIn(String file) {
    return 'Definida em $file.';
  }

  @override
  String get dataDirDefaultLocation => 'O local padrão.';

  @override
  String dataDirTemporaryDefault(String file) {
    return 'O local padrão, somente desta vez: a pasta definida em $file não está disponível.';
  }

  @override
  String get dataDirTitle => 'Pasta de Dados';

  @override
  String get dataDirDescription =>
      'Onde o BaoCode guarda suas configurações, atalhos de teclado, servidores de linguagem e seu próprio estado. Outros programas também guardam arquivos lá (os caches da web view); o BaoCode nunca move nem remove esses arquivos.';

  @override
  String get dataDirCurrentFolder => 'Pasta atual';

  @override
  String get dataDirNewFolder => 'Nova pasta';

  @override
  String dataDirAfterRestart(String path) {
    return 'Após reiniciar: $path';
  }

  @override
  String get dataDirChange => 'Alterar…';

  @override
  String get dataDirResetDefault => 'Redefinir para o Padrão';

  @override
  String dataDirEnvDecides(String variable) {
    return '$variable define a pasta; remova-a para escolher uma aqui.';
  }

  @override
  String dataDirCannotWritePointer(String file, String error) {
    return 'Não é possível gravar $file: $error';
  }

  @override
  String get dataDirSettingUnreadable =>
      'Não é possível ler a configuração da pasta de dados do BaoCode';

  @override
  String get dataDirCannotWrite =>
      'O BaoCode não consegue gravar em sua pasta de dados';

  @override
  String get dataDirUnavailable =>
      'A pasta de dados do BaoCode não está disponível';

  @override
  String dataDirWhereEnv(String variable) {
    return 'Ela é definida pela variável de ambiente $variable.';
  }

  @override
  String dataDirWhereFixPointer(String file) {
    return 'Corrija ou exclua $file e tente novamente; o BaoCode só o altera se você escolher outra pasta.';
  }

  @override
  String dataDirWherePointer(String file) {
    return 'Ela é definida em $file. Se estiver em uma unidade que não está conectada, conecte-a e tente novamente.';
  }

  @override
  String dataDirDefaultIs(String path) {
    return 'A pasta padrão é $path.';
  }

  @override
  String get dataDirRetry => 'Tentar Novamente';

  @override
  String get dataDirUseDefaultOnce => 'Usar a Pasta Padrão Desta Vez';

  @override
  String get dataDirChooseAnother => 'Escolher Outra Pasta…';

  @override
  String get dataDirRemoveOldTitle =>
      'Remover os dados que o BaoCode deixou na pasta anterior?';

  @override
  String dataDirRemoveOldDetail(String current, String items) {
    return 'O BaoCode agora guarda seus dados em $current. Somente os itens dele são removidos da pasta anterior ($items); a pasta e tudo mais nela permanecem.';
  }

  @override
  String get dataDirRemove => 'Remover';

  @override
  String get dataDirKeep => 'Manter';

  @override
  String get dataDirRemoveOldInUse =>
      'Alguns dos dados antigos não puderam ser removidos';

  @override
  String dataDirRemoveOldInUseDetail(String items) {
    return 'Os arquivos em $items estão em uso, talvez por outro programa. Todo o restante foi removido; o BaoCode oferece remover o que sobrou na próxima inicialização.';
  }

  @override
  String get impTitle => 'Importar Atalhos de Teclado';

  @override
  String get impImport => 'Importar';

  @override
  String get impNothingFound =>
      'Nenhum atalho de teclado ou mapa de teclas do Visual Studio Code, Cursor, Windsurf ou VSCodium foi encontrado.';

  @override
  String get impKeybindingsFrom => 'Atalhos de teclado de';

  @override
  String impKeybindingCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atalhos de teclado',
      one: '1 atalho de teclado',
    );
    return '$_temp0';
  }

  @override
  String get impImportAs => 'Importar como';

  @override
  String get impMerge => 'Mesclar com meus atalhos de teclado';

  @override
  String get impMergeDetail => 'Adiciona os que você não tem depois dos seus.';

  @override
  String get impReplace => 'Substituir meus atalhos de teclado';

  @override
  String get impReplaceDetail =>
      'Copia o arquivo como está, inclusive os comentários. O seu é mantido como keybindings.json.bak.';

  @override
  String impAlsoUse(String name) {
    return 'Importar e usar também $name';
  }

  @override
  String impInstalledIn(String products) {
    return 'Instalado em $products';
  }

  @override
  String impImportedFrom(String source) {
    return 'Importado de $source';
  }

  @override
  String impApplied(int supported) {
    return '$supported aplicados';
  }

  @override
  String impAppliedUnsupported(int supported, int unsupported) {
    String _temp0 = intl.Intl.pluralLogic(
      unsupported,
      locale: localeName,
      other: '$unsupported comandos',
      one: '1 comando',
    );
    return '$supported aplicados, $_temp0 ainda não suportados';
  }

  @override
  String impDuplicates(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atalhos de teclado que você já tinha foram ignorados.',
      one: '1 atalho de teclado que você já tinha foi ignorado.',
    );
    return '$_temp0';
  }

  @override
  String impBackup(String path) {
    return 'Seus atalhos de teclado anteriores: $path';
  }

  @override
  String get impNotSupportedYet => 'Ainda não suportados';

  @override
  String get impNotSupportedDetail =>
      'Estes permanecem em keybindings.json e passam a funcionar quando o app tiver os comandos correspondentes.';

  @override
  String impKeymapBuiltIn(String name) {
    return 'Mapa de teclas: $name é integrado e já está em uso.';
  }

  @override
  String impKeymapImported(String name) {
    return 'Mapa de teclas: $name foi importado e já está em uso.';
  }

  @override
  String impKeybindingsError(String error) {
    return 'Não foi possível importar os atalhos de teclado: $error';
  }

  @override
  String impKeymapError(String name, String error) {
    return 'Não foi possível importar $name: $error';
  }

  @override
  String get explorerNoFolderTitle => 'Nenhuma Pasta Aberta';

  @override
  String get explorerNoFolder => 'Você ainda não abriu uma pasta.';

  @override
  String get explorerOpenFolder => 'Abrir Pasta';

  @override
  String get ideSearchOpenFiles => 'Pesquisar arquivos abertos';

  @override
  String get ideWelcomeRecent => 'Recentes';

  @override
  String get ideStartRecent => 'Projetos recentes';

  @override
  String ideStartViewAll(int count) {
    return 'Ver todos ($count)';
  }

  @override
  String get ideOpenRecentPlaceholder =>
      'Selecione uma pasta ou arquivo para abrir';

  @override
  String get ideRecentFolders => 'pastas';

  @override
  String get ideRecentFiles => 'arquivos';

  @override
  String get ideNoRecent => 'Nenhuma pasta ou arquivo aberto recentemente';

  @override
  String get ideClearRecentConfirm =>
      'Deseja limpar todos os arquivos e pastas abertos recentemente?';

  @override
  String get ideClearRecentDetail => 'Esta ação é irreversível!';

  @override
  String get ideClearRecent => 'Limpar';

  @override
  String get ideChatNoFolder =>
      'Abra um arquivo ou uma pasta para conversar sobre ele com um agente.';

  @override
  String ideCannotOpen(String path, String error) {
    return 'Não é possível abrir $path: $error';
  }

  @override
  String get cmdNewUntitledFile => 'Novo Arquivo de Texto';

  @override
  String get cmdOpenFile => 'Abrir Arquivo...';

  @override
  String get cmdOpenFolder => 'Abrir Pasta...';

  @override
  String get cmdOpenRecent => 'Abrir Recente...';

  @override
  String get cmdSaveAs => 'Salvar Como...';

  @override
  String get cmdMarkdownShowPreview => 'Abrir Visualização';

  @override
  String get cmdMarkdownShowSource => 'Mostrar Origem';

  @override
  String get cmdCloseFolder => 'Fechar Pasta';

  @override
  String get cmdClearRecentlyOpened => 'Limpar Abertos Recentemente...';

  @override
  String cmdInstallShellCommand(String name) {
    return 'Instalar o comando \'$name\' no PATH';
  }

  @override
  String cmdUninstallShellCommand(String name) {
    return 'Desinstalar o comando \'$name\' do PATH';
  }

  @override
  String get cmdCategoryWorkspaces => 'Workspaces';

  @override
  String get cmdCategoryShellCommand => 'Comando de Shell';

  @override
  String shellCommandInstalled(String name) {
    return 'Comando de shell \'$name\' instalado com sucesso no PATH.';
  }

  @override
  String shellCommandUninstalled(String name) {
    return 'Comando de shell \'$name\' desinstalado com sucesso do PATH.';
  }

  @override
  String shellCommandOccupied(String path, String name) {
    return '$path já executa o comando \'$name\' de outro app. Substituí-lo pelo do BaoCode?';
  }

  @override
  String get shellCommandReplace => 'Substituir';

  @override
  String shellCommandFailed(String name, String error) {
    return 'Não foi possível instalar o comando de shell \'$name\': $error';
  }

  @override
  String shellCommandUninstallFailed(String name, String error) {
    return 'Não foi possível desinstalar o comando de shell \'$name\': $error';
  }

  @override
  String get generalSettingsMainWindow => 'Abrir na Inicialização';

  @override
  String get generalSettingsMainWindowDescription =>
      'O que o BaoCode abre: os agentes ou as janelas do IDE (conforme Restaurar Janelas), nunca os dois. Por padrão, onde estava quando foi fechado pela última vez.';

  @override
  String generalSettingsMainWindowLabel(String name) {
    return 'Abrir na Inicialização: $name';
  }

  @override
  String get generalSettingsMainWindowChat => 'Sempre Agente';

  @override
  String get generalSettingsMainWindowIde => 'Sempre IDE';

  @override
  String get generalSettingsMainWindowLast => 'Onde você parou';

  @override
  String get generalSettingsWindows => 'Janelas';

  @override
  String get generalSettingsIde => 'IDE Rápido';

  @override
  String get explorerExcludeSetting => 'Arquivos e pastas ocultos';

  @override
  String get explorerExcludeSettingDescription =>
      'Arquivos e pastas que o explorador não mostra, separados por vírgula: um nome (`node_modules`, `*.log`) corresponde em qualquer lugar, um caminho (`build/**`, `src/generated`) corresponde dentro da pasta.';

  @override
  String get explorerExcludeSettingPlaceholder =>
      'ex.: .git, node_modules, *.log';

  @override
  String get claudePathSetting => 'Caminho';

  @override
  String get claudePathSettingDescription =>
      'Vazio: o Claude Code mais recente nesta máquina, baixado se não houver nenhum. Um caminho: sempre aquele, por exemplo um que você compilou. (claudeCode.path)';

  @override
  String get claudePathSettingHint => 'Automático';

  @override
  String get claudePathChecking => 'Verificando…';

  @override
  String claudePathInUse(String path, String version) {
    return 'Em uso: $path ($version)';
  }

  @override
  String claudePathInUseUnknown(String path) {
    return 'Em uso: $path';
  }

  @override
  String claudePathInUseDownloaded(String version) {
    return 'Em uso: Claude Code $version, baixado pelo BaoCode';
  }

  @override
  String get claudePathMissing =>
      'Nenhum encontrado ainda: o Claude Code é baixado quando a primeira conversa começa.';

  @override
  String get generalSettingsIdeWindows => 'Janelas do IDE Rápido';

  @override
  String get generalSettingsIdeWindowsDescription =>
      'Onde o IDE Rápido abre: na janela principal no lugar do chat, uma pasta por vez, ou em janelas próprias, uma por pasta (Nova Janela, ⇧⌘N / Ctrl+Shift+N, abre uma vazia). Aplica-se imediatamente. (window.ideWindows)';

  @override
  String get generalSettingsIdeWindowsSeparate => 'Janelas separadas';

  @override
  String get generalSettingsIdeWindowsMain => 'Na janela principal';

  @override
  String generalSettingsWindowLabel(String setting, String name) {
    return '$setting: $name';
  }

  @override
  String get generalSettingsOpenFolders => 'Abrir Pastas em Nova Janela';

  @override
  String get generalSettingsOpenFoldersDescription =>
      'Se uma pasta aberta a partir de uma janela (Abrir Pasta…, Abrir Recente) usa uma nova janela. Por padrão, ela substitui a atual, a menos que ⌘/Ctrl esteja pressionado. (window.openFoldersInNewWindow)';

  @override
  String get generalSettingsOpenFiles => 'Abrir Arquivos em Nova Janela';

  @override
  String get generalSettingsOpenFilesDescription =>
      'Se um arquivo aberto a partir de uma janela usa uma nova janela. Por padrão, ele abre na atual. (window.openFilesInNewWindow)';

  @override
  String get generalSettingsOpenOn => 'Em uma nova janela';

  @override
  String get generalSettingsOpenOff => 'Na janela atual';

  @override
  String get generalSettingsRestoreWindows => 'Restaurar Janelas';

  @override
  String get generalSettingsRestoreWindowsDescription =>
      'As janelas do IDE que abrem novamente na inicialização, onde estavam. (window.restoreWindows)';

  @override
  String get generalSettingsRestoreAll => 'Todas as janelas';

  @override
  String get generalSettingsRestoreOne => 'A última janela ativa';

  @override
  String get generalSettingsRestoreFolders => 'Janelas com uma pasta';

  @override
  String get generalSettingsRestoreNone => 'Nenhuma';

  @override
  String get generalSettingsNewWindowDimensions => 'Tamanho da Nova Janela';

  @override
  String get generalSettingsNewWindowDimensionsDescription =>
      'O tamanho de uma nova janela. (window.newWindowDimensions)';

  @override
  String get generalSettingsDimensionsDefault => 'Padrão';

  @override
  String get generalSettingsDimensionsInherit => 'Como a última janela ativa';

  @override
  String get generalSettingsDimensionsMaximized => 'Maximizada';

  @override
  String get generalSettingsDimensionsFullscreen => 'Tela cheia';

  @override
  String get generalSettingsConfirmBeforeClose => 'Confirmar Antes de Fechar';

  @override
  String get generalSettingsConfirmBeforeCloseDescription =>
      'Se o fechamento de uma janela pede confirmação antes, mesmo sem nada não salvo. (window.confirmBeforeClose)';

  @override
  String get generalSettingsConfirmNever => 'Nunca';

  @override
  String get generalSettingsConfirmKeyboard => 'Quando fechada pelo teclado';

  @override
  String get generalSettingsConfirmAlways => 'Sempre';

  @override
  String get cmdNewWindow => 'Nova Janela';

  @override
  String get cmdCloseWindow => 'Fechar Janela';

  @override
  String get cmdSwitchWindow => 'Alternar Janela...';

  @override
  String get cmdShowChatWindow => 'Mostrar Janela de Chat';

  @override
  String get windowChatTitle => 'Chat';

  @override
  String get windowWelcomeTitle => 'Boas-vindas';

  @override
  String get windowConfirmClose => 'Tem certeza de que deseja fechar a janela?';

  @override
  String get windowTerminateTerminals =>
      'Deseja encerrar os processos em execução nos terminais da janela?';

  @override
  String get windowTerminate => 'Encerrar';

  @override
  String windowSaveChanges(int count) {
    return 'Deseja salvar as alterações nos seguintes $count arquivos?';
  }

  @override
  String get windowSaveAll => 'Salvar Tudo';

  @override
  String get windowCurrent => 'Atual';

  @override
  String get windowSwitchPlaceholder => 'Selecione uma janela para alternar';

  @override
  String get windowCycle => 'Percorrer Janelas';

  @override
  String get windowMenuWindows => 'Janelas';

  @override
  String get windowOpened => 'Abertas';

  @override
  String get generalSettingsShellCommand => 'Comando de Shell';

  @override
  String generalSettingsShellCommandDescription(String location) {
    return 'Abra arquivos e pastas no BaoCode a partir de um terminal: \'code <path>\'. Instalado em $location.';
  }

  @override
  String get generalSettingsShellCommandInstalled => 'Instalado';

  @override
  String get generalSettingsShellCommandNotInstalled => 'Não instalado';

  @override
  String get generalSettingsShellCommandOccupied =>
      'O comando de outro app está instalado';

  @override
  String get generalSettingsShellCommandInstall => 'Instalar';

  @override
  String get generalSettingsShellCommandUninstall => 'Desinstalar';

  @override
  String get menuMore => 'Mais…';

  @override
  String get sidebarSearch => 'Pesquisar';

  @override
  String get sidebarCustomize => 'Skills';

  @override
  String get sidebarOpenProject => 'Abrir Projeto';

  @override
  String get palettePlaceholder =>
      'Pesquisar agentes, conversas, arquivos, ações…';

  @override
  String get paletteFilterAll => 'Tudo';

  @override
  String get paletteFilterAgents => 'Agentes';

  @override
  String get paletteFilterFiles => 'Arquivos';

  @override
  String get paletteFilterActions => 'Ações';

  @override
  String get paletteFilterSettings => 'Configurações';

  @override
  String get paletteRecentAgents => 'Agentes Recentes';

  @override
  String get paletteRecentActions => 'Ações Recentes';

  @override
  String get paletteMessages => 'Nas Conversas';

  @override
  String paletteFilesIn(String project) {
    return 'Arquivos em $project';
  }

  @override
  String get paletteSearching => 'Pesquisando…';

  @override
  String get paletteNoResults => 'Nenhum resultado';

  @override
  String get paletteNoProject => 'Abra um projeto para pesquisar seus arquivos';

  @override
  String get paletteTypeToSearch => 'Digite para pesquisar';

  @override
  String get paletteHintSelect => 'Selecionar';

  @override
  String get paletteHintOpen => 'Abrir';

  @override
  String get paletteHintChangeFilter => 'Alterar Filtro';

  @override
  String get customizeTitle => 'Personalizar';

  @override
  String get customizeSearchPlaceholder => 'Pesquisar plugins, skills, MCPs…';

  @override
  String get customizeKindPlugins => 'Plugins';

  @override
  String get customizeKindMcps => 'MCPs';

  @override
  String get customizeKindSkills => 'Skills';

  @override
  String get customizeKindSubagents => 'Subagentes';

  @override
  String get customizeKindRules => 'Regras';

  @override
  String get customizeKindCommands => 'Comandos';

  @override
  String get customizeKindHooks => 'Hooks';

  @override
  String get customizeScopeUser => 'Usuário';

  @override
  String get customizeScopeProject => 'Projeto';

  @override
  String get customizeScopeLocal => 'Local';

  @override
  String get customizeScopePlugin => 'Instalado';

  @override
  String get customizeUserOnly => 'Somente usuário';

  @override
  String get customizeNew => 'Novo';

  @override
  String get customizeEmpty => 'Nada aqui ainda';

  @override
  String get customizeNoMatches => 'Nenhuma correspondência';

  @override
  String get customizeUnsupported =>
      'Personalizar o Claude Code exige o app para desktop.';

  @override
  String get customizeSave => 'Salvar';

  @override
  String get customizeRevert => 'Reverter';

  @override
  String get customizeSaved => 'Salvo';

  @override
  String get customizeUnsaved => 'Alterações não salvas';

  @override
  String get customizeEdit => 'Editar';

  @override
  String get customizeReadOnly =>
      'Somente leitura: o próprio Claude Code mantém este arquivo.';

  @override
  String get customizeEnabled => 'Ativado';

  @override
  String get customizeDisabled => 'Desativado';

  @override
  String get customizeBack => 'Voltar';

  @override
  String get customizeClose => 'Fechar Personalização';

  @override
  String customizeDeleteTitle(String name) {
    return 'Excluir $name?';
  }

  @override
  String customizeDeleteMessage(String path) {
    return 'Isso remove $path e não pode ser desfeito.';
  }

  @override
  String customizeNewTitle(String kind) {
    return 'Novo $kind';
  }

  @override
  String get customizeNameHint => 'nome';

  @override
  String get customizeNameInvalid =>
      'Começa com uma letra ou dígito; sem espaços nem / \\ : * ? \" < > | (até 64)';

  @override
  String get customizeNameUnofficial =>
      'Oficialmente apenas minúsculas, dígitos e -; o claude.ai pode rejeitar';

  @override
  String get customizeNameTaken => 'Já existe um com esse nome';

  @override
  String get customizeCreate => 'Criar';

  @override
  String customizeLoadFailed(String error) {
    return 'Não foi possível ler: $error';
  }

  @override
  String customizeSaveFailed(String error) {
    return 'Não foi possível salvar: $error';
  }

  @override
  String get settingsBack => 'Voltar';

  @override
  String get settingsSearch => 'Pesquisar Configurações';

  @override
  String get customizeScopeSynced => 'Sincronizado do claude.ai';

  @override
  String get customizeSyncedReadOnly =>
      'Somente leitura: sincronizado do claude.ai, que sobrescreveria as alterações feitas aqui.';

  @override
  String customizeEditFile(String file) {
    return 'Editar $file';
  }

  @override
  String get customizeEmptyPlugins =>
      'Nenhum instalado. Instale plugins com /plugin no Claude Code.';

  @override
  String get customizeEmptyMcpsUser =>
      'Nenhum ainda. Adicione um com: claude mcp add --scope user <name> -- <command>';

  @override
  String get customizeEmptyMcpsLocal =>
      'Nenhum ainda. Adicione um com claude mcp add, executado no projeto.';

  @override
  String get customizeEmptyMcpsProject =>
      'Nenhum ainda. Servidores compartilhados com o projeto ficam no .mcp.json dele.';

  @override
  String customizeEmptyHooks(String file) {
    return 'Nenhum ainda. Hooks ficam em \"hooks\" no $file.';
  }

  @override
  String get customizeConnectorReadOnly =>
      'Somente leitura: um conector do claude.ai, gerenciado nas configurações do claude.ai, em Conectores.';

  @override
  String get settingsSectionModels => 'Modelos';

  @override
  String get modelsTitle => 'Modelos';

  @override
  String get modelsDefault => 'Modelo Padrão para Novas Sessões';

  @override
  String get modelsDefaultDescription =>
      'Se não definido, uma nova sessão começa com o último modelo escolhido.';

  @override
  String get modelsDefaultLast => 'Último escolhido';

  @override
  String modelsChoiceLabel(String label, String value) {
    return '$label: $value';
  }

  @override
  String get modelsBuiltinName => 'Claude Code (configuração desta máquina)';

  @override
  String get modelsBuiltinDefault => 'Padrão do Claude Code';

  @override
  String get modelsBuiltinBadge => 'Integrado';

  @override
  String get modelsBuiltinDescription =>
      'Seu próprio login e configurações, sem alterações';

  @override
  String get modelsProviders => 'Provedores';

  @override
  String modelsEnableProvider(String name) {
    return 'Oferecer $name no seletor de modelos';
  }

  @override
  String get modelsFeaturedWhy => 'Por que estou vendo isto?';

  @override
  String get modelsFeaturedNote =>
      'Estes sites são listados oficialmente pelo BaoCode';

  @override
  String get modelsFeaturedNoteHow =>
      'Adicione a importação com um clique para ser listado também, de graça';

  @override
  String get modelsFeaturedNoteLink => 'Liste Meu Site Também';

  @override
  String modelsImportTitle(String host) {
    return 'Importar um provedor de $host';
  }

  @override
  String get modelsImportProtocol => 'Protocolo';

  @override
  String get modelsImportUrl => 'URL Base';

  @override
  String get modelsImportKeyLabel => 'Chave';

  @override
  String get modelsImportListedBadge => 'Listado oficialmente';

  @override
  String get modelsImportNoKey => 'nenhuma, adicione depois';

  @override
  String modelsImportExisting(String name) {
    return 'Você já tem este provedor: $name.';
  }

  @override
  String get modelsImportNamePlaceholder => 'Nome';

  @override
  String get modelsImportAdd => 'Importar Modelos';

  @override
  String get modelsImportFinish => 'Importar';

  @override
  String get modelsImportWithoutModels => 'Importar Sem Modelos';

  @override
  String get modelsImportPreparing => 'Preparando seus modelos…';

  @override
  String modelsImportUpdateKey(String name) {
    return 'Atualizar a Chave de $name';
  }

  @override
  String modelsImportOpenExisting(String name) {
    return 'Abrir $name';
  }

  @override
  String get modelsImportAsNew => 'Adicionar como Novo Provedor';

  @override
  String get modelsImportInvalid =>
      'Este link de importação não pode ser usado';

  @override
  String get modelsImportInvalidDetail =>
      'Ele precisa de uma URL base (http ou https) e de um protocolo que o BaoCode conheça. Peça um novo link ao site ou adicione o provedor manualmente em Configurações → Modelos.';

  @override
  String get modelsAddProvider => 'Adicionar Provedor';

  @override
  String get modelsNewProviderName => 'Novo Provedor';

  @override
  String get modelsProviderNoUrl => 'Sem URL base';

  @override
  String modelsModelCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count modelos',
      one: '1 modelo',
      zero: 'nenhum modelo',
    );
    return '$_temp0';
  }

  @override
  String get modelsAccounts => 'Contas';

  @override
  String get modelsAccountsDescription =>
      'Entre com o ChatGPT para usar modelos Codex na cota do seu plano. Com várias contas, as solicitações são distribuídas entre elas pelo balanceamento de carga abaixo, e uma sem cota cede a vez à próxima.';

  @override
  String get modelsAccountsNone => 'Nenhuma conta ainda';

  @override
  String modelsAccountCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count contas',
      one: '1 conta',
      zero: 'nenhuma conta',
    );
    return '$_temp0';
  }

  @override
  String get modelsAddAccount => 'Adicionar Conta';

  @override
  String get modelsAddAccountDescription =>
      'Abre a página de login do ChatGPT no navegador.';

  @override
  String get modelsAccountSigningIn => 'Aguardando o login…';

  @override
  String get modelsAccountSigningInDetail =>
      'Conclua o login no navegador. Se ele não abriu, copie o link para ele.';

  @override
  String get modelsAccountCopyLink => 'Copiar Link';

  @override
  String modelsAccountSignInFailed(String error) {
    return 'Falha no login: $error';
  }

  @override
  String get modelsRefreshQuota => 'Atualizar Cota';

  @override
  String get modelsAccountRemove => 'Remover conta';

  @override
  String modelsAccountRemoveConfirm(String name) {
    return 'Remover “$name”?';
  }

  @override
  String get modelsAccountRemoveDetail =>
      'O login dela é excluído desta máquina.';

  @override
  String modelsAccountEnable(String name) {
    return 'Usar $name';
  }

  @override
  String get modelsAccountDisabled => 'Desativada';

  @override
  String get modelsAccountLimited => 'Sem cota';

  @override
  String get modelsAccountQuotaUnknown => 'Cota ainda desconhecida';

  @override
  String get modelsQuotaShortWindow => 'Janela curta';

  @override
  String get modelsQuotaLongWindow => 'Janela longa';

  @override
  String modelsQuotaLastUpdated(String time) {
    return 'Última atualização $time';
  }

  @override
  String get modelsQuotaWeek => 'Semanal';

  @override
  String modelsQuotaHours(int count) {
    return '${count}h';
  }

  @override
  String modelsQuotaDays(int count) {
    return '${count}d';
  }

  @override
  String modelsQuotaUsed(int percent) {
    return '$percent% usado';
  }

  @override
  String modelsQuotaRemaining(int percent) {
    return '$percent% restante';
  }

  @override
  String quotaBarWindowLeft(String window, int percent) {
    return '$window $percent% restante';
  }

  @override
  String quotaBarAvailable(int count, int total) {
    return '$count/$total disponíveis';
  }

  @override
  String quotaBarAllOut(String time) {
    return 'Todas as contas sem cota · volta $time';
  }

  @override
  String quotaBarBackAt(String time) {
    return 'Sem cota · volta $time';
  }

  @override
  String get quotaBarNone => 'Nenhuma conta pode ser usada';

  @override
  String get quotaBarThisChat => 'Este chat';

  @override
  String get quotaBarRefresh => 'Atualizar Cota';

  @override
  String modelsQuotaResetsIn(String time) {
    return 'renova em $time';
  }

  @override
  String modelsQuotaResetsAt(String time) {
    return 'renova $time';
  }

  @override
  String modelsQuotaCredits(String credits) {
    return 'Créditos: $credits';
  }

  @override
  String modelsDurationMinutes(int count) {
    return '$count min';
  }

  @override
  String modelsDurationHours(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String get modelsBalance => 'Balanceamento de Carga';

  @override
  String get modelsBalanceRoundRobin => 'Round Robin';

  @override
  String get modelsBalanceRoundRobinDescription =>
      'Cada nova conversa vai para a próxima conta e permanece nela (o cache está lá).';

  @override
  String get modelsBalanceFillFirst => 'Preencher Primeiro';

  @override
  String get modelsBalanceFillFirstDescription =>
      'Usa a primeira conta até ficar sem cota, depois a próxima.';

  @override
  String get modelsBalanceMostRemaining => 'Mais Restante';

  @override
  String get modelsBalanceMostRemainingDescription =>
      'Cada nova conversa vai para a conta com mais cota restante.';

  @override
  String get modelsAccountPortBusy =>
      'A porta 1455, para onde o login retorna, está sendo usada por outro programa (um proxy no Docker ou o Codex CLI fazendo login). Faça o login no navegador mesmo assim: a página em que ele terminar falhará ao carregar ou mostrará outra coisa. Copie o endereço completo dessa página e cole abaixo.';

  @override
  String get modelsAccountCallback => 'Endereço após o login';

  @override
  String get modelsAccountCallbackDetail =>
      'Se o navegador não voltar sozinho, cole o endereço em que ele terminou.';

  @override
  String get modelsProtocolAnthropic => 'Compatível com Anthropic';

  @override
  String get modelsConnection => 'Conexão';

  @override
  String get modelsName => 'Nome';

  @override
  String get modelsIcon => 'Ícone';

  @override
  String get modelsIconDescription =>
      'Encabeça seus modelos no seletor de modelos: o logo de um fabricante, o ícone do site ou uma imagem sua. Se não definido, o logo do fabricante indicado pela URL base.';

  @override
  String get modelsIconChange => 'Alterar Ícone';

  @override
  String get modelsProtocol => 'Protocolo';

  @override
  String get modelsProtocolDescription =>
      'As APIs da OpenAI passam pelo proxy local, que traduz as solicitações do Claude Code e as respostas.';

  @override
  String get modelsBaseUrl => 'URL Base';

  @override
  String get modelsBaseUrlAnthropicHint =>
      'Sem /v1, como ANTHROPIC_BASE_URL: o Claude Code adiciona /v1/messages.';

  @override
  String get modelsBaseUrlOpenAIHint =>
      'Como o provedor documenta; sem uma versão no caminho (…/v1), /v1 é adicionado.';

  @override
  String get modelsApiKey => 'Chave de API';

  @override
  String get modelsApiKeyDescription =>
      'Guardada no chaveiro do sistema, não no settings.json.';

  @override
  String get modelsApiKeyShow => 'Mostrar a chave';

  @override
  String get modelsApiKeyHide => 'Ocultar a chave';

  @override
  String modelsApiKeyError(String error) {
    return 'Não foi possível guardar a chave: $error';
  }

  @override
  String get modelsTest => 'Testar Conexão';

  @override
  String get modelsTesting => 'Conectando…';

  @override
  String modelsTestOk(int count) {
    return 'Conectado: o provedor lista $count modelos.';
  }

  @override
  String modelsTestFailed(String error) {
    return 'Não foi possível conectar: $error';
  }

  @override
  String get modelsModelsGroup => 'Modelos';

  @override
  String get modelsModelsDescription =>
      'Os marcados são oferecidos no seletor de modelos.';

  @override
  String get modelsFetch => 'Buscar do Provedor…';

  @override
  String get modelsAddModel => 'Adicionar Modelo…';

  @override
  String get modelsSearch => 'Pesquisar modelos';

  @override
  String get modelsNone =>
      'Nenhum modelo ainda: busque-os do provedor ou adicione manualmente.';

  @override
  String get modelsNoMatch => 'Nenhum modelo corresponde.';

  @override
  String get modelsMissing => 'Removido do provedor';

  @override
  String get modelsMissingTooltip =>
      'Não é mais listado pelo provedor; mantido até você removê-lo.';

  @override
  String modelsRemoveMissing(int count) {
    return 'Remover os Removidos ($count)';
  }

  @override
  String modelsRemoveMissingConfirm(int count) {
    return 'Remover $count modelos que o provedor não lista mais?';
  }

  @override
  String get modelsCustom => 'Manual';

  @override
  String modelsShowAll(int count) {
    return 'Mostrar Todos ($count)';
  }

  @override
  String get modelsShowChecked => 'Mostrar Apenas Marcados';

  @override
  String get modelsNoneChecked =>
      'Nenhum modelo marcado: mostre todos para marcar alguns.';

  @override
  String get modelsEdit => 'Editar…';

  @override
  String get modelsDuplicate => 'Duplicar…';

  @override
  String get modelsRemove => 'Remover';

  @override
  String get modelsMore => 'Mais Ações';

  @override
  String get modelsTestModel => 'Testar';

  @override
  String get modelsTestModels => 'Testar Todos';

  @override
  String get modelsTestModelFailed => 'Falhou';

  @override
  String modelsTestFirstText(String seconds) {
    return 'Primeiro token ${seconds}s';
  }

  @override
  String modelsTestTotal(String seconds) {
    return 'Total ${seconds}s';
  }

  @override
  String modelsEnableModel(String name) {
    return 'Oferecer $name';
  }

  @override
  String get modelsRoles => 'Funções';

  @override
  String get modelsRolesDescription =>
      'Qual modelo o Claude Code usa para cada parte do seu trabalho. Se não definido, o modelo escolhido assume. Todos, exceto o modelo principal, podem ser de outro provedor: o proxy local do BaoCode envia as solicitações para lá.';

  @override
  String get modelsRoleUnset => 'Não definido';

  @override
  String get modelsRoleMain => 'Modelo Principal';

  @override
  String get modelsRoleMainDescription =>
      'Usado quando o modelo que uma sessão escolheu deste provedor não existe mais.';

  @override
  String get modelsRoleOpus => 'Nível Opus';

  @override
  String get modelsRoleOpusDescription =>
      'ANTHROPIC_DEFAULT_OPUS_MODEL: o que “opus” significa, como no modo Plan.';

  @override
  String get modelsRoleSonnet => 'Nível Sonnet';

  @override
  String get modelsRoleSonnetDescription =>
      'ANTHROPIC_DEFAULT_SONNET_MODEL: o que “sonnet” significa.';

  @override
  String get modelsRoleHaiku => 'Nível Haiku';

  @override
  String get modelsRoleHaikuDescription =>
      'ANTHROPIC_DEFAULT_HAIKU_MODEL: o trabalho em segundo plano do Claude Code e os títulos dos agentes.';

  @override
  String get modelsRoleHaikuWarning =>
      'Se não definido, o trabalho em segundo plano roda no modelo escolhido, que pode ser mais lento e custar mais. Escolha um modelo pequeno e rápido.';

  @override
  String get modelsRoleSubagent => 'Subagentes';

  @override
  String get modelsRoleSubagentDescription =>
      'CLAUDE_CODE_SUBAGENT_MODEL: o modelo em que todo subagente roda, acima do indicado por sua definição ou pela chamada do agente (exceto inherit).';

  @override
  String get modelsRoleMissing =>
      'Este modelo não pertence mais ao provedor: as solicitações a ele falharão.';

  @override
  String get modelsAdvanced => 'Avançado';

  @override
  String get modelsAuth => 'Autenticação';

  @override
  String get modelsAuthDescription =>
      'Como a chave é enviada. Automático: x-api-key para api.anthropic.com, um token bearer nos demais.';

  @override
  String get modelsAuthAuto => 'Automático';

  @override
  String get modelsNonessential => 'Desativar Tráfego Não Essencial';

  @override
  String get modelsNonessentialDescription =>
      'CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC: sem telemetria, relatórios de erro ou verificações de atualização, que provedores diferentes da Anthropic não respondem.';

  @override
  String get modelsPreserveThinking => 'Reenviar Raciocínio';

  @override
  String get modelsPreserveThinkingDescription =>
      'Reenvia o raciocínio do modelo (reasoning_content) em solicitações posteriores, como DeepSeek e outros exigem.';

  @override
  String get modelsPromptCacheKey => 'Chave de Cache de Prompt';

  @override
  String get modelsPromptCacheKeyDescription =>
      'Envia o prompt_cache_key próprio de cada conversa, para que o provedor (ou um relay à frente de vários) encaminhe as solicitações para onde as anteriores estão em cache. Desative para um provedor que rejeita o campo.';

  @override
  String get modelsCodexVersion => 'Versão do Codex';

  @override
  String get modelsCodexVersionDescription =>
      'A versão do Codex CLI com que as solicitações são feitas. O backend só lista modelos compatíveis com essa versão; se faltarem modelos novos, informe uma versão mais recente e atualize a lista de modelos. Deixe vazio para usar o padrão do app.';

  @override
  String get modelsEnv => 'Ambiente Extra';

  @override
  String get modelsEnvDescription =>
      'Um KEY=VALUE por linha, passado ao Claude Code depois das configurações acima.';

  @override
  String get modelsHeaders => 'Cabeçalhos Personalizados';

  @override
  String get modelsHeadersDescription =>
      'Um Name: Value por linha, enviado em toda solicitação a este provedor. Os valores podem usar a variável CLAUDE_SESSION_ID (a sessão desta conversa) e ANTHROPIC_MODEL (o modelo pedido), cada uma entre chaves duplas; no protocolo direto da Anthropic essas duas vão como escritas, então só valores fixos funcionam ali. Cabeçalhos de autenticação (Authorization, x-api-key) são ignorados aqui: a chave é definida acima.';

  @override
  String get modelsHeadersPlaceholder => 'x-session-id: my-session';

  @override
  String get modelsDuplicateProvider => 'Duplicar Provedor';

  @override
  String get modelsDuplicateProviderDescription =>
      'Uma cópia deste provedor, com seus modelos, configurações e chave.';

  @override
  String modelsDuplicateName(String name) {
    return 'Cópia de $name';
  }

  @override
  String get modelsDelete => 'Excluir Provedor';

  @override
  String get modelsDeleteDescription => 'Remove-o, e sua chave do chaveiro.';

  @override
  String modelsDeleteConfirm(String name) {
    return 'Excluir “$name”?';
  }

  @override
  String get modelsDeleteDetail =>
      'As sessões nos modelos dele voltam aos do próprio Claude Code na próxima vez que iniciarem.';

  @override
  String modelsFetchTitle(String name) {
    return 'Modelos de $name';
  }

  @override
  String get modelsFetchLoading => 'Consultando o provedor…';

  @override
  String modelsFetchFailed(String error) {
    return 'Não foi possível buscar os modelos: $error';
  }

  @override
  String get modelsFetchEmpty => 'O provedor não lista modelos.';

  @override
  String get modelsFetchSelectAll => 'Selecionar Todos';

  @override
  String get modelsFetchSelectNone => 'Desmarcar Todos';

  @override
  String modelsFetchSelected(int count, int total) {
    return '$count de $total marcados';
  }

  @override
  String get modelsFetchNew => 'Novo';

  @override
  String get modelsFetchApply => 'Aplicar';

  @override
  String get modelsRetry => 'Tentar Novamente';

  @override
  String get modelsAddTitle => 'Adicionar Modelo';

  @override
  String get modelsEditTitle => 'Editar Modelo';

  @override
  String get modelsModelId => 'ID do Modelo';

  @override
  String get modelsModelIdHint => 'Como o provedor o nomeia, ex.: gpt-5';

  @override
  String get modelsModelIdTaken => 'Este provedor já tem esse modelo.';

  @override
  String get modelsModelLabel => 'Nome de Exibição';

  @override
  String get modelsModelLabelHint => 'Opcional';

  @override
  String get modelsContextWindow => 'Contexto Padrão';

  @override
  String get modelsContextWindowHint => 'Tokens, ex.: 128K; 200K se vazio';

  @override
  String get modelsContextInvalid => 'Um número de tokens, ex.: 200K.';

  @override
  String get modelsEffortOptions => 'Esforços de Raciocínio';

  @override
  String get modelsEffortOptionsDescription =>
      'Oferecidos no seletor de modelos; Médio é escolhido, a menos que outro seja.';

  @override
  String get modelsEffortAddHint => 'ex.: minimal';

  @override
  String get modelsEffortInvalid => 'Apenas letras, dígitos e hífens.';

  @override
  String get modelsContextOptions => 'Tamanhos de Contexto';

  @override
  String get modelsContextOptionsDescription =>
      'Oferecidos no seletor de modelos; o contexto padrão está entre eles.';

  @override
  String get modelsContextAddHint => 'ex.: 128K';

  @override
  String get modelsOptionAdd => 'Adicionar';

  @override
  String modelsOptionRemove(String name) {
    return 'Remover $name';
  }

  @override
  String get modelsOptionsReset => 'Restaurar Padrão';

  @override
  String get modelsOptionsNone => 'Nenhum: não oferecido.';

  @override
  String get modelsNoImages => 'Não aceita imagens';

  @override
  String get modelsKind => 'Usado para';

  @override
  String get modelsKindChat => 'Conversas';

  @override
  String get modelsKindImage => 'Geração de imagens (API de Imagens)';

  @override
  String get modelsKindImageChat => 'Geração de imagens (em uma conversa)';

  @override
  String get modelsKindDescription =>
      'Modelos de imagem não são oferecidos no seletor de modelos: os agentes criam imagens com eles pela ferramenta generate_image.';

  @override
  String get modelsEndpoint => 'Endpoint';

  @override
  String modelsEndpointUpstream(String protocol) {
    return 'Como o provedor ($protocol)';
  }

  @override
  String get modelsEndpointDescription =>
      'Para qual API vão as solicitações deste modelo, na URL base do provedor e com a chave dele: em um relay que atende vários, seus modelos Claude na da Anthropic e seus GPT na Responses, por exemplo.';

  @override
  String get modelsImageBadge => 'Imagem';

  @override
  String get modelsImage => 'Modelo de imagem';

  @override
  String get modelsImageDescription =>
      'Com o que os agentes criam imagens (a ferramenta generate_image), a menos que você peça outro; se perguntado a cada vez, você o escolhe na conversa. Ative modelos de imagem na lista de um provedor.';

  @override
  String get modelsImageFirst => 'Perguntar a cada vez';

  @override
  String get modelsImageNone => 'Nenhum ativado';

  @override
  String get modelsSave => 'Salvar';

  @override
  String get modelsManage => 'Gerenciar Modelos…';

  @override
  String modelsSwitchTitle(String name) {
    return 'Mudar para $name?';
  }

  @override
  String get modelsSwitchDetail =>
      'O Claude Code reinicia no outro provedor e retoma esta conversa (--resume). O histórico é enviado ao novo modelo como está; alguns provedores demoram mais na primeira vez. Uma resposta ainda em andamento para quando você enviar a próxima mensagem.';

  @override
  String get modelsSwitchConfirm => 'Mudar';

  @override
  String get modelsAuxiliary => 'Modelo Auxiliar';

  @override
  String get modelsAuxiliaryDescription =>
      'Usado em trabalhos auxiliares, como gerar títulos de conversas e mensagens de commit. Automático: o modelo da sessão (para mensagens de commit, o padrão das novas sessões); o de um provedor pelo seu nível Haiku.';

  @override
  String get modelsAuxiliaryAuto => 'Automático';

  @override
  String get modelsAuxiliaryBuiltin =>
      'Claude Code Haiku (configuração desta máquina)';

  @override
  String get settingsSectionUpdates => 'Atualizações';

  @override
  String get updatesSettingsTitle => 'Atualizações';

  @override
  String get updatesSettingsDescription =>
      'O BaoCode procura novas versões em baocode.dev.';

  @override
  String get updateCurrentVersion => 'Versão Atual';

  @override
  String updateLastChecked(String time) {
    return 'Última verificação $time';
  }

  @override
  String get updateNeverChecked => 'Ainda não verificado';

  @override
  String get updateCheckNow => 'Verificar Atualizações';

  @override
  String get updateChecking => 'Verificando atualizações…';

  @override
  String get updateUpToDate => 'O BaoCode está atualizado.';

  @override
  String updateAvailable(String version) {
    return 'O BaoCode $version está disponível.';
  }

  @override
  String updateReady(String version) {
    return 'O BaoCode $version foi baixado. Reinicie para atualizar.';
  }

  @override
  String updateDownloading(String version) {
    return 'Baixando o BaoCode $version…';
  }

  @override
  String updateDownloadingProgress(String version, int percent) {
    return 'Baixando o BaoCode $version… $percent%';
  }

  @override
  String updateMandatory(String version) {
    return 'Esta versão do BaoCode não tem mais suporte. Atualize para a $version para continuar usando.';
  }

  @override
  String get updateRestartNow => 'Reiniciar para Atualizar';

  @override
  String get updateLater => 'Mais tarde';

  @override
  String get updateSkip => 'Ignorar Esta Versão';

  @override
  String get updateSkippedNote =>
      'Você ignorou esta versão: ela não é oferecida de novo, mas ainda pode ser instalada aqui.';

  @override
  String updateFailed(String error) {
    return 'Não foi possível atualizar o BaoCode: $error';
  }

  @override
  String updateCheckFailed(String error) {
    return 'Não foi possível verificar atualizações: $error';
  }

  @override
  String get updateDisabled =>
      'As atualizações estão desativadas (update.mode é \"none\").';

  @override
  String get updateUnsupported =>
      'Esta versão do BaoCode não se atualiza sozinha.';

  @override
  String updateManual(String reason) {
    return 'O BaoCode não pode se atualizar aqui ($reason). Baixe a nova versão em baocode.dev.';
  }

  @override
  String get updateOpenDownloadPage => 'Abrir Página de Download';

  @override
  String updateUnfinished(String version, String current) {
    return 'O BaoCode $version não foi instalado: ainda é a $current. Tente novamente em Configurações > Atualizações ou baixe em baocode.dev.';
  }

  @override
  String get updateShowLog => 'Mostrar Log de Instalação';

  @override
  String get updateReleaseNotes => 'Notas da Versão';

  @override
  String updateReleaseNotesFor(String version) {
    return 'Novidades da $version';
  }

  @override
  String get updateMode => 'Modo de Atualização';

  @override
  String get updateModeDescription =>
      'Se o BaoCode procura novas versões por conta própria (update.mode).';

  @override
  String updateModeLabel(String name) {
    return 'Modo de atualização: $name';
  }

  @override
  String get updateModeDefault => 'Automático';

  @override
  String get updateModeManual => 'Manual';

  @override
  String get updateModeNone => 'Desligado';

  @override
  String get diagnosticsTitle => 'Logs de Diagnóstico';

  @override
  String get diagnosticsDescription =>
      'Envie aos desenvolvedores os logs de erro do BaoCode e os relatórios de falha e travamento que o sistema guardou dele, para ajudar a rastrear um problema. Nada é enviado até você fazer o upload.';

  @override
  String get diagnosticsUpload => 'Enviar…';

  @override
  String get diagnosticsDialogTitle => 'Enviar Logs de Diagnóstico';

  @override
  String get diagnosticsNotePlaceholder =>
      'Nota (opcional): o que deu errado e como fazer acontecer de novo';

  @override
  String diagnosticsFiles(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos de log',
      one: '1 arquivo de log',
    );
    return '$_temp0 ($size) será enviado.';
  }

  @override
  String get diagnosticsNoFiles =>
      'Ainda não há logs: só a nota e os detalhes da versão são enviados.';

  @override
  String diagnosticsDumps(int count, String size) {
    return 'Incluir despejos de memória de travamento ($count, $size)';
  }

  @override
  String get diagnosticsDumpsDetail =>
      'Despejos de memória podem conter partes de arquivos abertos e caminhos. Acima de 10 MB, só os mais recentes são incluídos.';

  @override
  String get diagnosticsPrivacy =>
      'Sua pasta pessoal é escrita como ~. A versão do app, o sistema e o idioma são enviados com os logs, mas não o ID de instalação das estatísticas de uso. Mantido no servidor por 90 dias.';

  @override
  String get diagnosticsSend => 'Enviar';

  @override
  String get diagnosticsUploading => 'Enviando…';

  @override
  String get diagnosticsUploaded => 'Enviado. ID do relatório:';

  @override
  String get diagnosticsUploadedDetail =>
      'Informe este ID aos desenvolvedores do BaoCode para que encontrem estes logs.';

  @override
  String diagnosticsOmittedDumps(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count despejos de memória mais antigos foram deixados',
      one: '1 despejo de memória mais antigo foi deixado',
    );
    return '$_temp0 de fora: acima de 10 MB.';
  }

  @override
  String get diagnosticsCopyId => 'Copiar ID';

  @override
  String get diagnosticsCopied => 'Copiado';

  @override
  String get diagnosticsRetry => 'Tentar Novamente';

  @override
  String get diagnosticsTooLarge =>
      'Os logs têm mais de 10 MB e não podem ser enviados.';

  @override
  String get diagnosticsRateLimited =>
      'Muitos envios agora. Tente novamente mais tarde.';

  @override
  String diagnosticsRefused(int status) {
    return 'O servidor não aceitou os logs (HTTP $status).';
  }

  @override
  String diagnosticsServerError(String status) {
    return 'O servidor não conseguiu receber os logs ($status). Tente novamente mais tarde.';
  }

  @override
  String diagnosticsFailed(String error) {
    return 'Não foi possível enviar: $error';
  }

  @override
  String get cmdCheckForUpdates => 'Verificar Atualizações...';

  @override
  String get settingsSectionAppearance => 'Aparência';

  @override
  String get settingsAppearanceKeywords =>
      'tema cor cores escuro claro theme color colour dark light';

  @override
  String get appearanceSettingsTitle => 'Aparência';

  @override
  String get appearanceSettingsColorTheme => 'Tema de Cores';

  @override
  String get appearanceSettingsColorThemeDescription =>
      'As cores do chat, da IDE e do terminal.';

  @override
  String appearanceSettingsColorThemeDescriptionWithKey(String key) {
    return 'As cores do chat, da IDE e do terminal. Preferências: Tema de Cores ($key) mostra uma prévia de cada um conforme você navega por eles.';
  }

  @override
  String appearanceSettingsColorThemeLabel(String theme) {
    return 'Tema de cores: $theme';
  }

  @override
  String get appearanceSettingsChatWidth => 'Largura da Conversa';

  @override
  String get appearanceSettingsChatWidthDescription =>
      'Quanto a conversa, a caixa de mensagem e as configurações crescem em uma janela larga.';

  @override
  String get appearanceSettingsChatWidthDefault => 'Padrão';

  @override
  String get appearanceSettingsChatWidthFull => 'Largura total';

  @override
  String appearanceSettingsChatWidthLabel(String width) {
    return 'Largura da conversa: $width';
  }

  @override
  String get appearanceSettingsAgentLoader => 'Agente Trabalhando';

  @override
  String get appearanceSettingsAgentLoaderDescription =>
      'Ao lado de um agente na barra lateral, nas abas e na pesquisa enquanto ele trabalha ou enquanto algo que ele iniciou ainda roda em segundo plano.';

  @override
  String get appearanceSettingsSubagentLoader => 'Subagente em Execução';

  @override
  String get appearanceSettingsSubagentLoaderDescription =>
      'No card de um subagente na conversa e na linha dele acima do campo de entrada, enquanto ele roda.';

  @override
  String appearanceSettingsLoaderLabel(String what, String style) {
    return '$what: $style';
  }

  @override
  String get appearanceSettingsLoaderSpeed => 'Velocidade';

  @override
  String appearanceSettingsLoaderSpeedLabel(String what, String speed) {
    return 'Velocidade de $what: $speed';
  }

  @override
  String get loaderStyleSnake => 'Cobra';

  @override
  String get loaderStyleStack => 'Empilhar e limpar';

  @override
  String get loaderStyleTwinkle => 'Cintilar';

  @override
  String get loaderStyleFill => 'Encher e esvaziar';

  @override
  String get loaderStylePulse => 'Pulso quadrado';

  @override
  String get loaderStyleRipple => 'Ondulação em cruz';

  @override
  String get loaderStyleSweep => 'Varredura diagonal';

  @override
  String get loaderStyleRain => 'Chuva de pixels';

  @override
  String get loaderStyleChecker => 'Xadrez';

  @override
  String get loaderStyleSpinner => 'Spinner';

  @override
  String get loaderStyleTwinSpinner => 'Spinner duplo';

  @override
  String get loaderStyleCorners => 'Cantos';

  @override
  String get loaderStyleDots => 'Pontos saltitantes';

  @override
  String get loaderStyleEqualizer => 'Equalizador';

  @override
  String get loaderStyleBar => 'Barra de progresso';

  @override
  String get loaderStyleScan => 'Linha de varredura';

  @override
  String get loaderStyleHourglass => 'Ampulheta';

  @override
  String get loaderStyleBreathe => 'Respirar';

  @override
  String get loaderStyleCircle => 'Anel (clássico)';

  @override
  String get appearanceSettingsUserMessageStyle => 'Suas Mensagens';

  @override
  String get appearanceSettingsUserMessageStyleDescription =>
      'Como as mensagens que você envia aparecem na conversa: tão largas quanto ela, com a que você está lendo permanecendo no topo ao rolar; ou como balões de chat à direita que rolam para fora.';

  @override
  String get appearanceSettingsUserMessageStyleSticky =>
      'Largura total, fixa no topo';

  @override
  String get appearanceSettingsUserMessageStyleBubble => 'Balões de chat';

  @override
  String appearanceSettingsUserMessageStyleLabel(String style) {
    return 'Suas mensagens: $style';
  }

  @override
  String get appearanceSettingsReplyScroll => 'Quando uma Resposta Chega';

  @override
  String get appearanceSettingsReplyScrollDescription =>
      'Onde a conversa fica enquanto a resposta à sua mensagem é escrita: no fim, acompanhando-a; ou no início, com sua mensagem no topo, para você continuar a leitura a partir dali. Rolando até o fim, ela volta a acompanhar.';

  @override
  String get appearanceSettingsReplyScrollFollow => 'Automático';

  @override
  String get appearanceSettingsReplyScrollStart => 'Ficar no início';

  @override
  String appearanceSettingsReplyScrollLabel(String choice) {
    return 'Quando uma resposta chega: $choice';
  }

  @override
  String get appearanceSettingsMinimap => 'Minimapa da Conversa';

  @override
  String get appearanceSettingsMinimapDescription =>
      'Um minimapa de toda a conversa à esquerda da coluna, mostrando onde você está ao rolar; clique ou arraste nele para ir a algum ponto. Ele substitui a barra de rolagem e não aparece em uma janela estreita demais para ele. Desligado: a barra de rolagem.';

  @override
  String get appearanceSettingsWindowBlur => 'Desfoque Nativo da Janela';

  @override
  String get appearanceSettingsWindowBlurDescription =>
      'O desfoque do sistema sob as janelas (o material da barra lateral do macOS, o acrílico do Windows 11): o que está atrás delas aparece através da barra lateral e da conversa. Desligado: as janelas são opacas.';

  @override
  String get appearanceSettingsSidebarTimes => 'Horários na Barra Lateral';

  @override
  String get appearanceSettingsSidebarTimesDescription =>
      'Cada agente na barra lateral termina com quando fez algo pela última vez. Desligado: só ao passar o mouse.';

  @override
  String get appearanceSettingsMinimapGlass => 'Opacidade do Vidro';

  @override
  String get appearanceSettingsMinimapGlassDescription =>
      'Quanto o vidro líquido sobre onde você está no minimapa aparece: seu tom, sombra e luz. Com 0%, só a parte visível se destaca.';

  @override
  String appearanceSettingsMinimapGlassLabel(String opacity) {
    return 'Opacidade do vidro do minimapa: $opacity';
  }

  @override
  String get appearanceSettingsMinimapElasticity => 'Elasticidade do Vidro';

  @override
  String get appearanceSettingsMinimapElasticityDescription =>
      'Quanto o vidro líquido se estica ao acompanhar sua rolagem, com a borda da frente na liderança, e se recompõe onde para.';

  @override
  String appearanceSettingsMinimapElasticityLabel(String level) {
    return 'Elasticidade do vidro do minimapa: $level';
  }

  @override
  String get minimapElasticityOff => 'Desligada';

  @override
  String get minimapElasticitySubtle => 'Sutil';

  @override
  String get minimapElasticityMedium => 'Média';

  @override
  String get minimapElasticityBouncy => 'Elástica';

  @override
  String get appearanceSettingsCodeFont => 'Fonte do Código';

  @override
  String get appearanceSettingsCodeFontDescription =>
      'A fonte em que o código é desenhado: no editor, no terminal, no chat e nas prévias. Nomes de famílias em ordem, separados por vírgulas, ou uma predefinição.';

  @override
  String get appearanceSettingsCodeFontDefault => 'Padrão';

  @override
  String get appearanceSettingsCodeFontField => 'Famílias de fontes';

  @override
  String appearanceSettingsCodeFontLabel(String font) {
    return 'Fonte do código: $font';
  }

  @override
  String get appearanceSettingsCodeSize => 'Tamanho do Código';

  @override
  String get appearanceSettingsCodeSizeDescription =>
      'O tamanho do código no editor da IDE e nas visualizações de arquivos e alterações do painel lateral com a interface em 100%; ampliar a interface o escala proporcionalmente. O código no chat segue o tamanho da interface; o terminal tem seu próprio tamanho.';

  @override
  String appearanceSettingsCodeSizeLabel(String size) {
    return 'Tamanho do código: $size';
  }

  @override
  String get appearanceSettingsLigatures => 'Ligaduras de Fonte';

  @override
  String get appearanceSettingsLigaturesDescription =>
      'Desenha sequências como => e != como um único glifo onde a fonte tiver um. O terminal não.';

  @override
  String get appearanceSettingsWordWrap => 'Quebra de Linha';

  @override
  String get appearanceSettingsWordWrapDescription =>
      'Quebra linhas longas na largura do editor, em todos os editores. O menu de contexto de um editor e a Paleta de Comandos (Alternar Quebra de Linha) também a alternam. Arquivos com mais de 5.000 linhas não são quebrados.';

  @override
  String get appearanceSettingsUiScale => 'Tamanho da Interface';

  @override
  String get appearanceSettingsUiScaleDescription =>
      'Amplia toda a interface (texto, ícones e espaçamento) e o código nela, e o texto do terminal enquanto o tamanho do terminal a acompanha. O código no editor amplia a partir do tamanho do código.';

  @override
  String appearanceSettingsUiScaleLabel(String percent) {
    return 'Tamanho da interface: $percent%';
  }

  @override
  String get appearanceSettingsTerminalSize => 'Tamanho da Fonte do Terminal';

  @override
  String get appearanceSettingsTerminalSizeDescription =>
      'O tamanho do texto do terminal. Por padrão, acompanha o tamanho da interface; pode ser definido separadamente.';

  @override
  String get appearanceSettingsTerminalSizeFollow =>
      'Acompanhar Tamanho da Interface';

  @override
  String get appearanceSettingsTerminalSizeCustom => 'Personalizado';

  @override
  String get appearanceSettingsTerminalSizeValue => 'Tamanho Personalizado';

  @override
  String appearanceSettingsTerminalSizeLabel(String size) {
    return 'Tamanho da fonte do terminal: $size';
  }

  @override
  String get generalSettingsContextMenuFinder => 'Menu de Contexto do Finder';

  @override
  String get generalSettingsContextMenuExplorer =>
      'Menu de Contexto do File Explorer';

  @override
  String get generalSettingsContextMenuDescription =>
      'Adiciona \"Abrir com o BaoCode\" (um novo agente) e \"Abrir com o Fast Ide\" (uma nova janela de IDE) ao menu de contexto de arquivos, pastas e do plano de fundo de uma pasta.';

  @override
  String get generalSettingsContextMenuMacNote =>
      'A configuração própria do Finder fica nas extensões das Configurações do Sistema, onde a extensão do BaoCode também pode ser ativada e desativada.';

  @override
  String get generalSettingsContextMenuOn => 'Ligado';

  @override
  String get generalSettingsContextMenuOff => 'Desligado';

  @override
  String get generalSettingsContextMenuUnsupported =>
      'Esta versão do app não tem extensão do Finder.';

  @override
  String get generalSettingsContextMenuTurnOn => 'Ligar';

  @override
  String get generalSettingsContextMenuTurnOff => 'Desligar';

  @override
  String get generalSettingsContextMenuSystemSettings =>
      'Configurações do Sistema…';

  @override
  String generalSettingsContextMenuFailed(String error) {
    return 'Não foi possível alterar o menu de contexto: $error';
  }

  @override
  String contextMenuOpenWith(String name) {
    return 'Abrir com $name';
  }

  @override
  String get cmdOpenRemoteFolder => 'Abrir Projeto Remoto...';

  @override
  String get cmdOpenRemoteFile => 'Abrir Arquivo Remoto...';

  @override
  String get remoteHostPlaceholder =>
      'Selecione um host, adicione um ou digite user@host[:port]';

  @override
  String remoteConnectTo(String host) {
    return 'Conectar a $host';
  }

  @override
  String get remoteNoHosts =>
      'Nenhum host ainda: adicione um ou digite user@host';

  @override
  String get remoteInvalidHost =>
      'Não é um host: sem espaços e sem começar com \'-\'';

  @override
  String remoteConnecting(String host) {
    return 'Conectando a $host...';
  }

  @override
  String remoteConnectFailed(String host) {
    return 'Não foi possível conectar a $host';
  }

  @override
  String get remoteRetry => 'Tentar Novamente';

  @override
  String remoteSignInTitle(String host) {
    return 'Entrar em $host';
  }

  @override
  String get remoteSignInRefused => 'Isso não foi aceito. Tente novamente.';

  @override
  String get remoteSignInRemember =>
      'Lembrar neste computador (no chaveiro do sistema)';

  @override
  String get remoteSignInConnect => 'Conectar';

  @override
  String remoteFolderPlaceholder(String host) {
    return 'Uma pasta em $host: escolha uma ou digite um caminho';
  }

  @override
  String get remoteFolderRefresh => 'Ler as pastas novamente';

  @override
  String get remoteOpenThisFolder => 'Abrir Esta Pasta';

  @override
  String get remoteParentFolder => 'Pasta Pai';

  @override
  String remoteGoTo(String path) {
    return 'Ir para $path';
  }

  @override
  String remoteListFailed(String path) {
    return 'Não foi possível listar $path';
  }

  @override
  String remoteReadingFolder(String path) {
    return 'Lendo $path…';
  }

  @override
  String get remoteFileHostPlaceholder =>
      'Selecione um host para navegar pelos arquivos dele';

  @override
  String remoteFilePlaceholder(String host) {
    return 'Um arquivo em $host: escolha um ou digite um caminho';
  }

  @override
  String remoteOpenFile(String path) {
    return 'Abrir $path';
  }

  @override
  String remoteOpenFailed(String path) {
    return 'Não foi possível abrir $path';
  }

  @override
  String get remoteRecentFiles => 'Arquivos Remotos Recentes';

  @override
  String remoteOpenFileOn(String host) {
    return 'Abrir Arquivo em $host...';
  }

  @override
  String remoteStatusActions(String host) {
    return 'Clique para ver os hosts e as ações de $host';
  }

  @override
  String remoteStatus(String kind, String host) {
    return '$kind: $host';
  }

  @override
  String remoteStatusConnecting(String kind, String host) {
    return '$kind: $host (conectando...)';
  }

  @override
  String remoteStatusReconnecting(String kind, String host) {
    return '$kind: $host (reconectando...)';
  }

  @override
  String remoteStatusFailed(String kind, String host) {
    return '$kind: $host (desconectado)';
  }

  @override
  String remoteStatusInstalling(String kind, String host, int percent) {
    return '$kind: $host (instalando o Claude Code $percent%)';
  }

  @override
  String remoteStatusInstallingUnsized(String kind, String host) {
    return '$kind: $host (instalando o Claude Code...)';
  }

  @override
  String remoteInstallingClaude(String host) {
    return 'Instalando o Claude Code em $host…';
  }

  @override
  String remoteInstallingClaudeProgress(String host, int percent) {
    return 'Instalando o Claude Code em $host… $percent%';
  }

  @override
  String localDownloadingClaude(int percent) {
    return 'Baixando o Claude Code… $percent%';
  }

  @override
  String remoteUploadingClaude(String host, int percent) {
    return 'Enviando o Claude Code para $host… $percent%';
  }

  @override
  String remoteStatusTooltip(String kind, String host) {
    return 'Conectado a $host via $kind';
  }

  @override
  String remoteStatusTooltipLost(String host) {
    return 'A conexão com $host foi perdida: clique para reconectar agora';
  }

  @override
  String remoteStatusTooltipResuming(String host) {
    return 'A conexão com $host foi perdida e está sendo refeita: os terminais e o Claude Code continuam em execução lá enquanto isso. Clique para reconectar agora';
  }

  @override
  String get remoteReconnect => 'Reconectar';

  @override
  String remoteProjectTooltip(String kind, String host) {
    return 'Em $host, via $kind';
  }

  @override
  String quitConfirmRemote(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count sessões e terminais em hosts remotos também serão encerrados.',
      one: '1 sessão ou terminal em um host remoto também será encerrado.',
    );
    return '$_temp0';
  }

  @override
  String get updateButton => 'Atualizar';

  @override
  String get tipsSetupTitle => 'Configurar o BaoCode';

  @override
  String tipsSetupCount(int done, int total) {
    return '$done/$total';
  }

  @override
  String tipsSetupEntry(int done, int total) {
    return 'Configuração $done/$total';
  }

  @override
  String get tipsHide => 'Ocultar';

  @override
  String get tipsTurnOn => 'Ativar';

  @override
  String get tipsDismiss => 'Fechar';

  @override
  String get tipsDone => 'Concluído';

  @override
  String get tipsDontShowAgain => 'Não Mostrar Novamente';

  @override
  String tipsFailed(String title, String error) {
    return 'Não foi possível ativar $title: $error';
  }

  @override
  String tipsUpdated(String version, String features) {
    return 'O BaoCode foi atualizado para $version. Novidades: $features.';
  }

  @override
  String get tipsListSeparator => ', ';

  @override
  String get tipsSettingsTitle => 'Recomendado';

  @override
  String get tipsSettingsDescription =>
      'Recursos ainda não ativados. Mostrar Guia de Configuração traz de volta a lista de configuração; \"workbench.tips.enabled\": false no settings.json desativa as dicas.';

  @override
  String get tipContextMenuBody =>
      'Abra arquivos e pastas no BaoCode pelo menu de contexto.';

  @override
  String tipShellCommandTitle(String name) {
    return 'Comando \'$name\'';
  }

  @override
  String tipShellCommandBody(String name) {
    return 'Abra pastas no BaoCode a partir de um terminal: $name <path>.';
  }

  @override
  String get tipImportKeybindingsTitle => 'Importar Atalhos de Teclado';

  @override
  String get tipImportKeybindingsBody =>
      'Traga seus atalhos de teclado do VS Code ou do Cursor.';

  @override
  String get tipColorThemeBody =>
      'Escolha as cores do chat, da IDE e do terminal.';

  @override
  String get cmdShowSetupGuide => 'Mostrar Guia de Configuração';

  @override
  String get cmdStarOnGitHub => 'Dar Estrela no BaoCode no GitHub';

  @override
  String get starPromptMessage => 'Gostando do BaoCode?';

  @override
  String get starPromptDetail =>
      'O BaoCode é gratuito e de código aberto. Se ele ajuda você, uma estrela no GitHub ajuda outras pessoas a encontrá-lo.';

  @override
  String get starPromptStar => 'Dar Estrela no GitHub';

  @override
  String get starPromptLater => 'Talvez Depois';

  @override
  String get cmdResetFeatureTips => 'Redefinir Dicas de Recursos';

  @override
  String get newChatWorkspaceGroup => 'Workspaces';

  @override
  String newChatWorkspaceDetail(int count, String names) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pastas',
      one: '1 pasta',
    );
    return '$_temp0 · $names';
  }

  @override
  String newChatHostProjects(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count projetos',
      one: '1 projeto',
    );
    return '$_temp0';
  }

  @override
  String get newChatPickRemoteFolder => 'Escolher Pasta…';

  @override
  String get newChatPickRemoteFolderDetail => 'Abrir uma pasta neste host';

  @override
  String get newChatCreateWorkspace => 'Criar Workspace…';

  @override
  String get newChatCreateWorkspaceDetail => 'Trabalhe com várias pastas';

  @override
  String get workspaceCreateTitle => 'Criar Workspace';

  @override
  String get workspaceEditTitle => 'Editar Workspace';

  @override
  String get workspaceName => 'Nome';

  @override
  String get workspaceNameHint => 'Meu Workspace';

  @override
  String get workspaceFolders => 'Pastas';

  @override
  String get workspaceFoldersDescription =>
      'Os agentes que trabalham neste workspace podem ler e alterar os arquivos destas pastas.';

  @override
  String workspaceFoldersEmpty(String app) {
    return 'Nenhuma pasta ainda. Adicione projetos ou pastas do $app.';
  }

  @override
  String get workspaceNoFolders => 'Adicione pelo menos uma pasta.';

  @override
  String get workspaceAddProject => 'Adicionar de Projetos';

  @override
  String workspaceAddFolder(String app) {
    return 'Adicionar do $app…';
  }

  @override
  String get workspaceNoProjects => 'Nenhum projeto para adicionar';

  @override
  String workspaceRemoveFolder(String name) {
    return 'Remover $name';
  }

  @override
  String get workspaceCreate => 'Criar';

  @override
  String workspaceHover(String folders) {
    return 'Workspace: $folders';
  }

  @override
  String get sidebarEditWorkspace => 'Editar Workspace…';

  @override
  String get sidebarDeleteWorkspace => 'Excluir Workspace';

  @override
  String get sidebarEditProject => 'Editar Projeto…';

  @override
  String get projectEditTitle => 'Editar Projeto';

  @override
  String get projectLocation => 'Local';

  @override
  String get projectLocationDescription =>
      'Moveu ou renomeou a pasta? Aponte o projeto para ela aqui, e as conversas vão junto. A pasta em si não é movida.';

  @override
  String projectChooseFolder(String app) {
    return 'Escolher no $app…';
  }

  @override
  String get projectFolderNotFound => 'Não há nenhuma pasta neste caminho.';

  @override
  String get projectRelocateBusy =>
      'Um agente deste projeto ainda está trabalhando ou aberto em uma janela própria. Altere o local quando ele terminar.';

  @override
  String get projectRelocateFailed =>
      'Não foi possível mover as conversas deste projeto.';

  @override
  String get projectRelocating => 'Movendo Conversas…';

  @override
  String ideWorkspaceTitle(String name) {
    return '$name (Workspace)';
  }

  @override
  String get ideAddFolderToWorkspace => 'Adicionar Pasta ao Workspace…';

  @override
  String get ideRemoveFolderFromWorkspace => 'Remover Pasta do Workspace';

  @override
  String get ideEmptyWorkspace => 'Este workspace ainda não tem pastas.';

  @override
  String get scmRepositories => 'Repositórios';

  @override
  String get cmdCreateWorkspace => 'Criar Workspace...';

  @override
  String get settingsSectionNetwork => 'Rede';

  @override
  String get settingsNetworkKeywords => 'proxy http https clash vpn rede';

  @override
  String get networkSettingsTitle => 'Rede';

  @override
  String get networkSettingsDescription =>
      'Como o BaoCode e o Claude Code que ele inicia acessam a internet.';

  @override
  String get networkProxy => 'Proxy';

  @override
  String get networkProxyDescription =>
      'O proxy do BaoCode e do Claude Code (http.proxyMode). Proxy do Sistema segue as configurações do sistema, como o proxy do sistema do Clash. Novas sessões aplicam a mudança; reinicie uma sessão em andamento para que ela a aplique.';

  @override
  String networkProxyLabel(String name) {
    return 'Proxy: $name';
  }

  @override
  String get networkProxySystem => 'Proxy do Sistema';

  @override
  String get networkProxyManual => 'Manual';

  @override
  String get networkProxyOff => 'Sem Proxy';

  @override
  String get networkProxyUrl => 'Endereço do Proxy';

  @override
  String get networkProxyUrlDescription =>
      'Um proxy HTTP, como a porta do Clash: http://127.0.0.1:7890 (http.proxy). SOCKS não é compatível.';

  @override
  String networkProxyUrlInvalid(String url) {
    return 'Não é um endereço de proxy HTTP: $url. Informe um como http://127.0.0.1:7890.';
  }

  @override
  String get networkProxyStatus => 'Em Uso';

  @override
  String get networkProxyStatusChecking => 'Detectando…';

  @override
  String networkProxyStatusSystem(String server) {
    return 'Proxy do sistema $server';
  }

  @override
  String networkProxyStatusEnvironment(String server) {
    return '$server, do ambiente (HTTPS_PROXY): o sistema não tem proxy definido';
  }

  @override
  String networkProxyStatusManual(String server) {
    return '$server';
  }

  @override
  String get networkProxyStatusManualMissing => 'Informe o endereço do proxy.';

  @override
  String get networkProxyStatusNone =>
      'Direto: o sistema não tem proxy definido.';

  @override
  String get networkProxyStatusOff => 'Direto.';

  @override
  String get networkProxyStatusAutoConfig =>
      'Direto: o sistema define seu proxy com um arquivo de configuração automática (PAC), que o BaoCode não segue. Ative o proxy do sistema do Clash ou informe o endereço manualmente.';

  @override
  String get networkProxyRefresh => 'Detectar Novamente';

  @override
  String get networkTest => 'Teste de Conexão';

  @override
  String get networkTestDescription =>
      'Acessa estes sites pelo proxy em uso: se cada um responde e com que rapidez (o tempo de uma nova conexão, até o início da resposta).';

  @override
  String get networkTesting => 'Testando…';

  @override
  String get networkTestRun => 'Executar Teste';

  @override
  String get networkTestRunAgain => 'Testar Novamente';

  @override
  String get networkTestIdle => 'Não testado';

  @override
  String networkTestMs(int ms) {
    return '$ms ms';
  }

  @override
  String get networkTestUnreachable => 'Inacessível';

  @override
  String networkTestSummary(int reached, int total) {
    return '$reached de $total sites acessíveis.';
  }

  @override
  String get networkFailureTimeout => 'Tempo esgotado';

  @override
  String get networkFailureRefused => 'Conexão recusada';

  @override
  String get networkFailureReset => 'Conexão redefinida';

  @override
  String get networkFailureDns => 'Falha na consulta DNS';

  @override
  String get networkFailureTls => 'Falha no TLS';

  @override
  String get networkFailureProxyAuth => 'O proxy exige login';

  @override
  String get networkFailureOther => 'Não foi possível conectar';

  @override
  String get networkTestHintRefused =>
      'Nada responde no endereço do proxy: verifique se o Clash (ou o proxy) está em execução.';

  @override
  String get networkTestHintOffline =>
      'Nenhum site responde: verifique a conexão de rede deste computador e o proxy.';

  @override
  String get networkTestHintBlocked =>
      'Só o Baidu responde: o proxy não está deixando passar os outros. Verifique o proxy acima ou o modo e as regras do Clash.';

  @override
  String get extsCapabilityFull => 'Totalmente compatível';

  @override
  String get extsCapabilityFullDetail =>
      'Todos os seus temas de cores ou de ícones de arquivo se aplicam.';

  @override
  String get extsCapabilityPartial => 'Parcialmente compatível';

  @override
  String get extsCapabilityPartialDetail =>
      'Seus temas se aplicam; o restante não faz nada no BaoCode.';

  @override
  String extsEngineIncompatible(String current, String requested) {
    return 'Requer o VS Code $requested; este é o $current.';
  }

  @override
  String get extsEngineMissing => 'Não informa qual VS Code requer.';

  @override
  String extsEngineInvalid(String requested) {
    return 'Engine \'$requested\' inválida.';
  }

  @override
  String extsEngineCompatible(String engine) {
    return 'Requer o VS Code $engine.';
  }

  @override
  String get extsTitleUpdates => 'Atualizações';

  @override
  String get extsTitleOpenVsx => 'Open VSX';

  @override
  String get extsUpdates => 'Atualizações';

  @override
  String get extsCheckForUpdates => 'Verificar Atualizações';

  @override
  String get extsMoreActions => 'Mais Ações...';

  @override
  String get extsInstallFromVsix => 'Instalar do VSIX...';

  @override
  String get extsSearchPlaceholder => 'Pesquisar Extensões do Open VSX';

  @override
  String extsSearchFailed(String error) {
    return 'Não foi possível pesquisar no Open VSX: $error';
  }

  @override
  String get extsLoadMore => 'Carregar Mais';

  @override
  String extsUpdateTo(String version) {
    return 'Atualizar para $version';
  }

  @override
  String get extsUpdating => 'Atualizando...';

  @override
  String get extsEnable => 'Habilitar';

  @override
  String get extsDisable => 'Desabilitar';

  @override
  String get extsDisabled => 'Desabilitada';

  @override
  String get extsSwitchToPreRelease => 'Mudar para a Versão de Pré-Lançamento';

  @override
  String get extsSwitchToRelease => 'Mudar para a Versão de Lançamento';

  @override
  String get extsInstallPreRelease => 'Instalar Versão de Pré-Lançamento';

  @override
  String extsInstallVersion(String version) {
    return 'Instalar $version';
  }

  @override
  String get extsPreRelease => 'Pré-Lançamento';

  @override
  String get extsVerifiedPublisher => 'Editor verificado';

  @override
  String extsDownloads(String count) {
    return '$count downloads';
  }

  @override
  String extsLoadFailed(String error) {
    return 'Não foi possível carregar: $error';
  }

  @override
  String get extsVersion => 'Versão';

  @override
  String get extsPreReleaseToggle => 'Pré-Lançamento';

  @override
  String get extsLatestVersion => 'Mais recente';

  @override
  String get extsTabDetails => 'Detalhes';

  @override
  String get extsTabFeatures => 'Recursos';

  @override
  String get extsTabChangelog => 'Changelog';

  @override
  String get extsNoReadme => 'Esta extensão não tem README.';

  @override
  String get extsNoChangelog => 'Esta extensão não tem changelog.';

  @override
  String get extsContributions => 'Contribuições';

  @override
  String get extsNoContributions => 'Esta extensão não contribui com nada.';

  @override
  String get extsActivationEvents => 'Eventos de Ativação';

  @override
  String get extsApiProposals => 'Propostas de API';

  @override
  String get extsCompatibility => 'Compatibilidade';

  @override
  String get extsInformation => 'Informações';

  @override
  String get extsInfoIdentifier => 'Identificador';

  @override
  String get extsInfoVersion => 'Versão';

  @override
  String get extsInfoLatest => 'Mais recente';

  @override
  String get extsInfoLastUpdated => 'Última Atualização';

  @override
  String get extsInfoEngine => 'VS Code';

  @override
  String get extsInfoPlatform => 'Plataforma';

  @override
  String get extsInfoLicense => 'Licença';

  @override
  String get extsInfoRepository => 'Repositório';

  @override
  String get extsInfoCategories => 'Categorias';

  @override
  String get extsInfoLocation => 'Local';

  @override
  String get extsVsixTitle => 'Instalar VSIX de Extensão';

  @override
  String extsVsixInvalid(String name, String error) {
    return '$name não é um VSIX válido: $error';
  }

  @override
  String extsVsixPlatformMismatch(String platform, String current) {
    return 'Foi compilada para $platform, não para $current.';
  }

  @override
  String extsVsixReplaces(String version) {
    return 'Substitui a versão $version.';
  }

  @override
  String extsPlatformCompatible(String platform) {
    return 'Plataforma: $platform';
  }

  @override
  String get extsPlatformUniversal => 'universal';

  @override
  String extsPageTitle(String name) {
    return 'Extensão: $name';
  }

  @override
  String get themeSelectIconThemePlaceholder =>
      'Selecionar Tema de Ícones de Arquivo (Setas para Cima/Baixo para Visualizar)';

  @override
  String get themeIconThemeBuiltIn => 'Integrado';

  @override
  String get extsCapabilityUnsupported => 'Não compatível';

  @override
  String get extsCapabilityUnsupportedDetail =>
      'Não tem tema de cores nem de ícones de arquivo: o BaoCode só usa temas de extensões.';

  @override
  String get extsFindingCode => 'Seu código não é executado.';

  @override
  String extsFindingContribution(String name) {
    return 'Não usado: $name';
  }

  @override
  String get extsPopularThemes => 'Temas Populares';

  @override
  String get extsTabThemes => 'Temas';

  @override
  String get extsTabLanguageServers => 'Servidores de Linguagem';

  @override
  String get sidebarAllHosts => 'Todos';

  @override
  String get sidebarThisMachine => 'Este Computador';

  @override
  String get sidebarSwitchHost => 'Alternar entre este computador e hosts SSH';

  @override
  String get sidebarAddSshHost => 'Adicionar Host SSH...';

  @override
  String sidebarOpenFolderOn(String host) {
    return 'Abrir Pasta em $host...';
  }

  @override
  String sidebarNoProjectsOn(String host) {
    return 'Nenhum projeto em $host ainda.';
  }

  @override
  String get sidebarHostConnected => 'Conectado';

  @override
  String get sidebarHostConnecting => 'Conectando...';

  @override
  String get sidebarHostDisconnected => 'Desconectado';

  @override
  String get sidebarHostIdle => 'Não conectado';

  @override
  String get sidebarDisconnectHost => 'Desconectar';

  @override
  String get sidebarRemoveHost => 'Remover Host';

  @override
  String sidebarRemoveHostTitle(String host) {
    return 'Remover $host?';
  }

  @override
  String get sidebarRemoveHostMessage =>
      'Seus projetos são retirados da barra lateral. As conversas são mantidas e voltam quando o host for adicionado novamente.';

  @override
  String get sidebarRemove => 'Remover';

  @override
  String sidebarElsewhereNeedsYou(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count agentes em outras máquinas precisam de você',
      one: '1 agente em outra máquina precisa de você',
    );
    return '$_temp0';
  }

  @override
  String get sidebarRenameHost => 'Renomear Host';

  @override
  String get sidebarEditHost => 'Editar Conexão...';

  @override
  String get explorerNoPermission => 'Sem permissão para ler esta pasta';

  @override
  String fileErrorAccessDenied(String path) {
    return 'Permissão negada: $path';
  }

  @override
  String get remoteAddedHosts => 'Adicionados';

  @override
  String explorerUndoCreateChanged(String name) {
    return '$name foi alterado desde que foi criado. Desfazer o exclui mesmo assim?';
  }

  @override
  String get settingsSectionMobile => 'Celular';

  @override
  String get settingsMobileKeywords =>
      'celular telefone iphone android ios parear pareamento qr code remoto lan';

  @override
  String get mobileSettingsDescription =>
      'Acompanhe e controle os agentes deste computador pelo BaoCode no seu celular, pela rede local ou pela internet. O que trafega entre eles é criptografado de ponta a ponta.';

  @override
  String get mobileAllow => 'Permitir que Celulares se Conectem';

  @override
  String get mobileAllowDescription =>
      'Celulares pareados com este computador se conectam diretamente a ele.';

  @override
  String get mobileStatus => 'Status';

  @override
  String get mobileStatusOff => 'Desativado';

  @override
  String get mobileStatusStarting => 'Iniciando…';

  @override
  String mobileStatusListening(int port) {
    return 'Escutando na porta $port';
  }

  @override
  String mobileStatusFailed(String error) {
    return 'Não foi possível escutar: $error';
  }

  @override
  String get mobileAddresses => 'Endereços';

  @override
  String get mobileAddressesDescription =>
      'Onde os celulares acessam este computador, na ordem em que tentam: primeiro a rede local, depois a internet.';

  @override
  String get mobileAddressesNone => 'Nenhuma rede encontrada.';

  @override
  String get mobileAddressesRefresh => 'Atualizar';

  @override
  String get mobilePort => 'Porta';

  @override
  String get mobilePortDescription =>
      'A porta à qual os celulares se conectam. Encaminhe-a no roteador para acessar este computador pela internet.';

  @override
  String mobilePortInvalid(String text) {
    return 'Não é uma porta: $text. Informe um número de 1 a 65535.';
  }

  @override
  String get mobilePublicAddress => 'Endereço Público';

  @override
  String get mobilePublicAddressDescription =>
      'Um domínio ou IP pelo qual este computador pode ser acessado da internet (com a porta encaminhada), colocado no QR code; vários separados por vírgulas. Atrás de um proxy que só aceita HTTPS (como um Cloudflare Tunnel), escreva como wss://domínio. Endereços IPv6 públicos são encontrados automaticamente.';

  @override
  String get mobileRelay => 'Relay';

  @override
  String get mobileRelayDescription =>
      'Acesse este computador pelo relay do BaoCode quando nenhum de seus endereços puder ser alcançado. Em breve.';

  @override
  String get mobileRelayUnavailable => 'Ainda Não Disponível';

  @override
  String get mobilePair => 'Parear um Celular';

  @override
  String get mobilePairDescription =>
      'Escaneie o código com o BaoCode no celular (Eu → Computadores pareados → Parear um computador) ou escolha este computador em Computadores Próximos por lá.';

  @override
  String get mobilePairShow => 'Mostrar QR Code';

  @override
  String get mobilePairCancel => 'Cancelar';

  @override
  String get mobilePairNewCode => 'Novo Código';

  @override
  String get mobilePairCopyLink => 'Copiar Link';

  @override
  String get mobilePairCopied => 'Copiado';

  @override
  String mobilePairExpires(int minutes) {
    return 'Válido por $minutes min, uma única vez. Um celular que não consiga escanear pode colar o link.';
  }

  @override
  String get mobilePairExpired => 'Este código expirou.';

  @override
  String mobilePairVerifyTitle(String name) {
    return 'Compare com $name';
  }

  @override
  String get mobilePairVerifyBody =>
      'Verifique se o celular mostra o mesmo código e confirme no celular.';

  @override
  String get mobilePairMismatch => 'Os Códigos Não Coincidem';

  @override
  String mobilePaired(String name) {
    return 'Pareado com $name.';
  }

  @override
  String get mobilePhones => 'Celulares Pareados';

  @override
  String get mobilePhonesNone => 'Nenhum celular pareado ainda.';

  @override
  String get mobilePhoneConnected => 'Conectado';

  @override
  String mobilePhoneLastSeen(String time) {
    return 'Última conexão $time';
  }

  @override
  String get mobilePhoneRemove => 'Remover';

  @override
  String get mobileThisComputerKey => 'Chave deste Computador';

  @override
  String get mobileThisComputerKeyDescription =>
      'O celular também a mostra: a mesma chave nos dois significa que ninguém está no meio.';

  @override
  String get mobileDiscoverable => 'Encontrar na Rede Local';

  @override
  String get mobileDiscoverableDescription =>
      'Celulares pareados com este computador o encontram na rede local, mesmo depois que o endereço muda; enquanto você pareia um, novos celulares o listam em Computadores Próximos.';

  @override
  String get mobilePairNearbyHint =>
      'Celulares nesta rede também podem escolher este computador em Computadores Próximos.';

  @override
  String mobilePairRequestTitle(String name) {
    return '$name Quer Parear';
  }

  @override
  String get mobilePairRequestBody =>
      'Ele encontrou este computador por perto. Permita só se o celular mostrar o mesmo código.';

  @override
  String get mobilePairAllow => 'Permitir';

  @override
  String get settingsSectionStash => 'Stash';

  @override
  String get settingsSectionCustomize => 'Personalizar';

  @override
  String get settingsCustomizeKeywords =>
      'skills subagentes regras comandos agentes claude memória hooks mcp plugins';

  @override
  String get stashTitle => 'Stash';

  @override
  String get stashHeading => 'Stash';

  @override
  String get stashNew => 'Novo stash';

  @override
  String get stashLinkOpen => 'Abrir link';

  @override
  String get stashLinkEdit => 'Editar link';

  @override
  String get stashLinkCopy => 'Copiar endereço do link';

  @override
  String get stashLinkRemove => 'Remover link';

  @override
  String get stashFormatMenu => 'Formatar';

  @override
  String get stashDraft => 'Rascunho';

  @override
  String get stashCodeChip => 'Código';

  @override
  String get stashTableChip => 'Tabela';

  @override
  String stashLines(int count) {
    return '$count linhas';
  }

  @override
  String get stashNewButton => 'Novo';

  @override
  String get stashNewTooltip => 'Novo stash';

  @override
  String get stashPlaceholder => 'Anote aqui…';

  @override
  String get stashHintNew => 'Novo';

  @override
  String get stashProjectTooltip => 'Projeto a que se refere';

  @override
  String get stashNoProject => 'Nenhum projeto';

  @override
  String get stashFormatBold => 'Negrito';

  @override
  String get stashFormatItalic => 'Itálico';

  @override
  String get stashFormatStrike => 'Tachado';

  @override
  String get stashFormatUnderline => 'Sublinhado';

  @override
  String get stashFormatCode => 'Código';

  @override
  String get stashFormatLink => 'Link';

  @override
  String get stashFormatColor => 'Cor do texto e do fundo';

  @override
  String get stashFormatHeading1 => 'Título 1';

  @override
  String get stashFormatHeading2 => 'Título 2';

  @override
  String get stashFormatHeading3 => 'Título 3';

  @override
  String get stashFormatBullets => 'Lista com marcadores';

  @override
  String get stashFormatNumbers => 'Lista numerada';

  @override
  String get stashFormatTasks => 'Lista de tarefas';

  @override
  String get stashFormatQuote => 'Citação';

  @override
  String get stashFormatCodeBlock => 'Bloco de código';

  @override
  String get markdownTableInsertRowAbove => 'Inserir linha acima';

  @override
  String get markdownTableInsertRowBelow => 'Inserir linha abaixo';

  @override
  String get markdownTableDeleteRow => 'Excluir linha';

  @override
  String get markdownTableInsertColumnLeft => 'Inserir coluna à esquerda';

  @override
  String get markdownTableInsertColumnRight => 'Inserir coluna à direita';

  @override
  String get markdownTableDeleteColumn => 'Excluir coluna';

  @override
  String get markdownTableAlignLeft => 'Alinhar à esquerda';

  @override
  String get markdownTableAlignCenter => 'Centralizar';

  @override
  String get markdownTableAlignRight => 'Alinhar à direita';

  @override
  String get markdownTableDuplicateRow => 'Duplicar linha';

  @override
  String get markdownTableMoveRowUp => 'Mover linha para cima';

  @override
  String get markdownTableMoveRowDown => 'Mover linha para baixo';

  @override
  String get markdownTableClearRow => 'Limpar linha';

  @override
  String get markdownTableDuplicateColumn => 'Duplicar coluna';

  @override
  String get markdownTableMoveColumnLeft => 'Mover coluna para a esquerda';

  @override
  String get markdownTableMoveColumnRight => 'Mover coluna para a direita';

  @override
  String get markdownTableClearColumn => 'Limpar coluna';

  @override
  String get markdownTableDeleteTable => 'Excluir tabela';

  @override
  String get stashFormatClear => 'Limpar formatação';

  @override
  String get stashPolish => 'Refinar';

  @override
  String get stashPolishing => 'Refinando…';

  @override
  String get stashPolishHint =>
      'A IA deixa a seleção mais clara, com as suas palavras, sem adicionar estrutura';

  @override
  String get composerPolish => 'Aprimorar prompt';

  @override
  String get composerPolishing => 'Aprimorando…';

  @override
  String get composerPolishHint =>
      'Aprimorar prompt: o modelo auxiliar transforma a mensagem em um prompt mais claro e específico para o agente, preenchendo o que você deixou vago; imagens, arquivos, código e links permanecem como estão; Desfazer reverte';

  @override
  String composerPolishFailed(String error) {
    return 'Não foi possível aprimorar o prompt: $error';
  }

  @override
  String get generalSettingsComposerPolish => 'Botão Aprimorar Prompt';

  @override
  String get generalSettingsComposerPolishDescription =>
      'Um botão na caixa de mensagem que pede ao modelo auxiliar para transformar o que você escreveu em um prompt mais claro e específico antes de enviar';

  @override
  String get generalSettingsLiveTurnStats => 'Velocidade e Tempo ao Vivo';

  @override
  String get generalSettingsLiveTurnStatsDescription =>
      'Enquanto o agente trabalha, uma linha abaixo da resposta mostra quanto tempo o turno levou, a velocidade de escrita do modelo e os tokens até agora, atualizando em tempo real. Os números abaixo de um turno concluído sempre aparecem.';

  @override
  String usageLimitScheduled(String time) {
    return 'Limite de uso atingido · continua automaticamente após a redefinição às $time';
  }

  @override
  String usageLimitTomorrow(String time) {
    return 'amanhã $time';
  }

  @override
  String get resumeAfterResetPrompt =>
      'O limite de uso foi redefinido. Continue de onde parou.';

  @override
  String get resumeAfterLimitToggle => 'Continuar Após a Redefinição do Limite';

  @override
  String stashPolishFailed(String error) {
    return 'Não foi possível refinar: $error';
  }

  @override
  String get stashLinkTitle => 'Link';

  @override
  String get stashRemove => 'Remover';

  @override
  String get stashEdit => 'Editar';

  @override
  String get stashFormulaTitle => 'Fórmula (TeX)';

  @override
  String get stashTableTitle => 'Tabela (Markdown)';

  @override
  String get stashCodeTitle => 'Bloco de código';

  @override
  String stashBigFileTitle(String name) {
    return '“$name” tem mais de 200 MB';
  }

  @override
  String get stashBigFileDetail =>
      'Vincular a ele onde está ou copiá-lo para o stash mesmo assim?';

  @override
  String get stashBigFileLink => 'Vincular';

  @override
  String get stashBigFileCopy => 'Copiar';

  @override
  String get stashSearchPlaceholder =>
      'Pesquisar stashes e o texto em suas imagens';

  @override
  String get stashAiSearch => 'Busca com IA';

  @override
  String get stashAiSearchHint =>
      'Encontra stashes pelo significado, não só pelas palavras. Consulta o modelo: tem custo.';

  @override
  String stashAiResults(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'A IA encontrou $count',
      one: 'A IA encontrou 1',
      zero: 'A IA não encontrou nada',
    );
    return '$_temp0';
  }

  @override
  String get stashAiClear => 'Limpar';

  @override
  String stashAiSearchFailed(String error) {
    return 'A busca com IA falhou: $error';
  }

  @override
  String get stashAiNoAnswer => 'O modelo não deu uma resposta utilizável.';

  @override
  String get aiModelAuxiliary => 'Igual ao Modelo Auxiliar';

  @override
  String get aiModelFirst =>
      'Escolha um modelo primeiro: as ações de IA o usarão daí em diante';

  @override
  String get aiModelNone => 'nenhum escolhido ainda';

  @override
  String aiModelTooltip(String model) {
    return 'Modelo para ações de IA: $model';
  }

  @override
  String get stashFilterAnyTime => 'Qualquer data';

  @override
  String get stashFilterAnyProject => 'Qualquer projeto';

  @override
  String get stashFilterAnyStatus => 'Qualquer status';

  @override
  String get stashFilterOpen => 'Não concluídos';

  @override
  String get stashGroupPinned => 'Fixados';

  @override
  String get stashGroupToday => 'Hoje';

  @override
  String get stashGroupYesterday => 'Ontem';

  @override
  String get stashGroupWeek => 'Últimos 7 dias';

  @override
  String get stashGroupMonth => 'Últimos 30 dias';

  @override
  String get stashGroupEarlier => 'Anteriores';

  @override
  String get stashGroupDone => 'Concluídos';

  @override
  String get stashStatus => 'Status';

  @override
  String get stashStatusCollected => 'Coletado';

  @override
  String get stashStatusRequirement => 'Requisito';

  @override
  String get stashStatusImplementing => 'Implementando';

  @override
  String get stashStatusDone => 'Concluído';

  @override
  String stashEmpty(String hotkey) {
    return 'Nada no stash ainda.\nPressione $hotkey em qualquer app para anotar algo.';
  }

  @override
  String get stashEmptyNoHotkey =>
      'Nada no stash ainda.\nClique em + para escrever um; defina um atalho em Configurações para anotar de qualquer app.';

  @override
  String get stashNoMatch => 'Nenhum stash corresponde.';

  @override
  String get stashPin => 'Fixar';

  @override
  String get stashUnpin => 'Desafixar';

  @override
  String get stashOpenInPanel => 'Abrir em Painel Flutuante';

  @override
  String get stashLinkProject => 'Vincular ao Projeto';

  @override
  String get stashMerge => 'Mesclar';

  @override
  String stashMergeTitle(String stashes) {
    return 'Mesclar $stashes?';
  }

  @override
  String stashMergeDetail(String target) {
    return 'O texto deles vai para $target, um após o outro; os demais são removidos, e os números deles levam a ele.';
  }

  @override
  String stashMergeSuggestion(String stashes) {
    return '$stashes parecem ser a mesma coisa.';
  }

  @override
  String get stashDismiss => 'Dispensar';

  @override
  String get stashDelete => 'Excluir';

  @override
  String stashDeleteOne(String stash) {
    return 'Excluir $stash?';
  }

  @override
  String stashDeleteMany(int count) {
    return 'Excluir $count stashes?';
  }

  @override
  String get stashDeleteDetail =>
      'As imagens e os arquivos deles vão junto. Isso não pode ser desfeito.';

  @override
  String stashPicked(int count) {
    return '$count selecionados';
  }

  @override
  String get stashMarkDone => 'Marcar como Concluído';

  @override
  String get stashReopen => 'Reabrir';

  @override
  String get stashClearPicked => 'Limpar seleção';

  @override
  String get stashClose => 'Fechar Stash';

  @override
  String get stashCloseDetail => 'Fechar';

  @override
  String get stashMore => 'Mais';

  @override
  String get stashExpand => 'Esclarecer';

  @override
  String get stashExpandHint =>
      'A IA reescreve sua nota de forma clara, preenchendo o que suas imagens e arquivos mostram, sem adicionar estrutura; ela substitui o texto, e Desfazer reverte';

  @override
  String get stashClarifying => 'Esclarecendo…';

  @override
  String get stashCancelClarify => 'Parar de Esclarecer';

  @override
  String get stashClarifyFailedShort => 'Não esclarecido';

  @override
  String get stashClarifyChanged =>
      'A nota mudou enquanto era esclarecida, então nada foi substituído. Tente novamente.';

  @override
  String get stashRetry => 'Tentar Novamente';

  @override
  String stashExpandFailed(String error) {
    return 'Não foi possível esclarecer a nota: $error';
  }

  @override
  String get stashImplement => 'Implementar no BaoCode';

  @override
  String get stashImplementHow => 'Como o agente deve trabalhar nisso?';

  @override
  String get stashImplementHowDetail =>
      'Em um novo git worktree (uma branch própria, sem tocar na sua cópia de trabalho) ou diretamente no projeto como está.';

  @override
  String get stashImplementWorktree => 'Novo Worktree';

  @override
  String get stashImplementDirect => 'Diretamente';

  @override
  String stashImplementStarter(String stash) {
    return 'Implemente o que $stash pede.';
  }

  @override
  String get stashImplementInWorktree =>
      'Primeiro crie um novo git worktree em uma nova branch para este trabalho e faça-o lá; me diga a branch quando terminar.';

  @override
  String get stashImplementInPlace =>
      'Trabalhe diretamente neste projeto, na branch atual.';

  @override
  String get stashImplementComplete =>
      'Quando terminar, marque como concluído no Stash.';

  @override
  String get stashThreads => 'Conversas';

  @override
  String get stashThreadSource => 'Anotado nesta conversa';

  @override
  String get stashThreadNoReply => 'Sem resposta ainda';

  @override
  String get stashThreadGone => 'Não está mais na lista';

  @override
  String get stashOpenThread => 'Abrir';

  @override
  String stashProjectSuggestion(String project) {
    return 'A IA acha que isto é sobre $project.';
  }

  @override
  String get stashLinkIt => 'Vincular';

  @override
  String get stashSettingsDescription =>
      'Uma anotação rápida feita de qualquer app, em um painel flutuante, para virar trabalho depois.';

  @override
  String get stashSettingsHotkey => 'Atalho';

  @override
  String stashSettingsHotkeyCurrent(String hotkey) {
    return '$hotkey mostra o painel de qualquer app.';
  }

  @override
  String get stashSettingsHotkeyNone =>
      'Sem atalho: o painel só aparece na página Stash.';

  @override
  String get stashSettingsHotkeyTaken =>
      'Outro app usa este atalho; escolha outro.';

  @override
  String get stashSettingsHotkeyHelp =>
      'Clique e pressione as novas teclas; Escape mantém o atual, Delete limpa.';

  @override
  String get stashHotkeyPress => 'Pressione as teclas…';

  @override
  String get stashHotkeyRefused =>
      'Requer um modificador com uma letra, dígito ou tecla comum';

  @override
  String get stashHotkeyNone => 'Nenhum';

  @override
  String get stashHotkeyClear => 'Limpar';

  @override
  String stashHotkeySuggested(String hotkey) {
    return 'Usar $hotkey';
  }

  @override
  String get stashHotkeyGlobal => 'Mostrar o painel Stash';

  @override
  String get stashHotkeyGlobalHint =>
      'Um atalho global: funciona em qualquer app.';

  @override
  String get stashHotkeyTooltip => 'O atalho do painel; clique para alterar';

  @override
  String get stashSettingsDirectory => 'Local';

  @override
  String get stashSettingsDirectoryChange => 'Alterar…';

  @override
  String get stashSettingsDirectoryReset => 'Padrão';

  @override
  String get stashSettingsDirectoryRestart =>
      'Entra em vigor após reiniciar o BaoCode.';

  @override
  String get stashAll => 'Todos';

  @override
  String get stashAllTooltip => 'Mostrar todos os stashes';

  @override
  String get stashHintSave => 'Salvar';

  @override
  String get stashHintClose => 'Fechar';

  @override
  String get stashSaved => 'Salvo';

  @override
  String get stashFilter => 'Filtrar';

  @override
  String get stashSort => 'Ordenar';

  @override
  String get stashSortManual => 'Personalizada (arraste para ordenar)';

  @override
  String get stashSortUpdated => 'Última edição';

  @override
  String get stashSortCreated => 'Última criação';

  @override
  String get stashSortNumber => 'Número';

  @override
  String get stashOpen => 'Abrir';

  @override
  String stashCount(int count) {
    return '$count stashes';
  }

  @override
  String get stashFormatMore => 'Mais';

  @override
  String get branchBarSwitch => 'Trocar de Branch';

  @override
  String get branchBarSearch => 'Pesquisar branches';

  @override
  String get branchBarCreate => 'Criar Branch…';

  @override
  String branchBarCreateFrom(String branch) {
    return 'Criar um branch a partir de “$branch”';
  }

  @override
  String branchBarCreateIn(String folder) {
    return 'Criar um branch em “$folder”';
  }

  @override
  String get branchBarCreateButton => 'Criar';

  @override
  String get branchBarDetached => 'HEAD desanexado';

  @override
  String get branchBarRunning =>
      'Não é possível trocar de branch enquanto o agente trabalha';

  @override
  String branchBarFailed(String branch) {
    return 'Não foi possível trocar para “$branch”';
  }

  @override
  String get branchBarNotRepository => 'Não é um repositório Git';

  @override
  String get branchBarWorkspace => 'Branches das pastas';

  @override
  String get settingsSectionAccounts => 'Contas Git';

  @override
  String get settingsAccountsKeywords =>
      'GitHub GitLab entrar login token issue pull request merge request';

  @override
  String get accountsDescription =>
      'Entre no GitHub ou GitLab para ver o estado das issues e pull requests vinculadas no Stash, importar issues como stashes e respondê-las depois que você confirmar.';

  @override
  String get accountsSignedIn => 'Conectado';

  @override
  String get accountsAdd => 'Adicionar uma conta';

  @override
  String get accountsKeptLocally =>
      'Os tokens ficam no chaveiro deste computador e são enviados apenas ao GitHub ou GitLab ao qual pertencem. Nada é publicado sem a sua confirmação.';

  @override
  String get accountsGitHubHosts =>
      'github.com, ou o GitHub Enterprise da sua empresa';

  @override
  String get accountsGitLabHosts => 'gitlab.com, ou um GitLab auto-hospedado';

  @override
  String get accountsSignInBrowser => 'Entrar pelo Navegador';

  @override
  String get accountsSignInToken => 'Usar um Token…';

  @override
  String get accountsViaBrowser => 'conectado pelo navegador';

  @override
  String get accountsViaToken => 'conectado com token';

  @override
  String get accountsSignOut => 'Sair';

  @override
  String accountsSignOutTitle(String login, String forge) {
    return 'Sair da conta $login do $forge?';
  }

  @override
  String accountsSignOutDetail(String forge) {
    return 'O token é excluído deste computador. Para revogar totalmente o acesso do BaoCode, revogue-o também nas configurações do $forge.';
  }

  @override
  String accountsRevoke(String forge) {
    return 'Sair e Abrir as Configurações do $forge';
  }

  @override
  String accountsTokenTitle(String forge) {
    return 'Entrar no $forge com um Token';
  }

  @override
  String get accountsSignIn => 'Entrar';

  @override
  String get accountsHost => 'Host';

  @override
  String get accountsToken => 'Token';

  @override
  String get accountsTokenGitHubScopes =>
      'Um token clássico com os escopos repo e read:user, ou um token de granularidade fina com acesso de leitura e escrita a issues e pull requests.';

  @override
  String get accountsTokenGitLabScopes =>
      'Um token de acesso pessoal com o escopo api.';

  @override
  String accountsTokenCreate(String host) {
    return 'Criar um Token em $host';
  }

  @override
  String get accountsTokenRefused =>
      'O token não foi aceito. Verifique se está completo e não expirou.';

  @override
  String accountsBrowserTitle(String forge) {
    return 'Entrar no $forge';
  }

  @override
  String accountsBrowserDetail(String host) {
    return 'Digite este código em $host para permitir que o BaoCode acesse sua conta:';
  }

  @override
  String get accountsCopyAndOpen => 'Copiar Código e Abrir Navegador';

  @override
  String get accountsOpenAgain => 'Copiado · Abrir Novamente';

  @override
  String get accountsBrowserStarting => 'Obtendo um código…';

  @override
  String get accountsBrowserWaiting =>
      'Aguardando você autorizar no navegador…';

  @override
  String get accountsRetry => 'Tentar Novamente';

  @override
  String get forgeStateOpen => 'Aberto';

  @override
  String get forgeStateDraft => 'Rascunho';

  @override
  String get forgeStateClosed => 'Fechado';

  @override
  String get forgeStateMerged => 'Merged';

  @override
  String get forgeChecksPassed => 'Verificações aprovadas';

  @override
  String get forgeChecksFailed => 'Verificações falharam';

  @override
  String get forgeChecksRunning => 'Verificações em andamento';

  @override
  String get stashIssues => 'Issues e pull requests';

  @override
  String stashIssueClosedBanner(String tag) {
    return '$tag foi fechada. Este stash também está concluído?';
  }

  @override
  String stashIssueOpenBanner(String tag) {
    return 'Este stash está concluído, mas $tag ainda está aberta.';
  }

  @override
  String get stashIssueReplyClose => 'Responder e fechar…';

  @override
  String stashIssueNotSignedIn(String forge) {
    return 'Entre no $forge para ver o estado';
  }

  @override
  String get stashIssueSignIn => 'Entrar…';

  @override
  String get stashIssueFailed => 'Não foi possível atualizar';

  @override
  String get stashIssueOpen => 'Abrir no Navegador';

  @override
  String get stashIssueCopy => 'Copiar Link';

  @override
  String get stashIssueComment => 'Comentar…';

  @override
  String get stashIssueClose => 'Fechar Issue…';

  @override
  String get stashIssueUnlink => 'Desvincular';

  @override
  String stashWriteFixedIn(String pulls) {
    return 'Corrigido em $pulls.';
  }

  @override
  String stashWriteTitle(String tag) {
    return 'Comentar em $tag';
  }

  @override
  String stashWriteCloseTitle(String tag) {
    return 'Fechar $tag';
  }

  @override
  String get stashWriteSend => 'Comentar';

  @override
  String get stashWriteSendClose => 'Comentar e Fechar';

  @override
  String get stashWriteCloseOnly => 'Fechar Issue';

  @override
  String get stashWriteSendAnyway => 'Enviar Mesmo Assim';

  @override
  String get stashWritePlaceholder => 'Escreva um comentário (Markdown)';

  @override
  String get stashWriteAlsoClose => 'Fechar a issue também';

  @override
  String get stashWriteSensitive =>
      'Parece conter caminhos deste computador ou segredos, que todos que puderem ver a issue verão:';

  @override
  String stashWriteAs(String login, String host) {
    return 'Publicado como $login em $host.';
  }

  @override
  String stashWriteFailed(String error) {
    return 'Não enviado: $error';
  }

  @override
  String get stashImport => 'Importar de Issues…';

  @override
  String get stashImportTitle => 'Importar Issues';

  @override
  String get stashImportAction => 'Importar';

  @override
  String stashImportCount(int count) {
    return 'Importar $count';
  }

  @override
  String get stashImportPaste => 'Cole o link de uma issue ou pull request';

  @override
  String get stashImportAdd => 'Adicionar';

  @override
  String get stashImportNotALink =>
      'Não é um link de issue ou pull request do GitHub ou GitLab.';

  @override
  String stashImportSignIn(String forge) {
    return 'Entre no $forge em Configurações → Contas para listar suas issues.';
  }

  @override
  String get stashImportRepo => 'Repositório';

  @override
  String get stashImportAssigned => 'Atribuídas a mim';

  @override
  String get stashImportCreated => 'Criadas por mim';

  @override
  String get stashImportAll => 'Todas abertas';

  @override
  String get stashImportSearch => 'Pesquisar';

  @override
  String get stashImportLoading => 'Carregando…';

  @override
  String get stashImportNoRepos =>
      'Nenhum projeto tem um remoto do GitHub ou GitLab. Cole um link de issue acima.';

  @override
  String get stashImportNone => 'Nenhuma issue aberta aqui.';

  @override
  String stashImportKnown(int id) {
    return 'no Stash #$id';
  }

  @override
  String sidebarOpenPull(String tag) {
    return 'Abrir $tag';
  }

  @override
  String get stashGroupOthers => 'Outros';

  @override
  String stashFilterProjects(int count) {
    return '$count projetos';
  }

  @override
  String get stashFilterJoiner => ', ';

  @override
  String get stashWelcomeTitle => 'Conheça o Stash';

  @override
  String get stashWelcomeLead =>
      'Anote as coisas assim que elas surgirem, passe-as a um agente quando estiver pronto e veja como cada uma está andando.';

  @override
  String get stashWelcomeNoteTitle => 'Anote';

  @override
  String get stashWelcomeAgentTitle => 'Passe a um agente';

  @override
  String get stashWelcomeAgent =>
      'Clique em Implementar no BaoCode ou mencione-o em uma conversa; a conversa e o stash continuam vinculados.';

  @override
  String get stashWelcomeTrackTitle => 'Acompanhe o andamento';

  @override
  String get stashWelcomeTrack =>
      'Os cartões mostram suas conversas ao vivo, e as issues e pull requests do GitHub e GitLab vinculadas a eles ficam sincronizadas.';

  @override
  String get stashWelcomeStart => 'Começar';

  @override
  String get stashWelcomeNoteBody =>
      'Texto, capturas de tela e links entram, e cada um recebe um número próprio, como uma issue.';

  @override
  String get stashWelcomeHotkeyTitle => 'Defina um atalho para anotar';

  @override
  String get stashWelcomeHotkeySetTitle => 'Atalho definido';

  @override
  String get stashWelcomeHotkey =>
      'Pressione-o em qualquer app e o painel Stash aparece, pronto para digitar. Clique na caixa abaixo e pressione as teclas que quiser.';

  @override
  String stashWelcomeHotkeySet(String hotkey) {
    return 'Pressione $hotkey em qualquer app para anotar algo. Altere aqui ou em Configurações → Stash quando quiser.';
  }

  @override
  String get stashWelcomeHotkeyLater =>
      'Você também pode definir depois em Configurações → Stash.';

  @override
  String get settingsSectionBrowser => 'Navegador';

  @override
  String get settingsBrowserKeywords =>
      'chrome extensão edge brave arc página web aba agente';

  @override
  String get browserSettingsDescription =>
      'Deixe os agentes usarem seu próprio navegador, conectado como você: abrir páginas, lê-las, clicar e digitar nas abas que você compartilha com eles. Você pode acompanhar cada passo no painel lateral.';

  @override
  String get browserSettingsUnsupported =>
      'O navegador está disponível apenas no macOS, Windows e Linux.';

  @override
  String get browserSettingsEnabled =>
      'Permitir que os Agentes Usem o Navegador';

  @override
  String get browserSettingsEnabledDescription =>
      'Desativado, os agentes não têm ferramentas de navegador e a extensão se desconecta.';

  @override
  String get browserSettingsStatus => 'Status';

  @override
  String get browserSettingsNotInstalled =>
      'Nenhum navegador se conectou ainda';

  @override
  String get browserSettingsNotInstalledDescription =>
      'Instale a extensão por uma das opções abaixo e abra o navegador: ele se conecta automaticamente.';

  @override
  String get browserSettingsNotRunning => 'Nenhum navegador conectado';

  @override
  String get browserSettingsNotRunningDescription =>
      'Abra um navegador com a extensão do BaoCode: ele se conecta automaticamente.';

  @override
  String get browserSettingsSandboxed =>
      'Navegadores Snap e Flatpak não conseguem se conectar';

  @override
  String get browserSettingsSandboxedDescription =>
      'O sandbox deles impede o auxiliar do BaoCode de executar. Instale o navegador pelo pacote .deb ou .rpm oficial, como o Google Chrome em google.com/chrome.';

  @override
  String browserSettingsConnected(String browser) {
    return '$browser conectado';
  }

  @override
  String browserSettingsIncompatible(String browser) {
    return '$browser: a versão da extensão não corresponde';
  }

  @override
  String browserSettingsExtensionVersion(String version) {
    return 'Extensão $version';
  }

  @override
  String get browserSettingsExtensionOld =>
      'A extensão está desatualizada. Pela loja, ela atualiza automaticamente, ou clique em Atualizar em chrome://extensions; se instalada manualmente, baixe o zip novamente, substitua o conteúdo da pasta e clique em recarregar.';

  @override
  String get browserSettingsAppOld =>
      'A extensão é mais nova que este BaoCode. Atualize o BaoCode.';

  @override
  String get browserSettingsInstall => 'Obter a Extensão';

  @override
  String get browserSettingsStore => 'Chrome Web Store';

  @override
  String get browserSettingsStoreDescription =>
      'Recomendado. Atualiza automaticamente; funciona no Chrome, Edge, Brave, Arc e outros navegadores Chromium.';

  @override
  String get browserSettingsStoreOpen => 'Abrir Loja';

  @override
  String get browserSettingsUnpacked =>
      'Instalar Manualmente (Modo Desenvolvedor)';

  @override
  String get browserSettingsUnpackedDescription =>
      'Descompacte em uma pasta que você vai manter. Em chrome://extensions, ative o Modo do desenvolvedor no canto superior direito, clique em Carregar sem compactação e escolha a pasta. Não atualiza automaticamente.';

  @override
  String get browserSettingsUnpackedDownload => 'Baixar Zip';

  @override
  String get browserSettingsOpen => 'Configurações do Navegador';

  @override
  String get browserHistoryTitle => 'Histórico de depuração';

  @override
  String get browserHistoryDescription =>
      'O que as abas compartilhadas com o BaoCode fazem é guardado conforme acontece, sem precisar gravar: as páginas, as requisições, erros e avisos do console. Os agentes consultam isso quando você pede (“falhou quando eu salvei”). Fica neste computador; cookies e tokens não são guardados.';

  @override
  String get browserHistoryDetailed => 'Histórico detalhado';

  @override
  String get browserHistoryDetailedDescription =>
      'Guarda também o corpo das requisições e respostas, o que você faz (cliques e digitação, nunca senhas) e todas as mensagens do console. Ocupa mais espaço.';

  @override
  String browserHistorySize(String size) {
    return 'Usando $size';
  }

  @override
  String get browserHistoryClear => 'Limpar';

  @override
  String get browserHistoryClearConfirm => 'Limpar o histórico de depuração?';

  @override
  String get browserHistoryClearDetail =>
      'As páginas, requisições e mensagens do console guardadas são excluídas. Isso não pode ser desfeito.';

  @override
  String browserHistoryTooLarge(String size) {
    return 'O histórico de depuração do navegador ocupa $size';
  }

  @override
  String get browserHistoryTooLargeDetail =>
      'Limpe-o ou veja em Configurações → Navegador.';

  @override
  String get browserHistoryOpenSettings => 'Configurações do navegador';

  @override
  String get browserWelcomeTitle => 'Agora os agentes podem usar seu navegador';

  @override
  String get browserWelcomeLead =>
      'Com a extensão do BaoCode, os agentes abrem páginas, leem, clicam e digitam no seu próprio Chrome, conectados como você.';

  @override
  String get browserWelcomeSharedTitle => 'Só as abas que você compartilha';

  @override
  String get browserWelcomeShared =>
      'Eles trabalham apenas no grupo de abas amarelo do BaoCode; suas outras abas continuam suas.';

  @override
  String get browserWelcomeWatchTitle => 'Veja funcionando';

  @override
  String get browserWelcomeWatch =>
      'O painel lateral mostra a página ao vivo enquanto o agente a usa. Assuma o controle quando quiser.';

  @override
  String get browserWelcomeShowTitle => 'Mostre uma vez';

  @override
  String get browserWelcomeShow =>
      'Peça a um agente para observar, faça você mesmo no navegador, e ele vê cada passo que você deu.';

  @override
  String get browserWelcomeInstallTitle => 'Adicione a extensão';

  @override
  String get browserWelcomeInstall =>
      'Para Chrome, Edge, Brave e Arc. Ela se conecta sozinha, e isto fica verde.';

  @override
  String get browserWelcomeTurnedOff =>
      'O navegador está desativado em Configurações → Navegador.';

  @override
  String browserWelcomeConnected(String browser) {
    return '$browser está conectado';
  }

  @override
  String get browserWelcomeTry =>
      'Experimente dizer a um agente: “Abra baocode.dev e veja a página de download.”';

  @override
  String get browserWelcomeUnpacked => 'Zip do Modo Desenvolvedor';

  @override
  String get browserWelcomeDone => 'Entendi';

  @override
  String get cmdBrowserWelcome => 'Conectar Seu Navegador...';

  @override
  String get cmdStashWelcome => 'Conheça o Stash...';

  @override
  String get cmdModelWelcome => 'Configurar um Modelo...';

  @override
  String get modelWelcomeTitle => 'Escolha um Modelo para Começar';

  @override
  String get modelWelcomeLead =>
      'O BaoCode executa seus agentes em um modelo de sua escolha. Adicione um upstream, um serviço com uma chave de API, e seus modelos estarão prontos para uso.';

  @override
  String get modelWelcomeAnyTitle => 'Qualquer upstream';

  @override
  String get modelWelcomeAny =>
      'A API da Anthropic, o Chat Completions ou Responses da OpenAI, ou um serviço compatível com algum deles, como OpenRouter ou DeepSeek.';

  @override
  String get modelWelcomeKeysTitle => 'Suas chaves ficam com você';

  @override
  String get modelWelcomeKeys =>
      'As chaves ficam no chaveiro do sistema, e as requisições vão deste computador direto para o upstream.';

  @override
  String get modelWelcomeSwitchTitle => 'Troque quando quiser';

  @override
  String get modelWelcomeSwitch =>
      'Adicione mais upstreams quando quiser e escolha o modelo de cada conversa abaixo do campo de entrada.';

  @override
  String get modelWelcomeStepTitle => 'Adicione seu primeiro upstream';

  @override
  String get modelWelcomeStep =>
      'O endereço e a chave dele, depois os modelos a usar. Alguns serviços também podem adicionar os seus com um clique em Configurações → Modelos.';

  @override
  String get modelWelcomeReadyTitle => 'Tudo pronto';

  @override
  String modelWelcomeReady(String model) {
    return 'Novas conversas começam em $model. Escolha outro abaixo do campo de entrada quando quiser.';
  }

  @override
  String get modelWelcomeLater =>
      'Você também pode adicionar um depois em Configurações → Modelos.';

  @override
  String get modelWelcomeSkip => 'Depois';

  @override
  String get modelWelcomeStart => 'Começar a Conversar';

  @override
  String get healthNoModel =>
      'Escolha um modelo para começar: adicione um upstream e seus modelos estarão prontos para uso.';

  @override
  String get modelSetUp => 'Configurar um Modelo';

  @override
  String get claudeCoreHint =>
      'Este chat roda no core integrado do BaoCode. Recomendamos o core do Claude Code para a experiência mais completa; ele é baixado para você se necessário.';

  @override
  String get claudeCoreHintSwitch => 'Mudar para o Claude Code';

  @override
  String get claudeCoreHintLater => 'Agora Não';

  @override
  String get remoteAddServer => 'Adicionar Servidor SSH...';

  @override
  String get remoteEditServer => 'Editar';

  @override
  String get settingsSectionSsh => 'Servidores SSH';

  @override
  String get settingsSshKeywords =>
      'ssh remoto servidor host jump bastion chave senha core';

  @override
  String get sshSettingsDescription =>
      'Os servidores aos quais os projetos remotos se conectam: o endereço, como entram, um jump host e o core que cada um executa.';

  @override
  String get sshSettingsServers => 'Servidores';

  @override
  String get sshSettingsServersDescription =>
      'Os adicionados no app e os hosts que a barra lateral tem.';

  @override
  String get sshSettingsNone => 'Nenhum servidor ainda';

  @override
  String get sshSettingsAdd => 'Adicionar Servidor…';

  @override
  String get sshSettingsEdit => 'Editar…';

  @override
  String get sshSettingsConnect => 'Conectar';

  @override
  String get sshSettingsDisconnect => 'Desconectar';

  @override
  String sshSettingsDisconnectTitle(String host) {
    return 'Desconectar de $host?';
  }

  @override
  String get sshSettingsDisconnectDetail =>
      'As conversas e terminais em execução lá serão encerrados.';

  @override
  String sshSettingsCore(String core) {
    return 'Core: $core';
  }

  @override
  String sshSettingsVia(String host) {
    return 'via $host';
  }

  @override
  String get sshSettingsTyped => 'Como digitado';

  @override
  String get sshSettingsConfigHosts => 'Hosts de ~/.ssh/config';

  @override
  String get sshSettingsConfigHostsDescription =>
      'Alterados nesse arquivo; o core deles é Automático.';

  @override
  String get sshSettingsOpenConfig => 'Abrir Arquivo';

  @override
  String get sshServerAddTitle => 'Adicionar Servidor SSH';

  @override
  String get sshServerAddSubtitle =>
      'Salvo na lista remota: conecte-se a ele com um clique.';

  @override
  String sshServerEditTitle(String name) {
    return 'Editar $name';
  }

  @override
  String get sshServerHost => 'Host';

  @override
  String get sshServerHostPlaceholder =>
      'Domínio ou IP; user@host:port é separado automaticamente';

  @override
  String get sshServerPort => 'Porta';

  @override
  String get sshServerUser => 'Usuário';

  @override
  String get sshServerName => 'Nome (opcional)';

  @override
  String get sshServerNamePlaceholder => 'ex.: Produção';

  @override
  String get sshServerAuth => 'Entrar com';

  @override
  String get sshServerAuthPassword => 'Senha';

  @override
  String get sshServerAuthKey => 'Chave Privada';

  @override
  String get sshServerAuthAuto => 'Automático';

  @override
  String get sshServerAuthAutoHint =>
      'Como o ssh faz em um terminal: ssh-agent, as chaves em ~/.ssh, ~/.ssh/config. A senha é solicitada se o servidor exigir.';

  @override
  String get sshServerPasswordHint =>
      'Guardada no chaveiro do sistema. Deixe vazio para ser perguntado ao conectar.';

  @override
  String get sshServerPasswordKept => 'Salva: deixe vazio para mantê-la';

  @override
  String get sshServerKeyPlaceholder =>
      'Caminho da chave privada, ex.: ~/.ssh/id_ed25519';

  @override
  String get sshServerKeyBrowse => 'Procurar...';

  @override
  String get sshServerKeysFound => 'Chaves em ~/.ssh';

  @override
  String get sshServerKeyHint =>
      'Se a chave tiver uma senha (passphrase), ela é solicitada ao conectar.';

  @override
  String get sshServerCore => 'Core';

  @override
  String get sshServerCoreAuto => 'Automático';

  @override
  String get sshServerCoreAutoHint =>
      'O Claude Code CLI do servidor, se houver; senão, o core integrado.';

  @override
  String get sshServerCoreBuiltinHint =>
      'O core próprio do BaoCode: roda nos upstreams de Configurações → Modelos.';

  @override
  String get sshServerCoreCliHint =>
      'O Claude Code CLI do servidor, instalado lá se não houver.';

  @override
  String get sshServerJump => 'Jump Host (opcional)';

  @override
  String get sshServerNoJump => 'Nenhum: conectar diretamente';

  @override
  String get sshServerSaveConnect => 'Salvar e Conectar';

  @override
  String get sshServerSave => 'Salvar';

  @override
  String get sshServerHostRequired => 'Informe o domínio ou IP do servidor';

  @override
  String get sshServerHostInvalid => 'Sem espaços e sem começar com \'-\'';

  @override
  String get sshServerPortInvalid => 'Uma porta vai de 1 a 65535';

  @override
  String get sshServerKeyRequired => 'Escolha o arquivo da chave privada';

  @override
  String get sshServerKeyMissing => 'Esse arquivo não existe';

  @override
  String get remoteForgetHostKey => 'Remover a Chave Antiga e Conectar';

  @override
  String remoteForgetHostKeyTitle(String host) {
    return 'Remover a chave antiga de $host?';
  }

  @override
  String get remoteForgetHostKeyDetail =>
      'Somente se você sabe que o servidor foi reinstalado ou que a chave mudou: caso contrário, alguém pode estar entre você e ele. A chave atual dele é aceita na próxima conexão.';

  @override
  String get remoteForgetHostKeyButton => 'Remover e Conectar';

  @override
  String get remoteFailNoSsh =>
      'Não há ssh neste computador: instale o cliente OpenSSH.';

  @override
  String get remoteFailAuth =>
      'O servidor recusou o login: verifique o usuário, a senha ou a chave.';

  @override
  String get remoteFailCancelled => 'O login foi cancelado.';

  @override
  String get remoteFailHostKey =>
      'A chave do servidor não é conhecida, e sua configuração do ssh diz para não aceitar novas (StrictHostKeyChecking).';

  @override
  String get remoteFailHostKeyChanged =>
      'A chave do servidor mudou desde a última conexão: ele foi reinstalado, ou alguém está no meio.';

  @override
  String get remoteFailUnreachable =>
      'Não foi possível alcançar o servidor: verifique o endereço, a porta e a rede.';

  @override
  String get remoteFailWsl =>
      'O WSL não conseguiu iniciar esta distribuição: verifique se o WSL está instalado e se a distribuição aparece em wsl --list.';

  @override
  String get channelSetupTitle => 'Bem-vindo ao BaoCode';

  @override
  String get channelSetupLead =>
      'Conclua sua configuração inicial em baocode.dev. Leva cerca de 10 segundos.';

  @override
  String get channelSetupStepTitle => 'Conclua a configuração no navegador';

  @override
  String get channelSetupStep =>
      'O BaoCode abre baocode.dev no seu navegador. Quando a página disser que terminou, o BaoCode continua sozinho.';

  @override
  String get channelSetupWaitingTitle => 'Aguardando o navegador…';

  @override
  String get channelSetupWaiting =>
      'Quando a página disser que terminou, o BaoCode continua sozinho. Fechou a página sem querer? Abra-a novamente.';

  @override
  String get channelSetupOpenFailedTitle => 'O navegador não abriu';

  @override
  String get channelSetupOpenFailed =>
      'Copie este endereço e abra-o no navegador. Quando a página disser que terminou, o BaoCode continua sozinho.';

  @override
  String get channelSetupAddressCopied => 'Copiado';

  @override
  String get channelSetupOffline =>
      'Não foi possível acessar baocode.dev. Você precisa estar online para concluir a configuração.';

  @override
  String get channelSetupRetry => 'Tentar Novamente';

  @override
  String get channelSetupDoneTitle => 'Configuração concluída';

  @override
  String get channelSetupOpen => 'Concluir Configuração no Navegador';

  @override
  String get channelSetupOpenAgain => 'Abrir a Página Novamente';

  @override
  String get channelSetupNoResponse => 'O navegador não responde?';

  @override
  String get channelSetupPasteLead =>
      'Se a página mostrar um link, copie-o e cole aqui:';

  @override
  String get channelSetupPasteConfirm => 'OK';

  @override
  String get channelSetupLinkInvalid =>
      'Esse não é o link da página. Copie o link completo mostrado lá.';

  @override
  String get channelSetupLinkOther =>
      'Esse link é de outra instalação do BaoCode. Use a página que este BaoCode abriu.';

  @override
  String get channelSetupTrouble => 'Está com problemas?';

  @override
  String get channelSetupOnceTitle => 'Apenas uma vez';

  @override
  String get channelSetupOnce =>
      'Depois de concluído, isto não aparece mais, nem mesmo após uma atualização.';

  @override
  String get channelSetupPrivateTitle => 'Nada pessoal';

  @override
  String get channelSetupPrivate =>
      'A página só informa ao BaoCode onde você ouviu falar dele, como um vídeo ou um site.';

  @override
  String get channelSetupFindingTitle => 'Preparando seu canal…';

  @override
  String get channelSetupFinding => 'Só um momento.';

  @override
  String get channelSetupSiteOfflineTitle =>
      'Não foi possível acessar baocode.dev';

  @override
  String get channelSetupSiteOffline =>
      'O BaoCode precisa estar online para ler seu canal. Verifique sua conexão e tente novamente.';

  @override
  String get channelSetupUnavailableTitle => 'Este canal não está disponível';

  @override
  String get channelSetupUnavailable =>
      'O canal de onde veio este instalador ainda não tem contas configuradas. Se você o baixou por outro canal, confirme de onde veio no navegador; caso contrário, entre em contato com quem lhe deu o instalador ou baixe a edição padrão em baocode.dev.';

  @override
  String get channelSetupConfirmAgain => 'Confirmar no Navegador';

  @override
  String channelWelcomeTitle(String channel) {
    return 'Bem-vindo ao $channel';
  }

  @override
  String channelWelcomeText(String channel) {
    return 'Entre na sua conta $channel para começar.';
  }

  @override
  String get channelWelcomeSignIn => 'Entrar';

  @override
  String get channelWelcomeSigningIn => 'Entre na janela que foi aberta…';

  @override
  String get channelWelcomePreparing => 'Preparando…';

  @override
  String channelWelcomeFailed(String error) {
    return 'Não foi possível concluir o login: $error';
  }

  @override
  String get channelAccountTitle => 'Conta';

  @override
  String get channelAccountBalance => 'Saldo';

  @override
  String get channelAccountRefresh => 'Atualizar';

  @override
  String get channelAccountSignOut => 'Sair';

  @override
  String get channelAccountSignOutTitle => 'Sair?';

  @override
  String channelAccountSignOutDetail(String channel) {
    return 'Você precisará entrar no $channel novamente para continuar usando o BaoCode.';
  }

  @override
  String get channelAccountOpenSite => 'Abrir Site';

  @override
  String get channelAccountDefaultModel => 'Modelo padrão para novos chats';

  @override
  String get channelAccountNoModels =>
      'A chave em uso não dá acesso a nenhum modelo.';

  @override
  String get channelAccountKeys => 'Minhas Chaves de API';

  @override
  String get channelAccountCreateKey => 'Criar Chave';

  @override
  String get channelAccountKeyName => 'Nome';

  @override
  String get channelAccountKeyGroup => 'Grupo';

  @override
  String get channelAccountUseKey => 'Usar Esta Chave';

  @override
  String get channelAccountInUse => 'Em Uso';

  @override
  String get channelAccountNoKeys => 'Nenhuma chave de API ainda.';

  @override
  String get channelAccountSignedOut => 'Você não está conectado.';

  @override
  String get channelAccountUnavailable =>
      'Este canal não está disponível. Entre em contato com quem lhe deu o instalador.';

  @override
  String channelAccountFailed(String error) {
    return 'Algo deu errado: $error';
  }

  @override
  String channelAccountBlocked(String site, String request) {
    return '$site recusou a conexão deste computador ($request); o firewall dele pode estar bloqueando o IP da sua rede ou proxy. Tente outra rede ou acesse $site sem o proxy.';
  }

  @override
  String get settingsSectionAbout => 'Sobre';

  @override
  String get aboutTagline =>
      'Uma interface desktop incrível e fácil de usar para o Claude Code, com uma IDE ultrarrápida integrada.';

  @override
  String aboutVersion(String version, int build) {
    return 'Versão $version ($build)';
  }

  @override
  String aboutRepository(String repository) {
    return '$repository · gratuito e de código aberto, sob a GPL-3.0';
  }

  @override
  String get aboutWebsite => 'Site';

  @override
  String get aboutChangelog => 'Changelog';

  @override
  String get aboutChangelogDetail => 'O que cada versão mudou';

  @override
  String get aboutFeedback => 'Reportar um Problema';

  @override
  String get aboutFeedbackDetail =>
      'Abra uma issue no GitHub ou veja as abertas por outros';

  @override
  String get aboutOpen => 'Abrir';

  @override
  String get stashSettingsIssueSync => 'Issues como stashes';

  @override
  String get stashSettingsIssueSyncDescription =>
      'Em um projeto que é um repositório Git no GitHub ou GitLab (conectado em Contas): suas issues abertas viram stashes, uma vez cada, mantidas em sincronia nos dois sentidos. Um stash excluído ou desvinculado de sua issue não volta.';

  @override
  String get stashIssueSyncMine =>
      'Somente as atribuídas a mim ou abertas por mim';

  @override
  String get stashIssueSyncOff =>
      'Desativado: apenas as importadas ou publicadas';

  @override
  String get stashIssueLocal => 'Somente local';

  @override
  String get stashIssueAllow => 'Permitir publicar como issue';

  @override
  String get stashIssueNotPublished => 'Ainda não é uma issue';

  @override
  String stashIssuePublishTo(String repo) {
    return 'Publicar como issue de $repo…';
  }

  @override
  String get stashIssueKeepLocal => 'Manter local';

  @override
  String get stashIssuePush => 'Enviar alterações para a issue…';

  @override
  String get stashIssuePushShort => 'Enviar';

  @override
  String get stashIssueTakeRemote =>
      'Descartar alterações locais, usar as da issue';

  @override
  String get stashIssueUnlinkOwn => 'Desvincular, manter local';

  @override
  String stashIssueConflict(String tag) {
    return '$tag também foi alterada no forge. Qual versão manter?';
  }

  @override
  String get stashIssueKeepMine => 'Manter a minha (enviar)';

  @override
  String get stashIssueKeepTheirs => 'Usar a da issue';

  @override
  String stashIssueChangedHere(String tag) {
    return 'As alterações daqui ainda não estão em $tag.';
  }

  @override
  String get stashIssueDiscard => 'Descartar';

  @override
  String stashIssuePublishTitle(String repo) {
    return 'Publicar como issue de $repo';
  }

  @override
  String stashIssuePushTitle(String tag) {
    return 'Enviar alterações para $tag';
  }

  @override
  String get stashIssuePublish => 'Publicar';

  @override
  String get stashIssueNoText => '(sem descrição)';

  @override
  String stashIssuePicturesGitHub(int count, String branch) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count imagens são enviadas para o branch $branch do repositório, para a issue exibi-las.',
      one:
          '1 imagem é enviada para o branch $branch do repositório, para a issue exibi-la.',
    );
    return '$_temp0';
  }

  @override
  String stashIssuePicturesGitLab(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count imagens são enviadas para o projeto, para a issue exibi-las.',
      one: '1 imagem é enviada para o projeto, para a issue exibi-la.',
    );
    return '$_temp0';
  }

  @override
  String get stashImplementShort => 'Implementar';

  @override
  String stashImplementIssue(String issue) {
    return 'É a issue $issue: o pull request deve dizer que a corrige.';
  }

  @override
  String get stashIssueSyncAll => 'Todas as issues abertas';

  @override
  String get stashIssueChecking => 'Procurando o repositório…';

  @override
  String get stashIssueRefresh => 'Atualizar agora';

  @override
  String get stashIssuePublishButton => 'Publicar como Issue';

  @override
  String get stashIssuePushButton => 'Enviar para a Issue';

  @override
  String get stashIssueLoading => 'Carregando…';

  @override
  String get stashSyncing => 'Sincronizando issues…';

  @override
  String stashSyncingRepo(String repo, int index, int total) {
    return 'Sincronizando as issues de $repo ($index/$total)…';
  }

  @override
  String get stashSyncTooltip => 'Sincronizar issues agora';

  @override
  String stashSyncTooltipLast(String time) {
    return 'Sincronizar issues agora · última às $time';
  }

  @override
  String stashSyncFailed(String repo, String error) {
    return 'Não foi possível sincronizar as issues de $repo: $error';
  }

  @override
  String stashSyncSignIn(String forge, String repo, int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Entre no $forge para que as issues de $repo e de mais $count repositórios virem stashes.',
      one: 'Entre no $forge para que as issues de $repo virem stashes.',
    );
    return '$_temp0';
  }

  @override
  String get stashSyncingEmpty => 'Sincronizando as issues dos projetos…';

  @override
  String get stashFilterAnyIssue => 'Qualquer origem';

  @override
  String get stashFilterIssue => 'Issues';

  @override
  String get stashFilterNotIssue => 'Somente local';

  @override
  String get stashImplementEmpty =>
      'Escreva algo primeiro e depois implemente no BaoCode';

  @override
  String stashIssueDuplicateBanner(String issue, String stash) {
    return '$issue, do stash $stash mesclado neste, ainda está aberta. Fechar como duplicada?';
  }

  @override
  String get stashIssueCloseDuplicate => 'Fechar como duplicada…';

  @override
  String get stashIssueDuplicateNoIssue =>
      'Mesclado em outra nota; fechando como duplicada.';

  @override
  String get stashNewsOpened => 'Nova issue';

  @override
  String get stashNewsChanged => 'Alterada no forge';

  @override
  String get stashNewsCommented => 'Novos comentários';

  @override
  String get stashNewsClosed => 'Fechada no forge';

  @override
  String get stashNewsReopened => 'Reaberta no forge';

  @override
  String stashNewsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atualizações',
      one: '1 atualização',
    );
    return '$_temp0';
  }

  @override
  String get stashNewsCountTooltip =>
      'Mostrar só as atualizações sobre você: suas issues e pull requests, as atribuídas a você ou que citam você';

  @override
  String get stashNewsCountTooltipOn =>
      'Mostrando só as atualizações sobre você; clique para ver todas';

  @override
  String get stashFilterNews => 'Sobre você';

  @override
  String get stashMarkAllSeen => 'Marcar todas como vistas';

  @override
  String stashIssueComments(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comentários',
      one: '1 comentário',
    );
    return '$_temp0';
  }

  @override
  String get stashIssueDiscussion => 'Discussão';

  @override
  String stashIssueDiscussionAll(int count, String forge) {
    return 'Ver todos os $count no $forge';
  }

  @override
  String get stashIssueDiscussionFailed =>
      'Não foi possível carregar os comentários.';

  @override
  String get stashIssueDiscussionLoading => 'Carregando os comentários…';

  @override
  String stashDeleteAndClose(String issue) {
    return 'Excluir e fechar $issue…';
  }

  @override
  String stashDeleteOpenIssue(String issue) {
    return 'A issue $issue continua aberta no forge, a menos que também seja fechada.';
  }

  @override
  String stashIssueInSync(String issue) {
    return 'Igual a $issue';
  }

  @override
  String stashIssueSyncedAt(String time) {
    return 'sincronizado $time';
  }

  @override
  String get stashIssueNotPushed => 'Alterado aqui, ainda não enviado';

  @override
  String get stashIssueRemoteNewer => 'Alterado no forge';

  @override
  String get stashIssueBothChanged => 'Alterado aqui e no forge';

  @override
  String get stashIssueDiscussionEmpty => 'Nenhum comentário ainda';

  @override
  String get stashNewsMerged => 'Pull request mesclado';

  @override
  String get stashNewsChangesRequested => 'Alterações solicitadas';

  @override
  String get stashNewsChecksFailed => 'Verificações falharam';

  @override
  String get stashNewsMarked => 'Marcado como não lido';

  @override
  String stashNewsOther(String news) {
    return '$news (não é sobre você)';
  }

  @override
  String stashNewsSidebar(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count atualizações sobre você',
      one: '1 atualização sobre você',
    );
    return '$_temp0';
  }

  @override
  String get stashFilterAllNews => 'Qualquer atualização';

  @override
  String get stashMarkSeen => 'Marcar como lido';

  @override
  String get stashMarkUnseen => 'Marcar como não lido';

  @override
  String stashPullChecksFailedBanner(String pull) {
    return 'As verificações de $pull falharam.';
  }

  @override
  String stashPullChangesBanner(String pull) {
    return 'Foram solicitadas alterações em $pull.';
  }

  @override
  String stashPullMergedBanner(String pull) {
    return '$pull foi mesclado. Isto também está concluído?';
  }

  @override
  String get stashPullFix => 'Corrigir na própria conversa';

  @override
  String get stashPullView => 'Ver';

  @override
  String stashPullFixChecks(String pull) {
    return 'As verificações de $pull falharam. Descubra o que falhou e corrija.';
  }

  @override
  String stashPullFixChanges(String pull) {
    return 'Foram solicitadas alterações em $pull. Leia a revisão e faça-as.';
  }

  @override
  String stashWriteManyTitle(int count) {
    return 'Comentar em $count issues';
  }

  @override
  String stashWriteCloseManyTitle(int count) {
    return 'Fechar $count issues';
  }

  @override
  String stashDeleteOpenIssues(int count, String issues) {
    return 'As issues $issues deles continuam abertas no servidor, a menos que também sejam fechadas.';
  }

  @override
  String stashDeleteAndCloseMany(int count) {
    return 'Excluir e fechar $count issues…';
  }

  @override
  String get gitLogRepository => 'Repositório';

  @override
  String get gitLogSearch => 'Pesquisar mensagens; separe várias com |';

  @override
  String get gitLogClearSearch => 'Limpar pesquisa';

  @override
  String get gitLogUser => 'Usuário';

  @override
  String get gitLogAllUsers => 'Todos os usuários';

  @override
  String get gitLogMe => 'Eu';

  @override
  String get gitLogDate => 'Data';

  @override
  String get gitLogAnyDate => 'Qualquer período';

  @override
  String get gitLogLastDay => 'Últimas 24 horas';

  @override
  String get gitLogLastWeek => 'Últimos 7 dias';

  @override
  String get gitLogLastMonth => 'Últimos 30 dias';

  @override
  String get gitLogLastYear => 'Último ano';

  @override
  String get gitLogHighlight => 'Destacar';

  @override
  String get gitLogHighlightNone => 'Nada';

  @override
  String get gitLogHighlightMine => 'Meus commits';

  @override
  String get gitLogClearFilters => 'Limpar filtros';

  @override
  String get gitLogCheckout => 'Fazer checkout para...';

  @override
  String get gitLogSortTopo => 'Ordem topológica';

  @override
  String get gitLogSortDate => 'Ordem por data';

  @override
  String get gitLogLocalBranches => 'Branches locais';

  @override
  String get gitLogRemoteBranches => 'Branches remotas';

  @override
  String get gitLogTags => 'Tags';

  @override
  String get gitLogBackToLog => 'Voltar ao log';

  @override
  String get gitLogNoCommits => 'Nenhum commit corresponde.';

  @override
  String get gitLogLocalChanges => 'Alterações locais';

  @override
  String gitLogLocalChangesCount(int count) {
    return 'Alterações locais ($count)';
  }

  @override
  String get gitLogSelectCommit =>
      'Selecione um commit para ver seus detalhes.';

  @override
  String get gitLogAuthor => 'Autor';

  @override
  String get gitLogParents => 'Pai: ';

  @override
  String get gitLogShowBranches => 'Mostrar branches';

  @override
  String get gitLogHideBranches => 'Ocultar branches';

  @override
  String get gitLogShowSizes => 'Mostrar tamanhos';

  @override
  String get gitLogHideSizes => 'Ocultar tamanhos';

  @override
  String gitLogFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
    );
    return '$_temp0';
  }

  @override
  String get gitLogInNoBranch => 'Nenhuma branch tem este commit.';

  @override
  String gitLogInBranches(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count branches',
      one: '1 branch',
    );
    return 'Em $_temp0';
  }

  @override
  String get gitLogList => 'Lista';

  @override
  String get gitLogTree => 'Árvore';

  @override
  String get gitLogFilterFiles =>
      'Filtrar arquivos (* e ? correspondem a qualquer coisa)';

  @override
  String get gitLogCopyPath => 'Copiar caminho';

  @override
  String get gitLogCopyRelativePath => 'Copiar caminho relativo';

  @override
  String get gitLogBinary => 'binário';

  @override
  String get gitLogPreviousFile => 'Arquivo anterior';

  @override
  String get gitLogNextFile => 'Próximo arquivo';

  @override
  String get gitLogOpenInEditor => 'Abrir no editor';

  @override
  String get checkpointsTitle => 'Checkpoints';

  @override
  String get checkpointsDescription =>
      'Instantâneos dos projetos em que os agentes trabalham, mantidos para desfazer as alterações deles. Os de uma conversa são removidos 30 dias após ela alterar algo pela última vez.';

  @override
  String checkpointsSize(String size) {
    return 'Usando $size';
  }

  @override
  String get checkpointsMeasuring => 'Medindo…';

  @override
  String get checkpointsClear => 'Limpar';

  @override
  String get checkpointsClearing => 'Limpando…';

  @override
  String get checkpointsClearConfirm => 'Limpar os checkpoints?';

  @override
  String get checkpointsClearDetail =>
      'As alterações feitas pelos agentes em conversas que não estão abertas não poderão mais ser desfeitas. Os arquivos em si permanecem como estão.';

  @override
  String gitLogToday(String time) {
    return 'Hoje $time';
  }

  @override
  String gitLogYesterday(String time) {
    return 'Ontem $time';
  }

  @override
  String get gitLogCheckoutRevision => 'Fazer checkout da revisão';

  @override
  String get gitLogNewBranch => 'Nova branch…';

  @override
  String gitLogNewBranchAt(String commit) {
    return 'Nova branch em $commit';
  }

  @override
  String gitLogCheckoutBranch(String branch) {
    return 'Fazer checkout de \'$branch\'';
  }

  @override
  String get gitLogCopyHash => 'Copiar o hash completo';

  @override
  String get gitLogCopyRefNames => 'Copiar nome da branch ou tag';

  @override
  String gitLogCopyName(String name) {
    return 'Copiar \'$name\'';
  }

  @override
  String get gitLogLoading => 'Carregando histórico…';

  @override
  String get gitLogWorktree => 'Worktree';

  @override
  String gitLogWorktreeOf(String path) {
    return 'Worktree: $path';
  }

  @override
  String get gitLogFollowAgent => 'Seguir o agente';

  @override
  String get gitLogAgentHere => 'O agente trabalha aqui';

  @override
  String gitLogWorktreeAt(String name, String path) {
    return 'Em checkout na worktree $name\n$path';
  }

  @override
  String get gitLogMainWorktree => 'worktree principal';

  @override
  String get gitLogWorktreeMissing => 'ausente';

  @override
  String branchBarWorktree(String name, String path) {
    return 'Na worktree $name\n$path';
  }

  @override
  String get gitCommitChanges => 'Alterações';

  @override
  String get gitCommitUnversioned => 'Arquivos não versionados';

  @override
  String get gitCommitConflicts => 'Conflitos de merge';

  @override
  String get gitCommitAmend => 'Corrigir';

  @override
  String get gitCommitMessage => 'Mensagem do commit';

  @override
  String get gitCommitButton => 'Commit';

  @override
  String get gitCommitAndPush => 'Commit e push';

  @override
  String get gitCommitRollback => 'Reverter…';

  @override
  String gitCommitRollbackConfirm(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
    );
    return 'Reverter as alterações de $_temp0?';
  }

  @override
  String get gitCommitRollbackDetail =>
      'Eles voltam ao estado do último commit; arquivos ainda não commitados são excluídos.';

  @override
  String get gitCommitRollbackButton => 'Reverter';

  @override
  String get gitCommitShowDiff => 'Mostrar diferenças';

  @override
  String get gitCommitJumpToSource => 'Ir para o código-fonte';

  @override
  String get gitCommitAddToVcs => 'Adicionar ao VCS';

  @override
  String get gitCommitMarkResolved => 'Marcar como resolvido';

  @override
  String get gitCommitExpandAll => 'Expandir tudo';

  @override
  String get gitCommitCollapseAll => 'Recolher tudo';

  @override
  String get gitCommitGroupByDirectory => 'Agrupar por diretório';

  @override
  String get gitCommitEmptyMessage => 'Digite uma mensagem de commit.';

  @override
  String get gitCommitNothingSelected => 'Marque os arquivos para o commit.';

  @override
  String get gitCommitNoChanges => 'Nenhuma alteração local';

  @override
  String gitCommitSelected(int checked, int total) {
    return '$checked de $total arquivos marcados';
  }

  @override
  String get gitLogUndoCommit => 'Desfazer commit';

  @override
  String get branchBarNewWorktree => 'Nova worktree…';

  @override
  String branchBarNewWorktreeFrom(String branch, String folder) {
    return 'Uma nova branch a partir de “$branch”, em uma worktree própria ao lado de “$folder”: o agente trabalha lá e o seu checkout permanece como está';
  }

  @override
  String branchBarInWorktree(String name) {
    return 'Na worktree $name';
  }

  @override
  String branchBarWorkIn(String path, String branch) {
    return 'A partir de agora, trabalhe em $path (branch $branch): leia e edite os arquivos e execute os comandos lá.';
  }

  @override
  String get diffRevertChange => 'Reverter';

  @override
  String get diffRemoveChange => 'Remover';

  @override
  String get diffPreviousDifference => 'Diferença anterior';

  @override
  String get diffNextDifference => 'Próxima diferença';

  @override
  String diffDifferenceOf(int current, int count) {
    return '$current de $count';
  }

  @override
  String diffDifferences(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count diferenças',
      one: '1 diferença',
      zero: 'Nenhuma diferença',
    );
    return '$_temp0';
  }

  @override
  String get diffSettings => 'Configurações do visualizador';

  @override
  String get diffLayoutAuto => 'Lado a lado quando houver largura suficiente';

  @override
  String get diffSideBySide => 'Visualizador lado a lado';

  @override
  String get diffUnified => 'Visualizador unificado';

  @override
  String get diffIgnoreWhitespace =>
      'Ignorar espaços em branco no fim das linhas';

  @override
  String get diffWhitespaceNone => 'Não ignorar espaços em branco';

  @override
  String get diffIgnoreAllWhitespace => 'Ignorar todos os espaços em branco';

  @override
  String get diffCollapseUnchanged => 'Recolher trechos não alterados';

  @override
  String diffUnchangedLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linhas não alteradas',
      one: '1 linha não alterada',
    );
    return '$_temp0';
  }

  @override
  String get diffHighlightCharacters => 'Destacar caracteres';

  @override
  String get diffHighlightWords => 'Destacar palavras';

  @override
  String get diffHighlightLines => 'Destacar linhas';

  @override
  String get diffHighlightNone => 'Não destacar';

  @override
  String get diffGoToFile => 'Ir para o arquivo alterado';

  @override
  String get lineChangePrevious => 'Alteração anterior';

  @override
  String get lineChangeNext => 'Próxima alteração';

  @override
  String get lineChangeRollback => 'Reverter';

  @override
  String get lineChangeShowDiff => 'Mostrar diferenças';

  @override
  String get lineChangeCopy => 'Copiar linhas originais';

  @override
  String get cmdNextChange => 'Ir para a próxima alteração';

  @override
  String get cmdPreviousChange => 'Ir para a alteração anterior';

  @override
  String get cmdShowNextChange => 'Mostrar próxima alteração';

  @override
  String get cmdShowPreviousChange => 'Mostrar alteração anterior';

  @override
  String get gitAnnotate => 'Anotar com Git Blame';

  @override
  String get gitCloseAnnotations => 'Fechar anotações';

  @override
  String get gitLogCopyPatch => 'Copiar como patch';

  @override
  String get gitLogCherryPick => 'Cherry-pick';

  @override
  String get gitLogCompareWithLocal => 'Comparar com o local';

  @override
  String get gitLogResetToHere => 'Redefinir a branch atual para aqui';

  @override
  String get gitLogResetSoft => 'Soft: manter as alterações em stage';

  @override
  String get gitLogResetMixed => 'Mixed: manter as alterações, fora do stage';

  @override
  String get gitLogResetHard => 'Hard: descartar as alterações';

  @override
  String get gitLogResetKeep => 'Keep: manter as alterações locais';

  @override
  String gitLogResetHardConfirm(String branch, String commit) {
    return 'Redefinir “$branch” para $commit e descartar todas as alterações desde então, commitadas ou não?';
  }

  @override
  String get gitLogResetButton => 'Redefinir';

  @override
  String get gitLogRevertCommit => 'Reverter commit';

  @override
  String get gitLogEditMessage => 'Editar mensagem do commit…';

  @override
  String get gitLogDropCommit => 'Descartar commit';

  @override
  String gitLogDropConfirm(String commit, String subject) {
    return 'Remover $commit “$subject” da branch?';
  }

  @override
  String get gitLogDropButton => 'Descartar';

  @override
  String get gitLogPushUpToHere => 'Fazer push de tudo até aqui';

  @override
  String get gitLogNewTag => 'Nova tag…';

  @override
  String gitLogNewTagAt(String commit) {
    return 'Nova tag em $commit';
  }

  @override
  String get gitTagName => 'Nome da tag';

  @override
  String get gitTagMessage => 'Mensagem (opcional: uma tag anotada)';

  @override
  String get gitLogCreateTag => 'Criar tag';

  @override
  String get gitLogGoToParent => 'Ir para o commit pai';

  @override
  String get gitLogGoToChild => 'Ir para o commit filho';

  @override
  String gitLogComparedWithLocal(String commit) {
    return '$commit ↔ Local';
  }

  @override
  String get gitLogNoDifferences =>
      'Nenhuma diferença em relação à árvore de trabalho';

  @override
  String get gitLogCopyHashes => 'Copiar hashes dos commits';

  @override
  String gitLogCherryPickCount(int count) {
    return 'Cherry-pick de $count commits';
  }

  @override
  String get gitLogCompareCommits => 'Comparar commits';

  @override
  String gitLogRevertCommits(int count) {
    return 'Reverter $count commits';
  }

  @override
  String gitLogSquashCommits(int count) {
    return 'Combinar $count commits em um (squash)';
  }

  @override
  String gitLogCommitsSelected(int count) {
    return '$count commits selecionados';
  }

  @override
  String get gitLogPaths => 'Caminhos';

  @override
  String get gitLogAllPaths => 'Todos os caminhos';

  @override
  String gitLogCurrentFile(String path) {
    return 'Arquivo atual: $path';
  }

  @override
  String gitLogCurrentFolder(String path) {
    return 'Sua pasta: $path';
  }

  @override
  String gitLogPathCount(int count) {
    return '$count caminhos';
  }

  @override
  String gitLogLinesOf(String file, int start, int end) {
    return '$file: linhas $start–$end';
  }

  @override
  String get gitShowHistory => 'Mostrar histórico';

  @override
  String get gitShowHistoryForSelection => 'Mostrar histórico da seleção';

  @override
  String get gitShowBranches => 'Mostrar branches';

  @override
  String get gitHideBranches => 'Ocultar branches';

  @override
  String get gitBranchesFilter => 'Filtrar branches';

  @override
  String get gitBranchesHead => 'HEAD (branch atual)';

  @override
  String get gitBranchCheckout => 'Checkout';

  @override
  String gitBranchNewFrom(String name) {
    return 'Nova branch a partir de “$name”…';
  }

  @override
  String gitBranchCheckoutRebase(String current) {
    return 'Fazer checkout e rebase sobre “$current”';
  }

  @override
  String gitBranchCompare(String current) {
    return 'Comparar com “$current”';
  }

  @override
  String get gitBranchDiffWorkingTree =>
      'Mostrar diferenças com a árvore de trabalho';

  @override
  String gitBranchRebaseOnto(String current, String name) {
    return 'Fazer rebase de “$current” sobre “$name”';
  }

  @override
  String gitBranchMerge(String name, String current) {
    return 'Fazer merge de “$name” em “$current”';
  }

  @override
  String gitBranchPullRebase(String current) {
    return 'Pull em “$current” usando rebase';
  }

  @override
  String gitBranchPullMerge(String current) {
    return 'Pull em “$current” usando merge';
  }

  @override
  String get gitBranchUpdate => 'Atualizar';

  @override
  String get gitBranchPush => 'Push';

  @override
  String gitBranchPushTo(String upstream) {
    return 'Fazer push para $upstream';
  }

  @override
  String get gitBranchUpstream => 'Upstream';

  @override
  String get gitBranchUnsetUpstream => 'Remover upstream';

  @override
  String get gitBranchRename => 'Renomear…';

  @override
  String gitBranchRenameTitle(String name) {
    return 'Renomear a branch “$name”';
  }

  @override
  String get gitBranchRenameButton => 'Renomear';

  @override
  String get gitBranchFavorite => 'Adicionar aos favoritos';

  @override
  String get gitBranchUnfavorite => 'Remover dos favoritos';

  @override
  String get gitBranchShowOnly => 'Mostrar somente esta no log';

  @override
  String get gitBranchDelete => 'Excluir';

  @override
  String get gitTagDelete => 'Excluir tag';

  @override
  String get gitBranchDeleteButton => 'Excluir';

  @override
  String gitBranchDeleteRemoteConfirm(String name) {
    return 'Excluir a branch “$name” no remoto?';
  }

  @override
  String gitBranchNotMergedConfirm(String name) {
    return '“$name” tem commits que não foram mesclados em nenhuma outra branch. Excluir mesmo assim?';
  }

  @override
  String gitBranchDeleted(String name) {
    return 'Branch “$name” excluída.';
  }

  @override
  String gitTagDeleted(String name) {
    return 'Tag “$name” excluída.';
  }

  @override
  String get gitBranchRestore => 'Restaurar';

  @override
  String gitBranchCompared(String name, String current, int ahead, int behind) {
    return '“$name” tem $ahead commits que “$current” não tem; “$current” tem $behind que ela não tem.';
  }

  @override
  String get gitBranchCompareFiles => 'Mostrar arquivos alterados';

  @override
  String scmGraphRangeIn(String to, String from) {
    return 'Commits em “$to” que não estão em “$from”';
  }

  @override
  String get gitBranchesRecent => 'Recentes';

  @override
  String get gitBranchesSearch => 'Pesquisar branches e ações';

  @override
  String get gitUpdateProject => 'Atualizar projeto';

  @override
  String get gitCommitEllipsis => 'Commit…';

  @override
  String get gitPushEllipsis => 'Push…';

  @override
  String get gitNewBranchEllipsis => 'Nova branch…';

  @override
  String get gitCheckoutRevision => 'Fazer checkout de tag ou revisão…';

  @override
  String get gitBranchesTitle => 'Branches do Git';

  @override
  String get gitRevisionPlaceholder =>
      'Uma tag, uma branch ou um hash de commit';

  @override
  String get gitUpdateProjectDetail =>
      'Atualiza a branch atual de cada repositório com o upstream: faz merge dos novos commits ou rebase dos commits da própria branch sobre eles. As alterações locais ficam em stash enquanto isso.';

  @override
  String get gitUpdateMerge => 'Merge';

  @override
  String get gitUpdateRebase => 'Rebase';

  @override
  String get gitDontAskAgain => 'Não perguntar novamente';

  @override
  String get gitPushTitle => 'Fazer push dos commits';

  @override
  String get gitPushTags => 'Fazer push das tags';

  @override
  String get gitPushForce => 'Push forçado';

  @override
  String gitPushForceConfirm(String targets) {
    return 'Fazer push forçado para $targets?';
  }

  @override
  String get gitPushForceDetail =>
      'O que está lá é substituído pelo que você enviar (com lease: somente conforme o último fetch, para que nenhum commit mais novo de outra pessoa se perca).';

  @override
  String get gitPushNothing => 'Nada para enviar';

  @override
  String get gitPushRemote => 'Remoto';

  @override
  String get gitPushNew => 'novo';

  @override
  String get gitPushSelectCommit =>
      'Selecione um commit para ver seus arquivos';

  @override
  String get gitPushEllipsisCommand => 'Push…';

  @override
  String get gitOperationRebasing => 'Fazendo rebase';

  @override
  String get gitOperationMerging => 'Fazendo merge';

  @override
  String get gitOperationCherryPicking => 'Fazendo cherry-pick';

  @override
  String get gitOperationReverting => 'Revertendo';

  @override
  String gitOperationConflicts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conflitos restantes',
      one: '1 conflito restante',
    );
    return '$_temp0';
  }

  @override
  String get gitOperationResolved => 'conflitos resolvidos';

  @override
  String get gitOperationContinue => 'Continuar';

  @override
  String get gitOperationSkip => 'Ignorar';

  @override
  String get gitOperationAbort => 'Abortar';

  @override
  String gitOperationAbortConfirm(String what) {
    return 'Abortar? $what é interrompido e o que foi feito até agora é desfeito.';
  }

  @override
  String get gitConflictAcceptCurrent => 'Aceitar atual (nossa)';

  @override
  String get gitConflictAcceptIncoming => 'Aceitar recebida (deles)';

  @override
  String get gitConflictMerge => 'Merge…';

  @override
  String gitMergeTitle(String path) {
    return 'Mesclar revisões de $path';
  }

  @override
  String get gitMergeOurs => 'Atual (nossa)';

  @override
  String get gitMergeResult => 'Resultado';

  @override
  String get gitMergeTheirs => 'Recebida (deles)';

  @override
  String gitMergeConflictsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conflitos restantes',
      one: '1 conflito restante',
      zero: 'Todos os conflitos resolvidos',
    );
    return '$_temp0';
  }

  @override
  String gitMergeChangesApplied(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alterações aplicadas sem conflito',
      one: '1 alteração aplicada sem conflito',
      zero: '',
    );
    return '$_temp0';
  }

  @override
  String get gitMergePrevious => 'Conflito anterior';

  @override
  String get gitMergeNext => 'Próximo conflito';

  @override
  String get gitMergeApply => 'Aplicar';

  @override
  String get gitMergeAppend => 'Acrescentar';

  @override
  String get gitMergeIgnore => 'Ignorar';

  @override
  String get gitMergeAi => 'Mesclar com IA';

  @override
  String get gitMergeAiAll => 'Mesclar conflitos com IA';

  @override
  String gitMergeAiFailed(String error) {
    return 'A IA não conseguiu mesclar o conflito: $error';
  }

  @override
  String get gitMergeAiNoAnswer => 'a resposta não tinha linhas mescladas';

  @override
  String get gitMergeAcceptOurs => 'Aceitar atual';

  @override
  String get gitMergeAcceptTheirs => 'Aceitar recebida';

  @override
  String gitMergeUnresolved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count conflitos não foram resolvidos.',
      one: '1 conflito não foi resolvido.',
    );
    return '$_temp0';
  }

  @override
  String get gitMergeUnresolvedDetail =>
      'Salvar o resultado como está e marcar o arquivo como resolvido?';

  @override
  String get gitMergeSaveAnyway => 'Salvar e marcar como resolvido';

  @override
  String get gitMergeDiscard => 'Descartar o resultado do merge?';

  @override
  String get gitMergeDiscardButton => 'Descartar';

  @override
  String get gitDiffExcludeChange => 'Deixar esta alteração fora do commit';

  @override
  String get gitDiffIncludeChange => 'Incluir esta alteração no commit';

  @override
  String get gitDiffExcludeLine => 'Deixar esta linha fora do commit';

  @override
  String get gitDiffIncludeLine => 'Incluir esta linha no commit';

  @override
  String get gitChangelistActive => 'ativa';

  @override
  String get gitChangelistMoveTo => 'Mover para outra lista de alterações';

  @override
  String get gitChangelistNew => 'Nova lista de alterações…';

  @override
  String get gitChangelistCreate => 'Criar';

  @override
  String get gitChangelistName => 'Nome da lista de alterações';

  @override
  String get gitChangelistCommitOnly =>
      'Fazer commit somente desta lista de alterações';

  @override
  String get gitChangelistSetActive => 'Definir lista de alterações ativa';

  @override
  String get gitChangelistRename => 'Renomear lista de alterações…';

  @override
  String get gitChangelistRenameButton => 'Renomear';

  @override
  String get gitChangelistDelete => 'Excluir lista de alterações';

  @override
  String gitChangelistTurn(String request) {
    return 'IA: $request';
  }

  @override
  String get gitStashChangesTitle => 'Fazer stash das alterações';

  @override
  String gitStashFilesTitle(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Fazer stash de $count arquivos',
      one: 'Fazer stash de 1 arquivo',
    );
    return '$_temp0';
  }

  @override
  String get gitStashButton => 'Stash';

  @override
  String get gitStashMessage => 'Mensagem (opcional)';

  @override
  String get gitStashUntracked => 'Incluir arquivos não rastreados';

  @override
  String get gitStashBase => 'Base';

  @override
  String get gitStashApply => 'Aplicar';

  @override
  String get gitStashPop => 'Pop';

  @override
  String get gitStashAsBranch => 'Restaurar stash como branch…';

  @override
  String get gitStashCopyMessage => 'Copiar mensagem';

  @override
  String get gitStashDrop => 'Descartar…';

  @override
  String gitStashDropConfirm(String ref) {
    return 'Descartar $ref?';
  }

  @override
  String get gitStashDropButton => 'Descartar';

  @override
  String get gitStashClear => 'Limpar stashes…';

  @override
  String get gitStashClearConfirm => 'Descartar todos os stashes?';

  @override
  String get gitStashClearButton => 'Limpar';

  @override
  String get gitStashNone => 'Nenhum stash';

  @override
  String get gitStashTab => 'Stash';

  @override
  String get gitCommitTab => 'Commit';

  @override
  String get gitStashSelected => 'Fazer stash dos arquivos selecionados…';

  @override
  String get gitCommitIgnored => 'Arquivos ignorados';

  @override
  String get gitCommitShowIgnored => 'Mostrar arquivos ignorados';

  @override
  String gitCommitLongSubject(int limit) {
    return 'O assunto tem mais de $limit caracteres';
  }

  @override
  String get gitCommitNoBlankLine =>
      'Separe o assunto do corpo com uma linha em branco';

  @override
  String get gitCommitMessageHistory =>
      'Histórico de mensagens de commit (Ctrl+M)';

  @override
  String get gitCommitNoMessageHistory => 'Nenhuma mensagem ainda';

  @override
  String get gitCommitOptions => 'Opções de commit';

  @override
  String get gitCommitAuthor => 'Autor…';

  @override
  String gitCommitAuthorIs(String author) {
    return 'Autor: $author';
  }

  @override
  String get gitCommitAuthorReset => 'Usar o autor configurado';

  @override
  String get gitCommitAuthorPlaceholder => 'Nome <email>';

  @override
  String get gitCommitSignOff => 'Commit com sign-off';

  @override
  String get gitCommitRunHooks => 'Executar hooks do Git';

  @override
  String get gitCommitSignedOff => 'Com sign-off';

  @override
  String get gitCommitNoHooks => 'Hooks ignorados';

  @override
  String get gitLogInteractiveRebase => 'Rebase interativo a partir daqui…';

  @override
  String gitRebaseTitle(int count, String base) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count commits',
      one: '1 commit',
    );
    return 'Rebase de $_temp0 a partir de $base';
  }

  @override
  String get gitRebasePick => 'Pick';

  @override
  String get gitRebaseReword => 'Reword';

  @override
  String get gitRebaseEdit => 'Edit';

  @override
  String get gitRebaseSquash => 'Squash';

  @override
  String get gitRebaseFixup => 'Fixup';

  @override
  String get gitRebaseDrop => 'Drop';

  @override
  String get gitRebaseMoveUp => 'Mover para cima (Alt+Up)';

  @override
  String get gitRebaseMoveDown => 'Mover para baixo (Alt+Down)';

  @override
  String get gitRebaseMessage => 'Mensagem do commit';

  @override
  String get gitRebaseStart => 'Iniciar rebase';

  @override
  String get gitRebaseNothingBelow =>
      'O commit mais antigo mantido não pode receber squash nem fixup: não há nada abaixo dele.';

  @override
  String get gitRebaseStopped =>
      'O rebase parou: corrija o commit ou resolva os conflitos e depois clique em Continuar.';

  @override
  String get gitRebaseCleanUpWithAi => 'Organizar com IA';

  @override
  String get gitRebaseCleanUpWithAiDetail =>
      'Deixe o modelo sugerir o que aplicar fixup, squash e reword; você revisa antes de o rebase começar';

  @override
  String get gitRebaseAiPlanning => 'Planejando… (clique para parar)';

  @override
  String get gitRebaseAiNoPlan =>
      'A resposta do modelo não era uma lista de rebase destes commits.';

  @override
  String gitRebaseAiFailed(String error) {
    return 'Não foi possível organizar com IA: $error';
  }

  @override
  String gitTagPushTo(String remote) {
    return 'Fazer push da tag para $remote';
  }

  @override
  String gitTagDeleteOn(String remote) {
    return 'Excluir tag em $remote';
  }

  @override
  String gitTagDeleteOnConfirm(String name, String remote) {
    return 'Excluir a tag $name em $remote?';
  }

  @override
  String get gitRemotesManage => 'Gerenciar remotos…';

  @override
  String get gitRemotesTitle => 'Remotos do Git';

  @override
  String get gitRemotesNone => 'Nenhum remoto';

  @override
  String get gitRemoteAdd => 'Adicionar remoto';

  @override
  String get gitRemoteEdit => 'Editar remoto';

  @override
  String get gitRemoteRemove => 'Remover';

  @override
  String get gitRemoteName => 'Nome';

  @override
  String get gitRemoteUrl => 'URL';

  @override
  String gitRemoteRemoveConfirm(String name) {
    return 'Remover o remoto $name?';
  }

  @override
  String get gitRemoteRemoveDetail =>
      'As branches remotas dele vão junto; nada muda no servidor.';

  @override
  String get gitCloneTitle => 'Obter do controle de versão';

  @override
  String get gitCloneUrl => 'URL';

  @override
  String get gitCloneDirectory => 'Diretório';

  @override
  String get gitCloneBrowse => 'Procurar…';

  @override
  String get gitCloneButton => 'Clonar';

  @override
  String get gitCloning => 'Clonando…';

  @override
  String get gitCloneCommand => 'Clonar repositório…';

  @override
  String get gitReviewWithAi => 'Revisar alterações com IA';

  @override
  String get gitReviewStop => 'Parar a revisão';

  @override
  String get gitReviewBeforeCommit => 'Revisar com IA antes do commit';

  @override
  String get gitReviewRunning => 'Revisando as alterações…';

  @override
  String get gitReviewClean => 'Nenhum problema encontrado';

  @override
  String gitReviewFound(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count problemas encontrados',
      one: '1 problema encontrado',
    );
    return '$_temp0';
  }

  @override
  String get gitReviewCommitAnyway => 'Fazer commit mesmo assim';

  @override
  String get gitReviewCommitAndPushAnyway => 'Fazer commit e push mesmo assim';

  @override
  String gitReviewFailed(String error) {
    return 'Não foi possível revisar as alterações: $error';
  }

  @override
  String get gitAskAiCommit => 'Perguntar à IA sobre este commit';

  @override
  String gitAskAiCommitPrompt(String id, String subject) {
    return 'Explique o commit $id (“$subject”): o que ele altera e por quê, e qualquer coisa nele que pareça arriscada. Leia-o com `git show $id`.';
  }

  @override
  String gitAskAiCommits(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Perguntar à IA sobre estes $count commits',
      one: 'Perguntar à IA sobre este commit',
    );
    return '$_temp0';
  }

  @override
  String gitAskAiCommitsPrompt(String ids) {
    return 'Explique os commits $ids: o que eles alteram em conjunto e qualquer coisa neles que pareça arriscada. Leia-os com `git show`.';
  }

  @override
  String get gitAskAiHunk => 'Perguntar à IA sobre esta alteração';

  @override
  String gitAskAiHunkPrompt(String path, int line, String change) {
    return 'Sobre esta alteração em $path, na linha $line: explique o que ela faz e se há algo errado nela.\n\n```diff\n$change\n```';
  }

  @override
  String get gitAskAiChanges => 'Perguntar à IA sobre estas alterações';

  @override
  String gitAskAiChangesPrompt(String paths) {
    return 'Revise minhas alterações não commitadas em $paths (`git diff HEAD -- $paths`): explique o que elas fazem e aponte qualquer problema.';
  }

  @override
  String get gitAskAiConflicts => 'Pedir à IA para resolver os conflitos';

  @override
  String gitAskAiConflictsPrompt(String paths) {
    return 'Resolva os conflitos de merge em $paths: mantenha o que os dois lados pretendiam e depois me diga o que você escolheu. Não faça stage nem commit.';
  }

  @override
  String get gitLogFixup => 'Fixup com as alterações marcadas';

  @override
  String get compareWith => 'Comparar com';

  @override
  String get compareWithClipboard => 'Área de transferência';

  @override
  String compareWithClipboardLabel(String name) {
    return '$name (Área de transferência ↔ Arquivo)';
  }

  @override
  String get gitCompareWithBranch => 'Branch ou tag…';

  @override
  String get gitCompareWithRevision => 'Revisão…';

  @override
  String get gitCompareWithBranchPlaceholder =>
      'Selecione uma branch ou tag para comparar com o arquivo';

  @override
  String get gitCompareWithRevisionPlaceholder =>
      'Selecione uma revisão do arquivo para comparar';

  @override
  String gitCompareLabel(String name, String other) {
    return '$name ($other ↔ Árvore de trabalho)';
  }

  @override
  String get explorerSelectForCompare => 'Selecionar para comparar';

  @override
  String explorerCompareWithSelected(String name) {
    return 'Comparar com \'$name\'';
  }

  @override
  String compareFoldersSame(String original, String modified) {
    return '“$original” e “$modified” têm os mesmos arquivos.';
  }

  @override
  String compareFoldersPick(String original, String modified) {
    return 'Arquivos de “$original” e “$modified” que diferem em';
  }

  @override
  String compareFoldersOnlyIn(String name) {
    return 'Somente em “$name”';
  }

  @override
  String get compareFoldersModified => 'Alterado';

  @override
  String get compareWithLocalHistory => 'Histórico local…';

  @override
  String get localHistoryShow => 'Mostrar histórico local';

  @override
  String localHistoryNone(String name) {
    return 'Ainda não há histórico local de “$name”: ele é mantido conforme o arquivo é salvo.';
  }

  @override
  String localHistoryPick(String name) {
    return 'Uma versão de “$name” para comparar';
  }

  @override
  String localHistoryLabel(String name, String time) {
    return '$name (Histórico local, $time)';
  }

  @override
  String get explorerCompareSelected => 'Comparar selecionados';

  @override
  String compareFilesLabel(String original, String modified) {
    return '$original ↔ $modified';
  }

  @override
  String claudeProfileTitle(String project) {
    return 'Qual Claude usar em $project?';
  }

  @override
  String get claudeProfileMenu => 'Perfil do Claude…';
}
