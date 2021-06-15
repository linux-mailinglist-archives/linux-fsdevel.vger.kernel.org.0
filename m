Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85413A7749
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhFOGpZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 02:45:25 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:53428
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhFOGpY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 02:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPDId27QP5/uEj24RHOf2Op+lL80DJ0aq73TFCmdv3k=;
 b=v18rdJWBKvIbnPpV1E8K+F+lDCFZrPixeTnfXibOjvVit5laXBdQMl2fAP14nmFHP0l18kT/Z3QFMS+9a2PHpGv71RLsBlVZyGdXJR4/LukpFsWFBWoQYD+pN0Nk+qHm6zL4brMs1LABvi5zcOQ8XC35QnnsDBYkkf0DleC2z3g=
Received: from AM6P194CA0067.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::44)
 by VI1PR08MB3152.eurprd08.prod.outlook.com (2603:10a6:803:3f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 06:43:17 +0000
Received: from VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::6a) by AM6P194CA0067.outlook.office365.com
 (2603:10a6:209:84::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 06:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT011.mail.protection.outlook.com (10.152.18.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 06:43:17 +0000
Received: ("Tessian outbound d5fe3fdc5a40:v93"); Tue, 15 Jun 2021 06:43:16 +0000
X-CR-MTA-TID: 64aa7808
Received: from a37f4d004f9a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9014E2AB-EF4F-4015-BCC4-8E221CBCA2C3.1;
        Tue, 15 Jun 2021 06:43:11 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a37f4d004f9a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 06:43:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwyHuDeYjTt3p1Nb5eki3OKgTQWSEysd2DNxH5FNhmhlCOLftWWbIZuFZLIvw+W2JUhY+s2LzNj4/HSjez6smRWf2bGj9Kbv4Askef/0uvwuGSUTXnGYYrfHozbb424UwSQsfXxw5cR1U48hAi21FBkq0/1hiinbKOFIJ+fY48GLHP04o885P4PCV4hsfykweKAsaI1xv4BxUWfCSlpN91kQY7I2pW1ECVqsCfAKwLov7Jz+vQgn/1Ne2y7fZDDdkFC+pFFwcDijPXVyHnlRFYRaeG1pGnnplJOMDAkXn+YAesyDlKHROhkaCVTAzpmQBsPBHGsCV4L3Q2FrY34FwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPDId27QP5/uEj24RHOf2Op+lL80DJ0aq73TFCmdv3k=;
 b=mvLSbcA5CU9jR7lzUZfM5r+UGIXOvX1f0Xp2P/35tX7o7oankaik0vu2pyU+fC8+BN96Z9RzAotd6QnGHF0QCnV2nEu/ttl5AhHR67hyCoiXwCcSXH8oLPa+pMTHJVwT44m1m9BKPrDQfJSeTcHpwuyQeHZAEVGgh7u9Te0BCckUb2Kqf5AoWV0Ay8SwfL5/jerCTHCHJ+dYNm5EQVUPethmc7HiS421BvAreeNF6mooBzhgXGxK78HrKaowZKSb9ZoCjCQUnq+4PkXnee2PJmS3QEQvTwKhLFMfXKn5PTQk3I8+bKafR6GfwLGBPOa557jOyjaKe3N/sruzb1EWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPDId27QP5/uEj24RHOf2Op+lL80DJ0aq73TFCmdv3k=;
 b=v18rdJWBKvIbnPpV1E8K+F+lDCFZrPixeTnfXibOjvVit5laXBdQMl2fAP14nmFHP0l18kT/Z3QFMS+9a2PHpGv71RLsBlVZyGdXJR4/LukpFsWFBWoQYD+pN0Nk+qHm6zL4brMs1LABvi5zcOQ8XC35QnnsDBYkkf0DleC2z3g=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6823.eurprd08.prod.outlook.com (2603:10a6:20b:394::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 06:43:09 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 06:43:09 +0000
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
Subject: RE: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Topic: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Index: AQHXXtruU5AIb64vzESDK9b2+VqurKsPU6qAgAU5OEA=
Date:   Tue, 15 Jun 2021 06:43:09 +0000
Message-ID: <AM6PR08MB4376F90B594C5134302A830AF7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com>
 <35c35b55-3c58-59e8-532a-6cad34aff729@rasmusvillemoes.dk>
In-Reply-To: <35c35b55-3c58-59e8-532a-6cad34aff729@rasmusvillemoes.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 70E2B711D04DC14C8BF695F8BEABD92F.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 08fc79b3-71ad-4148-2cb9-08d92fc8dbba
x-ms-traffictypediagnostic: AS8PR08MB6823:|VI1PR08MB3152:
X-Microsoft-Antispam-PRVS: <VI1PR08MB3152883BF172E7784E2B81A0F7309@VI1PR08MB3152.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:2201;OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8CwlUj4BUuhdAeBdXhv96bVklAEygS6KpyV26RNySfqwgvyHlvRk1vYRgVi0xZY1JjwF6IhPcjpCB08OZmNnx3zBByNHfA8+Yy8JFfJBbGKzQd6M9mcoE+Zt5t7fsa6tdM4n6llVUkcCL0Fd+eVClB4/tw9FseQUw5e+GWEif63tKSKzfBjLzh+ZIqXr4SPR6B4/Hxxvq/LlQAP/N1Se+KcIdzTY/GP4MAPyoFC/c4s0mpnq5SpZpCMfIHnKSrf6EavitS+4U6B9KBRCqaQNHj/O016R/KAJZcK6tplSHVUbOYdihefjtMwR5gU4GR0v/XYC+kdztZIEYz42BT/irLOWoM0MV0l6LjRlZw9+h1rJQuKfnp0+q9/7SBhSaC0OTRASfNIwcDuDID85GNLN/fhmcpoBaNMeTWe/+KgaDuqa13NTvYCBn9M5XAU9/pj/wSHMze0zOgZqYfrSO5f/zFnUwIfsApOWaZ2szt8xRBrhNnfpLmXmOoZ+ui+LA8NRzfihVXkXubsGavF6/5yujvHH//IUrc2G+uv98Y7dWj4WdCxHVsYbSeMzEqwAOg5mptx1KkkmbjU59EI/+PJiSs6of62XPCyFMOT4mxcfFudaRaRA/lZDGESmYKoInPreLlLAsFOsjtpdgxWjbuKFv9df9PgLgq1+PhgtC/PhIi+sXfvj3vQ9Mnnuu/7zo/0yFPElybs5YAN7TDmDY0yQxFiVNsznJxVM9lQ0UtaF5AQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(86362001)(54906003)(316002)(9686003)(5660300002)(4326008)(83380400001)(122000001)(8936002)(110136005)(53546011)(38100700002)(478600001)(7696005)(2906002)(966005)(6506007)(7416002)(186003)(66946007)(64756008)(66556008)(76116006)(66446008)(66476007)(26005)(52536014)(8676002)(55016002)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HVAuZY5dGK+Rb34SkSf996VFegQmEMYcY6QiTprKs3j0lvuoKJriDcpVkwbs?=
 =?us-ascii?Q?K/fQJed2IGUQWo2qj5cgOnhTU6CDUquf7kSb5cckE1ygaQn0eRCrYwlnEwyK?=
 =?us-ascii?Q?eK1NFbejJDVoGN6XquDNsklRUDrhtOXJu6uXnx+fkJA8o7ZQb8iO2RiJUldN?=
 =?us-ascii?Q?6GpjuBhaiUgapjT18VocoIgR3g0X8c/w6yh06Fa6X6skTPfgo2XkZxJgLT+J?=
 =?us-ascii?Q?WM6sw4ZaI04BjBuhqMHFIFYoYJoKQjiB9aoKiKaCwG/LEADXy/DsHducbhFa?=
 =?us-ascii?Q?AMbB3UhP2iXGDnD6zht3gJwtpVuzbxg3C1EkK6SChLWRP9ress57agLwxGDF?=
 =?us-ascii?Q?LS6leYhYf4dgqdSs+qDZE41bYrVDFIxkZgH61akZX0hzmmXT/p0/rqNLKRhM?=
 =?us-ascii?Q?ehSn8flu6WGxSTUPmIh4NsXJRsjsU3ny+IjcBY5dz6j35KhynMWdc63WfDIw?=
 =?us-ascii?Q?8tOaA5vJs2k2IG29Olp0fE7dtrLryggI9wpadGIhVSKfLtx7cqQo56ko9Q1V?=
 =?us-ascii?Q?oO6dpkSfTAF2/QzAkZP3LnUEaerYQFkCHDygoALDSglZ0SU/Fw9V6zTwty+Q?=
 =?us-ascii?Q?FKD42/AlSa6p7q/HN+NdyB77V2B/EYRFPClszigQEpcxgT3fL205hgX72xtb?=
 =?us-ascii?Q?wbc0bp8p/W91N8fMZVH99668z8EdtLcMxfdyklxOIYyAl4nmT43a3QPH/lah?=
 =?us-ascii?Q?UfIX3ZkHOa2aKL43QIZFjT6Mt2a2jGYnHtIvPJDdPYXYyoXAuIme1Ht/dOV8?=
 =?us-ascii?Q?9UtYDyKz4b5dJyWygxGma0cfwvCcGqQR2ke99YuuntzAvD31ZGCZCFGOH02W?=
 =?us-ascii?Q?sn3TTpjMdbnQ9ZR634BiF7HuaO+MKv89kia6Lh354NAf/ABxPoig7fG3z3Tk?=
 =?us-ascii?Q?d0+CxQozLyjfnSgZVprkY+HVz8+3xmCo35uMuDv5XS2xBLK20nS8OCbI6Vqp?=
 =?us-ascii?Q?A+ur8YyR3vdGLVhUX3F08UPqUOyL4GLqft7vEaYjlBKJUJYUbKkJP4nkR+HW?=
 =?us-ascii?Q?z6E1KnokWGLPxIDk8UL/N7rtP9cTnjk6StMdysXhxT+SSd9uFEVcv8NEd37w?=
 =?us-ascii?Q?n6/fiERekM/ko5655hfoYwLLC/2ORbvwKwFnBPhnhmj1aopirayOKQrA7yF7?=
 =?us-ascii?Q?McPRf7q06NktM5lVIWPCoUB2NTlX7VyGEh24+wifJH8RsF4eQUatMG+1BY9x?=
 =?us-ascii?Q?oa90GIAe2ZdKf3ukb1pTcT/Lz7Mn1FHmdgiC7BqQvNKhDq1M6PybTkLQY868?=
 =?us-ascii?Q?SVDGWN/QKpBqhXAqVgj03S43DhqV/xLJ+Qp3W946wIE3np+/2yqLqbC9e7aG?=
 =?us-ascii?Q?kCvbsyrbJWkQJB3SlyLjzGSn?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6823
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 458ad146-203b-4c71-e627-08d92fc8d6db
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IGkw4Vi7V2I0rKRRtu62lY8OKKpLTg69iSm+LOewg7icuf29c4tRFjF5dAAk6zoyehI4Kfb6CLNSVbJTqvx66B26O6uSe7b9IZyMPKX1hMpiIOlaQXSXKWWFB4W3uOS5nb0dDJ7aBx8WKCPudgqgH4K+R/7d5Iw6+51NtMW/GFyJFjukShybi13XCSJAKEb29ATQ4ZBnTTvyiwla3woPXQ34iK0YmqvdIh03IHS0BEzsxRLDwEjNslkoTS2L/f0w9M0Ch8A/KjcRRZerUfH6bomJPALUAoVqCz5TQpaUI79Wme7A8BRZ1Cw+bvIzrcZbhrnwklxCRg2A+0dzfJRSjdAVSqZBWi+HYXCOLPS704apYeeyAo2ftZgdMAbM9DIhIAnV7XSC0JGihRgJIkv1fkcI+uWVWvKFMMhh1NgygkBA1biq5fyv5E0x/gzx+bTVSVnjxqXvxqawFAwLwupClPoTcfxAkGtp/OHRNnsuJlAF8LNlYWxQLRWXLZSJZ1q6w0JIYqOMeKdRuNIhB6/hHe4PVLbyb1rqnRNA9zewrDRH+tfGiJjpn8JHdL/WbSBAxyXQlLyYPmlDX0Jp3PVV03zqVLqIugEUXPwZ7APiGZYjTG5O+W64dUljc3nqD6uuEisim8bZjbir1N84d75506h83z4w0DC0kRoH77onwwofQ8h147W8oRCwYvJMuurjzwkMnnY8/Wo3HngyUBRGVmBTTWC4FRUQwCbhSVKPGZAxRfarIqMoGL9jaPVf3GIqPYxx5SJJ59/zIIs9scH2JA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(86362001)(336012)(5660300002)(83380400001)(55016002)(966005)(478600001)(81166007)(82310400003)(186003)(7696005)(26005)(2906002)(82740400003)(4326008)(36860700001)(47076005)(9686003)(8936002)(6506007)(316002)(70586007)(53546011)(8676002)(450100002)(54906003)(52536014)(33656002)(356005)(110136005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 06:43:17.3662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fc79b3-71ad-4148-2cb9-08d92fc8dbba
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT011.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3152
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Rasmus

> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Saturday, June 12, 2021 5:28 AM
> To: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
> Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Jonathan Corbet <corbet@lwn.net>;
> Alexander Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
> <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path f=
or
> file
>
> On 11/06/2021 17.59, Jia He wrote:
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
> >     %pd{,2,3,4}
> > -   %pD{,2,3,4}
> > +   %pD
> >
> >  For printing dentry name; if we race with :c:func:`d_move`, the name
> might
> >  be a mix of old and new ones, but it won't oops.  %pd dentry is a safe=
r
> >  equivalent of %s dentry->d_name.name we used to use, %pd<n> prints ``n=
``
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
> > +static char *string_truncate(char *buf, char *end, const char *s,
> > +                        u32 full_len, struct printf_spec spec)
> > +{
> > +   int lim =3D 0;
> > +
> > +   if (buf < end) {
>
> See below, I think the sole caller guarantees this,

Ok, will remove this check statement

>
> > +           if (spec.precision >=3D 0)
> > +                   lim =3D strlen(s) - min_t(int, spec.precision, strl=
en(s));
> > +
> > +           return widen_string(buf + full_len, full_len, end - lim, sp=
ec);
> > +   }
> > +
> > +   return buf;
>
> which is good because this would almost certainly be wrong (violating
> the "always forward buf appropriately regardless of whether you wrote
> something" rule).
>
> > +}
> >  static char *string_nocheck(char *buf, char *end, const char *s,
> >                         struct printf_spec spec)
> >  {
> > @@ -920,13 +935,37 @@ char *dentry_name(char *buf, char *end, const
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
>
> If I'm reading this right, you're using buf as scratch space to write
> however much of the path fits. Then [*]
>
> > +   /* Minus 1 byte for '\0' */
> > +   dpath_len =3D end - buf - prepend_len - 1;
> > +
> > +   reserved_size =3D max_t(int, dpath_len, spec.field_width);
> > +
> > +   /* no filling space at all */
> > +   if (buf >=3D end || !buf)
> > +           return buf + reserved_size;
>
> Why the !buf check? The only way we can have that is the snprintf(NULL,
> 0, ...) case of asking how much space we'd need to malloc, right? In
> which case end would be NULL+0 =3D=3D NULL, so buf >=3D end automatically=
,
> regardless of how much have been "printed" before %pD.

My original purpose is to avoid any memory copy/move for kvasprintf->
vsnprintf(NULL, 0,...). But as you said, this can be folded into the case
buf >=3D end.
Do you think whether following case should be forbidden?:
vsnprintf(NULL, 8,...).
Sorry if it is too verbose. If above invoking is valid, !buf should
still be checked.

>
> > +
> > +   /* small space for long name */
> > +   if (buf < end && prepend_len < 0)
>
> So if we did an early return for buf >=3D end, we now know buf < end and
> hence the first part here is redundant.
>
> Anyway, as for [*]:
>
> > +           return string_truncate(buf, end, p, dpath_len, spec);
> > +
> > +   /* space is enough */
> > +   return string_nocheck(buf, end, p, spec);
>
> Now you're passing p to string_truncate or string_nocheck, while p
> points somewhere into buf itself. I can't convince myself that would be
> safe. At the very least, it deserves a couple of comments.

When code goes here, the buffer space must be as follows:
|.........|.........|
buf       p         end

So string_nocheck is safe because essential it would byte-to-byte copy p to=
 buf.

But I agree comments are needed here.


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
