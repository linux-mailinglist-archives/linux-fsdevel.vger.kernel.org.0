Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA53D3B3AEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhFYCfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 22:35:30 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:56640
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233017AbhFYCfa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhw7TZxK/XEA9o3idriRuaSWfnQBvpoGiHCFjwiGe04=;
 b=Rwj6zOuFjQS7V0XfrAz4cWExiMAFymrKAikbHkAp8BxMa2ExclDbU870noaCwDLgWjykLRvEI/f5im3gnD+vG/ddANKl2O5NUClcs2fjGWR092IBTTennBzRDs4JN8/RgjV3xLsKiQNB7bxPVjmFz45rb/bOG7q8delVgnthZB8=
Received: from AM7PR03CA0005.eurprd03.prod.outlook.com (2603:10a6:20b:130::15)
 by AM0PR08MB3955.eurprd08.prod.outlook.com (2603:10a6:208:12d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 25 Jun
 2021 02:33:06 +0000
Received: from VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::82) by AM7PR03CA0005.outlook.office365.com
 (2603:10a6:20b:130::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 02:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT039.mail.protection.outlook.com (10.152.19.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 02:33:05 +0000
Received: ("Tessian outbound f88ae75fbd47:v96"); Fri, 25 Jun 2021 02:33:05 +0000
X-CR-MTA-TID: 64aa7808
Received: from 05653cd763ed.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F3BA853E-BF07-41A7-BBBD-4D3066A005CD.1;
        Fri, 25 Jun 2021 02:33:00 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 05653cd763ed.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Jun 2021 02:33:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3wSmJG2ANC9IRWNu25ZzNVVg1K86aj5Mi8nbOQIVDfYyuc+dJoAxzhMhGMKtF7Lu+rdY5i5N0bFu+4Re1IimBc45ENPRwiHaUPr+G9xUcfog6Qg8eqVpu1tMVLzlQfGhlF0NMYGIEpmO/bX688lqaQvnUbiNE12gHRdmsMilHnk5PB8nLPIEn3CgpKDQP/WrW5QYSMBnkbmQibLLple79MnZu19+tWOeSZaBBR+q/KHbGvpyWKzUt7kkxyPcZP/yon5AgwdfNTqHs9T1UEjPiuc1nZ78rwm8Qy7UltwyYAPtbPQQqg/6twNTIm1tKTpPcAYvs5P1pd0WgfJ3trWCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhw7TZxK/XEA9o3idriRuaSWfnQBvpoGiHCFjwiGe04=;
 b=KtMs/xWWfhL4os/55dYlpFigxGGbZQ61bnDPuvwEzmUvIfRwWkkBoUVMKngDH6+mMTry3sP0aUsYDDlxdCbsE/DzqLu7Ery6E5EeapqeSEzRvZuJJyOC1PXmFjdARjWq/Sm+0PNMz2s+Ft8J5TK2nz23BnoN/xjJMTbyS3xg4ltO/1pF8OoZDWU/zoJuyCXA1iVDMCigYwT/THEp7X06+eakrQ1Gf5+rq+Yd9OS7AOPVRK2V87DUIMp3hikcEk9+v7DskYn2gQbJ6XIhGsuYPqXU0uNy2cdFGdRbId/jrAMZ/F9Ez3osEXRn7lF4ShUVn3uaKxgC7HBl+GOx3raGXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhw7TZxK/XEA9o3idriRuaSWfnQBvpoGiHCFjwiGe04=;
 b=Rwj6zOuFjQS7V0XfrAz4cWExiMAFymrKAikbHkAp8BxMa2ExclDbU870noaCwDLgWjykLRvEI/f5im3gnD+vG/ddANKl2O5NUClcs2fjGWR092IBTTennBzRDs4JN8/RgjV3xLsKiQNB7bxPVjmFz45rb/bOG7q8delVgnthZB8=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3190.eurprd08.prod.outlook.com (2603:10a6:209:46::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 02:32:58 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 02:32:58 +0000
From:   Justin He <Justin.He@arm.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: RE: [PATCH v2 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Thread-Topic: [PATCH v2 2/4] lib/vsprintf.c: make '%pD' print the full path of
 file
Thread-Index: AQHXZ/O5UHs/WMb9uku9amq3N+sOmqsi3yWAgAACHdCAASM1QA==
Date:   Fri, 25 Jun 2021 02:32:58 +0000
Message-ID: <AM6PR08MB4376C621240CD63E215C40EEF7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-3-justin.he@arm.com> <YNRJ61m6duXjpGrp@alley>
 <AM6PR08MB4376E39649192846F644E785F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376E39649192846F644E785F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 6CD1CC7F5603FF4B9025836CC0C407BC.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 22d3a9b9-2893-4fac-3d94-08d937819063
x-ms-traffictypediagnostic: AM6PR08MB3190:|AM0PR08MB3955:
X-Microsoft-Antispam-PRVS: <AM0PR08MB3955D07D481B044D2ABFA59CF7069@AM0PR08MB3955.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:765;OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: V2u+wQPNPKYP6wEnjIDgKXRtVMRUqloGqseCIGSEwah51ThmNTZP6GbnT0+yh3552YJnkYO3+m+l0lHZbwLt/WVqN7LUP6L96N57+7PY4EB8NkfAidA6p3okJgb8MrFTEzKO3Jg5ktqx52/fDHhawq4+xKY0E3dpUR23kaLNHKPQsnodThvhnvLSnTl14P+VtQYzQDDSVcS85sO7GeXuMuyeg0sfMu2DAoAYH0EclFpkEB21KaZznbcxJ6zDDqPHlzGNGjurAd4ADcWSLRdrB8YE7pIJPgos1OE6e7UpNF9mSGZlvcsr675Qaj2jtOHEHy970h3xUyg37OIYqJxmoHR4Cz6BoREDb2VvQa7UKD/r+xbsycez7TCOvNOAsGv2Q+1AJsT4nxZFrKrpP8xhs0xtshIQtnvwJ6NoBPfkXRJK66NT0AgEXwqQ/XGBzkFQFiI7NbXBL7uS55BSD5bSobExlC2cvcfVIX60l3FV2p2SJ+K6Qu2j0kiejWdhwC5BZtNZLaL3mKOFTNpR+SQAW7CkVrNyH82Zr/lA64HxrmrN2nItXIFAmz0ia6DwDl/8rPlTKNXsNn1aMgsvK0XTxdL87YLjfTVTx+IbZhjD7gI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(9686003)(76116006)(5660300002)(66446008)(66476007)(66946007)(6916009)(66556008)(64756008)(53546011)(7416002)(6506007)(2940100002)(186003)(52536014)(26005)(86362001)(54906003)(478600001)(71200400001)(7696005)(4326008)(38100700002)(122000001)(316002)(2906002)(83380400001)(8936002)(33656002)(55016002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0F2SFowWTdjRU5FRHhDTzR3T3pwU1YwQ0ZKdUZvMkNIRmhtQjJWR0w3RmE3?=
 =?utf-8?B?VWQvc2IzTHFmVHIvem5peEh4SW9pSlBDejY5VnZaQWd2eUdyckxhL2RmWUNL?=
 =?utf-8?B?SVlMb3luK2hiMW5kYjR0VUVNK1lMRDZHWWtxcFhKVkxRSjVrMG9oWGVyVXI1?=
 =?utf-8?B?WDBvM3hDS3hwVXFVRVpaSmJ4NWNNT3gzMytWdkFSbVpVVUVFeVdkN2NlYldp?=
 =?utf-8?B?MVM5V21wU3VWdkgrNjdqRW9kaUtjRlpQOVE1SXJwNHRUTlhsMU5KZy92ME9a?=
 =?utf-8?B?Uk9DRmN4YXBPR0FNc3NDR1g2VU9aMGFlL1kvdlJ3Q1hPY0ZGRUVaNXNHOFB2?=
 =?utf-8?B?N2pKeXRLZkZ5NmxDZDNaN3ZQVEM2NXhuUFU0SmtzRlNPVkpWbVB5Ky9wRE82?=
 =?utf-8?B?R1d3cFJ2Y1ZHaTRsek1qbDZiSmFyVUNHUVpqZjVqajVNUUk2MmdGL1ZlUUww?=
 =?utf-8?B?WTYxZGFaL2NZWkhXMnQxQlBXc3ZIMnpBb1Rud2tlY0VvTVZmalNpeHh2NHF5?=
 =?utf-8?B?akV6cWdVTGRNMHhzcE13Z2JEQjYrU2E4L1VkT2p0bFoyREdWdmlhZFhsN0tk?=
 =?utf-8?B?MEJIejNOQjluWkNsR05RczNWbzhlQXFBbXlUQWRLVkQ4MjMzWWtFNkh5akly?=
 =?utf-8?B?anVwSUR5U1p0Q2h5V3JlT0xTVmhXR0w2UCtJcnBKSFJZeGd5bHdYOGVJWnR4?=
 =?utf-8?B?clpVWGFHY2xlblBWMlZhVUtXYnEvVGxmenJka1ZkcTY2V2g2aXRzRjlmVW5F?=
 =?utf-8?B?VXREcS9XVkpkdkI1Vjc4RFhyY01pUmVSaytCam9MNFhtQkk2cG5ZK3JEVVhI?=
 =?utf-8?B?azBjY2JnSEV0TERNQnBOUzgwcW43Q1RBRWcwVjFYRHlFK21HR2ZIeEZlNndv?=
 =?utf-8?B?bEZEQzE1OHJaL2pPOVJmdUZsdkI3WDVpMmdFK1FITm53TE0vY1Bzdzg0b1RD?=
 =?utf-8?B?eGRaeXJhNWE2WmJYb1NuR3pyMTB5SGJMZEFKaUVJRXA1UWMzVWg3cXhHR3BE?=
 =?utf-8?B?dHNQUVNUck5SNVZCRUJNbEF5VkU2QzZDUUM1aXVJYitVcXo1NjdwaGhXY2RN?=
 =?utf-8?B?NCtobVlTdkFNcENhQmV6UEVmY0NCYnhFTjdhYmRGN2JmM1oreUdGK1pMMmlR?=
 =?utf-8?B?Z1BwYnc0T2lmb1dERWdnMS9wdVAyejlxdU1aVkplYkZYaytIaDBwR2QyNzR6?=
 =?utf-8?B?Y3lOdFNWVXROdVU2ZkovUjFKTFg2VFZtb1d3cGJRVjdtdnJlbEM4eVM3NWNy?=
 =?utf-8?B?THo1SDRSR2MvTG80WXcwMm9aNit2SVZRREQ5ZFR2WDRsTmtsVk5iSTZlZVVB?=
 =?utf-8?B?WFJHRjA5Rm9ieVJjbHFzZktlM1FkcGxIblFYditQdS9FelJtRjUwS0hadHFl?=
 =?utf-8?B?eU1nT3dlQ3hraUY1UDVYQ2MzSkZQbDJ4REpEcEc3MkNieTR3a3VtaThHZ1Yv?=
 =?utf-8?B?Y01ZOXhXUmNjK3FhVjJPYk11MzNSdnFBbWdPQStWOWRETTdyS1VpUjBEdkdv?=
 =?utf-8?B?RmhyN3ZTTmtPTGU2SjdyZERseVlnaEI3UmtLY1VvbVk1SHpJRG5qV0s1RmhB?=
 =?utf-8?B?a3lpQmU0Y0tuNW1rYU5wQTFNdkJleWJWcUtCdndycDZXRVlTUCtpaTZDY1Iw?=
 =?utf-8?B?M1FIM211M1B1YmVGVEVzbnh1alVqditQZzNxOFBFQjNKdG9XYUNnQ3BQRTRM?=
 =?utf-8?B?eENDcGlBU1VXT0hubGFJc0dPaThaaGtXeUQ1d3pEdDUxeXRSc3BNaHVOWVdP?=
 =?utf-8?Q?JY8a43gOlFXXqGOqcIklL3pDg2gmufaGKjLqp63?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3190
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 713e730c-ab4a-4757-f154-08d937818bfc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjFZDbnYRQVPxt698GVDTKe74Yd2I6aUjYqIC7/uaLnON3b1qjb4BR+kVM7zyzBXfeV1fsc506fAD9ThTCYVqNgvRBtamYGMToaoO+2qcXNQ8LtdJMBLIzSewdets/het06426n8WKVaik2ktEJyfmbxpEUZw6Brsv+9D/8O1FDOPnl2eVdjeVGJmo8AHYfcnAxahaaGY+ET9M/nYzOye39VybL0+XYzFtWyCojC9mEtH6zlXhD16V9cKo4hNLCpFIRld4mprnQsQ+762qdiADYi5n/YPqlfTMRHIRtZWE6U2lKsYpVHEYqIMaOzhG10FHLFdxHGxL/gK5Oml2TJYYyedX2gN5jyanYNwdUXPz+V1WFjqULwnyzuVdBNNYe4vP/Stmd3XCntaDpbzdltCjQaE1kq85rL7gkUBuMrrz0owutSCBBTjJ/jmw9spPtinEan5XYnIpJG9ikZ32KSq0OCAiuZSO7MlXLo1PqsZjgGQnq3CwHn5pO98O6/jFsigzQzEuF543/EIlNsdZcZOC1YBVHyTdhGwTWditL2Y+3kSn0SlwqGl0L1F7jkM+BL9F8f4FRmd/q3c5SFG+jIp67/B7oGzOVDDmmRv/dtg/LWCvRvQYDXQpbH6UI6PJkO4mc9UaTM3AjKyi8q2OgQL3p87BLxfzZXrrOKdRVECo6jkug47h60CrIvWZoP6wG2hTAggtD+5uFr080y/0GZSg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39850400004)(346002)(136003)(46966006)(36840700001)(83380400001)(55016002)(316002)(33656002)(7696005)(6862004)(356005)(9686003)(36860700001)(336012)(478600001)(81166007)(2906002)(47076005)(82310400003)(186003)(26005)(54906003)(86362001)(6506007)(4326008)(8936002)(70586007)(2940100002)(82740400003)(53546011)(70206006)(52536014)(8676002)(5660300002)(450100002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 02:33:05.9998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d3a9b9-2893-4fac-3d94-08d937819063
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT039.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3955
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSnVzdGluIEhlDQo+IFNl
bnQ6IEZyaWRheSwgSnVuZSAyNSwgMjAyMSAxMDozMCBBTQ0KPiBUbzogUGV0ciBNbGFkZWsgPHBt
bGFkZWtAc3VzZS5jb20+DQo+IENjOiBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlzLm9y
Zz47IFNlcmdleSBTZW5vemhhdHNreQ0KPiA8c2Vub3poYXRza3lAY2hyb21pdW0ub3JnPjsgQW5k
eSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBSYXNt
dXMgVmlsbGVtb2VzDQo+IDxsaW51eEByYXNtdXN2aWxsZW1vZXMuZGs+OyBKb25hdGhhbiBDb3Ji
ZXQgPGNvcmJldEBsd24ubmV0PjsgQWxleGFuZGVyDQo+IFZpcm8gPHZpcm9AemVuaXYubGludXgu
b3JnLnVrPjsgTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LQ0KPiBmb3VuZGF0aW9uLm9y
Zz47IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgRXJpYw0K
PiBCaWdnZXJzIDxlYmlnZ2Vyc0Bnb29nbGUuY29tPjsgQWhtZWQgUy4gRGFyd2lzaCA8YS5kYXJ3
aXNoQGxpbnV0cm9uaXguZGU+Ow0KPiBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7
IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPjsgQ2hyaXN0b3BoDQo+IEhlbGx3
aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsgbmQgPG5kQGFybS5jb20+DQo+IFN1YmplY3Q6IFJFOiBb
UEFUQ0ggdjIgMi80XSBsaWIvdnNwcmludGYuYzogbWFrZSAnJXBEJyBwcmludCB0aGUgZnVsbCBw
YXRoDQo+IG9mIGZpbGUNCj4gDQo+IEhpIFBldHINCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiBGcm9tOiBQZXRyIE1sYWRlayA8cG1sYWRla0BzdXNlLmNvbT4NCj4gPiBT
ZW50OiBUaHVyc2RheSwgSnVuZSAyNCwgMjAyMSA1OjAyIFBNDQo+ID4gVG86IEp1c3RpbiBIZSA8
SnVzdGluLkhlQGFybS5jb20+DQo+ID4gQ2M6IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2Rt
aXMub3JnPjsgU2VyZ2V5IFNlbm96aGF0c2t5DQo+ID4gPHNlbm96aGF0c2t5QGNocm9taXVtLm9y
Zz47IEFuZHkgU2hldmNoZW5rbw0KPiA+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5j
b20+OyBSYXNtdXMgVmlsbGVtb2VzDQo+ID4gPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kaz47IEpv
bmF0aGFuIENvcmJldCA8Y29yYmV0QGx3bi5uZXQ+OyBBbGV4YW5kZXINCj4gPiBWaXJvIDx2aXJv
QHplbml2LmxpbnV4Lm9yZy51az47IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC0NCj4g
PiBmb3VuZGF0aW9uLm9yZz47IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRl
YWQub3JnPjsgRXJpYw0KPiA+IEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+OyBBaG1lZCBT
LiBEYXJ3aXNoIDxhLmRhcndpc2hAbGludXRyb25peC5kZT47DQo+ID4gbGludXgtZG9jQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+ID4gZnNk
ZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3Jn
PjsgQ2hyaXN0b3BoDQo+ID4gSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+OyBuZCA8bmRAYXJt
LmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gbGliL3ZzcHJpbnRmLmM6IG1h
a2UgJyVwRCcgcHJpbnQgdGhlIGZ1bGwNCj4gcGF0aA0KPiA+IG9mIGZpbGUNCj4gPg0KPiA+IE9u
IFdlZCAyMDIxLTA2LTIzIDEzOjUwOjA5LCBKaWEgSGUgd3JvdGU6DQo+ID4gPiBQcmV2aW91c2x5
LCB0aGUgc3BlY2lmaWVyICclcEQnIGlzIGZvciBwcmludGluZyBkZW50cnkgbmFtZSBvZiBzdHJ1
Y3QNCj4gPiA+IGZpbGUuIEl0IG1heSBub3QgYmUgcGVyZmVjdCAoYnkgZGVmYXVsdCBpdCBvbmx5
IHByaW50cyBvbmUgY29tcG9uZW50LikNCj4gPiA+DQo+ID4gPiBBcyBzdWdnZXN0ZWQgYnkgTGlu
dXMgWzFdOg0KPiA+ID4gPiBBIGRlbnRyeSBoYXMgYSBwYXJlbnQsIGJ1dCBhdCB0aGUgc2FtZSB0
aW1lLCBhIGRlbnRyeSByZWFsbHkgZG9lcw0KPiA+ID4gPiBpbmhlcmVudGx5IGhhdmUgIm9uZSBu
YW1lIiAoYW5kIGdpdmVuIGp1c3QgdGhlIGRlbnRyeSBwb2ludGVycywgeW91DQo+ID4gPiA+IGNh
bid0IHNob3cgbW91bnQtcmVsYXRlZCBwYXJlbnRob29kLCBzbyBpbiBtYW55IHdheXMgdGhlICJz
aG93IGp1c3QNCj4gPiA+ID4gb25lIG5hbWUiIG1ha2VzIHNlbnNlIGZvciAiJXBkIiBpbiB3YXlz
IGl0IGRvZXNuJ3QgbmVjZXNzYXJpbHkgZm9yDQo+ID4gPiA+ICIlcEQiKS4gQnV0IHdoaWxlIGEg
ZGVudHJ5IGFyZ3VhYmx5IGhhcyB0aGF0ICJvbmUgcHJpbWFyeSBjb21wb25lbnQiLA0KPiA+ID4g
PiBhIF9maWxlXyBpcyBjZXJ0YWlubHkgbm90IGV4Y2x1c2l2ZWx5IGFib3V0IHRoYXQgbGFzdCBj
b21wb25lbnQuDQo+ID4gPg0KPiA+ID4gSGVuY2UgY2hhbmdlIHRoZSBiZWhhdmlvciBvZiAnJXBE
JyB0byBwcmludCB0aGUgZnVsbCBwYXRoIG9mIHRoYXQgZmlsZS4NCj4gPiA+DQo+ID4gPiBJZiBz
b21lb25lIGludm9rZXMgc25wcmludGYoKSB3aXRoIHNtYWxsIGJ1dCBwb3NpdGl2ZSBzcGFjZSwN
Cj4gPiA+IHByZXBlbmRfbmFtZV93aXRoX2xlbigpIG1vdmVzIG9yIHRydW5jYXRlcyB0aGUgc3Ry
aW5nIHBhcnRpYWxseS4NCj4gPg0KPiA+IERvZXMgdGhpcyBjb21tZW50IGJlbG9uZyB0byB0aGUg
MXN0IHBhdGNoPw0KPiA+IHByZXBlbmRfbmFtZV93aXRoX2xlbigpIGlzIG5vdCBjYWxsZWQgaW4g
dGhpcyBwYXRjaC4NCj4gPg0KPiBUZW5kIHRvIHJlbW92ZSB0aGlzIHBhcmFncmFwaCBzaW5jZSB0
aGUgY29tbWVudHMgaW4gZG9fcGF0aF91bnNhZmUNCj4gKHBhdGNoMS80KQ0KPiB3YXMgY2xlYXIg
ZW5vdWdoLg0KSGksDQpJIG5vdGljZWQgeW91ciBzdWdnZXN0ZWQgY29tbWl0IG1zZyBpbiBhbm90
aGVyIHRocmVhZC4gUGxlYXNlIGlnbm9yZSBhYm92ZQ0KbXkgd29yZHMuDQoNCi0tDQpDaGVlcnMs
DQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
