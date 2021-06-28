Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8022A3B57D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 05:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhF1DbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Jun 2021 23:31:08 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:59944
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231678AbhF1DbH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Jun 2021 23:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EDHZP/GRhZsqTGBW8CK0Bd5c/AyNZORm+JSokaaM6Q=;
 b=1PUqTD7NJxNwyRdQQwtFYJuFIxp2qfpom+cCgr/8A+i5XOwKYfJeCim0xcJLDa5Sc+bW7wWVPuq/dB/ySWZeJ1feq0wCAsARni3ed7vN5y7OqfKkBSzvvJernWj+hCEJMd/wG3RaQbnMucUR1oStmvRIr1Tu3WlfupyDhGWQFhw=
Received: from AS8PR04CA0024.eurprd04.prod.outlook.com (2603:10a6:20b:310::29)
 by AM0PR08MB3186.eurprd08.prod.outlook.com (2603:10a6:208:5d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 03:28:38 +0000
Received: from AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::ad) by AS8PR04CA0024.outlook.office365.com
 (2603:10a6:20b:310::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 03:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT048.mail.protection.outlook.com (10.152.17.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 03:28:37 +0000
Received: ("Tessian outbound df524a02e6bb:v97"); Mon, 28 Jun 2021 03:28:36 +0000
X-CR-MTA-TID: 64aa7808
Received: from 00fdcb5a7aa1.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7C5E434E-8ACE-434C-BF11-96A547AF8EE7.1;
        Mon, 28 Jun 2021 03:28:29 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 00fdcb5a7aa1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 28 Jun 2021 03:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOS6PyyorPgpbu2PgdKskX6rPJzGRcA2N0tLuadbHV8vpdXlhCu/NMu/m+ePlAP9Uw0sWqYRWKp/4tOuWj1hIkWpkTDQjzfkqVQgyRBxgN1vdOFQuCeFItElx3EJgcN3GAOMTgd78h4GSNvpd412uq3Qut92sKv36Q4mHidgny42l9S0Qe/XDXP+KfzVxOSjklitudYswrwhYjyHOdLnI4vpRX6Yj73DldT/5mZc9zDhnmZRhNhTdWsD/Rr2QnJGaa0Sqcf+fZC0+PHOYvWDWF4sYQle/1RVEh4OGAB2wE2d4q1veVILlc4nb+59e/wgWeU0RUSEk12YQB3iRfEy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EDHZP/GRhZsqTGBW8CK0Bd5c/AyNZORm+JSokaaM6Q=;
 b=eefvUhGv7LNW+HDlF4q1es8ehZw2KN2EvB1m/wj9G0xVEROFSEa546bqwrN6tfOlFIRjGA3X2ku6NWIlUhPoxz6oAATm2HPs6E6G6+uFDGvqtwJX8LyUQZG8+WGyQpqt+yxbRLqosYmjC4cvkLrvy4jF0mdwGg1IWDg4Nae5K1BAM1ifQIKxwf0RUse3YTms27ZPPt65eWRbtZN7qsmLkJPzjjHwXTCch+eY2GiPWU6siWmJY9y07Dl4eylfnlAJzwDrzoWrregh/brml1kGSolEQaAO9gPuBmr2cSzn7WlqqVqUxH9VZR5r0Z0Lvpo0ly7j82zOIrbwihGaOiha+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EDHZP/GRhZsqTGBW8CK0Bd5c/AyNZORm+JSokaaM6Q=;
 b=1PUqTD7NJxNwyRdQQwtFYJuFIxp2qfpom+cCgr/8A+i5XOwKYfJeCim0xcJLDa5Sc+bW7wWVPuq/dB/ySWZeJ1feq0wCAsARni3ed7vN5y7OqfKkBSzvvJernWj+hCEJMd/wG3RaQbnMucUR1oStmvRIr1Tu3WlfupyDhGWQFhw=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6341.eurprd08.prod.outlook.com (2603:10a6:20b:33f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 28 Jun
 2021 03:28:25 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 03:28:19 +0000
From:   Justin He <Justin.He@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
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
Subject: RE: [PATCH 13/14] d_path: prepend_path() is unlikely to return
 non-zero
Thread-Topic: [PATCH 13/14] d_path: prepend_path() is unlikely to return
 non-zero
Thread-Index: AQHXTEjX4vA9qb1/tUuDI9sxRSQuQasklodQgACoVwCAA7zVQA==
Date:   Mon, 28 Jun 2021 03:28:19 +0000
Message-ID: <AM6PR08MB43769E57C213CD2C92476F2CF7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
 <AM6PR08MB43762B63D11A43FE84849748F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YNYZTIP+anazsz/U@zeniv-ca.linux.org.uk>
In-Reply-To: <YNYZTIP+anazsz/U@zeniv-ca.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: CB6421B20A6A944D9DF13BCBB5286C75.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: fa6a8db3-911a-4a8e-a4c2-08d939e4d100
x-ms-traffictypediagnostic: AS8PR08MB6341:|AM0PR08MB3186:
X-Microsoft-Antispam-PRVS: <AM0PR08MB31869DD834B576AA6095148FF7039@AM0PR08MB3186.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Y3eG7STbpi626Qqz1uuMLIH8TE9bDSNr+YJk7zJTChKE1Q34gdGEj9utoZNhDVM0ymL/k2bnFlsZsZYaWkP4eeDx6MobGJZojGh4cHzl/sl1acwpAQYR5b5slyMijt9YbvO3qZm9Q1g/2zIA2Ed8lua6/mGHiLttE2q3V+i9xCJr56QDkU/eZRG/q3XRSz3TbT0AHepAkYh0TYYz7ZeiF++vTrK3AhUgjwrmz0SEnDYcDbLNfmT5ElT0axGuP59NR0nVmWMRD0kIRAby6PCtJkvuG07Nvgg5K9GRIHyaxyXuAhHX/cEP7hz+nU5tALUr8q2YX7FwOi5W/jghMj+Qhjbw/Sy2mU/cejOxIFXpEsZPmcOLEXKQq08+TnBFUDw/SUyl5IqIcoWGTuFr3k0hyTZhuT614em4MIqJN25Vb+07rUtEkQ2sRpz0TQaYkPDoIb/RxtwR6vjrOeQm66PD4eEc+M7xHxwkXo97bdHbA4UKprLYjzE/Kf42AZuNDEvjiwRaGe4NObTAJldnU0WJx8WGDUyQb8jmlC2atalcW1bOWBd7O1sf5BZF5RX7TrKIf8bRhfmhlGmPJDFCXReMJErDvQvYjhbC/XKcZB5Oe+OMR6fYrkg6IS96kmTqKe5txQy46vdBEy2bc3gdUVvtnxMqpFeIf80SzQGDg2DfQZCfgAQ1pHXtiS1AwWUiTqdgbL5sjhhCfNJWz7nzITyKAaKp3NUzPva+kp/CQOwjl+0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(39850400004)(346002)(376002)(186003)(6916009)(9686003)(66446008)(64756008)(55016002)(966005)(76116006)(122000001)(66946007)(66556008)(26005)(66476007)(478600001)(83380400001)(5660300002)(38100700002)(2906002)(316002)(52536014)(54906003)(33656002)(7416002)(53546011)(6506007)(86362001)(8676002)(71200400001)(7696005)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?neU8MdLZ9yEcqOLKVcMKm6l1Y3loMiUMFOxG2ZazKRSorqB3oLhWxhjHos/P?=
 =?us-ascii?Q?OF1YKmU7YCw1ULfyhc1m/w8fmNobR004UNUAlMsg4n5Y4hmd+LyquO2G9lJV?=
 =?us-ascii?Q?pbZ/QfA2N6uWYNLuWrVZP21kMP00yjN+60dKBdf993pWWsQoV4DKby2zhDuk?=
 =?us-ascii?Q?xOeYTor1a0VQeND8UJv/vRUJOq4y17ID+P5Wg76mYjMf3BnOTLPbZheJ046M?=
 =?us-ascii?Q?UEzXoxefrApqZtZEZUyd3UHbNM1nxZd3pSDHVlP0xDbJRaOvjziWhjnkPlXK?=
 =?us-ascii?Q?d4Ipea5JX55v/tsLZ/XN3L6a+3vg7QHcJgMXDIYKrnol0gaOyZLyxmHF0HHr?=
 =?us-ascii?Q?jPlK+VKCpYCUMkq9BnqhT/8Xigq4DFxt52vlUxjzHuPuxxBN7T1Xe6hDsy3E?=
 =?us-ascii?Q?yULHuPEvfsWmwB49xgTWG2FbfwdSm6kK5Y0bZSsnSlAhnHoOrDp1r07oAKP1?=
 =?us-ascii?Q?/vQsrTjl8/Ffvb5A7lMTB/u9eAaENDXULg5MFzLWN14NINfXpWaO6eJLYXv7?=
 =?us-ascii?Q?ZszVPKClbrQ6gyHr3u5/eFsoH3x9aXBwFZQKZdTGGLpbwnpBbbEdk92OFvSp?=
 =?us-ascii?Q?rBO7pfkkLMNgxEyW38Kfj98GEaV2CnWOBCjUkZ9YlPV1klsh8Fvk9DblQ4EQ?=
 =?us-ascii?Q?LU8adHUS7oMAIWpf29GVVLgU41hOdMUyWsn1bSkSk25Wu3up0c/XxV8lVcH2?=
 =?us-ascii?Q?FQ+FxkgwWzT5NZ4dIaq1o+P5tlyKyBO8jEeM10fVpF4yXTDNx3Z9SqIBry7+?=
 =?us-ascii?Q?rjZcXBaMHb2vCLWXHr626CTe5RFv3i1pN+ES+fl1bjTGHQNrIIU5LjCHZNEn?=
 =?us-ascii?Q?sfU9ysEkP9Oovwryv4vaKD1Mj0jWadkLIxhlq7V/Rqx09l/9GQXnAp6O3eLg?=
 =?us-ascii?Q?VSvsV1xQ6CuPAbM71ytdfiUMor1lUg5rv8bjfcFQPp1NHYd5uHDTDcNki8qm?=
 =?us-ascii?Q?cVoUZUi2Yq50rYzVBTes87tiDU4rUBcEyCLm4cO5erkNZNv94jgMA3F7ppPa?=
 =?us-ascii?Q?9u+C1UQe+7WSpS7nqcr1ZN+a5dAcxCw9B7jbqW4UEew9qGJkjQbH7+j/4cMC?=
 =?us-ascii?Q?jo8J+7OdSIQb1DUEXQ4NWmDwCzrWFisTGN5mbmvct6mh7xOMG5Pt1QVcEb4p?=
 =?us-ascii?Q?Np2RousLMNxHuh3Ldt41tL2ehpna7P1sOxi9VLNVTZZstPDr99AZW/aBp3qd?=
 =?us-ascii?Q?bg2kABm/B/V179zt44Fz5RjRR7ZF2RtQVLkxN0h6IDJSuAsqat07fNnIg5lG?=
 =?us-ascii?Q?B+cgPXYq4FDfcTmvHQjoUqvIXUD2qbUxmM28dyXOenBAhU/QXfdPezM9SFot?=
 =?us-ascii?Q?9/p3dMTeumijBzPdvv947A70?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6341
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: b5db230a-0312-4b26-0144-08d939e4c6c1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QUAlCdr2EYLT6sm/UPbzkm29QhBhXxmnFGhBWnxhTbyHkMDcN3uUnJdIY/pi0E0VCzZa6hZIN6id46qH+PZi8A42l0sKKaS/j1yxYc/xOs3JoygEhuI81nvpyRcV4+0DuUb72ulXM6oKYaf2YAd3Dz8C6noMxrHQV2HEIVE8RDH5yqXMyw6jFUU9DBCtB9QLBK4V2bZjQ6X798PkcZEZ+Y9fVUsuAcBYNIytEPCXXS8dTkFGsbwbPgqPP+Icq1Oz67fiskYLbQeFCnhv0pHHbpxTogJ7Fb33uIPjgijGrWddOi0iDf+hITRuMyFx7KjQ43YqweuEgakNBPaDOC1cgXo/lL5bBLcktIT8XvxHI7RSln9tv4L0d5RpOD1XsqB33FPkoEOft51Rdfc42BCUFMLw2gQdY6NFXBQGapsiwiGxbEHvfDF2jpYPIf5Z7uREYGBK94hf9Ac5zk+HQOW/1gBiaLYKDYqBKnvt6k+Vkgc/7FAc7HXo/GT6K8TPRa7jRpaHRaMWfBAkjLufuI0r7IgSqTY8+ghO8vH7QoSPzDWhIIQTzyTj9MUXi3hb86eGAZjr7utl3dmGN5qD9906uruuN1jMSfv9ADsg1NDNb65PJpQvJexAJHvr67U98FlNNNGVgis8C9TkZLVbZ4ryZQJ5BOKGMb/LXBvlbyoDEQlUpQ9QLcfonugCSH7fyhVFUX+MIDF/JjllwaW28YCf62AKzGXdN7JprK6RgG6gQsJhIBoLC2Ie0RLEZzyfKltr8juPpLqHxCEyEXp4VPZ5MNgidbI6NspikJY+E7JJInPF7/dB1lGeKoXcGNqiN45p/j5WQwO8KhmGKEm1KpfiDg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(46966006)(36840700001)(6506007)(8676002)(47076005)(53546011)(4326008)(82310400003)(336012)(2906002)(450100002)(966005)(70586007)(70206006)(478600001)(86362001)(5660300002)(52536014)(81166007)(316002)(186003)(83380400001)(356005)(9686003)(8936002)(54906003)(7696005)(26005)(36860700001)(55016002)(33656002)(82740400003)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 03:28:37.0153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6a8db3-911a-4a8e-a4c2-08d939e4d100
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3186
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Saturday, June 26, 2021 1:59 AM
> To: Justin He <Justin.He@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>; Petr Mladek
> <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>; Sergey
> Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
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
> Subject: Re: [PATCH 13/14] d_path: prepend_path() is unlikely to return
> non-zero
>
> On Fri, Jun 25, 2021 at 08:00:49AM +0000, Justin He wrote:
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -210,6 +210,7 @@ static int prepend_path(const struct path *path,
> >         b =3D *p;
> >         read_seqbegin_or_lock(&rename_lock, &seq);
> >         error =3D __prepend_path(path->dentry, real_mount(path->mnt), r=
oot,
> &b);
> > +       printk("prepend=3D%d",error);
> >         if (!(seq & 1))
> >                 rcu_read_unlock();
> >         if (need_seqretry(&rename_lock, seq)) {
> >
> > Then the result seems a little different:
> > root@entos-ampere-02:~# dmesg |grep prepend=3D1 |wc -l
> > 7417
> > root@entos-ampere-02:~# dmesg |grep prepend=3D0 |wc -l
> > 772
> >
> > The kernel is 5.13.0-rc2+ + this series + my '%pD' series
> >
> > Any thoughts?
>
> On which loads?  1 here is "mount/dentry pair is in somebody
> else's namespace or outside of the subtree we are chrooted
> into".  IOW, what's calling d_path() on your setup?

No special loads, merely collecting the results after kernel boots up.

To narrow down, I tested your branch [1] *without* my '%pD' series:
[1] https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=3Dw=
ork.d_path

The result is the same after kernel boots up.

The call trace are as follows:
The prepend_path returns 1:
  Call trace:
   prepend_path+0x144/0x340
   d_absolute_path+0x6c/0xb8
   aa_path_name+0x1c0/0x3d8
   profile_transition+0x90/0x908
   apparmor_bprm_creds_for_exec+0x914/0xaf0
   security_bprm_creds_for_exec+0x34/0x50
   bprm_execve+0x178/0x668
   do_execveat_common.isra.47+0x1b4/0x1c8
   __arm64_sys_execve+0x44/0x58
   invoke_syscall+0x54/0x110
   el0_svc_common.constprop.2+0x5c/0xe0
   do_el0_svc+0x34/0xa0
   el0_svc+0x20/0x30
   el0_sync_handler+0x88/0xb0
   el0_sync+0x148/0x180

The prepend_path returns 0:
  Call trace:
   prepend_path+0x144/0x340
   d_path+0x110/0x158
   proc_pid_readlink+0xbc/0x1b8
   vfs_readlink+0x14c/0x170
   do_readlinkat+0x134/0x168
   __arm64_sys_readlinkat+0x28/0x38
   invoke_syscall+0x54/0x110
   el0_svc_common.constprop.2+0x5c/0xe0
   do_el0_svc+0x34/0xa0
   el0_svc+0x20/0x30
   el0_sync_handler+0x88/0xb0
   el0_sync+0x148/0x180


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
