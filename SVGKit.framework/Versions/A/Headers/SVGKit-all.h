//
//  SVGKit-all.h
//  SVGKit
//
//  Created by C.W. Betts on 9/26/14.
//  Copyright (c) 2014 C.W. Betts. All rights reserved.
//

#ifndef SVGKit_SVGKit_all_h
#define SVGKit_SVGKit_all_h

#import "SVGKit.h"
#import "CALayerExporter.h"
#import "CALayer+RecursiveClone.h"
#import "CALayerWithChildHitTest.h"
#import "CALayerWithClipRender.h"
#import "CAShapeLayerWithClipRender.h"
#import "CAShapeLayerWithHitTest.h"
#import "SVGKCSSPrimitiveValue.h"
#import "SVGKCSSPrimitiveValue_ConfigurablePixelsPerInch.h"
#import "SVGKCSSRuleList.h"
#import "SVGKCSSStyleRule.h"
#import "SVGKCSSStyleSheet.h"
#import "SVGKCSSValue_ForSubclasses.h"
#import "SVGKCSSValueList.h"
#import "SVGKDOMGlobalSettings.h"
#import "SVGKMediaList.h"
#import "SVGKNamedNodeMap_Iterable.h"
#import "SVGKStyleSheet.h"
#import "SVGKStyleSheetList.h"
#import "SVGElementInstance.h"
#import "SVGElementInstanceList.h"
#import "SVGGradientElement.h"
#import "SVGGradientLayer.h"
#import "SVGGradientStop.h"
#import "SVGGroupElement.h"
#import "SVGKExporterNSData.h"
#import "SVGHelperUtilities.h"
#import "SVGStyleCatcher.h"
#import "SVGStyleElement.h"
#import "SVGKImage+CGContext.h"

// Parser headers
#import "SVGKPointsAndPathsParser.h"
#import "SVGKParserDefsAndUse.h"
#import "SVGKParserDOM.h"
#import "SVGKParserGradient.h"
#import "SVGKParserPatternsAndGradients.h"
#import "SVGKParserStyles.h"

// Mutable headers
#import "SVGKDocument+Mutable.h"
#import "SVGKCSSRuleList+Mutable.h"
#import "SVGSVGElement_Mutable.h"
#import "SVGUseElement_Mutable.h"
#import "SVGElementInstance_Mutable.h"
#import "SVGDocument_Mutable.h"
#import "SVGKNodeList+Mutable.h"

// Source headers
#import "SVGKSourceLocalFile.h"
#import "SVGKSourceNSData.h"
#import "SVGKSourceString.h"
#import "SVGKSourceURL.h"

#endif
