Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E673E0B59
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 02:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbhHEAkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 20:40:04 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:22500
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234461AbhHEAkC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 20:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y8Sl4cz8J8NcWf8EHltr9miOuVKEIb+dd2ejX5VUbg=;
 b=cf8Joun5McWzUtJlWBei7ooXmb6RVsyY/Xup7DXVSRzMVYDiJTSYEzo34bOWO5rQh0jVD8iDvfiwvvn6KAFBzm+3OP/esERXtBMPh84cITg6CMpf+3/H0fOQPIbkjaieeaonxQBj/PJpzEbw2IIv8s5nDqqQRfYN80gPbc5wPkA=
Received: from DB9PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::32) by AM8PR08MB5570.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 5 Aug
 2021 00:39:47 +0000
Received: from DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d8:cafe::ef) by DB9PR01CA0027.outlook.office365.com
 (2603:10a6:10:1d8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Thu, 5 Aug 2021 00:39:47 +0000
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
 15.20.4394.16 via Frontend Transport; Thu, 5 Aug 2021 00:39:47 +0000
Received: ("Tessian outbound 312d863716bf:v101"); Thu, 05 Aug 2021 00:39:46 +0000
X-CR-MTA-TID: 64aa7808
Received: from 189ada0c2b1d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 787A3FE7-1A14-47BC-B32E-72C75AFF2964.1;
        Thu, 05 Aug 2021 00:39:41 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 189ada0c2b1d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 05 Aug 2021 00:39:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkaZfTAGa33tpaYvvGhoBinn84e2LDZBpxgyMhan1Iki73GHnEzmhWKgY6SH10IOfP+oxA3amLeQcQBt5s6ejwAB23sJdhAs/L/3nWVY9jTjIhyY9Czpo+4Ygb6h/Phz7tv6lQJp+tBePA2Ddw/PrJP3I52TrVnEiCgDME0BP1ELA/Hdc56AJX/D23AzaNMq54f2ia7oALf84UsAMvQTBoEdILVfVncIxLQVbKnbszXA5VDs5j5hcYFptZWjt8nepZgF2g+awP3akAqZz6uReuI1CNdEQHbwRxIjU3jqcho/mPL27qpn2oXh6+nEru0o3wpoK0ybAiUZL5hasRX6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y8Sl4cz8J8NcWf8EHltr9miOuVKEIb+dd2ejX5VUbg=;
 b=LnhbF7jlVEVSPxz1e2JlERsUBwojweqdkBu5u9r67a7GyV3htPiHqGOh9G2K4zqhs5A/WMMqZaMSZJUa9dLy93HUn661oDEMZI3CqP7wUKBDX5dGDUBI9W4BqNPH3r6NtZk0Af8BYwFBgWcpy6QsM+pIPngLhx3+IBIto4/Ynj4sELB6xpT8V1mQ2ZTD5oR8OGlxoc095cRBA2LNhmnX7Sk3yB1BjHSsVZfxN8PQXhLA6LAKLx8BaNfSBik7iwcwegeZU3KfkBuz+eQTtAFeXHQlVRE6vb+NUm71Rvo9UpVOuff51x+jRkXZqr/1MtGpwonV4wpBgpl7gJP4AwdnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y8Sl4cz8J8NcWf8EHltr9miOuVKEIb+dd2ejX5VUbg=;
 b=cf8Joun5McWzUtJlWBei7ooXmb6RVsyY/Xup7DXVSRzMVYDiJTSYEzo34bOWO5rQh0jVD8iDvfiwvvn6KAFBzm+3OP/esERXtBMPh84cITg6CMpf+3/H0fOQPIbkjaieeaonxQBj/PJpzEbw2IIv8s5nDqqQRfYN80gPbc5wPkA=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4246.eurprd08.prod.outlook.com (2603:10a6:20b:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Thu, 5 Aug
 2021 00:39:31 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::a443:3fd9:42c2:4b85%5]) with mapi id 15.20.4394.016; Thu, 5 Aug 2021
 00:39:31 +0000
