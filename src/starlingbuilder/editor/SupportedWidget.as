/**
 *  Starling Builder
 *  Copyright 2015 SGN Inc. All Rights Reserved.
 *
 *  This program is free software. You can redistribute and/or modify it in
 *  accordance with the terms of the accompanying license agreement.
 */
package starlingbuilder.editor {
import feathers.controls.Alert;
import feathers.controls.AutoComplete;
import feathers.controls.ButtonGroup;
import feathers.controls.Callout;
import feathers.controls.Check;
import feathers.controls.DataGrid;
import feathers.controls.DateTimeSpinner;
import feathers.controls.Drawers;
import feathers.controls.GroupedList;
import feathers.controls.Header;
import feathers.controls.ImageLoader;
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.NumericStepper;
import feathers.controls.PageIndicator;
import feathers.controls.Panel;
import feathers.controls.PanelScreen;
import feathers.controls.PickerList;
import feathers.controls.ProgressBar;
import feathers.controls.Radio;
import feathers.controls.Screen;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.controls.ScrollBar;
import feathers.controls.ScrollContainer;
import feathers.controls.ScrollScreen;
import feathers.controls.ScrollText;
import feathers.controls.Scroller;
import feathers.controls.SimpleScrollBar;
import feathers.controls.Slider;
import feathers.controls.SpinnerList;
import feathers.controls.StackScreenNavigator;
import feathers.controls.StackScreenNavigatorItem;
import feathers.controls.TabBar;
import feathers.controls.TextArea;
import feathers.controls.TextInput;
import feathers.controls.ToggleButton;
import feathers.controls.ToggleSwitch;
import feathers.controls.Tree;
import feathers.controls.WebView;
import feathers.data.ArrayCollection;
import feathers.data.ArrayHierarchicalCollection;
import feathers.data.HierarchicalCollection;
import feathers.data.ListCollection;
import feathers.layout.AnchorLayoutData;
import feathers.layout.FlowLayout;
import feathers.layout.HorizontalLayout;
import feathers.layout.HorizontalLayoutData;
import feathers.layout.TiledColumnsLayout;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;
import feathers.layout.VerticalLayoutData;
import feathers.layout.VerticalSpinnerLayout;
import feathers.layout.WaterfallLayout;
import feathers.media.VideoPlayer;

import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Sprite3D;
import starling.filters.BlurFilter;
import starling.filters.CRTFilter;
import starling.filters.CrossProcessingFilter;
import starling.filters.DropShadowFilter;
import starling.filters.FlashlightFilter;
import starling.filters.GlowFilter;
import starling.filters.KaleidoscopeFilter;
import starling.filters.LineGlitchFilter;
import starling.filters.NewsprintFilter;
import starling.filters.PixelateFilter;
import starling.filters.RadialBlurFilter;
import starling.filters.SineWaveFilter;
import starling.filters.SpotlightFilter;
import starling.filters.VignetteFilter;
import starling.filters.WarpFilter;
import starling.styles.DistanceFieldStyle;
import starling.text.TextField;

import starlingbuilder.extensions.filters.ColorFilter;

public class SupportedWidget {
    /*
     * NOTE:
     *
     * Add to this linkers if you want your component to be officially supported by the editor, as well as adding meta data in editor_template.json
     * If you want to register custom component, then you should call TemplateData.registerCustomComponent instead
     *
     */

    public static const LINKERS:Array = [
        Image,
        TextField,
        starling.display.Button,
        Quad,
        List,
        Sprite,
        Sprite3D,

        Alert,
        AutoComplete,
        feathers.controls.Button,
        ButtonGroup,
        Callout,
        Check,
        DataGrid,
        DateTimeSpinner,
        Drawers,
        GroupedList,
        Header,
        ImageLoader,
        Label,
        LayoutGroup,
        List,
        MovieClip,
        NumericStepper,
        PageIndicator,
        Panel,
        PanelScreen,
        PickerList,
        ProgressBar,
        Radio,
        Screen,
        ScreenNavigator,
        ScreenNavigatorItem,
        ScrollBar,
        ScrollContainer,
        Scroller,
        ScrollScreen,
        ScrollText,
        SimpleScrollBar,
        Slider,
        SpinnerList,
        StackScreenNavigator,
        StackScreenNavigatorItem,
        TabBar,
        TextArea,
        TextInput,
        ToggleButton,
        ToggleSwitch,
        Tree,
        VideoPlayer,
        WebView,

        HorizontalLayout,
        VerticalLayout,
        FlowLayout,
        TiledRowsLayout,
        TiledColumnsLayout,
        VerticalSpinnerLayout,
        WaterfallLayout,

        AnchorLayoutData,
        HorizontalLayoutData,
        VerticalLayoutData,

        ArrayCollection,
        ArrayHierarchicalCollection,
        HierarchicalCollection,
        ListCollection,

        BlurFilter,
        GlowFilter,
        DropShadowFilter,
        ColorFilter,
        CRTFilter,
        CrossProcessingFilter,
        FlashlightFilter,
        KaleidoscopeFilter,
        LineGlitchFilter,
        NewsprintFilter,
        PixelateFilter,
        RadialBlurFilter,
        SineWaveFilter,
        SpotlightFilter,
        VignetteFilter,
        WarpFilter,

        DistanceFieldStyle,
    ]

    public static const DEFAULT_SCALE3_RATIO:Array = [0.49, 0.02, "horizontal"];
    public static const DEFAULT_SCALE9_RATIO:Array = [0.3, 0.3, 0.4, 0.4];

    public function SupportedWidget() {

    }
}
}
