Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6BF36F45A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 05:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhD3DSE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 23:18:04 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:21956
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229577AbhD3DSE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9XxjExPIBKwJZ8x3uWSwJPfjxAahewh6zN57gAdv0I=;
 b=XpVCMKt2MKfD9WRXOwpkc7qT/TkNoCNdja7jKpMAWBFjUcaV6clrbxBgy0yYJJwYe5rqbaCcP5tNR0eF8B2sLNUsxS2IFQaQz56Jg7T71hwgMSGXgoKsaMNYMUVs5+DbmdhNV8hthQvvx2KdGbL5Z3WVMv9ayaHVaLhxtnCLYHY=
Received: from AM6P194CA0089.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::30)
 by DB7PR08MB3850.eurprd08.prod.outlook.com (2603:10a6:10:7b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 03:17:14 +0000
Received: from VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::e6) by AM6P194CA0089.outlook.office365.com
 (2603:10a6:209:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Fri, 30 Apr 2021 03:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT029.mail.protection.outlook.com (10.152.18.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 03:17:13 +0000
Received: ("Tessian outbound 9a5bb9d11315:v91"); Fri, 30 Apr 2021 03:17:12 +0000
X-CR-MTA-TID: 64aa7808
Received: from 8aa978eef07a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7D64A09B-E69F-4DB3-9131-A6EBE68E4A1A.1;
        Fri, 30 Apr 2021 03:17:06 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8aa978eef07a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Apr 2021 03:17:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUf17YE/XpE+JnC+v3/AtmviRWrh8ecvpL3xtFKENWi3xLSxRDVx8zUZqNftg0LcrJE2oZ9Sgund6/q5bWlug0tUcp14SKb11kNG7p385vwwNacXihCOAS2IK+9tbxQp1TadzQauRiMFyVs8L9UbkC8yK4CTvNWAQsGxJMv+Fhs94b8Rk2I0TgT93dX1x89gr1dsTgREnzePTzplINCYZnGSWKAEmbec9f8P9aiMbbkNvo9Jhk/5LAnPdLkRoHOQegFbut4XMJqKMggj4ovyqZGg7ceOCBhbrOVFJ+TbrzbJmnmWB4ROJ37m05q2aYMGoiCE0m85Qg2ZdiYX4MMTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9XxjExPIBKwJZ8x3uWSwJPfjxAahewh6zN57gAdv0I=;
 b=jiprqsHv5BQqxJQOhH9/2DGWwkjDVQDEZxETpP58Hwixslae8nfBgNgqocEhyXP1z2df30Y7IvwCOtGQJ/z10iDQmJWkDUVCpEywJNgrokfJbNXH7o+D2Uznqczc4DQUGqC5rLWgi2nazIH5ZrkZcPEozESztEUBiN2w2+BFalSRW6X2GEAQN9/FwEiDWhdu+fPEe5fbEhC5XSWafYkoWI2Wrd8r3FpYBsV1LSYaO4YRqWcWcT9wPNFIWaxP1aGOIt29sMrP9WUQE2vx8gTYvDddevbybp3vYDYcde19fjLtyNffWlXKXJ7+DcMASzKcuMD4C5v0kjDR8ZVPsnUu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9XxjExPIBKwJZ8x3uWSwJPfjxAahewh6zN57gAdv0I=;
 b=XpVCMKt2MKfD9WRXOwpkc7qT/TkNoCNdja7jKpMAWBFjUcaV6clrbxBgy0yYJJwYe5rqbaCcP5tNR0eF8B2sLNUsxS2IFQaQz56Jg7T71hwgMSGXgoKsaMNYMUVs5+DbmdhNV8hthQvvx2KdGbL5Z3WVMv9ayaHVaLhxtnCLYHY=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6888.eurprd08.prod.outlook.com (2603:10a6:20b:393::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 03:17:04 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60%3]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 03:17:03 +0000
From:   Justin He <Justin.He@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [GIT PULL] iomap: new code for 5.13-rc1
Thread-Topic: [GIT PULL] iomap: new code for 5.13-rc1
Thread-Index: AQHXO51Cqf1NQAhE30CBg6xQ5yY+C6rIx96AgAACK4CAAKr1AIAABfQAgAAAxgCAAAleAIAABo8AgACaL4CAAOfgAIAAqT2AgACvAzA=
Date:   Fri, 30 Apr 2021 03:17:02 +0000
Message-ID: <AM6PR08MB43769965CAF732F1DEA4A37AF75E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210427025805.GD3122264@magnolia>
 <CAHk-=wj6XUGJCgsr+hx3rz=4KvBP-kspn3dqG5v-cKMzzMktUw@mail.gmail.com>
 <20210427195727.GA9661@lst.de>
 <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de>
 <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de>
 <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
 <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
 <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk>
 <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
In-Reply-To: <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E3694A20105CB14AA9B990F03DC00F2A.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4cf9e469-3307-4269-5943-08d90b86733c
x-ms-traffictypediagnostic: AS8PR08MB6888:|DB7PR08MB3850:
X-Microsoft-Antispam-PRVS: <DB7PR08MB3850F9FB6AC37AFD66456550F75E9@DB7PR08MB3850.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XtB6a6k11AEDNgotFn+uwBDsjWrwaBal7DRvF/JFGtC//SKA6zvlvEMr+tPhvoo/qvz+CmhMBTLJd0mn4CK51+wbO35KFGLvxgTn96gjNGkId8WRsVFfgrrDH6dhXoPclmwAT8Ke3Nc0TzQNg99+UccUPrLRSAkfX9lPCe+dymG3Lp43Ldt3jytyOuOuIACNbvkjOULYIA4CgEFsydUW5xZK4mmykZ9oiZFPPWRZNUoGylT15mFAEwqK9QqmB3gG+rHVIxMWNhNEX4Yr7cP3i0/YIfsKTzKlNK+yKBU5VH33sBjdiQqakHbqCDZ0EY3VfNvgsDJgj4Q3RY7rEDouFRvpjFBv7JtNm8sxUH4RVkoXZ06uKU+/wlqWVsVepuXkTbdqEtgrz0r0SYVrT4PRA1HuEjKj0faXvzDDoeZIAS68+9r7IJhrBMmHplY9W5lNJ9k87WRgK6xZhlgy9U555va+4NHydoaS/AlDMFo5+ygOnGZ7ebrXwQ3V/RSrJb/qAsTHxenEEhQVZflWx0xhJoaT9xdqcfD+09BGlzYlF9dGbUo+gSuzrwo9nHJXvb3nhH7Eh4dmL1aUfrXLdHZaUBQhjCsgBFQwte1nWsPkVhk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(478600001)(9686003)(186003)(4326008)(316002)(53546011)(54906003)(76116006)(110136005)(7416002)(86362001)(64756008)(52536014)(66446008)(5660300002)(66946007)(83380400001)(66556008)(66476007)(2906002)(122000001)(8676002)(55016002)(26005)(71200400001)(33656002)(8936002)(6506007)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cHgvMzFxdFRIdml6MW5MMy95c0RIVU5xUFJHQnovOU43QU1lYi8zWS9XZ0hp?=
 =?utf-8?B?U2RRNnpodExlWTh6OGlRWElqZ3FaWXlCbmZYVUpaaDZtcTZNVW4xRXRBQmdO?=
 =?utf-8?B?WDFFMitaUXFxOWk5UFZkNC92bU1uY2Y2K0MvTnFpMHdnR1RCTmo4Q29PaWtG?=
 =?utf-8?B?Y05ZUGZGUDVqWmIrTmpHZXlrdUY0TFlJdkF1bzVvY3c3cTZQWXRKdGpXZVN4?=
 =?utf-8?B?WlQybEl2aUVOdWJ4L2lBU2gyT1FaRytJY0w2cUFXanZyM0JqVCtMRXkzeERy?=
 =?utf-8?B?QVNBVzB2T2tIZkp1aU94aUQ5VmtQZ1dKVVB1YXMrbWZITmtQSG52U3ViNTla?=
 =?utf-8?B?ZUVOZzZnU3Mvd2RCNHBiY29NYVZGbERFcy9yUG9rQkRhU1NjV3E4bTA3OTNm?=
 =?utf-8?B?TmtHdXVjdVRXcVJ2aE9qd2RiNGVFUlhjUHI1YWZPa1pCVnl2MzlLYXVSSFdl?=
 =?utf-8?B?MVJoVWIzMkMxNGsyMHRORkdBZVUyWjN0WXI1TkZWN0ZwTmtIQmVVd3dkRnRQ?=
 =?utf-8?B?eHVuM0NhQmZsd2tIUm9oM210YnBOMWc5a3JmaXJmdW83YUd1MHV2UkJzc2tN?=
 =?utf-8?B?U0RhNndWQXk4NnFFU0RDZ29hWTdiVENOR3RobzlFcG5XYmt0SjRSWUx2dFNV?=
 =?utf-8?B?ZVRZalRvamZxR0d5SEo1L2Rlc25rSmhSQ1hoL3FDcHl3YmdKeTJTOU9ENWV1?=
 =?utf-8?B?NmE2T01EZjQ2cnhMeDBMc3c3dW8xdEJhR1Y0Nk1ONGtvNTRRbUlBMEFZSUlw?=
 =?utf-8?B?NnNkc1JoODhvRllTZUNxVmdiNXpqUi92ODJpMzRZRWtwNjY4bkFTMm5pM054?=
 =?utf-8?B?OGRMYmVLUm1nMkxRdEZXaFkvaXVZRWVjMTN4MDk5NldkcTRoWUZ1ZklPblp6?=
 =?utf-8?B?TzAydlNJTm9HNytqMG0vK3YvOU15N1YyWkR5WERGVnVWdTUwTURkMm00SmV5?=
 =?utf-8?B?RjRDemVFTEMzVTBmYjBnKyt3alVockxHdWtveDZlQTNhclRockpXTDJYbk1r?=
 =?utf-8?B?NG5ESnltTzZaYVFlK3hBd1p4cG11OFNqSTdwR2hoRnZIR3RWUUZKUmwxa2t1?=
 =?utf-8?B?N1pEbSszNkVXY09xc3VtQ3BQZUYxaU10Yk81aVBmcXdoNG4yYVI0a3hscTlH?=
 =?utf-8?B?ZGZCbGxEaS9XelJNY0ZydTRJSC9nUit4ajdqNEZlejRKNXUycENKRUkwb0ZL?=
 =?utf-8?B?dVdCS2dyOW5UZ0FLN25FUDd6YzBNTlFsZDlZT0htbGpUYmZVeEpuR2lpVzVE?=
 =?utf-8?B?N3VkbDdzR1M1UjJCc2U2ZjFqUE4xb0pwdThHZGhTTGE5bklmNUlkQitNMmVJ?=
 =?utf-8?B?d3lZemZRMkhubUV6azEwMi9uS0ZIdWozTVE4ZlphMWVSTysrMjRzRFhqTEMw?=
 =?utf-8?B?WWJQaGRGcXE1cmNoOEt5cDRiUkgvdWp5dk8xbGgxN1JwVk9kYU5jdkhFWnh4?=
 =?utf-8?B?QVZwRXZMT0F1bDJ6MTFMbWdkemgzdzYwdk9pU0dKVjJ4d01qUFE4NkF4b05J?=
 =?utf-8?B?V2RGVDhkbFdXRnFQbHJFOFFUMkN5TU9HdHlHRG9OM3E4RmUwcTVtWnlxN29O?=
 =?utf-8?B?bGgySzducE9qQW9VMk5qdmtsb2dHWWRRdGp6WWxJZmhZUDM2V3dlRHNWU2xi?=
 =?utf-8?B?bnlISE95aW9QMExxcThJNVU2NVF6RGFqMGZnTFpZZU1NaDEwYUZGY05jMC94?=
 =?utf-8?B?SmMzeXZ6SDFxbE03NjBMTkpzQ251VUtnU0FkelNJWXNHZXFXcERQWDZHSjZJ?=
 =?utf-8?Q?uot3U1chECvOZOf4OZoD6oSw1/Z+j82PUpjEQRq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6888
Original-Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d775a736-3de8-442e-fb0a-08d90b866d1c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwv+hRmux0wpHHMtnP1U34HyLr6M20GydvdzJ8OgD9cz34TcD+5peTL+nabp4/yhzzCI2I56z20h3/msJbKmDin1vGaNWHzg1J23+oqbVQTYCF03kmhLzd9rAz6Mu9/+FrRM+bZbJlIRxevB257CKbmKGzRAcQimUtM6JIqNoof+Yb9cvt9ZV6P1im4bpUEv9Rov/lQwNq5MHmooMSdHFUon9lU8nv6kE6RsOv6ax846f1tg2YLJahG2q+n76lUFlieaPfDOLAbGn57K7OcQDzBkuoPMZnOBb6rqkXPOaOz7NO19Y5YT2wHcfNVRgjKwLNCXh9GOesq1b8GyMPnIppFCnEIvd4A4e0JTG+zlAc+U4RXMfO+6JqLYzGQ5GyveSH+iYkQyqxXCnVjdjmcbsAQzbsPUhjR1bv2YSfj35tOKfj/DmUerxvjSdyXlkiTgy89WdOIL62qdJ9KBlK03wtkwXNj53Ed3FGGUqHazLKsvMh7rvFpjSSPXNEsYlPhBlB4i8ya3ty1Oix/lXIuakjSOLfUUBWwUcn5OONF8WX5VNY5hZ81Ag41ojdQMlmTLSL3fK8fnXxw91MZ1iswmU6UbwyKdWMq7U3V880DT6nqKvcN95+e4W6dHcuoej+vm/0lLPHnpgH8eC36iDYe4JZXvMs9bmnb05Oa/TIQdpo1Yg7ZgT+BpClEw3LNOT884
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(55016002)(82310400003)(5660300002)(2906002)(107886003)(356005)(478600001)(47076005)(8676002)(9686003)(70586007)(83380400001)(54906003)(36860700001)(110136005)(26005)(34020700004)(316002)(186003)(82740400003)(7696005)(53546011)(8936002)(336012)(86362001)(52536014)(70206006)(450100002)(33656002)(6506007)(81166007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 03:17:13.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf9e469-3307-4269-5943-08d90b86733c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT029.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3850
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBUb3J2YWxk
cyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwg
MzAsIDIwMjEgMTI6NDYgQU0NCj4gVG86IFJhc211cyBWaWxsZW1vZXMgPGxpbnV4QHJhc211c3Zp
bGxlbW9lcy5kaz4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPjsgRGFycmlj
ayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz47DQo+IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFy
bS5jb20+OyBBbCBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az47IGxpbnV4LQ0KPiBmc2Rl
dmVsIDxsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXhmcyA8bGludXgtDQo+
IHhmc0B2Z2VyLmtlcm5lbC5vcmc+OyBEYXZlIENoaW5uZXIgPGRhdmlkQGZyb21vcmJpdC5jb20+
OyBMaW51eCBLZXJuZWwNCj4gTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsgRXJpYyBTYW5kZWVuDQo+IDxzYW5kZWVuQHNhbmRlZW4ubmV0PjsgQW5keSBTaGV2Y2hl
bmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW0dJVCBQVUxM
XSBpb21hcDogbmV3IGNvZGUgZm9yIDUuMTMtcmMxDQo+DQo+IE9uIFdlZCwgQXByIDI4LCAyMDIx
IGF0IDExOjQwIFBNIFJhc211cyBWaWxsZW1vZXMNCj4gPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5k
az4gd3JvdGU6DQo+ID4NCj4gPiA+IFRoYXQgYWxzbyBkb2VzIGV4cGxhaW4gdGhlIGFyZ3VhYmx5
IG9kZCAlcEQgZGVmYXVsdHM6ICVwZCBjYW1lIGZpcnN0LA0KPiA+ID4gYW5kIHRoZW4gJXBEIGNh
bWUgYWZ0ZXJ3YXJkcy4NCj4gPg0KPiA+IEVoPyA0YjZjY2NhNzAxZWY1OTc3ZDBmZmJjMmM5MzI0
MzBkZWE4OGIzOGI2IGFkZGVkIHRoZW0gYm90aCBhdCB0aGUgc2FtZQ0KPiA+IHRpbWUuDQo+DQo+
IEFoaCwgSSBsb29rZWQgYXQgImdpdCBibGFtZSIsIGFuZCBzYXcgdGhhdCBmaWxlX2RlbnRyeV9u
YW1lKCkgd2FzDQo+IGFkZGVkIGxhdGVyLiBCdXQgdGhhdCB0dXJucyBvdXQgdG8gaGF2ZSBiZWVu
IGFuIGFkZGl0aW9uYWwgZml4IG9uIHRvcCwNCj4gbm90IGFjdHVhbGx5ICJsYXRlciBzdXBwb3J0
Ii4NCj4NCj4gTG9va2luZyBtb3JlIGF0IHRoYXQgY29kZSwgSSBhbSBzdGFydGluZyB0byB0aGlu
ayB0aGF0DQo+ICJmaWxlX2RlbnRyeV9uYW1lKCkiIHNpbXBseSBzaG91bGRuJ3QgdXNlICJkZW50
cnlfbmFtZSgpIiBhdCBhbGwuDQo+IERlc3BpdGUgdGhhdCBzaGFyZWQgY29kZSBvcmlnaW4sIGFu
ZCBkZXNwaXRlIHRoYXQgc2ltaWxhciBsZXR0ZXINCj4gY2hvaWNlIChsb3dlci12cy11cHBlciBj
YXNlKSwgYSBkZW50cnkgYW5kIGEgZmlsZSByZWFsbHkgYXJlIHZlcnkgdmVyeQ0KPiBkaWZmZXJl
bnQgZnJvbSBhIG5hbWUgc3RhbmRwb2ludC4NCj4NCj4gQW5kIGl0J3Mgbm90IHRoZSAiYSBmaWxl
bmFtZSBpcyB0aGUgd2hhbGUgcGF0aG5hbWUsIGFuZCBhIGRlbnRyeSBoYXMNCj4gaXRzIG93biBw
cml2YXRlIGRlbnRyeSBuYW1lIiBpc3N1ZS4gSXQncyByZWFsbHkgdGhhdCB0aGUgJ3N0cnVjdCBm
aWxlJw0KPiBjb250YWlucyBhIF9wYXRoXyAtIHdoaWNoIGlzIG5vdCBqdXN0IHRoZSBkZW50cnkg
cG9pbnRlciwgYnV0IHRoZQ0KPiAnc3RydWN0IHZmc21vdW50JyBwb2ludGVyIHRvby4NCj4NCj4g
U28gJyVwRCcgcmVhbGx5ICpjb3VsZCogZ2V0IHRoZSByZWFsIHBhdGggcmlnaHQgKGJlY2F1c2Ug
aXQgaGFzIGFsbA0KPiB0aGUgcmVxdWlyZWQgaW5mb3JtYXRpb24pIGluIHdheXMgdGhhdCAnJXBk
JyBmdW5kYW1lbnRhbGx5IGNhbm5vdC4NCj4NCj4gQXQgdGhlIHNhbWUgdGltZSwgSSByZWFsbHkg
ZG9uJ3QgbGlrZSBwcmludGsgc3BlY2lmaWVycyB0byB0YWtlIGFueQ0KPiByZWFsIGxvY2tzIChp
ZSBtb3VudF9sb2NrIG9yIHJlbmFtZV9sb2NrKSwgc28gSSB3b3VsZG4ndCB3YW50IHRoZW0gdG8N
Cj4gdXNlIHRoZSBmdWxsICBkX3BhdGgoKSBsb2dpYy4NCg0KSXMgaXQgYSBnb29kIGlkZWEgdG8g
aW50cm9kdWNlIGEgbmV3IGRfcGF0aF9ub2xvY2soKSBmb3IgZmlsZV9kZW50cnlfbmFtZSgpPw0K
SW4gZF9wYXRoX25vbG9jaygpLCBpZiBpdCBkZXRlY3RzIHRoYXQgdGhlcmUgaXMgY29uZmxpY3Rz
IHdpdGggbW91bnRfbG9jaw0Kb3IgcmVuYW1lX2xvY2ssIHRoZW4gcmV0dXJuZWQgTlVMTCBhcyBh
IG5hbWUgb2YgdGhhdCB2ZnNtb3VudD8NCg0KVGhhbmtzIGZvciBmdXJ0aGVyIHN1Z2dlc3Rpb24u
DQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQpJTVBPUlRBTlQgTk9USUNFOiBU
aGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRl
bnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZpbGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRl
bmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQg
ZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQg
Zm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBvciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkg
bWVkaXVtLiBUaGFuayB5b3UuDQo=
