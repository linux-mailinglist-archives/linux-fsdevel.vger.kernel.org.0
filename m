Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEC73A8334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 16:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFOOvG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 10:51:06 -0400
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:48099
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230079AbhFOOvG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 10:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocSGFtJjcIZd5TEEBQk9IsS5djrKOtRPCheazwFVUPI=;
 b=eP759qn5JXxwTYxMxcj6BHIAlKHjW5dRm0ZLteCrDWjt6PtvL4OEHZt6EORPiQcoDmE3Kuh59qi6JG2y+j98TpycrzqBtYUKGZ49Gu/rHNbJddZibk2bdZ53KK5z7UmhEjFF1JpLj38qsR2S5Blv6ODcQlyhzlZmWuT/vlffW0s=
Received: from DB6P191CA0021.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::31) by
 AM0PR08MB4292.eurprd08.prod.outlook.com (2603:10a6:208:143::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 15 Jun
 2021 14:48:58 +0000
Received: from DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::6e) by DB6P191CA0021.outlook.office365.com
 (2603:10a6:6:28::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 15 Jun 2021 14:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT017.mail.protection.outlook.com (10.152.20.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 14:48:58 +0000
Received: ("Tessian outbound e42494175638:v93"); Tue, 15 Jun 2021 14:48:58 +0000
X-CR-MTA-TID: 64aa7808
Received: from 595ca255bfb6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D746AB3A-D350-4649-A843-F1ED8106D9E9.1;
        Tue, 15 Jun 2021 14:48:52 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 595ca255bfb6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 14:48:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khBRV81TC7ObRpFNNUrHP+J4D+3QbBIRXAruk7XCG0xN+XAJnsXhMhqMt5Du6/sVwnh9RAv8eqq35kt5Rpv+PNn24wpulXwUlarI33xJzkhabultfvHkYenvS1lmXu7Nt9348pqLmO9xYHOuvDDWPcYcblEAeL/wDcgC/Zj+09gyLRjicRKefloslTm5u0geWctZTC/qZ3mJTm+qWa7CNiXck7yDs3De/4ARhS9Yb6MzFY7pFUz6sbMlcUG9LoIT+TrVbDVDzRj2tLsnarHq2nFYHG4iO8/Qg3QOmAU7EKEgWOXfnMzEBad9gd+KBvP0Q0MhZIWqpzL+LTcQCahUmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocSGFtJjcIZd5TEEBQk9IsS5djrKOtRPCheazwFVUPI=;
 b=UT535a0KCSsM7s5j6KvFq//tBy6LaGj87FoOxYyzO6/QqhtXWyjg7rhVqa0Ldm5rHsItBYiBpKBp4KcD4aHmsFPJt4BmDRFLoukQYYoo1Qeg+KG8cP6GCROWPtQDfVWDuKLm/MRXTVBOazJR2LsqZjRezF6Kp0qVXFahRWRLc3is267twXIjWhtiI1kvS95rA18iG42nlTlfAl7VX7D7Z4JfJEP1QavSFD6RUQBkczkCHHwrH6kdzkQ+R4vk0aIMjHxcDllMG5uyKV8PUvr3iHTeCIE/KbSgv9Jxm+i+7Vp1dAuc1DGXEuVfyAWp9lm6HyYnjwZx1mEDMHImeF+fqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocSGFtJjcIZd5TEEBQk9IsS5djrKOtRPCheazwFVUPI=;
 b=eP759qn5JXxwTYxMxcj6BHIAlKHjW5dRm0ZLteCrDWjt6PtvL4OEHZt6EORPiQcoDmE3Kuh59qi6JG2y+j98TpycrzqBtYUKGZ49Gu/rHNbJddZibk2bdZ53KK5z7UmhEjFF1JpLj38qsR2S5Blv6ODcQlyhzlZmWuT/vlffW0s=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4117.eurprd08.prod.outlook.com (2603:10a6:20b:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 15 Jun
 2021 14:48:50 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 14:48:50 +0000
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
        nd <nd@arm.com>
Subject: RE: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Topic: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Index: AQHXXtruU5AIb64vzESDK9b2+VqurKsTqaKAgAGCtqA=
Date:   Tue, 15 Jun 2021 14:48:50 +0000
Message-ID: <AM6PR08MB4376D4F902BC2F3F713D2FE6F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com> <YMd4ixry8ztzlG/e@alley>
In-Reply-To: <YMd4ixry8ztzlG/e@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 414B615C78E3AA49B6D8578E7852EE33.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [223.167.32.16]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4a9af40c-92d0-4b7d-28af-08d9300cb528
x-ms-traffictypediagnostic: AM6PR08MB4117:|AM0PR08MB4292:
X-Microsoft-Antispam-PRVS: <AM0PR08MB42926A95D9A029C883706F0BF7309@AM0PR08MB4292.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: MzkPlcjIaka2A5bgRKf4HXb2JIBODNdrt+R9+Yyd4hnYENpKDSsnqVD2bP6vx1jeAxt1bIqfUo5+W9tIv379QDQejeAw/e5QMNcbOviHRRctoJZUZknpUKTjLXXkD0RG+yiMt3LEXjBuYIpTxLPJbx9JN8rsPGWNGVRwQx57Mm1zuLR531slYgMJiKuE/WoXU4Tg1z6JbtYglCMF2I5RGqOUncCAaqXWkYRY5d4ZItCr9lDD+vkgzEtUrBVyLvT2qM9ihXtwrzdFQRI5RyVe/4CBGNOwMY3CZPYuMzvFmXQyoJkPgvVHhjiC2Yj700pe+Kc5mw5z1yCK7SEcUT85rAjYkiLJKIxpo0YRPfBpmAmlLYjuC8iKAqP71oB54q45jeJGTTlMvlWKQexhXl886Lki7PJyexKXDdCfisis1q/bpFi5CzO6J/ijD/V27uE2txgJ60Y9O91LrkqFNBO8OZhqt+GqTxKrMsbO2iWqbmzdF6nw9tTveGwxllMLFUXB6h+/OqoC2qKvhg0kCcugKNekbnakg5MqQBVkeKVSqysm5T4f0aavxIipPegO8ZS6f5/yuRPv2lPrsCMcsEQLeQadJBJsn94Rcj1jKjRWDLGyZOC1t9p24z14MN/98oAaryGx0fN1BBId2ElBj5sfaIkHLQ1aLDUpfvCovhx4qOnEUFv2zRPz5Er46Arfpe4qMxAiq1W/8Qx/xHowZzOoVzLSm/cwuzx1Ka56qmN62bE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(86362001)(76116006)(26005)(52536014)(186003)(55016002)(53546011)(83380400001)(6506007)(33656002)(6916009)(7696005)(54906003)(5660300002)(316002)(122000001)(38100700002)(71200400001)(64756008)(478600001)(66446008)(4326008)(8936002)(8676002)(66476007)(66556008)(66946007)(9686003)(7416002)(2906002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yftUEabD/tXqvaMpruxOwCz8S4OMhUs0qzT505FhQ66o+UU4YV52dWu9NNry?=
 =?us-ascii?Q?OjHjkshhIc9i5wfTHjbWkjgAMiFOyYzu0S3wrHT9KzsIb8b831cjalDdIBT9?=
 =?us-ascii?Q?znSA0Vf+u7Kn5CGasSQTHmV+VLugZ/NN5MVB3cvkSsmkkw+LE17sp4tfnTyU?=
 =?us-ascii?Q?VWOeuG9IUnJa1A0WNNu8L1YeAIj7BphC+dpOzioWjKrU0IYQyy5zXIB9tHEK?=
 =?us-ascii?Q?jkk4w/ZzRDtA0W9MKeAHZsQxI3/FEzz4jhylmEmgEZNERUa6yi52dAfQ+qzm?=
 =?us-ascii?Q?YbXVoDD0QXJ28AmUbpHuzeEGlDwLb3351yCoVS8oR2PqULvmaqVzWBaoTKkH?=
 =?us-ascii?Q?o5xXyycIru++xpwmUASGSaVQuawymoLKLNZTAJL1ve/47nC+lmxwNrs1i6Qs?=
 =?us-ascii?Q?lX3ImObTwd9RC+dQN9hJ7uoD94UR/+HcYH7LE2qm9ftiCu0AVcQyYls6m83B?=
 =?us-ascii?Q?s0cnorg9a6IMXjC5V8lWfW/HHobnPonaE4YG9tJOd9w2moXsEi672kfnZM1S?=
 =?us-ascii?Q?xRqn1r76ZLGqDo46EBjEU5Ux6BedIEw/sOoR75D6pj3cqniHvFSrdIXwnJCv?=
 =?us-ascii?Q?MjnPuqLzSi+coRaWIj5jghQok9Cu6RGfCSR9P9G/CwRecbtAlcZNsOl42NJD?=
 =?us-ascii?Q?T5g8+/ctCIzT3lS024e72WvcG5pxTNphbR0163uuXtKqiBbw03B4m1scGFq+?=
 =?us-ascii?Q?EClOnJ7VDwVJ2pmoZktmom3XOe6MYFest6l9altmrNNPoBZIOO/GPbkwNH2t?=
 =?us-ascii?Q?S4aBZAfaOdxE3Gv16GYGI8kA2zLfRS6cvA7qP0LcZRwgHk6CnGxCnM/KqZ/L?=
 =?us-ascii?Q?fj12u4Em9i9n+cnswNt364dFACy1FDh4/jIw054G5T4DfOfw/ZeeyWYr94Sk?=
 =?us-ascii?Q?e8l22R5RpEfSay8bSuuH3EeZv7s+unAH6eGmqFh2sgo1Cv0QjToFgHCVHPDj?=
 =?us-ascii?Q?x92VrvScgR0qfyHbao1lO6IQHkBCCftu2m4MauYRpEzdvtAN6yRlSHsdq2Aw?=
 =?us-ascii?Q?idHOX2sbBLKgn53xPXf00AwRriGHo/z5Op70A+GIgUI6f1m27aPaP6OZCHyh?=
 =?us-ascii?Q?QIwyEYmJCdlaphzOqa1J4ZtnK80ZCfuyry1kZ3RL3oIG2KWVdaKA4P/EABls?=
 =?us-ascii?Q?F+dz2LXOBthDTEhfDOMxea89irPWYk/OfOLnrDwB0ctbr1b1MGrh/3BXLjxL?=
 =?us-ascii?Q?pskiBLhLStA7BxwvYYqW/BVuotR3qrPKLE7VfO8uECJY5hWXTHlT82GR/Lf6?=
 =?us-ascii?Q?+PkEKl9NBlQfXpD0Hvw6VaCQt7olbryK8ag5r6Ps/gZC4nYLxAfrInWIiqRo?=
 =?us-ascii?Q?7QONHUFsMD8ORyO0M8GM79VU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4117
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7d798c5e-3a99-4955-1d6f-08d9300cb062
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhpT+zr3f41W4lvamdyJIqS+HasPS2pScwcNQO7ZStKY7bCgJL+3Qof6gxXevndaey0bAlP7jG1jDhVaC00mcKQA+km6d0m2FYTbXzLwqIAY5X2/CXoM1/004pAS3X+NduwCFHZBlon9ARb4OyPXlJPNDWutOf+gtZDVJW3qVSJ556JpT6uBLmXe6PD2xuy14F03uFP9MeDx8BeejM8iKVLKbIXbvJhs64uGdwjOvN6fjdLk9VgqehJsLCH/CRf4hWoR5qA5JBn4Gh+pXa2vjRhOpcXHmgmxV3m6kqlG8OyRvvKKe6WITjiKfh0tB2QkJmt72G7yWjc9pqiqT3DrMH9+dNfgpkSK/gfyK0g4W/W36mw7+8sX4niejO56eeVVaAVv07z3Hxhqjazq8RfWJlPR83XZoEK66tg+V9Vqhi0FlbpIJPAvGFcL1yN/j56jVjfVm0pEVeGTzcv1+62MypwXu5kWdXxVHrMskN17zbR7H0Nelb+YhwyOYbtkI8yfrkGjbzMXyI9y4q+75x2ha5JRm3/oPw08PqL3NRHe/0rMXNq+CdSwfXtjL2YlOvudI+3Qf2UVrfLIEQQPAi7sHTGTckpID4gViOS0FJny7k1LJAmyCLAM5p6z3DgIabWyaTMBkYO61SfB6EEWeTuEFcoukiHelAA+ADNk/jF+VVgRsqCo7P2Tu07WLOxn+O4j3cWRUzPDmVOldOclnl4dP73xozPzBb6pQjJqUSoXJodrvwG4BtE9iS2Po1zgvYI38L7wmOKKPT1YKpS1Tavqqg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39850400004)(46966006)(36840700001)(6862004)(8676002)(54906003)(4326008)(8936002)(450100002)(966005)(82310400003)(478600001)(336012)(9686003)(356005)(86362001)(81166007)(316002)(82740400003)(55016002)(26005)(2906002)(5660300002)(70586007)(33656002)(36860700001)(47076005)(7696005)(52536014)(6506007)(186003)(53546011)(70206006)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 14:48:58.6544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9af40c-92d0-4b7d-28af-08d9300cb528
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4292
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Petr

> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Monday, June 14, 2021 11:41 PM
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
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path
> for file
>=20
> On Fri 2021-06-11 23:59:52, Jia He wrote:
> > We have '%pD' for printing a filename. It may not be perfect (by
> > default it only prints one component.)
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
> > Things become more complicated when spec.precision and spec.field_width
> > is added in. string_truncate() is to handle the small space case for
> > '%pD' precision and field_width.
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=3DwimsMqGdzik187YWLb-
> ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  Documentation/core-api/printk-formats.rst |  5 ++-
> >  lib/vsprintf.c                            | 47 +++++++++++++++++++++--
> >  2 files changed, 46 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/core-api/printk-formats.rst
> b/Documentation/core-api/printk-formats.rst
> > index f063a384c7c8..95ba14dc529b 100644
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -408,12 +408,13 @@ dentry names
> >  ::
> >
> >  	%pd{,2,3,4}
> > -	%pD{,2,3,4}
> > +	%pD
> >
> >  For printing dentry name; if we race with :c:func:`d_move`, the name
> might
> >  be a mix of old and new ones, but it won't oops.  %pd dentry is a safe=
r
> >  equivalent of %s dentry->d_name.name we used to use, %pd<n> prints
> ``n``
> > -last components.  %pD does the same thing for struct file.
> > +last components.  %pD prints full file path together with mount-relate=
d
> > +parenthood.
> >
> >  Passed by reference.
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index f0c35d9b65bf..317b65280252 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/string.h>
> >  #include <linux/ctype.h>
> >  #include <linux/kernel.h>
> > +#include <linux/dcache.h>
> >  #include <linux/kallsyms.h>
> >  #include <linux/math64.h>
> >  #include <linux/uaccess.h>
> > @@ -601,6 +602,20 @@ char *widen_string(char *buf, int n, char *end,
> struct printf_spec spec)
> >  }
> >
> >  /* Handle string from a well known address. */
>=20
> This comment is for widen_string().
>=20
> string_truncate() functionality is far from obvious. It would deserve
> it's own description, including description of each parammeter.
>=20
> Well, do we really need it? See below.
>=20
> > +static char *string_truncate(char *buf, char *end, const char *s,
> > +			     u32 full_len, struct printf_spec spec)
> > +{
> > +	int lim =3D 0;
> > +
> > +	if (buf < end) {
> > +		if (spec.precision >=3D 0)
> > +			lim =3D strlen(s) - min_t(int, spec.precision,
> strlen(s));
> > +
> > +		return widen_string(buf + full_len, full_len, end - lim,
> spec);
> > +	}
> > +
> > +	return buf;
> > +}
> >  static char *string_nocheck(char *buf, char *end, const char *s,
> >  			    struct printf_spec spec)
> >  {
> > @@ -920,13 +935,37 @@ char *dentry_name(char *buf, char *end, const
> struct dentry *d, struct printf_sp
> >  }
> >
> >  static noinline_for_stack
> > -char *file_dentry_name(char *buf, char *end, const struct file *f,
> > +char *file_d_path_name(char *buf, char *end, const struct file *f,
> >  			struct printf_spec spec, const char *fmt)
> >  {
> > +	const struct path *path;
> > +	char *p;
> > +	int prepend_len, reserved_size, dpath_len;
> > +
> >  	if (check_pointer(&buf, end, f, spec))
> >  		return buf;
> >
> > -	return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> > +	path =3D &f->f_path;
> > +	if (check_pointer(&buf, end, path, spec))
> > +		return buf;
> > +
> > +	p =3D d_path_unsafe(path, buf, end - buf, &prepend_len);
> > +
> > +	/* Minus 1 byte for '\0' */
> > +	dpath_len =3D end - buf - prepend_len - 1;
> > +
> > +	reserved_size =3D max_t(int, dpath_len, spec.field_width);
> > +
> > +	/* no filling space at all */
> > +	if (buf >=3D end || !buf)
> > +		return buf + reserved_size;
> > +
> > +	/* small space for long name */
> > +	if (buf < end && prepend_len < 0)
> > +		return string_truncate(buf, end, p, dpath_len, spec);
>=20
> We need this only because we allowed to write the path behind
> spec.field_width. Do I get it right?
>=20
> > +
> > +	/* space is enough */
> > +	return string_nocheck(buf, end, p, spec);
> >  }
>=20
> It easy to get lost in all the computations, including the one
> in string_truncate():
>=20
> 	dpath_len =3D end - buf - prepend_len - 1;
> 	reserved_size =3D max_t(int, dpath_len, spec.field_width);
> and
> 	lim =3D strlen(s) - min_t(int, spec.precision, strlen(s));
> 	return widen_string(buf + full_len, full_len, end - lim, spec);
>=20
> Please, add comments explaining the meaning of the variables a bit.
> They should help to understand why it is done this way.
>=20
>=20
> I tried another approach below. The main trick is that
> max_len is limited by spec.field_width and spec.precision before calling
> d_path_unsave():
>=20
>=20
> 	if (check_pointer(&buf, end, f, spec))
> 		return buf;
>=20
> 	path =3D &f->f_path;
> 	if (check_pointer(&buf, end, path, spec))
> 		return buf;
>=20
> 	max_len =3D end - buf;
> 	if (spec.field_width >=3D 0 && spec.field_width < max_len)
> 		max_len =3D spec.filed_width;
> 	if (spec.precision >=3D 0 && spec.precision < max_len)
> 		max_len =3D spec.precision;
>=20
> 	p =3D d_path_unsafe(path, buf, max_len, &prepend_len);
>=20
> 	/*
> 	 * The path has been printed from the end of the buffer.
> 	 * Process it like a normal string to handle "precission"
> 	 * and "width" effects. In the "worst" case, the string
> 	 * will stay as is.
> 	 */
> 	if (buf < end) {
> 		buf =3D string_nocheck(buf, end, p, spec);
> 		/* Return buf when output was limited or did fit in. */
> 		if (spec.field_width >=3D 0 || spec.precision >=3D 0 ||
> 		    prepend_len >=3D 0) {
> 			return buf;
> 		}
> 		/* Otherwise, add what was missing. Ignore tail '\0' */
> 		return buf - prepend_len - 1;
> 	}
>=20
> 	/*
> 	 * Nothing has been written to the buffer. Just count the length.
> 	 * I is fixed when field_with is defined. */
> 	if (spec.field_width >=3D 0)
> 		return buf + spec.field_width;
>=20
> 	/* Otherwise, use the length of the path. */
> 	dpath_len =3D max_len - prepend_len - 1;
>=20
> 	/* The path might still get limited by precision number. */
> 	if (spec.precision >=3D 0 && spec.precision < dpath_len)
> 		return buf + spec.precision;
>=20
> 	return buf + dpath_len;

As Rasmus confirmed that we needn't consider the spec.precision,
the code can be more concise.
I will send out v4 after testing together with one test_printf patch
from Rasmus.


--
Cheers,
Justin (Jia He)


>=20
>=20
> Note that the above code is not even compile tested. There might be
> off by one mistakes. Also, it is possible that I missed something.
>=20
> Best Regards,
> Petr
