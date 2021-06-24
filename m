Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085B03B2515
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 04:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhFXChk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Jun 2021 22:37:40 -0400
Received: from mail-db8eur05on2084.outbound.protection.outlook.com ([40.107.20.84]:35457
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229882AbhFXChj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmAod0QwUloVXzi2MhJvz6nPcXW+WluM7uWRwDVcOrI=;
 b=ObkUtziEVRSay0EX5IDkkydFJec1zN/UkgY2QeCgHnQkiZauqIXXg0AlvxMs+9PuQYmXHOXytrhzgqkBVaRl0HxtS1UsENkPw7duWIzDiwyZaNdCyApDnUQ+naYo60eqAFfd8wL2LWEX4akz68ufISmlq481qPcRtYc26Di8haw=
Received: from DB6PR1001CA0037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:55::23)
 by DBBPR08MB4348.eurprd08.prod.outlook.com (2603:10a6:10:cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 02:35:18 +0000
Received: from DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:55:cafe::3c) by DB6PR1001CA0037.outlook.office365.com
 (2603:10a6:4:55::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Thu, 24 Jun 2021 02:35:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT020.mail.protection.outlook.com (10.152.20.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 02:35:18 +0000
Received: ("Tessian outbound 92494750bf3c:v96"); Thu, 24 Jun 2021 02:35:18 +0000
X-CR-MTA-TID: 64aa7808
Received: from ed4b729df66e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9417DC42-0688-4AD3-97C4-C3E1891FDA02.1;
        Thu, 24 Jun 2021 02:35:11 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ed4b729df66e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Jun 2021 02:35:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3GzHxQ+wxiivhE8GmEcBTuF2uQGBeEqF4JQ4oKii0T/z5JT9INmi0fEaHIst+R1lfeSZ8t8oBHzbHihR6aKcPGmwVNhxvIebLOqr2r+it0JigF3kSm021KEobIr2S3/o7KSaR8fsdYIcVXWBHEwpNTI92VIxaKht33PEsvEwNmNwXvh0eu6RSPvnLh40nIHA9RpYt8iR8sZRlZXc/1nipqXTyM1cGS8pkbLOiJDc5qpkNKrUABn4mqXm/TBATpZsD5/iWRo/ydHK2tXxBbSMLr9bqUbQ7qMwQudyHwkmJmgie/Q9dJMuAWrhsUClQVP+MHtaMbi8R9WddZon/pYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmAod0QwUloVXzi2MhJvz6nPcXW+WluM7uWRwDVcOrI=;
 b=EgY0qs10bINP1sN/hn/X/6js3zJOoxXHXqF0+MuTUMsQkZVsH6vQm10D5NsNfEUv1/7+RsZNTelcZLcY//sx1jfNlDKrXciPXCOWMFWXKxp7qCzebsQ2kC1yLHm/LfsE9YTu+Awex97ksbF1nlimPZhfpupRuRte7a6b5DJuq1YRZp8hRTrkvnU2hEEiSBctZ6K/PueJs2zOOQ6ZW4hhFlcYgFYQ9sSeaAumKi8MUtsJ3iajqpynzxwl52Kq463XjyTXT7KtQJCIVQM5N4fe50OqOPK105vJ4n6ayl/p/iYd3Z3Cud1EXmeGl9fmi+sNdwhsYjF4+V1EQb/mWwVteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmAod0QwUloVXzi2MhJvz6nPcXW+WluM7uWRwDVcOrI=;
 b=ObkUtziEVRSay0EX5IDkkydFJec1zN/UkgY2QeCgHnQkiZauqIXXg0AlvxMs+9PuQYmXHOXytrhzgqkBVaRl0HxtS1UsENkPw7duWIzDiwyZaNdCyApDnUQ+naYo60eqAFfd8wL2LWEX4akz68ufISmlq481qPcRtYc26Di8haw=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4422.eurprd08.prod.outlook.com (2603:10a6:20b:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 02:35:09 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 02:35:02 +0000
From:   Justin He <Justin.He@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Petr Mladek <pmladek@suse.com>,
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
Subject: RE: [PATCH v5 1/4] fs: introduce helper d_path_unsafe()
Thread-Topic: [PATCH v5 1/4] fs: introduce helper d_path_unsafe()
Thread-Index: AQHXZ3APPvTGE0Nw2U+XBRBhCUmYhKsgGSWAgAC+lNCAAHezgIAARClQ
Date:   Thu, 24 Jun 2021 02:35:02 +0000
Message-ID: <AM6PR08MB4376206454B462E45E72D3DBF7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-2-justin.he@arm.com>
 <YNH1d0aAu1WRiua1@smile.fi.intel.com>
 <AM6PR08MB43761598697E6DC08A5E71ADF7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YNL5v1I9xOfpLPke@smile.fi.intel.com>
In-Reply-To: <YNL5v1I9xOfpLPke@smile.fi.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: D98A2F739550D44389E1E1DB649B8A63.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ec3790b4-4fcc-4237-7ded-08d936b8b4a2
x-ms-traffictypediagnostic: AM6PR08MB4422:|DBBPR08MB4348:
X-Microsoft-Antispam-PRVS: <DBBPR08MB4348366BCC51A7E9ECB1D0A8F7079@DBBPR08MB4348.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:499;OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: utFsAGBQQNhULGFxXHSY01qPpu3XUkpabQKDXT8rO+UUnpTaVnwmDfg2OgM0Hyl+oyEOrDbMmxw16z8+UFfWXrZzUJvgsVGZ5A0J2yRuvi5ry0tMs/PrM2iHEhRt/MwbnTneV1+3im/B5Oqauxk6j63g629oxxSDRay/j5L3f6bAAObjaXIyYrynhL3NQ4osx1wAAUzSb96WTzvXE5701Cuh0NUkITcu3GRLuw6h9iXwpWblmkDzzR23bYf4veYItTpVgbONwDHvu/jOrU1UiUR6qhKpS/7aRQ4cl6g5GSFg090YkGnIRNW1sWU7q1LkL1xfIHFadm5ecfOAuXuaBLKeLaheyyKbMgeKWRV9n1gLTgYOuPZg3NzWlXgPr/EgNDPYB+vRRne6HkwA6ylbZtxu0E0Lv0mGa1C4kEkv7OtsogYFKyEQGA/a0Fbu0bMbrOv4iCp25D/JAhgsHR5zWk8tOHih+rHBrgiG+AKKODxEGutuxDpyC3hyqtGMCh+HPMl9Q3+n2Tlw5KmO0MHHU6SL5WQ/1X7H4XoJStD0RAJuKRFQwegsHKntf6A7NKO0Tn8vo9VajJIXEQ88dzYs9R0+a8zWfJHWjFttNKEGzjs5B1B2CwPWolezoZHbqEc+NtUFD+wKZeWXaB0sCtqyVcApd+bM1/c9/7zFJwQFDDI9IJyPSawnaI4Juz/0rLO8CQF6cDoMxwcN3qBHxgWUf9h3gA2Il8ew5hy2xtiLzM4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(346002)(376002)(396003)(66556008)(33656002)(9686003)(478600001)(66946007)(38100700002)(122000001)(4326008)(71200400001)(55016002)(76116006)(7696005)(5660300002)(6916009)(2906002)(26005)(64756008)(66446008)(83380400001)(186003)(86362001)(7416002)(966005)(54906003)(316002)(52536014)(53546011)(6506007)(8676002)(66476007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2RsI8U+8Ko4AMC2R0mv6MZ1/Sz5bjp0XKSMvLE6x4f75imn+ueJuOgS5PBaT?=
 =?us-ascii?Q?QT6bQT+lx0uDO41U0ANfxbXzATiX727zNL4N+WZfJJpb3G5Qy1xwJTWWQQFV?=
 =?us-ascii?Q?DmVQPMn63qpYf4vvWo5+MwIvtdgjFfTOYjYYEijmEtn3yAUJR1osjISrjP3w?=
 =?us-ascii?Q?9IvzwPo6u2w6mJ9SvymZvqackaSG0PYqoUVOgfi9t1QKHXRw64QcGbBmlLka?=
 =?us-ascii?Q?LNU5ZRVw9rwWfWIAAFPT/4NfpiATzB7K3EE0TLDUm/9I10gnxS0IQtn8haiW?=
 =?us-ascii?Q?llcjMiYsoXFPdN2Fc+tBLn7/3j/K5Rxho3QsMGCnrX8w3tuCCg3DCvcS5CYd?=
 =?us-ascii?Q?E8S3AA6XWqHZXihgUxfO596E2sGDgEbSR1xslvvKtD0p3B/vqaf4YZpRHcD4?=
 =?us-ascii?Q?20cjBih7rbOftw8+stk4sn0AW92Kzpus0+xd6hGpyzjNGwbywoNNVnw14iqD?=
 =?us-ascii?Q?ZH0oA3SfRw+X622Dc6Ts25oRrigzdSr8LTgNCkz0LHeblvwL/iqhzRDFYAIR?=
 =?us-ascii?Q?zT19jB5pIvGbuA9LnYK/n16u5hwqtzDSWZK0fePsDt5ThfrH9oyjc59CSwD3?=
 =?us-ascii?Q?ITp1LC/vfT1lgP7rR8bEws8HpWz6rNKYxoEnh0iYosIsf1IJvZYItsjEF7Hv?=
 =?us-ascii?Q?Pj78Nesexz0fOaK31MOq3pzxvKUHh9hHfwqcYNqjTH0hrf13pCkCPsrBhAZG?=
 =?us-ascii?Q?nnASW/4ODHdywmGpUsRi+KCIl78Hcp5MG3F3RAsDWcjyJnsBV8BxPr7XwRNv?=
 =?us-ascii?Q?68cGFrFqEMWlBBXGfAWx59/bX+716Q3cNKwcDY3CjxGxCrZlWpdIg+9PCTGC?=
 =?us-ascii?Q?zpA5SYVvU3UjITt9h6bZuBZaUbxq6xDHysMCKLi9swVwXHd6+ZxLRIZ3k4sX?=
 =?us-ascii?Q?GkKVygz0dqDmlWMUxS5/0GGoBEF3UhRQcz48a+9O0uBbNjAI5CFLKqihPrxM?=
 =?us-ascii?Q?y976xqBSjRmwYgrmKY99R40LWLMG/8RyRR8AGSNfuK8BIndlqUtYzrPwGcj4?=
 =?us-ascii?Q?Hy2OxuVGHxYHHMFmlK4QmLF1qN99dV7n0G1ZrYQmFxFJuUikdu9PS/Exn2ux?=
 =?us-ascii?Q?CG6okED4w3119PIwKN67xsAh+t44ZguiY+hKkNjDh514pd8Dc084GyJwAuGe?=
 =?us-ascii?Q?9Qo0djfbwk5b5SPghtOT68/rm4P0CdJOPBF/YcMpwwobEv+crWDuRyAhNbMz?=
 =?us-ascii?Q?v7f7befXrPotMyIZ/Gr1kenHCGvpzFvyQoJVkDqOqQMUunSxK7amJ3mJp2OP?=
 =?us-ascii?Q?lKZXC9FfJMUANmySUduH3t+59T1Hg3mxUFU2k0IbBSfj30dwrtx9h/sjUgKE?=
 =?us-ascii?Q?AUtHzawXvsHwcdIrWqy7uKpv?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4422
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d7312e92-f1e0-409f-8ebd-08d936b8ab56
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxSQAzabBdEpfE3wgxOhx2FeDHodqL+3x3kSnWI5Q47AKuhDvxWUMHiyMLmrhfL8zUo6c06Omx7xbHTti/+x/40dQmbglhgf6uSKLTFNpagV6ufn4Lq0X/i5N1c9xNhaJLz4nMGQNvPH7QR4uqa95D0tWd8ViOJQd8HCoY387ux5z0HB3B840wMALlUNgTSTXWRClNxv6hp9RzMOXe82VmeJV3uwNpeavE/NJ2r6MJs9oG5fLdhdfbCeORovbrjrcGnx2HEN2B5El2/sMNoCGKe//K83JtJAyquTbcIJzq5x8eZl6SFvCxOqB9A6OgsYON0Q+PpIkjzrf3SHFI3Mfp/oLqOqRjMr7D/lKP7M3mJcCV/MkQaVC+LpPJxatF0OeIrbNURx111F1RnHCE0O2HaSXntyXuXBN9aDHKY3bqRWiHxKwtPjJAm0nvC23nMPjSTCZyG2nNzLHpcywwEaaKGLoz5U+Nou+5Wc57ZPGHPNKT7SIxVGm9T77IXsJmcW6l2yog2bAhnEojj1ML3m22hIY5r2wHZHtF5Oh/Cml6TVKZbw3adg2m8X9/xcSWjUZPIIWMJRWiBQwA/+47iDsHxQkakvuG6wr8w11d3XH6gmSO3bxWqi+x3ciq0d1m6xWyBzi3uokjOR6+U3vZnahwj6xtS9xFyUcfmJ01HtterP9gjUysmmM64tUVzOYgd8tgpw3ykAIzWRZnNDdVMMxVCaa+WlV/ea+ELJd0lHCofosCYfcuQVu59Ksp7CjZhFjPRVYu66qNKlYtyg8koE2A==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39850400004)(346002)(46966006)(36840700001)(8936002)(82740400003)(70586007)(356005)(478600001)(81166007)(83380400001)(6862004)(316002)(54906003)(450100002)(70206006)(33656002)(52536014)(53546011)(4326008)(86362001)(6506007)(186003)(5660300002)(8676002)(7696005)(9686003)(26005)(55016002)(2906002)(82310400003)(47076005)(966005)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 02:35:18.1881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec3790b4-4fcc-4237-7ded-08d936b8b4a2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB4348
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andy

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, June 23, 2021 5:07 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>; Christoph
> Hellwig <hch@infradead.org>; nd <nd@arm.com>
> Subject: Re: [PATCH v5 1/4] fs: introduce helper d_path_unsafe()
>=20
> On Wed, Jun 23, 2021 at 02:02:45AM +0000, Justin He wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Tuesday, June 22, 2021 10:37 PM
> > > On Tue, Jun 22, 2021 at 10:06:31PM +0800, Jia He wrote:
>=20
> ...
>=20
> > > >   * prepend_name - prepend a pathname in front of current buffer
> pointer
> > > > - * @buffer: buffer pointer
> > > > - * @buflen: allocated length of the buffer
> > > > + * @p: prepend buffer which contains buffer pointer and allocated
> length
> > >
> > > >   * @name:   name string and length qstr structure
> > >
> > > Indentation issue btw, can be fixed in the same patch.
> >
> > Okay
> > >
> > > >   *
> > > >   * With RCU path tracing, it may race with d_move(). Use READ_ONCE=
()
> to
> > >
> > > Shouldn't this be a separate change with corresponding Fixes tag?
> >
> > Sorry, I don't quite understand here.
> > What do you want to fix?
>=20
> Kernel doc. The Fixes tag should correspond to the changes that missed th=
e
> update of kernel doc.
Ah, I got your point.=20
Actually, this is originated from an unmerged patch [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=
=3Dwork.d_path&id=3Dad08ae586586ea9e2c0228a3d5a083500ea54202

I will ping Al Viro to fix this


--
Cheers,
Justin (Jia He)


