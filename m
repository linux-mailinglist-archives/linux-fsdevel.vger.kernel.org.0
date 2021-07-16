Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A53CB24C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 08:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbhGPGUi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 02:20:38 -0400
Received: from mail-eopbgr10081.outbound.protection.outlook.com ([40.107.1.81]:47878
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233176AbhGPGUh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grJHRN90QE709FdTVUk3ZnGpuQ6djvF3NIFuNbVFlEM=;
 b=G/LNge1gwtNkWUJNN0MWTxTB1k4j0h/WHt/qQOUt3wmqzmre0zFf7X3N5eqCvoEOIw6kCGhhjAlRkyXOYEHoetHsOYF+WxFkkX7sKCFoPIyPvtpyulYPkSN2937fJx7zoWELKSxzzknnLFEhnp3G0ou+6e3NEDOhaHRWkno5U4I=
Received: from AM6PR04CA0007.eurprd04.prod.outlook.com (2603:10a6:20b:92::20)
 by VE1PR08MB5263.eurprd08.prod.outlook.com (2603:10a6:803:116::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Fri, 16 Jul
 2021 06:17:40 +0000
Received: from VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::49) by AM6PR04CA0007.outlook.office365.com
 (2603:10a6:20b:92::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 06:17:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT044.mail.protection.outlook.com (10.152.19.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 06:17:40 +0000
Received: ("Tessian outbound 664b93226e0b:v99"); Fri, 16 Jul 2021 06:17:39 +0000
X-CR-MTA-TID: 64aa7808
Received: from ab343009c2e1.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 032CFB5B-54E7-4343-98E1-01F81358224D.1;
        Fri, 16 Jul 2021 06:17:33 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ab343009c2e1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 16 Jul 2021 06:17:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnRdvm35xKghB5+tmpatoedCcXgjJ+2Ssi4vLq0VuDrwj3dhMdwLyC1vXEgSUSVlTXbN0uemf4ygLH55n1M/7W4Y9993moThEqcyLGCENAcupilaJdYvhUkKC+kVXRCXF1Qbnqc6ghj7qGHnEOIDe7sW0+MZ3CN4Wqy/Q+5fVxWQySai6rZcir66m0F6KpuO0OnGoDF64ME4hSB9Ayeh1560VXWXbQaeAG7I7XVAneCr13iZBh2Yq4ysoqjcDp2zytJVlWD8GrYeUDh0fp4l/MLuJDL8KczNPsZtrcyGLRmVfcSGlOtE0wVwnETw3vODMjJc7MBWqS8e2eFpQZclcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grJHRN90QE709FdTVUk3ZnGpuQ6djvF3NIFuNbVFlEM=;
 b=CVQ+O3dwGPFjfpYXwqWUyPKhI9sC7Us8ivGD7eaFy4QDcP9n6W66z3VM7GxvaG1j+LQIlUkZjRrSK0OoCHnz/EW62jCsMOppZCVUfzT3O5Z7U+SkPOA3txv5YGFpI6DlVQfg43xRGGUeeKzXaSIBkAVZNbFC0TkZP5QRfSLog3CQygOjcf1amiowyz6vaixuMk5xb8y3AeffYbD9Skv0QN+kmaGZqEm0kr2HzIivGFkQDZeMUo1mGQIJFBkDja3Hoipe8EhT+iyDRT6a70+gfyNCSMBDyDd1FZrbk667Q/OXBeWQYATrh6XIIhW0eO7fOgoIyxIhMHjteo1leih69g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grJHRN90QE709FdTVUk3ZnGpuQ6djvF3NIFuNbVFlEM=;
 b=G/LNge1gwtNkWUJNN0MWTxTB1k4j0h/WHt/qQOUt3wmqzmre0zFf7X3N5eqCvoEOIw6kCGhhjAlRkyXOYEHoetHsOYF+WxFkkX7sKCFoPIyPvtpyulYPkSN2937fJx7zoWELKSxzzknnLFEhnp3G0ou+6e3NEDOhaHRWkno5U4I=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3638.eurprd08.prod.outlook.com (2603:10a6:20b:4b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.26; Fri, 16 Jul
 2021 06:17:30 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4331.026; Fri, 16 Jul 2021
 06:17:29 +0000
From:   Justin He <Justin.He@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        nd <nd@arm.com>, "Darrick J. Wong" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFC 07/13] iomap: simplify iomap_swapfile_fail() with
 '%pD' specifier
Thread-Topic: [PATCH RFC 07/13] iomap: simplify iomap_swapfile_fail() with
 '%pD' specifier
Thread-Index: AQHXeSfOfVCeryK4fEmuKVaSKzQEI6tFIGIAgAABdjA=
Date:   Fri, 16 Jul 2021 06:17:29 +0000
Message-ID: <AM6PR08MB4376391DC23C94DF22E72B9CF7119@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210715031533.9553-1-justin.he@arm.com>
 <20210715031533.9553-8-justin.he@arm.com> <YPEi9CvMoM5Bpq/i@infradead.org>
In-Reply-To: <YPEi9CvMoM5Bpq/i@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 75C995CFF37E3E439151CAC3BD09AAD4.0
x-checkrecipientchecked: true
Authentication-Results-Original: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d260e0db-dc2d-4203-5a11-08d948216a34
x-ms-traffictypediagnostic: AM6PR08MB3638:|VE1PR08MB5263:
X-Microsoft-Antispam-PRVS: <VE1PR08MB5263B47429225C4EF74FBA51F7119@VE1PR08MB5263.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xlXsaTdPC8fduV8BVbYeiXeagwWWRdYshbOxlmQj7EYHjdTne+YLMVCnoE/jmIjT96SkbwtbnOZEJbHE4lM9gevnifncXCIoRjmcrOfWd1fsx9ijoMNs+9cswhKJ/TPgCSzHWDh/VDCg90coyiVLQI8ir9IEAoDOE89JIXOJyIHjMVy7Hdn49goFs7qJzSoI8uzls2ITu5DaunivWJvaQ0ciH4OhQax/9lhK0WcqID80reICHrOdeRQyDG+88VpO0dBBghCoqAGna3oVlfKnfmunltfSD+dFJxRutrQsOfWRlIWAyonUEt93tl2/njtonKmSdpCwOagy0TPh+IPZ8I9+/t2rzY7MkIDeA+Yv01qHqH46eWBHFkskEjomUiE8tR9kIHCpUKQ0ExqwyPGBpDhDRDcNxeLUHgWhFwHoznhVkdgZRYlPtOn9bJsMjxOc3cgJB8ciMS7ooifN/liwHLxXBTq3alV1v31RIQ4JyR5wCVbAl3KQSTQbtJkzwhhtHxCzg+TThrOEdINvSqiQP/uc5lTDouK1SH8dCf0MCual9fF5a/ZV/zxqJv3fsPavoSI9JWWuVSEgs4ylRDYDhpQF0mI26OxLXqfGbDXUAFo5ywJpFclP5C4jlOkWzak44WxgEmZEP9QURkXpM83erZZhSMi75gs/YosllG5nYuUZ5xtqPr/wyreQOc4j+f/VmD+9DlcmKDsofS9+BGsnlA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(366004)(136003)(376002)(478600001)(8936002)(122000001)(38100700002)(2906002)(83380400001)(8676002)(52536014)(4326008)(86362001)(4744005)(5660300002)(33656002)(64756008)(26005)(6506007)(6916009)(53546011)(9686003)(66556008)(186003)(55016002)(66446008)(71200400001)(66476007)(76116006)(66946007)(7696005)(316002)(54906003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eNxRce+SVAKZ1ImWo3ikGFZlJWVX+oC1d0AU3ooMB31PacpkG/TQjzryKPI5?=
 =?us-ascii?Q?2LJqC1dirSgLfWU/OJBduTNUoTPfou/jPBBowYoyPCqlVImXjTky+7cwuiZI?=
 =?us-ascii?Q?yhEFmlLWSefQC8xKc/Hy8NSaU/phgpbigpVex3jPYi1itjkQQgcR+pe9iXLD?=
 =?us-ascii?Q?Ooa2pDgnD8bMhOp69ePO6LMDUjyRE+mB57pjs4UewKYkmgS8YGtsA7lCsJ+P?=
 =?us-ascii?Q?DBaFcP+XoTisferrZvcxaF5QGUKC1h7OznHUXbfALZ8qYZplPQiIvN1Wg3GK?=
 =?us-ascii?Q?yiuMkdcM+jzMg28yI4FwfrcX7I/E9OYHZj/EfloTPlATgVZWGLN/R0Gh8FrX?=
 =?us-ascii?Q?6sqYjA3vJQcdvUQdP0tTDtaFcWCQDn4fBjkj+Rhs6qnIGOG5RIdgMo4CuMeo?=
 =?us-ascii?Q?sULxVL0BCoCmpu0ZFit8K0TAVypU18ib6VlmSWgIN329oKDxTT2YKk0ruwFB?=
 =?us-ascii?Q?HCofOiKuDNMCMT8eYf5ywvTg18+KlcqNkcfIyDthn2irP4DmfbsL2iry9lop?=
 =?us-ascii?Q?tnkfgy1cJR5RiBN7vIcVMk8Ip5I1g1ZeEJOmdcTkEYKyBB7eysurmRkNSkS0?=
 =?us-ascii?Q?g3Ch9tvHmtmVIVE9mBwSZe6gLchzRlPgWPPq4A5JSwmDaHOL7PF/VevbngVa?=
 =?us-ascii?Q?o2NaTUyNqarv9QWe5uAmcjZ61hP6S3QCKSRm1JCazxQFSO64Rgv6zCDdmSIV?=
 =?us-ascii?Q?XEq2xEgrWCU4yHIdiiNk2SvbFbph61mMXTwKk/E8K6PybmFXSowzPZLI0har?=
 =?us-ascii?Q?+Olr/KGK3Kpjqq8iGhNvvyUb5rAavnLY4v3wSz5beI9N7FSv8xxzcLEbFZpq?=
 =?us-ascii?Q?j8vEvR7g4GkAx9qwMT/YxhtWdZFCGp3yylrXdGvHm13UjeFc8JQZeu9yobfn?=
 =?us-ascii?Q?x3HuOmx07n3VQLc0XnohpuAGN4wwZckEBrGcJS6LWxt2h7U8tXf32pemPCsF?=
 =?us-ascii?Q?57x6Nd4jSRDbFbgf6v/tajhg3YLV3YwZssDE+8mZMAdlPh7Bf1fawsB3zlys?=
 =?us-ascii?Q?pBzpWp4b1d/iM2wRu/RhADsLJd9a6sEbjeey2fZ0KjWsGjgP1mB+9HtX41N5?=
 =?us-ascii?Q?SiVpQJIhUruFEWcr3H1uvP4d4Ra6d3jxUu6KNm89q8St+1pAHBNcrl1qPpG+?=
 =?us-ascii?Q?xmycuzA/Qpmlb3yd1XGK2srnxSRxKV/GHZt+iCsuMBTSP4s1cs/rhwsJoKKL?=
 =?us-ascii?Q?scqNHSLE9DivD7XJpHD84Bzr/hFdxZvPqWImnJL63mmfXkaYJJ6MGKHzxmgb?=
 =?us-ascii?Q?5NA35X/Dc84fg+BMZcN990uIvtA53hBp/l8VCzpyQUgMWcCYXHWHtig4K71H?=
 =?us-ascii?Q?Dt6hTabKfk3YosJyIHighrC1?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3638
Original-Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a49403ed-cdb2-4cb1-6cd4-08d9482163e6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+Ci97KAdCT2gdfTdGHolH/6/cgaDqigDA4MJvR/y+3PVXoC9HPQg2dkkLgNXDafo05q+AK8/egJedfCOyoRcSoSuZnDg2QWQxYFVoC3ybvnV80qv9ZlO4+kzclzgPP23IBL5ljQbpx7yjO4DepxyV4TlOi+iGsm+uxldyw/Q3FR8plZ+0T7jlz8ODlzb4fi7xdBYG5m8T40QldRRgr/P8/EWQBSvPgs5AuD68LmgBnc09uY8w/IuK+r40+kfsB8oZa26FFe0HiLQgkCoBJVdFSxRto0r6nktoYKq1bX0n0XWWRaxk+xzTeFn7mTNR8qpx0XxmcZNJgjBRce90DYNud8G8NZ6TpioIk29Bv2FoZGzpV4AE/9kUGirCANPrn5ttFXAMJP364n/z2eQk2cFnmfPmSbnIxpi3H7M4H6s7bg34rXEFFpRS6jaFWWiaSNr3tDH6lmCJDuPFNnPNFxNkPgtm0j53zqqEykQDUqziOCJFlc8E9e8XTbgLKkD3PnStV8+obZAT9q1FarMU/aLBWoiLSDvV5HT1qlpFb8MvQQAR0pVEETsf4j1eZ/7hdra10arP6bXW4ZG08y3ts/qyKke45c4aMgsDUFGEJjZIcb47fp1MKGkV/j7c1Pb7gAhaX0p24CN3nDq1SIw1knYmCelwvDQT7l3dbg/qYG442+reQ0WiRAOEqed2HqGvEjjKXmcZuW0z8Gy2jMt+4E4A==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(52536014)(36860700001)(186003)(26005)(47076005)(2906002)(316002)(82310400003)(55016002)(70586007)(450100002)(70206006)(53546011)(6506007)(83380400001)(356005)(336012)(7696005)(6862004)(81166007)(9686003)(478600001)(33656002)(54906003)(8936002)(8676002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 06:17:40.0593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d260e0db-dc2d-4203-5a11-08d948216a34
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5263
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Friday, July 16, 2021 2:11 PM
> To: Justin He <Justin.He@arm.com>
> Cc: linux-kernel@vger.kernel.org; Linus Torvalds <torvalds@linux-
> foundation.org>; Christoph Hellwig <hch@infradead.org>; nd <nd@arm.com>;
> Darrick J. Wong <djwong@kernel.org>; linux-xfs@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFC 07/13] iomap: simplify iomap_swapfile_fail() with
> '%pD' specifier
>=20
> On Thu, Jul 15, 2021 at 11:15:27AM +0800, Jia He wrote:
> > After the behavior of '%pD' is change to print the full path of file,
> > iomap_swapfile_fail() can be simplified.
> >
> > Given the space with proper length would be allocated in vprintk_store(=
),
> > the kmalloc() is not required any more.
> >
> > Besides, the previous number postfix of '%pD' in format string is
> > pointless.
>=20
> This also touched iomap_dio_actor, but the commit og only mentions
> iomap_swapfile_fail.
Okay, I will refine the msg in next version.
Thanks


--
Cheers,
Justin (Jia He)


