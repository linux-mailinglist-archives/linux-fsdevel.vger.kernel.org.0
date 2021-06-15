Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB3C3A7797
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFOHIj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:08:39 -0400
Received: from mail-eopbgr40067.outbound.protection.outlook.com ([40.107.4.67]:27407
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229488AbhFOHIi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF1GaBxwlSm+4UG+yRGNjFQem/b6pO7/CbXSW/gSwNw=;
 b=jpJYNqaxWTw0AUvmkkrzqglPJ7FnlnXACz6+WhtEmMTKBFawWJuh79z6usQfrZxVKL5dL+b8c1uD0tudCFBjz7/HP4CFYcavYajZPFXQLjrRNsgSNTUY4Wxnj7OZBTb8VrQLthdJTOp88JhSY0X+sCSmrfnI6nb8iRtzAg5RZ3M=
Received: from DB6PR1001CA0031.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::17)
 by AM0PR08MB4148.eurprd08.prod.outlook.com (2603:10a6:208:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Tue, 15 Jun
 2021 07:06:20 +0000
Received: from DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::1e) by DB6PR1001CA0031.outlook.office365.com
 (2603:10a6:4:55::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 07:06:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT014.mail.protection.outlook.com (10.152.20.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 07:06:20 +0000
Received: ("Tessian outbound a65d687b17e4:v93"); Tue, 15 Jun 2021 07:06:20 +0000
X-CR-MTA-TID: 64aa7808
Received: from 68c4c8aa7b52.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0E61F9BE-8033-44FF-ACAF-4746897AAA0E.1;
        Tue, 15 Jun 2021 07:06:14 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 68c4c8aa7b52.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 07:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgnuUGzJjvilR90Gjdb/iUl+e+MtyvRnQuYiWWAJfiiR+7m/gq4xUbxf4zhiLmkOOSWYt4rKgMjB/meG4qA27eXyW4luP1hvZUGxekmJrEJT7s3FisgNK1DYEEVdqOmG810BgpOgGtXBeg/q9v81ntO4Grs4pPH5uY67GgKNr2aoN2UlQvA9ZZ4XpI1LsGHWxu+jN33BqXJ4MovOhd4VPwFvb6NeUhqwooTY0sgqfMumGZEh4RfoQvjUw6Rguprevj00oZw1M4f/IQRLUp8fCv8+8FRmn2M7hL14ZRbYNenuGer4r/azLSV6D0Vkg7wgzkGZ2GIP9bM4u7LTTmMUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF1GaBxwlSm+4UG+yRGNjFQem/b6pO7/CbXSW/gSwNw=;
 b=XuHtb0St7r6iPg5xk3vueW8i27RpMGPNidza2xOdaBK+8ouPxn2nQXqLXGZzSWUwq+NpsXoTioDGOBcf0+P/6y04xegK/U0nBKRYGPgBR9NUKJGEKX4ZWkQ1N6F1aenJnLrDjrM/LGivW+3zqQRu83k02uXLWpY7/l0bf9F/DX6gb5/gddVY2AUP2vdyRQL1LArqpdNCTePbxrYuNpo74nlC7fhmR+JCvefxI9nrkvO4RD2NZLTNs4sXnUfvM1w4jqi9YP0no7LPm5ezRVQ3rxhVVLuCKqytIDwGYzGfoyb361/TaYrZdlFegpidhgWvXXv7ciYHbjtdNDpTK22sUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BF1GaBxwlSm+4UG+yRGNjFQem/b6pO7/CbXSW/gSwNw=;
 b=jpJYNqaxWTw0AUvmkkrzqglPJ7FnlnXACz6+WhtEmMTKBFawWJuh79z6usQfrZxVKL5dL+b8c1uD0tudCFBjz7/HP4CFYcavYajZPFXQLjrRNsgSNTUY4Wxnj7OZBTb8VrQLthdJTOp88JhSY0X+sCSmrfnI6nb8iRtzAg5RZ3M=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 07:06:05 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 07:06:05 +0000
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
Thread-Index: AQHXXtr4yj2ZFiynnEqJXnMpAugWBKsPVv2AgAVSIdA=
Date:   Tue, 15 Jun 2021 07:06:03 +0000
Message-ID: <AM6PR08MB4376C7D2EEAF19F4CA636369F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com>
 <4fe3621f-f4a0-2a74-e831-dad9e046f392@rasmusvillemoes.dk>
In-Reply-To: <4fe3621f-f4a0-2a74-e831-dad9e046f392@rasmusvillemoes.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2A1E0A6DF4EA4549A77FEDD999E54425.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7cd2483b-0785-4ca0-5a81-08d92fcc1408
x-ms-traffictypediagnostic: AM7PR08MB5367:|AM0PR08MB4148:
X-Microsoft-Antispam-PRVS: <AM0PR08MB41480E0BBC9555EB6D2240A7F7309@AM0PR08MB4148.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 03Ku4CwA7tLzwxU5Sf7NLkDUqb+ZByoZQV9WL23BPNAobs2v17+Kj05uVPVGBmeDk2ZarFaAB+F4v2G84lykQTsR1F0lASHVMSd075QIENm/zBft6ebRJ2cZrnyuAKxAzZDa/Zg/PckmqxQJ9+3WQy4+1zJfoIX28iLq36/Cxethx7wcoGWdFEbTU4aS6JwQSGjmEmJcHm97iYnyuIrtykrOFCE+Yz+m+NLX3NpWuZYuE6y/QCQgvJdaff20f/+TuhslQ6drdHR6nC1nXQSqrZ95Hxhiy4ZubXie9eA8x73pJxGzlEPLA+YY6T5DqsXLESDnblzNNzmgNiBtHg7jV/IUUD4kiUDIZMuHu99vMyLwZhMpb+vX8bTuKeiJ9BYbbEKGH2HVeeA9AWXWMht4JeZjzy+F899WRimaZS3PhIbK4r44dRo5ssFMz2AyUkzavtpcY4V2FB7+hl51SY1XrpgwAmL1qHJWM6l50YAwb8LcATR8glukIZW9tU4YOeA63ApDyE6L45z1Fj4tERCjwJgo1X+xSJQQ5TqZIOdfu2kjRMJLhrf9mTp5co2M0UZmK24pxsSb/+sdyXutegf1t3ptnAtJF+FMc2lEWieNm0c=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39850400004)(7416002)(76116006)(6506007)(86362001)(66946007)(9686003)(110136005)(53546011)(316002)(55016002)(8936002)(186003)(52536014)(33656002)(54906003)(5660300002)(64756008)(71200400001)(66446008)(83380400001)(478600001)(122000001)(4326008)(2906002)(66476007)(8676002)(26005)(66556008)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B+DUxT/FvSnR1ARuDuVLIkwAHJ4NgHQtlmhKBfPMblTqD4Jb9k5RybjhbnRI?=
 =?us-ascii?Q?LHLXZAP55JwdT43HbPmBPwWyBZ6qLJXhlhVNT1AU6xJGA7LrvnIcdckDeTGX?=
 =?us-ascii?Q?+Xg8IakPNLJ2g4vQRRctBZ0J2EK3S7vVSgEQXaop5IbbSBe3uamc1NBrrNVL?=
 =?us-ascii?Q?KadY+YR7hMTmfpgxK0ndC21euRXp8oq8Zg2z4mJ4XZkOXwuTMcqA+OHeD02y?=
 =?us-ascii?Q?Uu0Z4mX7ziZsxR66UPchUhbVDGRMdlItTBSy2WskYpuNwl0r1tMY3ZzM6t26?=
 =?us-ascii?Q?NqX2KgUUaFOI8wMf0YB97wZTxWtyeV364EAlwsMU8pnhQH0HZD3EMNkTkwR3?=
 =?us-ascii?Q?rj1Q5ESFbAucWvPyahRiSbl5cXh1M+CfROqFyslxHMb1DCX7txqS/2W2wYnU?=
 =?us-ascii?Q?8hKDCQbu4wJWuTjCIOjbhUdt4F/Gc+viTt2/dgCy+sdJXedzWenx/6zC32sQ?=
 =?us-ascii?Q?aZjMXOQ9lqdvG2W1mGcpn4O/vnWgC4W3O7QJB0LkTJTC0FWMI2UsOzPHk2TS?=
 =?us-ascii?Q?QeAxsEf0s1sRYjcIwTouGgzKkD8U0ByEH9hSNsxME48XsjmDu1bL5nWmm4xN?=
 =?us-ascii?Q?m/6qqDI0CDYKGYB1L4blZzuXgwZ3d9hrQSU0DmXX3yBLiR4cj1lCzCZycQ0G?=
 =?us-ascii?Q?9kdOa5xM/2kYYFICl1RsQjnj0/sjlOclayrmfna88pcmb/H7Rf3iyBFl8SQ1?=
 =?us-ascii?Q?FNpWHD/HGrZnGe8hBnCBfksIfrY3tocCo5Dlhcoxi3tzadlNcXmHdMDLyYLn?=
 =?us-ascii?Q?7KLWJWBA/qpBaVHUut5S+JHX1oXRIe6ELo+cpiEY42TLVL+I0jU4Wzfo157g?=
 =?us-ascii?Q?tEXg6umbu9EAIJPa2JV8VZ1oleWJMo2UrKFVGwGmbOLsR1kXhSeKUbQmyazW?=
 =?us-ascii?Q?ifaoe2N5St5uC7on/pM8ihk58zBogSrCKn5d8yfA4gvwTtL/JwbdutONo/b5?=
 =?us-ascii?Q?Yto7JE9TXBQW7ZVevHvdogZI/BTbMpfKTqRPqh1OZY/tNrepJQiT8/XQRCo+?=
 =?us-ascii?Q?jvRV92vE+sbgy3j5QAgcBln5pBPsPJGXz3tRq9SCDV80bj3uV/AJi+W84217?=
 =?us-ascii?Q?rL4iPRtd6FfQzrUdeGpRAmyx4uC+2pNGC5p9JJpFEcqGBN7wSjRqJYiZVYZS?=
 =?us-ascii?Q?CTEr7rgRFhyuDWdQ4OnpwQaRMWoxLb/gz3Rur2wOCIvJWYeSAOMMoUm6VriM?=
 =?us-ascii?Q?5UfftTjX+57ZFqq40WxO2ZGRe7Tvd4OgVW71IEPvGmaUt0QfUiR1XDHlnXxa?=
 =?us-ascii?Q?mB7ffRFGsZrsI7XE0nKq3WXaPBQ5MBfGauMMN6W/k2WzV1EbnjWImO9ZP/dx?=
 =?us-ascii?Q?e/W8PPqdezqWfIzyUeE6yY9+?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: fb8b3ce6-9471-42a0-afcb-08d92fcc0acf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CIzYCBEHFqjvrhS2IlDcfaswVVUC2kuB9kvUIzJOqSwXOk41SWkgH0tktIBucxo4LhRY0BqCJ+WAE7UePdgau6LtnenKMDs1VO6C1XihDNey/GkEjBzMs0lVhrHcsMzpKWbsFB2Fx+dk0en+PduFlRsaysGlkJWiFDrNZwzrz3g5w+fPKsVrGZP8zT5hL3wwn9LXMNTSl4GoVmdyycmqbHiEcYGXRvTZB33JZ5Ij1ChoqBZDw5DliI+l6lR/bdfkx6o5jiTKpXlEDdzbJiNnAQuF0UkRwPQN0xRwCcNaZmvdmuIHEj8XaRc29vXqBrnjqEC3sloJ4q/AqnPF1kqfaoMUml7SArzkLLLmCnGQuupzsogeNJHR/BpXJOCyeCRlT5Omj6f6+jfhp7ZwSHpWVn1qbzz7U8DkjPEIVjxTPVqrMEsSawJgKdCn8wAk+By5Xaah0AvBQ1oTcqnd8JHamCe1p+bNx3ziZwVao/PaXJ4hOV/jC41aGNYCfi1Ii6Xw4jcIEs0Pcd1gdaIUgr3eHUl1EXpcULbUKBsXDPY4PU33bpYgWbmlXZsYzqYS5bTNNVyzmI9oENRmMX/tJp/UbIwuyX2LaQh0B5o10M24H8ZGo79Qs5E2N2FO8Dj8dQnQW5RkzbeCwBkfGe0UQxFsyMZD8+2kZxrysvBvzeQhQyw=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(346002)(136003)(46966006)(36840700001)(81166007)(356005)(6506007)(83380400001)(7696005)(47076005)(82310400003)(26005)(70586007)(70206006)(36860700001)(53546011)(186003)(86362001)(82740400003)(33656002)(450100002)(5660300002)(8676002)(54906003)(110136005)(8936002)(478600001)(316002)(55016002)(2906002)(52536014)(336012)(4326008)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 07:06:20.5431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd2483b-0785-4ca0-5a81-08d92fcc1408
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4148
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Rasmus

> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Saturday, June 12, 2021 5:40 AM
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
> Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
>
> On 11/06/2021 17.59, Jia He wrote:
> > After the behaviour of specifier '%pD' is changed to print full path
> > of struct file, the related test cases are also updated.
> >
> > Given the string is prepended from the end of the buffer, the check
> > of "wrote beyond the nul-terminator" should be skipped.
>
> Sorry, that is far from enough justification.
>
> I should probably have split the "wrote beyond nul-terminator" check in t=
wo:
>
> One that checks whether any memory beyond the buffer given to
> vsnprintf() was touched (including all the padding, but possibly more
> for the cases where we pass a known-too-short buffer), symmetric to the
> "wrote before buffer" check.
>
> And then another that checks the area between the '\0' and the end of
> the given buffer - I suppose that it's fair game for vsnprintf to use
> all of that as scratch space, and for that it could be ok to add that
> boolean knob.
>
Sorry, I could have thought sth like "write beyond the buffer" had been che=
cked by
old test cases, but seems not.
I will split the "wrote beyond nul-terminator" check into 2 parts. One for
Non-%pD case, the other for %pD.

For %pD, it needs to check whether the space beyond test_buffer[] is writte=
n


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
