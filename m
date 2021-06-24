Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF193B2741
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 08:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFXGQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 02:16:11 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:57571
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231240AbhFXGQI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rhfg8nFaWD1pByveQM90S1/gfoCkN0bHoibKa6mm3Q=;
 b=6MJiW+JF8zTkseVuxC6DI9UQi88ZF9EYJj8UxHD+TEh5LWXVsvwpS5k3omrlDKYKd1KlFuxu3Z4freHqb4KMNssxToXN7p33D+K9ct2DYywPMnA+x8ZrbwQWyA8/v1v34zC7zVKvzMWkxKesgetrULC6P7RUDfg4DYwGim7ZPv4=
Received: from AM6PR0502CA0038.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::15) by PAXPR08MB7090.eurprd08.prod.outlook.com
 (2603:10a6:102:202::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 24 Jun
 2021 06:13:34 +0000
Received: from AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::36) by AM6PR0502CA0038.outlook.office365.com
 (2603:10a6:20b:56::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 06:13:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT003.mail.protection.outlook.com (10.152.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 06:13:34 +0000
Received: ("Tessian outbound 92494750bf3c:v96"); Thu, 24 Jun 2021 06:13:34 +0000
X-CR-MTA-TID: 64aa7808
Received: from 62a85a395ae2.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D7B5C1E6-FBCF-4372-B151-0DB9F518A52B.1;
        Thu, 24 Jun 2021 06:13:28 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 62a85a395ae2.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Jun 2021 06:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+0uZPm4JGrJMCN0wWWJ3kHfiUKUiJIPlx/7GWvZcVVh6Sp7oV9lAlFpD1Yuli7CYNw5wq2JQlOZb/ByxgJ7WTgHjV3jN+Fq1Vdd0Te+9u/diiI1vbZ3zPokLrSxKfCQ3fATYFgmWTsgkzRsA06x8AX47EGipfIFXDO92UgP7mXfWsdtPgfeTstZrcfoyu2+8pUmiNEPRJNcE6nDN1+5/GMZxLsA9rvs82adTpLyL5PCFLfKHv+SOaRtw8Cdqtoo6E5767/I0mXeHtjHVZfS768hN3ACeSomnzQayxtPG97/FCNvZnjjUYGOo6WjW0JMgPf+cjpGqH7o+dOmD68jiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rhfg8nFaWD1pByveQM90S1/gfoCkN0bHoibKa6mm3Q=;
 b=GybbNrm7iN/WpbsWu8jtv9M5CPpwpYl4BTNOa7MJJ9j/qphwF0bBfFNumE+XB20gpsP58x4nFp6WvRdQSh01DD9C+PSag6mi8iLGSE2/gjgPNVbsRI6kWpTJnK/uZ38500o3LGMOyMzVM3LpUb0xsV0fLGYiJM920tnSybsrNpbfLeK5IYMRd3a4n7VJhtsAmmk2RKmuL3EaejM0Y6VI/dv48+u2nWUDBzHLzH1JISw7Lrcx/+9eYUNMdy8C1KmiXMBckoehPZxIRDz9fOxVFOavJ1sAcH955jYeGxfLIK2d5G3Vuk2hrA80ex9tzq9CcEuflzN7QFYKIUCl79BqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rhfg8nFaWD1pByveQM90S1/gfoCkN0bHoibKa6mm3Q=;
 b=6MJiW+JF8zTkseVuxC6DI9UQi88ZF9EYJj8UxHD+TEh5LWXVsvwpS5k3omrlDKYKd1KlFuxu3Z4freHqb4KMNssxToXN7p33D+K9ct2DYywPMnA+x8ZrbwQWyA8/v1v34zC7zVKvzMWkxKesgetrULC6P7RUDfg4DYwGim7ZPv4=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3592.eurprd08.prod.outlook.com (2603:10a6:20b:4b::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 24 Jun
 2021 06:13:24 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 06:13:24 +0000
From:   Justin He <Justin.He@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 06/14] d_path: don't bother with return value of prepend()
Thread-Topic: [PATCH 06/14] d_path: don't bother with return value of
 prepend()
Thread-Index: AQHXTEjKsW2D5e6JU0KYzk7aniZHlKsi51pA
Date:   Thu, 24 Jun 2021 06:13:24 +0000
Message-ID: <AM6PR08MB43766761214CB7E42982F58EF7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-6-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-6-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: EBE5201A6D9F8F46B83EA28EAF34AB68.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: a1e9c6be-1e7b-4a6a-96ee-08d936d732ad
x-ms-traffictypediagnostic: AM6PR08MB3592:|PAXPR08MB7090:
X-Microsoft-Antispam-PRVS: <PAXPR08MB7090D617E76FC0BD5426CE6FF7079@PAXPR08MB7090.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1247;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Rfp3XRhFGayyUfQSNj0Uz1nF4yYC12rSEdKZiTV166rM2B8fSi2p27FvT23qePfxblFFbwt4r4p3JD/lV9qb+E4wogiYwbwWE+LcY5zrla+vhuZMpVm/dTgOauuo+AkvTTLq8ujk2cCIX280JF15Hc08Pkj2rRfpeK4F5sNrHcax+9nEaUGClbyCHB8hTZNEe39oAnhcQ7ZEuwIs0rJmL9NkfWgUdiik2ylRJCLtHas361qiUmG0o/wT2VjEu3ANmsxiX+UtqgKSw7c1mzoLCDis0g2C5c2pz53B9i+it+DX9WAoOxJVBKpjQDlLFYhUWNmOGDTuh4ybWAFzcrOW3Tu7ml1w/4MsaqJLf6WgXFB4EFRyp5/0jD2V1Bns19ec5V/Qe10sSrSggWh9eecb8hKrP1tqn5JFiS5WGd3LlhRiMxJsc3pMeZfW4/qUHiXpEgX2gOXsD1zwn0FwBh443Wb6J76atjRiOB7bd0LkRu07ip/jMMEuxXB3/Upf0D6RQE6/cwkfJ38naEFVogSKqFPf5QwU4KU5Z1n1Q/WdqJrevqjGFn6ddQQKk8899689INV4df4eV/Sru7CVd+fv9uvPRGknOT46RLi4qZiLrS0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(8676002)(33656002)(478600001)(4326008)(71200400001)(83380400001)(7696005)(8936002)(55016002)(186003)(2906002)(7416002)(26005)(9686003)(110136005)(316002)(6506007)(53546011)(86362001)(66556008)(54906003)(66446008)(66476007)(76116006)(66946007)(5660300002)(38100700002)(52536014)(122000001)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ycJirM9Hv/3cLb3Xdt3Teye340Qzu2prNx22GFMeoHgPnvPasINY7m9zuP+p?=
 =?us-ascii?Q?gNIvk72oMxIhpHGZqhbO2mfJL4TkL2X1CGSn4ZLNTX08FQizm8gKBHIPfdv+?=
 =?us-ascii?Q?Zrs3YNOV2er944iOgNAnamCg60NOk18LslAupguAcmtiJ6hS7FIIbcLCfbty?=
 =?us-ascii?Q?eWRmeym84hxcAz1UDJry2EeMC73JNd47ZbmtTRRtJgetQ4+9voWQJXuc8ZCg?=
 =?us-ascii?Q?Cnaj+n0aPQxAfIyuwC26hBIfVEN/cDT+3YhEX1u+tRP3eB93SlGt1TO7+Plo?=
 =?us-ascii?Q?zxKzYKAPg6M/laGTJAamK6DYJ8BGc0V1s0A08Zu58AkKZ0hZAK6pTxmBk4ga?=
 =?us-ascii?Q?ZQa2Y+KwHZdgHOJPCVr7xRrfZqbX5vMmlc3hekF6eUMf5CosoCPBrWhyHCAt?=
 =?us-ascii?Q?zyH0uFoizvt1dtHwu3c+WjbY4JZjOAGLsrOGiKrXj0rM+lvSzl2rx3EWsoSs?=
 =?us-ascii?Q?PzH+iJYKhfi2+aC3LX3fWnaUnULEhruaF3oGTaP2j3paO78foSjdhUO9KRkN?=
 =?us-ascii?Q?g3g3++mp8C66fBPjewzi5ub767/G15if146T7jYzIhgdJHrrTRk/D4cfs7hI?=
 =?us-ascii?Q?TFBxTdUmfL/VvK79l3uMShYhh+YILYfEEJqSIqzucKK6QYrwvinziQQi72DA?=
 =?us-ascii?Q?4aKZkN/Hys8mPcGJOlfRBVpuJQWKgl9sLLpuGKIye8MSgN7c/bS3m0FdzNge?=
 =?us-ascii?Q?k3Z+1Hg3amvMMB71wP9wVS3Th02bRtixznIyoIO48KJF5JG/FOlo8XVzR9Ng?=
 =?us-ascii?Q?55OV1XVLV1n8ATtOhYbPBLi1qHQchvkJ8rdDVac9ouN54j28lp9h7CMzMBTQ?=
 =?us-ascii?Q?cBNVtXkJYVb9kuUxW0cOvHwuKpbpWqYGITEy5p6Zi5FoCz838qDC4P9Lq/PZ?=
 =?us-ascii?Q?KWOj17HE/wUvZgIaw3i47NkVcMO2nNCHAkkSLjFzul/Y/6yo8zwwdq52VTSG?=
 =?us-ascii?Q?8LKwNrTagNpugvwLdMtgybf9hM4/QEJ0Bt+m2iqBKzB2T7MhaEK4iU9e5/Hc?=
 =?us-ascii?Q?tLRCgRfWXOAXkxC606Fey4d/ynlImg03TMcdMLMNB6sO1tJrIhYeRw8MQRvs?=
 =?us-ascii?Q?3Qj4rZ2CB45gSpVYleBFDwDFIbOioLIrU2Kw10GQGlvH3PpfB/v0qC+LtCbS?=
 =?us-ascii?Q?hjElZWaOHFbVDw+KUIHofIw2eh1elCYQuE7y4FjT5Eu6eXVUduFwvuQhHHrP?=
 =?us-ascii?Q?R6/q6hjhN7XPfFMGlxNIYbIIORNJqKYzfn6kdu1RWsZ3tT11ukdJVmRz3nJt?=
 =?us-ascii?Q?qV1c51zKhSOgABy6drxDO9uuqGrEiQ322aOWuwxtGiMa9261z4xNyGyEOozr?=
 =?us-ascii?Q?eOzjNwQ9Zto44rpiBfGcCaAs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3592
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 32abaaf2-a15e-4391-671e-08d936d72c9d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LY37fK7nmOraeJvwsumCIYyG9BogQWXWVLS4mTAO7mTXP76RJHN/hhSUZjlQLhDry6WQ3Q69r+3gHC86qaa1U2qoazR67g6ZAI0v7aEXyTmx7df7AROzoikxXNTI2fN3Vq+MbO1SBdZvIufbieP3xga2Ca6d68qvEaUkKPOWeYBi+kSsGMhCJdOr2MNmC73S0jXiPE+JRnZOHNlz83UyvM/bHggVc9XTdGn3hkjjMcYF4YUME8CIs538/8uyCLaBeBT7pl6LRWIQ+gNI4xUVPQKcBmCmdtKF6O72hmLVeP8IQXmOqojgsvaBmkBod4x5IYWNX3hYpf/1vxLYGX9oklJPFtxQomG5hKCK/MXYGIPMiUN/QSwxnt2RoRAH1eu02ZFf0LOP/LLW62D1mVlmUo1RqwsvD/kfGpJjBiFE4LoZxE4pbCelZGsJxXNrX/7gwcjoNSqWSZgOcOBFi7aKeavC1eGrGPqGC7m8N8EXvHXz9no+0XgEn3Crf71DxYaMtnzTv1mOuzIKOKbncpa2+XFbII0ad0kg2WrDZbHYZvc13ME7DAldtnUIIEQb0N5tOwVK0kdmOo8P2Az0h/xjM2K/+frQs44+nvEZsRdAi8Knqleh/SuLYnpd3gEpvZm5CnWZ0Y0btR5o+abycsp86ApUbMG30wcuPG66M0a/xJQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(7696005)(82310400003)(4326008)(55016002)(336012)(70586007)(47076005)(52536014)(8676002)(82740400003)(316002)(26005)(33656002)(36860700001)(2906002)(86362001)(81166007)(356005)(8936002)(450100002)(70206006)(54906003)(186003)(83380400001)(110136005)(9686003)(478600001)(5660300002)(6506007)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 06:13:34.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e9c6be-1e7b-4a6a-96ee-08d936d732ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7090
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Wednesday, May 19, 2021 8:49 AM
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
> Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Heiko
> Carstens <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>; Christia=
n
> Borntraeger <borntraeger@de.ibm.com>; Eric W . Biederman
> <ebiederm@xmission.com>; Darrick J. Wong <darrick.wong@oracle.com>; Peter
> Zijlstra (Intel) <peterz@infradead.org>; Ira Weiny <ira.weiny@intel.com>;
> Eric Biggers <ebiggers@google.com>; Ahmed S. Darwish
> <a.darwish@linutronix.de>; open list:DOCUMENTATION <linux-
> doc@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-s390 <linux-s390@vger.kernel.org>; linux-
> fsdevel <linux-fsdevel@vger.kernel.org>
> Subject: [PATCH 06/14] d_path: don't bother with return value of prepend(=
)
>
> Only simple_dname() checks it, and there we can simply do those
> calls and check for overflow (by looking of negative buflen)
> in the end.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: Jia He <justin.he@arm.com>

--
Cheers,
Justin (Jia He)
> ---
>  fs/d_path.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 311d43287572..72b8087aaf9c 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -8,14 +8,13 @@
>  #include <linux/prefetch.h>
>  #include "mount.h"
>
> -static int prepend(char **buffer, int *buflen, const char *str, int
> namelen)
> +static void prepend(char **buffer, int *buflen, const char *str, int
> namelen)
>  {
>       *buflen -=3D namelen;
> -     if (*buflen < 0)
> -             return -ENAMETOOLONG;
> -     *buffer -=3D namelen;
> -     memcpy(*buffer, str, namelen);
> -     return 0;
> +     if (likely(*buflen >=3D 0)) {
> +             *buffer -=3D namelen;
> +             memcpy(*buffer, str, namelen);
> +     }
>  }
>
>  /**
> @@ -298,11 +297,10 @@ char *simple_dname(struct dentry *dentry, char
> *buffer, int buflen)
>  {
>       char *end =3D buffer + buflen;
>       /* these dentries are never renamed, so d_lock is not needed */
> -     if (prepend(&end, &buflen, " (deleted)", 11) ||
> -         prepend(&end, &buflen, dentry->d_name.name, dentry->d_name.len)
> ||
> -         prepend(&end, &buflen, "/", 1))
> -             end =3D ERR_PTR(-ENAMETOOLONG);
> -     return end;
> +     prepend(&end, &buflen, " (deleted)", 11);
> +     prepend(&end, &buflen, dentry->d_name.name, dentry->d_name.len);
> +     prepend(&end, &buflen, "/", 1);
> +     return buflen >=3D 0 ? end : ERR_PTR(-ENAMETOOLONG);
>  }
>
>  /*
> --
> 2.11.0

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
