Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6B3AFB06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 04:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhFVCYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 22:24:07 -0400
Received: from mail-eopbgr60071.outbound.protection.outlook.com ([40.107.6.71]:57374
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231357AbhFVCYF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35q0VppHrtf2d0Xb4pjpBkfs5VxIx538K906Y/s6+bI=;
 b=qmwSURurYkkybX/mNS3j6TfCzIasP7OJGTxHONMSIQIE38RnfP5muPQZ7QikTdXj5dTr6HGuEiWOtUdZcjp1K5w/oU2xAhhf9L5j7BdF+kWJsQYkMkdkfa30LI5+9k2X3bxEcutbIaioOfnc9pnuYCxll1Ai4sDcrSQAo13q/rU=
Received: from AM6P194CA0048.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::25)
 by DBBPR08MB6091.eurprd08.prod.outlook.com (2603:10a6:10:1f4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 02:21:44 +0000
Received: from AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::b) by AM6P194CA0048.outlook.office365.com
 (2603:10a6:209:84::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 22 Jun 2021 02:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT046.mail.protection.outlook.com (10.152.16.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 02:21:44 +0000
Received: ("Tessian outbound 41e46b2c3cec:v96"); Tue, 22 Jun 2021 02:21:43 +0000
X-CR-MTA-TID: 64aa7808
Received: from 0cc1fed85e9e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 27218875-A010-4AF8-8F5C-AACC7873F8FC.1;
        Tue, 22 Jun 2021 02:21:37 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0cc1fed85e9e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Jun 2021 02:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMvmn11i6OgXHaO7J+VrjLjGCfST9sY1jtcs86H33QBP7TT3bmn6EYNrs7ehzRrVoqQKHJv9UOtkXUYn12ALvd/ga+FDZOVeOmnrLAExkXXH9dhou2osKD7W5EX1WgPAokx/ZU89ZwnpvARft8n2VMmj3VCVxWsDkVQOi+q5RU7j9HYWa+NTD43yzAkHKzqjXe9hfx5PszaGnjsQc1A1aGRJNntef6LzT3iPhZ3GjdNxQvhqKsCXRNv5V+PvRgrhuJfnJUcaBzAlvGdWJUMipNStVIrscGIkrHtzppGggqCtzTaeBBHICDq3TiYDfxQLtV7zeg0wspDgv8I2oVOaNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35q0VppHrtf2d0Xb4pjpBkfs5VxIx538K906Y/s6+bI=;
 b=W8kufdM1vrUiF/GUqQdwhMyvqsC4QK+DdtsDuZlt5ePDjz7uHQXaoMGnXIDbOJ3VR5LUlNsb2uhG4vePpu8HByCvuyhMNvmmTayH69PucSwplZ7yOXdIkFqszgGn/yGD4CmXMf5nVk96XCehKFa14zLSfoPE7bE+L3QuIEoBRte9fMiESmHxpM53hvie1eS+LY0sn9pu89JtvzZmW6uutZvFGc8qex6vI+WAaxUHDFHNkcDqlS78JeqqbtfiGLmICGFF5wV92zoaSdjLlh4bSDN4wxYs1ZGMlwUgBQbRsdoiQJNvRt4PLi+9/iyWFPBfybVvLAkMGHm0p/fe1pr3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35q0VppHrtf2d0Xb4pjpBkfs5VxIx538K906Y/s6+bI=;
 b=qmwSURurYkkybX/mNS3j6TfCzIasP7OJGTxHONMSIQIE38RnfP5muPQZ7QikTdXj5dTr6HGuEiWOtUdZcjp1K5w/oU2xAhhf9L5j7BdF+kWJsQYkMkdkfa30LI5+9k2X3bxEcutbIaioOfnc9pnuYCxll1Ai4sDcrSQAo13q/rU=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4055.eurprd08.prod.outlook.com (2603:10a6:20b:a7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 02:21:36 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:21:36 +0000
From:   Justin He <Justin.He@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH RFCv4 4/4] lib/test_printf.c: add test cases for '%pD'
Thread-Topic: [PATCH RFCv4 4/4] lib/test_printf.c: add test cases for '%pD'
Thread-Index: AQHXYf4uNW82+J1L3U6RrdvqeineHasVi1OAgALBmYCABwmdIA==
Date:   Tue, 22 Jun 2021 02:21:36 +0000
Message-ID: <AM6PR08MB4376FCAAFB6BF7914689C27DF7099@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-5-justin.he@arm.com>
 <CAHp75VeB68UUfz=6dO31zf59p6_5wGBX7etWJEV_xtLYsy=hBQ@mail.gmail.com>
 <YMthxzhHv7jeZKBJ@alley>
In-Reply-To: <YMthxzhHv7jeZKBJ@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 440D8916553FC845AF6D54E8F2DBA34F.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8459a443-7a0f-496e-e736-08d935247ae0
x-ms-traffictypediagnostic: AM6PR08MB4055:|DBBPR08MB6091:
X-Microsoft-Antispam-PRVS: <DBBPR08MB6091FF4B3B43774B1F1E0638F7099@DBBPR08MB6091.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6430;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: N96WvMOl05h69VThCcZwtgzseZMo2fw6UtMHgDgTtvTHM/ItjLTHWkM6MWwTj9tF/aogmhurCqu68xLPayPjbqjOjMOlaSyTgVZ6fZiSNycECYlUQyaK7Q7bvuWi/tWM9EthWbS+c3gCToxQFavoEgvSn5n3BSWFUUaASZftwfXc/8ylXkihUDC5jb/ABNhaIc++Qx/qRdyKxSPYkoERd0DTkLn6543qkbKq+iSxEJpcZV8AMbYqYfG9xFhjnLxmNvuF3XDwwQoinW9xLPD+QDDri1Jk073551xvknW0JnXV894seFwS/KaK+sGX+i+feDru/t+a3N4L4XGGNZUIU9I9Tpkw9BvrczrLo7EEAeO5iLyLh9BX4CMFfvjP3FywgUz4TmEyShVM9dRgoljQpZ+QjwXVbNaHNfktVzgLzUEo7GrNI88DJ314hGmVMDDN3Pkz0Peik/Lqly/cT80dI/gXpZuiMUhbft7mbnxgfLY725gbAJufz66rSqp7P7912y2M60J9WH7U5vnXvuks2NPpULymT4Yj/MeczxsV5uhkR9M9fphSxy1XHYTQykArS2je5XwodLKyL4Mcs+NHZgqWsNvifcr01jX/dr4/2Eg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39850400004)(376002)(396003)(136003)(7416002)(55016002)(54906003)(5660300002)(4326008)(110136005)(26005)(6506007)(52536014)(33656002)(8676002)(71200400001)(7696005)(316002)(122000001)(38100700002)(478600001)(66476007)(8936002)(2906002)(83380400001)(53546011)(66946007)(76116006)(9686003)(64756008)(86362001)(66556008)(186003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xtenMM7y7p3dwgsW6CKUZqnTMc15BoeMql/2EH60ChKmjIcEjE1arvbmRv5K?=
 =?us-ascii?Q?xoYWIzU/0KuHTi47tnN7eKVgBupPZ7eg2gWn77iEVkNNCDVEfpoTuLzbppnr?=
 =?us-ascii?Q?DG+Vt0kzbqGeH/cMdmWv51GmejIcM1R8BgZqDoPc1/NzVWPgiVdriHnzznxy?=
 =?us-ascii?Q?muvZy3BNis1yQTt9b618ilTCSvtH3VjKyHVrCc48f8yPbdiGFUrzEF4GcGod?=
 =?us-ascii?Q?cRJb8G1GUpRtFZVuuKB6zpgurf+E1UuGd6kXQmkXsqgJZXhO9rAJ+PQ23PiB?=
 =?us-ascii?Q?2cC3HDVK6jUh7cTvt9PkH/mIHNOtN9i9643xPeGFCsBAK3tSmnw1VCVWd0ww?=
 =?us-ascii?Q?sWtShSJXpKawLs+BNtvpPmFxIONyRtbPo6kywmqyfBQmtkJh1SRZWHwX2KP7?=
 =?us-ascii?Q?N+rZ/vRTYjBUS4lFzCF5gnWOiwh2NQ3YZf3lz41iR/FDBlRMyuSx/ni18nOS?=
 =?us-ascii?Q?rzWEZ3J4ynQ24Lr5URbOFMwzSjZcy/uNu3e18zbVE4TB6v9vc76UW18gDLeP?=
 =?us-ascii?Q?70Lyv+dW73s8AW7/y9nHzm8LS6lhpalfrQx6bGCj7dIy6pHsSalrOa7UYrbp?=
 =?us-ascii?Q?aaemauYm4uCPbBee9JmIIH5LOUdgN/JP7TRZbDZt00Xl0WTS9e6Hqn/V+HN5?=
 =?us-ascii?Q?ge15Lbx34nMP98qTlBc8gImhNsx41Irfy5RkjWRPoqC+SURTSkrihIIkQkD8?=
 =?us-ascii?Q?RR8E7wz6wNwcB3DolZUpZ2pYTbhuPXoM0hbsXp4G4rDfq9i3X6sRO+JMHQ31?=
 =?us-ascii?Q?KJhITD0DXThNmIPuibJvROsa05U/E7615ElOnR/yGkTt/jWsaLiyOducwRHQ?=
 =?us-ascii?Q?ktrcAc/mJxvYHkSq71AY8lyd1QFgc7ljuAssqkCMMkhyyegGG3woFjVYKE8+?=
 =?us-ascii?Q?3kfSx6jcedi7/8Ns2x71piesnzmyZCSDDT0LEP6VQBe4NGWsfu8v0SSjzM3E?=
 =?us-ascii?Q?EOmujNvO7ybkZuPbGsxEugK2jVN9SmmMp0PimHmMaGQw5WdFpJYA6+ezGWr2?=
 =?us-ascii?Q?oB//J/7AEcHjLkic7tlpfQuzr6FGI41XOyISXOnmijx+lNC/gRlg1U7OYJTw?=
 =?us-ascii?Q?uGmeFOZR3RSsRs7J2alD+qtJhV2iXRL4Qff3jyELK7iSCMC1zaxA2pMKDHv3?=
 =?us-ascii?Q?w822C1xFTsFV/y0nm9dPGk87lADXGDwJj+1mYbdpfOGQFbNf+Zmtx950ZkZw?=
 =?us-ascii?Q?Nsnn6H9RTXjyT2wPfu00Dfj32wc9FNs1E3ywaGZ7/xe3aG8Lb8TRuoXSI3jg?=
 =?us-ascii?Q?l3T8CZRdc9b/9YnPeB9awF5S7j8SedDMDEgv+R2vhI+3+VpOckiIu9sntPP+?=
 =?us-ascii?Q?FSbUaj+lpE4xxKdOapHOLN5f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4055
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c81d9863-e547-4c72-e211-08d9352475fc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KSJqmp1cbqf0tw/W6nmYBRLvP9mirHm5LqkCPcIlMqdmIxeWPW+wDEn6MOUdITVekJaomVshPAX9Dg2DjRAZXkSM/hpl9cVEYsXf+cNX6qrXYR0yKC5QMeIunXV7LtMcE+MaUm6eYe51Rf7lbr12n7F7ZcDUHoCVvCwOL+hw0qYj42nF9IVWGpb6HpscCVZ55DBy+jnulZc/eZhuFvzG6LM2NAlnzn2VchSCSuQEGiGUje1eGYaygNPhTeypxx3wJPG8qiHphhZUJligwrDIuVJib26MgzHhmtv9fL3niKgWs1ipbLMeb/g2IVDGA8i1ZT0SJMOZP7HyBPARDksGQflFpi+St6oeAy/4dthKWbst/u6DOFb4yr01ILTfhGnCVGhmtPCnbQGB7CL3XMhIs1/UAdNvkzRamqS33nZUCHRK40lSMohfqb0KJ4Vpw6ZvA4lVkqsJSaEt1o3ak//r+Of+nGfxC7DO9t5vCxObJ6d4CHbhsIHOPbzTfLHMp9oLqW9fs+qm61iWUSMNKs4U244i7RR9BouljJ3YFluitXNNW7L5AZCclRm5mhgZaiO80BDGYjQb1h+cQoWH1bRqBVv+Zdlm4l2eKqmRqhVE6d20/gtCtyFAxPakJeRQxDz77i3A+th5UZdBxM0KkGNwdOANUKLp1dF3LYfb/dV3dCE=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(136003)(346002)(46966006)(36840700001)(26005)(53546011)(6506007)(82740400003)(5660300002)(36860700001)(356005)(186003)(82310400003)(8936002)(336012)(2906002)(7696005)(47076005)(8676002)(107886003)(86362001)(316002)(81166007)(4326008)(450100002)(70586007)(70206006)(55016002)(54906003)(478600001)(110136005)(9686003)(52536014)(83380400001)(33656002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:21:44.5350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8459a443-7a0f-496e-e736-08d935247ae0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT046.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6091
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Thursday, June 17, 2021 10:53 PM
> To: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Justin He <Justin.He@arm.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> Linux Documentation List <linux-doc@vger.kernel.org>; Linux Kernel Mailin=
g
> List <linux-kernel@vger.kernel.org>; Linux FS Devel <linux-
> fsdevel@vger.kernel.org>; Matthew Wilcox <willy@infradead.org>
> Subject: Re: [PATCH RFCv4 4/4] lib/test_printf.c: add test cases for '%pD=
'
>
> On Tue 2021-06-15 23:47:29, Andy Shevchenko wrote:
> > On Tue, Jun 15, 2021 at 6:55 PM Jia He <justin.he@arm.com> wrote:
> > >
> > > After the behaviour of specifier '%pD' is changed to print full path
> > > of struct file, the related test cases are also updated.
> > >
> > > Given the string of '%pD' is prepended from the end of the buffer, th=
e
> > > check of "wrote beyond the nul-terminator" should be skipped.
> > >
> > > Signed-off-by: Jia He <justin.he@arm.com>
> > > ---
> > >  lib/test_printf.c | 26 +++++++++++++++++++++++++-
> > >  1 file changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > > index d1d2f898ebae..9f851a82b3af 100644
> > > --- a/lib/test_printf.c
> > > +++ b/lib/test_printf.c
> > > @@ -78,7 +80,7 @@ do_test(int bufsize, const char *expect, int elen,
> > >                 return 1;
> > >         }
> > >
> > > -       if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize =
-
> (written + 1))) {
> >
> > > +       if (!is_prepended_buf && memchr_inv(test_buffer + written + 1=
,
> FILL_CHAR, bufsize - (written + 1))) {
> >
> > Can it be parametrized? I don't like the custom test case being
> > involved here like this.
>
> Yup, it would be nice.
>
> Also it is far from obvious what @is_prepended_buf means if you do not
> have context of this patchset. I think about a more generic name
> that comes from the wording used in 3rd patch, e.g.
>
>     @need_scratch_space or @using_scratch_space or @dirty_buf
>
> Anyway, the most easy way to pass this as a parameter would be to add it
> to __test() and define a wrapper, .e.g:
>
> static void __printf(3, 4) __init
> __test(const char *expect, int elen, bool using_scratch_space,
>       const char *fmt, ...)
>
> /*
>  * More relaxed test for non-standard formats that are using the provided
> buffer
>  * as a scratch space and write beyond the trailing '\0'.
>  */
> #define test_using_scratch_space(expect, fmt, ...)                    \
>       __test(expect, strlen(expect), true, fmt, ##__VA_ARGS__)
Okay, thanks for the suggestion.


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
