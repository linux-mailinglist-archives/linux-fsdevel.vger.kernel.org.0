Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4A3B271B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 08:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhFXGHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 02:07:52 -0400
Received: from mail-am6eur05on2063.outbound.protection.outlook.com ([40.107.22.63]:31841
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230257AbhFXGHv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 02:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtovbDbHJG+y0XvZWQcG1iEUfV8ZshPdSI5UdXu63iM=;
 b=w2vErsd6NJFp+GNNkV38RwkocD9vAo/iKz26CeMc9RZ8qpGAYB/Y57wn2X5fk2kjNwnzajqKT5V+N8tachtrHFT2+yxPuohF+0+WGbUceW1Z1dP8qXDWhO2L0e4dIDG3ycCSObPnsV5pTmz77ljgDNk4KbmB+liR7K2vcKzvGG4=
Received: from AS8PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:20b:127::26)
 by DB6PR08MB2696.eurprd08.prod.outlook.com (2603:10a6:6:25::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 24 Jun
 2021 06:05:25 +0000
Received: from VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:127:cafe::f5) by AS8PR04CA0141.outlook.office365.com
 (2603:10a6:20b:127::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 06:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT004.mail.protection.outlook.com (10.152.18.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 06:05:25 +0000
Received: ("Tessian outbound 41e46b2c3cec:v96"); Thu, 24 Jun 2021 06:05:23 +0000
X-CR-MTA-TID: 64aa7808
Received: from 88f6ea8af959.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 629CA7B3-BA11-45BF-AFBA-7E6713E64542.1;
        Thu, 24 Jun 2021 06:05:17 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 88f6ea8af959.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Jun 2021 06:05:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHKE93Gd9DjLuieLhNNSHGKMKOD+sarN3/8ku/HACciXhve7+kGM6ysfWVgzrwf0v+SUx2Kzq8WH1ChqOSXZmA+Fu7wftiqKAfNYgNnIgOlKvxUIti6vO9lPj/VpBb85RQ0qkluOgvewT5uGbsHlOpBq2jiT6JkXkwtY60vpoREIFFfdsdC4WqZZvOHjq1qwn8aX6PfWaqKnvjz/s64I7PFOT3o/dJz0LexONuIqRgjhz1XAxtRSjXMhoCIjpcbnJnV5ujuPcT8OOgw0nIQC5sO4GO3GcJV+m7CEHJt1JyFtUs9JsXh8ZZzzu9YAo4tf8h53Ji7whb/UMMqM46zO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtovbDbHJG+y0XvZWQcG1iEUfV8ZshPdSI5UdXu63iM=;
 b=kMBVI6lCphYJLxLD9/XcQlzqMBNcrDjGtpzvan8rnnlMFrApNOh7//kTA3TDLEgZgTZiLnUsAdsYzaKFBohZ5LTMgyfIyx0uSHzUKXnZvyfqrubev00+hZA20g81r7GcyxinMt4zp307P+9CifcLJDNz0fRRAHgeL2llatDaRGijR1cvG6PpHO7wkN/ijd+4Q3a3/aYgc2NbA2z7wBzMFaoay1wupgoCa2NuPtwuhMYYNRe8DeLBFB38e5Nk6rcaFo90Pj4l1a1eSye2BvEUCTYr+mw/UGpH5+HzimhVLFC+qgdnZkvTFO1yCZG78bhs4FySyKjGpmZ7UDnkjjc2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtovbDbHJG+y0XvZWQcG1iEUfV8ZshPdSI5UdXu63iM=;
 b=w2vErsd6NJFp+GNNkV38RwkocD9vAo/iKz26CeMc9RZ8qpGAYB/Y57wn2X5fk2kjNwnzajqKT5V+N8tachtrHFT2+yxPuohF+0+WGbUceW1Z1dP8qXDWhO2L0e4dIDG3ycCSObPnsV5pTmz77ljgDNk4KbmB+liR7K2vcKzvGG4=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6822.eurprd08.prod.outlook.com (2603:10a6:20b:39c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 24 Jun
 2021 06:05:16 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 06:05:15 +0000
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
Subject: RE: [PATCH 01/14] d_path: "\0" is {0,0}, not {0}
Thread-Topic: [PATCH 01/14] d_path: "\0" is {0,0}, not {0}
Thread-Index: AQHXTEjHwkw7QNxV5Ue9TUQd/nmVh6si5ODg
Date:   Thu, 24 Jun 2021 06:05:15 +0000
Message-ID: <AM6PR08MB43765D3E0F5768F3D1D960B4F7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: EC1603BBEE7CB94589F5B8CCDA1268EE.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: efe9a083-afcb-49a4-13e0-08d936d60f37
x-ms-traffictypediagnostic: AS8PR08MB6822:|DB6PR08MB2696:
X-Microsoft-Antispam-PRVS: <DB6PR08MB2696098BA462BF57CFCB54B4F7079@DB6PR08MB2696.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:247;OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xjkPd91akNFHBuk9EZoZLvZ2JR38fbjx70ZCg+KL6uSoKplNkEixdlbsQkswXee99wbuxOOpB9E3jeA5Dx/EwQ6G48r+b3wcDl99OtH4loIIJXn4JpVFVS4reF+0UZe2p16X8PcAb+z3xuTh/cuprTp0kROAxTvO//wCmD/EEhH2GA2as7j1gpYTB6wdmSUs3/N3iP6mAx/OcY32GtcIsN3kHdioqZiYJj4rxraukm2EnUV1xJjs6EvT3ErZKRa5gy2IYvGsiDiql0CQ/tryOup6luK69993zJZIVIAoI1doX38PcvdpLjsMtr83vJWZ6hampMGy4Mg2iSyH83hCog3ccMG2nyJ/t0mLJTVXv4FnXbgAARBHKBnnQZcJlzWAcPqV7tdRfXPLoJCwHpHqp2aD7Ay61JOoENL4/ARA0hqwm1NjC7cUJ0G1N7z8ubeSOHhD5rNYvzPpksNS6wqqFuZLE0tr+RFg+bIAiY1IOhgg2ZCUYjO1BxPO9xxIDrJUFriY3jhjWZ2AiZlDxzin+HsgR4uXKPyfFYeA/nntI2XIObam+Q/u61U2WRmUitWD8SFv+jtsRYBbepA5g3nuJgti9kokBVXKq2qD0TPaduAjRW5BXFNurs2w9u4a5+Gc4DSeaBnW8BlBQdPL/4X4SQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39860400002)(346002)(366004)(54906003)(8676002)(122000001)(110136005)(38100700002)(26005)(7696005)(6506007)(53546011)(8936002)(186003)(478600001)(86362001)(33656002)(52536014)(2906002)(83380400001)(7416002)(66476007)(66556008)(64756008)(66946007)(66446008)(4326008)(316002)(55016002)(76116006)(9686003)(5660300002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MmuoNW3I+zZCel3a9S9ED0m9dyQY77qBqitum1F/Dd5Dg/qu9Tat8bP/pUNs?=
 =?us-ascii?Q?xh2d7EV1IUXsRSQFg5WwZDMURHRs5eT4FfNf1MSJsYZtO7Wv599N3OK2DwxM?=
 =?us-ascii?Q?GARFtw2x2sKcaJLX0mmksL4DgcX2lXPH6BQLOcTOM2APaVPRUdknrlmuzCpY?=
 =?us-ascii?Q?zFMnCYVysVWA5rYgYCdwQ2HG9QOqJz8QxH3QAygkRFe3eaumU6f2MgS7uIk3?=
 =?us-ascii?Q?xFT3qw8JggLLH/n9wsF2EPffs0zqxvPzACkpEnXkpljzeoDxl0/Peq6V1aR9?=
 =?us-ascii?Q?tGxvBPqySsGTsqoHePeoP26YeTQM/y2XYKRlFGrdz8NOi+W2k9CR+4s/i49i?=
 =?us-ascii?Q?vtutzjQyG0pBzmC45BuQbmmYJVBL56/KBWdhuYWUKaSzUN0YkfxL1c3XUxoT?=
 =?us-ascii?Q?vKTtqcX87C5V40u2UfDxtJJeSKiBhZ67wCefyNgs7ZVDcG0R7r1KmIEseobz?=
 =?us-ascii?Q?f6es2+rZhYPz+viR3aFIKKfEclwFCf2OpULawgI5ervQ08yk3hZbjTPL2oIo?=
 =?us-ascii?Q?Yhbf0qVrGqVK7eX8m2Lscv1j2CMizqYlhqhJRfMhsywsSO8r5T4LsX9Q9Gy4?=
 =?us-ascii?Q?BHN4szvhKXHC7h6zM35vmT0k6KvJTJSCHN446URs/fARQZVC1ryGFYyaVQQ0?=
 =?us-ascii?Q?+rzd3E4lBEmd3vDjlC5eKDzhEIiBz3XlHkuYSR6vTyb4lxtRSZUJsedLa9T9?=
 =?us-ascii?Q?IL90YfgYUKTpJ49l8TbYhVVpEtAL7U81sq2Qx7D/EyxfwM3VwJc7y/a9mr5g?=
 =?us-ascii?Q?FyqGwfGAZMJqTJwbDE2tm6nWgeX8GCUP5CUj8rznuvdfdLKjs9UVbaAl2oSV?=
 =?us-ascii?Q?A1SUHbX0LN49U3qwWwRC7s1sdTSU/qsMNTE9letBJh8+xsg97exBZvi+Au04?=
 =?us-ascii?Q?pZTu4einuZMWROK9Gy9W8Tz/1n6zk2dxJVsVHza1zHzNN2AoBIvkFWIgVoxa?=
 =?us-ascii?Q?QtFFNSzNEsP0HYQSB5ptn+WIUJ2MPbUkaUxzpVaxTCDGKy2LCRJKElPgTGge?=
 =?us-ascii?Q?C2A4q3O9Vv1DFzRj2fZXvgX1ljInTsdABwR2FD73JmOWC1sQRs8ETDkV66Vz?=
 =?us-ascii?Q?0ZXtVvlf/j4OZQBrjPxYCIjKlYRRxamiDn63dhZ6T9SvwBDRU85lzV5/gJ6x?=
 =?us-ascii?Q?A0+bU3XECXMulq5YyOAj7GZ8/rFPM+TnnlSmf53a+/UfTGPx4tLOU6SgSZrm?=
 =?us-ascii?Q?GXhg8fgvXMKIrGes4rTorw1+LpQc2h8EWANpOv6EkoKgKsJpDqfxB2Vg3Ces?=
 =?us-ascii?Q?QaaKtG/fFx4AdnKGGx0NZM+Y6RDR7W4DOONz6hjDnIriDYikwFa7X49IJ9UN?=
 =?us-ascii?Q?9L8NmW58lZ0xa4jkPr612lFm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6822
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: f4128585-07ee-461d-fa53-08d936d6092c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvaUux3jP6S9P95q1xgt/ylCcyv7kEtBCpFSesWnPMWBRo0f8aj5Xx+znovcnu1hrygfIIDTWq73im3LK1Xc9C/viJd/A2hiCO9DUIr5vuOh6KWqU6ayZ4u7ecW+ucD+VB2uLXSoDSjZX8j3oFbYNmAb5OBGG/kQSvRL3FmaRE83TrR8gwj2Qog1kLVz5iQXwJssSsOqZMrmt5rNa8wPYD+A0kI16m3tR5RFlX3PAxUtKqpLPkMvkYc7fws3HTksqNTQ2G4fbyXES4KOSD5DETl1gjWyLuZVuNgVvHmNN3pTgOZo0nfsqDw2Aj8ctG1muJK4XkZD07wNSF4HGCcuO9VSN0Vm9YYyG60S5jef1f1f63ckYDpzFxukQXjveeFMroG+A5uqUR72TjQWnP5hivKOBFfUsoFtSNBMta21+smyr/YqRgX5MbWpd+8GU7nV42F/5nqPE5bnAZ+pO5jsbPpSSyGhUcZ0hqxjuIWvXip6QscNvKW+/6xsMyPqAkr0wKN5ZvCES73QvvhwnACOfx4x9e/3EEXs91SIrVbJUyKAq0Jx1rmalheVhl29KGSQKFGN7PRe95JowPZuVCb4GQp2MdAkt9vCPSdOMkBLjTFasCwEe1iCa/oaC01Irc2HCY+qcM0GNxlocIW9prpOgQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(8936002)(356005)(9686003)(336012)(450100002)(86362001)(33656002)(7696005)(186003)(70206006)(2906002)(54906003)(26005)(55016002)(316002)(5660300002)(52536014)(4326008)(81166007)(8676002)(478600001)(82310400003)(83380400001)(6506007)(53546011)(36860700001)(47076005)(70586007)(82740400003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 06:05:25.3136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efe9a083-afcb-49a4-13e0-08d936d60f37
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT004.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2696
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
> Subject: [PATCH 01/14] d_path: "\0" is {0,0}, not {0}
>
> Single-element array consisting of one NUL is spelled ""...
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
