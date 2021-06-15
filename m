Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF5643A77CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFOHRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:17:38 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:28410
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229613AbhFOHRg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36jkej3TY39D82h3VU/MS3J+zylcX5vZkqSzFZUjhA=;
 b=93pQa6Pv9D5srS7dt8yM94x0JF0eEHjh132stPraLu3ewMkukfH/4QdTutfzdzJA8RI2RnQcN6X8LshU63g7JSeqJvzXw2teG+88EhY3/vlnZvaAv8I95RaTCaKJZ8Uy/eXlSbNifvWe/cvIz47UjQWD24Nhk/TP49IDo97DaOc=
Received: from DB8PR03CA0029.eurprd03.prod.outlook.com (2603:10a6:10:be::42)
 by PR3PR08MB5674.eurprd08.prod.outlook.com (2603:10a6:102:81::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 07:15:20 +0000
Received: from DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::47) by DB8PR03CA0029.outlook.office365.com
 (2603:10a6:10:be::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Tue, 15 Jun 2021 07:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT027.mail.protection.outlook.com (10.152.20.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 07:15:20 +0000
Received: ("Tessian outbound 9d3d496fabe8:v93"); Tue, 15 Jun 2021 07:15:20 +0000
X-CR-MTA-TID: 64aa7808
Received: from 8ad734083099.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D823D651-D9CF-4642-8A73-04C883398A0D.1;
        Tue, 15 Jun 2021 07:15:14 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8ad734083099.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 07:15:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1B6sjSH83uWOcDR3uqKPNHNLs9fwuTYDnBVNlReRimHgAURp/quRDBxRFKq8OywnxtfMpGTNrOCMsNIB6qTCJS/QndwvcP9Hrr58IvJT5LMR0b7h3KUtBojHCw1hEzTs0ia5dUtP/T1QJ/EOFYepeSN7x5q0Y2WKlBMDwJPR5JUYM6E+36qUFGN2xjb+LQOPMVCibDMDhax32uM7oTVH4IDKOTKQMqwqq3vZb8Ohcsq/gxfoBrPFLkpaZKSNXAqjxIKMUSxRlKsZ1gXF3dU1mRfe99G8aVDecVAn1Q11rxvtTiV8aWZekFnuJplgrtwFGePPli4MKCMo46T8M3b4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36jkej3TY39D82h3VU/MS3J+zylcX5vZkqSzFZUjhA=;
 b=cw7MchbJo7UPmceVWp++uQRMnbasRBKrcgct6O+OykvyAwtreKnwh1dgFqSIIVmj0O561pmf3/ujR5sx5GWDVeSfhMl/EeDtLyXLDEvBOesOeXS6TRcYQj/uENREkfevfGfDxAGxsvV8KitFfzwu9AgctqoJmzHlJb1r1UslQEyFV4jWsRHTj8eVcJx3ZPbMZXtEYXnZCFAwB2fcV+1eyeo7S8bIc/9vDoVgq0admbzy2vzKzdG6f3jN0CIa3C1Ola3O1IYJ5R4mUXZ4Us4zzO9WYB417+SYo3YWXeGogxY+YGgt9Ypj/Ax+idQMgZ8Y9GTeBXr6pii/iFLiBRSnGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j36jkej3TY39D82h3VU/MS3J+zylcX5vZkqSzFZUjhA=;
 b=93pQa6Pv9D5srS7dt8yM94x0JF0eEHjh132stPraLu3ewMkukfH/4QdTutfzdzJA8RI2RnQcN6X8LshU63g7JSeqJvzXw2teG+88EhY3/vlnZvaAv8I95RaTCaKJZ8Uy/eXlSbNifvWe/cvIz47UjQWD24Nhk/TP49IDo97DaOc=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6024.eurprd08.prod.outlook.com (2603:10a6:20b:23d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 07:15:12 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 07:15:12 +0000
From:   Justin He <Justin.He@arm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Thread-Topic: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Thread-Index: AQHXXtr4yj2ZFiynnEqJXnMpAugWBKsPVv2AgAVSIdCAAATl8A==
Date:   Tue, 15 Jun 2021 07:15:11 +0000
Message-ID: <AM6PR08MB4376D63563682BDB626BE79DF7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com>
 <4fe3621f-f4a0-2a74-e831-dad9e046f392@rasmusvillemoes.dk>
 <AM6PR08MB4376C7D2EEAF19F4CA636369F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376C7D2EEAF19F4CA636369F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 88481B13B5F6274AA78D6D6C0423D4CF.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d8d588ee-cd3c-4f23-7dfb-08d92fcd55ea
x-ms-traffictypediagnostic: AS8PR08MB6024:|PR3PR08MB5674:
X-Microsoft-Antispam-PRVS: <PR3PR08MB5674EF99CEC8ACDE5F419B4CF7309@PR3PR08MB5674.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0KgsikTVQwPXdgE0sLtR9hBjwwmYMgA371Jd4zivo97t3YjADSq7VO6KFV8acZ0PLw5pTh5pheoxPgk9Nixth9WZQg17sPjdkhqa+viHdttGFtGSsmT2UfIH3QeLKv1bSmRLDsS4yV5xnLMrQXTEx6MJrwrXL18vjx2PT2yVmNyKrdRFbk4oVrJ9cq40JQZWsi7yCqwMmt4Of8WfodtcGwhhj39mPTEAcrP1ulfQtNx0JlGMZAToALOvOju1310Yvf8BlWXIIX5EyKTvcfJjxqPxJ+X1HVcpc2hfOD1BsdmmIolE0qlesZI3HT7y4h5nnYSc2DdnmAP28Q34YFD9paAvgGZtPMe4RVx1AciwEXZ0XoVnGbP9RlgiOmTn8i4vSNT8piVbJPxFIehbZV/awR35G+x6XN3/l4Pjh+gkgq1apgobkTqNIapBzixjXrxuT9NAI9aTyl0Es1tn6nQLgKWsQ2Gb3BAJyGctaDxoHV3uFwgLoQ3/WVBE2bcB5XqG3JzTyKZJZOazzmhbN/Z9pQmQzDhS4lrv2/YGAfztLf2851qSU9b2svfeMo3b5EzW9msLdONzeF5+FOLxMPrK3dDCaf1AatokeDM+ZLnG35k=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(4326008)(76116006)(33656002)(55016002)(64756008)(2906002)(110136005)(66476007)(66556008)(66946007)(186003)(316002)(71200400001)(8676002)(54906003)(9686003)(66446008)(7696005)(6506007)(26005)(38100700002)(2940100002)(53546011)(478600001)(8936002)(5660300002)(7416002)(52536014)(122000001)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1z5iWpQ4bf9J8ceFLLOQEM24Kq76VXS/Midha/DlzQGUwmaaGx160yL90cgc?=
 =?us-ascii?Q?gyjYmenLQwlF1X7RET+l/9nut+OtclPIP+KMxaMm/h2JExnni1SRX2tSjecH?=
 =?us-ascii?Q?izO0r+nw+vPPUv07oGCxbYZ+J2zrRugnt3JRH2cneoWal1yJQp7A/xIRb9Q2?=
 =?us-ascii?Q?Xx+1YXsq8vhh2rcVsVcRIIt/pgpVKY+B9a/ZlvpnrgqK9Csofnrht691HX6X?=
 =?us-ascii?Q?a6Z1P6sz1EbuqDoKn6Ok5mXL1WOsyYXQcy5+aKM6fDWBrZ9lJGwBzm/4LlwB?=
 =?us-ascii?Q?0zEkwTcqRkqdALD8JIWM4vGtW2dJWTrnmQ1xEoFIniiW3kZCGYGCH7+y3eJu?=
 =?us-ascii?Q?5VUZyIcr3ggW92InZWsrxlg6OZNpllt+CWI2lGFOUgOIIFGtIuu75EL4kzq8?=
 =?us-ascii?Q?x3y6X2GBGGpNHMXg/LBJ91v+I6dHuqBtYjFSHzihdcljCGOagvNgIkloVuVd?=
 =?us-ascii?Q?8SiQ3UMZY1AprMOJPwqogO12RmZpRGgDOf75ZMeygvb/arkPM2NvA8wVtcOC?=
 =?us-ascii?Q?0DFiihd6w+DjdThRrpObf2Q4WffyFFibZMEvRBl2rzgfkIN/uXZ5h9K7M9HZ?=
 =?us-ascii?Q?q6ODh8u2cCbvm81PwtV4av8hWF1iQq/cJ9AlujS7yztGA//O2P2eyPpns94A?=
 =?us-ascii?Q?ql82bDlT7nuTCwCcsjy3hQWVvhHo4XT6cDAqmXQaPQmM8/b9ZrAXJuKutPCm?=
 =?us-ascii?Q?c88IStebitp4d0gJwke+Asxf1mvJ6MDHV6gkLpXZWOuuj/WTFAKWOmtqk/S9?=
 =?us-ascii?Q?byrRtLMC/ACueoVy3wQ5mo5HE+hwjQoDXBk7gckZ93qRV9hD0zH45GFrHHMU?=
 =?us-ascii?Q?5G8UQEoi+5buYw0GOIUmOLLQMWYRr4kO24aCi9fcRU5K4MQlvv1frpSD9KSB?=
 =?us-ascii?Q?rrIPUJcDLAFBtuqLBTB6266DvdmOxW5nB/Cmum8wHRacAVWCfNBx0uaPzpK/?=
 =?us-ascii?Q?rRz/8e6tdKh4zoiaJVuG7meNiZwe7deOs+PPuhGEkidNYIpxdEqyCTidq5iG?=
 =?us-ascii?Q?vJ/RqzUxdNGa7IGV6GbJu+Ji9BG87n3JigPlcCGoDzORmzPQeqC9tjHJKwR2?=
 =?us-ascii?Q?Ikin5KMKF3cDlgcI/SLDsQbz3E5NrvASILn5siEz3vu+0C58vBMjg22ZDzMh?=
 =?us-ascii?Q?RzLhFVsQfNapdPaIsBhBzipffcbGaSQ6qCWojhSfkMcYXozrZSPbXouB1fMP?=
 =?us-ascii?Q?ys3i+VH9jJSjyYXlgTwuaNM2PwJIE7Uo6TQwGzG0AZ4XlMFGuat3qZ03I79f?=
 =?us-ascii?Q?qXfDr3yrPQzD3PV6vYBgTNKH1PqesoInlAzXQXEloKwlNbkkXDlZxv4u+8BD?=
 =?us-ascii?Q?O7fBDP47VMqvNE4/7y5ggHpv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6024
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2bf1981f-2304-4ce5-0647-08d92fcd5118
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sBvu5Z01cVH1lXwYoeFnSqx598YfiksgspT7ER9HAWQrOryUE/iIo/rHTXmutPoSeAM5WZKh8KD4sEpaW9Vk/wYFFnJ7C494pBz9amRrEUhi7c3Q7KGf4us3vCav4BPe9+voXtdf0DR8OhEY7XGdEXI0+o94A/EZQvE/By8R3AOAqkt0T9ULXFrNqAafxdxL13Q42In75iENcvS2mmjdNKg1fdhEHDRfalGSLE1kmULHBZ8jlGcQBiyhxUSq22sDfUZBv6kPvAeq6+DpAiZcAMBGtmnaaYAvu4O1Cp0Tp0KX4hveJzEKhLNmZljW0IntGZJRHRPRxd16/fwDlxvHItwDG8F1oSjqHhPqLgq/zVkbFd5ERwS5DS9rDOAQzPthUJe4G/jT5Ktnp0XAD7jFQDLkFSptSIt73+EFOkmzVxSN9U6I0+B7LgnU0AEVfyvsewZpmoDT9zx4kY4Ay9hndxdL6AgaPkLXrIy1nHZlk23T+1cRNy1cdCTxSQ5sedydT4T3yH6266CNS7O+ZUbmU6rj1LhYeDm3cU1yM68Zu2Y2/SV6/Q2Xy/4VdRK7DUVB76igPVPulaFb0BhFWWtZ5j24KOmLNF4gFy4wqOgqulO4jhERIt34qxa2xEN9JEIVci1hW6YnwYE1On+UgJFkjoQK8EA7vk7lthr8GxLDb2c=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(26005)(316002)(33656002)(36860700001)(4326008)(2906002)(478600001)(82740400003)(9686003)(86362001)(83380400001)(186003)(81166007)(6506007)(70586007)(52536014)(8676002)(336012)(70206006)(53546011)(55016002)(5660300002)(47076005)(7696005)(54906003)(110136005)(450100002)(8936002)(82310400003)(356005)(2940100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 07:15:20.5728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d588ee-cd3c-4f23-7dfb-08d92fcd55ea
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5674
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Rasmus

> -----Original Message-----
> From: Justin He
> Sent: Tuesday, June 15, 2021 3:06 PM
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>; Petr Mladek
> <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>; Sergey
> Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Jonathan Corbet <corbet@lwn.net>;
> Alexander Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
> <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: RE: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
>
> Hi Rasmus
>
> > -----Original Message-----
> > From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Sent: Saturday, June 12, 2021 5:40 AM
> > To: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Stev=
en
> > Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> > <senozhatsky@chromium.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Jonathan Corbet <corbet@lwn.net>;
> > Alexander Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linu=
x-
> > foundation.org>
> > Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
> > <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>; linu=
x-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > fsdevel@vger.kernel.org
> > Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD=
'
> >
> > On 11/06/2021 17.59, Jia He wrote:
> > > After the behaviour of specifier '%pD' is changed to print full path
> > > of struct file, the related test cases are also updated.
> > >
> > > Given the string is prepended from the end of the buffer, the check
> > > of "wrote beyond the nul-terminator" should be skipped.
> >
> > Sorry, that is far from enough justification.
> >
> > I should probably have split the "wrote beyond nul-terminator" check in
> two:
> >
> > One that checks whether any memory beyond the buffer given to
> > vsnprintf() was touched (including all the padding, but possibly more
> > for the cases where we pass a known-too-short buffer), symmetric to the
> > "wrote before buffer" check.
> >
> > And then another that checks the area between the '\0' and the end of
> > the given buffer - I suppose that it's fair game for vsnprintf to use
> > all of that as scratch space, and for that it could be ok to add that
> > boolean knob.
> >
> Sorry, I could have thought sth like "write beyond the buffer" had been
> checked by
> old test cases, but seems not.
> I will split the "wrote beyond nul-terminator" check into 2 parts. One fo=
r
> Non-%pD case, the other for %pD.
>
> For %pD, it needs to check whether the space beyond test_buffer[] is
> written
>
>

Another question is about precision,
Do you think I should add some test cases e.g. "%.10pD" here?
I once added some, but the gcc report warning:
warning: precision used with '%p' gnu_printf

What do you think of that?


--
Cheers,
Justin (Jia He)




IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
