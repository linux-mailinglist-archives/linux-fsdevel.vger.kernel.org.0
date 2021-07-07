Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F341B3BE231
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 06:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhGGEx3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 00:53:29 -0400
Received: from mail-am6eur05on2056.outbound.protection.outlook.com ([40.107.22.56]:38506
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229989AbhGGEx2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CF1slwiDkalXwfRs1Z8DupZBNxhfZEd2qyoS2z0zW4=;
 b=xqxa0gvPIk0LcI7QIdZYGSpZhv8mQchDIApQ+UuLN12TuNA2qSEiDBztst2fXQHIbRb2ZT5DOUSwHag0TVnutNeMnblBUolqrTpnj0wtJoEdry/dAx/l4d2n/FZaMkbDyJtqozO4v2XougWm69y5d+vaHwuSZwzckImiqprju5c=
Received: from DB6P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::31) by
 AM6PR08MB3735.eurprd08.prod.outlook.com (2603:10a6:20b:81::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.23; Wed, 7 Jul 2021 04:50:47 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:29:cafe::ac) by DB6P193CA0021.outlook.office365.com
 (2603:10a6:6:29::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 04:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT018.mail.protection.outlook.com (10.152.20.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 04:50:46 +0000
Received: ("Tessian outbound c836dc7aad98:v97"); Wed, 07 Jul 2021 04:50:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from e0d2e8363e55.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1B6FAC8B-B3D3-4D9D-881A-D636123C7AE1.1;
        Wed, 07 Jul 2021 04:50:39 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e0d2e8363e55.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Jul 2021 04:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu0mnAR9P6johRMQ3/8CU/fTdI5v8V3nG3DKocLF5AcDCwGljkgmNIi2Vfod+qlGbqszVdNAcQ/4T6A9t1ygkvUpgV0qyWQCt7qAPmP1y7vubk6dRQIFhH2BhVz6Tbvip4KkpYp2RHglt3lLLZjXd1KRbskX9iUsVd7KiTAyTh0gG24o3uif4m9Z+/vtHEgdHV6NJL5MCQajKZT/eIeUsUd19ool7W0tPIvw6nsvbbSPKjx4Jdmj2UcCcv0FV32xi603Ur6ZddHw1BftmIF+rlSygjnNaIHfeTCU4eMLCINXeOHaQy8HmtSWhxrdpmMzjnRWzBvkUhZN6mXDwtoKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CF1slwiDkalXwfRs1Z8DupZBNxhfZEd2qyoS2z0zW4=;
 b=aym2OPbi1+8gYA/8i0MOrNK1s56d4fGOBJO7GlYoJOBGyRavdHCa8Ys/zZq7Kx+sjJ3RlbBOMCRapaGmUtFZhbEvSnspP/x0tppo+hTafNoezEFsxqFRaoQtmRv8XDfEbIfUEWcN0GhQ/fGE2EovL0sRHaxrSHcehUGhHX5yrvpVNxgB7KJM9rSil7B1hfXb0yV0c07Uk+wg1ijif+VYox6YLsH6G+jHGvfAdfVTHBOgMUfxwBwdBOZuG0UsyXIknasIfFU1rXPGJiWuyO3Q96LvZDM7XR0sjfGHWzCXXBnMQ0O+Q0ejy1hhSI76Xf1TAYFlCPZASglEZm4OkYt2ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CF1slwiDkalXwfRs1Z8DupZBNxhfZEd2qyoS2z0zW4=;
 b=xqxa0gvPIk0LcI7QIdZYGSpZhv8mQchDIApQ+UuLN12TuNA2qSEiDBztst2fXQHIbRb2ZT5DOUSwHag0TVnutNeMnblBUolqrTpnj0wtJoEdry/dAx/l4d2n/FZaMkbDyJtqozO4v2XougWm69y5d+vaHwuSZwzckImiqprju5c=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6994.eurprd08.prod.outlook.com (2603:10a6:20b:34c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 04:50:30 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 04:50:30 +0000
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
Subject: RE: [PATCH 03/14] d_path: regularize handling of root dentry in
 __dentry_path()
Thread-Topic: [PATCH 03/14] d_path: regularize handling of root dentry in
 __dentry_path()
Thread-Index: AQHXTEjIzjkc7s5AukulO5MhE2mNX6s3PmiA
Date:   Wed, 7 Jul 2021 04:50:30 +0000
Message-ID: <AM6PR08MB43768C8B3857136097ACAAFDF71A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-3-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-3-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: AFC7988C2CEEC74C9236971C6538A288.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 17aa982e-cf98-43fe-2e6a-08d94102c935
x-ms-traffictypediagnostic: AS8PR08MB6994:|AM6PR08MB3735:
X-Microsoft-Antispam-PRVS: <AM6PR08MB37355AB73007507BE544EAEAF71A9@AM6PR08MB3735.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: S2yO+YCOiccRADhtR32gDATOnyjPccvlYohQJjLgl4uHM2poIaVKhqWruPlMDc2ixnLWlw1zi+QUqZh6GFGyOah3px1afzT51h+1uZ3wvYd+76nDYXk6PEyPN/vyN9y+EAXIaKn9eMX8Ma/tzpAFRhMxTNaH7zrXE/zVkLPz3pxaWo5qo/R2NPFI4m9HT7DeowV9ZnnkHxD5VtqMUQRw7OqRAQahkMUIL2fNPosfAXF2HQMvXp/HLjlndxtVallyfwNBIxr8TyIC20AMtZsB9RUkzlZr1yQyBaD2Z0GZj1A5W4nBe3BTxceV1F7EjPZBUA53fUGrJIp2I/80wArUJIY6C+NCJ6VoWb3eTWyd9hfk6/2evAeI7ZG4iiKEmD4Xw7670CBY2OISosP95ZQyQ25utau8MTW5vGi1W+R3SXUsHCmwwfY0V+HU3+8xw/hmoU5oXwwZOVFWRh3XhaqtorKe6GDiO6tNI9u3C7MZ7usSW6h/iIvqWkPUqKbsaiaV6juShTxEeLxNmM426icXsuGH/rscrAFg5WXLIu9tYrYQOFDWg5H2fsMlAxr1MTHHMUc26osph6KhPJRAK5EPftrElbEBQS+1XNFFmYQqwFAvgt8R7foSldwyV4ac5gFAdnK3mvqR/XC71Kh0UyAXZw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(366004)(376002)(346002)(53546011)(66946007)(66476007)(6506007)(52536014)(76116006)(83380400001)(38100700002)(26005)(66446008)(86362001)(66556008)(64756008)(186003)(9686003)(110136005)(122000001)(478600001)(316002)(54906003)(4326008)(7696005)(8676002)(2906002)(7416002)(71200400001)(33656002)(5660300002)(8936002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CCZ8quxOzeNJFfnZM4pILfvHv8hxUSxsYmGqwRjMjtgm0fjgWp1dESRwSX29?=
 =?us-ascii?Q?023E/o4rRbnbTFk5nFX9qFAt79zbDi8vDNe7xjT7oP9ULNm3u5O84OPSIeGG?=
 =?us-ascii?Q?x0LBMv4RuSzXwSo7O+c8acJGG/+JNS2cBR4WGdOHwaWM+fJcvDQc5qkZlVbI?=
 =?us-ascii?Q?DgZWEM1HBVMCrR4L4oykPSPxQJkzTnAvtr3vAuqPFoSXxW5Pl7Jetd0m5UqJ?=
 =?us-ascii?Q?P5ibGQ5oVJRmvbxebkYWT4PmsqMnENhEKmqKqdD9oY9+dG8gm/5KECciBylM?=
 =?us-ascii?Q?B2NaYylY7GtYpBOyy1K0F13sR2PgiRcqt2j/RvzQsu2QMALudzjbjMCW4bvJ?=
 =?us-ascii?Q?4X+3/AvVVX6hWcRax6GxR82VV+1vIJg5Vh4JYT+ChUr6/49ulFKS0sW2Iuzr?=
 =?us-ascii?Q?xSfNzN/JQExo65SPGo2/ORzjyYycdgtBg9kVmwBljUpK1wTacAoAfB/xBA5C?=
 =?us-ascii?Q?PNnUxV+cNTaRAz+PBs3wCeV+C3907wd/y8bKAVioLdVevQKB7T0NXuBuims5?=
 =?us-ascii?Q?xD4H7GITDqDlu3lCjE1mLbQvYcFSsMbJHjpH5IcOLhMLCOcTYaTFFrwA/QJF?=
 =?us-ascii?Q?Bfk8qwHHsO7w5oWWJIkejIuweYXuTA/Qu683+2dzNTT3X61zxLkeqS4/UxDE?=
 =?us-ascii?Q?io7iVPIbNMt9qPWCz+SrDJmyJBM95BsvikiJo44R7YPi1ApRT/kpYjKblFmp?=
 =?us-ascii?Q?Okag5lZFGJ+697zjEtsQbVP9N5+/gi+snf56QjcI1+Cxy1Kghhem0Gf2gJxS?=
 =?us-ascii?Q?n9ynVjGXeLkFZFd1p2WSv9crt4aK0oDD+4qHWhIUjosmclmXDP0XAijvqOdF?=
 =?us-ascii?Q?sqezaSvz1pOCIfN46IeXvRuhnqEmTllq/d02hWHjW6nfeFcmvGwVJu58mW9o?=
 =?us-ascii?Q?6K64kpy6DnHVYJPcg+IPeHyIzSCaclzxiu7/LiuxQhKXS0B/iyi5XVb8E0R7?=
 =?us-ascii?Q?5gEyMqYU76KaRkt5NEXIAgXBdqfTqFWvVtmpt3mEo/H9PLN3B7z2G6fSCuui?=
 =?us-ascii?Q?m0mNc6MarfOvknhB3+Pr7e8xnUSzvA6UJNNV9EzL/LmytduqcK9G/N3mDojL?=
 =?us-ascii?Q?azv9+0CVqAmf7KgofcdB6GfKree23P07namTgvwzh0pVGDTcBAjls3RWYGH8?=
 =?us-ascii?Q?RPf4iLnFudp/U2AcIBZsZQfqFqZmYNiwU/97EAavNvP370Vw3WRbvy5ljiDB?=
 =?us-ascii?Q?+2dBWqjWkrL6p81ybk28RHEkId85pqvhmlHAW1H2a33vNNoy6bhE8pAnKNf1?=
 =?us-ascii?Q?jrilfb4+FD6FIr8RPRAZ/hepdyBT+VruHVpHrNA//UDsFiI7hLBqStgXFoGn?=
 =?us-ascii?Q?t6R7AZWOUiMIOCoAzPwCClma?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6994
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b2db6d39-3056-40be-9c73-08d94102bf7c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Civy3l5ql/MGXmImmtMMnuohGE8U/qcwpPq/KErY5vBQpAwG2+tkcYVSVcAY7ADx5mGitlhxE/hl/5tSWzZzZpW4bR/XkVOdrlfB/1jEtxUB3ksTNuaf2ihYzov4DoM5WT+EWQkSIxqO9tUl5B7m+o6x0+3l9B+GOuyilIx1gPhRg2FqY8wpmIqB0yyb6E769Hhdigew0l8/TIcd195Uh58DW/iSH/xqVdMV6KBC3H1GluILfyeMzJK1TiYQrO6uFs0fZ9rmRuN3V8D4pluVowO7o/vFE+Qhq9qyT4sHwLhYw4T0BLc35/P2eBvPuS9FjYjhRAMYcjssK9x4G2nqUWdpyQ4qTYV8Sz0j1pMCTDIB0p5XXTGnF6cOHUw5KwfW4cHcMFCuz9UjPYKn6O5AVSuSqHVU2Fbqi8mBgA6zfzE2j1QzytmU4gIErnPYyn0r8RgcOxtZn3YFtRjR2GrJdZ9z3tnMHQES9E0zFZpaS6xbNBkNtEu0wH6EY8LACgHBWxMsB95xZjkeAMWOvZpyMgsC0GkIjiZsQEwVzMuHt6sva/oF/jOQT6pMkmMSRsvU7LxAvoM6zjoiyqOOWT1AWkIcykJ6SdtiZvJ0Jq3WOW0G7QK5R/nLwp0NVGW2w93b4zQvs89nVRcCUSl4t+S3jIw6POR3szAIfsda95SBmEQEXydu7G0YQkGUoXJA5HRa+CnjOExsICRBbVe5UwjtSQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(46966006)(36840700001)(110136005)(26005)(55016002)(356005)(316002)(53546011)(336012)(478600001)(54906003)(186003)(33656002)(86362001)(70206006)(9686003)(81166007)(82740400003)(6506007)(7696005)(47076005)(8676002)(2906002)(83380400001)(82310400003)(36860700001)(5660300002)(52536014)(4326008)(450100002)(70586007)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 04:50:46.9963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17aa982e-cf98-43fe-2e6a-08d94102c935
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3735
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
> Subject: [PATCH 03/14] d_path: regularize handling of root dentry in
> __dentry_path()
>
> All path-forming primitives boil down to sequence of prepend_name()
> on dentries encountered along the way toward root.  Each time we prepend
> / + dentry name to the buffer.  Normally that does exactly what we want,
> but there's a corner case when we don't call prepend_name() at all (in ca=
se
> of __dentry_path() that happens if we are given root dentry).  We obvious=
ly
> want to end up with "/", rather than "", so this corner case needs to be
> handled.
>
> __dentry_path() used to manually put '/' in the end of buffer before
> doing anything else, to be overwritten by the first call of prepend_name(=
)
> if one happens and to be left in place if we don't call prepend_name() at
> all.  That required manually checking that we had space in the buffer
> (prepend_name() and prepend() take care of such checks themselves) and le=
ad
> to clumsy keeping track of return value.
>
> A better approach is to check if the main loop has added anything
> into the buffer and prepend "/" if it hasn't.  A side benefit of using
> prepend()
> is that it does the right thing if we'd already run out of buffer, making
> the overflow-handling logics simpler.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Jia He <justin.he@arm.com>


--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