From:   Justin He <Justin.He@arm.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>
Subject: RE: [PATCH v7 0/5] make '%pD' print the full path of file
Thread-Topic: [PATCH v7 0/5] make '%pD' print the full path of file
Thread-Index: AQHXeRbET067LGtFt0yeGEUSyrno+atNgnqAgBavjtA=
Date:   Thu, 5 Aug 2021 00:39:30 +0000
Message-ID: <AM6PR08MB4376B0A9A230C3C71AC97F40F7F29@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210715011407.7449-1-justin.he@arm.com>
 <20210721141141.ehnnneafnwezqnk6@pathway.suse.cz>
In-Reply-To: <20210721141141.ehnnneafnwezqnk6@pathway.suse.cz>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 413D8EC8A4F75B41B5AEF9AB99E9CD20.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: d6d2aff4-48a9-4dd0-41a0-08d957a986cf
x-ms-traffictypediagnostic: AM6PR08MB4246:|AM8PR08MB5570:
X-Microsoft-Antispam-PRVS: <AM8PR08MB557024B1CE0EA9BD78954D0BF7F29@AM8PR08MB5570.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: k/u3nsJHb/MCPpkR/le6jeH7aEfj87wI9CWY9Sh6jICDJycD0CCvhs28TxQnsUAAgO51VoEUC2TJfGIrLnu0PCI6yNOtPTNM7ZSWzv8VT/Jcf5g+TOotOy66GAVUqiQRKj59wNekwYI7Qyw1mjkEBYwCaMaOVckZ55ey2VbMTjO0Y/wpNqdw0OvAIYaetMjpz5xo3jq3cT2VZ3zdVVhmmPEvEssJmH3xwoqgHy/Zx3rsZB1nVKJhXC+MV+7QxVv262dY/EqBO0RSznqJSqr0Pl31ObXQyx3drPCzd6Lf8MMvxCt/2snjUBQWf30SctMmSHHKbOP6DRhwuG9XnsPWG9/8TPM7wFvOeP3I9UsDN8jvZtb6dXzv2hnCbN71+Iw+ncZRRkTSs5ibIBJIRIaV5iFPyDvEEihiRxCItQvg+G2fkm/JYd/6ATINczhnDLBVuSgE7am47ljnI586oPtxEfHLYw5eo0q/SQW6L2axJ7fBSngNienD0/SVz8W28U227hcFLSn0S/GBsa83crbbhnEEThIeKbr7xIPw2uSOliHR7cyNqgg/DCkoXrg8TocYMZRuXv7BEpgM6kCdpFtZrjNo0F8S/kETZzk2spPmuKAQ+ZrcSSK8AJo/eaywN268u1kWkdzgCFPUwZ68lje91CVsrrZTbmXFNk4dBjA4TJViA1mSjlJgbfPYwQIOmQk27byeKxuX1ig8MJMeE14sKQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(186003)(76116006)(33656002)(6916009)(4326008)(2906002)(7416002)(66476007)(83380400001)(38070700005)(66446008)(64756008)(8936002)(66556008)(508600001)(8676002)(38100700002)(54906003)(6506007)(66946007)(26005)(53546011)(5660300002)(52536014)(122000001)(55016002)(9686003)(316002)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXh3d1Q0K0lUQ1RiTGNqSDBXQXNDazV5NGJWSFBCRnFTUjUvT3NPNVZjYmJW?=
 =?utf-8?B?dWdQUUVWc2VWRTdPdm96bkpwNGNHdHp5dGs5eE9TTkpHNjFUL0p5WW9jTzFn?=
 =?utf-8?B?L0d4bGoxckFscUdaam1xcTY2L0cwREdsWXZnamtkUmQvNlQ4K2MwTy9vZWxv?=
 =?utf-8?B?aVZ5RUU4MVBjWHNRS2dUaHcxWjdiNGZzb0NhTncwaU9TZzZGL25RN2V4VFd3?=
 =?utf-8?B?MCtPbnRMYitPSTE0eWtCYnNMQVJWNGV4S1dPMTlxZzhhMVI2di9vMUg5TUE2?=
 =?utf-8?B?N2VPL2RKRjk3RTJxVnB4d2JJTUphbXN1ZGFjUXFXaVhGV1JlK2NLWVJtN0dR?=
 =?utf-8?B?N3NtUFVEQU5MMWdMMjFaRGVLeGd2VnFUdTZZcmJDa2pwdEhCcVk3TWxHWnBs?=
 =?utf-8?B?QkFDMVdDZkNGR2JrbDRaZHNqOEpld09kd0NjeTZkQTM3ckF1amNoNlFjSjRJ?=
 =?utf-8?B?YVE3NlBaWmJoMFRFeTdTOURRdnpjRVI5c2xBS29sdUpqeThPRllDY05nM3Jm?=
 =?utf-8?B?MjJ4Q1JKWDl0L0J0VXZoVGpZM09qTTN5OXk3V25vWGVGSG5LMnNxRTBwdDhG?=
 =?utf-8?B?eUZWMTl1N0E4VWdsVEtGK0p4QlpSOExqb25pdFlsYnRXdnNTRzBob2NDZXZm?=
 =?utf-8?B?NHkzODZwVC9EQUw0ZkxLZEwxN1dva2NhY1JtVzM5L1VTYzJ3cEx4enBaN0NC?=
 =?utf-8?B?TW1sTDlESytMaG1iSUg1bDdURk5aYlExdDR6SGZUZmMvdnpaK3dpbDJ6V0Rs?=
 =?utf-8?B?TTd0Y2VicVphYWZlWXZKanU4cTBnRHBUYWNQTnBucC91NVNIM3d6ZEZlRUlC?=
 =?utf-8?B?WHBZZzVnd2VWU0FaZk4rQmN4QlAwTjAzeTB6OGlQTWc2QmFEN1hZN1p3eGFF?=
 =?utf-8?B?d0hEZGNNVmxUTWV0ZWl1U0dVL3VWN2RxRzlJSlE0Zk5UaDRVUmdLYUVSMlRJ?=
 =?utf-8?B?Nk96dzYyb1FnVE80cU9VVkVycDkzUlBoQUFHdENTZUNZNFRMMjZ0VXY0VU5M?=
 =?utf-8?B?YXZWWHhReXcxQXhvejB6cFJsWm9QRFdpVTF2WmRzNmtaUDAzSEFMQVBvOUg4?=
 =?utf-8?B?aFpqMXN2azVPaEdHQkovb3ZLa3AxQjNOL0ZGWVZoL2pQbzIxT1dUNG40djBk?=
 =?utf-8?B?VGhKcWpXOUNiZDRONFlBZXlmUFJtUVZ2NTFncWUwUlE2cHZhZGt3RC9MVDAr?=
 =?utf-8?B?SCtkYWpFWXBrbmZubmxpcFpZWFJKZG1mN0tnNjVnN0NFOCt2STErLzZVc29h?=
 =?utf-8?B?cStZTW5TNTRtem92Z0QxK1poSDZVQ3grY3ZObGdTTmMvSURHd1owL3ErZ3Rw?=
 =?utf-8?B?bDVhODF4Uy9pWDM0dWpUMTdzOHpMQWdyL2loV1UzL3ZLMFF6aGlva1htclJD?=
 =?utf-8?B?WjVxaHg3RE5McCs3RDY0ZWFVMWljMmpWUENlbTR4d2FVNElnVTczVGpIbDVq?=
 =?utf-8?B?MENJYU5hZHFFRDAzcGtISnl1azhJbXVITjdONkdKTUlNRTVlRC9mRTc5TXdY?=
 =?utf-8?B?WEVES1RPSlpKOVg1Z2xQNDJlZy9iSzgvTStDUXVNZmV2RExRTTlvNm83RkNH?=
 =?utf-8?B?cDVtaTJiV3AvVjFUb2w2alc0Ti9HRVI5aWR4MHRERnpudXUyWm1Ob2p2ZXYx?=
 =?utf-8?B?MWRZZVFpbUF4N0c4YjhoNzFvUXNCdEo4VEdNR0lUOUx6VVlzR0k1TjdadlVZ?=
 =?utf-8?B?ZVRzT0N1dVlORlVoaUtTQXdHckpYd0F3UFdISUR1UnJVWUY4cnJ6ZndiRHF0?=
 =?utf-8?Q?Klm3jgP9sdAZa7+Wadei6rppOwVZoH5h+PSkXmD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4246
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: cd5b3b4f-4a97-454d-924d-08d957a97d31
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdwzHB1OQowl1k0lg/hkH1QE5xs9A/4HkHCZADkkY42pEXGXWAhuiq0PRlSS+nFHHTE3hhg/x03cXnQjeEUurrmh2Hm/hEUyvMy0mPVtcPGvLJ20fqJ6TXsA+Cno6glds4VQtGv14L2m7V4ddIZpfZDhxZSNfA1s03Rgwr60cvKHUCE7mbb3XYCO/D6m1CXCJirhKsIbBxs+Wlio8KVO765VKB9Fd/Y6ZcZkjm6/eAkQRCYUuPv0M+O6woaCaDD7EqShX8r7GlX3wbBpRvRx/+RKSOVX8MwYGWzjcayKVhhOfbufM4f8jI3OXPTti9Eh6M5o/3e2QQViVn2qGK25GO/ykRUmNtpAKSmM9KBp5ejlsjPbFLzxQ99vMwxCmIIstI1VNcyYzs1iG73ufdJgzctlCABDMrTUrMEPUYvUGO+f4uOiT76yspgp2mQDkW1Bhge2EHTH6T30nEiqRnpPEfkYepG0676Y6MBCswj1WCOu0q+1/eEc3UGlmdGXFrkQeDKmeRA9FlqsME4PKlRPeArSVYigFeHAyH4dQKzIDfJ3bcscS1gJOxTNevM0qt8bwocw4n/2yEP0HX+DG7Wo3BHq4i8NhNTaD3gppKRcyjIwN4tMKFFk5pDV8WCHPlg+6ohXYJgHBMgncXRt8TdW54AmXN99OfjUNmB6RblGFnSusFd6AIdaB95TCuZAGTivGbLJrIjUcDD569QTHVCuVg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(396003)(346002)(36840700001)(46966006)(81166007)(86362001)(186003)(82310400003)(33656002)(82740400003)(336012)(356005)(5660300002)(70206006)(53546011)(6506007)(70586007)(6862004)(83380400001)(4326008)(2906002)(8676002)(26005)(8936002)(478600001)(52536014)(450100002)(316002)(9686003)(55016002)(7696005)(54906003)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2021 00:39:47.2340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d2aff4-48a9-4dd0-41a0-08d957a986cf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5570
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgQWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRyIE1sYWRl
ayA8cG1sYWRla0BzdXNlLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDIxLCAyMDIxIDEw
OjEyIFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsgQWxleGFuZGVyIFZp
cm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPg0KPiBDYzogU3RldmVuIFJvc3RlZHQgPHJvc3Rl
ZHRAZ29vZG1pcy5vcmc+OyBTZXJnZXkgU2Vub3poYXRza3kNCj4gPHNlbm96aGF0c2t5QGNocm9t
aXVtLm9yZz47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tPjsgUmFzbXVzIFZpbGxlbW9lcw0KPiA8bGludXhAcmFzbXVzdmlsbGVtb2VzLmRrPjsg
Sm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD47IExpbnVzDQo+IFRvcnZhbGRzIDx0b3J2
YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz47IFBldGVyIFppamxzdHJhIChJbnRlbCkNCj4gPHBl
dGVyekBpbmZyYWRlYWQub3JnPjsgRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0Bnb29nbGUuY29tPjsg
QWhtZWQgUy4NCj4gRGFyd2lzaCA8YS5kYXJ3aXNoQGxpbnV0cm9uaXguZGU+OyBsaW51eC1kb2NA
dmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgt
ZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc7IE1hdHRoZXcgV2lsY294DQo+IDx3aWxseUBpbmZyYWRl
YWQub3JnPjsgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsgbmQNCj4gPG5k
QGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMC81XSBtYWtlICclcEQnIHByaW50
IHRoZSBmdWxsIHBhdGggb2YgZmlsZQ0KPiANCj4gT24gVGh1IDIwMjEtMDctMTUgMDk6MTQ6MDIs
IEppYSBIZSB3cm90ZToNCj4gPiBCYWNrZ3JvdW5kDQo+ID4gPT09PT09PT09PQ0KPiA+IExpbnVz
IHN1Z2dlc3RlZCBwcmludGluZyB0aGUgZnVsbCBwYXRoIG9mIGZpbGUgaW5zdGVhZCBvZiBwcmlu
dGluZw0KPiA+IHRoZSBjb21wb25lbnRzIGFzICclcGQnLg0KPiA+DQo+ID4gVHlwaWNhbGx5LCB0
aGVyZSBpcyBubyBuZWVkIGZvciBwcmludGsgc3BlY2lmaWVycyB0byB0YWtlIGFueSByZWFsIGxv
Y2tzDQo+ID4gKGllIG1vdW50X2xvY2sgb3IgcmVuYW1lX2xvY2spLiBTbyBJIGludHJvZHVjZSBh
IG5ldyBoZWxwZXINCj4gPiBkX3BhdGhfdW5zYWZlKCkgd2hpY2ggaXMgc2ltaWxhciB0byBkX3Bh
dGgoKSBleGNlcHQgaXQgZG9lc24ndCB0YWtlIGFueQ0KPiA+IHNlcWxvY2svc3BpbmxvY2suDQo+
ID4NCj4gPiBUT0RPDQo+ID4gPT09PQ0KPiA+IEkgcGxhbiB0byBkbyB0aGUgZm9sbG93dXAgd29y
ayBhZnRlciAnJXBEJyBiZWhhdmlvciBpcyBjaGFuZ2VkLg0KPiA+IC0gczM5MC9obWNkcnY6IHJl
bW92ZSB0aGUgcmVkdW5kYW50IGRpcmVjdG9yeSBwYXRoIGluIHByaW50aW5nIHN0cmluZy4NCj4g
PiAtIGZzL2lvbWFwOiBzaW1wbGlmeSB0aGUgaW9tYXBfc3dhcGZpbGVfZmFpbCgpIHdpdGggJyVw
RCcuDQo+ID4gLSBzaW1wbGlmeSB0aGUgc3RyaW5nIHByaW50aW5nIHdoZW4gZmlsZV9wYXRoKCkg
aXMgaW52b2tlZChpbiBzb21lDQo+ID4gICBjYXNlcywgbm90IGFsbCkuDQo+ID4gLSBjaGFuZ2Ug
dGhlIHByZXZpb3VzICclcERbMiwzLDRdJyB0byAnJXBEJw0KPiA+DQo+ID4gSmlhIEhlICg0KToN
Cj4gPiAgIGRfcGF0aDogZml4IEtlcm5lbCBkb2MgdmFsaWRhdG9yIGNvbXBsYWludHMNCj4gPiAg
IGRfcGF0aDogaW50cm9kdWNlIGhlbHBlciBkX3BhdGhfdW5zYWZlKCkNCj4gPiAgIGxpYi92c3By
aW50Zi5jOiBtYWtlICclcEQnIHByaW50IHRoZSBmdWxsIHBhdGggb2YgZmlsZQ0KPiA+ICAgbGli
L3Rlc3RfcHJpbnRmLmM6IGFkZCB0ZXN0IGNhc2VzIGZvciAnJXBEJw0KPiA+DQo+ID4gUmFzbXVz
IFZpbGxlbW9lcyAoMSk6DQo+ID4gICBsaWIvdGVzdF9wcmludGYuYzogc3BsaXQgd3JpdGUtYmV5
b25kLWJ1ZmZlciBjaGVjayBpbiB0d28NCj4gDQo+IFRoZSBwYXRjaHNldCBpcyByZWFkeSBmb3Ig
bGludXgtbmV4dCBmcm9tIG15IFBPVi4NCj4gDQo+IEkgY291bGQgdGFrZSBpdCB2aWEgcHJpbnRr
IHRyZWUgaWYgQWwgcHJvdmlkZXMgQWNrcyBmb3IgdGhlDQo+IGZpcnN0IHR3byAiZF9wYXRoOiAq
OiBwYXRjaGVzLg0KPiANCj4gT3IgQWwgY291bGQgdGFrZSBpdCB2aWEgaGlzIHRyZWUgaWYgaGUg
d291bGQgcHJlZmVyIHRvIGRvIHNvLg0KDQpLaW5kbHkgcGluZyDwn5iJDQoNCi0tDQpDaGVlcnMs
DQpKdXN0aW4gKEppYSBIZSkNCg0KDQo=
