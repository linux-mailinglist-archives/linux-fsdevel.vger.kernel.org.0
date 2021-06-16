Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D93A8DDF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 02:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFPA4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 20:56:48 -0400
Received: from mail-eopbgr130077.outbound.protection.outlook.com ([40.107.13.77]:29558
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230265AbhFPA4r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytxZ+tSiZznMBaivB+rOhKkoByxhYgYh4BvQPAp4dMg=;
 b=NYlW/o7LOkZxYnbE7CD2jFOKz/IDtmhYoOPDLtGlaL5nPwizgIhAnI32nxbpLCGdW3CldqbUzORXZGzeTR7gu/9EFCfBwFX2eBOqIM2X9BjEaN1CsLI/4qLHNNOJYph6+j1TJIu4BN1LCuoGYyCFHuEDv6uNqvHJB/d1KSoHS3Q=
Received: from DB6PR0501CA0014.eurprd05.prod.outlook.com (2603:10a6:4:8f::24)
 by AM5PR0802MB2579.eurprd08.prod.outlook.com (2603:10a6:203:98::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Wed, 16 Jun
 2021 00:54:24 +0000
Received: from DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::df) by DB6PR0501CA0014.outlook.office365.com
 (2603:10a6:4:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Wed, 16 Jun 2021 00:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT034.mail.protection.outlook.com (10.152.20.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 00:54:24 +0000
Received: ("Tessian outbound d8701fbbf774:v93"); Wed, 16 Jun 2021 00:54:24 +0000
X-CR-MTA-TID: 64aa7808
Received: from 33e873818a11.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 16BAF8C7-F2F4-44FE-A8FA-877B84E1FD8F.1;
        Wed, 16 Jun 2021 00:54:18 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 33e873818a11.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Jun 2021 00:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd1GNK4G8v8iYn2lA2gF/N1EfR4Qw3Bb96F38rGVy2cxqyjD7Qux8nqAwQUJF5sEZ580o0M7Si+w1IquoMjV5kenDR9TwWGX5zMp5q3TFjg9q0l7ODsaO5L6Sg5uz4CYFgh9NFPkVteqq+uW4X+AaEVcrvYAw/WA7rXOPbTn0NTrAlVhgeoVl7m5P15D4qQtJBf+RWclZ856ZTQtjvtIQcS0wDELt93KFw8EMFMpXOYQ8nLdMKNNwC+0qwe2NzJbWs5hLbXD9b4jTvgmSAOqKXhfZiKmebG9VWBdmXtp+RfaRT6+vqh+4KRBqcP0/vQq8UEdG16LYV6tNgJXQ/Vw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytxZ+tSiZznMBaivB+rOhKkoByxhYgYh4BvQPAp4dMg=;
 b=eV39IomqImGRQBqGsm3M0FEb+tSh0ta5LbObyWJj+kmILzKbxKOhKJFKVpxQOtV5F1UaMaRh3HHF6qa98z+uIXWY6/0fjQGEekCXGLG/Bi4PazL7kejMYoOchfwJBJAwrKqxj6+0Y1jmR7Hsr2Vw//ed1xrPQM3NGYYJENSek8wPtcLjVjWh/67w4iqUtdB/pgM0PPeVVeiayG83JJLEdZLRK4UWJbd+Cm87AQjOTfFI6SxJE3psgPVDRYnhxxivuuTIsxyGeXdFnR/0WwoOePkmySuTSlo6epMMuhMMLZkaCLcuVV6+lI/1AZLTApxS8xdqB84d5qcB/m5pTzKWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytxZ+tSiZznMBaivB+rOhKkoByxhYgYh4BvQPAp4dMg=;
 b=NYlW/o7LOkZxYnbE7CD2jFOKz/IDtmhYoOPDLtGlaL5nPwizgIhAnI32nxbpLCGdW3CldqbUzORXZGzeTR7gu/9EFCfBwFX2eBOqIM2X9BjEaN1CsLI/4qLHNNOJYph6+j1TJIu4BN1LCuoGYyCFHuEDv6uNqvHJB/d1KSoHS3Q=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (20.179.6.149) by
 AM6PR08MB3607.eurprd08.prod.outlook.com (20.177.115.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Wed, 16 Jun 2021 00:54:16 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 00:54:16 +0000
From:   Justin He <Justin.He@arm.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, nd <nd@arm.com>
Subject: RE: [PATCH RFCv4 1/4] fs: introduce helper d_path_unsafe()
Thread-Topic: [PATCH RFCv4 1/4] fs: introduce helper d_path_unsafe()
Thread-Index: AQHXYf47VYuynppC/ESPBzUZLyWkYasViWsAgABD00A=
Date:   Wed, 16 Jun 2021 00:54:15 +0000
Message-ID: <AM6PR08MB4376ED0A8F0C04D35E1409D1F70F9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-2-justin.he@arm.com>
 <CAHp75Vdpw6A0r0cjJKF8XhGL0-PccXHS1BXL1w04P37-027jUw@mail.gmail.com>
In-Reply-To: <CAHp75Vdpw6A0r0cjJKF8XhGL0-PccXHS1BXL1w04P37-027jUw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: B71123D0AB1DB743A4BCFC9EE52D1C8F.0
x-checkrecipientchecked: true
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7be11854-48bf-42d0-dff8-08d930614932
x-ms-traffictypediagnostic: AM6PR08MB3607:|AM5PR0802MB2579:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB25799174AA4D0B8040920A8DF70F9@AM5PR0802MB2579.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:398;OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: lITL3O60SqeNsB3irxpeF3H2F/PJv2cmjamGgebgwo0C0ZZFWcxTHOUbic5UJk0hKWmAnSIF7Z5YpD5aI4mvB8fv3g9Pk+FqPPGuXGuY1reAbIgevxKAOyMTQG8iQmtluZBxAifp3CYJOIn9KcRKdksFbTO9IviiYt66etU0JB4sNzmMD36Im8kzovmNW7EHWmJx7SvnTX0tjQ8U9dl8hD+Yh28wPsURW0NEDf8BKfZCs+WOS02MmQQqslNxfklYXQMwl864sw7k83LeBNBBcAiIPe3MimeqgQEJJre+DuEy7qu6o00PpbcAvMMxGKsNR6dBEf/iDbp6+XjmtyTwlJoGQNfuwsDWEnngUhOfZlZBh7FqYU3uWXysA19h/gFWBoojXGe5LF5irmOeulmm+Qrf/oGzenZGBczUEWyoIwt1HZczCKU6AhOyfnG1m4UXjYHk5Y5xEAcQQ8vpWS4K7Dw0fNH4tYpDq5Ww+zX6uuf3MCfRAwGmjaAdND1z64ebrxvAUXDg8bQgqzb/TimFlidALZ7mV+fC21W+UrxkwR7JaAzR166Ry/BS0l40Kef/94mOQS5S2CEFCYgXDajxi2HbcVRSb4bGC7+lHum6HYI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(366004)(396003)(346002)(33656002)(83380400001)(316002)(478600001)(8676002)(9686003)(54906003)(52536014)(5660300002)(55016002)(71200400001)(38100700002)(122000001)(7696005)(4326008)(53546011)(66556008)(76116006)(186003)(66446008)(66946007)(26005)(66476007)(2906002)(8936002)(6506007)(64756008)(6916009)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUV0VmxBS1lvdWtYSW84MnFrMXl1VXFzRGRMNFd1OUh6Ymd6K1RDVEtRVGZW?=
 =?utf-8?B?c1BPSmJybStxbVZxbmJpTEI2aWpzZUhPais5K2ZNT0Fkd0ZwYTNPc1JLaFNz?=
 =?utf-8?B?UHhxMW1KYjhGb2EwbWJFa0pCb2VPUjFEaHpzUkhvRmE1bnI1Mk5ncjJRYXhk?=
 =?utf-8?B?bERvdDQ4SWliV21xVGVnQXNyVzVyNWNzL1J2N1U0N0lLcUY1WnFmNmtEUTc0?=
 =?utf-8?B?eUd2SWd2UWRCdEZsSkhEQ21mRi9xb0poYmxyM1V4c3liU0dneGNpVkEzWVZR?=
 =?utf-8?B?OTFaN3NaVUZQcG0zd2VmbXhhT25qaDJzN1pXS2l0cUMySnhHM2pWMm9oRm84?=
 =?utf-8?B?eE9XMGlnWGtmeTJxa3VNZTRCdTJsTVVHMkUwRHRnWDdlMDZRK2IvNVlLZlNJ?=
 =?utf-8?B?Y1BFK1FKQU1qTFFMMFdXdy9qVW1ORXIwa0dZbUErb3FFSHlSWmJOc0RqL08r?=
 =?utf-8?B?eVh1NUtBWm5nWGRhcDdCem9IMXBrWXlJZlRFeTl6RHFlVHFFWHM5cmRqdEhr?=
 =?utf-8?B?cDdBVUV1N0E5YnUrdGZWZU5od01OanJjVDVKdDhMYnlsckRVdmIrTDRIQUQ3?=
 =?utf-8?B?TGxkTExVSm9iZ1FyaENMcjZDS2dGZUgwSzU5eWVhQkF4YnZUelQzNVdhVVR4?=
 =?utf-8?B?MjVsR3h4TE5RNGRsdXRQSFZlRUF0dDdkWDB3ZlAxWkU0SzY2QUxPTkt6dDlU?=
 =?utf-8?B?QzR3VHIzTmwxSjc5a1dkMHZlc0Yyb1NscWJLbjNTbzc5L0JKUFZ6MzJQeVF5?=
 =?utf-8?B?ZWVpM0hjczF2TWtRYTNCUlpwLzlFNUVZREd1NEtPNWdGVTZaRGFPY1B5aURl?=
 =?utf-8?B?OElKMGF4RmFpK1JCU2VIek9hOTdrMGNqbW5FWWYwQlVPZnBVSHFXWGY0M1N0?=
 =?utf-8?B?Mko5dUdnNG8vNFlYNDFacjB3TmwrS0lObWRKMU96SnlVbitQTlkvTTdlS0tL?=
 =?utf-8?B?UUVCc1J4NGtqbEYwUm8raHJsb00zNkxjR0tSaUdMb1BJQ2NPTkVmczVBeHAv?=
 =?utf-8?B?bFlCRDFJNW5jSEw3S0I0Q2hGSFViSnRTSFFGTG1DMDFBRU9YZ3gyNXhpOXFD?=
 =?utf-8?B?aFBBdmRtL3M4SEFsbWZ1NXA4YnlpUW9CQVhDTVRNVzd1Z0xBb3FNK2tqL0pF?=
 =?utf-8?B?L2theWNPUWFycko5NmtQR0RFdDlZcXArZGpJcGxEWng2TE0xWTFjN1NROUho?=
 =?utf-8?B?ZW03cGRvK0k0dnVjTzFTajFKT3g2OTh0R1JRK2VHTjNDbmVlUlp0QUhNWHRI?=
 =?utf-8?B?RkRoRFhQQVhET3NneWhDTG5SQkc5ZFRmeEk0U1FadnJocjVVUUcyVy9KaUVE?=
 =?utf-8?B?ZHFYQXdqN2dwR2NhSm5wb0VabFkwczU1TWEzN0l6WEZMY1V0Yyt4cDZ1K2w5?=
 =?utf-8?B?cnd3TmNmVzdVdWVGVllJa1I0Zm1PYzFrVUszVTJ5Z1FMYml6K1hlUkkxTTNr?=
 =?utf-8?B?MXI5cFV3c2hEaHlFQmpkWmhpTmFMN2RWSnVwZEEvZlUza0dJbFpybEQ3ZFpa?=
 =?utf-8?B?TVgxWjBRSFduSlpDMkZ5WkFob21DZzYzR1NqWXc4TTFucEFXWWZIK1c2WnIz?=
 =?utf-8?B?UGdSZHVPWTRhbWhqK1l1NW5QV1F3VG1kb2xSS2MyNEVPcExzUkpTQmpsNWhS?=
 =?utf-8?B?ZWtKMzQwOEFka1MyNEJUcWpscGNObVRzcGtCSzNteDJ5dEhLUU5ycUkzeWd6?=
 =?utf-8?B?ZmcrOWdhWTdFckUwY2lsUUwxaHUxOXdCS0oyY1F3ZXZvZ2lKd0VwSnJoMHhG?=
 =?utf-8?Q?U1lGTk3/9nK3xj8YOzZR+hk6CANf2dAJMPMNsg/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3607
Original-Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 037244ff-0f7f-4a3a-bf5b-08d930614419
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7/WCdgzishOkelnGkKQz+NM1dpbrCXopcvnnoZtxQWaISPFx1BbcD9vPhAeOYzbsvf2TQ1/bmD5UyeFG77/sYuQm98PT3Z+56c7MNTvW8uWjgR4KK5CYVL3PNwodG9yZRRUJ6g3TVPbRhoP4VeGfDlncBiiq3Y9EYx1do7X/ExZIrm7+hps+tVqJ/6LBbU5gVRDrpjYLnYVMVNzLnyw0ncIy0GxsbYM47QsxtW0+R1nj1kuncHX5nW+WkbZnj/nlYGtOE0gqMdVFMvG60zM7nKiiB3EksCTNpJQaOQfXUoqiZ1VaUHMSrtXkt860IZnuLIMr4CDwcCK9wqB/zG7Xw8K9/tRgEFX+HGU+zfktfK9W+bn5hoRfqPCK6FwfJMsL+bEj+Bq6bdkXCLCAXpnsc4Vw/pr7sK4zfI3WiEpuijLd3Tq97Xh7v6DmRZ89Aj6WMFm0DRwgvFWGponsZF3i3QEepe79aZpsS9EWpOT0mYt8EmZByDfDCuj01UsdA1BvjqPtp5HIlzW91VfPWm88MZDGOHUONJ9hnnkbov8qnV161eaQS1uydT5jt8UJZSTHQbkSaxQZQlO9AWXhbVCetSnxVxiZmqL1d/+6G0b8JqZO81JoaoB85SnWKmcaLc8b7EYvy8E5Fxab/adKjwv5eihQa67GojmmvgfBgYMxiZg=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39850400004)(36840700001)(46966006)(336012)(70206006)(4326008)(70586007)(8936002)(55016002)(6862004)(450100002)(33656002)(86362001)(54906003)(356005)(26005)(81166007)(83380400001)(52536014)(478600001)(47076005)(5660300002)(186003)(36860700001)(316002)(82740400003)(9686003)(8676002)(7696005)(2906002)(6506007)(82310400003)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 00:54:24.7527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be11854-48bf-42d0-dff8-08d930614932
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2579
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgQW5keQ0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMsIEkgd2lsbCByZXNvbHZlIHlvdSBtZW50
aW9uZWQgdHlwby9ncmFtbWFyIGlzc3Vlcw0KDQpTb21lIGFuc3dlciBiZWxvdw0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2
Y2hlbmtvQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKdW5lIDE2LCAyMDIxIDQ6NDEg
QU0NCj4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+DQo+IENjOiBQZXRyIE1sYWRl
ayA8cG1sYWRla0BzdXNlLmNvbT47IFN0ZXZlbiBSb3N0ZWR0IDxyb3N0ZWR0QGdvb2RtaXMub3Jn
PjsNCj4gU2VyZ2V5IFNlbm96aGF0c2t5IDxzZW5vemhhdHNreUBjaHJvbWl1bS5vcmc+OyBBbmR5
IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IFJhc211
cyBWaWxsZW1vZXMNCj4gPGxpbnV4QHJhc211c3ZpbGxlbW9lcy5kaz47IEpvbmF0aGFuIENvcmJl
dCA8Y29yYmV0QGx3bi5uZXQ+OyBBbGV4YW5kZXINCj4gVmlybyA8dmlyb0B6ZW5pdi5saW51eC5v
cmcudWs+OyBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtDQo+IGZvdW5kYXRpb24ub3Jn
PjsgUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBFcmljDQo+
IEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+OyBBaG1lZCBTLiBEYXJ3aXNoIDxhLmRhcndp
c2hAbGludXRyb25peC5kZT47DQo+IExpbnV4IERvY3VtZW50YXRpb24gTGlzdCA8bGludXgtZG9j
QHZnZXIua2VybmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nDQo+IExpc3QgPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBGUyBEZXZlbCA8bGludXgtDQo+IGZzZGV2ZWxA
dmdlci5rZXJuZWwub3JnPjsgTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDdjQgMS80XSBmczogaW50cm9kdWNlIGhlbHBlciBkX3Bh
dGhfdW5zYWZlKCkNCj4gDQo+IE9uIFR1ZSwgSnVuIDE1LCAyMDIxIGF0IDY6NTYgUE0gSmlhIEhl
IDxqdXN0aW4uaGVAYXJtLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGlzIGhlbHBlciBpcyBzaW1p
bGFyIHRvIGRfcGF0aCBleGNlcHQgdGhhdCBpdCBkb2Vzbid0IHRha2UgYW55DQo+ID4gc2VxbG9j
ay9zcGlubG9jay4gSXQgaXMgdHlwaWNhbCBmb3IgZGVidWdnaW5nIHB1cnBvc2UuIEJlc2lkZXMs
DQo+IA0KPiBwdXJwb3Nlcw0KPiANCj4gPiBhbiBhZGRpdGlvbmFsIHJldHVybiB2YWx1ZSAqcHJl
bnBlbmRfbGVuKiBpcyB1c2VkIHRvIGdldCB0aGUgZnVsbA0KPiA+IHBhdGggbGVuZ3RoIG9mIHRo
ZSBkZW50cnkuDQo+ID4NCj4gPiBwcmVwZW5kX25hbWVfd2l0aF9sZW4oKSBlbmhhbmNlcyB0aGUg
YmVoYXZpb3Igb2YgcHJlcGVuZF9uYW1lKCkuDQo+ID4gUHJldmlvdXNseSBpdCB3aWxsIHNraXAg
dGhlIGxvb3AgYXQgb25jZSBpbiBfX3ByZXBlbl9wYXRoKCkgd2hlbiB0aGUNCj4gPiBzcGFjZSBp
cyBub3QgZW5vdWdoLiBfX3ByZXBlbmRfcGF0aCgpIGdldHMgdGhlIGZ1bGwgbGVuZ3RoIG9mIGRl
bnRyeQ0KPiA+IHRvZ2V0aGVyIHdpdGggdGhlIHBhcmVudCByZWN1c2l2ZWx5Lg0KPiANCj4gcmVj
dXJzaXZlbHkNCj4gDQo+ID4NCj4gPiBCZXNpZGVzLCBpZiBzb21lb25lIGludm9rZXMgc25wcmlu
dGYgd2l0aCBzbWFsbCBidXQgcG9zaXRpdmUgc3BhY2UsDQo+ID4gcHJlcGVuZF9uYW1lX3dpdGgo
KSBuZWVkcyB0byBtb3ZlIGFuZCBjb3B5IHRoZSBzdHJpbmcgcGFydGlhbGx5Lg0KPiA+DQo+ID4g
TW9yZSB0aGFuIHRoYXQsIGthc25wcmludGYgd2lsbCBwYXNzIE5VTEwgX2J1Zl8gYW5kIF9lbmRf
LCBoZW5jZQ0KPiANCj4ga2FzcHJpbnRmKCkNCj4gDQo+ID4gaXQgcmV0dXJucyBhdCB0aGUgdmVy
eSBiZWdpbm5pbmcgd2l0aCBmYWxzZSBpbiB0aGlzIGNhc2U7DQo+ID4NCj4gPiBTdWdnZXN0ZWQt
Ynk6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEppYSBIZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4gLS0tDQo+ID4gIGZzL2RfcGF0aC5j
ICAgICAgICAgICAgfCA4MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gPiAgaW5jbHVkZS9saW51eC9kY2FjaGUuaCB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFu
Z2VkLCA4MiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL2RfcGF0aC5jIGIvZnMvZF9wYXRoLmMNCj4gPiBpbmRleCAyM2E1M2Y3YjVjNzEuLjRm
YzIyNGVhZGY1OCAxMDA2NDQNCj4gPiAtLS0gYS9mcy9kX3BhdGguYw0KPiA+ICsrKyBiL2ZzL2Rf
cGF0aC5jDQo+ID4gQEAgLTY4LDkgKzY4LDY2IEBAIHN0YXRpYyBib29sIHByZXBlbmRfbmFtZShz
dHJ1Y3QgcHJlcGVuZF9idWZmZXIgKnAsDQo+IGNvbnN0IHN0cnVjdCBxc3RyICpuYW1lKQ0KPiA+
ICAgICAgICAgcmV0dXJuIHRydWU7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBwcmVw
ZW5kX25hbWVfd2l0aF9sZW4oc3RydWN0IHByZXBlbmRfYnVmZmVyICpwLCBjb25zdCBzdHJ1Y3QN
Cj4gcXN0ciAqbmFtZSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgaW50IG9yaWdfYnVm
bGVuKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBjb25zdCBjaGFyICpkbmFtZSA9IHNtcF9sb2FkX2Fj
cXVpcmUoJm5hbWUtPm5hbWUpOyAvKiBeXl4gKi8NCj4gDQo+IFdoYXQgZG9lcyB0aGlzIGZ1bm55
IGNvbW1lbnQgbWVhbj8NCg0KSXQgaXMgaW5oZXJpdGVkIGZyb20gdGhlIHByZXBlbmRfbmFtZSgp
DQoNCj4gDQo+ID4gKyAgICAgICBpbnQgZGxlbiA9IFJFQURfT05DRShuYW1lLT5sZW4pOw0KPiA+
ICsgICAgICAgY2hhciAqczsNCj4gPiArICAgICAgIGludCBsYXN0X2xlbiA9IHAtPmxlbjsNCj4g
PiArDQo+ID4gKyAgICAgICBwLT5sZW4gLT0gZGxlbiArIDE7DQo+ID4gKw0KPiA+ICsgICAgICAg
aWYgKHVubGlrZWx5KCFwLT5idWYpKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKG9yaWdfYnVmbGVuIDw9IDApDQo+ID4gKyAgICAgICAg
ICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBUaGUg
Zmlyc3QgdGltZSB3ZSBvdmVyZmxvdyB0aGUgYnVmZmVyLiBUaGVuIGZpbGwgdGhlIHN0cmluZw0K
PiA+ICsgICAgICAgICogcGFydGlhbGx5IGZyb20gdGhlIGJlZ2lubmluZw0KPiA+ICsgICAgICAg
ICovDQo+ID4gKyAgICAgICBpZiAodW5saWtlbHkocC0+bGVuIDwgMCkpIHsNCj4gPiArICAgICAg
ICAgICAgICAgaW50IGJ1ZmxlbiA9IHN0cmxlbihwLT5idWYpOw0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgcyA9IHAtPmJ1ZjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIC8qIFN0aWxs
IGhhdmUgc21hbGwgc3BhY2UgdG8gZmlsbCBwYXJ0aWFsbHkgKi8NCj4gPiArICAgICAgICAgICAg
ICAgaWYgKGxhc3RfbGVuID4gMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHAtPmJ1
ZiAtPSBsYXN0X2xlbjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBidWZsZW4gKz0gbGFz
dF9sZW47DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAg
IGlmIChidWZsZW4gPiBkbGVuICsgMSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIC8q
IFRoaXMgZGVudHJ5IG5hbWUgY2FuIGJlIGZ1bGx5IGZpbGxlZCAqLw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIG1lbW1vdmUocC0+YnVmICsgZGxlbiArIDEsIHMsIGJ1ZmxlbiAtIGRsZW4g
LSAxKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwLT5idWZbMF0gPSAnLyc7DQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgbWVtY3B5KHAtPmJ1ZiArIDEsIGRuYW1lLCBkbGVuKTsN
Cj4gPiArICAgICAgICAgICAgICAgfSBlbHNlIGlmIChidWZsZW4gPiAwKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgLyogUGFydGlhbGx5IGZpbGxlZCwgYW5kIGRyb3AgbGFzdCBkZW50
cnkgbmFtZSAqLw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHAtPmJ1ZlswXSA9ICcvJzsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtZW1jcHkocC0+YnVmICsgMSwgZG5hbWUsIGJ1
ZmxlbiAtIDEpOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcyA9
IHAtPmJ1ZiAtPSBkbGVuICsgMTsNCj4gPiArICAgICAgICpzKysgPSAnLyc7DQo+IA0KPiA+ICsg
ICAgICAgd2hpbGUgKGRsZW4tLSkgew0KPiA+ICsgICAgICAgICAgICAgICBjaGFyIGMgPSAqZG5h
bWUrKzsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGlmICghYykNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgKnMrKyA9IGM7DQo+IA0K
PiBJJ20gd29uZGVyaW5nIHdoeSBjYW4ndCBtZW1jcHkoKSBiZSB1c2VkIGhlcmUgYXMgd2VsbC4N
Cg0KDQpGcm9tIHRoZSBjb21tZW50cyBvZiBjb21taXQgN2E1Y2Y3OTE6DQoNCj5Ib3dldmVyLCB0
aGVyZSBtYXkgYmUgbWlzbWF0Y2ggYmV0d2VlbiBsZW5ndGggYW5kIHBvaW50ZXIuDQo+ICogVGhl
IGxlbmd0aCBjYW5ub3QgYmUgdHJ1c3RlZCwgd2UgbmVlZCB0byBjb3B5IGl0IGJ5dGUtYnktYnl0
ZSB1bnRpbA0KPiAqIHRoZSBsZW5ndGggaXMgcmVhY2hlZCBvciBhIG51bGwgYnl0ZSBpcyBmb3Vu
ZC4NCg0KU2VlbXMgd2Ugc2hvdWxkbid0IHVzZSBtZW1jcHkvc3RyY3B5IGhlcmUNCg0KPiANCj4g
PiArICAgICAgIH0NCj4gPiArICAgICAgIHJldHVybiB0cnVlOw0KPiA+ICt9DQo+ID4gIHN0YXRp
YyBpbnQgX19wcmVwZW5kX3BhdGgoY29uc3Qgc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBjb25zdCBz
dHJ1Y3QNCj4gbW91bnQgKm1udCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IHN0cnVjdCBwYXRoICpyb290LCBzdHJ1Y3QgcHJlcGVuZF9idWZmZXINCj4gKnApDQo+ID4gIHsN
Cj4gPiArICAgICAgIGludCBvcmlnX2J1ZmxlbiA9IHAtPmxlbjsNCj4gPiArDQo+ID4gICAgICAg
ICB3aGlsZSAoZGVudHJ5ICE9IHJvb3QtPmRlbnRyeSB8fCAmbW50LT5tbnQgIT0gcm9vdC0+bW50
KSB7DQo+ID4gICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBkZW50cnkgKnBhcmVudCA9IFJF
QURfT05DRShkZW50cnktPmRfcGFyZW50KTsNCj4gPg0KPiA+IEBAIC05Nyw4ICsxNTQsNyBAQCBz
dGF0aWMgaW50IF9fcHJlcGVuZF9wYXRoKGNvbnN0IHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4g
Y29uc3Qgc3RydWN0IG1vdW50ICptbnQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIDM7DQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgcHJlZmV0Y2gocGFyZW50KTsNCj4gPiAt
ICAgICAgICAgICAgICAgaWYgKCFwcmVwZW5kX25hbWUocCwgJmRlbnRyeS0+ZF9uYW1lKSkNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICAgICAgICAgICAgcHJl
cGVuZF9uYW1lX3dpdGhfbGVuKHAsICZkZW50cnktPmRfbmFtZSwgb3JpZ19idWZsZW4pOw0KPiA+
ICAgICAgICAgICAgICAgICBkZW50cnkgPSBwYXJlbnQ7DQo+ID4gICAgICAgICB9DQo+ID4gICAg
ICAgICByZXR1cm4gMDsNCj4gPiBAQCAtMjYzLDYgKzMxOSwyOSBAQCBjaGFyICpkX3BhdGgoY29u
c3Qgc3RydWN0IHBhdGggKnBhdGgsIGNoYXIgKmJ1ZiwgaW50DQo+IGJ1ZmxlbikNCj4gPiAgfQ0K
PiA+ICBFWFBPUlRfU1lNQk9MKGRfcGF0aCk7DQo+ID4NCj4gPiArLyoqDQo+ID4gKyAqIGRfcGF0
aF91bnNhZmUgLSBmYXN0IHJldHVybiB0aGUgZnVsbCBwYXRoIG9mIGEgZGVudHJ5IHdpdGhvdXQg
dGFraW5nDQo+ID4gKyAqIGFueSBzZXFsb2NrL3NwaW5sb2NrLiBUaGlzIGhlbHBlciBpcyB0eXBp
Y2FsIGZvciBkZWJ1Z2dpbmcgcHVycG9zZS4NCj4gDQo+IHB1cnBvc2VzDQo+IA0KPiBIYXZlbid0
IHlvdSBnb3Qga2VybmVsIGRvYyB2YWxpZGF0aW9uIHdhcm5pbmdzPyBQbGVhc2UsIGRlc2NyaWJl
DQo+IHBhcmFtZXRlcnMgYXMgd2VsbC4NCg0KSSB3aWxsIGNoZWNrIGl0IGFuZCB1cGRhdGUgaWYg
dGhlcmUgaXMgYSB3YXJuaW5nLCB0aGFua3MgZm9yIHRoZSByZW1pbmRlci4NCg0KDQotLQ0KQ2hl
ZXJzLA0KSnVzdGluIChKaWEgSGUpDQoNCg0KDQo=
