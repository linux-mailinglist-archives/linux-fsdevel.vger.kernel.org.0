Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008533B5861
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 06:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhF1EjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 00:39:07 -0400
Received: from mail-eopbgr60059.outbound.protection.outlook.com ([40.107.6.59]:27603
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230203AbhF1EjG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:39:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR+yXIIF3yHq7qzm1kGSHdvcLgs2XO4oKCEq2gnoKCQ=;
 b=4CraxxJFPmrlcMFiigYDtpI7i4xtkZMn4PLa7OaIcu19CSKRs+Bfl6p72VZyTzcRxfiTbVFTeAuv4GEMy5pvcw6DkJYxhVslv6IPzcAWzFttQgtcJbXv173vPk4CYePxk/LO4JWnTXdfFV9y3PXO5x9T8QoYaN/RFSVGJDzJFvc=
Received: from AM6PR0502CA0072.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::49) by AM6PR08MB5047.eurprd08.prod.outlook.com
 (2603:10a6:20b:d5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 28 Jun
 2021 04:36:36 +0000
Received: from VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::e7) by AM6PR0502CA0072.outlook.office365.com
 (2603:10a6:20b:56::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20 via Frontend
 Transport; Mon, 28 Jun 2021 04:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT037.mail.protection.outlook.com (10.152.19.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 04:36:36 +0000
Received: ("Tessian outbound df524a02e6bb:v97"); Mon, 28 Jun 2021 04:36:34 +0000
X-CR-MTA-TID: 64aa7808
Received: from 0fec114450ef.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 293AB585-7711-47BE-A3BA-A98C728F6065.1;
        Mon, 28 Jun 2021 04:36:28 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0fec114450ef.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 28 Jun 2021 04:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVLEZLkavyIRbBeQuArw7FpyySoQceoLRdlnRZ4Mdq37hzZiyR19Bmh6tlthBCfsCnc3qfTZm+TpY3+w5H9BlFflviCZVnv90tYPTbTYqgcnXEv2E2IkzrEXNq0L5NttIlGKIZGLV+uiif/Z/YkjtS5Z7Ltnet7FrmBhBCceEW3y2vcxCsNUaYalLe9/HSJzTieWKrBoBmYrZhnyA5CrRgHn0yQ82jWjjMRdtlH6NxPlf05EAEPfDciMFhOfXNOV4yWqpgeciGcirTqhO40eWQIbxRmnNT97lzW04y6hyUERabXWVbvdleeeBi/YsoUN7itUmkRZ5+hTzwTAC8fzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR+yXIIF3yHq7qzm1kGSHdvcLgs2XO4oKCEq2gnoKCQ=;
 b=CAuYoVe+o2J3/rNElbUmFibaFJcoUpUp/WMXU6vTaS8xMLkqtjuhsmqFxouA9cRPsstLYv3Xn3NCQ7Wl1VYtRITAkmPCzTsc/Pd2MqAy/+QFhH1TfWRPZldRCYIe+g2AQ28QfaH21vnNn9xJSrrLivPB9UPEDMH5nMG+/4wQQ8fH8WAeT9t+q6JEmlgY4X7T0icxuQ9YlAY8MvO4HYBbYtTSF3MTEJFdA92dJy49/xsNIp6QyfjB0ccfIvtweckA5cvJNw302rZ/CXIrSn3dcfdrqEAh2K3bndtLsbWjme/3BvXwo8Vd6+RTxoMkJrBCUY6MAD6cfj+1iALz7owGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR+yXIIF3yHq7qzm1kGSHdvcLgs2XO4oKCEq2gnoKCQ=;
 b=4CraxxJFPmrlcMFiigYDtpI7i4xtkZMn4PLa7OaIcu19CSKRs+Bfl6p72VZyTzcRxfiTbVFTeAuv4GEMy5pvcw6DkJYxhVslv6IPzcAWzFttQgtcJbXv173vPk4CYePxk/LO4JWnTXdfFV9y3PXO5x9T8QoYaN/RFSVGJDzJFvc=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB5926.eurprd08.prod.outlook.com (2603:10a6:20b:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 28 Jun
 2021 04:36:24 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 04:36:24 +0000
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
Thread-Index: AQHXTEjX4vA9qb1/tUuDI9sxRSQuQasklodQgACoVwCAA7zVQIAAE8mAgAAF+mA=
Date:   Mon, 28 Jun 2021 04:36:24 +0000
Message-ID: <AM6PR08MB437631C5AD4004EF6B7ADFA1F7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-13-viro@zeniv.linux.org.uk>
 <AM6PR08MB43762B63D11A43FE84849748F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YNYZTIP+anazsz/U@zeniv-ca.linux.org.uk>
 <AM6PR08MB43769E57C213CD2C92476F2CF7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YNlMi80b8bpY1ZHk@zeniv-ca.linux.org.uk>
In-Reply-To: <YNlMi80b8bpY1ZHk@zeniv-ca.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: A4347E30F9F7144E9E154D3DFE84A780.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4ab2a488-970f-431e-ff6f-08d939ee5053
x-ms-traffictypediagnostic: AS8PR08MB5926:|AM6PR08MB5047:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5047CA5AA6709A9C28A164D8F7039@AM6PR08MB5047.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 44N01s7MB1u630vXlFWKB+x7kK10Rq4hTP4QZzvd935CTupxAmihnOzpyV0G5Td5yHVns7Z8aGKk7gbmMOt/jtzOi7DYEZw5aZmGeqEgn4cQdpLoTlMGjfwqcOB4IAMRsdRTIFz5Gqy8I7kYU58mUGQeJHAtABbD63CO6QL5LOfUhEBS+gG5LKmUvCQMVSxvY202NNIA0oyqRiBk5yv1LSqip07l10WWvFep9Un8R25PB7TgiGmKSmzkJczc7CTSSxjC1WOU5fmvloJclqw8bCiY2NKSvihT9z1sQrgTXf+tMex9ksoLTEU03NnPeOLnymSdjHa33vdWlw+Oh2eoM0BYC3Vt+echnv6OoIN4MHWZlH3Z2qmeeoZOh+EsGE2F+26rwDEqePu12L0seM9lVW/0Fzgs8i7lDarrdNUZV+Bpt8t+UebFS0qar1XolZrcIsPtDBiC4rQ/SsowwkI8ixZ8aplsawP5DPkq4Cx34NoWIOSaqiGgIxPh9iAPfq6+QPaenFMAT2miCnnuNVWOEXa9GGGFNtApzDibVpeTJloxM78sb8t8FbI4CZPsO5rWjBX5ZZByzzJvBEhOcZ+NMqB9/QrDfzz0RHMeGnVHApFiWbMWpzl0XsoYNbLmYpjCvjCh4sq2RQgq80VGMktH5W5sj3qMMZNbJRyaf5U/OUEsCwB7vS35j9ZNgeCKYDX+Y+fRDVbxP9P7ZgVYgKXMJNDRtB2gsMBtSEKu3DfRedg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(136003)(376002)(396003)(71200400001)(33656002)(66476007)(66446008)(64756008)(66556008)(7416002)(6916009)(5660300002)(52536014)(55016002)(9686003)(4326008)(966005)(76116006)(316002)(83380400001)(53546011)(6506007)(7696005)(38100700002)(2906002)(122000001)(186003)(26005)(86362001)(66946007)(54906003)(8676002)(8936002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9KYAawa+MYXQ8UfQWay48FbR44x9Il3ILWUBrSNB21e1X14KspekpFNTFdkX?=
 =?us-ascii?Q?lxiLbTYRbB8Nb+l+UP5T8hxpF96GpZhHoHoOS0HumHH65nRUaQybJrQK6239?=
 =?us-ascii?Q?78pNxZH7dcufO0S7p+t0D73knMPP+6hp7mkYt7kN+vPy444Hwz+am1XiHBqG?=
 =?us-ascii?Q?RD8lW31Q/EBQkbZaHXPGcP2d6pxClhRa2WYH84zQjHEyxAxPKjlgVBBurxdE?=
 =?us-ascii?Q?p2EvisZjsLycDT8Q2asdib6ZRDgbtF0M8cRBeb3w4DuQRcODpdVhOsD/4P7A?=
 =?us-ascii?Q?KiYUfpZe/jO26ab87ZDOZR29yVNP+onJ1ddKTb1Z12ezcFekBvasfwik3IYs?=
 =?us-ascii?Q?Pdg/SZxey3uFifGTq1qlzl+ET0CdsaeLRTpVm1G8HBNOrn47FcYaFRt6PPIn?=
 =?us-ascii?Q?XroIg6jkA8xh81dppo6YNL9rLt629MxHQxcazxwgiqKhLvxor4muzc40kU2y?=
 =?us-ascii?Q?RVkHCJpbiav63Mu18+hYqDOYbuMADA4mSY/cjncufMa4D95tC+aM3HZgJm6d?=
 =?us-ascii?Q?A/Uz0p8v1Sg87rZcXXZsC2FMTWjPJBl/8qUp3joTcG6nqpcL3iCJLCo17H6J?=
 =?us-ascii?Q?hj/zCFpfX28zAFBaLGOcPT49FOVJjWLsv1rJYWyOvGpifCrOxdx/vYvXdzpv?=
 =?us-ascii?Q?SgJpPQ7w+Tp8xHf1jj1mbwc0jsko8P2zBXzZn1JOrEE3MrgWZib+BPb7NTdX?=
 =?us-ascii?Q?4vqkD4FxYOvCagEscpig/RQEhL+MyPjm6kJYekvxSGizCmPAY6cgwSLJyGHG?=
 =?us-ascii?Q?0aSIFACVKfAU0+fQ3evpeGRuRiWIdBHQWp6k15Ybf5p0X4kN009WYeBiQa3h?=
 =?us-ascii?Q?ZiT4EVxDafnFOrO5TBS4WyNcnmhq2Tq5ri/r19sDoTimxPC9Yb+jV8Boc48J?=
 =?us-ascii?Q?OiB1d4LjWc8/6fwzNj3QalO6lLxeJOE53Bcf7YziFxEQdIWUEwAIESlPcJj4?=
 =?us-ascii?Q?qjvtNNzqvXH6SAgs8O0cEDekyfjjaXbGBq0AdFhinGuSiQrpC6aFlOOCFKPa?=
 =?us-ascii?Q?2BvIXeFPP8akUXGTaI4mauJVTdhgsrXK4TOPIXgREhq9TlDZDxjx6dXy6RCX?=
 =?us-ascii?Q?xNJBqxUfWPMP5AKiIH07CulnLcpISnDh1nZIIQJfx63h754mC8U7M84CpfBi?=
 =?us-ascii?Q?jRryjQgflWCt3HK5CnWKoIKhc8sECo/fxCb11px4T9LCfhFxWgwDhY/MRr/p?=
 =?us-ascii?Q?JN82dDmOJXfUB73us0/N3PKf3+YFo2fGp+F7WG6rFvCHZVysvAju833nG3RH?=
 =?us-ascii?Q?8Old70cUxX7bNNKVXXWWKsKRBqYO7zYwAFTVqrHPbIn3spbOfLmIdFvaUl9U?=
 =?us-ascii?Q?RCxo1LPuEtqqacpusXxenx1K?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5926
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3a966c50-2dfa-4847-47c4-08d939ee498c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yNYV6wrEmJ21svPIFrFZluD7kBHMMjo2I5fUVzhty8Apg+xeFe1qK93nebxq4Zmuvf5Btz4eAOTYxshuXaQAWrzscH3KswYPhdmsdJZxAalMPXsZmn3urcW46Euh0mt2Tnbsm+oZW+pdXxqHNoa6RQJDWWgXWPsBTexvUTBHZ/KI007PGnADGuAklPk4nO4P9ZxxqhHVbTBiHOC8zC0PO5XzuhVt+fF4DJGHEt0CgGLO0BKHnj+XrzZDgJAELpooSkIoBsuMrn5EI1qPnlkUpTk8wapgduQSHJHhIx5wknv+sxnkXxCmWh+k6u6+O3HaRpGzSAtsXXVNmBwDxr+1VvIeiQ7L/i8f46SlpBRy8AP6ko/OwWU0SfZP6LvvhCVg1i3GcA9s7wgA80bvHaND1EzG/0Y/7yFTOaAXa1Dfoo72MvBgLK1E0UPhQ85TyCDiTsb+u3J5RtEkgnoTcy4B8DCc9kAYxAQhVF6+3y6CSaX0DCBeSOHX1/Z3Uw8fRniAGqKZFRH2WLw5GqNJ48Cn4SdV/jd94/GiQyTmBzWjgdtkY6Ah2U3ON+QfqoxkpsCIOCnyTHGHOA/ki58VbDw9fcm5MgS/mdTcyVfdzJ9d6nioxW+dJz2QTo9vQWnIPUWXpU138HliymZQglI/P84Qhv6ECteQ1QnFjeB54s2CQn/En/P2GZ2BSqwp9U+2gLe9Oomf11traSPHwKy7PeU7NK4Y/o/BokYkb0ujOjlk76iFQBSm/e//2JAZ5nLzIt4rPMa3syntUHvMNddG6D4PKw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(346002)(376002)(36840700001)(46966006)(86362001)(186003)(966005)(81166007)(5660300002)(8676002)(83380400001)(7696005)(316002)(82740400003)(47076005)(36860700001)(2906002)(33656002)(70206006)(54906003)(53546011)(356005)(26005)(82310400003)(9686003)(478600001)(8936002)(450100002)(4326008)(70586007)(336012)(6862004)(52536014)(55016002)(6506007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 04:36:36.0008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab2a488-970f-431e-ff6f-08d939ee5053
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT037.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5047
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Monday, June 28, 2021 12:14 PM
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
> On Mon, Jun 28, 2021 at 03:28:19AM +0000, Justin He wrote:
>
> > > On which loads?  1 here is "mount/dentry pair is in somebody
> > > else's namespace or outside of the subtree we are chrooted
> > > into".  IOW, what's calling d_path() on your setup?
> >
> > No special loads, merely collecting the results after kernel boots up.
> >
> > To narrow down, I tested your branch [1] *without* my '%pD' series:
> > [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=3Dwor=
k.d_
> path
> >
> > The result is the same after kernel boots up.
>
> IOW, you get 1 in call from d_absolute_path().  And the same commit has
> -       if (prepend_path(path, &root, &b) > 1)
> +       if (unlikely(prepend_path(path, &root, &b) > 1))
> there.  What's the problem?
>
Ah, sorry for the mistake.


--
Cheers,
Justin (Jia He)

> If you want to check mispredictions, put printks at the statements
> under those if (unlikely(...)) and see how often do they trigger...
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
