Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA53B122E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jun 2021 05:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFWDa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 23:30:28 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:52615
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230004AbhFWDa1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMTGOTc9zWjVew5k8/XN+g8KbAYYis8p+hXnmhTxL40=;
 b=CEcfjVKYpgU1TCxvxZtEuvNoqECqnJtCNxksW16N7Kew0YHqOHiJY2mBZHK/mtvzT3T3Ptwjh6ur1MyOLrhabtKdRCa9FSPNUNmBayp7tk8ci1egnC3gRZxPUCumbMXNJu4zyK3l/ycQx5HeO+40vqePeNi0ht0LFMI72fSxJNk=
Received: from AM6P195CA0063.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::40)
 by AM0PR08MB4146.eurprd08.prod.outlook.com (2603:10a6:208:129::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 23 Jun
 2021 03:28:08 +0000
Received: from VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::23) by AM6P195CA0063.outlook.office365.com
 (2603:10a6:209:87::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Wed, 23 Jun 2021 03:28:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT048.mail.protection.outlook.com (10.152.19.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 23 Jun 2021 03:28:08 +0000
Received: ("Tessian outbound f945d55369ce:v96"); Wed, 23 Jun 2021 03:28:08 +0000
X-CR-MTA-TID: 64aa7808
Received: from c0222d715f4f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B17E78D6-FA22-4785-8B0D-023E4314FE2B.1;
        Wed, 23 Jun 2021 03:28:02 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c0222d715f4f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 23 Jun 2021 03:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aW4hGlEMBZt/gb2dSiuMymOPxLQViJ0IwGuqUeQZAqwBCph3HnHkP9E+Op/wjQ74/U+vBS72FhjFFebhsRKlTt7yGcP3rRuAPo6ODVpbNVI6Ae/mUWsnJHVdsmwirC8t5cCXbzSzw1Xmw6OEbdR6AyDoh1y/Ms1h9dtvdCqhHlUZ5QrKg0hYDwohsF9XlgfejzWxcRyqF6fwFuxNgOsumFxaoUUG4huYdS7wFT08EFxHGLID8ZHIqCfPD8ZyLlZfR4K0AJAv18Qx7fFg7oWX31Gj5xTw1cLkx9f7JeWta4/wQaLV+Spa4cdn4QwsC0DeJz7HQze/zuZyRGICcEfbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMTGOTc9zWjVew5k8/XN+g8KbAYYis8p+hXnmhTxL40=;
 b=eQLkSBQmb2VK3jX15IcccMw8nmWaNTLiOdk2dnwMljYWpz+EGnIyyISgTL+i0WOIHLC8I0mv+4pEtwmg4rXD9lNqFBdKuVTnl8jQYtxDqwIjwa2938BmTvahE5oLYWS8687NG0l3bgI25Irfvg3g25ux7p962USGbhOMkT5oFUaYHzx/JiQJxDi+lVIFe9rhaca9QZSDUSpGHgFHyXKonT+GJQYxWT9NnfxNeKhDwuAXOlsroaS5slvDRUps9IiKGQdd/IpEzqVSjPipHh647fjWwomecs5LrkRsyGCqfNME1CB+PnaH0EDHsMLg091mPY0HXEU/L4VyO6FXdtalBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMTGOTc9zWjVew5k8/XN+g8KbAYYis8p+hXnmhTxL40=;
 b=CEcfjVKYpgU1TCxvxZtEuvNoqECqnJtCNxksW16N7Kew0YHqOHiJY2mBZHK/mtvzT3T3Ptwjh6ur1MyOLrhabtKdRCa9FSPNUNmBayp7tk8ci1egnC3gRZxPUCumbMXNJu4zyK3l/ycQx5HeO+40vqePeNi0ht0LFMI72fSxJNk=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (20.179.6.149) by
 AM6PR08MB5046.eurprd08.prod.outlook.com (10.255.122.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Wed, 23 Jun 2021 03:27:59 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 03:27:54 +0000
From:   Justin He <Justin.He@arm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH v5 4/4] lib/test_printf.c: add test cases for '%pD'
Thread-Topic: [PATCH v5 4/4] lib/test_printf.c: add test cases for '%pD'
Thread-Index: AQHXZ3ASEmHAdoCMtk6TLy9G5BdQOKsggf8AgABsjnA=
Date:   Wed, 23 Jun 2021 03:27:54 +0000
Message-ID: <AM6PR08MB43764CC4C5CE337239ECA1B7F7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-5-justin.he@arm.com>
 <03f59e85-bba3-2e2c-ebaa-48daa93d6fec@rasmusvillemoes.dk>
In-Reply-To: <03f59e85-bba3-2e2c-ebaa-48daa93d6fec@rasmusvillemoes.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: B480448BDAB39A46845A212F268C8AD3.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 434ab98e-ca79-4938-9dcf-08d935f6ebf2
x-ms-traffictypediagnostic: AM6PR08MB5046:|AM0PR08MB4146:
X-Microsoft-Antispam-PRVS: <AM0PR08MB41461B0983A306B101618C6AF7089@AM0PR08MB4146.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:3044;OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qHHS4giR27wdjpou3nu6AFLGSmsEK+wLPJ8nCLpLWQ/EFbSoxR2YecPXKqI642GKdAw0RroDMbsfjxhRO6ZqChCkmh7O/N0NazkH8rJcrtyh8boz2BNeSq98L8JNBo4SV9xYkURKCqRHuFM7QiXuXGtJwsA0kCwi2IZuCLdy6I4lJxHrqjAQH6GwR3h0lbHKrSi8NMQuQHQwRM4p2RQ8lM9Efjs3QJHtrFYxTHUneRs/1+nye1USF+UXF3eFJCDBD4H8p8GC5nKwoEZkrbNQVFAZJ/RNMT360t6Wkz3d2exP8NMxJRvvaXysOze+waeVn5QpjPVta/yHyJykbd/yfq6HhDZcy2+Ux8iDHQ7I7pNMI5s9bpmyNsaEOHaHVnyywrHDae4Pb2XZa3I1dCbjFYcKrz0UowQ+S0mKUsdBBQc1rduwmSWv+rUl53ykVUccLPJ5dF7UEgHqZKWOPc0tf1tTMu3UQfG9w93UXzgq8lRMSKFaqWkE28C2wZZ4Vo5md7Y7jThiM4anD8058Rmd0MRRQWQpzp0Tw4saduxtLY4woGEbbx0kKTYMnB7SldWWoz1CY5Cyl/52lLoueuVc47a1p21ydA1rhTaPOsLDR37224d07A6IIJkJ5R60nFGRTFApdpGFLyaLtPdaIrAgrA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(346002)(396003)(366004)(5660300002)(83380400001)(38100700002)(52536014)(7696005)(33656002)(7416002)(186003)(6506007)(26005)(4326008)(86362001)(53546011)(71200400001)(478600001)(6916009)(316002)(8936002)(55016002)(8676002)(64756008)(122000001)(2906002)(66476007)(76116006)(66556008)(66946007)(54906003)(9686003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmwzVUZtRk1XQ2U5WE9KRDFTRGljS1JMMTZlVW5EaWR2NEJjaDk1R1JzbUxW?=
 =?utf-8?B?Z0pVdjJEb00yM1hyZmxOMEJrZnhla09zMXplZVRUaWJHVm9vQ3Y3bncvcHhC?=
 =?utf-8?B?L1RwcWVpZG05K3RvNVVyT2NyY0graFRlWjg2R09pb01XeU42cXRreXlJMHp5?=
 =?utf-8?B?bFBhKys4aUUrb2pxUEtDcU4wWnJYeDJnbFFOVUtFYUs1dk9GdTMyYm0wVWpy?=
 =?utf-8?B?OUMvdGJWcnNraDV2aGR2Z2FHNkFRaWRtZzRtY1hUQ0s1RFFZRmlLN1g4dXVB?=
 =?utf-8?B?YjV4aDJhQVhlNlFhbWtkQ1VmSUduTDh0bFBEZjN1VEs0aC83TGFmb3ZYWE0w?=
 =?utf-8?B?Ynlja0JxNTdjekhjUjBNS0p4MXJnRENqUUI4eXdOMUhWVWZyYmwzaVVTYzNo?=
 =?utf-8?B?K1VFazNnL250eGdjTit3UU9xWnF4aVpsT1hiWHc0MHBVYTVoOWdWQmR4bVhZ?=
 =?utf-8?B?TEEzeUtlTUZvcE12QjkyS3pld1ZSS2JGTW0zSktYbnVwSmQ0Ymh4VnZnaC9T?=
 =?utf-8?B?VEhnK2RlUW1YUlV2TktkR2JYbXppR3hzT3FCUUFsSFliZXh2UVQwaVROc0tn?=
 =?utf-8?B?WkRUMnNJVzhGOGVEUWVDN3RaRC93cW40dlh3Y3FMVlRyTjdMYWFiOS9vV09t?=
 =?utf-8?B?bC9ML2JjbG1QV0NrYWJpbHNWVFF6QjVEbkczT1h2aDBZeFNJQnNUd212Y0tE?=
 =?utf-8?B?UUVqd0N3MEJJSS9kTDg1U1VYVm5LYjNjNTFBQWdBY1VjOVBjeEJIYkRTZVhu?=
 =?utf-8?B?Mkx5QlgrdElKbEJjbDFzNGgraU1NR2c2SkozT3ZXQ255emJYSWlraUpERE5V?=
 =?utf-8?B?Q05EcTFweGx1VU9CTlpCdkQ4VmpMeDdibUxVZmhpczc0QTIvem42bnprMlFq?=
 =?utf-8?B?TUdod0QvM09VcURoL0F2VlYxakRqWldPQnl2OWttRitCd0RuRmYvWnNkeDRN?=
 =?utf-8?B?T1FNRUdPL1c5TnplNGQ3aHV2UDN1clZwbVNzSHJwZjlweTE4Qk9RTVZGYmhv?=
 =?utf-8?B?WHZPZzltdS9xUHJ1aUtQdFRmZFAreThkV3d4ZGZDMjFqSHJTU1pkR1FUSTVt?=
 =?utf-8?B?anZkVnFKdTFmTVZaRUVaOHUrNkNyamM2TERMQ1RqY21YM3JDeVh3Vlc0Y05r?=
 =?utf-8?B?RWZaTCtzQi94NWduaFMrcUFLOFJEdFRibEVNdDUwR1YrOS9pQ2pFUmwrK28w?=
 =?utf-8?B?aXR0TE9BSVgwOGgyTE90R3FIS0JlbXdxV2RLWmhpYUN4WElMQk9jWlc4V2FE?=
 =?utf-8?B?c0ZCeUpmb3ZaYXo2TWwyT2dIcXhHcEtFVGRGK3F5MU1zMUxJdWM4bUY3UHl5?=
 =?utf-8?B?Z3YvdkhlUGRUVmgxTEUvMTFVSWJrODljdGl6aW5LT0s4eXVxdE11VUhoL1FY?=
 =?utf-8?B?Wmw4dGYyUjQ2N0gxUEJsc0doRWZlYnJVaWc1NEtWNWZLVnFVOGxKczFyT0Nk?=
 =?utf-8?B?NGpzVThPcGd3RUJrSEJlcjhnWm0rZDBJV1pOUnI4UXMrVm00ZEtXOFAwd2RK?=
 =?utf-8?B?ZnhCL3kzd1VPYkZnSWE0OXdIaTdNeUtiSVUyU3A3Qk1kQ2JVMzc4SGxHazVY?=
 =?utf-8?B?TXlRTDBtQ0RFK1E0bXpjSXczeFh0MGIvWHJMcEQ1QXNTN0JLaFVwUFdzQUF2?=
 =?utf-8?B?MWxpaGFleWZmOEhabjNzZlBLSTduOHJFVGIvanpJYnAvQ0Z2bjdnc1BXM01G?=
 =?utf-8?B?ZGR0OWZSREgyK29LQ0NFSVFrOVkya1k3dzFDcEozRXc1QUQzODB5VWp5OUJX?=
 =?utf-8?Q?gtqI1UwZHy3JoKxB5FKwHk+bGYmy9vfpMwABns2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5046
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e81003e8-022b-4f2a-8719-08d935f6e38d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgtmBrcPB3COdnyvvALX/VJkuJUqJ95KfBfpuVzGgjbazmEKsfPGJHxvvLtxwC/BDoToh+dN2OvvhRFloWO8Po468XKhSunfnPp+0AtCKoDbEsKiTjgwjxWGPQo/k53+bZCDUQdxgf2pYy7kaukiVgYQSZEXjMiwXrypcCwPQKnfurmyO2M42NUpccn858W6VmHqqP9B29n2y2mxzfY4ucSF54u6Zoc+m0uO/YvuM0574XOAS6uuNtde897pYDf9boSz+iQ9z3gWMpAxbuxwWecBiMM4ufFpVWaGqz9BOFfFfGFsuF5FU8hTox78T0oTArSDirIyrZ8ozsRHmZvRG0hnLv+faM4yUlTcyysnpm7wVRkY+xjvjPY1GPf7blWxVPjk4nur9xOOD6ZV0i92Xmup9cXmKWu8bUOrNTF1NBn3PbAxwsuFTn6F3YUqAIKM64MCatkagq1mCQ3F5RoZxjpdfx32DV/dD7MWVg/ErWPwuKVAKgoMGIqmd9KZY+Mg5C0oQF/MDn3/thVZn4HNB5X78mEvc0cbAZEoTe9WTK8kbxSaBikQv1p9riPoKPO9FI5NRMBZAsqvxsboNLRDwxeGElaXmIY8kXiwYFTL8HtzFsL/p0VO4dvSfF2wrshuBcowAcQZ2Ihg9Cc5IhXBfEXLKHAqTQU9QSSGB+4PsHo=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39850400004)(376002)(36840700001)(46966006)(26005)(81166007)(336012)(316002)(53546011)(6506007)(8676002)(107886003)(6862004)(47076005)(186003)(70206006)(36860700001)(54906003)(70586007)(83380400001)(2906002)(9686003)(33656002)(7696005)(55016002)(478600001)(82310400003)(82740400003)(52536014)(5660300002)(4326008)(86362001)(356005)(8936002)(450100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 03:28:08.4479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 434ab98e-ca79-4938-9dcf-08d935f6ebf2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4146
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgUmFzbXVzDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFzbXVz
IFZpbGxlbW9lcyA8bGludXhAcmFzbXVzdmlsbGVtb2VzLmRrPg0KPiBTZW50OiBXZWRuZXNkYXks
IEp1bmUgMjMsIDIwMjEgNDo1MiBBTQ0KPiBUbzogSnVzdGluIEhlIDxKdXN0aW4uSGVAYXJtLmNv
bT47IFBldHIgTWxhZGVrIDxwbWxhZGVrQHN1c2UuY29tPjsgU3RldmVuDQo+IFJvc3RlZHQgPHJv
c3RlZHRAZ29vZG1pcy5vcmc+OyBTZXJnZXkgU2Vub3poYXRza3kNCj4gPHNlbm96aGF0c2t5QGNo
cm9taXVtLm9yZz47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVua29AbGludXgu
aW50ZWwuY29tPjsgSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD47DQo+IEFsZXhhbmRl
ciBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az47IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxk
c0BsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc+DQo+IENjOiBQZXRlciBaaWpsc3RyYSAoSW50ZWwp
IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEVyaWMgQmlnZ2Vycw0KPiA8ZWJpZ2dlcnNAZ29vZ2xl
LmNvbT47IEFobWVkIFMuIERhcndpc2ggPGEuZGFyd2lzaEBsaW51dHJvbml4LmRlPjsgbGludXgt
DQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiBmc2RldmVsQHZnZXIua2VybmVsLm9yZzsgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGlu
ZnJhZGVhZC5vcmc+OyBDaHJpc3RvcGgNCj4gSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+OyBu
ZCA8bmRAYXJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA0LzRdIGxpYi90ZXN0X3By
aW50Zi5jOiBhZGQgdGVzdCBjYXNlcyBmb3IgJyVwRCcNCj4gDQo+IE9uIDIyLzA2LzIwMjEgMTYu
MDYsIEppYSBIZSB3cm90ZToNCj4gPiBBZnRlciB0aGUgYmVoYXZpb3VyIG9mIHNwZWNpZmllciAn
JXBEJyBpcyBjaGFuZ2VkIHRvIHByaW50IHRoZSBmdWxsIHBhdGgNCj4gPiBvZiBzdHJ1Y3QgZmls
ZSwgdGhlIHJlbGF0ZWQgdGVzdCBjYXNlcyBhcmUgYWxzbyB1cGRhdGVkLg0KPiA+DQo+ID4gR2l2
ZW4gdGhlIGZ1bGwgcGF0aCBzdHJpbmcgb2YgJyVwRCcgaXMgcHJlcGVuZGVkIGZyb20gdGhlIGVu
ZCBvZiB0aGUNCj4gc2NyYXRjaA0KPiA+IGJ1ZmZlciwgdGhlIGNoZWNrIG9mICJ3cm90ZSBiZXlv
bmQgdGhlIG51bC10ZXJtaW5hdG9yIiBzaG91bGQgYmUgc2tpcHBlZA0KPiA+IGZvciAnJXBEJy4N
Cj4gPg0KPiA+IFBhcmFtZXRlcml6ZSB0aGUgbmV3IHVzaW5nX3NjcmF0Y2hfc3BhY2UgaW4gX190
ZXN0LCBkb190ZXN0IHRvIHNraXAgdGhlDQo+ID4gdGVzdCBjYXNlIG1lbnRpb25lZCBhYm92ZSwN
Cj4gDQo+IEkgYWN0dWFsbHkgcHJlZmVyIHRoZSBmaXJzdCBzdWdnZXN0aW9uIG9mIGp1c3QgaGF2
aW5nIGEgZmlsZS1nbG9iYWwgYm9vbC4NCg0KWWVzLCB0aGlzIGlzIG15IHByZXZpb3VzIHByb3Bv
c2FsLCBidXQgc2VlbXMgaXQgaXMgbm90IHNhdGlzZnlpbmcg8J+YiS4NCg0KLS0NCkNoZWVycywN
Ckp1c3RpbiAoSmlhIEhlKQ0KDQoNCj4gDQo+IElmIGFuZCB3aGVuIHdlIGdldCBvdGhlciBjaGVj
a3MgdGhhdCBuZWVkIHRvIGJlIGRvbmUgc2VsZWN0aXZlbHkgW2UuZy4NCj4gInNucHJpbnRmIGlu
dG8gYSB0b28gc2hvcnQgYnVmZmVyIHByb2R1Y2VzIGEgcHJlZml4IG9mIHRoZSBmdWxsIHN0cmlu
ZyIsDQo+IHdoaWNoIGFsc28gY2FtZSB1cCBkdXJpbmcgdGhpcyBkaXNjdXNzaW9uIGJ1dCB3YXMg
dWx0aW1hdGVseSBrZXB0XQ0KPiBkZXBlbmRpbmcgb24gdGhlICU8d2hhdGV2ZXI+IGJlaW5nIGV4
ZXJjaXNlZCwgd2UgY2FuIGFkZCBhICJ1MzIgbm9jaGVjayINCj4gd2l0aCBhIGJ1bmNoIG9mIGJp
dHMgc2F5aW5nIHdoYXQgdG8gZWxpZGUuDQo+IA0KPiBOb3QgaW5zaXN0aW5nIGVpdGhlciB3YXks
IGp1c3QgbXkgJDAuMDIuDQo+IA0KDQo=
