Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA13B3A3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 02:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhFYAp5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 20:45:57 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:1760
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229521AbhFYAp4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pd1+2roXk5nw9Yv2jSOaDTqOH8BdEZ9dbsP9ULyPQ4=;
 b=5ky5WEYMHus13uhXeTH45P1GFJUg3D1pHWdtATxFddKd3Q8ULsoxRyS62obGaq07It1uoZ5ZyDXBPFdWi3Ts2iMIWuOyqLU/ksEwf1IxInZ1G5YyoSQdCNvZmmumKcgSm8eIx+lCIOm3WNnTcst9oGmC9hsiCxDRGzWHkyQmM0Y=
Received: from DB8PR09CA0016.eurprd09.prod.outlook.com (2603:10a6:10:a0::29)
 by AM6PR08MB3048.eurprd08.prod.outlook.com (2603:10a6:209:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 25 Jun
 2021 00:43:32 +0000
Received: from DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::9c) by DB8PR09CA0016.outlook.office365.com
 (2603:10a6:10:a0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Fri, 25 Jun 2021 00:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT013.mail.protection.outlook.com (10.152.20.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Fri, 25 Jun 2021 00:43:32 +0000
Received: ("Tessian outbound f945d55369ce:v96"); Fri, 25 Jun 2021 00:43:31 +0000
X-CR-MTA-TID: 64aa7808
Received: from 551acb9212c6.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3F5E62C1-0FC2-4BCA-9E85-008D75CA8634.1;
        Fri, 25 Jun 2021 00:43:25 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 551acb9212c6.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 25 Jun 2021 00:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joyK4jiVih3kIt4eT7+B6BRYerScMSZzpDvnijQNFKmg60pBch5vx/F63U8rVDgVtYwVbaYXZ8Jxlp1KIgBXaAUMCleDI9EtiPZUyeoBXz0rNSz264BRGjtEXUd+2d6/s/pceex2LwvW3Dvxza91ykmkJt55X3sg+YDHys38ipJ0peBEzqRyt2a9gqmUOjaPh7rZucwH1ruzzQyUlwcEtR4ZDRAfLTield2hfHFUmfUBBlGJfcfgFd8yGMVihIi6fSvNA8A83+nJ194CThuuCvTYkI+DidRtvaTsUSzxTvuU8jYJMy1D6ybWzbI39mPKRLnfweKTzrW9llbqMiycdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pd1+2roXk5nw9Yv2jSOaDTqOH8BdEZ9dbsP9ULyPQ4=;
 b=oWC1Cs4NowmbVXb1R84KBOBgBp7d1owj3ZOqO54hQ8aJNzPlUZ12f0Jk9Ier3njL+WPYWYNFOlfAhHrOWo1Y4F7tM8/Y1B4igXov49MJLywFmRiZvkWB+QBR+/uKwn3yUgvkjKR5GnuGp1KJjTIkQwwksuVHoFeINvj38niadHe7BUvQhCgvo6qWZZFsAfI1NoWRUj2jKaypfKSKdDRhT3vDoRRCJZrNNA1CuwZu4ZO5nZPlwF90zd9KqkfN6SsAPg1U2x85nz8wxUD3EAy60vHjf061OD2vx/S2d1e/Zs8Nn1FoVWMAcJkHLMIwsc4N6oAKP1D4mrzRKsU1fU2FIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pd1+2roXk5nw9Yv2jSOaDTqOH8BdEZ9dbsP9ULyPQ4=;
 b=5ky5WEYMHus13uhXeTH45P1GFJUg3D1pHWdtATxFddKd3Q8ULsoxRyS62obGaq07It1uoZ5ZyDXBPFdWi3Ts2iMIWuOyqLU/ksEwf1IxInZ1G5YyoSQdCNvZmmumKcgSm8eIx+lCIOm3WNnTcst9oGmC9hsiCxDRGzWHkyQmM0Y=
Received: from AM0PR08MB4370.eurprd08.prod.outlook.com (2603:10a6:208:148::20)
 by AM0PR08MB4948.eurprd08.prod.outlook.com (2603:10a6:208:163::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Fri, 25 Jun
 2021 00:43:23 +0000
Received: from AM0PR08MB4370.eurprd08.prod.outlook.com
 ([fe80::b551:868b:cec7:2e23]) by AM0PR08MB4370.eurprd08.prod.outlook.com
 ([fe80::b551:868b:cec7:2e23%7]) with mapi id 15.20.4264.020; Fri, 25 Jun 2021
 00:43:23 +0000
From:   Justin He <Justin.He@arm.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
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
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, nd <nd@arm.com>
Subject: RE: [PATCH 09/14] d_path: introduce struct prepend_buffer
Thread-Topic: [PATCH 09/14] d_path: introduce struct prepend_buffer
Thread-Index: AQHXTEjYkwczPOUyUkWE0gldq/uCLqshzh/ggAFQTgCAAP464A==
Date:   Fri, 25 Jun 2021 00:43:22 +0000
Message-ID: <AM0PR08MB4370B5A85FFDD36D79DE73E2F7069@AM0PR08MB4370.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-9-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376D92F354CD17445DC4EC1F7089@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <f9908c77-77e2-03fd-25a4-f7ce9802535e@metux.net>
In-Reply-To: <f9908c77-77e2-03fd-25a4-f7ce9802535e@metux.net>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 053F43D5FE916C45952CE97128EFE2F3.0
x-checkrecipientchecked: true
Authentication-Results-Original: metux.net; dkim=none (message not signed)
 header.d=none;metux.net; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: da59c2b5-fcaa-48de-9f26-08d9377241e0
x-ms-traffictypediagnostic: AM0PR08MB4948:|AM6PR08MB3048:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3048C53E08BC9B4D521BFD04F7069@AM6PR08MB3048.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: GDfJJ3O/RzJJ1Z9Fyvx/Rm+ypo8i31rm6l7PBnoOddDKGpiGDwGKEN6kPokngf9prIWr5J16ghmovx5TTtoq4GpJopG5e5JZfcSnJ6iqbuU5pfd3hxvDYdCyNSDEdj4EFOefWQTrYc9ontFehzUSsADfevnFv8rmhcxEnBbXxCBLut3qaZe2qflYPuV7bEorbvVS6IxRB89EzkmTGMlo8PRoIqICN/n2daQjfsrSd7D013JcZIjB6Sep3/+bZrWFQzl6smAN04B7WH91UweCYxCL+r6W7vtL3SODqN8KVT3gO8JIVuOGoSPLydfSWLFNNeIt1xqGPgZtPtWZSMLn5VbApfpsWSzNOv92Wc6I7V93p0Z7jEJy5C1npMb6WiHReM29JNpLm7E8iT53xRZS3IsCQrP8aZtOpEXJ+O4d+TuMgxUaNZCtqT52+jNiFZ13eHpv/LV1qGUuwVqbW5i+/MoiQaFm7RFqvs9R7KOXw5SKjZUeChy9F2q+CMk+s5tndPmC1G4yHvvcmlEV69WJRHlLb+pu9bI9Hibi5z1PjX5zkdq8QzfzXVxFMl8rfFfRugqMiRKJvoEMo6U2YXVJeFLvdig6XDkwtDcgDdIUFdE=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4370.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39850400004)(186003)(8936002)(6506007)(26005)(7696005)(53546011)(5660300002)(66556008)(33656002)(4326008)(7416002)(76116006)(52536014)(66946007)(64756008)(66476007)(66446008)(8676002)(38100700002)(55016002)(54906003)(110136005)(83380400001)(478600001)(71200400001)(86362001)(9686003)(122000001)(316002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUdWa3JGT0plWG90YmlsYmtSUkwxN0ZhMmltU0VueEhIU3B2V3VKNHZhT0N3?=
 =?utf-8?B?MzBiSTk5WS82VndZRERpakw4VVkyencvQTBSUzgyczVRbjgzWGVxdW5FUFIx?=
 =?utf-8?B?L3FmU3pMV25peUtiVHNieElZVW9BcmVjZ0N2bG5tamJCeS9vbFRuLy83cU8w?=
 =?utf-8?B?YU9ZVG5ZcXpjdnY4eVRSNVQ2OU1NM2NaK3gzbzJvb2dIZ0xVWVVBZHJiYnUy?=
 =?utf-8?B?ZGl6VGV2c2RxZ2w5ZEFUQU1waExhaVNlT245NGNZbmlPR0c2VTlrQnFvblZT?=
 =?utf-8?B?ZjhzZy80Mjg5RTc4bitIYWFKUUJvRi9PcTVndlFKdzhRVUdTbDNVaUkxTVdW?=
 =?utf-8?B?K01HYy9malRtRGZyOWJ6RGRDN21JQmFIVUVuVGF3MXBwd0tsZEdLU2NkRjhU?=
 =?utf-8?B?MnJUc3E0V1dFZnArMGFCNXFNd2NySmdhbHFGUmRETWF1NFBnSTIyWTllMmtO?=
 =?utf-8?B?eUIwVThTeGlscjRBd2FFZ0lrSk1xL0tFbEhtZVNsVElNUFJHTllDT1RibnBu?=
 =?utf-8?B?NW1xVTY1b21BSFZOREJFSVNwUHZ6ZUIyOU52Q2Iva3pzMXdJeG1Bc3NOY29H?=
 =?utf-8?B?SHA3NUw4azM5R0swdmR4T2VmSVBlbG9nc1ptMGtPcUhDYkMxczBjMkxIM09a?=
 =?utf-8?B?Q2hUanhxckovR0Y2c1V4MmhJSzJkNU1DNVl6Y2xZZzBRZEpaaldQZmg5Uy96?=
 =?utf-8?B?U3ZBWDhlZU1xUjdrVndCaHFmTklQaDF5Nkd6SXhSejhmb2xMM0JlSTRmUzNs?=
 =?utf-8?B?TEUzL2JPYi9aQ053clh4T3NJZjRLRmFtajN4U2llQUxpNmRSZCs2cm85bkVy?=
 =?utf-8?B?UVlpalNMamZ2Qzg1UTg1aythcEJpUmNWSmc3NGovY1hOZVhtWjVjZW8vSmN0?=
 =?utf-8?B?THlVS3Q4bTJZRzhhdTZ0ME41dG5mSk0zNjI2RHU2c3VQQXRFdWN1R3VORGFT?=
 =?utf-8?B?NjBBNlB6S09WVWM5anVvc3RnWCtNdFE0cWR6SHpsUi9SR1NMMCthUVFBZkpP?=
 =?utf-8?B?YTgzVHZXWEE5M09xNmxlSHVFRTVwZTA2SjBCcENZV083YnNCOEFwa1VDS0VF?=
 =?utf-8?B?NkVERzEvT0szdFBCNEZrL0ZDaDZvQjB2QmZpTHFna3NrcHR3UGpnU2sxSk9k?=
 =?utf-8?B?Q3gwZ0RWNVZuUHhsbFoyR1l1UGt1cWV5V0Y0ZytLcWRCeXEvdmRmdS9KM0d6?=
 =?utf-8?B?cFNqVFRGeFJZMEpqdHNoeEJwMWdvWU9hanpVY25RVVluQTgrWWpDZ255dUVI?=
 =?utf-8?B?TDErRXhVREZKQlVLeFA5cmU0Mms3SnNJNkF2NHhKSmpzRHVPeU9JWWx3TW15?=
 =?utf-8?B?MVV5ZWJXNW5yRVBic1ZBemhZb1R4aExVZmM2eHlLTmZJU01kaktualhxKzNn?=
 =?utf-8?B?Ym8wQnNtUUJ4ZXBCaDUxZ2JuY0xJWk1mUEh6ZEI2NlhvSG5HbHU5dDdKdy9t?=
 =?utf-8?B?a3N4YTJ6VExjZWwwczZXRGlXZno2bTBDaEFWN3hJS0JMckREK0M4RFp4cTRR?=
 =?utf-8?B?ZmNRVEZCLzJLSkpSS3M0ZGl6c2JUbWc0L2ZPeklnV1h5cWxEb3RtdFR0RkFW?=
 =?utf-8?B?YjkySER6ZkZNL2ZmZGNGcHhpWlRuQ0VDNms2QVlpQ2NZZjlmV2NJUkJadlU5?=
 =?utf-8?B?T1Mra3ErcnQwL2ZLU1c3QnJndEVvL1h6dkJGckg5cHJxZWFZRU16bE1KUStX?=
 =?utf-8?B?TUJPVnlreG1ycU04akVtTit5MUJMSXRKZmhJTWFUeUQ1VHhOS2pZWmoyM2ZP?=
 =?utf-8?Q?pCcM7GAccLvk7w+6unPrk5LPgD7n+Jn9pbACRWe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4948
Original-Authentication-Results: metux.net; dkim=none (message not signed)
 header.d=none;metux.net; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4ac99de3-cec2-4183-f74b-08d937723ccb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHzvaQThep5KHzkwaQ2e/C2gac5rJAMgnU3agskNS3bbVK/tNBwkBnn0up+1PAiQV8VcXcbnXfrNyG5jWqbx0UEl6W01TerAui+S+fwu+Y69bGnOOKeRT68H5B9bLuplRLRRyF/Ok3wfyTNpz8JGH/m5bUcGPVFS5e7fvfZw1sQyQ5XkI3BkBqfhbSymL8lw6H3dLgUzhY2kMDB4fHHnwLQSXoW/2Wt4s2VoFymTiuKkPu3yDL5yefEVC75Jlj6AsZ6E9aShm/F7iCDbX0cJe2XD2vy7Fb/y8Vy12tJBXlVeujWD+sxNB66rZg6w9r11B6QFh5cdzde+uTPwhtas/WHcSO/xXWLVuTrbsyEDzpdAF7vuU1Hyyy7psaHu3c8S1ntKotXosjg/f9i/on2hSUc8hBCOcR4oU7Y0Jl49xXqFzJE+p9fYvq1u5QZM09iP00OVIwtzP8L7HgbBRVkFJB9zLzY+UY9/hkkNS0RqlDXUbODZDPidghDRDFOID352ogolDaIEg5nMSF/sjjzIK73d/o98INZ96YZAPqBVmWZM3QTb0H6jtKwMV0833d18lxCE8dijtLkyJ5gSJDRAe15xcHu2r29Ma6lBg2L9hgbePFLaSS+cK+q82R8gg3n2BrmSX9cm2ycyFMMqZIqAX5nmKpeO4BW5iV2lTchIlZ7DWSZzOjq6yrKI7Ek90RQYFgkMjpNwhHXYO+UgsCdW+Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(136003)(46966006)(36840700001)(2906002)(53546011)(450100002)(6506007)(82740400003)(4326008)(7696005)(81166007)(83380400001)(356005)(82310400003)(86362001)(36860700001)(26005)(9686003)(70206006)(55016002)(336012)(47076005)(54906003)(316002)(186003)(478600001)(8936002)(5660300002)(8676002)(110136005)(52536014)(33656002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 00:43:32.0535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da59c2b5-fcaa-48de-9f26-08d9377241e0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT013.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3048
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgRW5yaWNvDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW5yaWNv
IFdlaWdlbHQsIG1ldHV4IElUIGNvbnN1bHQgPGxrbWxAbWV0dXgubmV0Pg0KPiBTZW50OiBUaHVy
c2RheSwgSnVuZSAyNCwgMjAyMSA1OjMwIFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBh
cm0uY29tPjsgQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51eC5vcmcudWs+OyBMaW51cw0KPiBUb3J2
YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IENjOiBQZXRyIE1sYWRlayA8
cG1sYWRla0BzdXNlLmNvbT47IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3JnPjsN
Cj4gU2VyZ2V5IFNlbm96aGF0c2t5IDxzZW5vemhhdHNreUBjaHJvbWl1bS5vcmc+OyBBbmR5IFNo
ZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IFJhc211cyBW
aWxsZW1vZXMNCj4gPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kaz47IEpvbmF0aGFuIENvcmJldCA8
Y29yYmV0QGx3bi5uZXQ+OyBIZWlrbw0KPiBDYXJzdGVucyA8aGNhQGxpbnV4LmlibS5jb20+OyBW
YXNpbHkgR29yYmlrIDxnb3JAbGludXguaWJtLmNvbT47IENocmlzdGlhbg0KPiBCb3JudHJhZWdl
ciA8Ym9ybnRyYWVnZXJAZGUuaWJtLmNvbT47IEVyaWMgVyAuIEJpZWRlcm1hbg0KPiA8ZWJpZWRl
cm1AeG1pc3Npb24uY29tPjsgRGFycmljayBKLiBXb25nIDxkYXJyaWNrLndvbmdAb3JhY2xlLmNv
bT47IFBldGVyDQo+IFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSXJh
IFdlaW55IDxpcmEud2VpbnlAaW50ZWwuY29tPjsNCj4gRXJpYyBCaWdnZXJzIDxlYmlnZ2Vyc0Bn
b29nbGUuY29tPjsgQWhtZWQgUy4gRGFyd2lzaA0KPiA8YS5kYXJ3aXNoQGxpbnV0cm9uaXguZGU+
OyBvcGVuIGxpc3Q6RE9DVU1FTlRBVElPTiA8bGludXgtDQo+IGRvY0B2Z2VyLmtlcm5lbC5vcmc+
OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZz47IGxpbnV4LXMzOTAgPGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPjsgbGludXgtDQo+
IGZzZGV2ZWwgPGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDA5LzE0XSBkX3BhdGg6IGludHJvZHVjZSBzdHJ1Y3QgcHJlcGVuZF9idWZmZXINCj4g
DQo+IEhpIGZvbGtzLA0KPiANCj4gPHNuaXA+DQo+IA0KPiA+PiAgICAgICAgIFdlJ3ZlIGEgbG90
IG9mIHBsYWNlcyB3aGVyZSB3ZSBoYXZlIHBhaXJzIG9mIGZvcm0gKHBvaW50ZXIgdG8NCj4gZW5k
DQo+ID4+IG9mIGJ1ZmZlciwgYW1vdW50IG9mIHNwYWNlIGxlZnQgaW4gZnJvbnQgb2YgdGhhdCku
ICBUaGVzZSBzaXQgaW4gcGFpcnMNCj4gb2YNCj4gPj4gdmFyaWFibGVzIGxvY2F0ZWQgbmV4dCB0
byBlYWNoIG90aGVyIGFuZCB1c3VhbGx5IHBhc3NlZCBieSByZWZlcmVuY2UuDQo+ID4+IFR1cm4g
dGhvc2UgaW50byBpbnN0YW5jZXMgb2YgbmV3IHR5cGUgKHN0cnVjdCBwcmVwZW5kX2J1ZmZlcikg
YW5kIHBhc3MNCj4gPj4gcmVmZXJlbmNlIHRvIHRoZSBwYWlyIGluc3RlYWQgb2YgcGFpcnMgb2Yg
cmVmZXJlbmNlcyB0byBpdHMgZmllbGRzLg0KPiA+Pg0KPiA+PiBEZWNsYXJlZCBhbmQgaW5pdGlh
bGl6ZWQgYnkgREVDTEFSRV9CVUZGRVIobmFtZSwgYnVmLCBidWZsZW4pLg0KPiA+Pg0KPiA+PiBl
eHRyYWN0X3N0cmluZyhwcmVwZW5kX2J1ZmZlcikgcmV0dXJucyB0aGUgYnVmZmVyIGNvbnRlbnRz
IGlmDQo+ID4+IG5vIG92ZXJmbG93IGhhcyBoYXBwZW5lZCwgRVJSX1BUUihFTkFNRVRPT0xPTkcp
IG90aGVyd2lzZS4NCj4gPj4gQWxsIHBsYWNlcyB3aGVyZSB3ZSB1c2VkIHRvIGhhdmUgdGhhdCBi
b2lsZXJwbGF0ZSBjb252ZXJ0ZWQgdG8gdXNlDQo+ID4+IG9mIHRoYXQgaGVscGVyLg0KPiANCj4g
dGhpcyBzbWVsbHMgbGlrZSBhIGdlbmVyaWMgZW5vdWdoIHRoaW5nIHRvIGdvIGludG8gbGliLCBk
b2Vzbid0IGl0ID8NCj4gDQpNYXliZSwgYnV0IHRoZSBzdHJ1Y3QgcHJlcGVuZF9idWZmZXIgYWxz
byBuZWVkcyB0byBiZSBtb3ZlZCBpbnRvIGxpYi4NCklzIGl0IG5lY2Vzc2FyeT8gSXMgdGhlcmUg
YW55IG90aGVyIHVzZXIgb2Ygc3RydWN0IHByZXBlbmRfYnVmZmVyPw0KDQotLQ0KQ2hlZXJzLA0K
SnVzdGluIChKaWEgSGUpDQoNCg0KDQo=
