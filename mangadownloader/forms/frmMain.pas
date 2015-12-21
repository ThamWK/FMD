{
        File: frmMain.pas
        License: GPLv2
        This unit is a part of Free Manga Downloader
}

unit frmMain;

{$mode objfpc}{$H+}

interface

uses
  {$ifdef windows}
  ActiveX, windows,
  {$else}
  FakeActiveX,
  {$endif}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LCLType,
  ExtCtrls, ComCtrls, Buttons, Spin, Menus, VirtualTrees, RichMemo, IniFiles,
  simpleipc, lclproc, types, strutils, LCLIntf, DefaultTranslator, EditBtn,
  FileUtil, LazUTF8Classes, TAGraph, TASources, TASeries, TATools, AnimatedGif,
  uBaseUnit, uData, uDownloadsManager, uFavoritesManager, uUpdateThread,
  uUpdateDBThread, uSilentThread, uMisc, uGetMangaInfosThread, uTranslation,
  frmDropTarget, frmAccountManager, CheckUpdate, accountmanagerdb,
  USimpleException, USimpleLogger;

type

  { TMainForm }

  TMainForm = class(TForm)
    appPropertiesMain: TApplicationProperties;
    Bevel1: TBevel;
    btAddToFavorites: TBitBtn;
    btBrowse: TSpeedButton;
    btCancelFavoritesCheck: TSpeedButton;
    btAbortCheckLatestVersion: TSpeedButton;
    btOptionBrowse: TSpeedButton;
    btChecks: TSpeedButton;
    btDonate: TImage;
    btFavoritesImport: TBitBtn;
    btFilter: TBitBtn;
    btFilterReset: TBitBtn;
    btOptionApply: TBitBtn;
    btReadOnline: TBitBtn;
    btRemoveFilter: TSpeedButton;
    btSearchClear: TSpeedButton;
    btWebsitesSearchClear: TSpeedButton;
    btUpdateList: TSpeedButton;
    btURL: TSpeedButton;
    cbOptionAutoCheckFavStartup: TCheckBox;
    cbOptionAutoCheckFavInterval: TCheckBox;
    cbOptionAutoCheckFavDownload: TCheckBox;
    cbOptionAutoCheckFavRemoveCompletedManga: TCheckBox;
    cbOptionEnableLoadCover: TCheckBox;
    cbOptionRemoveMangaNameFromChapter: TCheckBox;
    cbOptionShowDownloadToolbar: TCheckBox;
    cbOptionUpdateListNoMangaInfo: TCheckBox;
    cbOptionDigitVolume: TCheckBox;
    cbOptionDigitChapter: TCheckBox;
    cbOptionMangaFoxRemoveWatermarks: TCheckBox;
    cbOptionLiveSearch: TCheckBox;
    cbOptionUpdateListRemoveDuplicateLocalData : TCheckBox;
    cbUseRegExpr: TCheckBox;
    cbOptionProxyType: TComboBox;
    cbOptionOneInstanceOnly: TCheckBox;
    miAbortSilentThread: TMenuItem;
    mmChangelog: TMemo;
    pcAbout: TPageControl;
    pmSbMain: TPopupMenu;
    sbSaveTo: TScrollBox;
    tsAccounts: TTabSheet;
    tsAboutText: TTabSheet;
    tsChangelogText: TTabSheet;
    TransferRateToolset: TChartToolset;
    miFavoritesStopCheckNewChapter: TMenuItem;
    miFavoritesCheckNewChapter: TMenuItem;
    pnDownloadToolbarLeft: TPanel;
    pnDownloadToolbar: TPanel;
    TransferRateGraphArea: TAreaSeries;
    TransferRateGraph: TChart;
    ckDropTarget: TCheckBox;
    edOptionDefaultPath: TEdit;
    edOptionExternalParams: TEdit;
    edOptionExternalPath: TFileNameEdit;
    edSaveTo: TEdit;
    edWebsitesSearch: TEdit;
    edURL: TEdit;
    gbDropTarget: TGroupBox;
    gbOptionExternal: TGroupBox;
    IconDL: TImageList;
    IconMed: TImageList;
    IconSmall: TImageList;
    itMonitor: TTimer;
    itStartup: TIdleTimer;
    lbDefaultDownloadPath: TLabel;
    lbDropTargetOpacity: TLabel;
    lbOptionExternalParams: TLabel;
    lbOptionConnectionTimeout: TLabel;
    lbSaveTo: TLabel;
    lbOptionProxyType: TLabel;
    lbOptionRenameDigits: TLabel;
    lbFilterHint: TLabel;
    lbOptionExternal: TLabel;
    lbOptionCustomRenameHint: TLabel;
    lbOptionCustomRenameHint1: TLabel;
    lbOptionExternalParamsHint: TLabel;
    TransferRateGraphList: TListChartSource;
    medURLCut: TMenuItem;
    medURLCopy: TMenuItem;
    medURLPaste: TMenuItem;
    medURLPasteandgo: TMenuItem;
    medtURLDelete: TMenuItem;
    MenuItem15: TMenuItem;
    medURLSelectAll: TMenuItem;
    MenuItem17: TMenuItem;
    medURLUndo: TMenuItem;
    miFavoritesDownloadAll: TMenuItem;
    miDownloadViewMangaInfo: TMenuItem;
    MenuItem9: TMenuItem;
    miDownloadDeleteTask: TMenuItem;
    miDownloadDeleteTaskData: TMenuItem;
    miDownloadOpenWith: TMenuItem;
    miFavoritesOpenWith: TMenuItem;
    pnlWebsitesToolRight: TPanel;
    pnlWebsitesTool: TPanel;
    pnCustomGenre: TPanel;
    pnThumbContainer: TPanel;
    pnMainTop: TPanel;
    btVisitMyBlog: TBitBtn;
    btCheckLatestVersion: TBitBtn;
    btFavoritesCheckNewChapter: TBitBtn;
    btDownload: TBitBtn;
    btRemoveFilterLarge: TBitBtn;
    cbOptionAutoCheckLatestVersion: TCheckBox;
    cbOptionShowDeleteTaskDialog: TCheckBox;
    cbOptionBatotoShowScanGroup: TCheckBox;
    cbOptionBatotoShowAllLang: TCheckBox;
    cbOptionUseProxy: TCheckBox;
    cbSelectManga: TComboBox;
    ckFilterAction: TCheckBox;
    ckFilterHarem: TCheckBox;
    ckFilterHentai: TCheckBox;
    ckFilterHistorical: TCheckBox;
    ckFilterHorror: TCheckBox;
    ckFilterJosei: TCheckBox;
    ckFilterLolicon: TCheckBox;
    ckFilterMartialArts: TCheckBox;
    ckFilterMature: TCheckBox;
    ckFilterMecha: TCheckBox;
    ckFilterMusical: TCheckBox;
    ckFilterAdult: TCheckBox;
    ckFilterMystery: TCheckBox;
    ckFilterPsychological: TCheckBox;
    ckFilterRomance: TCheckBox;
    ckFilterSchoolLife: TCheckBox;
    ckFilterSciFi: TCheckBox;
    ckFilterSeinen: TCheckBox;
    ckFilterShotacon: TCheckBox;
    ckFilterShoujo: TCheckBox;
    ckFilterShoujoAi: TCheckBox;
    ckFilterShounen: TCheckBox;
    ckFilterAdventure: TCheckBox;
    ckFilterShounenAi: TCheckBox;
    ckFilterSliceofLife: TCheckBox;
    ckFilterSmut: TCheckBox;
    ckFilterSports: TCheckBox;
    ckFilterSupernatural: TCheckBox;
    ckFilterTragedy: TCheckBox;
    ckFilterYaoi: TCheckBox;
    ckFilterYuri: TCheckBox;
    ckFilterWeebtons: TCheckBox;
    ckFilterComedy: TCheckBox;
    cbOnlyNew: TCheckBox;
    cbAddAsStopped: TCheckBox;
    cbOptionShowQuitDialog: TCheckBox;
    cbOptionPathConvert: TCheckBox;
    cbOptionGenerateChapterName: TCheckBox;
    cbOptionGenerateMangaFolderName: TCheckBox;
    cbOptionMinimizeToTray: TCheckBox;
    cbOptionAutoNumberChapter: TCheckBox;
    cbSearchFromAllSites: TCheckBox;
    ckFilterDoujinshi: TCheckBox;
    ckFilterDrama: TCheckBox;
    ckFilterEchi: TCheckBox;
    ckFilterFantasy: TCheckBox;
    ckFilterGenderBender: TCheckBox;
    cbFilterStatus: TComboBox;
    cbLanguages: TComboBox;
    cbOptionLetFMDDo: TComboBox;
    edFilterSummary: TEdit;
    edFilterTitle: TEdit;
    edFilterAuthors: TEdit;
    edFilterArtists: TEdit;
    edCustomGenres: TEdit;
    edOptionCustomRename: TEdit;
    edOptionHost: TEdit;
    edOptionPass: TEdit;
    edOptionPort: TEdit;
    edOptionUser: TEdit;
    edSearch: TEdit;
    gbDialogs: TGroupBox;
    gbOptionProxy: TGroupBox;
    gbOptionRenaming: TGroupBox;
    gbOptionFavorites: TGroupBox;
    gbMisc: TGroupBox;
    IconList: TImageList;
    itSaveDownloadedList: TIdleTimer;
    itRefreshDLInfo: TIdleTimer;
    itCheckFav: TIdleTimer;
    itAnimate: TIdleTimer;
    imCover: TImage;
    lbOptionCustomRename: TLabel;
    lbOptionPDFQuality: TLabel;
    lbOptionAutoCheckFavIntervalMinutes: TLabel;
    lbOptionLetFMDDo: TLabel;
    lbOptionNewMangaTime: TLabel;
    lbOptionLanguage: TLabel;
    lbOptionDialogs: TLabel;
    lbFilterCustomGenres: TLabel;
    lbFilterSummary: TLabel;
    lbFilterStatus: TLabel;
    lbFilterTitle: TLabel;
    lbFilterAuthors: TLabel;
    lbFilterArtists: TLabel;
    lbMode: TLabel;
    lbOptionHost: TLabel;
    lbOptionMaxParallel: TLabel;
    lbOptionMaxRetry: TLabel;
    lbOptionMaxThread: TLabel;
    lbOptionPass: TLabel;
    lbOptionPort: TLabel;
    lbOptionUser: TLabel;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    miFavoritesViewInfos: TMenuItem;
    miChapterListHighlight: TMenuItem;
    mnDownload1Click: TMenuItem;
    mnUpdate1Click: TMenuItem;
    miMangaListDownloadAll: TMenuItem;
    miMangaListViewInfos: TMenuItem;
    mnUpdateList: TMenuItem;
    mnUpdateDownFromServer: TMenuItem;
    miDownloadMergeCompleted: TMenuItem;
    miFavoritesOpenFolder: TMenuItem;
    miHighlightNewManga: TMenuItem;
    miI2: TMenuItem;
    miDownloadOpenFolder: TMenuItem;
    miFavoritesDelete: TMenuItem;
    miMangaListAddToFavorites: TMenuItem;
    miFavoritesChangeCurrentChapter: TMenuItem;
    miFavoritesChangeSaveTo: TMenuItem;
    miDownloadDeleteCompleted: TMenuItem;
    miDownloadStop: TMenuItem;
    miChapterListCheckAll: TMenuItem;
    miChapterListUncheckSelected: TMenuItem;
    miChapterListCheckSelected: TMenuItem;
    miI1: TMenuItem;
    miDownloadResume: TMenuItem;
    miDownloadDelete: TMenuItem;
    miChapterListUncheckAll: TMenuItem;
    pcLeft: TPageControl;
    pbWait: TPaintBox;
    pmChapterList: TPopupMenu;
    pnOptions: TPageControl;
    pnChapterList: TPanel;
    pnFilter: TPanel;
    pnGenres: TPanel;
    pcMain: TPageControl;
    pnInfomation: TPanel;
    pmDownload: TPopupMenu;
    pmFavorites: TPopupMenu;
    pmMangaList: TPopupMenu;
    pmUpdate: TPopupMenu;
    pmEditURL: TPopupMenu;
    rbOne: TRadioButton;
    rbAll: TRadioButton;
    rgDropTargetMode: TRadioGroup;
    rgOptionCompress: TRadioGroup;
    rmAbout: TRichMemo;
    rmInformation: TRichMemo;
    sbFilter: TScrollBox;
    sbInformation: TScrollBox;
    sbDownloadConnections: TScrollBox;
    dlgSaveTo: TSelectDirectoryDialog;
    seOptionMaxParallel: TSpinEdit;
    seOptionMaxRetry: TSpinEdit;
    seOptionConnectionTimeout: TSpinEdit;
    seOptionMaxThread: TSpinEdit;
    seOptionNewMangaTime: TSpinEdit;
    seOptionAutoCheckFavIntervalMinutes: TSpinEdit;
    seOptionPDFQuality: TSpinEdit;
    seOptionDigitVolume: TSpinEdit;
    seOptionDigitChapter: TSpinEdit;
    btAbortUpdateList: TSpeedButton;
    spInfos: TSplitter;
    spMainSplitter: TSplitter;
    sbMain: TStatusBar;
    sbUpdateList: TStatusBar;
    tbDropTargetOpacity: TTrackBar;
    tbWebsitesCollapseAll: TToolButton;
    tbWebsitesExpandAll: TToolButton;
    ToolBarWebsites: TToolBar;
    tsView: TTabSheet;
    tmBackup: TIdleTimer;
    ToolBarDownload: TToolBar;
    tbDownloadResumeAll: TToolButton;
    tbDownloadStopAll: TToolButton;
    ToolButton1: TToolButton;
    tbDownloadDeleteCompleted: TToolButton;
    tvDownloadFilter: TTreeView;
    tsDownloadFilter: TTabSheet;
    tsMangaList: TTabSheet;
    tsMisc: TTabSheet;
    tsUpdate: TTabSheet;
    tsAbout: TTabSheet;
    tsWebsites: TTabSheet;
    tsDialogs: TTabSheet;
    TrayIcon: TTrayIcon;
    tsGeneral: TTabSheet;
    tsFavorites: TTabSheet;
    tsSaveTo: TTabSheet;
    tsConnections: TTabSheet;
    tsOption: TTabSheet;
    tsFilter: TTabSheet;
    tsInformation: TTabSheet;
    tsDownload: TTabSheet;
    clbChapterList: TVirtualStringTree;
    vtOptionMangaSiteSelection: TVirtualStringTree;
    vtFavorites: TVirtualStringTree;
    vtDownload: TVirtualStringTree;
    vtMangaList: TVirtualStringTree;
    mangaCover: TPicture;

    procedure appPropertiesMainShowHint(var HintStr: String;
      var CanShow: Boolean; var HintInfo: THintInfo);
    procedure btAddToFavoritesClick(Sender: TObject);
    procedure btAbortUpdateListClick(Sender: TObject);
    procedure btAbortCheckLatestVersionClick(Sender: TObject);
    procedure btCancelFavoritesCheckClick(Sender: TObject);
    procedure btChecksClick(Sender: TObject);
    procedure btCheckLatestVersionClick(Sender: TObject);
    procedure btDonateClick(Sender: TObject);
    procedure btFavoritesImportClick(Sender: TObject);
    procedure btReadOnlineClick(Sender: TObject);
    procedure btSearchClearClick(Sender: TObject);
    procedure btUpdateListClick(Sender: TObject);
    procedure btURLClick(Sender: TObject);
    procedure btVisitMyBlogClick(Sender: TObject);
    procedure btWebsitesSearchClearClick(Sender: TObject);
    procedure cbOptionAutoCheckFavIntervalChange(Sender: TObject);
    procedure cbOptionDigitChapterChange(Sender: TObject);
    procedure cbOptionDigitVolumeChange(Sender: TObject);
    procedure cbSelectMangaChange(Sender: TObject);
    procedure clbChapterListBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure clbChapterListFreeNode(Sender : TBaseVirtualTree;
      Node : PVirtualNode);
    procedure clbChapterListGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure clbChapterListGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: String);
    procedure clbChapterListInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure edSearchChange(Sender: TObject);
    procedure edSearchKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure edURLKeyPress(Sender: TObject; var Key: Char);
    procedure edWebsitesSearchChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);

    procedure btBrowseClick(Sender: TObject);
    procedure btOptionBrowseClick(Sender: TObject);
    procedure btDownloadClick(Sender: TObject);
    procedure btFavoritesCheckNewChapterClick(Sender: TObject);
    procedure btOptionApplyClick(Sender: TObject);

    procedure btFilterClick(Sender: TObject);
    procedure btFilterResetClick(Sender: TObject);
    procedure btRemoveFilterClick(Sender: TObject);

    procedure cbAddAsStoppedChange(Sender: TObject);
    procedure cbOptionUseProxyChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormWindowStateChange(Sender: TObject);
    procedure itAnimateTimer(Sender: TObject);
    procedure itCheckFavTimer(Sender: TObject);
    procedure itMonitorTimer(Sender: TObject);
    procedure itRefreshDLInfoStartTimer(Sender: TObject);
    procedure itRefreshDLInfoStopTimer(Sender: TObject);
    procedure itRefreshDLInfoTimer(Sender: TObject);
    procedure itSaveDownloadedListTimer(Sender: TObject);
    procedure itStartupTimer(Sender: TObject);
    procedure medURLCutClick(Sender: TObject);
    procedure medURLCopyClick(Sender: TObject);
    procedure medURLPasteClick(Sender: TObject);
    procedure medURLPasteandgoClick(Sender: TObject);
    procedure medtURLDeleteClick(Sender: TObject);
    procedure medURLSelectAllClick(Sender: TObject);
    procedure medURLUndoClick(Sender: TObject);
    procedure miAbortSilentThreadClick(Sender: TObject);
    procedure miDownloadViewMangaInfoClick(Sender: TObject);
    procedure miChapterListHighlightClick(Sender: TObject);
    procedure miDownloadDeleteTaskClick(Sender: TObject);
    procedure miDownloadMergeCompletedClick(Sender: TObject);
    procedure miFavoritesCheckNewChapterClick(Sender: TObject);
    procedure miFavoritesDownloadAllClick(Sender: TObject);
    procedure miFavoritesStopCheckNewChapterClick(Sender: TObject);
    procedure miFavoritesViewInfosClick(Sender: TObject);
    procedure miHighlightNewMangaClick(Sender: TObject);

    procedure miFavoritesDeleteClick(Sender: TObject);
    procedure miMangaListAddToFavoritesClick(Sender: TObject);
    procedure miFavoritesChangeCurrentChapterClick(Sender: TObject);
    procedure miFavoritesChangeSaveToClick(Sender: TObject);

    procedure miChapterListCheckSelectedClick(Sender: TObject);
    procedure miChapterListUncheckSelectedClick(Sender: TObject);
    procedure miChapterListCheckAllClick(Sender: TObject);
    procedure miChapterListUncheckAllClick(Sender: TObject);

    procedure miDownloadDeleteCompletedClick(Sender: TObject);
    procedure miDownloadResumeClick(Sender: TObject);
    procedure miDownloadStopClick(Sender: TObject);
    procedure miMangaListDownloadAllClick(Sender: TObject);
    procedure miMangaListViewInfosClick(Sender: TObject);
    procedure miFavoritesOpenFolderClick(Sender: TObject);
    procedure miDownloadOpenFolderClick(Sender: TObject);
    procedure miFavoritesOpenWithClick(Sender: TObject);
    procedure miDownloadOpenWithClick(Sender: TObject);
    procedure mnDownload1ClickClick(Sender: TObject);
    procedure mnUpdate1ClickClick(Sender: TObject);
    procedure mnUpdateDownFromServerClick(Sender: TObject);
    procedure mnUpdateListClick(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure pmDownloadPopup(Sender: TObject);
    procedure pmEditURLPopup(Sender: TObject);
    procedure pmFavoritesPopup(Sender: TObject);
    procedure pmMangaListPopup(Sender: TObject);
    procedure pmSbMainPopup(Sender: TObject);
    procedure sbUpdateListDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure seOptionAutoCheckFavIntervalMinutesChange(Sender: TObject);
    procedure spMainSplitterMoved(Sender: TObject);
    procedure tbDownloadDeleteCompletedClick(Sender: TObject);
    procedure tbDownloadResumeAllClick(Sender: TObject);
    procedure tbDownloadStopAllClick(Sender: TObject);
    procedure tbDropTargetOpacityChange(Sender: TObject);
    procedure tbWebsitesCollapseAllClick(Sender: TObject);
    procedure tbWebsitesExpandAllClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure tvDownloadFilterSelectionChanged(Sender: TObject);
    procedure UniqueInstanceFMDOtherInstance(Sender: TObject;
      ParamCount: Integer; Parameters: array of String);
    procedure vtDownloadAfterCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      const CellRect: TRect);
    procedure vtDownloadColumnDblClick(Sender: TBaseVirtualTree;
      Column: TColumnIndex; Shift: TShiftState);
    procedure vtDownloadDragAllowed(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
    procedure vtDownloadDragDrop(Sender : TBaseVirtualTree; Source : TObject;
      DataObject : IDataObject; Formats : TFormatArray; Shift : TShiftState;
      const Pt : TPoint; var Effect : LongWord; Mode : TDropMode);
    procedure vtDownloadDragOver(Sender : TBaseVirtualTree; Source : TObject;
      Shift : TShiftState; State : TDragState; const Pt : TPoint;
      Mode : TDropMode; var Effect : LongWord; var Accept : Boolean);
    procedure vtDownloadFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtDownloadGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: String);
    procedure vtDownloadGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vtDownloadGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure vtDownloadHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vtDownloadInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtDownloadKeyDown(Sender : TObject; var Key : Word;
      Shift : TShiftState);
    procedure vtDownloadKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure vtFavoritesBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vtFavoritesColumnDblClick(Sender: TBaseVirtualTree;
      Column: TColumnIndex; Shift: TShiftState);
    procedure vtFavoritesFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtFavoritesGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: String);
    procedure vtFavoritesGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vtFavoritesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure vtFavoritesHeaderClick(Sender: TVTHeader; Column: TColumnIndex;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure vtFavoritesInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vtMangaListChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vtMangaListColumnDblClick(Sender: TBaseVirtualTree;
      Column: TColumnIndex; Shift: TShiftState);
    procedure vtMangaListDragAllowed(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
    procedure vtMangaListDragOver(Sender : TBaseVirtualTree; Source : TObject;
      Shift : TShiftState; State : TDragState; const Pt : TPoint;
      Mode : TDropMode; var Effect : LongWord; var Accept : Boolean);
    procedure vtMangaListBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vtMangaListGetCursor(Sender: TBaseVirtualTree;
      var ACursor: TCursor);
    procedure vtMangaListGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: String);
    procedure vtMangaListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure tmBackupTimer(Sender: TObject);
    procedure vtOptionMangaSiteSelectionChange(Sender : TBaseVirtualTree;
      Node : PVirtualNode);
    procedure vtOptionMangaSiteSelectionFocusChanged(Sender : TBaseVirtualTree;
      Node : PVirtualNode; Column : TColumnIndex);
    procedure vtOptionMangaSiteSelectionFreeNode(Sender : TBaseVirtualTree;
      Node : PVirtualNode);
    procedure vtOptionMangaSiteSelectionGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vtOptionMangaSiteSelectionGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: String);
    procedure vtOptionMangaSiteSelectionInitNode(Sender: TBaseVirtualTree;
      ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure DisableAddToFavorites(webs: String);
  private
    PrevWindowState: TWindowState;
    procedure vtDownloadMoveItems(NextIndex : Cardinal; Mode : TDropMode);
  protected
    procedure FMDInstanceReceiveMsg(Sender: TObject);
    procedure ClearChapterListState;
  public
    ulTotalPtr, ulWorkPtr: Integer;
    optionMangaSiteSelectionNodes: array of PVirtualNode;
    LastSearchStr, LastSearchWeb: String;
    isStartup, isExiting, isRunDownloadFilter, isUpdating: Boolean;
    revisionIni, updates, mangalistIni, options: TIniFile;
    FavoriteManager: TFavoriteManager;
    dataProcess: TDBDataProcess;
    mangaInfo: TMangaInfo;
    ChapterList: array of TChapterStateItem;
    DLManager: TDownloadManager;
    updateDB: TUpdateDBThread;
    updateList: TUpdateMangaManagerThread;
    SilentThreadManager: TSilentThreadManager;
    // animation gif
    gifWaiting: TAnimatedGif;
    gifWaitingRect: TRect;

    // doing stuff like get manga info, compress, ...
    GetInfosThread: TGetMangaInfosThread;
    isGetMangaInfos: Boolean;

    // check update
    CheckUpdateThread: TCheckUpdateThread;

    // repaint treeview
    procedure tvDownloadFilterRepaint;

    // generate >> nodes
    procedure GeneratetvDownloadFilterNodes;

    // load about information
    procedure LoadAbout;

    procedure CloseNow;

    // en: Too lazy to add it one by one
    procedure InitCheckboxes;

    // download task filters
    procedure ShowTasks(Status: TDownloadStatusTypes = []);

    procedure ShowTasksOnCertainDays(const L, H: longint);
    procedure ShowTodayTasks;
    procedure ShowYesterdayTasks;
    procedure ShowOneWeekTasks;
    procedure ShowOneMonthTasks;
    procedure vtDownloadFilters;

    procedure AddChapterNameToList;

    // Create silent thread
    procedure AddSilentThread(URL: string);

    // Add text to TRichMemo
    procedure AddTextToInfo(title, infoText: String);

    // Show manga information
    procedure ShowInformation(const title, website, link: String);

    // get manga list from server
    procedure RunGetList;

    // Load config from config.ini
    procedure LoadOptions;
    procedure SaveOptions;
    procedure ApplyOptions;

    // Load config from mangalist.ini
    procedure LoadMangaOptions;

    function SaveMangaOptions: String;

    procedure UpdateVtChapter;
    procedure UpdateVtDownload;
    procedure UpdateVtFavorites;

    // Load form information, like previous position, size, ...
    procedure LoadFormInformation;
    procedure SaveFormInformation;
    procedure SaveDropTargetFormInformation;

    // load language from file
    procedure CollectLanguagesFromFiles;
    procedure ApplyLanguage;

    // openwith
    procedure OpenWithExternalProgram(const dirPath, Filename: String);

    // transfer rate graph
    procedure TransferRateGraphInit(xCount: Integer = 10);
    procedure TransferRateGraphAddItem(TransferRate: Integer);

    // exit counter
    function ShowExitCounter: Boolean;

    // open db with thread
    procedure OpenDataDB(const AWebsite: String);

    // search db with thread
    procedure SearchDataDB(const ATitle: String);

    // exception handle
    procedure ExceptionHandler(Sender: TObject; E: Exception);
    { public declarations }
  end;

  { TOpenDBThread }

  TOpenDBThread = class(TThread)
  private
    FWebsite: String;
  protected
    procedure SetControlEnabled(const Value: Boolean);
    procedure SyncOpenStart;
    procedure SyncOpenFinish;
    procedure Execute; override;
  public
    constructor Create(const AWebsite: String);
    destructor Destroy; override;
  end;

  { TSearchDBThread }

  TSearchDBThread = class(TThread)
  private
    FSearchStr: String;
    FNewSearch: Boolean;
  protected
    procedure SyncBeforeSearch;
    procedure SyncAfterSearch;
    procedure Execute; override;
  public
    constructor Create(const ASearchStr: String);
    destructor Destroy; override;
    procedure NewSearch(const ASearchStr: String);
  end;

  procedure AdvanceLoadHTTPConfig(const HTTP: THTTPSendThread; Website: String);

var
  //Instance
  FMDInstance: TSimpleIPCServer;

  MainForm: TMainForm;
  INIAdvanced: TIniFileR;

  // update fmd through main thread
  DoAfterFMD: TFMDDo;
  IsDlgCounter: Boolean = False;
  FUpdateURL: String;

const
  CL_HLBlueMarks = $FDC594;
  CL_HLGreenMarks = $B8FFB8;
  CL_HLRedMarks = $008080FF;

resourcestring
  RS_FilterStatusItems = 'Completed'#13#10'Ongoing'#13#10'<none>';
  RS_OptionFMDDoItems = 'Do nothing'#13#10'Exit FMD'#13#10'Shutdown'#13#10'Hibernate';
  RS_DropTargetModeItems = 'Download all'#13#10'Add to favorites';

  RS_HintFavoriteProblem = 'There is a problem with this data!'#13#10
                         + 'Removing and re-adding this data may fix the problem.';
  RS_DlgTitleExistInDLlist = 'This title are already in download list.'#13#10
                           + 'Do you want to download it anyway?';
  RS_DlgQuit = 'Are you sure you want to exit?';
  RS_DlgRemoveTask = 'Are you sure you want to delete the task(s)?';
  RS_DlgRemoveFavorite = 'Are you sure you want to delete the favorite(s)?';
  RS_DlgURLNotSupport = 'URL not supported!';
  RS_DlgUpdaterIsRunning = 'Updater is running!';
  RS_DlgTypeInNewChapter = 'Type in new chapter:';
  RS_DlgTypeInNewSavePath = 'Type in new save path:';
  RS_DlgUpdaterWantToUpdateDB = 'Do you want to download manga list from the server?';
  RS_DlgRemoveFinishTasks = 'Are you sure you want to delete all finished tasks?';
  RS_DlgMangaListSelect = 'You must choose at least 1 manga website!';
  RS_DlgCannotGetMangaInfo = 'Cannot get manga info. Please check your internet connection and try it again.';
  RS_DlgCannotConnectToServer = 'Cannot connect to the server.';
  RS_LblOptionExternalParamsHint = '%s : Path to the manga'#13#10+
                                   '%s : Chapter filename'#13#10+
                                   #13#10+
                                   'Example : "%s%s"';
  RS_LblAutoCheckNewChapterMinute = 'Auto check for new chapter every %d minutes';
  RS_BtnOK = '&OK';
  RS_Loading = 'Loading ...';
  RS_Checking = 'Checking...';
  RS_AllDownloads = 'All downloads';
  RS_InProgress = 'In progress';
  RS_History = 'History';
  RS_Today = 'Today';
  RS_Yesterday = 'Yesterday';
  RS_OneWeek = 'One week';
  RS_OneMonth = 'One month';
  RS_Import = 'Import';
  RS_Software = 'Software';
  RS_SoftwarePath = 'Path to the software (e.g. C:\MangaDownloader)';
  RS_Cancel = 'Cancel';
  RS_ModeAll = 'Mode: Show all (%d)';
  RS_ModeFiltered = 'Mode: Filtered (%d)';
  RS_Selected = 'Selected: %d';
  RS_InfoWebsite = 'Website:';
  RS_InfoTitle = 'Title:';
  RS_InfoAuthors = 'Author(s):';
  RS_InfoArtists = 'Artist(s):';
  RS_InfoGenres = 'Genre(s):';
  RS_InfoStatus = 'Status:';
  RS_InfoSummary = 'Summary:';
  RS_FMDAlreadyRunning = 'Free Manga Downloader already running!';
  RS_ModeSearching = 'Mode: Searching...';

implementation

{$R *.lfm}

uses
  frmImportFavorites, frmShutdownCounter, WebsiteModules, RegExpr, Clipbrd,
  LazFileUtils, LazUTF8;

var
  // thread for open db
  OpenDBThread: TOpenDBThread;

  // thread for search db
  SearchDBThread: TSearchDBThread;

  // ...
  UpdateStatusTextStyle: TTextStyle;

procedure ChangeAllCursor(const ParentControl: TWinControl; const Cur: TCursor);
var
  i: Integer;
begin
  if ParentControl = nil then Exit;
  ParentControl.Cursor := Cur;
  if ParentControl.ControlCount > 0 then
    for i := 0 to ParentControl.ControlCount - 1 do
      ParentControl.Controls[i].Cursor := Cur;
end;

procedure AdvanceLoadHTTPConfig(const HTTP: THTTPSendThread; Website: String);
begin
  if HTTP = nil then Exit;
  if Website = '' then Exit;
  HTTP.UserAgent := INIAdvanced.ReadString('UserAgent', Website, '');
  HTTP.Cookies.Text := INIAdvanced.ReadString('Cookies', Website, '');
end;

{ TSearchDBThread }

procedure TSearchDBThread.SyncBeforeSearch;
begin
  with MainForm do
  begin
    vtMangaList.Cursor := crHourGlass;
    vtMangaList.Clear;
    lbMode.Caption := RS_ModeSearching;
  end;
end;

procedure TSearchDBThread.SyncAfterSearch;
begin
  with MainForm do
  begin
    if dataProcess.Filtered then
      lbMode.Caption := Format(RS_ModeFiltered, [dataProcess.RecordCount])
    else
      lbMode.Caption := Format(RS_ModeAll, [dataProcess.RecordCount]);
    LastSearchWeb := dataProcess.Website;
    LastSearchStr := UpCase(FSearchStr);
    vtMangaList.BeginUpdate;
    vtMangaList.RootNodeCount := dataProcess.RecordCount;
    vtMangaList.EndUpdate;
    vtMangaList.Cursor := crDefault;
  end;
end;

procedure TSearchDBThread.Execute;
begin
  if MainForm.dataProcess <> nil then
  begin
    Synchronize(@SyncBeforeSearch);
    while FNewSearch do
    begin
      FNewSearch := False;
      MainForm.dataProcess.Search(FSearchStr);
    end;
    if not Terminated then
      Synchronize(@SyncAfterSearch);
  end;
end;

constructor TSearchDBThread.Create(const ASearchStr: String);
begin
  FreeOnTerminate := True;
  FSearchStr := ASearchStr;
  FNewSearch := True;
  inherited Create(False);
end;

destructor TSearchDBThread.Destroy;
begin
  SearchDBThread := nil;
  inherited Destroy;
end;

procedure TSearchDBThread.NewSearch(const ASearchStr: String);
begin
  if ASearchStr <> FSearchStr then
  begin
    FSearchStr := ASearchStr;
    FNewSearch := True;
  end;
end;

{ TOpenDBThread }

procedure TOpenDBThread.SetControlEnabled(const Value: Boolean);
begin
  with MainForm do
  begin
    cbSelectManga.Enabled := Value;
    btUpdateList.Enabled := Value;
    edSearch.Enabled := Value;
    btSearchClear.Enabled := Value;
    btRemoveFilter.Enabled := Value;
  end;
end;

procedure TOpenDBThread.SyncOpenStart;
begin
  with MainForm do
  begin
    ChangeAllCursor(tsMangaList, crHourGlass);
    SetControlEnabled(False);
    lbMode.Caption := RS_Loading;
    vtMangaList.Clear;
  end;
end;

procedure TOpenDBThread.SyncOpenFinish;
begin
  with MainForm do
  begin
    LastSearchStr := upcase(edSearch.Text);
    LastSearchWeb := currentWebsite;
    if dataProcess.Filtered then
      lbMode.Caption := Format(RS_ModeFiltered, [dataProcess.RecordCount])
    else
      lbMode.Caption := Format(RS_ModeAll, [dataProcess.RecordCount]);
    SetControlEnabled(True);
    vtMangaList.BeginUpdate;
    vtMangaList.RootNodeCount := dataProcess.RecordCount;
    vtMangaList.EndUpdate;
    ChangeAllCursor(tsMangaList, crDefault);
  end;
end;

procedure TOpenDBThread.Execute;
begin
  if (FWebsite <> '') and (MainForm.dataProcess <> nil) then
  begin
    Synchronize(@SyncOpenStart);
    if MainForm.dataProcess <> nil then
    begin
      MainForm.dataProcess.Open(FWebsite);
      if MainForm.edSearch.Text <> '' then
        MainForm.dataProcess.Search(MainForm.edSearch.Text);
    end;
    if not Terminated then
    Synchronize(@SyncOpenFinish);
  end;
end;

constructor TOpenDBThread.Create(const AWebsite: String);
begin
  FreeOnTerminate := True;
  FWebsite := AWebsite;
  inherited Create(False);
end;

destructor TOpenDBThread.Destroy;
begin
  OpenDBThread := nil;
  inherited Destroy;
end;

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Randomize;
  fmdDirectory := CleanAndExpandDirectory(GetCurrentDirUTF8);
  SetLogFile(Format('%s\%s_LOG_%s.txt', ['log', ExtractFileNameOnly(ParamStrUTF8(0)),
    FormatDateTime('dd-mm-yyyy', Now)]));
  Writelog_I('Starting ' + AnsiQuotedStr(Application.Title, '"'));
  InitSimpleExceptionHandler;
  AddIgnoredException('EImagingError');
  AddIgnoredException('ERegExpr');
  btAbortUpdateList.Parent := sbUpdateList;
  isRunDownloadFilter := False;
  isUpdating := False;
  isExiting := False;
  isGetMangaInfos := False;
  DoAfterFMD := DO_NOTHING;
  Application.HintHidePause := 10000;
  sbUpdateList.DoubleBuffered := True;

  // load about
  LoadAbout;

  // remove old updater
  if FileExistsUTF8(fmdDirectory + 'old_updater.exe') then
    DeleteFileUTF8(fmdDirectory + 'old_updater.exe');

  // TrayIcon
  TrayIcon.Icon.Assign(Application.Icon);
  PrevWindowState := wsNormal;

  // account
  accountmanagerdb.InitAccountManager(fmdDirectory + CONFIG_FOLDER + ACCOUNTS_FILE);

  // advanced settings
  INIAdvanced := TIniFileR.Create(fmdDirectory + CONFIG_FOLDER + CONFIG_ADVANCED);

  // main dataprocess
  dataProcess := TDBDataProcess.Create;

  // downloadmanager
  DLManager := TDownloadManager.Create;
  DLManager.Restore;

  // favorites
  FavoriteManager := TFavoriteManager.Create;
  FavoriteManager.DLManager := Self.DLManager;
  FavoriteManager.OnUpdateFavorite := @UpdateVtFavorites;
  FavoriteManager.OnUpdateDownload := @UpdateVtDownload;

  // download all / add to favorites
  SilentThreadManager := TSilentThreadManager.Create;

  // ShowInformation
  mangaInfo := TMangaInfo.Create;

  // Load config.ini
  options := TIniFile.Create(fmdDirectory + CONFIG_FOLDER + CONFIG_FILE);
  options.CacheUpdates := True;

  // Load revision.ini
  revisionIni := TIniFile.Create(fmdDirectory + CONFIG_FOLDER + REVISION_FILE);
  options.CacheUpdates := False;
  options.StripQuotes := False;

  // Load updates.ini
  updates := TIniFile.Create(fmdDirectory + CONFIG_FOLDER + UPDATE_FILE);
  updates.CacheUpdates := False;

  // Load mangalist.ini
  mangalistIni := TIniFile.Create(fmdDirectory + CONFIG_FOLDER + MANGALIST_FILE);
  mangalistIni.CacheUpdates := True;

  // generate tvDownloadFilter nodes
  GeneratetvDownloadFilterNodes;

  // set connection limit
  seOptionMaxParallel.MaxValue := MAX_TASKLIMIT;
  seOptionMaxThread.MaxValue := MAX_CONNECTIONPERHOSTLIMIT;

  isStartup := False;
  CollectLanguagesFromFiles;
  LoadFormInformation;
  LoadMangaOptions;
  LoadOptions;
  ApplyOptions;

  if cbFilterStatus.Items.Count > 2 then
    cbFilterStatus.ItemIndex := 2;

  vtDownload.NodeDataSize := SizeOf(TDownloadInfo) - 4;
  vtDownload.RootNodeCount := DLManager.Count;

  vtFavorites.NodeDataSize := SizeOf(TFavoriteInfo);
  UpdateVtFavorites;

  InitCheckboxes;

  pcMain.ActivePage := tsDownload;

  TrayIcon.Show;

  // load some necessary options at startup
  Revision := revisionIni.ReadInteger('general', 'Revision', 0);
  revisionIni.Free;

  currentJDN := GetCurrentJDN;

  // read online
  btDownload.Enabled := False;
  btReadOnline.Enabled := False;
  btAddToFavorites.Enabled := False;

  // waiting gif
  if FileExistsUTF8(IMAGE_FOLDER + 'waiting.gif') then
  begin
    gifWaiting := TAnimatedGif.Create(IMAGE_FOLDER + 'waiting.gif');
    gifWaiting.EraseColor := Self.Color;
    gifWaiting.BackgroundMode := gbmSaveBackgroundOnce;
    gifWaitingRect.Left := 53;
    gifWaitingRect.Top := 84;
    gifWaitingRect.Right := 101;
    gifWaitingRect.Bottom := 131;
  end;

  mangaCover := TPicture.Create;

  // refresh sort
  if DLManager.Count > 1 then
  begin
    DLManager.SortDirection := Boolean(vtDownload.Header.SortDirection);
    vtDownload.Repaint;
  end;
  if FavoriteManager.Count > 0 then
  begin
    FavoriteManager.SortDirection := Boolean(vtFavorites.Header.SortDirection);
    FavoriteManager.Sort(vtFavorites.Header.SortColumn);
    vtFavorites.Repaint;
  end;

  //textstyle for updatestatusbar
  with UpdateStatusTextStyle do
  begin
    Alignment := taLeftJustify;
    Layout := tlCenter;
    SingleLine := True;
    Clipping := False;
    ExpandTabs := False;
    ShowPrefix := False;
    Wordbreak := False;
    Opaque := True;
    SystemFont := False;
    RightToLeft := False;
    EndEllipsis := True;
  end;

  // embed form
  AccountManagerForm := TAccountManagerForm.Create(Self);
  with AccountManagerForm do begin
    Parent := tsAccounts;
    Align := alClient;
    Show;
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if cbOptionShowQuitDialog.Checked and (DoAfterFMD = DO_NOTHING) then
  begin
    if MessageDlg('', RS_DlgQuit, mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
    begin
      CloseAction := caNone;
      Exit;
    end;
  end;
  CloseNow;
  CloseAction := caFree;
end;

procedure TMainForm.CloseNow;
begin
  //Terminating all threads and wait for it
  if Assigned(CheckUpdateThread) then
  begin
    CheckUpdateThread.Terminate;
    CheckUpdateThread.WaitFor;
  end;
  if Assigned(SearchDBThread) then
  begin
    SearchDBThread.Terminate;
    SearchDBThread.WaitFor;
  end;
  if Assigned(OpenDBThread) then
  begin
    OpenDBThread.Terminate;
    OpenDBThread.WaitFor;
  end;
  if isGetMangaInfos then
  begin
    GetInfosThread.IsFlushed := True;
    GetInfosThread.Terminate;
    GetInfosThread.WaitFor;
  end;
  if isUpdating then
  begin
    updateList.Terminate;
    updateList.WaitFor;
  end;
  FavoriteManager.StopChekForNewChapter(True);
  SilentThreadManager.StopAll(True);
  DLManager.StopAllDownloadTasksForExit;

  tmBackup.Enabled := False;
  itSaveDownloadedList.Enabled := False;
  itRefreshDLInfo.Enabled := False;
  itCheckFav.Enabled := False;
  itAnimate.Enabled := False;
  itStartup.Enabled := False;
  itMonitor.Enabled := False;

  if Assigned(FormDropTarget) then
    FormDropTarget.Close;

  if FMDInstance <> nil then
  begin
    FMDInstance.StopServer;
    FreeAndNil(FMDInstance);
  end;

  //Backup data
  DLManager.Backup;
  DLManager.BackupDownloadedChaptersList;
  isExiting := True;
  FavoriteManager.Backup;
  SaveOptions;
  SaveFormInformation;

  //embed form
  if Assigned(AccountManagerForm) then
    AccountManagerForm.Close;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  SetLength(optionMangaSiteSelectionNodes, 0);
  SetLength(ChapterList, 0);
  FreeAndNil(mangaInfo);

  FreeAndNil(DLManager);
  FreeAndNil(SilentThreadManager);
  FreeAndNil(FavoriteManager);
  FreeAndNil(dataProcess);

  FreeAndNil(gifWaiting);
  FreeAndNil(mangaCover);

  FreeAndNil(mangalistIni);
  FreeAndNil(updates);
  FreeAndNil(options);
  FreeAndNil(INIAdvanced);
  Writelog_I(AnsiQuotedStr(Application.Title, '"') + ' exit normally');
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if not isStartup then
    itStartup.Enabled := True;
end;

procedure TMainForm.cbOptionUseProxyChange(Sender: TObject);
begin
  gbOptionProxy.Enabled := cbOptionUseProxy.Checked;
end;

procedure TMainForm.FormWindowStateChange(Sender: TObject);
begin
  if (WindowState = wsMinimized) then
  begin
    if cbOptionMinimizeToTray.Checked then
    begin
      ShowInTaskBar := stNever;
      Hide;
      if not TrayIcon.Visible then
        TrayIcon.Show;
    end;
  end
  else
    PrevWindowState := WindowState;
end;

procedure TMainForm.itAnimateTimer(Sender: TObject);
begin
  gifWaiting.Update(pbWait.Canvas, gifWaitingRect);
end;

procedure TMainForm.itCheckFavTimer(Sender: TObject);
begin
  if IsDlgCounter then Exit;
  if OptionAutoCheckLatestVersion then
    btCheckLatestVersionClick(btCheckLatestVersion);
  FavoriteManager.isAuto := True;
  FavoriteManager.CheckForNewChapter;
end;

function TMainForm.ShowExitCounter: Boolean;
begin
  IsDlgCounter := True;
  with TShutdownCounterForm.Create(nil) do try
    case DoAfterFMD of
      DO_POWEROFF:
        begin
          WaitTimeout := 60;
          LabelMessage := RS_LblMessageShutdown;
        end;
      DO_HIBERNATE:
        begin
          WaitTimeout := 30;
          LabelMessage := RS_LblMessageHibernate;
        end;
      DO_EXIT:
        begin
          WaitTimeout := 5;
          LabelMessage := RS_LblMessageExit;
        end;
    end;
    Result := (ShowModal = mrOK);
  finally
    Free;
  end;
  IsDlgCounter := False;
end;

procedure TMainForm.OpenDataDB(const AWebsite: String);
begin
  if OpenDBThread = nil then
    OpenDBThread := TOpenDBThread.Create(AWebsite);
end;

procedure TMainForm.SearchDataDB(const ATitle: String);
begin
  if SearchDBThread = nil then
    SearchDBThread := TSearchDBThread.Create(ATitle)
  else
  begin
    SearchDBThread.NewSearch(ATitle);
  end;
end;

procedure TMainForm.itMonitorTimer(Sender: TObject);
begin
  itMonitor.Enabled := False;
  if DoAfterFMD <> DO_NOTHING then
  begin
    if DoAfterFMD in [DO_POWEROFF, DO_HIBERNATE, DO_EXIT] then
    begin
      if ShowExitCounter then
      begin
        Self.CloseNow;
        if DoAfterFMD = DO_POWEROFF then
          fmdPowerOff
        else
        if DoAfterFMD = DO_HIBERNATE then
          fmdHibernate;
        Self.Close;
      end;
    end
    else
    if DoAfterFMD = DO_UPDATE then
    begin
      if FileExistsUTF8(fmdDirectory + 'updater.exe') then
        CopyFile(fmdDirectory + 'updater.exe', fmdDirectory + 'old_updater.exe');
      if FileExistsUTF8(fmdDirectory + 'old_updater.exe') then
      begin
        Self.CloseNow;
        RunExternalProcess(fmdDirectory + 'old_updater.exe',
          ['-x', '-r', '3', '-a', FUpdateURL, '-l', Application.ExeName,
           '--lang', uTranslation.LastSelected], True, False);
        Self.Close;
      end;
    end;
    DoAfterFMD := DO_NOTHING;
  end;
end;

procedure TMainForm.itRefreshDLInfoStartTimer(Sender: TObject);
begin
  if Assigned(DLManager) then
  begin
    TransferRateGraphInit(round(TransferRateGraph.Width/4));
    TransferRateGraph.Visible := True;
  end;
end;

procedure TMainForm.itRefreshDLInfoStopTimer(Sender: TObject);
begin
  if Assigned(DLManager) then
  begin
    DLManager.ClearTransferRate;
    TransferRateGraph.Visible := False;
  end;
  vtDownload.Repaint;
end;

procedure TMainForm.itRefreshDLInfoTimer(Sender: TObject);
begin
  if Assigned(DLManager) then
    TransferRateGraphAddItem(DLManager.TransferRate);
  vtDownload.Repaint;
end;

procedure TMainForm.itSaveDownloadedListTimer(Sender: TObject);
begin
  DLManager.BackupDownloadedChaptersList;
end;

procedure TMainForm.itStartupTimer(Sender: TObject);
begin
  itStartup.Enabled := False;
  if not isStartup then
  begin
    isStartup := True;
    if cbSelectManga.ItemIndex > -1 then
      OpenDataDB(cbSelectManga.Items[cbSelectManga.ItemIndex]);
    if OptionAutoCheckLatestVersion then
      btCheckLatestVersionClick(btCheckLatestVersion);
    if OptionAutoCheckFavStartup then
    begin
      MainForm.FavoriteManager.isAuto := True;
      MainForm.FavoriteManager.CheckForNewChapter;
    end;
    DLManager.CheckAndActiveTaskAtStartup;
  end;
end;

procedure TMainForm.medURLCutClick(Sender: TObject);
begin
  edURL.CutToClipboard;
end;

procedure TMainForm.medURLCopyClick(Sender: TObject);
begin
  edURL.CopyToClipboard;
end;

procedure TMainForm.medURLPasteClick(Sender: TObject);
begin
  edURL.PasteFromClipboard;
end;

procedure TMainForm.medURLPasteandgoClick(Sender: TObject);
begin
  edURL.Text := Clipboard.AsText;
  btURLClick(edURL);
end;

procedure TMainForm.medtURLDeleteClick(Sender: TObject);
begin
  edURL.ClearSelection;
end;

procedure TMainForm.medURLSelectAllClick(Sender: TObject);
begin
  edURL.SelectAll;
  edURL.SetFocus;
end;

procedure TMainForm.medURLUndoClick(Sender: TObject);
begin
  edURL.Undo;
end;

procedure TMainForm.miAbortSilentThreadClick(Sender: TObject);
begin
  if Assigned(SilentThreadManager) then
    SilentThreadManager.StopAll(False);
end;

procedure TMainForm.miDownloadViewMangaInfoClick(Sender: TObject);
var
  i: Integer;
begin
  if vtDownload.Focused then
    with DLManager.TaskItem(vtDownload.FocusedNode^.Index) do
    begin
      i := Modules.LocateModule(DownloadInfo.Website);
      if i > -1 then
        edURL.Text := FillHost(Modules.Module[i].RootURL, DownloadInfo.Link)
      else
        edURL.Text := FillMangaSiteHost(DownloadInfo.Website, DownloadInfo.Link);
      btURLClick(btURL);
      pcMain.ActivePage := tsInformation;
    end;
end;

procedure TMainForm.miChapterListHighlightClick(Sender: TObject);
begin
  miChapterListHighlight.Checked := not miChapterListHighlight.Checked;
  options.WriteBool('general', 'HighlightDownloadedChapters',
    miChapterListHighlight.Checked);
  if Length(ChapterList) > 0 then
  begin
    if miChapterListHighlight.Checked then
      DLManager.GetDownloadedChaptersState(mangaInfo.website + mangaInfo.link,
        ChapterList)
    else
      ClearChapterListState;
    clbChapterList.Repaint;
  end;
end;

procedure TMainForm.miDownloadDeleteTaskClick(Sender: TObject);
var
  xNode: PVirtualNode;
  i: Integer;
  f: String;
begin
  if vtDownload.SelectedCount = 0 then Exit;
  if DLManager.Count = 0 then Exit;
  if (cbOptionShowDeleteTaskDialog.Checked) then
    if MessageDlg('', RS_DlgRemoveTask,
      mtConfirmation, [mbYes, mbNo], 0) <> mrYes then
      Exit;
  DLManager.CS_DownloadManager_Task.Acquire;
  try
    xNode := vtDownload.GetLast();
    while Assigned(xNode) do begin
      if vtDownload.Selected[xNode] then begin
        DLManager.StopTask(xNode^.Index, False, True);
        with TTaskContainer(DLManager.Containers[xNode^.Index]) do begin
          if (Sender = miDownloadDeleteTaskData) and (ChapterName.Count > 0) then begin
            for i := 0 to ChapterName.Count - 1 do begin
              f := CleanAndExpandDirectory(DownloadInfo.SaveTo) + ChapterName[i];
              if FileExistsUTF8(f + '.zip') then
                DeleteFileUTF8(f + '.zip')
              else if FileExistsUTF8(f + '.cbz') then
                DeleteFileUTF8(f + '.cbz')
              else if FileExistsUTF8(f + '.pdf') then
                DeleteFileUTF8(f + '.pdf')
              else if DirectoryExistsUTF8(f) then
                DeleteDirectory(f, False);
            end;
            RemoveDirUTF8(CleanAndExpandDirectory(DownloadInfo.SaveTo));
          end;
          TTaskContainer(DLManager.Containers[xNode^.Index]).Free;
          DLManager.Containers.Delete(xNode^.Index);
        end;
      end;
      xNode := vtDownload.GetPreviousSelected(xNode);
    end;
  finally
    DLManager.CS_DownloadManager_Task.Release;
  end;
  DLManager.CheckAndActiveTask;
  UpdateVtDownload;
end;

procedure TMainForm.miDownloadMergeCompletedClick(Sender: TObject);
var
  i, j: Cardinal;
  // merge all finished tasks that have same manga name, website and directory
begin
  i := DLManager.Count - 1;
  while i > 0 do
  begin
    if DLManager.TaskItem(i).Status = STATUS_FINISH then
    begin
      j := i - 1;
      while j > 0 do
      begin
        if (i <> j) and
          (DLManager.TaskItem(j).Status = STATUS_FINISH) and
          SameText(DLManager.TaskItem(i).DownloadInfo.title,
          DLManager.TaskItem(j).DownloadInfo.title) and
          SameText(DLManager.TaskItem(i).DownloadInfo.website,
          DLManager.TaskItem(j).DownloadInfo.website) and
          SameText(DLManager.TaskItem(i).DownloadInfo.saveTo,
          DLManager.TaskItem(j).DownloadInfo.saveTo) then
        begin
          DLManager.TaskItem(i).ChapterLinks.Text :=
            DLManager.TaskItem(j).ChapterLinks.Text +
            DLManager.TaskItem(i).ChapterLinks.Text;
          DLManager.TaskItem(i).ChapterName.Text :=
            DLManager.TaskItem(j).ChapterName.Text +
            DLManager.TaskItem(i).ChapterName.Text;
          DLManager.TaskItem(i).DownloadInfo.dateTime :=
            DLManager.TaskItem(j).DownloadInfo.dateTime;
          DLManager.RemoveTask(j);
          Dec(i);
        end;
        Dec(j);
      end;
    end;
    Dec(i);
  end;
  UpdateVtDownload;
end;

procedure TMainForm.miFavoritesCheckNewChapterClick(Sender: TObject);
var
  xNode: PVirtualNode;
begin
  if vtFavorites.SelectedCount > 0 then
  begin
    xNode := vtFavorites.GetFirstSelected;
    repeat
      if Assigned(xNode) then
      begin
        FavoriteManager.CheckForNewChapter(xNode^.Index);
        xNode := vtFavorites.GetNextSelected(xNode);
      end;
    until xNode = nil;
    vtFavorites.Repaint;
  end;
end;

procedure TMainForm.miFavoritesDownloadAllClick(Sender: TObject);
var
  i: Integer;
  xNode: PVirtualNode;
begin
  if vtFavorites.SelectedCount = 0 then Exit;
  SilentThreadManager.BeginAdd;
  try
    xNode := vtFavorites.GetFirstSelected;
    for i := 0 to vtFavorites.SelectedCount - 1 do
    begin
      if vtFavorites.Selected[xNode] then
        with FavoriteManager.FavoriteItem(xNode^.Index).FavoriteInfo do
          SilentThreadManager.Add(MD_DownloadAll, Website, Title, Link, SaveTo);
      xNode := vtFavorites.GetNextSelected(xNode);
    end;
  except
    on E: Exception do
      ExceptionHandler(Self, E);
  end;
  SilentThreadManager.EndAdd;
end;

procedure TMainForm.miFavoritesStopCheckNewChapterClick(Sender: TObject);
var
  xNode: PVirtualNode;
begin
  if vtFavorites.SelectedCount > 0 then
  begin
    xNode := vtFavorites.GetFirstSelected;
    repeat
      if Assigned(xNode) then
      begin
        FavoriteManager.StopChekForNewChapter(False, xNode^.Index);
        xNode := vtFavorites.GetNextSelected(xNode);
      end;
    until xNode = nil;
    vtFavorites.Repaint;
  end;
end;

procedure TMainForm.miFavoritesViewInfosClick(Sender: TObject);
var
  title, website, link: String;
  i: Integer;
begin
  if (not vtFavorites.Focused) then
    Exit;
  btDownload.Enabled := False;
  pcMain.ActivePage := tsInformation;
  imCover.Picture.Assign(nil);
  rmInformation.Clear;
  rmInformation.Lines.Add('Loading ...');
  clbChapterList.Clear;

  website := FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.Website;
  link := FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.link;
  title := FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.Title;

  if isGetMangaInfos then
  begin
    GetInfosThread.IsFlushed := True;
    GetInfosThread.Terminate;
    //GetInfosThread.WaitFor;
  end;
  GetInfosThread := TGetMangaInfosThread.Create;
  GetInfosThread.MangaListPos := -2;
  GetInfosThread.Title := title;
  GetInfosThread.Website := website;
  GetInfosThread.Link := link;
  GetInfosThread.Start;

  if Assigned(gifWaiting) then
  begin
    itAnimate.Enabled := True;
    pbWait.Visible := True;
  end;

  if ExecRegExpr('^https?://', link) then
    edURL.Text := link
  else
  begin
    i := Modules.LocateModule(website);
    if i > -1 then
      edURL.Text := FillHost(Modules.Module[i].RootURL, link)
    else
      edURL.Text := FillMangaSiteHost(website, link);
  end;

  btDownload.Enabled := (clbChapterList.RootNodeCount > 0);
  btReadOnline.Enabled := (edURL.Text <> '');
end;

procedure TMainForm.miHighlightNewMangaClick(Sender: TObject);
begin
  miHighlightNewManga.Checked := not miHighlightNewManga.Checked;
  options.WriteBool('general', 'HighLightNewManga', miHighlightNewManga.Checked);
  vtMangaList.Repaint;
end;

procedure TMainForm.LoadAbout;
var
  i: Integer;
  s: string;
  fs: TFileStreamUTF8;
  st: TStringList;
  regx: TRegExpr;
begin
  // load readme.rtf
  s := fmdDirectory + README_FILE;
  if FileExistsUTF8(s) then begin
    regx := TRegExpr.Create;
    st := TStringList.Create;
    try
      regx.ModifierI := True;
      regx.Expression := '(version.*)(\d+\.){3}\d+';
      st.LoadFromFile(s);
      if st.Count > 0 then
        for i := 0 to st.Count - 1 do
          if regx.Exec(st[i]) then
          begin
            st[i] := regx.Replace(st[i], '$1\' + FMD_VERSION_NUMBER, True);
            st.SaveToFile(s);
            Break;
          end;
    finally
      st.Free;
      regx.Free;
    end;
    fs := TFileStreamUTF8.Create(s, fmOpenRead or fmShareDenyNone);
    try
      rmAbout.LoadRichText(fs);
    finally
      fs.free;
    end;
  end;
  // load changelog.txt
  s := CleanAndExpandDirectory(fmdDirectory) + CHANGELOG_FILE;
  if FileExistsUTF8(s) then  mmChangelog.Lines.LoadFromFile(s);
end;

procedure TMainForm.tvDownloadFilterRepaint;
var
  i: Cardinal;
  LFinishedTasks: Cardinal = 0;
  LInProgressTasks: Cardinal = 0;
  LStoppedTasks: Cardinal = 0;
  LFailedTask: Cardinal = 0;
begin
  if (Assigned(DLManager)) and (DLManager.Count > 0) then
    for i := 0 to DLManager.Count - 1 do
    begin
      case DLManager.TaskItem(i).Status of
        STATUS_FINISH: Inc(LFinishedTasks);
        STATUS_DOWNLOAD, STATUS_PREPARE, STATUS_WAIT: Inc(LInProgressTasks);
        STATUS_STOP: Inc(LStoppedTasks);
        STATUS_PROBLEM, STATUS_FAILED: Inc(LFailedTask);
      end;
    end;

  // root
  tvDownloadFilter.Items[0].Text :=
    Format('%s (%d)', [RS_AllDownloads, vtDownload.RootNodeCount]);

  // childs
  tvDownloadFilter.Items[1].Text := Format('%s (%d)', [RS_Finish, LFinishedTasks]);
  tvDownloadFilter.Items[2].Text := Format('%s (%d)', [RS_InProgress, LInProgressTasks]);
  tvDownloadFilter.Items[3].Text := Format('%s (%d)', [RS_Stopped, LStoppedTasks]);
  tvDownloadFilter.Items[4].Text := Format('%s (%d)', [RS_Failed, LFailedTask]);

  // root
  tvDownloadFilter.Items[5].Text := RS_History;

  // childs
  tvDownloadFilter.Items[6].Text := RS_Today;
  tvDownloadFilter.Items[7].Text := RS_Yesterday;
  tvDownloadFilter.Items[8].Text := RS_OneWeek;
  tvDownloadFilter.Items[9].Text := RS_OneMonth;
end;

procedure TMainForm.GeneratetvDownloadFilterNodes;
begin
  with tvDownloadFilter do begin
    Items.Clear;

    // root
    Items.Add(nil, RS_AllDownloads);
    Items[0].ImageIndex := 4;
    Items[0].SelectedIndex := 4;
    Items[0].StateIndex := 4;

    // childs
    Items.AddChild(tvDownloadFilter.Items[0], RS_Finish);
    Items[1].ImageIndex := 5;
    Items[1].SelectedIndex := 5;
    Items[1].StateIndex := 5;
    Items.AddChild(tvDownloadFilter.Items[0], RS_InProgress);
    Items[2].ImageIndex := 6;
    Items[2].SelectedIndex := 6;
    Items[2].StateIndex := 6;
    Items.AddChild(tvDownloadFilter.Items[0], RS_Stopped);
    Items[3].ImageIndex := 7;
    Items[3].SelectedIndex := 7;
    Items[3].StateIndex := 7;
    Items.AddChild(tvDownloadFilter.Items[0], RS_Failed);
    Items[4].ImageIndex := 16;
    Items[4].SelectedIndex := 16;
    Items[4].StateIndex := 16;

    // root
    Items.Add(nil, RS_History);
    Items[5].ImageIndex := 4;
    Items[5].SelectedIndex := 4;
    Items[5].StateIndex := 4;

    // childs
    Items.AddChild(tvDownloadFilter.Items[5], RS_Today);
    Items[6].ImageIndex := 8;
    Items[6].SelectedIndex := 8;
    Items[6].StateIndex := 8;
    Items.AddChild(tvDownloadFilter.Items[5], RS_Yesterday);
    Items[7].ImageIndex := 8;
    Items[7].SelectedIndex := 8;
    Items[7].StateIndex := 8;
    Items.AddChild(tvDownloadFilter.Items[5], RS_OneWeek);
    Items[8].ImageIndex := 8;
    Items[8].SelectedIndex := 8;
    Items[8].StateIndex := 8;
    Items.AddChild(tvDownloadFilter.Items[5], RS_OneMonth);
    Items[9].ImageIndex := 8;
    Items[9].SelectedIndex := 8;
    Items[9].StateIndex := 8;

    Items[Self.options.ReadInteger('general', 'DownloadFilterSelect',0)].Selected := True;
  end;
end;

procedure TMainForm.btDownloadClick(Sender: TObject);
var
  s: String;
  i, pos: Integer;
  isCreate: Boolean = False;
  xNode: PVirtualNode;
begin
  if clbChapterList.CheckedCount = 0 then
    Exit;
  Pos := -1;
  xNode := clbChapterList.GetFirstChecked;
  for i := 0 to clbChapterList.CheckedCount - 1 do
  begin
    if xNode^.CheckState = csCheckedNormal then
    begin
      if not isCreate then
      begin
        pos := DLManager.AddTask;
        isCreate := True;
      end;
      DLManager.TaskItem(pos).Website := mangaInfo.website;
      // generate folder name
      s := CustomRename(OptionCustomRename,
        mangaInfo.website,
        mangaInfo.title,
        mangaInfo.authors,
        mangaInfo.artists,
        mangaInfo.chapterName.Strings[xNode^.Index],
        Format('%.4d', [xNode^.Index + 1]),
        cbOptionPathConvert.Checked);
      DLManager.TaskItem(pos).ChapterName.Add(s);
      DLManager.TaskItem(pos).ChapterLinks.Add(
        mangaInfo.chapterLinks.Strings[xNode^.Index]);
      ChapterList[xNode^.Index].Downloaded := True;
      clbChapterList.ReinitNode(xNode, False);
    end;
    xNode := clbChapterList.GetNextChecked(xNode);
  end;
  if not isCreate then
    Exit;
  if cbAddAsStopped.Checked then
  begin
    DLManager.TaskItem(pos).DownloadInfo.Status := RS_Stopped;
    DLManager.TaskItem(pos).Status := STATUS_STOP;
  end
  else
  begin
    DLManager.TaskItem(pos).DownloadInfo.Status := RS_Waiting;
    DLManager.TaskItem(pos).Status := STATUS_WAIT;
  end;
  DLManager.TaskItem(pos).CurrentDownloadChapterPtr := 0;
  DLManager.TaskItem(pos).DownloadInfo.Website := mangaInfo.website;
  DLManager.TaskItem(pos).DownloadInfo.Link := mangaInfo.url;
  DLManager.TaskItem(pos).DownloadInfo.Title := mangaInfo.title;
  DLManager.TaskItem(pos).DownloadInfo.DateTime := Now;

  s := CorrectPathSys(edSaveTo.Text);
  // save to
  if cbOptionGenerateMangaFolderName.Checked then
  begin
    if not cbOptionPathConvert.Checked then
      s := s + RemoveSymbols(mangaInfo.title)
    else
      s := s + RemoveSymbols(UnicodeRemove(mangaInfo.title));
  end;
  s := CorrectPathSys(s);
  DLManager.TaskItem(pos).DownloadInfo.SaveTo := s;
  UpdateVtDownload;

  DLManager.CheckAndActiveTask;
  DLManager.AddToDownloadedChaptersList(
    mangaInfo.website + mangaInfo.link, DLManager.TaskItem(pos).ChapterLinks);
  FavoriteManager.AddToDownloadedChaptersList(
    mangaInfo.website, mangaInfo.link, DLManager.TaskItem(pos).ChapterLinks);
  clbChapterList.Repaint;
  pcMain.ActivePage := tsDownload;
end;

procedure TMainForm.btAddToFavoritesClick(Sender: TObject);
var
  s, s2: String;
  i: Integer;
begin
  if mangaInfo.title <> '' then
  begin
    s := CorrectPathSys(edSaveTo.Text);

    // save to
    if cbOptionGenerateMangaFolderName.Checked then
    begin
      if not cbOptionPathConvert.Checked then
        s := s + RemoveSymbols(mangaInfo.title)
      else
        s := s + RemoveSymbols(UnicodeRemove(mangaInfo.title));
    end;
    s := CorrectPathSys(s);

    s2 := '';
    if (mangaInfo.numChapter > 0) {AND (mangaInfo.website = MANGASTREAM_NAME)} then
    begin
      for i := 0 to mangaInfo.numChapter - 1 do
        s2 := s2 + mangaInfo.chapterLinks.Strings[i] + SEPERATOR;
    end;

    FavoriteManager.Add(mangaInfo.title, IntToStr(mangaInfo.numChapter), s2,
      mangaInfo.website, s, mangaInfo.link);
    vtFavorites.NodeDataSize := SizeOf(TFavoriteInfo);
    UpdateVtFavorites;
    btAddToFavorites.Enabled := False;
  end;
end;

procedure TMainForm.btAbortUpdateListClick(Sender: TObject);
begin
  if isUpdating then
    updateList.Terminate;
end;

procedure TMainForm.btAbortCheckLatestVersionClick(Sender: TObject);
begin
  if Assigned(CheckUpdateThread) then
    CheckUpdateThread.Terminate;
end;

procedure TMainForm.btCancelFavoritesCheckClick(Sender: TObject);
begin
  FavoriteManager.StopChekForNewChapter(False);
end;

procedure TMainForm.appPropertiesMainShowHint(var HintStr: String;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if HintInfo.HintControl = vtMangaList then
    HintInfo.HintMaxWidth := 500;
  if HintInfo.HintControl = sbUpdateList then
    if isUpdating then
      HintStr := Trim(updateList.websites.Text)
    else
      HintStr := '';
end;

// -----

procedure TMainForm.btFavoritesCheckNewChapterClick(Sender: TObject);
begin
  FavoriteManager.isAuto := False;
  FavoriteManager.CheckForNewChapter;
end;

// -----

procedure TMainForm.btBrowseClick(Sender: TObject);
begin
  //dlgSaveTo.InitialDir := CorrectFilePath(edSaveTo.Text);
  dlgSaveTo.InitialDir := edSaveTo.Text;
  if dlgSaveTo.Execute then
    edSaveTo.Text := dlgSaveTo.FileName;
  //edSaveTo.Text := CorrectFilePath(dlgSaveTo.FileName);
end;

procedure TMainForm.btOptionBrowseClick(Sender: TObject);
begin
  //dlgSaveTo.InitialDir := CorrectFilePath(edOptionDefaultPath.Text);
  dlgSaveTo.InitialDir := edOptionDefaultPath.Text;
  if dlgSaveTo.Execute then
    edOptionDefaultPath.Text := CorrectPathSys(dlgSaveTo.FileName);
  //edOptionDefaultPath.Text := CorrectFilePath(dlgSaveTo.FileName);
end;

// -----

procedure TMainForm.btUpdateListClick(Sender: TObject);
var
  button: TControl;
  lowerLeft: TPoint;
  {$IFNDEF SELFUPDATE}
  i: Cardinal;
  {$ENDIF}
begin
  {$IFDEF SELFUPDATE}
  pmUpdate.Items[0].Enabled := True;
  pmUpdate.Items[3].Enabled := True;
  {$ELSE}
  if dataProcess.Title.Count = 0 then
    pmUpdate.Items[0].Enabled := False
  else
    pmUpdate.Items[0].Enabled := True;

  pmUpdate.Items[3].Enabled := True;
  for i := 0 to cbSelectManga.Items.Count - 1 do
  begin
    if not (FileExistsUTF8(DATA_FOLDER + cbSelectManga.Items.Strings[i] + DATA_EXT)) then
    begin
      pmUpdate.Items[3].Enabled := False;
      Break;
    end;
  end;
  {$ENDIF}
  if Sender is TControl then
  begin
    button := TControl(Sender);
    lowerLeft := Point(button.Left, button.Top + button.Height * 2 +
      (button.Height div 2));
    lowerLeft := ClientToScreen(lowerLeft);
    pmUpdate.Popup(lowerLeft.X, lowerLeft.Y);
  end;
end;

procedure TMainForm.DisableAddToFavorites(webs: String);
begin
  btAddToFavorites.Enabled := not SitesWithoutFavorites(webs);
end;

procedure TMainForm.FMDInstanceReceiveMsg(Sender: TObject);
begin
  MessageDlg(Application.Title, RS_FMDAlreadyRunning, mtWarning, [mbOK], 0);
  if WindowState = wsMinimized then
    WindowState := wsNormal;
  Show;
  BringToFront;
end;

procedure TMainForm.ClearChapterListState;
var
  i: Integer;
begin
  if Length(ChapterList) > 0 then
    for i := Low(ChapterList) to High(ChapterList) do
      ChapterList[i].Downloaded := False;
end;

procedure TMainForm.btURLClick(Sender: TObject);
var
  i: Integer;
  webid: Cardinal;
  website,
  host,
  link: String;
  regx: TRegExpr;
begin
  website := '';
  host := '';
  link := '';
  edURL.Text := FixURL(edURL.Text);
  regx := TRegExpr.Create;
  try
    regx.Expression := '^https?\://';
    if not (regx.Exec(edURL.Text)) then
      edURL.Text := 'http://' + edURL.Text;

    regx.Expression := REGEX_HOST;
    if regx.Exec(edURL.Text) then
    begin
      host := regx.Replace(edURL.Text, '$2', True);
      link := regx.Replace(edURL.Text, '$4', True);
    end;

    if (host <> '') and (link <> '') then
    begin
      host := LowerCase(host);
      i := Modules.LocateModuleByHost(host);
      if i > -1 then
      begin
        website := Modules.Module[i].Website;
        edURL.Text := FillHost(Modules.Module[i].RootURL, link);
      end
      else
      begin
        for i := Low(WebsiteRoots) to High(WebsiteRoots) do
          if Pos(host, WebsiteRoots[i, 1]) > 0 then
          begin
            webid := i;
            website := WebsiteRoots[i, 0];
            Break;
          end;
        if website <> '' then
          edURL.Text := FillMangaSiteHost(webid, link);
      end;
    end;
  finally
    regx.Free;
  end;

  DisableAddToFavorites(website);
  if (website = '') or (link = '') then
  begin
    MessageDlg('', RS_DlgURLNotSupport, mtInformation, [mbYes], 0);
    Exit;
  end;

  if isGetMangaInfos then
  begin
    GetInfosThread.IsFlushed := True;
    GetInfosThread.Terminate;
    //GetInfosThread.WaitFor;
  end;
  GetInfosThread := TGetMangaInfosThread.Create;
  GetInfosThread.MangaListPos := -1;
  GetInfosThread.Title := '';
  GetInfosThread.Website := website;
  GetInfosThread.Link := link;
  GetInfosThread.Start;

  pcMain.ActivePage := tsInformation;
  imCover.Picture.Assign(nil);
  clbChapterList.Clear;
  if Assigned(gifWaiting) then
  begin
    itAnimate.Enabled := True;
    pbWait.Visible := True;
  end;
  btAddToFavorites.Enabled := not SitesWithoutFavorites(website);
  rmInformation.Clear;
  rmInformation.Lines.Add(RS_Loading);
end;

procedure TMainForm.btVisitMyBlogClick(Sender: TObject);
begin
  OpenURL('http://akarink.wordpress.com/');
end;

procedure TMainForm.btWebsitesSearchClearClick(Sender: TObject);
begin
  edWebsitesSearch.Clear;
end;

procedure TMainForm.cbOptionAutoCheckFavIntervalChange(Sender: TObject);
begin
  seOptionAutoCheckFavIntervalMinutes.Enabled := cbOptionAutoCheckFavInterval.Checked;
  lbOptionAutoCheckFavIntervalMinutes.Enabled := cbOptionAutoCheckFavInterval.Checked;
end;

procedure TMainForm.cbOptionDigitChapterChange(Sender: TObject);
begin
  seOptionDigitChapter.Enabled := cbOptionDigitChapter.Checked;
end;

procedure TMainForm.cbOptionDigitVolumeChange(Sender: TObject);
begin
  seOptionDigitVolume.Enabled := cbOptionDigitVolume.Checked;
end;

procedure TMainForm.btReadOnlineClick(Sender: TObject);
begin
  OpenURL(mangaInfo.url);
end;

procedure TMainForm.btSearchClearClick(Sender: TObject);
begin
  edSearch.Tag := 1;
  edSearch.Clear;
end;

procedure TMainForm.btCheckLatestVersionClick(Sender: TObject);
begin
  if Assigned(CheckUpdateThread) then
    MessageDlg('', RS_DlgUpdaterIsRunning, mtInformation, [mbYes], 0)
  else
    CheckUpdateThread := TCheckUpdateThread.Create;
end;

procedure TMainForm.btDonateClick(Sender: TObject);
begin
  OpenURL('https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=akarin.km@gmail.com&item_name=Donation+to+Free+Manga+Downloader');
end;

procedure TMainForm.btFavoritesImportClick(Sender: TObject);
begin
  with TImportFavorites.Create(Self) do try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TMainForm.btChecksClick(Sender: TObject);
begin
  if Sender is TControl then
    with TControl(Sender) do begin
      pmChapterList.Alignment := Menus.paRight;
      pmChapterList.PopUp(ControlOrigin.x, ControlOrigin.y);
      pmChapterList.Alignment := Menus.paLeft;
    end;
  clbChapterList.SetFocus;
end;

procedure TMainForm.cbSelectMangaChange(Sender: TObject);
begin
  if cbSelectManga.ItemIndex < 0 then
    Exit;
  options.WriteInteger('form', 'SelectManga', cbSelectManga.ItemIndex);
  if currentWebsite <> cbSelectManga.Items[cbSelectManga.ItemIndex] then
  begin
    currentWebsite := cbSelectManga.Items[cbSelectManga.ItemIndex];
    vtMangaList.Clear;
    if dataProcess = nil then
      dataProcess := TDBDataProcess.Create
    else
    if dataProcess.Connected then
      dataProcess.Close;
    lbMode.Caption := Format(RS_ModeAll, [0]);
    if DataFileExist(cbSelectManga.Items[cbSelectManga.ItemIndex]) then
    begin
      OpenDataDB(cbSelectManga.Items[cbSelectManga.ItemIndex]);
    end
    else
      RunGetList;
  end;
end;

procedure TMainForm.clbChapterListBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  if Assigned(Node) then
    if ChapterList[Node^.Index].Downloaded then
    begin
      TargetCanvas.Brush.Color := CL_HLGreenMarks;
      TargetCanvas.FillRect(CellRect);
    end;
end;

procedure TMainForm.clbChapterListFreeNode(Sender : TBaseVirtualTree;
  Node : PVirtualNode);
var
  Data: PChapterStateItem;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    Finalize(Data^);
end;

procedure TMainForm.clbChapterListGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TChapterStateItem);
end;

procedure TMainForm.clbChapterListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
var
  Data: PChapterStateItem;
begin
  Data := clbChapterList.GetNodeData(Node);
  if Assigned(Data) then
    CellText := Data^.Title;
end;

procedure TMainForm.clbChapterListInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PChapterStateItem;
begin
  with Sender do
  begin
    Data := GetNodeData(Node);
    if mangaInfo.chapterName.Count = 1 then
      Data^.Title := ChapterList[Node^.Index].Title
    else
      Data^.Title := Format('%.4d - %s', [Node^.Index + 1,
        ChapterList[Node^.Index].Title]);
    Data^.Link := ChapterList[Node^.Index].Link;
    Data^.Downloaded := ChapterList[Node^.Index].Downloaded;
    Node^.CheckType := ctCheckBox;
    clbChapterList.ValidateNode(Node, False);
  end;
end;

procedure TMainForm.edURLKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btURLClick(btURL);
end;

procedure TMainForm.edWebsitesSearchChange(Sender: TObject);
var
  s: String;
  lcount: Integer;
  data: PSingleItem;
  xNode, lNode: PVirtualNode;
begin
  if Length(optionMangaSiteSelectionNodes) < 1 then Exit;
  s := Trim(LowerCase(edWebsitesSearch.Text));
  vtOptionMangaSiteSelection.BeginUpdate;
  try
    lNode := nil;
    lcount := 0;
    vtOptionMangaSiteSelection.RootNode^.TotalHeight := vtOptionMangaSiteSelection.DefaultNodeHeight;
    if s = '' then
    begin
      xNode := vtOptionMangaSiteSelection.GetFirst;
      while Assigned(xNode) do
      begin
        Include(xNode^.States, vsVisible);
        if xNode^.ChildCount > 0 then
        begin
          lNode := xNode;
          Inc(vtOptionMangaSiteSelection.RootNode^.TotalHeight, xNode^.NodeHeight);
        end
        else
          if Assigned(lNode) then
            if vsExpanded in lNode^.States then
              Inc(vtOptionMangaSiteSelection.RootNode^.TotalHeight, xNode^.NodeHeight);
        xNode := vtOptionMangaSiteSelection.GetNext(xNode);
      end;
    end
    else
    begin
      xNode := vtOptionMangaSiteSelection.GetFirst;
      while Assigned(xNode) do
      begin
        Include(xNode^.States, vsVisible);
        if xNode^.ChildCount > 0 then
        begin
          if Assigned(lNode) then
          begin
            if lcount > 0 then
              Inc(vtOptionMangaSiteSelection.RootNode^.TotalHeight, lNode^.NodeHeight)
            else
              Exclude(lNode^.States, vsVisible);
          end;
          lNode := xNode;
          lcount := 0;
        end
        else
        begin
          data := vtOptionMangaSiteSelection.GetNodeData(xNode);
          if Assigned(data) then
          begin
            if Pos(s, LowerCase(data^.Text)) <> 0 then
            begin
              Inc(lcount);
              if Assigned(lNode) then
              begin
                if vsExpanded in lNode^.States then
                  Inc(vtOptionMangaSiteSelection.RootNode^.TotalHeight, xNode^.NodeHeight);
              end;
            end
            else
              Exclude(xNode^.States, vsVisible);
          end;
        end;
        xNode := vtOptionMangaSiteSelection.GetNext(xNode);
      end;
      if Assigned(lNode) then
      begin
        if lcount > 0 then
          Inc(vtOptionMangaSiteSelection.RootNode^.TotalHeight, lNode^.NodeHeight)
        else
          Exclude(lNode^.States, vsVisible);
      end;
    end;
  finally
    vtOptionMangaSiteSelection.EndUpdate;
  end;
end;

procedure TMainForm.btRemoveFilterClick(Sender: TObject);
begin
  if dataProcess.Filtered then
  begin
    vtMangaList.Clear;
    Screen.Cursor := crHourGlass;
    try
      dataProcess.RemoveFilter;
      vtMangaList.RootNodeCount := dataProcess.RecordCount;
      lbMode.Caption := Format(RS_ModeAll, [dataProcess.RecordCount]);
      edSearch.Tag := -1;
      edSearch.Clear;
    except
      on E: Exception do
        ExceptionHandler(Self, E);
    end;
    Screen.Cursor := crDefault;
  end;
end;

// -----

procedure TMainForm.btFilterClick(Sender: TObject);
var
  checkGenres,
  uncheckGenres: TStringList;
  i: Integer;
  s: String;
begin
  Screen.Cursor := crHourGlass;
  checkGenres := TStringList.Create;
  uncheckGenres := TStringList.Create;
  try
    edCustomGenres.Text := Trim(edCustomGenres.Text);
    if cbUseRegExpr.Checked and (edCustomGenres.Text <> '') then
      checkGenres.Add(edCustomGenres.Text)
    else
    begin
      ExtractStrings([','], [], PChar(edCustomGenres.Text), checkGenres);
      TrimStrings(checkGenres);
      i := 0;
      while i < checkGenres.Count do begin
        s := Trim(checkGenres.Strings[i]);
        if (s <> '') and (s[1] = '-') or (s[1] = '!') then begin
          Delete(s, 1, 1);
          uncheckGenres.Add(s);
          checkGenres.Delete(i);
        end
        else Inc(i);
      end;
    end;

    if pnGenres.ControlCount > 0 then
      for i := 0 to pnGenres.ControlCount - 1 do
        if pnGenres.Controls[i] is TCheckBox then begin
          if TCheckBox(pnGenres.Controls[i]).State = cbChecked then
            checkGenres.Add(TCheckBox(pnGenres.Controls[i]).Caption)
          else
          if TCheckBox(pnGenres.Controls[i]).State = cbUnchecked then
            uncheckGenres.Add(TCheckBox(pnGenres.Controls[i]).Caption);
        end;

    if dataProcess.CanFilter(
      checkGenres,
      uncheckGenres,
      edFilterTitle.Text,
      edFilterAuthors.Text,
      edFilterArtists.Text,
      IntToStr(cbFilterStatus.ItemIndex),
      edFilterSummary.Text,
      OptionNewMangaTime,
      rbAll.Checked,
      cbOnlyNew.Checked) then
    begin
      dataProcess.FilterAllSites := cbSearchFromAllSites.Checked;
      if cbSearchFromAllSites.Checked then
        dataProcess.SitesList.Assign(cbSelectManga.Items);

      edSearch.Tag := -1;
      edSearch.Clear;
      vtMangaList.Clear;

      dataProcess.Filter(
        checkGenres,
        uncheckGenres,
        edFilterTitle.Text,
        edFilterAuthors.Text,
        edFilterArtists.Text,
        IntToStr(cbFilterStatus.ItemIndex),
        edFilterSummary.Text,
        OptionNewMangaTime,
        rbAll.Checked,
        cbOnlyNew.Checked,
        cbUseRegExpr.Checked);
    end;
  except
    on E: Exception do
      ExceptionHandler(Self, E);
  end;
  uncheckGenres.Free;
  checkGenres.Free;
  Screen.Cursor := crDefault;

  vtMangaList.RootNodeCount := dataProcess.RecordCount;
  if dataProcess.Filtered then
    lbMode.Caption := Format(RS_ModeFiltered, [vtMangaList.RootNodeCount])
  else
    lbMode.Caption := Format(RS_ModeAll, [vtMangaList.RootNodeCount])
end;

procedure TMainForm.btFilterResetClick(Sender: TObject);
var
  i: Cardinal;
begin
  for i := 0 to 37 do
    TCheckBox(pnGenres.Controls[i]).State := cbGrayed;
  edFilterTitle.Caption := '';
  edFilterAuthors.Caption := '';
  edFilterArtists.Caption := '';
  edFilterSummary.Caption := '';
  cbFilterStatus.ItemIndex := 2;
  edCustomGenres.Caption := '';
end;

// ----- vtMangaList popup menu -----

procedure TMainForm.miMangaListAddToFavoritesClick(Sender: TObject);
var
  i: Cardinal;
  xNode: PVirtualNode;
begin
  if vtMangaList.SelectedCount = 0 then Exit;
  SilentThreadManager.BeginAdd;
  try
    xNode := vtMangaList.GetFirstSelected;
    for i := 0 to vtMangaList.SelectedCount - 1 do
    begin
      if vtMangaList.Selected[xNode] then
      begin
        SilentThreadManager.Add(MD_AddToFavorites,
          dataProcess.WebsiteName[xNode^.Index],
          DataProcess.Value[xNode^.Index, DATA_PARAM_TITLE],
          DataProcess.Value[xNode^.Index, DATA_PARAM_LINK]);
      end;
      xNode := vtMangaList.GetNextSelected(xNode);
    end;
  finally
    SilentThreadManager.EndAdd;
  end;
end;

// ----- vtFavorites popup menu -----

procedure TMainForm.miFavoritesDeleteClick(Sender: TObject);
var
  xNode: PVirtualNode;
begin
  if vtFavorites.SelectedCount = 0 then Exit;
  if FavoriteManager.isRunning then begin
    MessageDlg('', RS_DlgFavoritesCheckIsRunning,
      mtInformation, [mbOK], 0);
    Exit;
  end;
  if cbOptionShowDeleteTaskDialog.Checked then
    if MessageDlg('', RS_DlgRemoveFavorite, mtConfirmation, [mbYes, mbNo], 0) = mrNo then
      Exit;

  xNode := vtFavorites.GetLast();
  while Assigned(xNode) do begin
    if vtFavorites.Selected[xNode] then
      FavoriteManager.Remove(xNode^.Index, False);
    xNode := vtFavorites.GetPreviousSelected(xNode);
  end;
  FavoriteManager.Backup;
  UpdateVtFavorites;
end;

procedure TMainForm.miFavoritesChangeCurrentChapterClick(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  if FavoriteManager.isRunning then
  begin
    MessageDlg('', RS_DlgFavoritesCheckIsRunning,
      mtInformation, [mbYes, mbNo], 0);
    Exit;
  end;
  if not Assigned(vtFavorites.FocusedNode) then
    Exit;
  s := FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.currentChapter;
  repeat
    if InputQuery('', RS_DlgTypeInNewChapter, s) then
  until TryStrToInt(s, i);
  if s <> FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.currentChapter then
  begin
    FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.currentChapter := s;
    UpdateVtFavorites;
    FavoriteManager.Backup;
  end;
end;

procedure TMainForm.miFavoritesChangeSaveToClick(Sender: TObject);
begin
  if FavoriteManager.isRunning then
  begin
    MessageDlg('', RS_DlgFavoritesCheckIsRunning,
      mtInformation, [mbYes, mbNo], 0);
    Exit;
  end;
  if not Assigned(vtFavorites.FocusedNode) then
    Exit;
  if InputQuery('', RS_DlgTypeInNewSavePath,
    FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.SaveTo) then
  begin
    FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.SaveTo :=
      CorrectFilePath(FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.SaveTo);
    UpdateVtFavorites;
    FavoriteManager.Backup;
  end;
end;

// ----- clbChapterList popup menu -----

procedure TMainForm.miChapterListCheckSelectedClick(Sender: TObject);
var
  i: Cardinal;
  xNode: PVirtualNode;
begin
  if clbChapterList.SelectedCount > 0 then
  begin
    xNode := clbChapterList.GetFirstSelected;
    for i := 0 to clbChapterList.SelectedCount - 1 do
    begin
      if clbChapterList.Selected[xNode] then
        xNode^.CheckState := csCheckedNormal;
      clbChapterList.InvalidateNode(xNode);
      xNode := clbChapterList.GetNextSelected(xNode);
    end;
  end;
end;

procedure TMainForm.miChapterListUncheckSelectedClick(Sender: TObject);
var
  i: Cardinal;
  xNode: PVirtualNode;
begin
  if clbChapterList.SelectedCount > 0 then
  begin
    xNode := clbChapterList.GetFirstSelected;
    for i := 0 to clbChapterList.SelectedCount - 1 do
    begin
      if clbChapterList.Selected[xNode] then
        xNode^.CheckState := csUncheckedNormal;
      clbChapterList.InvalidateNode(xNode);
      xNode := clbChapterList.GetNextSelected(xNode);
    end;
  end;
end;

procedure TMainForm.miChapterListCheckAllClick(Sender: TObject);
var
  i: Cardinal;
  Node: PVirtualNode;
begin
  if clbChapterList.RootNodeCount > 0 then
  begin
    Node := clbChapterList.GetFirst;
    for i := 0 to clbChapterList.RootNodeCount - 1 do
    begin
      Node^.CheckState := csCheckedNormal;
      clbChapterList.InvalidateNode(Node);
      Node := clbChapterList.GetNext(Node);
    end;
  end;
end;

procedure TMainForm.miChapterListUncheckAllClick(Sender: TObject);
var
  i: Cardinal;
  Node: PVirtualNode;
begin
  if clbChapterList.RootNodeCount > 0 then
  begin
    Node := clbChapterList.GetFirst;
    for i := 0 to clbChapterList.RootNodeCount - 1 do
    begin
      Node^.CheckState := csUncheckedNormal;
      clbChapterList.InvalidateNode(Node);
      Node := clbChapterList.GetNext(Node);
    end;
  end;
end;

// ----- vtDownload popup menu -----

procedure TMainForm.mnDownload1ClickClick(Sender: TObject);
var
  i: Integer;
begin
  if not isUpdating then
  begin
    if (MessageDlg('', RS_DlgUpdaterWantToUpdateDB, mtInformation, [mbYes, mbNo], 0) =
      mrYes) then
    begin
      // if dataProcess.Title.Count > 1 then
      //begin
      isUpdating := True;
      updateList := TUpdateMangaManagerThread.Create;
      for i := 0 to cbSelectManga.Items.Count - 1 do
        updateList.websites.Add(cbSelectManga.Items[i]);
      updateList.isDownloadFromServer := True;
      updateList.Start;
      //end;
    end;
  end
  else
    MessageDlg('', RS_DlgFavoritesCheckIsRunning, mtInformation, [mbYes], 0);
end;

procedure TMainForm.mnUpdate1ClickClick(Sender: TObject);
var
  i, j, e: Cardinal;
  f: Boolean;
  st: TStringList;
begin
  if (not isUpdating) then
  begin
    {$IFNDEF SELFUPDATE}
    if dataProcess.Title.Count > 0 then
    {$ENDIF}
    begin
      isUpdating := True;
      updateList := TUpdateMangaManagerThread.Create;
      for i := 0 to cbSelectManga.Items.Count - 1 do
        updateList.websites.Add(cbSelectManga.Items[i]);
      updateList.isDownloadFromServer := False;
      updateList.Start;
    end;
  end
  else
  begin
    e := 0;
    if (updateList.websites.Count > 0) and (cbSelectManga.Items.Count > 0) then
    begin
      st := TStringList.Create;
      st.Assign(updateList.websites);
      for i := 0 to st.Count - 1 do
      begin
        st[i] := Trim(StringReplace(st[i], UTF8Encode(WideString(#$2714)), '', []));
      end;
      for i := 0 to cbSelectManga.Items.Count - 1 do
      begin
        f := False;
        for j := 0 to st.Count - 1 do
          if cbSelectManga.Items[i] = st[j] then
          begin
            Inc(e);
            f := True;
            Break;
          end;
        if not f then
          updateList.websites.Add(cbSelectManga.Items[i]);
      end;
      st.Free;
    end;
    if (e > 0) and (e = cbSelectManga.Items.Count) then
      MessageDlg('', RS_DlgFavoritesCheckIsRunning, mtInformation, [mbYes], 0);
  end;
end;

procedure TMainForm.mnUpdateDownFromServerClick(Sender: TObject);
begin
  if (not isUpdating) then
    RunGetList
  else
    MessageDlg('', RS_DlgFavoritesCheckIsRunning, mtInformation, [mbYes], 0);
end;

procedure TMainForm.mnUpdateListClick(Sender: TObject);
var
  i: Cardinal;
  e: Boolean;
  st: TStringList;
begin
  if (not isUpdating) then
  begin
    {$IFNDEF SELFUPDATE}
    if dataProcess.Title.Count > 0 then
    {$ENDIF}
    begin
      isUpdating := True;
      updateList := TUpdateMangaManagerThread.Create;
      updateList.numberOfThreads := 4;
      updateList.websites.Add(cbSelectManga.Items[cbSelectManga.ItemIndex]);
      updateList.isDownloadFromServer := False;
      updateList.Start;
    end;
  end
  else
  begin
    e := False;
    st := TStringList.Create;
    st.Assign(updateList.websites);
    if st.Count > 0 then
    begin
      for i := 0 to st.Count - 1 do
      begin
        st[i] := Trim(StringReplace(st[i], UTF8Encode(WideString(#$2714)), '', []));
        if st[i] = cbSelectManga.Items[cbSelectManga.ItemIndex] then
          e := True;
      end;
    end;
    st.Free;
    if not e then
      updateList.websites.Add(cbSelectManga.Items[cbSelectManga.ItemIndex])
    else
      MessageDlg('', RS_DlgFavoritesCheckIsRunning, mtInformation, [mbYes], 0);
  end;
end;

procedure TMainForm.miDownloadDeleteCompletedClick(Sender: TObject);
begin
  if cbOptionShowDeleteTaskDialog.Checked then
    if not (MessageDlg('', RS_DlgRemoveFinishTasks,
      mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
      Exit;
  DLManager.RemoveAllFinishedTasks;
  UpdateVtDownload;
  // the reason we put it in here instead of in DLManager because of the size of
  // download list will change during this method
end;

procedure TMainForm.miDownloadResumeClick(Sender: TObject);
var
  xNode: PVirtualNode;
begin
  if vtDownload.SelectedCount > 0 then begin
    xNode := vtDownload.GetFirstSelected();
    while Assigned(xNode) do begin
      DLManager.SetTaskActive(xNode^.Index);
      xNode := vtDownload.GetNextSelected(xNode);
    end;
    DLManager.CheckAndActiveTask();
    UpdateVtDownload;
  end;
end;

procedure TMainForm.miDownloadStopClick(Sender: TObject);
var
  xNode: PVirtualNode;
begin
  if vtDownload.SelectedCount > 0 then begin
    xNode := vtDownload.GetFirstSelected();
    while Assigned(xNode) do begin
      DLManager.StopTask(xNode^.Index, False);
      xNode := vtDownload.GetNextSelected(xNode);
    end;
    DLManager.CheckAndActiveTask();
    UpdateVtDownload;
  end;
end;

procedure TMainForm.miMangaListDownloadAllClick(Sender: TObject);
var
  xNode: PVirtualNode;
  AllowedToCreate, YesAll, NoAll : Boolean;
  i, j: Integer;
  mResult: TModalResult;
  mBtns: TMsgDlgButtons;
begin
  if vtMangaList.SelectedCount = 0 then Exit;

  SilentThreadManager.BeginAdd;
  try
    YesAll := False;
    NoAll := False;
    if vtMangaList.SelectedCount = 1 then
      mBtns := [mbYes, mbNo]
    else
      mBtns := [mbYes, mbNo, mbYesToAll, mbNoToAll];

    xNode := vtMangaList.GetFirstSelected;
    for i := 0 to vtMangaList.SelectedCount - 1 do
    begin
      if vtMangaList.Selected[xNode] then
      begin
        AllowedToCreate := True;
        if DLManager.Count > 0 then
          for j := 0 to DLManager.Count - 1 do
            if dataProcess.Value[xNode^.Index, DATA_PARAM_TITLE] =
              DLManager.TaskItem(j).DownloadInfo.title then
            begin
              if YesAll then
                AllowedToCreate := True
              else if NoAll then
                AllowedToCreate := False
              else
              begin
                pcMain.ActivePage := tsDownload;
                mResult := MessageDlg('', DLManager.TaskItem(j).DownloadInfo.title +
                  LineEnding + LineEnding + RS_DlgTitleExistInDLlist, mtConfirmation,
                    mBtns, 0);
                case mResult of
                  mrYes : AllowedToCreate := True;
                  mrNo  : AllowedToCreate := False;
                  mrYesToAll :
                    begin
                      YesAll := True;
                      NoAll := False;
                      AllowedToCreate := True;
                    end;
                  mrNoToAll :
                    begin
                      YesAll := False;
                      NoAll := True;
                      AllowedToCreate := False;
                    end;
                end;
              end;
              Break;
            end;

        if AllowedToCreate then
          SilentThreadManager.Add(MD_DownloadAll,
            dataProcess.WebsiteName[xNode^.Index],
            dataProcess.Value[xNode^.Index, DATA_PARAM_TITLE],
            dataProcess.Value[xNode^.Index, DATA_PARAM_LINK]);
      end;
      xNode := vtMangaList.GetNextSelected(xNode);
    end;
  except
    on E: Exception do
      ExceptionHandler(Self, E);
  end;
  SilentThreadManager.EndAdd;
end;

procedure TMainForm.miMangaListViewInfosClick(Sender: TObject);
var
  title, website, link: String;
  i: Integer;
begin
  if (not vtMangaList.Focused) or (vtMangaList.SelectedCount = 0) then
    Exit;
  btDownload.Enabled := False;
  btAddToFavorites.Enabled := False;
  pcMain.ActivePage := tsInformation;
  imCover.Picture.Assign(nil);
  rmInformation.Clear;
  rmInformation.Lines.Add(RS_Loading);
  clbChapterList.Clear;

  if isGetMangaInfos then
  begin
    GetInfosThread.IsFlushed := True;
    GetInfosThread.Terminate;
    //GetInfosThread.WaitFor;
  end;
  GetInfosThread := TGetMangaInfosThread.Create;
  GetInfosThread.MangaListPos := vtMangaList.FocusedNode^.Index;

  website := dataProcess.WebsiteName[GetInfosThread.MangaListPos];
  title := DataProcess.Value[GetInfosThread.mangaListPos, DATA_PARAM_TITLE];
  link := DataProcess.Value[GetInfosThread.mangaListPos, DATA_PARAM_LINK];

  GetInfosThread.Title := title;
  GetInfosThread.Website := website;
  GetInfosThread.Link := link;
  GetInfosThread.Start;

  i := Modules.LocateModule(website);
  if i > -1 then
    edURL.Text := FillHost(Modules.Module[i].RootURL, link)
  else
    edURL.Text := FillMangaSiteHost(website, link);

  if Assigned(gifWaiting) then
  begin
    itAnimate.Enabled := True;
    pbWait.Visible := True;
  end;

  btReadOnline.Enabled := (link <> '');
end;

procedure TMainForm.miFavoritesOpenFolderClick(Sender: TObject);
begin
  if not Assigned(vtFavorites.FocusedNode) then
    Exit;
  OpenDocument(TrimRightChar(
    FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.SaveTo,
    [PathDelim]));
end;

procedure TMainForm.miDownloadOpenFolderClick(Sender: TObject);
begin
  if (vtDownload.SelectedCount = 0) or (Assigned(vtDownload.FocusedNode) = False) then
    Exit;
  OpenDocument(TrimRightChar(
    DLManager.TaskItem(vtDownload.FocusedNode^.Index).DownloadInfo.SaveTo,
    [PathDelim]));
end;

procedure TMainForm.miFavoritesOpenWithClick(Sender: TObject);
var
  f, fd: String;
  Info: TSearchRec;
  l: TStringList;
begin
  if (not Assigned(vtFavorites.FocusedNode)) then
    Exit;
  l := TStringList.Create;
  try
    fd := StringReplace(FavoriteManager.FavoriteItem(
      vtFavorites.FocusedNode^.Index).FavoriteInfo.SaveTo, '/', '\', [rfReplaceAll]);
    if fd[Length(fd)] <> PathDelim then
      fd := fd + PathDelim;

    if FindFirstUTF8(fd + '*', faAnyFile and faDirectory, Info) = 0 then
      repeat
        l.Add(Info.Name);
      until FindNextUTF8(Info) <> 0;
    if l.Count >= 3 then
      f := l.Strings[2]
    else
      f := '';
    FindCloseUTF8(Info);

    OpenWithExternalProgram(fd, f);
  except
  end;
  l.Free;
end;

procedure TMainForm.miDownloadOpenWithClick(Sender: TObject);
var
  f, fd, ff: String;
  Info: TSearchRec;
  l: TStringList;
begin
  if (not Assigned(vtDownload.FocusedNode)) then
    Exit;
  l := TStringList.Create;
  try
    fd := StringReplace(DLManager.TaskItem(
      vtDownload.FocusedNode^.Index).DownloadInfo.SaveTo, '/', '\', [rfReplaceAll]);
    if fd[Length(fd)] <> PathDelim then
      fd := fd + PathDelim;

    if DLManager.TaskItem(vtDownload.FocusedNode^.Index).ChapterName.Count > 0 then
    begin
      ff := DLManager.TaskItem(vtDownload.FocusedNode^.Index).
        ChapterName[0];
      if FileExistsUTF8(fd + ff + '.zip') then
        f := ff + '.zip'
      else if FileExistsUTF8(fd + ff + '.cbz') then
        f := ff + '.cbz'
      else if FileExistsUTF8(fd + ff + '.pdf') then
        f := ff + '.pdf'
      else if DirectoryExistsUTF8(fd + ff) then
        f := ff
      else
        f := '';
    end;

    if f = '' then
    begin
      if FindFirstUTF8(fd + '*', faAnyFile and faDirectory, Info) = 0 then
        repeat
          l.Add(Info.Name);
        until FindNextUTF8(Info) <> 0;
      if l.Count >= 3 then
        f := l.Strings[2]
      else
        f := '';
      FindCloseUTF8(Info);
    end;

    OpenWithExternalProgram(fd, f);
  except
  end;
  l.Free;
end;

procedure TMainForm.pcMainChange(Sender: TObject);
begin
  if pcMain.ActivePage = tsFavorites then
    vtFavorites.Repaint
  else if pcMain.ActivePage = tsOption then
    LoadOptions;
end;

procedure TMainForm.pmDownloadPopup(Sender: TObject);

  function FinishedTaskPresent: Boolean;
  var
    i: Integer;
  begin
    Result := False;
    with DLManager do begin
      CS_DownloadManager_Task.Acquire;
      try
        for i := 0 to Count - 1 do
          if TaskItem(i).Status = STATUS_FINISH then
          begin
            Result := True;
            Break;
          end;
      finally
        CS_DownloadManager_Task.Release;
      end;
    end;
  end;

  function SelectedTaskStatusPresent(Stats: TDownloadStatusTypes): Boolean;
  var
    xNode: PVirtualNode;
  begin
    Result := False;
    if vtDownload.SelectedCount > 0 then
    begin
      with DLManager do
      begin
        CS_DownloadManager_Task.Acquire;
        try
          xNode := vtDownload.GetFirstSelected;
          repeat
            if TaskItem(xNode^.Index).Status in Stats then
            begin
              Result := True;
              Break;
            end;
            xNode := vtDownload.GetNextSelected(xNode);
          until xNode = nil;
        finally
          CS_DownloadManager_Task.Release;
        end;
      end;
    end;
  end;

begin
  with DLManager do begin
    if vtDownload.SelectedCount = 0 then
    begin
      miDownloadStop.Enabled := False;
      miDownloadResume.Enabled := False;
      miDownloadDelete.Enabled := False;
      miDownloadDeleteTask.Enabled := False;
      miDownloadDeleteTaskData.Enabled := False;
      miDownloadDeleteCompleted.Enabled := FinishedTaskPresent;
      miDownloadMergeCompleted.Enabled := miDownloadDeleteCompleted.Enabled;
      miDownloadViewMangaInfo.Enabled := False;
      miDownloadOpenFolder.Enabled := False;
      miDownloadOpenWith.Enabled := False;
    end
    else
    if vtDownload.SelectedCount = 1 then
    begin
      miDownloadStop.Enabled := (TaskItem(vtDownload.FocusedNode^.Index).Status in [STATUS_DOWNLOAD, STATUS_PREPARE, STATUS_WAIT]);
      miDownloadResume.Enabled := (TaskItem(vtDownload.FocusedNode^.Index).Status in [STATUS_STOP, STATUS_FAILED, STATUS_PROBLEM]);
      miDownloadDelete.Enabled := True;
      miDownloadDeleteTask.Enabled := True;
      miDownloadDeleteTaskData.Enabled := True;
      miDownloadDeleteCompleted.Enabled := FinishedTaskPresent;
      miDownloadMergeCompleted.Enabled := miDownloadDeleteCompleted.Enabled;
      miDownloadViewMangaInfo.Enabled := (TaskItem(vtDownload.FocusedNode^.Index).DownloadInfo.Link <> '');
      miDownloadOpenFolder.Enabled := True;
      miDownloadOpenWith.Enabled := True;
    end
    else
    begin
      miDownloadStop.Enabled := SelectedTaskStatusPresent([STATUS_DOWNLOAD, STATUS_PREPARE, STATUS_WAIT]);
      miDownloadResume.Enabled := SelectedTaskStatusPresent([STATUS_STOP, STATUS_FAILED, STATUS_PROBLEM]);
      miDownloadDelete.Enabled := True;
      miDownloadDeleteTask.Enabled := True;
      miDownloadDeleteTaskData.Enabled := True;
      miDownloadDeleteCompleted.Enabled := FinishedTaskPresent;
      miDownloadMergeCompleted.Enabled := miDownloadDeleteCompleted.Enabled;
      miDownloadViewMangaInfo.Enabled := False;
      miDownloadOpenFolder.Enabled := False;
      miDownloadOpenWith.Enabled := False;
    end;
  end;
end;

procedure TMainForm.pmEditURLPopup(Sender: TObject);
begin
  medURLUndo.Enabled := edURL.CanUndo;
  medURLCut.Enabled := (Length(edURL.SelText) <> 0);
  medURLCopy.Enabled := (Length(edURL.SelText) <> 0);
  medURLPaste.Enabled := (Length(Clipboard.AsText) <> 0);
  medURLPasteandgo.Enabled := (Length(Clipboard.AsText) <> 0);
  medtURLDelete.Enabled := (Length(edURL.SelText) <> 0);
  medURLSelectAll.Enabled := (Length(edURL.Text) <> 0) and
    (edURL.SelLength <> Length(edURL.Text));
end;

procedure TMainForm.pmFavoritesPopup(Sender: TObject);

  function SelectedStatusPresent(Stats: TFavoriteStatusTypes): Boolean;
  var
    xNode: PVirtualNode;
  begin
    Result := False;
    with FavoriteManager do
    begin
      if vtFavorites.SelectedCount > 0 then
      begin
        Lock;
        try
          xNode := vtFavorites.GetFirstSelected;
          repeat
            if Assigned(xNode) then
            begin
              if FavoriteManager.FavoriteItem(xNode^.Index).Status in Stats then
              begin
                Result := True;
                Break;
              end;
              xNode := vtFavorites.GetNextSelected(xNode);
            end;
          until xNode = nil;
        finally
          LockRelease;
        end;
      end;
    end;
  end;

begin
  if vtFavorites.SelectedCount = 0 then
  begin
    miFavoritesViewInfos.Enabled := False;
    miFavoritesDownloadAll.Enabled := False;
    miFavoritesDelete.Enabled := False;
    miFavoritesChangeSaveTo.Enabled := False;
    miFavoritesOpenFolder.Enabled := False;
    miFavoritesOpenWith.Enabled := False;
  end
  else
  if vtFavorites.SelectedCount = 1 then
  begin
    miFavoritesCheckNewChapter.Visible := SelectedStatusPresent([STATUS_IDLE]);
    miFavoritesStopCheckNewChapter.Visible :=
      SelectedStatusPresent([STATUS_CHECK, STATUS_CHECKING]);
    miFavoritesViewInfos.Enabled := True;
    miFavoritesDownloadAll.Enabled := (Trim(FavoriteManager.FavoriteItem(
      vtFavorites.FocusedNode^.Index).FavoriteInfo.Link) <> '');
    miFavoritesDelete.Enabled := True;
    miFavoritesChangeSaveTo.Enabled := True;
    miFavoritesOpenFolder.Enabled :=
      DirectoryExistsUTF8(FavoriteManager.FavoriteItem(vtFavorites.FocusedNode^.Index).FavoriteInfo.SaveTo);
    miFavoritesOpenWith.Enabled := miFavoritesOpenFolder.Enabled;
  end
  else
  begin
    miFavoritesCheckNewChapter.Visible := SelectedStatusPresent([STATUS_IDLE]);
    miFavoritesStopCheckNewChapter.Visible :=
      SelectedStatusPresent([STATUS_CHECK, STATUS_CHECKING]);
    miFavoritesViewInfos.Enabled := False;
    miFavoritesDownloadAll.Enabled := True;
    miFavoritesDelete.Enabled := True;
    miFavoritesChangeSaveTo.Enabled := False;
    miFavoritesOpenFolder.Enabled := False;
    miFavoritesOpenWith.Enabled := False;
  end;
  if FavoriteManager.isRunning then
  begin
    miFavoritesDelete.Enabled := False;
    miFavoritesChangeSaveTo.Enabled := False;
  end;
end;

procedure TMainForm.pmMangaListPopup(Sender: TObject);
begin
  if vtMangaList.SelectedCount = 1 then
  begin
    pmMangaList.Items[0].Enabled := True;
    pmMangaList.Items[1].Enabled := True;
    pmMangaList.Items[2].Enabled := True;
  end
  else
  if vtMangaList.SelectedCount > 1 then
  begin
    pmMangaList.Items[0].Enabled := False;
    pmMangaList.Items[1].Enabled := True;
    pmMangaList.Items[2].Enabled := True;
  end;
  pmMangaList.Items[2].Enabled := not SitesWithoutFavorites(cbSelectManga.Text);
end;

procedure TMainForm.pmSbMainPopup(Sender: TObject);
begin
  if Assigned(SilentThreadManager) then
  begin
    if SilentThreadManager.ItemCount = 0 then
      Abort;
  end
  else
    Abort;
end;

procedure TMainForm.sbUpdateListDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  ClRect, TxtRect, BarRect, ProgressBarRect: TRect;
  Percents: double;
begin
  if Panel.Index = 0 then
  begin
    //Button
    with btAbortUpdateList do
    begin
      Left := Rect.Right - Width - 3;
      Top := Rect.Top + 2;
    end;

    //Information
    if ulTotalPtr = 0 then
      ulTotalPtr := 100;
    if ulWorkPtr > ulTotalPtr then
      ulWorkPtr := 0;
    Percents := ulWorkPtr / ulTotalPtr;
    with StatusBar.Canvas do
    begin
      ClRect := Rect;
      ClRect.Left := Rect.Left + 3;
      ClRect.Right := Rect.Right - btAbortUpdateList.Width - 6;
      ClRect.Bottom := Rect.Bottom - 3;

      TxtRect := ClRect;
      TxtRect.Bottom := TxtRect.Top + TextHeight('A');
      //progress-bar box
      BarRect := ClRect;
      BarRect.Top := TxtRect.Bottom + 2;

      Pen.Style := psSolid;
      Brush.Style := bsSolid;
      Pen.Color := RGB(188, 188, 188);
      Brush.Color := RGB(230, 230, 230);
      Rectangle(BarRect);

      ProgressBarRect := BarRect;
      ProgressBarRect.Right := round((ProgressBarRect.Right - ProgressBarRect.Left) *
        Percents) + ProgressBarRect.Left;

      if (ProgressBarRect.Right - ProgressBarRect.Left) > 0 then
      begin
        //green
        Pen.Color := RGB(6, 176, 37);
        Brush.Color := RGB(50, 217, 66);
        //orange
        //Pen.Color := RGB(153, 79, 0);
        //Brush.Color := RGB(233, 112, 24);
        Rectangle(ProgressBarRect);
      end;
      Brush.Style := bsClear;
      TextRect(txtRect, 5, 0, Panel.Text, UpdateStatusTextStyle);
    end;
  end;
end;

procedure TMainForm.seOptionAutoCheckFavIntervalMinutesChange(Sender: TObject);
begin
  lbOptionAutoCheckFavIntervalMinutes.Caption :=
    Format(RS_LblAutoCheckNewChapterMinute, [seOptionAutoCheckFavIntervalMinutes.Value]);
end;

procedure TMainForm.spMainSplitterMoved(Sender: TObject);
begin
  sbMain.Panels[0].Width := spMainSplitter.Left;
end;

procedure TMainForm.tbDownloadDeleteCompletedClick(Sender: TObject);
begin
  if DLManager.TaskStatusPresent([STATUS_FINISH]) then
    miDownloadDeleteCompletedClick(miDownloadDeleteCompleted);
end;

procedure TMainForm.tbDownloadResumeAllClick(Sender: TObject);
begin
  DLManager.StartAllTasks;
  UpdateVtDownload;
end;

procedure TMainForm.tbDownloadStopAllClick(Sender: TObject);
begin
  DLManager.StopAllTasks;
  UpdateVtDownload;
end;

procedure TMainForm.tbDropTargetOpacityChange(Sender: TObject);
begin
  frmDropTarget.FAlphaBlendValue := tbDropTargetOpacity.Position;
  if Assigned(FormDropTarget) then
    FormDropTarget.AlphaBlendValue := frmDropTarget.FAlphaBlendValue;
end;

procedure TMainForm.tbWebsitesCollapseAllClick(Sender: TObject);
begin
  vtOptionMangaSiteSelection.FullCollapse;
end;

procedure TMainForm.tbWebsitesExpandAllClick(Sender: TObject);
begin
  vtOptionMangaSiteSelection.FullExpand;
end;

procedure TMainForm.TrayIconDblClick(Sender: TObject);
begin
  if (WindowState = wsMinimized) or (Visible = False) then
  begin
    WindowState := PrevWindowState;
    ShowInTaskBar := stDefault;
    Show;
  end
  else
    Application.BringToFront;
end;

procedure TMainForm.tvDownloadFilterSelectionChanged(Sender: TObject);
begin
  vtDownloadFilters;
  pcMain.ActivePage := tsDownload;
  options.WriteInteger('general', 'DownloadFilterSelect',
    tvDownloadFilter.Selected.AbsoluteIndex);
end;

procedure TMainForm.UniqueInstanceFMDOtherInstance(Sender: TObject;
  ParamCount: Integer; Parameters: array of String);
begin
  if WindowState = wsMinimized then
    WindowState := wsNormal;
  Show;
  BringToFront;
end;

procedure TMainForm.vtDownloadAfterCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  const CellRect: TRect);
var
  Data: PDownloadInfo;
  BarRect, ProgressBarRect: TRect;
  Percents: double;
  ww, hh: Integer;
begin
  if Node = nil then Exit;
  if Node^.Index >= DLManager.Count then Exit;
  if Column = 2 then
  begin
    Data := vtDownload.GetNodeData(Node);
    //if Data^.Status = stFinish then
    if DLManager.TaskItem(Node^.Index).Status in
      [STATUS_FINISH, STATUS_COMPRESS, STATUS_FAILED] then
      Percents := 1
    else
    if StrToIntDef(Trim(ExtractWord(2, Data^.Progress, ['/'])), 100) = 0 then
      Percents := 0
    else
      Percents := StrToIntDef(Trim(ExtractWord(1, Data^.Progress, ['/'])), 0) /
        StrToIntDef(Trim(ExtractWord(2, Data^.Progress, ['/'])), 100);
    //progress-bar box
    BarRect.Left := CellRect.Left + 2;
    BarRect.Top := CellRect.Top + 2;
    BarRect.Right := CellRect.Right - 2;
    BarRect.Bottom := CellRect.Bottom - 2;
    TargetCanvas.Pen.Style := psSolid;
    TargetCanvas.Brush.Style := bsSolid;

    TargetCanvas.Pen.Color := RGB(188, 188, 188);
    TargetCanvas.Brush.Color := RGB(230, 230, 230);

    TargetCanvas.Rectangle(BarRect);
    //TargetCanvas.RoundRect(BarRect, 6,6);

    // a progress-bar
    ProgressBarRect := BarRect;
    //Inc(ProgressBarRect.Left);
    //Inc(ProgressBarRect.Top);
    //Dec(ProgressBarRect.Right);
    //Dec(ProgressBarRect.Bottom);
    ProgressBarRect.Right := round((ProgressBarRect.Right - ProgressBarRect.Left) *
      Percents) + ProgressBarRect.Left;
    if (ProgressBarRect.Right - ProgressBarRect.Left) > 0 then
    begin
      //TargetCanvas.Pen.Style:= psClear;

      case DLManager.TaskItem(Node^.Index).Status of
        //(STATUS_STOP, STATUS_WAIT, STATUS_PREPARE,
        //STATUS_DOWNLOAD, STATUS_FINISH, STATUS_COMPRESS, STATUS_PROBLEM, STATUS_FAILED);
        STATUS_STOP, STATUS_FAILED:
        begin
          //Red
          TargetCanvas.Pen.Color := RGB(177, 26, 26);
          TargetCanvas.Brush.Color := RGB(240, 74, 74);
        end;
        STATUS_WAIT:
        begin
          //gray
          TargetCanvas.Pen.Color := RGB(188, 188, 188);
          TargetCanvas.Brush.Color := RGB(230, 230, 230);
        end;
        STATUS_DOWNLOAD:
        begin
          //blue
          TargetCanvas.Pen.Color := RGB(29, 107, 179);
          TargetCanvas.Brush.Color := RGB(79, 178, 250);
          //blue light
          //TargetCanvas.Pen.Color:= RGB(124,178,234);
          //TargetCanvas.Brush.Color:= RGB(163,210,254);
        end;
        STATUS_PROBLEM:
        begin
          //yellow
          //TargetCanvas.Pen.Color := RGB(195, 145, 79);
          TargetCanvas.Pen.Color := RGB(240, 74, 74);
          TargetCanvas.Brush.Color := RGB(254, 235, 128);
        end;
        STATUS_FINISH:
        begin
          //green
          TargetCanvas.Pen.Color := RGB(6, 176, 37);
          TargetCanvas.Brush.Color := RGB(50, 217, 66);
        end;
        else
        begin
          //browngold
          TargetCanvas.Pen.Color := RGB(200, 162, 94);
          TargetCanvas.Brush.Color := RGB(240, 213, 141);
        end;
      end;
      //TargetCanvas.RoundRect(ProgressBarRect, 5, 5);
      TargetCanvas.Rectangle(ProgressBarRect);
      //TargetCanvas.FillRect(ProgressBarRect);
    end;
    //text
    TargetCanvas.Font.Color := clBlack;
    TargetCanvas.Brush.Style := bsClear;
    TargetCanvas.GetTextSize(Data^.Progress, ww, hh);
    TargetCanvas.TextOut(CellRect.Left + ((CellRect.Right - CellRect.Left - ww) div 2),
      CellRect.Top + ((CellRect.Bottom - CellRect.Top - hh) div 2), Data^.Progress);
  end;
end;

procedure TMainForm.vtDownloadColumnDblClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
begin
  miDownloadOpenFolderClick(Sender);
end;

procedure TMainForm.vtDownloadDragAllowed(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
begin
  Allowed := True;
end;

procedure TMainForm.vtDownloadMoveItems(NextIndex: Cardinal; Mode: TDropMode);
var
  i, nIndex: Integer;
  cNode: PVirtualNode;
  ConTemp: TFPList;
begin
  vtDownload.BeginUpdate;
  ConTemp := TFPList.Create;
  try
    nIndex := NextIndex;

    if vtDownload.SelectedCount > 0 then
    begin
      cNode := vtDownload.GetFirst;
      i := 0;
      while i < vtDownload.RootNodeCount do
               //DLManager.Count do
      begin
        if vtDownload.Selected[cNode] then
        begin
          vtDownload.Selected[cNode] := False;
          ConTemp.Add(DLManager.TaskItem(i));
          DLManager.containers.Delete(i);
          if (i < nIndex) and (nIndex > 0) then
            Dec(nIndex);
        end
        else
          Inc(i);
        cNode := vtDownload.GetNext(cNode);
      end;
      vtDownload.FocusedNode := nil;

      for i := 0 to ConTemp.Count - 1 do
      begin
        if (i = 0) and (Mode in [dmBelow, dmNowhere]) then
          Inc(nIndex)
        else
        if (i > 0) then
        begin
          if (nIndex < DLManager.Count) then
            Inc(nIndex);
        end;
        if nIndex > DLManager.Count then
          Dec(nIndex);
        DLManager.containers.Insert(nIndex, ConTemp[i]);
      end;

      cNode := vtDownload.GetFirst;
      while Assigned(cNode) and (cNode^.Index < nIndex) do
        cNode := vtDownload.GetNext(cNode);

      for i := 0 to ConTemp.Count - 1 do
      begin
        if Assigned(cNode) then
        begin
          vtDownload.Selected[cNode] := True;
          vtDownload.FocusedNode := cNode;
          cNode := vtDownload.GetPrevious(cNode);
        end;
      end;
    end;
  finally
    ConTemp.Free;
    cNode := nil;
    vtDownload.EndUpdate;
    //vtDownload.Repaint;
    //Some node isn't repaint correctly if not explicitly triggering repaint?
  end;
  vtDownloadFilters;
end;

procedure TMainForm.vtDownloadDragDrop(Sender : TBaseVirtualTree;
  Source : TObject; DataObject : IDataObject; Formats : TFormatArray;
  Shift : TShiftState; const Pt : TPoint; var Effect : LongWord;
  Mode : TDropMode);
begin
  if (Source <> vtDownload) or (Source <> Sender) or
    (DLManager.Count < 2) then
    Exit;
  if Mode = dmNowhere then
    vtDownloadMoveItems(vtDownload.GetLast^.Index, Mode)
  else
    vtDownloadMoveItems(vtDownload.DropTargetNode^.Index, Mode);
end;

procedure TMainForm.vtDownloadDragOver(Sender : TBaseVirtualTree;
  Source : TObject; Shift : TShiftState; State : TDragState; const Pt : TPoint;
  Mode : TDropMode; var Effect : LongWord; var Accept : Boolean);
begin
  Accept := (Sender = Source);
end;

// Download table

procedure TMainForm.vtDownloadFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  Data: PDownloadInfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    Finalize(Data^);
end;

procedure TMainForm.vtDownloadGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
  var HintText: String);
var
  l, i: Cardinal;
  p: PDownloadInfo;
begin
  if Node^.Index >= DLManager.Count then Exit;
  if Column = 0 then
  begin
    l := DLManager.TaskItem(Node^.Index).ChapterLinks.Count;
    if l > 0 then
    begin
      HintText := '';
      if l < 5 then
      begin
        for i := 0 to l - 1 do
          if HintText = '' then
            HintText :=
              DLManager.TaskItem(Node^.Index).ChapterName.Strings[i]{ + ' : ' +
        DLManager.TaskItem(Node^.Index).ChapterLinks.Strings[i]}
          else
            HintText := HintText + LineEnding +
              DLManager.TaskItem(Node^.Index).ChapterName.Strings[i]{ + ' : ' +
        DLManager.TaskItem(Node^.Index).ChapterLinks.Strings[i]};
      end
      else
      begin
        for i := 0 to 1 do
          if HintText = '' then
            HintText :=
              DLManager.TaskItem(Node^.Index).ChapterName.Strings[i]{ + ' : ' +
        DLManager.TaskItem(Node^.Index).ChapterLinks.Strings[i]}
          else
            HintText := HintText + LineEnding +
              DLManager.TaskItem(Node^.Index).ChapterName.Strings[i]{ + ' : ' +
        DLManager.TaskItem(Node^.Index).ChapterLinks.Strings[i]};
        HintText := HintText + LineEnding + '...';
        for i := l - 2 to l - 1 do
          HintText := HintText + LineEnding +
            DLManager.TaskItem(Node^.Index).ChapterName.Strings[i]{ + ' : ' +
        DLManager.TaskItem(Node^.Index).ChapterLinks.Strings[i]};
      end;
    end;
  end
  else
  begin
    p := Sender.GetNodeData(Node);
    case Column of
      1: HintText := p^.Status;
      2: HintText := p^.Progress;
      4: HintText := p^.Website;
      5: HintText := p^.SaveTo;
      6: HintText := DateTimeToStr(p^.dateTime);
    end;
  end;
end;

procedure TMainForm.vtDownloadGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
begin
  if (Node^.Index < DLManager.Count) and
    (vtDownload.Header.Columns[Column].Position = 0) then
    ImageIndex := integer(DLManager.TaskItem(Node^.Index).Status);
end;

procedure TMainForm.vtDownloadGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
var
  Data: PDownloadInfo;
  pos: Cardinal;
begin
  if Node^.Index >= DLManager.Count then Exit;
  with Sender do
  begin
    pos := Node^.Index;
    Data := Sender.GetNodeData(Node);
    if (DLManager.Count > 0) then
      if Assigned(Data) and (DLManager.TaskItem(pos) <> nil) then
      begin
        Data^.Title := DLManager.TaskItem(pos).DownloadInfo.Title;
        Data^.Status := DLManager.TaskItem(pos).DownloadInfo.Status;
        Data^.Progress := DLManager.TaskItem(pos).DownloadInfo.Progress;
        Data^.TransferRate := DLManager.TaskItem(pos).DownloadInfo.TransferRate;
        Data^.Website := DLManager.TaskItem(pos).DownloadInfo.Website;
        Data^.SaveTo := DLManager.TaskItem(pos).DownloadInfo.SaveTo;
        Data^.DateTime := DLManager.TaskItem(pos).DownloadInfo.DateTime;
        case Column of
          0: CellText := Data^.title;
          1: CellText := Data^.status;
          2: CellText := '';
          3: CellText := Data^.TransferRate;
          4: CellText := Data^.website;
          5: CellText := Data^.saveTo;
          6: CellText := DateTimeToStr(Data^.dateTime);
        end;
      end;
  end;
end;

procedure TMainForm.vtDownloadHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X, Y: Integer
  );
begin
  if DLManager.Count < 2 then Exit;
  if (Column = 2) or (Column = 3) then Exit;
  if DLManager.SortColumn = Column then
    DLManager.SortDirection := not DLManager.SortDirection;
  DLManager.SortColumn := Column;
  vtDownload.Header.SortDirection := TSortDirection(DLManager.SortDirection);
  vtDownload.Header.SortColumn := Column;
  DLManager.Sort(Column);
  vtDownload.Repaint;
end;

procedure TMainForm.vtDownloadInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PDownloadInfo;
  pos: Cardinal;
begin
  with Sender do
  begin
    pos := Node^.Index;
    Data := GetNodeData(Node);
    if (DLManager.Count <> 0) then
      if (DLManager.TaskItem(pos) <> nil) or
        (not DLManager.TaskItem(pos).Thread.isTerminated) then
      begin
        Data^.title := DLManager.TaskItem(pos).DownloadInfo.title;
        Data^.status := DLManager.TaskItem(pos).DownloadInfo.Status;
        Data^.progress := DLManager.TaskItem(pos).DownloadInfo.Progress;
        Data^.TransferRate := DLManager.TaskItem(pos).DownloadInfo.TransferRate;
        Data^.website := DLManager.TaskItem(pos).DownloadInfo.Website;
        Data^.saveTo := DLManager.TaskItem(pos).DownloadInfo.SaveTo;
        Data^.dateTime := DLManager.TaskItem(pos).DownloadInfo.dateTime;
      end;
  end;
  vtDownload.ValidateNode(Node, False);
end;

procedure TMainForm.vtDownloadKeyDown(Sender : TObject; var Key : Word;
  Shift : TShiftState);
begin
  if (Key in [VK_UP, VK_DOWN]) and (ssCtrl in Shift) then
  begin
    if Key = VK_DOWN then
      vtDownloadMoveItems(vtDownload.GetFirstSelected^.Index, dmBelow)
    else
      if vtDownload.GetFirstSelected^.Index > 0 then
        vtDownloadMoveItems(vtDownload.GetFirstSelected^.Index - 1, dmAbove);
  end;
end;

procedure TMainForm.vtDownloadKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
    miDownloadDeleteTaskClick(miDownloadDeleteTask);
end;

procedure TMainForm.vtFavoritesBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Data: PFavoriteInfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
  begin
    with FavoriteManager.FavoriteItem(Node^.Index) do
    begin
      if Trim(FavoriteInfo.Link) = '' then
      begin
        TargetCanvas.Brush.Color := CL_HLRedMarks;
        TargetCanvas.FillRect(CellRect);
      end
      else
      if Status = STATUS_CHECKING then
      begin
        TargetCanvas.Brush.Color := CL_HLGreenMarks;
        TargetCanvas.FillRect(CellRect);
      end;
    end;
  end;
end;

procedure TMainForm.vtFavoritesColumnDblClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
begin
  miFavoritesOpenFolderClick(Sender);
end;

procedure TMainForm.vtFavoritesFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PFavoriteInfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    Finalize(Data^);
end;

procedure TMainForm.vtFavoritesGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex;
  var LineBreakStyle: TVTTooltipLineBreakStyle; var HintText: String);
var
  Data: PFavoriteInfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    case Column of
      1: if Trim(Data^.Link) = '' then
           HintText := RS_HintFavoriteProblem
         else
           HintText := Data^.Title;
      2: HintText := Data^.currentChapter;
      3: HintText := Data^.website;
      4: HintText := Data^.saveTo;
    end;
end;

procedure TMainForm.vtFavoritesGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PFavoriteInfo;
begin
  if vtFavorites.Header.Columns[Column].Position = 1 then
  begin
    Data := Sender.GetNodeData(Node);
    if Assigned(Data) then
      with FavoriteManager.FavoriteItem(Node^.Index) do
      begin
        if Trim(FavoriteInfo.Link) = '' then
          ImageIndex := 16
        else
        case Status of
          STATUS_CHECK: ImageIndex := 19;
          STATUS_CHECKING: ImageIndex := 12;
          STATUS_CHECKED: ImageIndex := 20;
          else
            ImageIndex := -1;
        end;
      end;
  end;
end;

// vtFavorites

procedure TMainForm.vtFavoritesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
var
  Data: PFavoriteInfo;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then
    case Column of
      0: CellText := Data^.numbering;
      1: CellText := Data^.Title;
      2: CellText := Data^.currentChapter;
      3: CellText := Data^.website;
      4: CellText := Data^.saveTo;
    end;
end;

procedure TMainForm.vtFavoritesHeaderClick(Sender: TVTHeader;
  Column: TColumnIndex; Button: TMouseButton; Shift: TShiftState; X, Y: Integer
  );
begin
  if FavoriteManager.isRunning then Exit;
  if FavoriteManager.Count < 2 then Exit;
  if Column = 0 then Exit;
  FavoriteManager.isRunning := True;
  try
    if FavoriteManager.SortColumn = Column then
      FavoriteManager.sortDirection := not FavoriteManager.sortDirection;
    FavoriteManager.SortColumn := Column;
    vtFavorites.Header.SortColumn := Column;
    vtFavorites.Header.SortDirection := TSortDirection(FavoriteManager.sortDirection);
    FavoriteManager.Sort(Column);
  finally
    UpdateVtFavorites;
    FavoriteManager.isRunning := False;
  end;
end;

procedure TMainForm.vtFavoritesInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PFavoriteInfo;
  pos: Cardinal;
begin
  with Sender do
  begin
    pos := Node^.Index;
    Data := GetNodeData(Node);
    Data^.numbering := IntToStr(QWord(pos) + 1);
    Data^.Title := FavoriteManager.FavoriteItem(pos).FavoriteInfo.Title;
    Data^.currentChapter := FavoriteManager.FavoriteItem(pos).FavoriteInfo.currentChapter;
    Data^.website := FavoriteManager.FavoriteItem(pos).FavoriteInfo.website;
    Data^.saveTo := FavoriteManager.FavoriteItem(pos).FavoriteInfo.saveTo;
    Data^.Link := FavoriteManager.FavoriteItem(pos).FavoriteInfo.Link;
  end;
  vtFavorites.ValidateNode(Node, False);
end;

procedure TMainForm.vtMangaListChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  //if (NOT isUpdating) then
  //begin
  if vtMangaList.SelectedCount > 0 then
    sbMain.Panels[0].Text := Format(RS_Selected, [vtMangaList.SelectedCount])
  else
    sbMain.Panels[0].Text := '';
  //end;
end;

procedure TMainForm.vtMangaListColumnDblClick(Sender: TBaseVirtualTree;
  Column: TColumnIndex; Shift: TShiftState);
begin
  miMangaListViewInfosClick(vtMangaList);
end;

procedure TMainForm.vtMangaListDragAllowed(Sender : TBaseVirtualTree;
  Node : PVirtualNode; Column : TColumnIndex; var Allowed : Boolean);
begin
  Allowed := False;
end;

procedure TMainForm.vtMangaListDragOver(Sender : TBaseVirtualTree;
  Source : TObject; Shift : TShiftState; State : TDragState; const Pt : TPoint;
  Mode : TDropMode; var Effect : LongWord; var Accept : Boolean);
begin
  Accept := False;
end;

// options

procedure TMainForm.btOptionApplyClick(Sender: TObject);
begin
  SaveOptions;
  ApplyOptions;
end;

procedure TMainForm.cbAddAsStoppedChange(Sender: TObject);
begin
  options.WriteBool('general', 'AddAsStopped', cbAddAsStopped.Checked);
end;

// vtMangaList

procedure TMainForm.vtMangaListBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
begin
  if (isExiting) or (dataProcess.RecordCount = 0) then
    Exit;
  if miHighlightNewManga.Checked then
  begin
    if Assigned(Node) then
      if StrToIntDef(dataProcess.Value[Node^.Index, DATA_PARAM_JDN], 0) > (currentJDN - OptionNewMangaTime) then
      begin
        TargetCanvas.Brush.Color := CL_HLBlueMarks;
        TargetCanvas.FillRect(CellRect);
      end;
  end;
end;

procedure TMainForm.vtMangaListGetCursor(Sender: TBaseVirtualTree;
  var ACursor: TCursor);
begin
  ACursor := Sender.Cursor;
end;

procedure TMainForm.vtMangaListGetHint(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
  var HintText: String);
var
  LPos: Integer;
  s: String;
begin
  s := '';
  LPos := Node^.Index;
  with dataProcess do
  begin
    if FilterAllSites then
      s := s + RS_InfoWebsite + LineEnding +
        dataProcess.WebsiteName[LPos] + LineEnding + LineEnding;
    if Trim(Value[LPos, DATA_PARAM_TITLE]) <> '' then
      s := s + RS_InfoTitle + LineEnding + Value[LPos, DATA_PARAM_TITLE];
    if Trim(Value[LPos, DATA_PARAM_AUTHORS]) <> '' then
      s := s + LineEnding + LineEnding + RS_InfoAuthors + LineEnding +
        Value[LPos, DATA_PARAM_AUTHORS];
    if Trim(Value[LPos, DATA_PARAM_ARTISTS]) <> '' then
      s := s + LineEnding + LineEnding + RS_InfoArtists + LineEnding +
        Value[LPos, DATA_PARAM_ARTISTS];
    if Trim(Value[LPos, DATA_PARAM_GENRES]) <> '' then
      s := s + LineEnding + LineEnding + RS_InfoGenres + LineEnding +
        Value[LPos, DATA_PARAM_GENRES];
    if Trim(Value[LPos, DATA_PARAM_STATUS]) <> '' then
    begin
      s := s + LineEnding + LineEnding + RS_InfoStatus + LineEnding;
      if Value[LPos, DATA_PARAM_STATUS] = '0' then
        s := s + cbFilterStatus.Items[0]
      else
        s := s + cbFilterStatus.Items[1];
    end;
    if Trim(Value[LPos, DATA_PARAM_SUMMARY]) <> '' then
      s := s + LineEnding + LineEnding + RS_InfoSummary + LineEnding +
        StringBreaks(dataProcess.Value[LPos, DATA_PARAM_SUMMARY]);
  end;
  HintText := s;
end;

procedure TMainForm.vtMangaListGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
begin
  if Assigned(Node) then
    CellText :=  Format('%s (%s)', [dataProcess.Value[Node^.Index, DATA_PARAM_TITLE],
      dataProcess.Value[Node^.Index, DATA_PARAM_NUMCHAPTER]]);
end;

procedure TMainForm.InitCheckboxes;
var
  i: Cardinal;
begin
  for i := 0 to 37 do
    TCheckBox(pnGenres.Controls[i]).State := cbGrayed;
end;

procedure TMainForm.ShowTasks(Status: TDownloadStatusTypes);
var
  i: Cardinal;
  xNode: PVirtualNode;
  canExit: Boolean = False;
begin
  if vtDownload.RootNodeCount = 0 then
    Exit;
  xNode := vtDownload.GetLast;
  for i := vtDownload.RootNodeCount - 1 downto 0 do
  begin
    if Status = [] then
      vtDownload.isVisible[xNode] := True
    else
      vtDownload.IsVisible[xNode] := DLManager.TaskItem(i).Status in Status;
    if canExit then
      Exit;
    if xNode = vtDownload.GetFirst then
      canExit := True;
    xNode := vtDownload.GetPrevious(xNode);
    if xNode = vtDownload.GetFirst then
      canExit := True;
  end;
end;

procedure TMainForm.ShowTasksOnCertainDays(const L, H: longint);
var
  i: Cardinal;
  jdn: longint;
  xNode: PVirtualNode;
  canExit: Boolean = False;
  dt: TDateTime;
  day, month, year: Word;
begin
  if vtDownload.RootNodeCount = 0 then
    Exit;
  if vtDownload.RootNodeCount <> DLManager.Count then
    vtDownload.RootNodeCount := DLManager.Count;
  xNode := vtDownload.GetLast;
  for i := DLManager.Count-1 downto 0 do
  begin
    if i < DLManager.Count then
    begin
      dt := DLManager.TaskItem(i).DownloadInfo.dateTime;
      DecodeDate(dt, year, month, day);
      jdn := DateToJDN(year, month, day);

      if (jdn >= L) and (jdn <= H) then
        vtDownload.isVisible[xNode] := True
      else
        vtDownload.isVisible[xNode] := False;

      if canExit then
        Exit;
      if xNode = vtDownload.GetFirst then
        canExit := True;
      xNode := vtDownload.GetPrevious(xNode);
      if xNode = vtDownload.GetFirst then
        canExit := True;
    end;
  end;
end;

procedure TMainForm.ShowTodayTasks;
begin
  ShowTasksOnCertainDays(GetCurrentJDN, GetCurrentJDN);
end;

procedure TMainForm.ShowYesterdayTasks;
begin
  ShowTasksOnCertainDays(GetCurrentJDN - 1, GetCurrentJDN - 1);
end;

procedure TMainForm.ShowOneWeekTasks;
begin
  ShowTasksOnCertainDays(GetCurrentJDN - 7, GetCurrentJDN);
end;

procedure TMainForm.ShowOneMonthTasks;
begin
  ShowTasksOnCertainDays(GetCurrentJDN - 30, GetCurrentJDN);
end;

procedure TMainForm.vtDownloadFilters;
begin
  if (isRunDownloadFilter) or
    (not Assigned(tvDownloadFilter.Selected)) then
    Exit;
  isRunDownloadFilter := True;
  case tvDownloadFilter.Selected.AbsoluteIndex of
    0, 5: ShowTasks;
    1: ShowTasks([STATUS_FINISH]);
    2: ShowTasks([STATUS_WAIT, STATUS_PREPARE, STATUS_DOWNLOAD, STATUS_COMPRESS]);
    3: ShowTasks([STATUS_STOP]);
    4: ShowTasks([STATUS_PROBLEM, STATUS_FAILED]);
    6: ShowTodayTasks;
    7: ShowYesterdayTasks;
    8: ShowOneWeekTasks;
    9: ShowOneMonthTasks;
  end;
  tvDownloadFilterRepaint;
  isRunDownloadFilter := False;
end;

procedure TMainForm.AddChapterNameToList;
begin
  UpdateVtChapter;
end;

procedure TMainForm.AddSilentThread(URL: string);
var
  i, j, m: Integer;
  host, link, webs: String;
  URls: TStringList;
  mt: TMetaDataType;
begin
  if Trim(URL) = '' then Exit;
  URLs := TStringList.Create;
  try
    URls.Text := URL;
    if URls.Count > 0 then
    begin
      SilentThreadManager.BeginAdd;
      with TRegExpr.Create do
      try
        Expression := REGEX_HOST;
        for i := 0 to URls.Count - 1 do
        begin
          host := '';
          link := '';
          webs := '';
          host := LowerCase(Replace(URls[i], '$2', True));
          link := Replace(URls[i], '$4', True);
          if (host <> '') and (link <> '') then
          begin
            m := Modules.LocateModuleByHost(host);
            if m > -1 then
              webs := Modules.Module[m].Website;
            if webs = '' then
            begin
              for j := Low(WebsiteRoots) to High(WebsiteRoots) do
                if Pos(host, LowerCase(WebsiteRoots[j, 1])) <> 0 then
                  webs := WebsiteRoots[j, 0];
            end;
            if webs <> '' then
            begin
              if rgDropTargetMode.ItemIndex = 0 then
                mt := MD_DownloadAll
              else
                mt := MD_AddToFavorites;
              if not ((mt = MD_AddToFavorites) and SitesWithoutFavorites(webs)) then
                SilentThreadManager.Add(mt, webs, '', link);
            end;
          end;
        end;
      finally
        Free;
      end;
      SilentThreadManager.EndAdd;
    end;
  finally
    URls.Free;
  end;
end;

procedure TMainForm.AddTextToInfo(title, infoText: String);
var
  fp: TFontParams;
  cp, np: Integer;
  fn: String;
begin
  infoText := Trim(infoText);
  if infoText <> '' then
    with rmInformation do
    begin
      if Trim(Lines.Text) <> '' then
        Lines.Add('');
      SelStart := UTF8Length(Lines.Text);
      cp := SelStart;
      GetTextAttributes(cp, fp);
      fn := rmInformation.Font.Name;
      fp.Style := [fsBold, fsUnderline];
      fp.Name := fn;
      Inc(fp.Size);
      Lines.Add(title);
      SelStart := UTF8Length(Lines.Text);
      np := SelStart;
      SetTextAttributes(cp, np - cp, fp);
      if title = RS_InfoSummary then
        infoText := Trim(StringBreaks(infoText));
      Lines.Add(infoText);
      fp.Style := [];
      fp.Name := fn;
      Dec(fp.Size);
      SetTextAttributes(np, UTF8Length(Lines.Text) - np, fp);
    end;
end;

procedure TMainForm.ShowInformation(const title, website, link: String);
var
  i: Integer;
begin
  pcMain.ActivePage := tsInformation;
  if Trim(edSaveTo.Text) = '' then
    edSaveTo.Text := options.ReadString('saveto', 'SaveTo', DEFAULT_PATH);
  if Trim(edSaveTo.Text) = '' then
    edSaveTo.Text := DEFAULT_PATH;
  edSaveTo.Text := CorrectPathSys(edSaveTo.Text);

  with rmInformation do
  begin
    imCover.Picture.Assign(nil);
    Clear;

    if (GetInfosThread <> nil) and
      ((GetInfosThread.MangaListPos > -1) or (GetInfosThread.MangaListPos = -2)) then
    begin
      mangaInfo.title := title;
      mangaInfo.link := link;
    end
    else
      edURL.Text := mangaInfo.url;

    AddTextToInfo(RS_InfoTitle, mangaInfo.title + LineEnding);
    AddTextToInfo(RS_InfoAuthors, mangaInfo.authors + LineEnding);
    AddTextToInfo(RS_InfoArtists, mangaInfo.artists + LineEnding);
    AddTextToInfo(RS_InfoGenres, mangaInfo.genres + LineEnding);
    i := StrToIntDef(mangaInfo.status, -1);
    if (i > -1) and (i < cbFilterStatus.Items.Count) then
      AddTextToInfo(RS_InfoStatus, cbFilterStatus.Items[i]);
    AddTextToInfo(RS_InfoSummary, mangaInfo.summary);
    CaretPos := Point(0, 0);
  end;
  SetLength(ChapterList, mangaInfo.chapterName.Count);
  for i := 0 to mangaInfo.chapterName.Count - 1 do
  begin
    ChapterList[i].Title := mangaInfo.chapterName[i];
    ChapterList[i].Link := mangaInfo.chapterLinks[i];
    ChapterList[i].Downloaded := False;
  end;
  if miChapterListHighlight.Checked then
    DLManager.GetDownloadedChaptersState(mangaInfo.website + mangaInfo.link,
      ChapterList)
  else
    ClearChapterListState;
  UpdateVtChapter;

  btDownload.Enabled := (clbChapterList.RootNodeCount > 0);
  btReadOnline.Enabled := (mangaInfo.link <> '');
  btAddToFavorites.Enabled := not SitesWithoutFavorites(website);

  //check if manga already in FavoriteManager list
  if btAddToFavorites.Enabled and (FavoriteManager.Count > 0) then
    btAddToFavorites.Enabled := not FavoriteManager.IsMangaExist(mangaInfo.title, website);
end;

procedure TMainForm.RunGetList;
begin
  if (MessageDlg('', RS_DlgUpdaterWantToUpdateDB, mtInformation, [mbYes, mbNo], 0) =
    mrYes) and
    (not isUpdating) then
  begin
    isUpdating := True;
    updateDB := TUpdateDBThread.Create;
    updateDB.websiteName := cbSelectManga.Items[cbSelectManga.ItemIndex];
    updateDB.Start;
  end;
end;

procedure TMainForm.LoadOptions;
var
  l: TStringList;
  i, j: Integer;
  s: String;
  data: PSingleItem;
begin
  with options do begin
    // general
    cbOptionOneInstanceOnly.Checked := ReadBool('general', 'OneInstanceOnly', True);
    cbOptionLiveSearch.Checked := ReadBool('general', 'LiveSearch', True);
    cbOptionMinimizeToTray.Checked := ReadBool('general', 'MinimizeToTray', False);
    cbOptionLetFMDDo.ItemIndex := ReadInteger('general', 'LetFMDDo', 0);
    cbOptionAutoNumberChapter.Checked := ReadBool('general', 'AutoNumberChapter', True);
    edOptionExternalPath.FileName := ReadString('general', 'ExternalProgramPath', '');
    edOptionExternalParams.Text := ReadString('general', 'ExternalProgramParams', DEFAULT_EXPARAM);
    cbAddAsStopped.Checked := ReadBool('general', 'AddAsStopped', False);
    miHighLightNewManga.Checked := ReadBool('general', 'HighlightNewManga', True);
    miChapterListHighlight.Checked := ReadBool('general', 'HighlightDownloadedChapters', True);

    // view
    cbOptionShowDownloadToolbar.Checked := ReadBool('view', 'ShowDownloadsToolbar', True);
    cbOptionEnableLoadCover.Checked := ReadBool('view', 'LoadMangaCover', True);
    ckDropTarget.Checked := ReadBool('droptarget', 'Show', False);
    frmDropTarget.FWidth := ReadInteger('droptarget', 'Width', frmDropTarget.FWidth);
    frmDropTarget.FHeight := ReadInteger('droptarget', 'Heigth', frmDropTarget.FHeight);
    frmDropTarget.FTop := ReadInteger('droptarget', 'Top', frmDropTarget.FTop);
    frmDropTarget.FLeft := ReadInteger('droptarget', 'Left', frmDropTarget.FLeft);
    rgDropTargetMode.ItemIndex := ReadInteger('droptarget', 'Mode', 0);
    tbDropTargetOpacity.Position := ReadInteger('droptarget', 'Opacity', 255);

    // connection
    seOptionMaxParallel.Value := ReadInteger('connections', 'NumberOfTasks', 1);
    seOptionMaxThread.Value := ReadInteger('connections', 'NumberOfThreadsPerTask', 1);
    seOptionMaxRetry.Value := ReadInteger('connections', 'Retry', 3);;
    seOptionConnectionTimeout.Value := ReadInteger('connections', 'ConnectionTimeout', 15);
    cbOptionUseProxy.Checked := ReadBool('connections', 'UseProxy', False);
    cbOptionProxyType.Text := ReadString('connections', 'ProxyType', 'HTTP');
    edOptionHost.Text := ReadString('connections', 'Host', '');
    edOptionPass.Text := ReadString('connections', 'Pass', '');
    edOptionPort.Text := ReadString('connections', 'Port', '');
    edOptionUser.Text := ReadString('connections', 'User', '');

    // saveto
    edOptionDefaultPath.Text := ReadString('saveto', 'SaveTo', DEFAULT_PATH);
    if Trim(edOptionDefaultPath.Text) = '' then
      edOptionDefaultPath.Text := DEFAULT_PATH;
    rgOptionCompress.ItemIndex := ReadInteger('saveto', 'Compress', 0);
    cbOptionPathConvert.Checked := ReadBool('saveto', 'PathConvert', False);
    cbOptionRemoveMangaNameFromChapter.Checked := ReadBool('saveto', 'RemoveMangaNameFromChapter', True);
    cbOptionGenerateChapterName.Checked := ReadBool('saveto', 'GenerateChapterName', False);
    cbOptionGenerateMangaFolderName.Checked := ReadBool('saveto', 'GenerateMangaName', True);
    cbOptionAutoNumberChapter.Checked := ReadBool('saveto', 'AutoNumberChapter', True);
    seOptionPDFQuality.Value := ReadInteger('saveto', 'PDFQuality', 100);
    edOptionCustomRename.Text := ReadString('saveto', 'CustomRename', DEFAULT_CUSTOM_RENAME);
    if Trim(edOptionCustomRename.Text) = '' then
      edOptionCustomRename.Text := DEFAULT_CUSTOM_RENAME;
    cbOptionDigitVolume.Checked := ReadBool('saveto', 'ConvertDigitVolume', True);
    seOptionDigitVolume.Value := ReadInteger('saveto', 'DigitVolumeLength', 2);
    seOptionDigitVolume.Enabled := cbOptionDigitVolume.Checked;
    cbOptionDigitChapter.Checked := ReadBool('saveto', 'ConvertDigitChapter', True);
    seOptionDigitChapter.Value := ReadInteger('saveto', 'DigitChapterLength', 3);
    seOptionDigitChapter.Enabled := cbOptionDigitChapter.Checked;

    // update
    cbOptionAutoCheckLatestVersion.Checked := ReadBool('update', 'AutoCheckLatestVersion', True);
    cbOptionAutoCheckFavStartup.Checked := ReadBool('update', 'AutoCheckFavStartup', True);
    cbOptionAutoCheckFavInterval.Checked := ReadBool('update', 'AutoCheckFavInterval', True);
    seOptionAutoCheckFavIntervalMinutes.Value := ReadInteger('update', 'AutoCheckFavIntervalMinutes', 60);
    lbOptionAutoCheckFavIntervalMinutes.Caption := Format(RS_LblAutoCheckNewChapterMinute, [seOptionAutoCheckFavIntervalMinutes.Value]);
    cbOptionAutoCheckFavIntervalChange(cbOptionAutoCheckFavInterval);
    seOptionNewMangaTime.Value := ReadInteger('update', 'NewMangaTime', 1);
    cbOptionAutoCheckFavDownload.Checked := ReadBool('update', 'AutoCheckFavAutoDownload', False);
    cbOptionAutoCheckFavRemoveCompletedManga.Checked := ReadBool('update', 'AutoCheckFavAutoRemoveCompletedManga', False);
    cbOptionUpdateListNoMangaInfo.Checked := ReadBool('update', 'UpdateListNoMangaInfo', False);
    cbOptionUpdateListRemoveDuplicateLocalData.Checked := ReadBool('update', 'UpdateListRemoveDuplicateLocalData', False);

    // dialogs
    cbOptionShowQuitDialog.Checked := ReadBool('dialogs', 'ShowQuitDialog', True);
    cbOptionShowDeleteTaskDialog.Checked := ReadBool('dialogs', 'ShowDeleteDldTaskDialog', True);

    // misc
    cbOptionBatotoShowScanGroup.Checked := ReadBool('misc', 'BatotoShowScanGroup', True);
    cbOptionBatotoShowAllLang.Checked := ReadBool('misc', 'BatotoShowAllLang', False);
    cbOptionMangaFoxRemoveWatermarks.Checked := ReadBool('misc', 'MangafoxRemoveWatermarks', False);

    // websites
    if Length(optionMangaSiteSelectionNodes) > 0 then
      for i := 0 to Length(optionMangaSiteSelectionNodes) - 1 do
        optionMangaSiteSelectionNodes[i]^.CheckState := csUncheckedNormal;
    l := TStringList.Create;
    try
      s := options.ReadString('general', 'MangaListSelect',
        mangalistIni.ReadString('general', 'DefaultSelect', DEFAULT_LIST));
      if Pos(SEPERATOR, s) > 0 then
        GetParams(l, s)    //for old config
      else
        ExtractStrings([','], [], PChar(s), l);
      if (l.Count > 0) and (Length(optionMangaSiteSelectionNodes) > 0) then
        for i := 0 to l.Count - 1 do
          for j := 0 to Length(optionMangaSiteSelectionNodes) - 1 do
          begin
            data := vtOptionMangaSiteSelection.GetNodeData(
              optionMangaSiteSelectionNodes[j]);
            if SameText(l[i], data^.Text) then
            begin
              optionMangaSiteSelectionNodes[j]^.CheckState := csCheckedNormal;
              Break;
            end;
          end;
    finally
      l.Free;
    end;
  end;
end;

procedure TMainForm.SaveOptions;
var
  s: String;
begin
  if Length(optionMangaSiteSelectionNodes) > 0 then
  begin
    s := SaveMangaOptions;
    if s = '' then
    begin
      MessageDlg('', RS_DlgMangaListSelect,
        mtConfirmation, [mbYes], 0);
      Exit;
    end;
  end;

  with options do
    try
      // general
      WriteString('general', 'MangaListSelect', s);
      WriteBool('general', 'LiveSearch', cbOptionLiveSearch.Checked);
      WriteBool('general', 'OneInstanceOnly', cbOptionOneInstanceOnly.Checked);
      if cbLanguages.ItemIndex > -1 then
        WriteString('languages', 'Selected', AvailableLanguages.Names[cbLanguages.ItemIndex]);
      WriteBool('general', 'MinimizeToTray', cbOptionMinimizeToTray.Checked);
      WriteInteger('general', 'LetFMDDo', cbOptionLetFMDDo.ItemIndex);
      WriteString('general', 'ExternalProgramPath', edOptionExternalPath.FileName);
      WriteString('general', 'ExternalProgramParams', edOptionExternalParams.Text);
      WriteBool('general', 'AddAsStopped', cbAddAsStopped.Checked);
      WriteBool('general', 'HighlightNewManga', miHighlightNewManga.Checked);
      WriteBool('general', 'HighlightDownloadedChapters', miChapterListHighlight.Checked);

      // view
      WriteBool('view', 'ShowDownloadsToolbar', cbOptionShowDownloadToolbar.Checked);
      WriteBool('view', 'LoadMangaCover', cbOptionEnableLoadCover.Checked);
      SaveDropTargetFormInformation;

      // connections
      WriteInteger('connections', 'NumberOfTasks', seOptionMaxParallel.Value);
      WriteInteger('connections', 'NumberOfThreadsPerTask', seOptionMaxThread.Value);
      WriteInteger('connections', 'Retry', seOptionMaxRetry.Value);
      WriteInteger('connections', 'ConnectionTimeout', seOptionConnectionTimeout.Value);
      WriteBool('connections', 'UseProxy', cbOptionUseProxy.Checked);
      WriteString('connections', 'ProxyType', cbOptionProxyType.Text);
      WriteString('connections', 'Host', edOptionHost.Text);
      WriteString('connections', 'Pass', edOptionPass.Text);
      WriteString('connections', 'Port', edOptionPort.Text);
      WriteString('connections', 'User', edOptionUser.Text);

      // saveto
      if Trim(edOptionDefaultPath.Text) = '' then
        edOptionDefaultPath.Text := DEFAULT_PATH;
      edOptionDefaultPath.Text := CorrectPathSys(edOptionDefaultPath.Text);
      WriteString('saveto', 'SaveTo', edOptionDefaultPath.Text);
      WriteBool('saveto', 'PathConvert', cbOptionPathConvert.Checked);
      WriteBool('saveto', 'GenerateChapterName', cbOptionGenerateChapterName.Checked);
      WriteBool('saveto', 'GenerateMangaName', cbOptionGenerateMangaFolderName.Checked);
      WriteInteger('saveto', 'Compress', rgOptionCompress.ItemIndex);
      WriteBool('saveto', 'AutoNumberChapter', cbOptionAutoNumberChapter.Checked);
      OptionAutoNumberChapterChecked := cbOptionAutoNumberChapter.Checked;
      WriteInteger('saveto', 'PDFQuality', seOptionPDFQuality.Value);
      WriteBool('saveto', 'RemoveMangaNameFromChapter', cbOptionRemoveMangaNameFromChapter.Checked);
      if Trim(edOptionCustomRename.Text) = '' then
        edOptionCustomRename.Text := DEFAULT_CUSTOM_RENAME;
      WriteString('saveto', 'CustomRename', edOptionCustomRename.Text);
      WriteBool('saveto', 'ConvertDigitVolume', cbOptionDigitVolume.Checked);
      WriteBool('saveto', 'ConvertDigitChapter', cbOptionDigitChapter.Checked);
      WriteInteger('saveto', 'DigitVolumeLength', seOptionDigitVolume.Value);
      WriteInteger('saveto', 'DigitChapterLength', seOptionDigitChapter.Value);

      // update
      WriteBool('update', 'AutoCheckLatestVersion', cbOptionAutoCheckLatestVersion.Checked);
      WriteBool('update', 'AutoCheckFavStartup', cbOptionAutoCheckFavStartup.Checked);
      WriteBool('update', 'AutoCheckFavInterval', cbOptionAutoCheckFavInterval.Checked);
      WriteInteger('update', 'AutoCheckFavIntervalMinutes', seOptionAutoCheckFavIntervalMinutes.Value);
      WriteInteger('update', 'NewMangaTime', seOptionNewMangaTime.Value);
      WriteBool('update', 'AutoCheckFavAutoDownload', cbOptionAutoCheckFavDownload.Checked);
      WriteBool('update', 'AutoCheckFavAutoRemoveCompletedManga', cbOptionAutoCheckFavRemoveCompletedManga.Checked);
      WriteBool('update', 'UpdateListNoMangaInfo', cbOptionUpdateListNoMangaInfo.Checked);
      WriteBool('update', 'UpdateListRemoveDuplicateLocalData', cbOptionUpdateListRemoveDuplicateLocalData.Checked);

      // dialogs
      WriteBool('dialogs', 'ShowQuitDialog', cbOptionShowQuitDialog.Checked);
      WriteBool('dialogs', 'ShowDeleteDldTaskDialog', cbOptionShowDeleteTaskDialog.Checked);

      // misc
      WriteBool('misc', 'BatotoShowScanGroup', cbOptionBatotoShowScanGroup.Checked);
      WriteBool('misc', 'BatotoShowAllLang', cbOptionBatotoShowAllLang.Checked);
      WriteBool('misc', 'MangafoxRemoveWatermarks', cbOptionMangaFoxRemoveWatermarks.Checked);
    finally
      UpdateFile;
    end;
end;

procedure TMainForm.ApplyOptions;
var
  i: Integer;
  isStillHaveCurrentWebsite: Boolean = False;
  data: PSingleItem;
begin
  try
    // general
    cbSelectManga.Clear;
    for i := 0 to Length(optionMangaSiteSelectionNodes) - 1 do
    begin
      data := vtOptionMangaSiteSelection.GetNodeData(optionMangaSiteSelectionNodes[i]);
      if (optionMangaSiteSelectionNodes[i]^.CheckState = csCheckedNormal) and
        (Data^.Text <> '') then
        cbSelectManga.Items.Add(data^.Text);
    end;
    for i := 0 to cbSelectManga.Items.Count - 1 do
    begin
      if cbSelectManga.Items[i] = currentWebsite then
      begin
        cbSelectManga.ItemIndex := i;
        isStillHaveCurrentWebsite := True;
        Break;
      end;
    end;
    if not isStillHaveCurrentWebsite then
    begin
      if cbSelectManga.Items.Count > 0 then
      begin
        cbSelectManga.ItemIndex := 0;
        cbSelectMangaChange(cbSelectManga);
      end
      else
      begin
        cbSelectManga.ItemIndex := -1;
        cbSelectManga.Text := '';
        currentWebsite := '';
        vtMangaList.Clear;
        lbMode.Caption := Format(RS_ModeAll, [0]);
      end;
    end;
    //FMDInstace
    if cbOptionOneInstanceOnly.Checked then
    begin
      if FMDInstance = nil then
      begin
        FMDInstance := TSimpleIPCServer.Create(Self);
        FMDInstance.ServerID := FMD_INSTANCE;
        FMDInstance.Global := True;
        FMDInstance.OnMessage := @FMDInstanceReceiveMsg;
        FMDInstance.StartServer;
      end;
    end
    else
    begin
      if FMDInstance <> nil then
      begin
        FMDInstance.StopServer;
        FreeAndNil(FMDInstance);
      end;
    end;
    OptionLetFMDDo := TFMDDo(cbOptionLetFMDDo.ItemIndex);
    OptionEnableLoadCover := cbOptionEnableLoadCover.Checked;
    OptionAutoNumberChapterChecked := cbOptionAutoNumberChapter.Checked;

    //view
    ToolBarDownload.Visible := cbOptionShowDownloadToolbar.Checked;
    if ckDropTarget.Checked then
    begin
      if FormDropTarget = nil then
        Application.CreateForm(TFormDropTarget, FormDropTarget);
      frmDropTarget.OnDropChekout := @AddSilentThread;
      frmDropTarget.FAlphaBlendValue := tbDropTargetOpacity.Position;
      FormDropTarget.Show;
    end
    else
    begin
      if Assigned(FormDropTarget) then
        FormDropTarget.Close;
    end;

    //connection
    OptionConnectionTimeout := seOptionConnectionTimeout.Value * 1000;
    OptionConnectionMaxRetry := seOptionMaxRetry.Value;
    OptionMaxThreads := seOptionMaxThread.Value;
    DLManager.maxDLTasks := seOptionMaxParallel.Value;
    DLManager.maxDLThreadsPerTask := seOptionMaxThread.Value;
    DLManager.retryConnect := OptionConnectionMaxRetry;
    if cbOptionUseProxy.Checked then
    begin
      OptionProxyType := cbOptionProxyType.Text;
      OptionProxyHost := edOptionHost.Text;
      OptionProxyPass := edOptionPass.Text;
      OptionProxyPort := edOptionPort.Text;
      OptionProxyUser := edOptionUser.Text;
    end
    else
    begin
      OptionProxyType := '';
      OptionProxyHost := '';
      OptionProxyPass := '';
      OptionProxyPort := '';
      OptionProxyUser := '';
    end;

    //saveto
    OptionPDFQuality := seOptionPDFQuality.Value;
    OptionCustomRename := edOptionCustomRename.Text;
    DLManager.compress := rgOptionCompress.ItemIndex;
    OptionRemoveMangaNameFromChapter := cbOptionRemoveMangaNameFromChapter.Checked;

    //update
    OptionAutoCheckLatestVersion := cbOptionAutoCheckLatestVersion.Checked;
    OptionAutoCheckFavStartup := cbOptionAutoCheckFavStartup.Checked;
    OptionAutoCheckFavInterval := cbOptionAutoCheckFavInterval.Checked;
    OptionAutoCheckFavIntervalMinutes := seOptionAutoCheckFavIntervalMinutes.Value;
    OptionNewMangaTime := seOptionNewMangaTime.Value;
    OptionAutoCheckFavDownload := cbOptionAutoCheckFavDownload.Checked;
    OptionAutoCheckFavRemoveCompletedManga := cbOptionAutoCheckFavRemoveCompletedManga.Checked;
    OptionUpdateListNoMangaInfo := cbOptionUpdateListNoMangaInfo.Checked;
    OptionUpdateListRemoveDuplicateLocalData := cbOptionUpdateListRemoveDuplicateLocalData.Checked;
    itCheckFav.Interval := OptionAutoCheckFavIntervalMinutes * 60000;
    itCheckFav.Enabled := OptionAutoCheckFavInterval;

    //misc
    OptionBatotoShowScanGroup := cbOptionBatotoShowScanGroup.Checked;
    OptionBatotoShowAllLang := cbOptionBatotoShowAllLang.Checked;

    //languages
    ApplyLanguage;
  except
    on E: Exception do
      ExceptionHandle(Self, E);
  end;
  if isStartup then
    DLManager.CheckAndActiveTask;
end;

procedure TMainForm.LoadMangaOptions;
var
  isDeleteUnusedManga: Boolean;
  i, j, sel: Integer;
  lang: TStringList;
  s, currentLanguage: String;
  ANode, currentRootNode: PVirtualNode;
  data: PSingleItem;
  wName, wLang: TStringList;
begin
  wName := TStringList.Create;
  wLang := TStringList.Create;
  lang := TStringList.Create;
  try
    mangalistIni.ReadSection('available', lang);
    TrimStrings(lang);
    if lang.Count > 0 then
      for i := 0 to lang.Count - 1 do
      begin
        s := Trim(mangalistIni.ReadString('available', lang[i], ''));
        if s <> '' then
          ExtractStrings([','], [], PChar(s), wName);
        TrimStrings(wName);
        while wlang.Count < wName.Count do
          wLang.Add(lang[i]);
      end;

    // load to option list
    if wName.Count > 0 then
    begin
      SetLength(optionMangaSiteSelectionNodes, wName.Count);
      currentLanguage := '';
      for i := 0 to wName.Count - 1 do
        with vtOptionMangaSiteSelection do
        begin
          if currentLanguage <> wLang[i] then
          begin
            currentLanguage := wLang[i];
            currentRootNode := AddChild(nil);
            data := GetNodeData(currentRootNode);
            data^.Text := currentLanguage;
            ValidateNode(currentRootNode, False);
          end;
          ANode := AddChild(currentRootNode);
          ANode^.CheckState := csUncheckedNormal;
          data := GetNodeData(ANode);
          data^.Text := wName[i];
          ValidateNode(ANode, False);
          optionMangaSiteSelectionNodes[i] := ANode;
        end;
    end;

    // load selected manga list
    lang.Clear;
    s := options.ReadString('general', 'MangaListSelect', DEFAULT_LIST);
    if Pos(SEPERATOR, s) <> 0 then
      ExtractParam(lang, s, SEPERATOR, False)
    else
      ExtractParam(lang, s, ',', False);
    cbSelectManga.Items.Assign(lang);

    // remove unused manga name
    i := 0;
    if (lang.Count > 0) and (Length(optionMangaSiteSelectionNodes) > 0) then
      while i < lang.Count do
      begin
        isDeleteUnusedManga := True;
        for j := 0 to Length(optionMangaSiteSelectionNodes) - 1 do
        begin
          Data := vtOptionMangaSiteSelection.GetNodeData(
            optionMangaSiteSelectionNodes[j]);
          if lang[i] = Data^.Text then
          begin
            isDeleteUnusedManga := False;
            Break;
          end;
        end;
        if isDeleteUnusedManga then
          lang.Delete(i)
        else
          Inc(i);
      end;

    // load last selected manga
    if cbSelectManga.Items.Count > 0 then
    begin
      sel := options.ReadInteger('form', 'SelectManga', 0);
      if sel < 0 then
        sel := 0;
      if sel > cbSelectManga.Items.Count - 1 then
        sel := cbSelectManga.Items.Count - 1;
      cbSelectManga.ItemIndex := sel;
      currentWebsite := cbSelectManga.Items[cbSelectManga.ItemIndex];
    end;
  finally
    lang.Free;
    wName.Free;
    wLang.Free;
  end;
end;

function TMainForm.SaveMangaOptions: String;
var
  i: Integer;
  data: PSingleItem;
begin
  Result := '';
  if Length(optionMangaSiteSelectionNodes) > 0 then
    for i := Low(optionMangaSiteSelectionNodes) to High(optionMangaSiteSelectionNodes) do
    begin
      data := vtOptionMangaSiteSelection.GetNodeData(optionMangaSiteSelectionNodes[i]);
      if optionMangaSiteSelectionNodes[i]^.CheckState = csCheckedNormal then
      begin
        if Result = '' then
          Result := data^.Text
        else
          Result := Result + ',' + data^.Text;
      end;
    end;
end;

procedure TMainForm.edSearchChange(Sender: TObject);
begin
  if edSearch.Tag = -1 then
  begin
    edSearch.Tag := 0;
    LastSearchWeb := currentWebsite;
    LastSearchStr := UpCase(edSearch.Text);
    Exit;
  end;
  if (not cbOptionLiveSearch.Checked) and (edSearch.Tag = 0) then Exit;
  if edSearch.Tag <> 0 then
    edSearch.Tag := 0;
  if (upcase(edSearch.Text) = LastSearchStr) and (currentWebsite = LastSearchWeb) then
    Exit;

  SearchDataDB(edSearch.Text);

  //vtMangaList.Clear;
  //dataProcess.Search(edSearch.Text);
  //vtMangaList.RootNodeCount := dataProcess.RecordCount;
  //if dataProcess.Filtered then
  //  lbMode.Caption := Format(RS_ModeFiltered, [vtMangaList.RootNodeCount])
  //else
  //  lbMode.Caption := Format(RS_ModeAll, [vtMangaList.RootNodeCount]);
end;

procedure TMainForm.edSearchKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    edSearch.Tag := 1;
    edSearchChange(edSearch);
  end
  else
  if edSearch.Tag <> 0 then
    edSearch.Tag := 0;
end;

procedure TMainForm.UpdateVtChapter;
begin
  clbChapterList.Clear;
  clbChapterList.RootNodeCount := Length(ChapterList);
end;

procedure TMainForm.UpdateVtDownload;
begin
  if vtDownload.RootNodeCount <> DLManager.Count then
    vtDownload.RootNodeCount := DLManager.Count;
  // the reason we put vtDownloadFilters in here instead of in DLManager because
  // the size of download list can change while this method is running
  vtDownloadFilters;
  vtDownload.Repaint;
end;

procedure TMainForm.UpdateVtFavorites;
begin
  vtFavorites.Clear;
  vtFavorites.RootNodeCount := FavoriteManager.Count;
end;

procedure TMainForm.LoadFormInformation;
var
  i: Integer;
begin
  with options do
  begin
    pcLeft.Width := ReadInteger('form', 'MainSplitter', 195);
    sbMain.Panels[0].Width := pcLeft.Width + 4;

    pcMain.PageIndex := ReadInteger('form', 'pcMainPageIndex', 0);

    Left := ReadInteger('form', 'MainFormLeft', MainForm.Left);
    Top := ReadInteger('form', 'MainFormTop', MainForm.Top);
    Width := ReadInteger('form', 'MainFormWidth', 640);
    Height := ReadInteger('form', 'MainFormHeight', 480);

    if ReadBool('form', 'MainFormMaximized', False) then
      PrevWindowState := wsMaximized
    else
      PrevWindowState := wsNormal;
    WindowState := PrevWindowState;

    if vtDownload.Header.Columns.Count > 0 then
     with vtDownload.Header.Columns do
      for i := 0 to Count - 1 do
        Items[i].Width := ReadInteger('form', 'vtDownload' + IntToStr(i) + 'Width', 50);

    if vtFavorites.Header.Columns.Count > 0 then
     with vtFavorites.Header.Columns do
      for i := 0 to Count - 1 do
        Items[i].Width := ReadInteger('form', 'vtFavorites' + IntToStr(i) + 'Width', 50);

    FavoriteManager.sortDirection := ReadBool('misc', 'SortFavoritesDirection', False);
    vtFavorites.Header.SortColumn := ReadInteger('misc', 'SortFavoritesColumn', 1);
    vtFavorites.Header.SortDirection := TSortDirection(FavoriteManager.sortDirection);

    DLManager.SortDirection := ReadBool('misc', 'SortDownloadDirection', False);
    vtDownload.Header.SortColumn := ReadInteger('misc', 'SortDownloadColumn', 0);
    vtDownload.Header.SortDirection := TSortDirection(DLManager.SortDirection);
  end;
end;

procedure TMainForm.SaveFormInformation;
var
  i: Integer;
begin
  with options do
  begin
    WriteInteger('form', 'MainSplitter', pcLeft.Width);
    WriteInteger('form', 'pcMainPageIndex', pcMain.PageIndex);
    WriteInteger('form', 'SelectManga', cbSelectManga.ItemIndex);
    WriteBool('form', 'MainFormMaximized', (WindowState = wsMaximized));
    if WindowState = wsMaximized then
      WindowState := wsNormal;
    WriteInteger('form', 'MainFormLeft', Left);
    WriteInteger('form', 'MainFormTop', Top);
    WriteInteger('form', 'MainFormWidth', Width);
    WriteInteger('form', 'MainFormHeight', Height);

    if vtDownload.Header.Columns.Count > 0 then
     with vtDownload.Header.Columns do
      for i := 0 to Count - 1 do
        WriteInteger('form', 'vtDownload' + IntToStr(i) + 'Width', Items[i].Width);

    if vtFavorites.Header.Columns.Count > 0 then
     with vtFavorites.Header.Columns do
      for i := 0 to Count - 1 do
        WriteInteger('form', 'vtFavorites' + IntToStr(i) + 'Width', Items[i].Width);

    WriteInteger('misc', 'SortDownloadColumn', vtDownload.Header.SortColumn);
    WriteBool('misc', 'SortDownloadDirection', DLManager.SortDirection);

    WriteInteger('misc', 'SortFavoritesColumn', vtFavorites.Header.SortColumn);
    WriteBool('misc', 'SortFavoritesDirection', FavoriteManager.sortDirection);
  end;
end;

procedure TMainForm.SaveDropTargetFormInformation;
begin
  with options do
  begin
    WriteBool('droptarget', 'Show', ckDropTarget.Checked);
    WriteInteger('droptarget', 'Mode', rgDropTargetMode.ItemIndex);
    WriteInteger('droptarget', 'Opacity', frmDropTarget.FAlphaBlendValue);
    WriteInteger('droptarget', 'Width', frmDropTarget.FWidth);
    WriteInteger('droptarget', 'Heigth', frmDropTarget.FHeight);
    WriteInteger('droptarget', 'Top', frmDropTarget.FTop);
    WriteInteger('droptarget', 'Left', frmDropTarget.FLeft);
  end;
end;

procedure TMainForm.CollectLanguagesFromFiles;
var
  i: Integer;
begin
  cbLanguages.Items.Clear;
  uTranslation.LangDir := CleanAndExpandDirectory(GetCurrentDirUTF8) + 'languages';
  uTranslation.LangAppName := 'fmd';
  uTranslation.CollectLanguagesFiles;
  if uTranslation.AvailableLanguages.Count > 0 then
  begin
    for i := 0 to AvailableLanguages.Count - 1 do
      cbLanguages.Items.Add(uTranslation.AvailableLanguages.ValueFromIndex[i]);
    cbLanguages.ItemIndex := uTranslation.AvailableLanguages.IndexOfName(
    options.ReadString('languages', 'Selected', 'en'));
  end;
end;

procedure TMainForm.ApplyLanguage;
var
  idxLanguages,
  idxFilterStatus,
  idxOptionLetFMDDo,
  idxOptionProxyType,
  idxDropTargetMode: Integer;
begin
  if AvailableLanguages.Count = 0 then Exit;
  if uTranslation.LastSelected <> AvailableLanguages.Names[cbLanguages.ItemIndex] then
  begin
    idxLanguages := cbLanguages.ItemIndex;
    idxFilterStatus := cbFilterStatus.ItemIndex;
    idxOptionLetFMDDo := cbOptionLetFMDDo.ItemIndex;
    idxOptionProxyType := cbOptionProxyType.ItemIndex;
    idxDropTargetMode := rgDropTargetMode.ItemIndex;
    if uTranslation.SetLangByIndex(cbLanguages.ItemIndex) then
    begin
      lbOptionExternalParamsHint.Hint := Format(RS_LblOptionExternalParamsHint,
        [EXPARAM_PATH, EXPARAM_CHAPTER, EXPARAM_PATH, EXPARAM_CHAPTER]);

      cbFilterStatus.Items.Text := RS_FilterStatusItems;
      cbOptionLetFMDDo.Items.Text := RS_OptionFMDDoItems;
      rgDropTargetMode.Items.Text := RS_DropTargetModeItems;

      cbLanguages.ItemIndex := idxLanguages;
      cbFilterStatus.ItemIndex := idxFilterStatus;
      cbOptionLetFMDDo.ItemIndex := idxOptionLetFMDDo;
      cbOptionProxyType.ItemIndex := idxOptionProxyType;
      rgDropTargetMode.ItemIndex := idxDropTargetMode;
      Self.Repaint;
      vtMangaList.Repaint;
      tvDownloadFilterRepaint;
    end;
  end;
end;

procedure TMainForm.OpenWithExternalProgram(const dirPath, Filename: String);
var
  Exe, Params,
  p, f: String;
begin
  Exe := Trim(options.ReadString('general', 'ExternalProgramPath', ''));
  Params := Trim(options.ReadString('general', 'ExternalProgramParams', DEFAULT_EXPARAM));

  p := Trim(TrimRightChar(Trim(dirPath), [PathDelim]));
  f := Trim(TrimChar(Trim(Filename), [PathDelim]));

  if Exe <> '' then
  begin
    if (Pos(EXPARAM_PATH + EXPARAM_CHAPTER, Params) <> 0) then
      f := PathDelim + f;
    Params := StringReplace(Params, EXPARAM_PATH, p, [rfIgnoreCase, rfReplaceAll]);
    Params := StringReplace(Params, EXPARAM_CHAPTER, f, [rfIgnoreCase, rfReplaceAll]);
    RunExternalProcess(Exe, Params, True, False);
  end
  else
  begin
    if (p <> '') and (f <> '') then
      f := p + PathDelim + f;
    OpenDocument(f);
  end;
end;

procedure TMainForm.TransferRateGraphInit(xCount: Integer);
var
  i: Integer;
begin
  TransferRateGraphList.Clear;
  TransferRateGraphList.DataPoints.NameValueSeparator := '|';
  TransferRateGraphArea.Legend.Format := FormatByteSize(0, True);
  if xCount=0 then
    TransferRateGraphInit
  else
    for i:=1 to xCount do
      TransferRateGraphList.DataPoints.Add(IntToStr(i)+'|0|?|');
end;

procedure TMainForm.TransferRateGraphAddItem(TransferRate: Integer);
var
  i: Integer;
begin
  TransferRateGraphArea.Legend.Format := FormatByteSize(TransferRate, True);
  with TransferRateGraphList.DataPoints do
  begin
    if Count=0 then
      TransferRateGraphInit;
    for i := 0 to Count - 1 do
      if i < Count - 1 then
        Strings[i] := Format('%d|%s', [i+1, ValueFromIndex[i+1]]);
    Strings[Count-1] := Format('%d|%d|?|',[Count,TransferRate]);
  end;
end;

procedure TMainForm.ExceptionHandler(Sender: TObject; E: Exception);
begin
  USimpleException.ExceptionHandle(Sender, E);
end;

procedure TMainForm.tmBackupTimer(Sender: TObject);
begin
  if not DLManager.isRunningBackup then
    DLManager.Backup;
end;

procedure TMainForm.vtOptionMangaSiteSelectionChange(Sender : TBaseVirtualTree;
  Node : PVirtualNode);
begin
  vtOptionMangaSiteSelection.Refresh;
end;

procedure TMainForm.vtOptionMangaSiteSelectionFocusChanged(
  Sender : TBaseVirtualTree; Node : PVirtualNode; Column : TColumnIndex);
begin
  vtOptionMangaSiteSelection.Refresh;
end;

procedure TMainForm.vtOptionMangaSiteSelectionFreeNode(
  Sender : TBaseVirtualTree; Node : PVirtualNode);
var
  Data: PSingleItem;
begin
  Data := vtOptionMangaSiteSelection.GetNodeData(Node);
  if Assigned(Data) then
    Finalize(Data^);
end;

procedure TMainForm.vtOptionMangaSiteSelectionGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TMangaListItem);
end;

procedure TMainForm.vtOptionMangaSiteSelectionGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: String);
var
  Data: PSingleItem;
begin
  Data := vtOptionMangaSiteSelection.GetNodeData(Node);
  if Assigned(Data) then
    CellText := Data^.Text;
end;

procedure TMainForm.vtOptionMangaSiteSelectionInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Level: Integer;
begin
  Level := vtOptionMangaSiteSelection.GetNodeLevel(Node);
  if Level = 1 then
    Node^.CheckType := ctCheckBox;
  vtOptionMangaSiteSelection.ValidateNode(Node, False);
end;

end.
