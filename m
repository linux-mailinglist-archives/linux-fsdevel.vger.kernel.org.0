Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087DE3A77D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFOHUZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:20:25 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:13579
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230190AbhFOHUY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMNmTvJnHlQJ2SOOBsg9JbwhK7HJmgKyr0uUhFcbOik=;
 b=7SSGBobFwzuuk5dvGYurS5PcyGi0k/aKoQofAS+QtxmamoImwbw0YOKyp1nX5Hvz2ayFpNNNlnMp10nghKLYsOicIJPZzRnLHQSBChla9rC2zKMAlq2xkhPPfIVVLlphMR006eM6DdfdA2DOEQSnDTM9OKhk8gJGkepIMNyIM6A=
Received: from AM5PR0402CA0001.eurprd04.prod.outlook.com
 (2603:10a6:203:90::11) by AM6PR08MB3445.eurprd08.prod.outlook.com
 (2603:10a6:20b:43::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Tue, 15 Jun
 2021 07:18:11 +0000
Received: from VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::df) by AM5PR0402CA0001.outlook.office365.com
 (2603:10a6:203:90::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 07:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT063.mail.protection.outlook.com (10.152.18.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 07:18:10 +0000
Received: ("Tessian outbound 596959d6512a:v93"); Tue, 15 Jun 2021 07:18:10 +0000
X-CR-MTA-TID: 64aa7808
Received: from a37d1324010f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 53A6B74E-C9AE-4B37-97FF-9270815046D6.1;
        Tue, 15 Jun 2021 07:18:03 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a37d1324010f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 07:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcp6L4qdqD80XzyGdhT6IAdh8T9gugzyrGkekZSvBWYJHWfM/NZg+lVEgRvQsswM8cb686zlbGCjH0rkM0ZZNAJkgSJozfZ9M9eOQhzx2AeSl3f7xqii3BxuCNFyEQLy/CGIgfQJ1k5577fjY7c7bIs70u1UVZYQuvrD0x7KMPorRQUpBe2JJgPSVQYoPvJAh8/Khc9/4rLwVMnE1OD1T1i8uTqq7bSE2DtvMg/axSXlZvYvTx1mTmHns345xMHZg4NzRJfTkExS2FxXJgV/SPbOdIohscITUI+B3CzfTht9DDwi81KTHyeClRbPnS96HaLfiyRbLbzU56GxUJdRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMNmTvJnHlQJ2SOOBsg9JbwhK7HJmgKyr0uUhFcbOik=;
 b=GC2ZtDPnA0zM6NjarsvdtgZ43YbDdxPg+9EZm0RPRimQqeasbwuGg3jj9RkXW2gCgdsWbX5iL4Ihm9JMaAVo771MS+24+7pZx8qbtACIhrf+pH9Y6uYIv+j/VzIAV8X2WFDevp8wSE5j6IkVwk4kb3hL8Gr68I6wuCeozRppybeDEEN9LcMpwAZpGnX1ep/buJ89fqqdvWLZxoZCIAXTN7tYpM5rDXdUnQt4V32QvsUQ55i1pMJ/SaoVwRT0rjVEYBPpi/kHvnB96QEMm/dCHZ2tY7CoCUoeSt2Io8+gvvy0rWwLWNqyCH6Mv9hLfIF+1Mk6XpsTzREvVWR5uPMEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMNmTvJnHlQJ2SOOBsg9JbwhK7HJmgKyr0uUhFcbOik=;
 b=7SSGBobFwzuuk5dvGYurS5PcyGi0k/aKoQofAS+QtxmamoImwbw0YOKyp1nX5Hvz2ayFpNNNlnMp10nghKLYsOicIJPZzRnLHQSBChla9rC2zKMAlq2xkhPPfIVVLlphMR006eM6DdfdA2DOEQSnDTM9OKhk8gJGkepIMNyIM6A=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6856.eurprd08.prod.outlook.com (2603:10a6:20b:351::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 07:18:02 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 07:18:02 +0000
From:   Justin He <Justin.He@arm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Topic: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Index: AQHXXtruU5AIb64vzESDK9b2+VqurKsTqaKAgAD8LoCAAAitgIAAAHTA
Date:   Tue, 15 Jun 2021 07:18:01 +0000
Message-ID: <AM6PR08MB43764C1A1EE67D0683EEF11CF7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com> <YMd4ixry8ztzlG/e@alley>
 <AM6PR08MB4376D26EFD5886B7CF21EFCFF7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <113d9380-8493-1bde-9c76-992f4ce675d9@rasmusvillemoes.dk>
In-Reply-To: <113d9380-8493-1bde-9c76-992f4ce675d9@rasmusvillemoes.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: DB7F0547DC83C44CB4FA7C6CA0937ED6.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 582dc9d0-102c-4e47-1dfa-08d92fcdbb65
x-ms-traffictypediagnostic: AS8PR08MB6856:|AM6PR08MB3445:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3445CB21DF194C9F383F32B4F7309@AM6PR08MB3445.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bwjs6vpJyV8jMF7qdQ/R2LZniFo0wC9S9AMG7YnPcIRe+FGJ2SHl9HybloyfTucbzzF8dPxwZI3j+4exSc3ItSCjfZpHrnaAyL4dd4t4xilVJUYkzHfV0hZR1HGhoQTMgdxmR3v0IDDm7DNuWwMcVWfQvvJO1K36n4CzGZj9i0EZOipx9YOrltwbOnC7ptNwwt9yAdwTXsmfiV7yXbW2veZRp1Az98WC5eTi31vJ+bB2HEpTdSOl6hreq0MM0ZsV0L8o65wJ1Ghzcqn3N/QB59etWAkApQBgpjHHK3p9vsT6u/FRQ8tUjVyi+PKC4BRNedEuryG+GQaxtbHC7zDovmUis7u771dAzFjQLYvsbxJHULKmOZLQdXVCUF555GrWDGad1j/Qvs6cepMK08ANIlCO1Wy8XL1sUaYDzWk68LmRvaAiJx9KgcvWpP6zk0cRG5zggGQ9HAdZS/xpXysldFHcnzcMWx9Tdr5IiHUEGPv7xoj0g6BPSBWf7yxuMqFKCp9uElZ5LfTx/C3a6VP/R72VHvxMB43tF9P3QYJM3SZ9wLLQh67mGE0D+mEnh7B3VaMiucLQH9gI0d+Nc5WKiCOUQl7EF+oeWeLl+FV9RUI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(39850400004)(396003)(55016002)(86362001)(6506007)(83380400001)(64756008)(8936002)(33656002)(52536014)(4326008)(53546011)(54906003)(66476007)(66946007)(7696005)(316002)(66446008)(7416002)(122000001)(76116006)(5660300002)(186003)(8676002)(26005)(9686003)(2906002)(38100700002)(478600001)(71200400001)(110136005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Wp0OEjytLsNgxedqURC+0Hg01W+Yl7wSG/kynWGxnSQZM/du8nkk4vDufq?=
 =?iso-8859-1?Q?SgpL5bvCm4Wh+U0PjjAuDH04NFKBN0+NSnPF9g+f0+wO6U+jbezgVHcqDW?=
 =?iso-8859-1?Q?0tp4h0ke7XwUjSjlOvheAsM72Yen+XGHouZ4YMp2ErqAVhBXo5b0N+ymu3?=
 =?iso-8859-1?Q?RnqotC9lNODyafRsZN/6k+Kefv5O7ZFzpO+ws4I3eKJcb+ahwYFOOehKqw?=
 =?iso-8859-1?Q?9g6jKtsX5ihguw/blRGEgwf0F7W7cNQjeHETwLTLI0nA8uYGT2ZJ+E+yXP?=
 =?iso-8859-1?Q?fHpGZbEKXgcQClCGqHC5EsxBofy9ahKFVvmWEZTCQWl0gl3Rh6utPHlXuk?=
 =?iso-8859-1?Q?LLpZWINvzoE9hc9FtrLGHsxuy8BG9blrZeg7H/vIhohFs8sumNt16EpsXl?=
 =?iso-8859-1?Q?WmyNZx/MA2DosKl+lT5VBOAkA+jvBEBOAvdEDEnMhHxbH0PdQAPHS4rbg0?=
 =?iso-8859-1?Q?WTOJnJxs7btLJVqsY7ScMmt6dUTrgZm6vrUbG0tpLYOu06VUZjUb3V2azP?=
 =?iso-8859-1?Q?Go1dEjRA3DIPi+qZUBKBS+wgz8w/UVfLD0ptZRgj7FnKOU9w/0kB4VZiIX?=
 =?iso-8859-1?Q?DeSyhHKEnCVPT2nGCGOlGLQGn+JGhsLxMwYdZbV6q4r2xwEhwmKtg+GpZt?=
 =?iso-8859-1?Q?hwttrwpPxHyHU8tZznQd4f7xWsQi/ntuDlWKVJCLF8Tqruqid0ZezkvpeO?=
 =?iso-8859-1?Q?FQHAp+6LgTctv9EjlXFv4r7e2l6PGgHJ1dt7ZCX8gG+V2YIj8iRkFsqx8D?=
 =?iso-8859-1?Q?xOudPfJWzGgkqwKaY1TnzEiscJiKnrYwsICfgmfaofirFUt4xzZtouLGO5?=
 =?iso-8859-1?Q?lTg3iMDKqaXq/emDFM4sgi4prKFASP/x26IHv+dON2m/W/RWwuj5ZHe044?=
 =?iso-8859-1?Q?9y1k5ZQvHf6ceFhmTUuSogagRrKPVp0G+0C7ozX3xqLXnA9Fkg3KPHqin8?=
 =?iso-8859-1?Q?uFxFpBaOzwH16LIX9KEqMz7b5zkY5fl/3B5Wv2Fb5GCi7ejGzOyqsqylxv?=
 =?iso-8859-1?Q?4lE0r1pWmi+anxtPbxoViXuu7q17gdXc+Vk9vsJ4fX4h3wYssVdR6olx/C?=
 =?iso-8859-1?Q?MlEahV9L1mRe3ZxL5Z2YabuxMMQP3tQc8aI+ra7pIy9G8hPBudglSQmvc1?=
 =?iso-8859-1?Q?luqdhvFwnPGBr0hMwRD83uacvPTq4K4VFW2etCf/pHOAPQXGTDQoVhsRZq?=
 =?iso-8859-1?Q?2zvqgr+CSXJjup0Auyn8/KlaZQs9u/+hNWnd4D7ggSpafKgmNYSMyuJPxe?=
 =?iso-8859-1?Q?rlypInzYSt2mfYb2zmEfn9Q9JU4MunlzFLA8M81E4I0+f83+zcAjf66VyV?=
 =?iso-8859-1?Q?faUDZKbNi42jhoZQdZA/dSrhWC0bPczwUhlI/XKQ61foz4sDSYEWInjk5Z?=
 =?iso-8859-1?Q?mk1JzawUmO?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6856
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 95cf67aa-0268-4f48-1816-08d92fcdb663
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LY/dFDPpTRGKBzJguJQe2EUxrlcZ+X/gwQaVpybOWcEGW2EdihVKYSTlUZkup17JT0jFoUGqMsMg/AjijMz3DtjoFPmCpfFrYgpvw1M+PoZyPGJA062rqkCPy4z4VTjpP5S/mIN33C0BfBYY525PVCzeqpWMg+agO7XHVJouDPP3nPMiG9y25jDviVMr2yiRWw0lH4MfMrM4pVckNRTa/3u4fYvLfMVQ6cYl202tjbmq/eSwOnQuNbqQchjPpyhMzBP6hWbFklk7sDO9KfJ41nFj1205B1RBZLLblMa7nVoU+AZStctuNNu9+eYHG9X3CNf5aSomD/doEsrJykygx5Co2ylKvzcTjjAHK84RgU6HyZsyR7lNoBlvYypN9gsVED8ZVInU8wPuq13MsggC/sbDS9Dvjz/3gv2XOFOdMJ1OAcCrRXXp9gqQoNCv38OlKLDneMAr9rSUhEkrrC8lyw3PQiViPB4M7aCriWoOKmEFu9MKv2ib06ncp9t8A6Uz2kY0Wd7yM38Tw5RML08djF1Oi5KfMgUM6dcCAJdGKcBJzPC+kQTm/en8AkLUYAECXKuir5bOE9Nou26rN9hM4Q32vJFslLNgoO/RS1S1SAFJwo6hxIaokd1lDXtY0b7J/1dMj1HlgnMlX/a/ppL2cTYDk7CLspMt7Jyqzp5uQYQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(110136005)(7696005)(2906002)(9686003)(33656002)(54906003)(450100002)(336012)(26005)(82310400003)(186003)(356005)(316002)(52536014)(83380400001)(478600001)(86362001)(4326008)(53546011)(5660300002)(70586007)(81166007)(6506007)(8676002)(55016002)(82740400003)(36860700001)(70206006)(8936002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 07:18:10.6414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582dc9d0-102c-4e47-1dfa-08d92fcdbb65
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3445
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Tuesday, June 15, 2021 3:15 PM
> To: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>
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
> Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path f=
or
> file
>
> On 15/06/2021 08.48, Justin He wrote:
> > Hi Petr
> >
>
> >>> +   /* no filling space at all */
> >>> +   if (buf >=3D end || !buf)
> >>> +           return buf + reserved_size;
> >>> +
> >>> +   /* small space for long name */
> >>> +   if (buf < end && prepend_len < 0)
> >>> +           return string_truncate(buf, end, p, dpath_len, spec);
> >>
> >> We need this only because we allowed to write the path behind
> >> spec.field_width. Do I get it right?
> >
> > Both of field_width and precision:
> > "%.14pD" or "%8.14pD"
>
> Precision is never gonna be used with %p (or any of its kernel
> extensions) because gcc would tell you
>
> foo.c:5:13: warning: precision used with =EF=BF=BD%p=EF=BF=BD gnu_printf =
format [-
> Wformat=3D]
>     5 |  printf("%.5p\n", foo);
>
> and there's no way -Wformat is going to be turned off to allow that usage=
.
>
> IOW, there's no need to add complexity to make "%.3pD" of something that
> would normally print "/foo/bar" merely print "/fo", similar to what a
> precision with %s would mean.
>
Aha, this answer my question in last email.
Thank you


--
Cheers,
Justin (Jia He)


> As for field width, I don't know if it's worth honouring, but IIRC the
> original %pd and %pD did that (that's where we have widen_string etc. fro=
m).
>
> Other %p extensions put the field with to some other use (e.g. the
> bitmap and hex string printing), so they obviously cannot simultaneously
> use it in the traditional sense.
>
> Rasmus
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
