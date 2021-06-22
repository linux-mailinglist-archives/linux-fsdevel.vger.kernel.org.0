Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A13AFB02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 04:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhFVCWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 22:22:52 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:29763
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230338AbhFVCWv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXusYSd3ePqi3wpJGn5sKhpW9+GlZ7X0ZmQ6aLoZ6ec=;
 b=m2JSBMt2OLFTevGKYoEcs82h1DPN6R5mKaxANNpoijcsZBa1gjP9sGH7FvZAvIyeW1MDL/FHX8CJYTv2OWTddsCzbD+FkrmEjhGSzm9r3BV9etQr5ttzJVj8yrWFGPPNzHZ6XKcNzg1cRsfTQI3WUiuQWWas5d5iitgo4X7JGIM=
Received: from AM6PR10CA0024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::37)
 by VE1PR08MB5278.eurprd08.prod.outlook.com (2603:10a6:803:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 02:20:21 +0000
Received: from AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::fa) by AM6PR10CA0024.outlook.office365.com
 (2603:10a6:209:89::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Tue, 22 Jun 2021 02:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT004.mail.protection.outlook.com (10.152.16.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 02:20:21 +0000
Received: ("Tessian outbound 7799c3c2ab28:v96"); Tue, 22 Jun 2021 02:20:20 +0000
X-CR-MTA-TID: 64aa7808
Received: from a23af9e5cb02.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CFFF3DDD-4B66-40E2-A3AE-F4D01946537B.1;
        Tue, 22 Jun 2021 02:20:14 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a23af9e5cb02.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Jun 2021 02:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kumFo7UnmyEcb+XYa6zbp2osuiOAaBB8pJtOdN7CU9LmE0vGWlR6Y1zv+X1FfOdeaCBhgC4hwLgLYyKW2X2l1TxlYm3XnoQDw/AmZYYCKlBkPm/D6XNI19kzTjwsr9H3QDCm+P6dy5HkxskDPaGDA9/1r+TxsRJY/2hh8GeyFT2KlE5rmBdrl9Qsj4yo9Hd3TAOsV25nY+GwLfzscYcpw+CBBlTm6kXSpo2i2XygL5ivVk0I33zALuhoVhYWI8yldInGxU7pv75kRUi6sbHqS9JFlaIwvYO6E4cAG1IfxhGIk+H/csPI6pNvi6jFwsEhmpna0H6eA+Tfxm8Pa0Xgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXusYSd3ePqi3wpJGn5sKhpW9+GlZ7X0ZmQ6aLoZ6ec=;
 b=faZAqK0aOEbsCug+G/H/w14UUuaID1KPEkiYXiZffulEw5XwNrrIxrbe45WyfDikGqUVWpXbCcNGDfPs1Eun+Xpfkcp+FaOhx42ZOnQ/zk02krxRntUcaGKUH3iHGNHRYkd9OTRVyv1tieqV/yzLPvJyeB8uxyJjJX2aGujWJJUdZe6bsiBS2TYfVWAA8Gw+7EYjI2G5RfN+hYB3C1MEJ0pam8K3z94/CZk8mxmNwW/9igx589V1XiMdnaVSS7Xtf4PKHuR8MkrQWZzjHm510Gm0yQn6bCXkskDXySfdrHmqJGCEPIkq92LigzHnr21CFKN812uqCZ6PO0XqHhM0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXusYSd3ePqi3wpJGn5sKhpW9+GlZ7X0ZmQ6aLoZ6ec=;
 b=m2JSBMt2OLFTevGKYoEcs82h1DPN6R5mKaxANNpoijcsZBa1gjP9sGH7FvZAvIyeW1MDL/FHX8CJYTv2OWTddsCzbD+FkrmEjhGSzm9r3BV9etQr5ttzJVj8yrWFGPPNzHZ6XKcNzg1cRsfTQI3WUiuQWWas5d5iitgo4X7JGIM=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4055.eurprd08.prod.outlook.com (2603:10a6:20b:a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 02:20:12 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:20:12 +0000
From:   Justin He <Justin.He@arm.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH RFCv4 2/4] lib/vsprintf.c: make '%pD' print full path for
 file
Thread-Topic: [PATCH RFCv4 2/4] lib/vsprintf.c: make '%pD' print full path for
 file
Thread-Index: AQHXYf4pVLUB+XxbIUiVpgPGMeKRTKsYQOcAgAcTzuA=
Date:   Tue, 22 Jun 2021 02:20:12 +0000
Message-ID: <AM6PR08MB437657CEE896E9E99C1D8CA9F7099@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-3-justin.he@arm.com> <YMtXshP8G4RZvr4m@alley>
In-Reply-To: <YMtXshP8G4RZvr4m@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 57A99EE09FBF4D4DB0ABD5BB528750CD.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d262cff3-6152-46fe-11e4-08d935244920
x-ms-traffictypediagnostic: AM6PR08MB4055:|VE1PR08MB5278:
X-Microsoft-Antispam-PRVS: <VE1PR08MB52783D2C25208CFCDAAB67BDF7099@VE1PR08MB5278.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: a4rJQQzFaf59KVRqvKmGidTQBcQ3i1BYjBQ6JzurJAeVq96yVIe75mG5cs29SXrDZDK0LBnFZFV0d7egudcrIUaxpXKJNJdggVr8Ju7uhrDHeWIRYhZ/IcQAU6KSlN3b0qsJQAGYoUKxioSn/YvRJgZMfZ+ONlsM5G2Gf0k3B4CzNwpyHeXmJDHcailo2g/5lfTaxmqxiSqDYljpTJmunNmXLO/3kljMKLH4W8r2V0pQ8BMDH+GH5JcpgjXAdsiPaQuNBuMkf/911VV26exIPp6UScA1yV8m8/97h6cpa5vWdh5XOl+c+axhbCXgsmLSvymK479XHlXIaSSZtD5+3aT8IV1lk22a2jGZH8YzxT5JfX2yzpKsGWTdmvZKkZ5YMvbA+cyZoXsSQ9D48KeTkFbTaddVH7vekRmo8hkxi1iih/aQ+jSePXJJC88DSQcbZym+w6VLdkwY/aln+7gSOArNtGTpMZc6+hvksoHhzigfL0iqi5WPQJ0XK25uGtcw8pWtgXioalSgJheUSTynzjzCKglyivS0zx8qI0qQ9KPIVC6SU3nWn47scLG5ON111uvbx9PoRbTdGKJ9fh70/WCOHnaq+1AUohgD5n4ls4/y5PeOkqwNqddkPiI7i1A4zKUpLFES/9y0zmej4d9EXFndFaH/MzMoa66+HOhTHjG7GGpeuUllxnhSG7cz1BYh/UrgiUUwn+A7/YzAExFG8qaUYMClNleB/ZZRGe7Ga7o=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(7416002)(966005)(55016002)(54906003)(5660300002)(4326008)(26005)(6506007)(52536014)(33656002)(8676002)(71200400001)(7696005)(316002)(122000001)(38100700002)(6916009)(478600001)(66476007)(8936002)(2906002)(83380400001)(53546011)(66946007)(76116006)(9686003)(64756008)(86362001)(66556008)(186003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RObW8HgCPMX2mwq/nFMzMGmfKiQVlOMcnzYYOEU92eAmVouI6puzBeTzs4Pg?=
 =?us-ascii?Q?kabWig4r2a/V7x9sSqT+oyVtD7/jxuDutraDMEVPIWFliRCJ47N/jjRljsCx?=
 =?us-ascii?Q?mpA1HxTq3ZXzM9oKx562MzrqZlh6ijwWr+nfEaZlplC2NsEJOCUrp6lDjF3b?=
 =?us-ascii?Q?neYH9AiDH4Yq+5tYux4vUqCtFxgDJ3EqjopcIgoLZKOyMR57nAHtoRHeA3d9?=
 =?us-ascii?Q?noChrA0b/sswatVXEqL4+NCs3qc8idl/vI7Ak22tpm6UHs1exGWduQJ4gk8+?=
 =?us-ascii?Q?v9xVbaMKGDo6RNuSphwsvKyUvwkTipE8IhRVvtl7sedSg7vktqdJvo2sPHVQ?=
 =?us-ascii?Q?v/ZAFlm6k8Fj5qhUr6GopcOZwQNY7ciZLxvq2lEtYZedsnwn+3xF7O8RKFag?=
 =?us-ascii?Q?wI58MEawqkF2mFkJABYVhOJn8ViQoFIYB373DIqX+BmGiXuHBQx3qr3rh9sX?=
 =?us-ascii?Q?Ikl2VOkeDTLXpnliXVb4HJX6jZjlLfjmqO1f+hOS2CHy1kNaFFvoO4JM5JLx?=
 =?us-ascii?Q?EZATsxcqD1gweiQU9455NBk0dCz9p27zPLW390PjN0S5wbVVlHmUiMz2/Kv7?=
 =?us-ascii?Q?q7LXPaijrEjbJxRudsu8atJkVBDP0uTXic3INNEYoXywih+MnjjvhFzEzNDC?=
 =?us-ascii?Q?fR5vTpGO2YfxeWb/kFghzVeuYcVvO5QWiyo+cIdQqYD6P9LTNdaOiKKPteKL?=
 =?us-ascii?Q?kFpU4T7Hzhka3ytYgcH7Y/l8JqewERL5reuqeph3kcpObZCZ1njbPzDFGSv4?=
 =?us-ascii?Q?dKx6YJI0Dg8uEZtvrTWhZCfAdGJJjO4m8I0wKKs+ZoveEHh/UJ6YkyqcVKVg?=
 =?us-ascii?Q?nygugsUDTHjTzlOJQnIufFvrCDnDlTiNhd/csvrysl9W1F+bw0x66nQ0VRfH?=
 =?us-ascii?Q?lterXymWPpoUDPHupgXR2wTmHJihJMRVYYOMhy+f2CUxbdLazN6aHRX5lsBM?=
 =?us-ascii?Q?C6GS3poa9WVOJ/YLnoWpsauBzq5j5U8GcmO7okVTVWKP0xq79OTIgrPY1lvX?=
 =?us-ascii?Q?c4S7NKqEEQroPGPLufr8kRtkuX/n6Ud6PP2YxyblMSCVa2sf/kh94IVefvlY?=
 =?us-ascii?Q?Ytzn4HfZJh7NXNTeUEfCeBWgJMq4T4n5A7pzO2VHnIK+r5Jp27q2n0wN8bCF?=
 =?us-ascii?Q?kyPDbhFCtUibA26gIoCvkzUignJTMMsB62IXj7yluGIuJKSS2YOTL0DxHpLw?=
 =?us-ascii?Q?YbjZDMroBBPwT6td0ou+agcLHkKY4pkIOSOo2FMyAfDJ1HYL+GNW+t3GSmYy?=
 =?us-ascii?Q?KXkeCCXRL0N2uhmn7JM8tMcS5kTK+iEKCN0JBaCx0whdOI41zfQsxc2OMyIS?=
 =?us-ascii?Q?umD/0s62MA+qoCFtjbJCmR53?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4055
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 96f26064-5342-4694-c423-08d9352443f5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8x/vuub3lrf+Gr2tioTMIsxNjGR7YMt/UFz6rF0TgZ9Yysm0ayhXUySW1dGq+Q/FtkjNmJLWBEqxoN1AqarnscEoyt2nXDNrafyvOXXMvB1h6B0ZmHMCY5PS/Y+L1zw5uGzzEAjImFU7AC8sY7ply7tqiCxU80+Sp9hNet7O4YshLvm1hpVk3RftWd/0G3M+jDO2IZCwl8OnFwCrS/rGpmKKVIGvVnZvh1tNVnKIlyFpvMKvDVxrF+ZbzUIwmES9u45mhlL51LL4Grjp9Sf1C9fSopVKVIRPqjswtBVq+iI4e94u3JKBuapOQtuZL1JN8iAkNM6c/48JrKt6I2F0N8usTdGI2XPPWOVdyBHqBhg+P6TaWbV18C9HFWCHxTUohea9w42wcuCfoO2zKMZHrbO2hv7GNgaglj3zx7TtU+M4XPA8VR/ZEHAg3aCoKNWAcdfcacYTdbKKbA3Dy6VcBexDuvm5o4Y0FuxtAOuktXf4vAtv8eYS8HfngT1vr/MGmQZ6pbzsT/yFxShnGimCVL3KwFHUu1t2+Mdrh5BCiKC0JgM3mlsPJUZ7Wxnuro48/xeb3C0hbiKuPaGUuGGNdFwK5V1Dkkr+tz+9QsKGUyW3KQRfsrYsRDMCWAnC5d63E9artNRwFTdy+hgPBw/SMPfiBTULnBDgpVILNitCRGKbwEo9aacgw8svdGVUzXJuVMgGfGCLH4OlZzjE3NuuL89TOkysVnoTy1INgkx89Giz4SQ7qfKyIiTDaCID9oqsLugAd1vKDZ7YOvWBNS/rtw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(136003)(376002)(36840700001)(46966006)(83380400001)(82310400003)(450100002)(107886003)(7696005)(316002)(6862004)(966005)(26005)(8676002)(2906002)(478600001)(86362001)(33656002)(52536014)(9686003)(336012)(4326008)(356005)(8936002)(70206006)(82740400003)(53546011)(55016002)(6506007)(54906003)(36860700001)(70586007)(81166007)(47076005)(186003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:20:21.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d262cff3-6152-46fe-11e4-08d935244920
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5278
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Petr

> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Thursday, June 17, 2021 10:10 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>
> Subject: Re: [PATCH RFCv4 2/4] lib/vsprintf.c: make '%pD' print full path
> for file
>
> On Tue 2021-06-15 23:49:50, Jia He wrote:
> > Previously, the specifier '%pD' is for printing dentry name of struct
> > file. It may not be perfect (by default it only prints one component.)
> >
> > As suggested by Linus at [1]:
> > A dentry has a parent, but at the same time, a dentry really does
> > inherently have "one name" (and given just the dentry pointers, you
> > can't show mount-related parenthood, so in many ways the "show just
> > one name" makes sense for "%pd" in ways it doesn't necessarily for
> > "%pD"). But while a dentry arguably has that "one primary component",
> > a _file_ is certainly not exclusively about that last component.
> >
> > Hence change the behavior of '%pD' to print full path of that file.
> >
> > Precision is never going to be used with %p (or any of its kernel
> > extensions) if -Wformat is turned on.
> > .
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=3DwimsMqGdzik187YWLb-
> ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Jia He <justin.he@arm.com>
>
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -920,13 +921,41 @@ char *dentry_name(char *buf, char *end, const
> struct dentry *d, struct printf_sp
> >  }
> >
> >  static noinline_for_stack
> > -char *file_dentry_name(char *buf, char *end, const struct file *f,
> > +char *file_d_path_name(char *buf, char *end, const struct file *f,
> >                     struct printf_spec spec, const char *fmt)
> >  {
> > +   const struct path *path;
> > +   char *p;
> > +   int prepend_len, reserved_size, dpath_len;
> > +
> >     if (check_pointer(&buf, end, f, spec))
> >             return buf;
> >
> > -   return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> > +   path =3D &f->f_path;
> > +   if (check_pointer(&buf, end, path, spec))
> > +           return buf;
> > +
> > +   p =3D d_path_unsafe(path, buf, end - buf, &prepend_len);
> > +
> > +   /* Calculate the full d_path length, ignoring the tail '\0' */
> > +   dpath_len =3D end - buf - prepend_len - 1;
> > +
> > +   reserved_size =3D max_t(int, dpath_len, spec.field_width);
>
> "reserved_size" is kind of confusing. "dpath_widen_len" or just "widen_le=
n"
> look much more obvious.

Okay

>
> The below comments are not bad. But they still made me thing about it
> more than I wanted ;-) I wonder if it following is better:
>
> > +   /* case 1: no space at all, forward the buf with reserved size */
> > +   if (buf >=3D end)
> > +           return buf + reserved_size;
>
>       /* Case 1: Already started past the buffer. Just forward @buf. */
>       if (buf >=3D end)
>               return buf + widen_len;
>
Okay
> > +
> > +   /*
> > +    * case 2: small scratch space for long d_path name. The space
> > +    * [buf,end] has been filled with truncated string. Hence use the
> > +    * full dpath_len for further string widening.
> > +    */
> > +   if (prepend_len < 0)
> > +           return widen_string(buf + dpath_len, dpath_len, end, spec);
>
>       /*
>        * Case 2: The entire remaining space of the buffer filled by
>        * the truncated path. Still need to get moved right when
>        * the filed width is greather than the full path length.
>        */
>       if (prepend_len < 0)
>               return widen_string(buf + dpath_len, dpath_len, end, spec);
>
Okay
> > +   /* case3: space is big enough */
> > +   return string_nocheck(buf, end, p, spec);
>
>       /*
>        * Case 3: The full path is printed at the end of the buffer.
>        * Print it at the right location in the same buffer.
>        */
>       return string_nocheck(buf, end, p, spec);
Okay
> >  }
> >  #ifdef CONFIG_BLOCK
> >  static noinline_for_stack
>
> In each case, I am happy that it was possible to simplify the logic.
> I got lost several times in the previous version.

Indeed, the cases can be much simpler if we don't consider spec.precision.
More than that, maybe we could remove the spec.precision consideration for
'%pd' or other pointer related specifiers also


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
