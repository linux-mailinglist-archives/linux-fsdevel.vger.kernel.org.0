Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3C3B2AE9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhFXJEI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 05:04:08 -0400
Received: from mail-eopbgr30085.outbound.protection.outlook.com ([40.107.3.85]:47234
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229918AbhFXJEG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 05:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CUFKBgKol+2aUuCUgA4A4TXov8pObXw9GVLaebYho0=;
 b=ToYgFNw2+K8rhydqOMGuJaxf4tTxnfpVX5P3ZX5r16OEVRRxF18Yi9c0lW6e7xVRv4YPECUiSp5kW4I3/mAvo2S0v9DXG/ZA0pb2Et9FaN+G3fL0tBHJyLw0Qbcjc6/AnooKldC+CkQGzeL6MsPUOo/5L31xrYv1eENWVfCPqY8=
Received: from DB6PR0301CA0036.eurprd03.prod.outlook.com (2603:10a6:4:3e::46)
 by AM6PR08MB5220.eurprd08.prod.outlook.com (2603:10a6:20b:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 09:01:43 +0000
Received: from DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3e:cafe::2e) by DB6PR0301CA0036.outlook.office365.com
 (2603:10a6:4:3e::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Thu, 24 Jun 2021 09:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT044.mail.protection.outlook.com (10.152.21.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 09:01:43 +0000
Received: ("Tessian outbound d6f95fd272ef:v96"); Thu, 24 Jun 2021 09:01:43 +0000
X-CR-MTA-TID: 64aa7808
Received: from a738cc50c7fb.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6CE1BDA5-2217-4564-A585-DDDD0D6F9B6C.1;
        Thu, 24 Jun 2021 09:01:38 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a738cc50c7fb.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Jun 2021 09:01:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJRhCKsj5cDBOc/7Uk/05tXbMEhlDbOnfBSOXkhQdqwkj/eEFbu04EgFTr9EAJi7/djUsyyQduBUJ76gwsQzegT9gbgdxz+RrGL2bwJhTlUU43xvHMByNO1MtXzBQ2QWRY9CE2yr89Pg1WGRjeznAco4QdHbXM4KTsH2m+664oN2qk2ViLzBmgxHLgsTyTgoar6Im6DJfSsBqceDnbyMHe5ZYiMBJ6t+FCn2BrCjDJu3vA5glMiGehb+85COT12LtwepuWdT7oPcjFgDG+Lhuxwky6rxLEjjjPoQPNmrbpTqGabT0Im/oa8Oq3RMFpyZjNRyPDer2RGIOiRou/JTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CUFKBgKol+2aUuCUgA4A4TXov8pObXw9GVLaebYho0=;
 b=IDKeiacgh3P3IjUdeKpo3ibcMIpo3m6bWnh7tsvpJX3hfTmi8OEApCtZ0Jib1CgcH2VLaao5Bm34Xf9dnRFjKXhH6FlK4jJTW/Jsn+I6/NgXVuzzJcL+evnKfYIDEQ8/qnj82O2Nt5+zhifkcUWW85zQjext0mbju5dYXGx2fOXICGR/kBZVZ6bF3SCr8MMWE3SYDtuMtZuafVoja04W1qehVqGGi5ReCyyD747KfmNgTgrIZcsIvGXO5iwvWGlL5+rpMROYXxxx+0F+VYlwrVKO2XX+TyqLpx8LG8h56uIr0lYHPG+FxxVMrAJ9QU4fU3iMn5IthLhiV4wQn853rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CUFKBgKol+2aUuCUgA4A4TXov8pObXw9GVLaebYho0=;
 b=ToYgFNw2+K8rhydqOMGuJaxf4tTxnfpVX5P3ZX5r16OEVRRxF18Yi9c0lW6e7xVRv4YPECUiSp5kW4I3/mAvo2S0v9DXG/ZA0pb2Et9FaN+G3fL0tBHJyLw0Qbcjc6/AnooKldC+CkQGzeL6MsPUOo/5L31xrYv1eENWVfCPqY8=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3127.eurprd08.prod.outlook.com (2603:10a6:209:43::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 09:01:35 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 09:01:35 +0000
From:   Justin He <Justin.He@arm.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>
Subject: RE: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Thread-Topic: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Thread-Index: AQHXZ3ANHoFkUZUtCEuxzhYeDZbv9KsgGg0AgADSkdCAAe97AIAAApEA
Date:   Thu, 24 Jun 2021 09:01:34 +0000
Message-ID: <AM6PR08MB43769131732E82C094CFC293F7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-3-justin.he@arm.com>
 <YNH2OsDTokjY1vaa@smile.fi.intel.com>
 <AM6PR08MB4376D0AFBC0A4505280822FFF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YNRGgNOHUJp2vX0o@alley>
In-Reply-To: <YNRGgNOHUJp2vX0o@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 4E609364B95E924FA8D0B7113F11FEFF.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: b566b401-38c7-4f40-762d-08d936eeb03f
x-ms-traffictypediagnostic: AM6PR08MB3127:|AM6PR08MB5220:
X-Microsoft-Antispam-PRVS: <AM6PR08MB522086926E912D9B582DA48EF7079@AM6PR08MB5220.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: hzDGXTUlW2oLK6W74SeSDsZ0TdK1mwYXmMSev76+3LvPt2CE4SvCUYVKRP3wOd2zctrcFsotspAEZ3iTOVTXbJeMh79I/AbBkYyS8/oYIf0uB+dzIlFP4+yWfRYMZsNLYp5P8nFY3p1E/Um2CxGE2NLsGrvQVOIEaRGd+V+pff7vU832zDkB10f3A8rXmELh6D141BfZ3qj2wqfNbhJIGJPEgHIaN8HFnJ3yfEVCD3/r+KAHlcvYxRQpcOFneH4WcCMKR47z3lX3PwygEYtNAUMrqE+kMLkQAGY5lqKMYQzmrNVtNCQFWIP8CLqU74H6j6WZoY2kIsaswLE+ga5u+xJHV4dzSX8vfAsqpeSkVSE2jMiXVnMAhZ2BuK49o4BuQMkWIdyGPb7c+xtVP40lGQv+arwwI0SRACqFfnCTZKMb3TYaSz9bSoxwMtoLRAVMrR2s2e/sGQ0yZS7UBbMLdtgnGL4gHDU8+CHO3taG4zOMxAAZfYEEXaPbF6KmKyim2keh2/b+bRGoWS+qI+1OPTxX2xtSK9uSvmj8KAnlJYXZjaqLqxjp7eWpgVJ3nm9Z21g6uHn+Ob5W+FSOzZfr5W2wFMZiYSsvUVQdmeEUIgc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(136003)(396003)(346002)(376002)(55016002)(26005)(8936002)(186003)(316002)(33656002)(53546011)(6506007)(4326008)(7696005)(76116006)(54906003)(2906002)(52536014)(9686003)(38100700002)(8676002)(122000001)(66556008)(6916009)(83380400001)(66946007)(7416002)(86362001)(478600001)(5660300002)(66476007)(64756008)(71200400001)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?30mmb1yEDQsTB79UIxWm+OayycB3R6LdCGrDFnzdqcdun5xU20zKfhuQ+oad?=
 =?us-ascii?Q?IgFqj46wVtE0FQ5fBhKdWeYJiFCaL703J7oRCvLdNa0BDYQ1V4TRvYpK0wUx?=
 =?us-ascii?Q?hE47cOfabHs+aSTTMzyEAf48MTpwLjlTdL3w2Iu6Mt7BrIiFOogYQmmjT65h?=
 =?us-ascii?Q?g9I6bSB2grZdGuTiuU0fIchzFMrBZ6mOWMlw7pZd6rYwqOV2BEThfurLbjIp?=
 =?us-ascii?Q?5qr8t+xQl43bwFN+z5gnT3fzD2w88YpaeuZj8jLtMfbpItJ1OMZaepJCXVCR?=
 =?us-ascii?Q?3+WBwlr3wnb4Z7sCZmE3RjhgySjgN7R7q433ABp1mun+gSPCbgniTwiXE7Za?=
 =?us-ascii?Q?nTYNinY1foZuTaPSFWqEOOfC56XaEPv2ELXxmDV1Cr2lpilzzBs/7QeuRRoi?=
 =?us-ascii?Q?YaIPPfZHwkUO0mnE+53YCCI0eJB3aCdFXyccXC4l9x8Vta1fEU4PnWNrJCr+?=
 =?us-ascii?Q?8Q2IpE+0PU7gSbwzBbQYKHRzC0WNuIaNXKCfq2ZrYYhUebkD2g4rUa4mo+aC?=
 =?us-ascii?Q?bEZiE3JV6MblQofLYptzzWvfUjCUE7Tp8t15FK/F92JvliHMqoyh+nWx/R2r?=
 =?us-ascii?Q?4oeaYnqpJB2sCnLBe0jj7p9UqiN/U8P7XZ5ryKFnq8PS8t3NGmag1l75V/Ck?=
 =?us-ascii?Q?nIeXi7R3iuqC19A76039FC8+x/z0eZB76hqVcLpVm5VFEtjvDRq7IuplR/mt?=
 =?us-ascii?Q?Ku4KJhk6K23QE+kCPi+fEjQn3FIzlvyPazrfkZHWLw5ADH5tJ7O4TkbOteNO?=
 =?us-ascii?Q?49MGNNuhznV6x3wF4XDDx/C8FH4ItfbG91SR/4hps3rf8BTOLb6haR9wYukk?=
 =?us-ascii?Q?N0WPRO2XpTof6WyUjnIL0ZwnmbEOF+/J8Ma+AxBiTOtC1mx3zuxd+hcnL+QV?=
 =?us-ascii?Q?mBhs7Z2ga99K3KljndVdTuWgKdZpHhfLbV6fc1C/LwNlchJiXZaXCLx9rVu8?=
 =?us-ascii?Q?+dSUnhtMTLrCs05wMhvz2AZqNcuoFiE7syoJ91IU6vjW0VWH9aFFF2v/+a5X?=
 =?us-ascii?Q?c41/p2WP3KlFNkZtGjq7dZh7r5pSxrZ+Dj8w82VwRnINlXxvFXjHzGRZYvst?=
 =?us-ascii?Q?8GDtE3K5Pr860zH98uNGskH40YZgVPn26o3LpbvxotckLdfbHAE47MYGVSG1?=
 =?us-ascii?Q?1ZOdYQDmHzBFuBYyQlUHMqgGWwljKUpXcgMTFY7pM5m2JdxUsQRpRapKNyHC?=
 =?us-ascii?Q?JEsgvOifhElQQ5jP/vkWCzzwHUlBtpxd5dsIBUybLtcrTDBoWjhx6C6ULVUD?=
 =?us-ascii?Q?Efz/FP9dwyAYd02nkmB+xr/WxcCPqCdn420gAVdPjCQ6mbTk1WKeybM9H+Ms?=
 =?us-ascii?Q?za2qWG9YWwxdw607HR3QDMnZ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3127
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a8625570-d6be-4c63-8032-08d936eeab1d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1saCk7yImtXX+vfF1OuqGzVwtgOh27DnxFFp+rk2f93i+6G/eQFVlwm+bWp7Ef+dTF5iBbFwYlX98mNpLqfKWGP5vTwdG5m45Oq4tLepVLjPJPWBCI3FIiT7QgQxCXzNbSdgEXDLEiQdl2bbtZTh+kYea4kdg9DBTH/a+c45qHiI4piTq15bMtJDvmLsEoprXBOPlHHEsF2+QkG3t4LGq4ZHkBjV5Y+V6rLlMOhbe7fRsg3U5P4Bog6Crk2nKBZQWfcda5gQGE4Ucl1SV7UBkvihbolYlgc3AS8FJTumW5aGXWoi4uPF6NmHjD8hJLDDOjb/t93du2PN/Z6Yn6xSKls0RwuFXQTkU7GXnFX/ldmdOpcnmkZa9Yy6R+Deng144ZVyfbjrJdFyxBKNdyHLXSGEIVgWyg0CUGGO1a2kF5WJhKyDr6y7i2YjcZGorq4Tn+4ySNYCPB3C8NJrJHW2C4RT8/PelgCptZbnSlLgssUGSyqlabosfN/WDAdZTHwVHw2+QOwbtIBYU2uvmqqZtkPGr1Ip217r3q3cwNhJl0oianoxvw5der7EAhafS8KR/6HlLn5qcJHgLR/AGCtEuMQn3kSo4LX4upC+jRa7n6R8M9wsVj17lVFa5wUw94I0pJbzjfgP+rddi9b7XcYRjyAsXjqltyS/kXSzdrlpmfqM7yAZM69rGULk7f3LYkKkrpPigHd1x8XYFaiH5oZCng==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(346002)(376002)(46966006)(36840700001)(26005)(9686003)(70206006)(6506007)(53546011)(478600001)(186003)(5660300002)(82740400003)(81166007)(83380400001)(356005)(55016002)(70586007)(450100002)(8676002)(4326008)(336012)(86362001)(82310400003)(54906003)(7696005)(47076005)(33656002)(8936002)(6862004)(316002)(36860700001)(2906002)(52536014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 09:01:43.6571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b566b401-38c7-4f40-762d-08d936eeb03f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5220
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Petr

> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Thursday, June 24, 2021 4:47 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Steven Rostedt
> <rostedt@goodmis.org>; Sergey Senozhatsky <senozhatsky@chromium.org>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; Jonathan Corbet
> <corbet@lwn.net>; Alexander Viro <viro@zeniv.linux.org.uk>; Linus Torvald=
s
> <torvalds@linux-foundation.org>; Peter Zijlstra (Intel)
> <peterz@infradead.org>; Eric Biggers <ebiggers@google.com>; Ahmed S.
> Darwish <a.darwish@linutronix.de>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org; Matthew Wilcox
> <willy@infradead.org>; Christoph Hellwig <hch@infradead.org>; nd
> <nd@arm.com>
> Subject: Re: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full pat=
h
> of file
>=20
> On Wed 2021-06-23 03:14:33, Justin He wrote:
> > Hi Andy
> >
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Tuesday, June 22, 2021 10:40 PM
> > > To: Justin He <Justin.He@arm.com>
> > > Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt
> <rostedt@goodmis.org>;
> > > Sergey Senozhatsky <senozhatsky@chromium.org>; Rasmus Villemoes
> > > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexand=
er
> > > Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> > > foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> > > Biggers <ebiggers@google.com>; Ahmed S. Darwish
> <a.darwish@linutronix.de>;
> > > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > > fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>;
> Christoph
> > > Hellwig <hch@infradead.org>; nd <nd@arm.com>
> > > Subject: Re: [PATCH v5 2/4] lib/vsprintf.c: make '%pD' print the full
> path
> > > of file
> > >
> > > On Tue, Jun 22, 2021 at 10:06:32PM +0800, Jia He wrote:
> > > > Previously, the specifier '%pD' is for printing dentry name of stru=
ct
> > > > file. It may not be perfect (by default it only prints one componen=
t.)
> > > >
> > > > As suggested by Linus [1]:
> > >
> > > Citing is better looked when you shift right it by two white spaces.
> >
> > Okay, I plan to cite it with "> "
>=20
> My understanding is that Andy suggested to omit '>' and prefix it by
> plain two spaces "  ". It would look better to me as well.

Okay, got it


--
Cheers,
Justin (Jia He)


