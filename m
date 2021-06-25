Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEF03B3AE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 04:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhFYCcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 22:32:11 -0400
Received: from mail-am6eur05on2056.outbound.protection.outlook.com ([40.107.22.56]:54875
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232942AbhFYCcK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 22:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tThgxxUdVIz1d8sAZhck9ZnN2tVE+eGrkuTZlE8xS/I=;
 b=X7bwkG5Nr9y8twyAh4BGE7iUNgQniL2DAz36d499IrIkeMFFbwxmzbiVzfzTkd9fUZdqCSks23LI4oFaQA3m0wN8Cod9Sfqy0w5ljpNEAfZjJG8VwaE3TeddDMyEYdpcjlfLM76Wq+lk1uukRLICtXUp3mNeRzj65ifmD/LfLTs=
Received: from AM6P191CA0059.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::36)
 by AM6PR08MB4488.eurprd08.prod.outlook.com (2603:10a6:20b:71::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 25 Jun
 2021 02:29:46 +0000
Received: from AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:7f:cafe::5f) by AM6P191CA0059.outlook.office365.com
 (2603:10a6:209:7f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Fri, 25 Jun 2021 02:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT014.mail.protection.outlook.com (10.152.16.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 02:29:46 +0000
Received: ("Tessian outbound 7799c3c2ab28:v96"); Fri, 25 Jun 2021 02:29:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from 019af62cc55f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 22E0327D-E10E-43CE-A656-C408A9009C1A.1;
        Fri, 25 Jun 2021 02:29:41 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 019af62cc55f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Jun 2021 02:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWU8xezcAV2kJWKHBAFWk/6m8w4/8204mCFIXxrnuqnEDrs9rxEr19/hO2v2GFUDCNmyfpdenBWw0ifvpzjjc8HuK7A7FpOv0F67s7IuC1faRC9+EIo8bjTMVKz2j5Sz/qMjmb2YIFkIeWKvDKfcIfrKKimQFTWC00R9pRyWgaQ0e9N7b2FKHDWcpBw4zfNXSXJRyFqVPvqeS+DqzW5hAVoJQZf+qycLcyWWGkpxO16wqjJDIl7hmqqsmIPO6uYG4OJIAk/O/IO5g1p1342aFNXH0Ih+1uiq/zSNhxbZIZL3/H3b/6ujt1z2SsHJcBgGF2235iw0BzmQdC2dgFpqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tThgxxUdVIz1d8sAZhck9ZnN2tVE+eGrkuTZlE8xS/I=;
 b=EpcAUVzIIohFqIlAJIusN6dqbf4VMkR7QuuHFX3zcV6sw9wNKNceajdKVvIniz+ZR/jSvC50CAIrX35EEn8n5XO5rLxm+4n+F6C2MvIhPrLk8aXFwiGdqedx/dcH+iMO+QcMYyWBoIlylm82N0SIYk5UuYQFEBdC4bhGoNRg0I93W1zmiNZjF/ZsbF/tZIymFXBHOxRszmSSNtaNlIzO2KyfYH6I6Mob2i3SWwDNDiKId9gGAmsUKqr+RCcNxbWQfpqvq0pxilymNoOCahiAJBIVNRZRjMSSRbyDKz0khUd7XE8fcbRAWBvnVFUW/3CiJW5QjoCP1Q1azH296hEm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tThgxxUdVIz1d8sAZhck9ZnN2tVE+eGrkuTZlE8xS/I=;
 b=X7bwkG5Nr9y8twyAh4BGE7iUNgQniL2DAz36d499IrIkeMFFbwxmzbiVzfzTkd9fUZdqCSks23LI4oFaQA3m0wN8Cod9Sfqy0w5ljpNEAfZjJG8VwaE3TeddDMyEYdpcjlfLM76Wq+lk1uukRLICtXUp3mNeRzj65ifmD/LfLTs=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3190.eurprd08.prod.outlook.com (2603:10a6:209:46::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Fri, 25 Jun
 2021 02:29:39 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 02:29:39 +0000
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
Thread-Index: AQHXZ/O5UHs/WMb9uku9amq3N+sOmqsi3yWAgAACHdA=
Date:   Fri, 25 Jun 2021 02:29:38 +0000
Message-ID: <AM6PR08MB4376E39649192846F644E785F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-3-justin.he@arm.com> <YNRJ61m6duXjpGrp@alley>
In-Reply-To: <YNRJ61m6duXjpGrp@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 66732AB005D9624E92FDCEB2BB22FF26.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 4cda955c-976e-4d1e-3700-08d937811981
x-ms-traffictypediagnostic: AM6PR08MB3190:|AM6PR08MB4488:
X-Microsoft-Antispam-PRVS: <AM6PR08MB448851F4A7822C4B05DA3753F7069@AM6PR08MB4488.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lk0yNelz4y/oY+J3zh1eg3pmwgu5whLtnOYaXbqbkFWgRWUbf5GisfG1WKs005xIj0xfLd9zXkjq0V8K9D0nbyVE0wWw/9uTzgFy5sJbV1mWfLugRCxNoUVG4X0TuyLHeNU/QVRjtmEwvIa8GVReoh2NfbRdci5G8DI2oSd39YxPQVUsP35Dv2VoV2k5UUwCoSZfRePOK4XDtWHwefKzDO2G0DGQFBfFPBgDEIKx0LvVVQDVjLH1uCPtzKc1n0flJ3xIIntIOHs9DoWoGL62gZIK8Zr17XWxCz+Q0zIVTcwEocdGNijIoiJY052sX7e8rVaQyBwDaWknfGJEjdL/zSV7nmh/MRrNCm95MWgNnFpy8xcr2pNo4jMFXvXVj5C6NnJMpfstDsljEKw+AE9KmqbUw0xyEc8/zBBewGIFiHBvVAsFQMROcqvXhDzzB7uLnWu2je2jsiDSsJDILv1YK3a4Jo4ttvY2+fe1QXlnhjf/sludkWdJUoleJXxAYAn1n27mU1OleZt+SKlzTGcJjQjo0P0juY9k0BWZj72iJzf20XeOS3Ai4wjImGs1lFlYoCZDBlSndgF0yGCPBHSLAc+UuBMFPbBYj621W2RMnig=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(366004)(346002)(9686003)(76116006)(5660300002)(66446008)(66476007)(66946007)(6916009)(66556008)(64756008)(53546011)(7416002)(6506007)(186003)(52536014)(26005)(86362001)(54906003)(478600001)(71200400001)(7696005)(4326008)(38100700002)(122000001)(316002)(2906002)(83380400001)(8936002)(33656002)(55016002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUNKKytKUndTZEFaUnp0d0pQTkFoWnVGVHlMM1ExWmNmNG1RWU0wK1VUMkw0?=
 =?utf-8?B?N1A2WUhMVXRSVjlGQ2tPZ1JMNlcrbXJqaEIva0QwWi8ycFBjb3Z5eXlYa3Ba?=
 =?utf-8?B?U2l3R1lTaGd5VG8yMjhkRCtpVVp5SlJTSmw0R3M1TGdlWEdmNjY0MGM2bnAz?=
 =?utf-8?B?QWtvWkllZ3MvQlN6QWxaWjRURm8xR3JMOXhRWkdBREYzMWRLL0RSaThPaDI1?=
 =?utf-8?B?NHVPcFkrYlpFSVdEYjlHTFEwL2RLNEFqY3VxYm5meHhuRW1PMUdzSkJ0dWV5?=
 =?utf-8?B?TDhCb1VXMGIwVUR0SW9VY1lCVUxYZlNyUmJ4d1MzekZCMFdCN1hTY3luWEZk?=
 =?utf-8?B?RkZVeUdmMDY1Rzk0ckZ0NktpZFNhblFnemRIdGxuNXJXM1NRY1JHV3VMSHhK?=
 =?utf-8?B?YUJqeUhQdXdOSi9wTTdxZHY0QnBXdGo2c3Y2MXpFQlZOMVR2QUhIRFpLN1pa?=
 =?utf-8?B?bUFWYi9IV3JJU01talVSVktWS0k4RTFqa2tDUVFMcmJDbEd3YmMvN3dLNHhP?=
 =?utf-8?B?d2x3a0Q0Wm4rRGRQTlV3VUZTZUFrK1RKS215V3VlaXVBTkRwbjd4ekRBMnZ2?=
 =?utf-8?B?RTk1bHRqcXR2YXdmaGpteHBTUmk2Sk1jamxURjdCekhZdTRMejU2NVNiZlpI?=
 =?utf-8?B?VTBtc1p4K3d4TTBmRmxiN2pKWG4rMHpKeUVJUXpGcnU3SnhLbXBEdXFZSlZy?=
 =?utf-8?B?TlVWREJqZDdKbEpKdGtXeUV5RXhGWDBueXJIdnFubDVNb2ljamQ1YjdxQitW?=
 =?utf-8?B?YmhCTE9aSFljOEplVGZoTGd1TGRIVlJMVzNlRDlFeElNcjAzSVdWVHpOSkdo?=
 =?utf-8?B?eStnRkc2OU5iTnVSVTVmWjhZRnllN2RkRmQ0cjRpYjZ6NXlFcWtWM1E0Wndv?=
 =?utf-8?B?L1ZHa2h1NHBmc2FoZVE5NmpIUnNURzVEdnlMYmlxdnlRSmZVWEQ1VGNzQU5m?=
 =?utf-8?B?a2hLdWFFR0F2WnBjcExqN1V4RWFkVVcyOEluUlZzSUZyZHNNMi85dms3Z0Nv?=
 =?utf-8?B?amcyMmxhL2liNk5DdUthbldrR0FENWEvSVJ6U0NtQVp1WUdZWHhvTmpKMmxN?=
 =?utf-8?B?NkZqSHJ3d010cUJqSDR2MnJIT2dhbWJvbnFOOUJQeW9xK3VDbnc0dGVvbUND?=
 =?utf-8?B?OWd0ZVBtVTBkWGJPT01zTlduVFEvQ25sZnVXVlgxZ0ZncTd3azBTL2tybW8r?=
 =?utf-8?B?NXRmWEZxdGtubiswbmNReTUwMk0yWDVxU1dGTllybTBpTGFoRjdWYmdEbWVl?=
 =?utf-8?B?cmFLQ0YzTlQ3V1ZkSkt0RTlMbDIvblUzenQrUGRqU3p3azAxWS84T21VSm93?=
 =?utf-8?B?RXAzeW4yNHhYejVIMHVyTUxGa2ExSmQ5TVltWFdIMFI2TC9zUWlkYldRWEFG?=
 =?utf-8?B?bG9WajJzOFVCTGRBenVyYWliTmxMUTJSY3l1a0xQQWRLOFRqdUU3NWdtZWJR?=
 =?utf-8?B?cVZpemRxVDd4TEdNdkJQQlNJWUJDZCtOZGRaOXoyMEE1WHpzWEZxS0xUMDdH?=
 =?utf-8?B?VGFrclp5YkVFRDd0L2liL0xKbmlOVnZaVXZHWkF5OEtOR1hwZ0NoMjdIeDlK?=
 =?utf-8?B?Unk3SlpqMEM1ZGQ2TVVFd1VzT05WS00xWWJwc25BeGRxWXllMEpoV01OYklh?=
 =?utf-8?B?Q2ZUV0hIN3MvQWdqcmJNYVE4QnBoVk0rQzhsNWxhbEtIckNuUzgxODlrMHNu?=
 =?utf-8?B?Q1E0anNtZllRUDhGb29BTnU1ZUhTSzA3eFBWZ3pyTUFHK295UGNUNXQ3WWp2?=
 =?utf-8?Q?Y+0BDJSywjtD8eQrKS2969cX9/T0sU4j7PH8mh3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3190
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ac82be2-8113-432f-9abe-08d9378114f1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zJOxxqLjeF2hPQVkqeWBg2tAIkYlBUZEDF2Fq5TmBVqTp9KWGDtBKdK4R5NTKw1odyXb31WHSRYP0y4cnZhFbdSadhaktniLuu4V2QRnzon/i00OFmYJSCy3DuKCxEy2WmMABZi2F9E2y9TYtZxvjbTgI9ERAe8gPmrWN6kPOB2rUXLZlgdq27ECCzAaafsGMBLrGfZFg2R+nI0OjpTmdRXJMRVjcsr7cP9oSLD0zVE7q7i+NYKoC5nr0wkow3IGEVNsAwMwUaCdUKhV88d2aJcpWknyqr4KVUiif+rCZsYvRcu7ikwZfibpuc4nNhjXZUepVApGigkS5LMnDswAv5CJt2n7LHXrCN7/PClLkPDdDxhsOi5fO7miefHBIGtFuIpY8ytYsKooTVDHGs1xA4A3Ysw1W/HA6JsvN5WH9dwA9WiCh4CQBvv15CLz12woOpYR4EO/CbuvcUAnsyjWj8+IQcrl8ZAI4oBIjVnsVKg8t0HC863x5etzFp4Lo3fvbIoPyfxeP2R3TO94hUOGHVGjomdhjsCEjNFTRhfH30YU2p87jOfv6+WNwUJiZH+1/nFptww3l6+uu5n8e+hBkzgZzaTNdPDj7e6QHFRTVt3Y16fTfJ1tfmR1oBKgYJECfX46dAVxTEgCDbCPq9Ei9LIrb6p4/mV2V1M1imoWSZFvSNXI57Xw/qLfgQNENlB2+FdyQhC6lGnsWQe9UkW9Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(376002)(396003)(46966006)(36840700001)(54906003)(8936002)(47076005)(70586007)(70206006)(82740400003)(336012)(33656002)(36860700001)(8676002)(478600001)(316002)(6862004)(5660300002)(83380400001)(186003)(2906002)(53546011)(6506007)(7696005)(450100002)(55016002)(356005)(4326008)(81166007)(52536014)(82310400003)(9686003)(86362001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 02:29:46.6683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cda955c-976e-4d1e-3700-08d937811981
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT014.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4488
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgUGV0cg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBldHIgTWxh
ZGVrIDxwbWxhZGVrQHN1c2UuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgSnVuZSAyNCwgMjAyMSA1
OjAyIFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogU3RldmVu
IFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+OyBTZXJnZXkgU2Vub3poYXRza3kNCj4gPHNl
bm96aGF0c2t5QGNocm9taXVtLm9yZz47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tPjsgUmFzbXVzIFZpbGxlbW9lcw0KPiA8bGludXhAcmFzbXVz
dmlsbGVtb2VzLmRrPjsgSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD47IEFsZXhhbmRl
cg0KPiBWaXJvIDx2aXJvQHplbml2LmxpbnV4Lm9yZy51az47IExpbnVzIFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC0NCj4gZm91bmRhdGlvbi5vcmc+OyBQZXRlciBaaWpsc3RyYSAoSW50ZWwpIDxw
ZXRlcnpAaW5mcmFkZWFkLm9yZz47IEVyaWMNCj4gQmlnZ2VycyA8ZWJpZ2dlcnNAZ29vZ2xlLmNv
bT47IEFobWVkIFMuIERhcndpc2ggPGEuZGFyd2lzaEBsaW51dHJvbml4LmRlPjsNCj4gbGludXgt
ZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
DQo+IGZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFk
ZWFkLm9yZz47IENocmlzdG9waA0KPiBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz47IG5kIDxu
ZEBhcm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gbGliL3ZzcHJpbnRmLmM6
IG1ha2UgJyVwRCcgcHJpbnQgdGhlIGZ1bGwgcGF0aA0KPiBvZiBmaWxlDQo+IA0KPiBPbiBXZWQg
MjAyMS0wNi0yMyAxMzo1MDowOSwgSmlhIEhlIHdyb3RlOg0KPiA+IFByZXZpb3VzbHksIHRoZSBz
cGVjaWZpZXIgJyVwRCcgaXMgZm9yIHByaW50aW5nIGRlbnRyeSBuYW1lIG9mIHN0cnVjdA0KPiA+
IGZpbGUuIEl0IG1heSBub3QgYmUgcGVyZmVjdCAoYnkgZGVmYXVsdCBpdCBvbmx5IHByaW50cyBv
bmUgY29tcG9uZW50LikNCj4gPg0KPiA+IEFzIHN1Z2dlc3RlZCBieSBMaW51cyBbMV06DQo+ID4g
PiBBIGRlbnRyeSBoYXMgYSBwYXJlbnQsIGJ1dCBhdCB0aGUgc2FtZSB0aW1lLCBhIGRlbnRyeSBy
ZWFsbHkgZG9lcw0KPiA+ID4gaW5oZXJlbnRseSBoYXZlICJvbmUgbmFtZSIgKGFuZCBnaXZlbiBq
dXN0IHRoZSBkZW50cnkgcG9pbnRlcnMsIHlvdQ0KPiA+ID4gY2FuJ3Qgc2hvdyBtb3VudC1yZWxh
dGVkIHBhcmVudGhvb2QsIHNvIGluIG1hbnkgd2F5cyB0aGUgInNob3cganVzdA0KPiA+ID4gb25l
IG5hbWUiIG1ha2VzIHNlbnNlIGZvciAiJXBkIiBpbiB3YXlzIGl0IGRvZXNuJ3QgbmVjZXNzYXJp
bHkgZm9yDQo+ID4gPiAiJXBEIikuIEJ1dCB3aGlsZSBhIGRlbnRyeSBhcmd1YWJseSBoYXMgdGhh
dCAib25lIHByaW1hcnkgY29tcG9uZW50IiwNCj4gPiA+IGEgX2ZpbGVfIGlzIGNlcnRhaW5seSBu
b3QgZXhjbHVzaXZlbHkgYWJvdXQgdGhhdCBsYXN0IGNvbXBvbmVudC4NCj4gPg0KPiA+IEhlbmNl
IGNoYW5nZSB0aGUgYmVoYXZpb3Igb2YgJyVwRCcgdG8gcHJpbnQgdGhlIGZ1bGwgcGF0aCBvZiB0
aGF0IGZpbGUuDQo+ID4NCj4gPiBJZiBzb21lb25lIGludm9rZXMgc25wcmludGYoKSB3aXRoIHNt
YWxsIGJ1dCBwb3NpdGl2ZSBzcGFjZSwNCj4gPiBwcmVwZW5kX25hbWVfd2l0aF9sZW4oKSBtb3Zl
cyBvciB0cnVuY2F0ZXMgdGhlIHN0cmluZyBwYXJ0aWFsbHkuDQo+IA0KPiBEb2VzIHRoaXMgY29t
bWVudCBiZWxvbmcgdG8gdGhlIDFzdCBwYXRjaD8NCj4gcHJlcGVuZF9uYW1lX3dpdGhfbGVuKCkg
aXMgbm90IGNhbGxlZCBpbiB0aGlzIHBhdGNoLg0KPiANClRlbmQgdG8gcmVtb3ZlIHRoaXMgcGFy
YWdyYXBoIHNpbmNlIHRoZSBjb21tZW50cyBpbiBkb19wYXRoX3Vuc2FmZSAocGF0Y2gxLzQpDQp3
YXMgY2xlYXIgZW5vdWdoLg0KDQo+ID4gTW9yZQ0KPiA+IHRoYW4gdGhhdCwga2FzcHJpbnRmKCkg
d2lsbCBwYXNzIE5VTEwgQGJ1ZiBhbmQgQGVuZCBhcyB0aGUgcGFyYW1ldGVycywNCj4gPiBhbmQg
QGVuZCAtIEBidWYgY2FuIGJlIG5lZ2F0aXZlIGluIHNvbWUgY2FzZS4gSGVuY2UgbWFrZSBpdCBy
ZXR1cm4gYXQNCj4gPiB0aGUgdmVyeSBiZWdpbm5pbmcgd2l0aCBmYWxzZSBpbiB0aGVzZSBjYXNl
cy4NCj4gDQo+IFNhbWUgaGVyZS4gZmlsZV9kX3BhdGhfbmFtZSgpIGRvZXMgbm90IHJldHVybiBi
b29sLg0KPiANCj4gV2VsbCwgcGxlYXNlIG1lbnRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHRo
YXQgJXBEIHVzZXMgdGhlIGVudGlyZQ0KPiBnaXZlbiBidWZmZXIgYXMgYSBzY3JhdGNoIHNwYWNl
LiBJdCBtaWdodCB3cml0ZSBzb21ldGhpbmcgYmVoaW5kDQo+IHRoZSB0cmFpbGluZyAnXDAnLg0K
PiANCj4gSXQgd291bGQgbWFrZSBzZW5zZSB0byB3YXJuIGFib3V0IHRoaXMgYWxzbyBpbg0KPiBE
b2N1bWVudGF0aW9uL2NvcmUtYXBpL3ByaW50ay1mb3JtYXRzLnJzdC4gSXQgaXMgYSBiaXQgbm9u
LXN0YW5kYXJkDQo+IGJlaGF2aW9yLg0KPiANCk9rYXkNCg0KPiA+IGRpZmYgLS1naXQgYS9saWIv
dnNwcmludGYuYyBiL2xpYi92c3ByaW50Zi5jDQo+ID4gaW5kZXggZjBjMzVkOWI2NWJmLi5mNDQ5
NDEyOTA4MWYgMTAwNjQ0DQo+ID4gLS0tIGEvbGliL3ZzcHJpbnRmLmMNCj4gPiArKysgYi9saWIv
dnNwcmludGYuYw0KPiA+IEBAIC05MjAsMTMgKzkyMSw0NCBAQCBjaGFyICpkZW50cnlfbmFtZShj
aGFyICpidWYsIGNoYXIgKmVuZCwgY29uc3QNCj4gc3RydWN0IGRlbnRyeSAqZCwgc3RydWN0IHBy
aW50Zl9zcA0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIG5vaW5saW5lX2Zvcl9zdGFjaw0KPiA+
IC1jaGFyICpmaWxlX2RlbnRyeV9uYW1lKGNoYXIgKmJ1ZiwgY2hhciAqZW5kLCBjb25zdCBzdHJ1
Y3QgZmlsZSAqZiwNCj4gPiArY2hhciAqZmlsZV9kX3BhdGhfbmFtZShjaGFyICpidWYsIGNoYXIg
KmVuZCwgY29uc3Qgc3RydWN0IGZpbGUgKmYsDQo+ID4gIAkJCXN0cnVjdCBwcmludGZfc3BlYyBz
cGVjLCBjb25zdCBjaGFyICpmbXQpDQo+ID4gIHsNCj4gPiArCWNoYXIgKnA7DQo+ID4gKwljb25z
dCBzdHJ1Y3QgcGF0aCAqcGF0aDsNCj4gPiArCWludCBwcmVwZW5kX2xlbiwgd2lkZW5fbGVuLCBk
cGF0aF9sZW47DQo+ID4gKw0KPiA+ICAJaWYgKGNoZWNrX3BvaW50ZXIoJmJ1ZiwgZW5kLCBmLCBz
cGVjKSkNCj4gPiAgCQlyZXR1cm4gYnVmOw0KPiA+DQo+ID4gLQlyZXR1cm4gZGVudHJ5X25hbWUo
YnVmLCBlbmQsIGYtPmZfcGF0aC5kZW50cnksIHNwZWMsIGZtdCk7DQo+ID4gKwlwYXRoID0gJmYt
PmZfcGF0aDsNCj4gPiArCWlmIChjaGVja19wb2ludGVyKCZidWYsIGVuZCwgcGF0aCwgc3BlYykp
DQo+ID4gKwkJcmV0dXJuIGJ1ZjsNCj4gPiArDQo+ID4gKwlwID0gZF9wYXRoX3Vuc2FmZShwYXRo
LCBidWYsIGVuZCAtIGJ1ZiwgJnByZXBlbmRfbGVuKTsNCj4gPiArDQo+ID4gKwkvKiBDYWxjdWxh
dGUgdGhlIGZ1bGwgZF9wYXRoIGxlbmd0aCwgaWdub3JpbmcgdGhlIHRhaWwgJ1wwJyAqLw0KPiA+
ICsJZHBhdGhfbGVuID0gZW5kIC0gYnVmIC0gcHJlcGVuZF9sZW4gLSAxOw0KPiA+ICsNCj4gPiAr
CXdpZGVuX2xlbiA9IG1heF90KGludCwgZHBhdGhfbGVuLCBzcGVjLmZpZWxkX3dpZHRoKTsNCj4g
PiArDQo+ID4gKwkvKiBDYXNlIDE6IEFscmVhZHkgc3RhcnRlZCBwYXN0IHRoZSBidWZmZXIuIEp1
c3QgZm9yd2FyZCBAYnVmLiAqLw0KPiA+ICsJaWYgKGJ1ZiA+PSBlbmQpDQo+ID4gKwkJcmV0dXJu
IGJ1ZiArIHdpZGVuX2xlbjsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogQ2FzZSAyOiBUaGUg
ZW50aXJlIHJlbWFpbmluZyBzcGFjZSBvZiB0aGUgYnVmZmVyIGZpbGxlZCBieQ0KPiA+ICsJICog
dGhlIHRydW5jYXRlZCBwYXRoLiBTdGlsbCBuZWVkIHRvIGdldCBtb3ZlZCByaWdodCB3aGVuDQo+
ID4gKwkgKiB0aGUgZmlsbGVkIHdpZHRoIGlzIGdyZWF0aGVyIHRoYW4gdGhlIGZ1bGwgcGF0aCBs
ZW5ndGguDQo+IA0KPiBzL2ZpbGxlZC9maWVsZC8gPw0KPiANCkFoLCBzb3JyeSwgSSBjaGFuZ2Vk
IGl0LiBJIHdvdWxkIGhhdmUgdGhvdWdodCBpdCBhcyBhIHR5cG8g8J+Yig0KDQoNCi0tDQpDaGVl
cnMsDQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
