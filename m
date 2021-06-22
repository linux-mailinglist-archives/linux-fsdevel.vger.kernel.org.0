Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71083B0666
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 16:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFVODU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 10:03:20 -0400
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:47520
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229988AbhFVODT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnHfCjZv30toqfr+N22JMmOqqvG+atk61Q2W43lfaCE=;
 b=37VpWXkgRd1idmlq4/6H37xfIPFsqocGaOUkuxm7kYC6QxtvLZ0//M9SOnaKADL6eBhlonKWrFUN3s00RGJdiTucY8ScKpQUuDCjF3En50DyyO361o06XOotvVT0FdGu8d07FHnlPcJcBFXQa3JXfB5MGRtHHHd4vLo7AkBG/DI=
Received: from DB8PR09CA0033.eurprd09.prod.outlook.com (2603:10a6:10:a0::46)
 by VI1PR08MB5503.eurprd08.prod.outlook.com (2603:10a6:803:137::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 22 Jun
 2021 14:00:52 +0000
Received: from DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::92) by DB8PR09CA0033.outlook.office365.com
 (2603:10a6:10:a0::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Tue, 22 Jun 2021 14:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT023.mail.protection.outlook.com (10.152.20.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 14:00:52 +0000
Received: ("Tessian outbound 41e46b2c3cec:v96"); Tue, 22 Jun 2021 14:00:51 +0000
X-CR-MTA-TID: 64aa7808
Received: from 64119074d7b3.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B4FE79CD-9A9D-4F7A-9B42-56821FBE597B.1;
        Tue, 22 Jun 2021 14:00:45 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 64119074d7b3.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 22 Jun 2021 14:00:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiU0zPIVB8rfzoqccylnTN+MA6rY/Bx2est1buDdJZgHSMzTYIugTrY6WdGiV/q6+l8pJU2zXVDUijyq8+QPIu5M2P3GKFDFe2FoEcRr75PYHIk9YO8Bf7Ixn8MVW0KSxE01use+vJfhc16uF/E7k41zPJowRu0+U1nz0OBZg52bwCkxK0SF2Rajhxm911EtQpQV1CmsfSl6Vy6xDr96y+VNsrTaEc6vLUhw8Y3iL7CV41Pgl2ap05ncjn5n2Wcb5bERAOL+8HgoU882WVTjh9bTqZ96Qnnf9IcssGpr05OcCFU3QTsvB3xG7L7MmDdIAdbVxgPRw6trs8/GyXc/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnHfCjZv30toqfr+N22JMmOqqvG+atk61Q2W43lfaCE=;
 b=fnHS3/vbP9nvqWeGb3TZo7zoDurYH6+JIgKChwpOZ/atCTvYdZ1Zd2qmVGtAG33uijn3j/o6FenCHqC+ZDrxcjp3DgljqE98SbcpuU6/NB2WVS3BSxQIVRwtkuSpOA3EVbIdA/+sozjuWirCWD/AuxwiJTUdwC5DzUTOj2rG1/dl6AIzYJFr0Rhy52A1F5/hIIc6923p5z7jD4nxvT2zSmqYq3zfKChZQivSNUYIJHFrjzLERJRV7oq72lWalCEnWrSHijLnuJgRYmx6NWATGQF6XFH4T3gOVDe17rpMNWoSMjBjkrsY5CxsFe/iZQmHr9y0iyz0f9WbXfoV53Y0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnHfCjZv30toqfr+N22JMmOqqvG+atk61Q2W43lfaCE=;
 b=37VpWXkgRd1idmlq4/6H37xfIPFsqocGaOUkuxm7kYC6QxtvLZ0//M9SOnaKADL6eBhlonKWrFUN3s00RGJdiTucY8ScKpQUuDCjF3En50DyyO361o06XOotvVT0FdGu8d07FHnlPcJcBFXQa3JXfB5MGRtHHHd4vLo7AkBG/DI=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB5973.eurprd08.prod.outlook.com (2603:10a6:20b:23f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 14:00:36 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 14:00:35 +0000
From:   Justin He <Justin.He@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@ftp.linux.org.uk>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, nd <nd@arm.com>
Subject: RE: [PATCHSET] d_path cleanups
Thread-Topic: [PATCHSET] d_path cleanups
Thread-Index: AQHXTEf+XmXF93T8KEe512bWDNoYjKsgQ77Q
Date:   Tue, 22 Jun 2021 14:00:35 +0000
Message-ID: <AM6PR08MB4376B6A584FB549FB27AE626F7099@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-2-justin.he@arm.com>
 <CAHk-=wgSFUUWJKW1DXa67A0DXVzQ+OATwnC3FCwhqfTJZsvj1A@mail.gmail.com>
 <YJbivrA4Awp4FXo8@zeniv-ca.linux.org.uk>
 <CAHk-=whZhNXiOGgw8mXG+PTpGvxnRG1v5_GjtjHpoYXd2Fn_Ow@mail.gmail.com>
 <YJb9KFBO7MwJeDHz@zeniv-ca.linux.org.uk>
 <CAHk-=wjhrhkWbV_EY0gupi2ea7QHpGW=68x7g09j_Tns5ZnsLA@mail.gmail.com>
 <CAHk-=wiOPkSm-01yZzamTvX2RPdJ0784+uWa0OMK-at+3XDd0g@mail.gmail.com>
 <YJdIx6iiU9YwnQYz@zeniv-ca.linux.org.uk>
 <CAHk-=wih_O+0xG4QbLw-3XJ71Yh43_SFm3gp9swj8knzXoceZQ@mail.gmail.com>
 <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
In-Reply-To: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 5074917919E2E34085772B63EFEE090F.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [223.167.32.100]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 8a7b0c18-525c-446a-0277-08d9358625df
x-ms-traffictypediagnostic: AS8PR08MB5973:|VI1PR08MB5503:
X-Microsoft-Antispam-PRVS: <VI1PR08MB5503C7B22FAD7CD2D7F180C5F7099@VI1PR08MB5503.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:3276;OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FqX/Nc8pQ/nl/gz6btkMkhGBEvmWnxNOii0ts4hQk4OgllBzS2k+yv3oRQSOkSEm5PVVyBmpY/k9WQpMd5J8Pt0i++1ihQnne3hlUewz4mYx4jrRO3Ps7S0RNG2NemimRI0fnvOm0AhMrnXT9ZEcOEOpORLXeNFIwwqhWOQwzWOw7bVWfrGGL7opexit681JZEoTPmFAOTj435P+ZO6nwYjy44cKcQ2c6qjuhqNk33tssdo+20V0hBAuGLCWeH0dbwjjAO4KeJ+gp8kTBc+wVAS5yRHRRU72otTKq03Tz1nGurhPW1h3cSAB6grFn+qezjtxnw/i8zz62W7y5bomEL9a8rqgOFvS/M95RHwAHaFeCPAOKyy8Wg0gNKpIu86L0v73anJA+lOcYW50bNQpbX2fdfHz2VHM34I4nm7M9hiPVQZ9QAY+++WEXx63q2giilMmFzyZ5utX4rJirW6X/Ok92qiyJPO6027HHM+8Hu+XWg0iMq3TmPp9YbXnzeJFXwxXz3/cjVeAI2timdO6M16QOVhNFpLKmGzVWWgkjsh8BhkY4jBhL/XTbeImCpJ093R5/Wo4uxksK2eP/YJyWA2g0qzSR/sDgQEkGVk0XuYGNV1Aa0BcTW+0QDcXfhYJ9PquB+kGhi+LsGK8Li6fNg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(122000001)(66556008)(66476007)(64756008)(66446008)(76116006)(86362001)(8676002)(8936002)(5660300002)(66946007)(38100700002)(26005)(55016002)(7416002)(83380400001)(498600001)(54906003)(33656002)(2906002)(110136005)(52536014)(71200400001)(6506007)(7696005)(53546011)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wQGhmLcH7EH+iQSmzB8L3T1wZ69vyMjvfuVVCv9Kcz+qqjmT9nDqXrAJHbW7?=
 =?us-ascii?Q?IW61G4+rrf5wCBnhmXlHuNyOhkcBWutbzpodKeeaqP7kuNG1Q9/aWIIAl1P6?=
 =?us-ascii?Q?6dbjcI+NOJ/WXCKCi69z1wTg5//veF0MD1TixcRmKvjeFr3rGdR0tZdX48oZ?=
 =?us-ascii?Q?qhkOypPMfcdKZA0IAcVrBa5H7yoeXvoxNpWCM2H3pvW+J1vq0kecuNSnWVWB?=
 =?us-ascii?Q?uY6rApHCBDzFEu26LuDnbk8gAuCo3PWqlUK2DLemQf6RhKF1NCBcG4+6RUOS?=
 =?us-ascii?Q?wfNY8Rl739oI8RZ29R1wqYrZk2iiG7ZXVufZCD5Fqgy7FoIO4RMETJ4r6BHg?=
 =?us-ascii?Q?we9tDk3qOMcOt9IjEfg0+yqrMyXEm5GRmdUxJbHtw6vcfbmz6dgIMFH3ccS+?=
 =?us-ascii?Q?VT6Dv1zsYHxFduvtEGp1nvhevL2ux1nD9yKj5uc335k81tcPAEQiFxfWlJP0?=
 =?us-ascii?Q?v+7mRG4rvve76EcihkkP5HX6UOYrpN8qG3JLq80zlmnx92s+Frg7fNZqVc2C?=
 =?us-ascii?Q?DXCB1CqQgk3BE+1lNcBP+7HDR2n0vBxlAcb6DlEQgA9/c7xAeTU58+wieNpb?=
 =?us-ascii?Q?dH3wwujJfZYZwH/eVvVLUyU/yMMug86i6hc5/Obq/RrOxvK77i7hM3Nn4/hz?=
 =?us-ascii?Q?T0q4tSSjUs0r88Ws0h6Rgf45yxW6+90EWtqVv7AYQ7TNcR87xfounVQXCgw9?=
 =?us-ascii?Q?2kUTq6WuRI9eoUweOonDTa0tuVlLawDB50248j3WXcPYKXxfewlN2NXwlfmE?=
 =?us-ascii?Q?zntnJGfP8gWncAB1UVlCjivSJ5ld9fpbdB+oouf65HeB7iM+scbZe6Ckfuiq?=
 =?us-ascii?Q?mTchGGZLcFwuwpA7tVBuMiGL0lQ5AvO274bxb/rGMDO8VmS6Gy5vyqD/eSPY?=
 =?us-ascii?Q?f2AdJs3GpAgJzenicfFdP3YQYZCjOq/vg1dln/pU2Mc1C9XscOTyal2LogvD?=
 =?us-ascii?Q?71tnJu+zunsie8dXqxgCTRtLYff9e63aOE9/tO4Af+QcvgWwBQsuTJ22rUUw?=
 =?us-ascii?Q?0PtesVCNBmxqPbR5fL1+uCjVxX0TOOr0DTH9XJk+e4rSsD/b41oh4QB0qEsM?=
 =?us-ascii?Q?JprD8ZtCSWQ5bunoQjCAi5vzxdmbHQAUHi3J65XVGNZiI7dWxendah+PTUF7?=
 =?us-ascii?Q?dfzcVOh8CK9ObPEEckFUYCfpLHDotjMkLSFCtc+C9NAGPsApCmRekZZzk47s?=
 =?us-ascii?Q?rALUpyg3u/DYvd4M/YbmH97gqc/QZCFeWHrAarfjdP10ZRj023jb3WI5GyMX?=
 =?us-ascii?Q?hdnLT3n4pgffik2d441LwRa50iHIsywv0Fp3dAzV1XXCdK5ErbGwgyG43a0p?=
 =?us-ascii?Q?jwzhs0KlENJ5lUQ6/TGQvY3i?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5973
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: c1d862d4-5986-448f-b30f-08d935861bea
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6BgsLce3RMrgXLAX12t+wuoQ/UNhKImNzFoTIcSAk5MeV36nAgXG4GAYANqPuNpOpAxMmUglNdr6igHFZzoFvPYEjEbHIudPntqsaJeyQ2Uv0Vt7ZOIpB4Jvjtx2WocPB1GZdARM5QsGPJGrM6GfHFiGbxD4K9jTnoZVgDxIHWTql3Cr77FX9MhBBH+oxw6nHODz2T4C+4wdB5OwJPbeqMTHHrWQuOMcm01SbhA4vDBzqK3YoogAbD9R2rzvfN4ACsMku2NWxHkmrr9X+LFaWN+SyZPH7sS/TatePejEteJnfz6ygNxsFAySmWpAbZTiSGacJzzTXKMlDP3dKEg9tjR18wO6GX8y4rmz73KDj+JyMyaGtgyz/0rPkcF1NFMXb68wHbEC091OboUsieOJ7aBSIa6YYhERaJ1y+q+WDdcoZz1jGxljG1db0nh9imeExXn+xKTW6ZdKE2nCR4vX2RuqSEWf7EC/BSJecuHPP+QiskoDmljQPKeih1JBfxXnaiWtyqOOPYBFYQJxQLrTFOAXeDzoiWCtN3uB5EP0Skzq3N7v6iN0CpRdsit1HqsVyuYeVpAg+tCR+BXUibfJ5KOcLT6KOsSiBigoZmtuEN4iIR8ZVKvI69QiIcimsKZkyXJqzzzk8g7YmWtn04N0TSWubk1Q9MsGCC22py01wQ=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(46966006)(36840700001)(70206006)(53546011)(6506007)(356005)(70586007)(186003)(83380400001)(26005)(8676002)(52536014)(86362001)(33656002)(110136005)(81166007)(316002)(54906003)(7696005)(82740400003)(8936002)(82310400003)(2906002)(478600001)(47076005)(9686003)(55016002)(36860700001)(4326008)(5660300002)(450100002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 14:00:52.6737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7b0c18-525c-446a-0277-08d9358625df
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT023.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5503
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Wednesday, May 19, 2021 8:43 AM
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
> Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Al Viro
> <viro@ftp.linux.org.uk>; Heiko Carstens <hca@linux.ibm.com>; Vasily Gorbi=
k
> <gor@linux.ibm.com>; Christian Borntraeger <borntraeger@de.ibm.com>; Eric
> W . Biederman <ebiederm@xmission.com>; Darrick J. Wong
> <darrick.wong@oracle.com>; Peter Zijlstra (Intel) <peterz@infradead.org>;
> Ira Weiny <ira.weiny@intel.com>; Eric Biggers <ebiggers@google.com>; Ahme=
d
> S. Darwish <a.darwish@linutronix.de>; open list:DOCUMENTATION <linux-
> doc@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-s390 <linux-s390@vger.kernel.org>; linux-
> fsdevel <linux-fsdevel@vger.kernel.org>
> Subject: [PATCHSET] d_path cleanups

For the whole patch series, I once tested several cases, most of them are
Related to new '%pD' behavior:
1. print '%pD' with full path of ext4 file
2. mount a ext4 filesystem upon a ext4 filesystem, and print the file
with '%pD'
3. all test_print selftests, including the new '%14pD' '%-14pD'
4. kasnprintf

In summary, please feel free to add/not_add:
Tested-by: Jia He <justin.he@arm.com>

--
Cheers,
Justin (Jia He)


