Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006F23A9110
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 07:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbhFPFTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 01:19:32 -0400
Received: from mail-vi1eur05on2054.outbound.protection.outlook.com ([40.107.21.54]:22240
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231176AbhFPFTb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 01:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnYLY69C7AORBMMN/ZSyyU31UJfTA7mfAxwxofmELWE=;
 b=t7AEV4tt9UYxRINg5ACIhPEVTKcxGq2z3+zCtSqAGbhR42mXg8dT7w2OSmscVfQNJlvWAmSqkcBUaRZX5D6MKqUaJwGUHvr6fqbLdUAvmNQLQ6Znclq5jTGoT72tHWFHq/5z401e9IQl5mV9T0mcrleoYF+eiS6tCP1Zp/9jeFE=
Received: from DB6PR07CA0112.eurprd07.prod.outlook.com (2603:10a6:6:2c::26) by
 VE1PR08MB4782.eurprd08.prod.outlook.com (2603:10a6:802:ae::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.23; Wed, 16 Jun 2021 05:17:07 +0000
Received: from DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::48) by DB6PR07CA0112.outlook.office365.com
 (2603:10a6:6:2c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend
 Transport; Wed, 16 Jun 2021 05:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT035.mail.protection.outlook.com (10.152.20.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 05:17:07 +0000
Received: ("Tessian outbound d8701fbbf774:v93"); Wed, 16 Jun 2021 05:17:07 +0000
X-CR-MTA-TID: 64aa7808
Received: from e22b75b05016.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F2ECE544-6A74-46A5-AA2A-00BA4CFB96BA.1;
        Wed, 16 Jun 2021 05:17:00 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e22b75b05016.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 16 Jun 2021 05:17:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km2S5RyQQEZUaxx5wxp9fds8wnu99ICiaTkS0FaWAKUL/eRegjM4/vjNggeqLUdmHTKNNXVedQMZD0m1jTRoxjH+ml8xmE609i5Vctim7l5xv7U/37HBpLpm+f6aJkw4CFmRsHJzyNu0w01nngbjlWBEqsOaW/D5S5yLqSgja72pO9DMKFwyUTWM5mXuQ8G7gnsh8/mSktCWgjw683klpfrBFLWctYKqmg0hgA6ZdGh2i645o0HOJR7uhev2QedRtCQqy+/k4pXLDF05EHcKdgycRBXeSNyrnVJMa6NmqVtU1lGKquVbstGYN0dNCbieAkB6Z5WrpvmTzx1hc7bu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnYLY69C7AORBMMN/ZSyyU31UJfTA7mfAxwxofmELWE=;
 b=kmazPKU2m2Vvike/0YxopmGTuaduMch9ZOTWFpca/nVf73OyGWzy4BRYnsz736oFmvYpfVRGLSIkioJ3GDjpt2wlKGPKpdZ4aVntp6lsoDBM0vOmzRRQIYPA3rEc+5fcCmng1/oGcdQZSAUg3t87eFOt9QUDVRh4s+fIkuf2U3DiZzkL+3WcmGta8Twp4pDgyWfBqLkdSA15390tZQxP3QIGpork0RPk1CJOFM9N6IbPVxzOnX2dFKh40e0b4Z/aEU9/MtWNBFx0DwEFyUYUfFnB7fMke4HnqKJcvsKUeHGqaRTl8xaGLOJ5I1fKB3Zl+cIfAxAbqGon/5sGwdI0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnYLY69C7AORBMMN/ZSyyU31UJfTA7mfAxwxofmELWE=;
 b=t7AEV4tt9UYxRINg5ACIhPEVTKcxGq2z3+zCtSqAGbhR42mXg8dT7w2OSmscVfQNJlvWAmSqkcBUaRZX5D6MKqUaJwGUHvr6fqbLdUAvmNQLQ6Znclq5jTGoT72tHWFHq/5z401e9IQl5mV9T0mcrleoYF+eiS6tCP1Zp/9jeFE=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6600.eurprd08.prod.outlook.com (2603:10a6:20b:33e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Wed, 16 Jun
 2021 05:16:52 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Wed, 16 Jun 2021
 05:16:52 +0000
From:   Justin He <Justin.He@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
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
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, nd <nd@arm.com>
Subject: RE: [PATCH RFCv4 0/4] make '%pD' print full path for file
Thread-Topic: [PATCH RFCv4 0/4] make '%pD' print full path for file
Thread-Index: AQHXYf4tLD2yzB62jEO37izWc9BPwasWF34AgAAA00A=
Date:   Wed, 16 Jun 2021 05:16:51 +0000
Message-ID: <AM6PR08MB4376212D6BB0D4321C8B796BF70F9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210615154952.2744-1-justin.he@arm.com>
 <YMmHdlJBnTBKUjeZ@infradead.org>
In-Reply-To: <YMmHdlJBnTBKUjeZ@infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: DF552A81EC628C488C23C90B48D62E59.0
x-checkrecipientchecked: true
Authentication-Results-Original: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 0708d06b-17af-4331-a249-08d93085fc9a
x-ms-traffictypediagnostic: AS8PR08MB6600:|VE1PR08MB4782:
X-Microsoft-Antispam-PRVS: <VE1PR08MB47829C5DB44341A4109FEC82F70F9@VE1PR08MB4782.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YpwhNJcpxMLkyN9cyp0T5U6xIIuhwsS67P+LNMRI1hZI2X4HJd4bD2cWA/mNyHIkoovcEZUprk2/Qf8OXVBscjyKYGU7T+uyrWPil0zPY+et8ToiRzaNzfs467ZiL4kKPtg3HIyJ05VekKj/fTdpuW5f79fk8lsM/WGiMuOwPMC1jJy/0gUdBr4AZh92djUI2rlYJoLRps4yW5CuzsDDUZbNxM4a0x48C02pexlp+Xcad/p7K6gJsrk+I5UFh7z7JOuo4U2TvKienVRIL1G0GR6hLLQZL6bVgVEG8nFNT9N+mVrNv/mHv8gpLW+2c/PO60ioWrc2nx8DCuxtTZDVS00sykhioAbMMuyReD7JiJVp2aoYf8tdRBJlhb+qcMV9ylu4yZzXGbq3xqGYlPTJqqD9TT4IyS4Y4gSbZbx1KpABaNfXGX+fRlmUbkcOl1v62C97fsteF+NV1JL4d2cLXBVMypEHp89TQKPsEp7fBT4gHfb4m4KnvwU/Noq1le8SPbVGbh5xLbTY0vzatnDz4kOZAcav8mfyxCuXbjAdxOhqpRoXQtfVOWspjoSsXii0sWyFfEdk1+ZlPMmH2rCdqtb/gRVEv1tgpk3dEr5I0mw=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39850400004)(52536014)(122000001)(8676002)(83380400001)(4326008)(6916009)(66556008)(55016002)(478600001)(6506007)(5660300002)(54906003)(2906002)(316002)(38100700002)(7696005)(4744005)(7416002)(33656002)(66476007)(53546011)(66946007)(86362001)(64756008)(26005)(186003)(71200400001)(8936002)(76116006)(66446008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jlVxE2KEce4Ej1bO0rcmAcEDsYuZ3XH+D/HnA0c0wh7lERZyB30LWvsMSBy3?=
 =?us-ascii?Q?9N3ifWkTaqMfSP2ZJOV1V5BwksgcGl7amXURDmV3o1xg4mdUzNTdrSSiMTNk?=
 =?us-ascii?Q?BCzCG+hDRRu3r7NQecQs1JKu+XhU1qwDWeHRrjYxt2a7z3cs9u78Rlk+ehfc?=
 =?us-ascii?Q?Jwh54cIz4LISq0HPZzHOmDKf2q1kKGwzSTkdf86ojh09ycs+3OVMk3UklKX2?=
 =?us-ascii?Q?xATOsfpJolcpf3mVSpsLGjwg+grkkpwJxo/aiMva1LV/Ou8UKlXJpOAwfwnc?=
 =?us-ascii?Q?CwQ36/ZHEIMnv4PMK+sOk8GIocCz3IFs+Ia+4ZU3wZb5TAwL8QjyIIdS21h/?=
 =?us-ascii?Q?BqNsmDtHDilSDpH4S3/utYluv8C+e3CwB8rNwaDRmaFPCnKKawhR3SSTnceX?=
 =?us-ascii?Q?2JtTX9i9BJl9FYxo+ZVD+/1pB4Z3na83znavOQjms19TiBC0aUh4vlOwEs1L?=
 =?us-ascii?Q?03fX6QlsR0ODiNHl5zJMLpusUavy7L2YFgb1nPDE6kdc+vQEaA8q5DSGf4fV?=
 =?us-ascii?Q?3E8v0B3go8hm4tM9VF3ZD50E3NWbdSXQfTp7EnB0cwuAjkDg51SW/dUGYsec?=
 =?us-ascii?Q?1VuohLEOiD1pAqZJKqGuvsM/3Df4taSZSlkj++usR84WNTFrKnQfkAEFBpum?=
 =?us-ascii?Q?rc3x/CeXh+U7KP+euaFrPQ5n8ZGLazEedKObsKDr74g9qNeNKquJQanWNZHr?=
 =?us-ascii?Q?6FCfbzFqWwBZBo3j1CKNHVJ/E3Vt1mGg+8scXf4WKlRLr3ZReE92b1OQfhOA?=
 =?us-ascii?Q?vsOV0YTyKpsQAXr1AEzBbltmiWX5LArrcVUYz952kb1ZWr7bkQ1vIE56ijbK?=
 =?us-ascii?Q?8OT6SCY9ZyuCppC8ML9R5LudxChjvjIQ888DhDmaQ9WYpH0FMnCMl8tWIprE?=
 =?us-ascii?Q?uhSxbyN14FqWW2hzC3QnfsDuzk2nWa6DrbcyR+pPA6frJ0dn1pFHHorPpqlY?=
 =?us-ascii?Q?iqlq4ytErq8Bsgzr5/xn7dSUrkF8fOKx6SzwXGkwvz8wilN2KqH0NUJNz9r6?=
 =?us-ascii?Q?Zj0bi82IQlnUAOP4vfiSHeodmFX726mBGJvHxM8WDEsx+ivXj3C8UArrTb3n?=
 =?us-ascii?Q?eNKoGD/RXu5FI+RePo9FQGgqmq4MBI7PVo+SxATJ296vZve5L6kaAiOuQ6N1?=
 =?us-ascii?Q?rk0N6fnSeeeLXNUHeQXA8C7XH5ZcBaHPSDPNsv+kbZOHuV88VriU5ZkFsmLx?=
 =?us-ascii?Q?vHs8TwW+xUoXgbQSpQ16dTwi1UdTT8Bq2vSkCcW2Y79feGhTRq4XjXaI7FX4?=
 =?us-ascii?Q?tkecJGi24uHRfWu8xVVSvIPgsqpwOcAbURu3hyJlNqB8jP13y7v6rXvvaTP3?=
 =?us-ascii?Q?gbGGSVraxWCv4j49q955G4Pq?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6600
Original-Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: acfe29e4-ae41-4c47-045c-08d93085f360
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMDsLrHzArBeSW7y9/g4N4CyEjnKGIn/QjYh7azN9RxKdu84k1NJGSFlaLjvDFabVp+g3W4OsWqjzb/4Pflt2Nib4ma2LIQ6P3Iqv5UKsZJXJkGqRKhVLIlUzkvc0z/9iYQ4fizWf1g62RBOsqgTZcx/0cW/gy5kflIKMDGtzrEa1MkqMRHwqWAxRo50RyOi6BoGZ4erQWvxm+WiSuRcql0lb7iQuba0IVbKf3VOTIz9+7TTbYML8fMhZbggnVAog9/rFbaoP4ZdqBuGx9F4BaVa4sqrXdwsZgpVtlnt48c8RNR5m8ZyGIfxfxOmoE0KLxiE+mDSkoU++fAvly6DG0aNqXPC2RviteoGWSiZuxKTQcZLLEEMilEzbkDAK7KHLl9OjTYvUmWXKi+g0PhdovdOD8BfVRzfKmpDxnYO6Rx1wmtFwq/J87vh5XdWFCsJPzsvHrOm1sbT0b2ECBkEy07f5w5bMgRKTibPhahgfnBkTbnq21029Z5SPIEbIn6d5Pbt6c4zhWxHKBUHCEMrJZ0WIq6ncVSyge2rolwjODjNcECg0zeX+9qixKOx/tQPpbGKf7pKWyboqa4Ixb6mYnwvAvopsXh5BOfCkXu8MMRr8i0LUjkySnUyO0Hx/F8zXcXGcoIHPXPeXqPs3qe26Q==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(136003)(396003)(346002)(46966006)(36840700001)(33656002)(83380400001)(82310400003)(9686003)(478600001)(316002)(54906003)(7696005)(336012)(8676002)(6862004)(52536014)(55016002)(5660300002)(356005)(81166007)(6506007)(82740400003)(47076005)(36860700001)(450100002)(70586007)(70206006)(186003)(26005)(8936002)(86362001)(4326008)(2906002)(53546011);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 05:17:07.6282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0708d06b-17af-4331-a249-08d93085fc9a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4782
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph

> -----Original Message-----
> From: Christoph Hellwig <hch@infradead.org>
> Sent: Wednesday, June 16, 2021 1:09 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>
> Subject: Re: [PATCH RFCv4 0/4] make '%pD' print full path for file
>=20
> Btw, please throw in a patch to convert iomap_swapfile_fail over to
> the new %pD as that started the whole flamewar^H^H^H^H^H^H^Hdiscussion.

Ok, thanks for the reminder.

After all of the solution/helper/interface is stable (maybe after removing =
RFC),
I tend to add more patches:
1. s390/hmcdrv: remove the redundant directory after using '%pD'
2. remove all the '%pD[2,3,4]' usage in fs/
3. your mentioned iomap_swapfile_fail


--
Cheers,
Justin (Jia He)


