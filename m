Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6213A790F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 10:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhFOIfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 04:35:22 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:25984
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231146AbhFOIfV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHB8997BuSu9vaGQtb7y3PL4iiUfwoGsK4WEADu7BJY=;
 b=sLJEV/8KvFTXjXD0Ww1rLdOjic7kfM20+DseDPxqUlBNHYd0TRFIQflcETy8SBDSfh+NoUj6wgfxUmLGtkVUTl90/3KmYmUC1RLi+BBkFa6bkuX3xdDSMRjLknkBv3zMrEl/mdmw7Wji5QsGd7D2jzGJPM10RhfyETsPJ22F2JM=
Received: from PR3P189CA0070.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::15)
 by DB8PR08MB5001.eurprd08.prod.outlook.com (2603:10a6:10:e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 08:33:07 +0000
Received: from VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:102:b4:cafe::fb) by PR3P189CA0070.outlook.office365.com
 (2603:10a6:102:b4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 08:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT012.mail.protection.outlook.com (10.152.18.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 08:33:07 +0000
Received: ("Tessian outbound a65d687b17e4:v93"); Tue, 15 Jun 2021 08:33:06 +0000
X-CR-MTA-TID: 64aa7808
Received: from 054968e68f55.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F0244961-5879-47AE-B185-1E964C138221.1;
        Tue, 15 Jun 2021 08:33:01 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 054968e68f55.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 08:33:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGz96yrfQtm44XdkNrg1zAp6EIOY7oxtk3ykbBhWBgTa3BVoXQOYR+n3fBjnHtef3pHjggveSxINYSLq6PdbNbSkEd+Bpd0N21eCBdOpm0kdngWxbxZk8gBJiOzALe2anZH/gyKwdmGuFKDjc9bu/cBpAdTSo8OVZXu3jk9sdQ9TyOSJICAbIc2VzfXQWZUCd/X5oHit5uBM3/yAcGbeojODYy/KN4CpfoQKkYcwJlVWchnc1Oawa+iYj6XsDZPICyrwPeDfMvJe1FhyE8M58BUdJis5KQgekQZYbjubB1UtIPcniU6RdIJESzrq44oy6H/A6I0MRQ8vHasKLxt+oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHB8997BuSu9vaGQtb7y3PL4iiUfwoGsK4WEADu7BJY=;
 b=D2CTwYOLrIDfUuLAsFhPucIWXwxrWLTp2YvAgkBYZScC1n6UcY7FSUiC0If4KOHSelLH4xHePaz6RJUejtUW2zgwm1tp1CvZz4AiNny81rJzmoYSw5IAlu7469HDXQngh/c9vK/oLd8fjZXXD/edVCoNiXbb/P92YQDd1BZogJ0FbaNyiiUELSLK1/Pz6uG5QIBu1WYaWjiJbqKsOsaS6YR+qhp9k0QbfONjLeDHyIAD5yI0SdUvZ/mTWv6JD5zopK4/qlg7Tunl+ndXjaIvvfd2vMt9gQHM+A3KvutDWLei1sk7CSG+CdpluAq0ETvV1auu5c7qhqTM0+ikjukqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHB8997BuSu9vaGQtb7y3PL4iiUfwoGsK4WEADu7BJY=;
 b=sLJEV/8KvFTXjXD0Ww1rLdOjic7kfM20+DseDPxqUlBNHYd0TRFIQflcETy8SBDSfh+NoUj6wgfxUmLGtkVUTl90/3KmYmUC1RLi+BBkFa6bkuX3xdDSMRjLknkBv3zMrEl/mdmw7Wji5QsGd7D2jzGJPM10RhfyETsPJ22F2JM=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS8PR08MB6373.eurprd08.prod.outlook.com (2603:10a6:20b:33a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Tue, 15 Jun
 2021 08:32:58 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 08:32:58 +0000
From:   Justin He <Justin.He@arm.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Topic: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path for
 file
Thread-Index: AQHXXtruU5AIb64vzESDK9b2+VqurKsPU6qAgAVrDRA=
Date:   Tue, 15 Jun 2021 08:32:57 +0000
Message-ID: <AM6PR08MB43765EBE1629644230316501F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-3-justin.he@arm.com>
 <35c35b55-3c58-59e8-532a-6cad34aff729@rasmusvillemoes.dk>
In-Reply-To: <35c35b55-3c58-59e8-532a-6cad34aff729@rasmusvillemoes.dk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: E795244BF7EBA1448AA2B2067B38A561.0
x-checkrecipientchecked: true
Authentication-Results-Original: rasmusvillemoes.dk; dkim=none (message not
 signed) header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 52a76dc2-8cd0-448a-2579-08d92fd833a2
x-ms-traffictypediagnostic: AS8PR08MB6373:|DB8PR08MB5001:
X-Microsoft-Antispam-PRVS: <DB8PR08MB500109BDFE908E5E5EA90D78F7309@DB8PR08MB5001.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1850;OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xVkfu/ASI7fgM8+plsDR8GGf7cAJ97vTGP4BPRYI7xB4a6dluLtDQDzfbFdEIH/hHLLQEkrhgAynJINV+N4t+k5QMz8LYQAM40Q6fSGP19ImpuozSCI6D+UGO+pTop6miM58JpKQmhKs0oaoEaIhk1lctLDJIyGBedOWW5bMGMyJEThek7lr5AySjjrZRMgVy+Jp7apNIYruQeoV9pDdU5i2nTE9d2z08b9HoGCfj/qRJYGLf3kGYR4fUkOiaPtyb733va3ZHDT0/eVQlxCOn4TK8JJRQv9dDutMkSvy0ArrkSa/qvKPMmQjyVPH0SkAz+QzYAQdNDiXhd79INsGsQm6o7JSCr/qb1rt4JxqwoTZGxeprc0VYDzIQwmtPacyez9nIEQSx3X6iFqqT2jpXfmebIX/o9VehXeCTlRQehq9ryr8SbbgicUiYqsBjORkxnAdIzFcIjztypOLLJQEdc1BscTQ9We8QZpCo1A/GfAbrUh7RFFf5MvpLuKyaJ2kXgSUrr14ibGJYlCrz+T4fnLVair+SyuIBIVzYMoLrZEiwPMYi43gKH7UevWWjFST6uoEfH6OcwI3PBbw7hE/GcRgR+KQt1hEzDwpanQigBxt1u53hS/ylEHX6m2JgLNsa0YzIPiuxYr4lJ2z+H5KdyFwTMh8egaiQhsw5JI97ljdxaIe9TopzFZ/bhUpGIBEssRrhCDFaIS9tNlWUqNgieqfZSFJn97WgZ3RveYuTDU=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(136003)(376002)(396003)(346002)(83380400001)(478600001)(54906003)(316002)(55016002)(4326008)(86362001)(2906002)(6506007)(53546011)(9686003)(110136005)(7696005)(33656002)(186003)(26005)(64756008)(76116006)(71200400001)(122000001)(8936002)(8676002)(66476007)(66556008)(66446008)(38100700002)(66946007)(966005)(5660300002)(7416002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?77E4lCQGCn0xOYytvvrkjUNQZELecEJ5wDwn9A/YsGweeVvP1itvcmf5dlgE?=
 =?us-ascii?Q?A0UlT/4uef57YJNgV8/dEWLFcHcMwUpD3A4TJpFW4Hz7yC74X62B0SWAo3kD?=
 =?us-ascii?Q?YCCHNypph7Dd2/4GYjG5k+XsvjgIFtWO8BhUWIp3nznWZucYRiJkeKmAdPxr?=
 =?us-ascii?Q?qMsnXizZGqaHYjXfFDIHECm2pa3mmweYrdxllhPhDWDzo0nZMp/Lkm5UPCfr?=
 =?us-ascii?Q?3CqnAFL6uTYJ/ckOrk1qGkPCxOeXSmjYSGEA/UIt6hy0bfVEAL03+oHrvbEv?=
 =?us-ascii?Q?/1/EFO1lkTxXC75npnJV3OnrvWxJqbP1xElnkM2eJezhA1RtUDeUdKDn+5uU?=
 =?us-ascii?Q?Okr85xj7LkszIBIMK4PHvE95MNd785ubUUXl+5DKArm9U7Sj04nYssaaAK+q?=
 =?us-ascii?Q?dc0/5lIKogE7JGKKFZp44ljTukFpYZD+vvSp/eHjBN479SfYyiGdpexj9jEe?=
 =?us-ascii?Q?658rjXIe+FPbNm5/y+q36qjnCOB0FqmjFC/C1rr0SouLVAOliBsdf/kHlp71?=
 =?us-ascii?Q?z8E+jUydzXvYBMfd2Lnbzu1ilJ7uO0Fn7txwf106WdyDqKxIxrTnuZUxfXIt?=
 =?us-ascii?Q?MocnDXgCdLfx5eDUN60BGGyaJj+7TB9H6z8BErs2ToPpAhbRY5/T9MUJubNA?=
 =?us-ascii?Q?yaXAidHZrtPGSNvL11FPYkD6gRffHzEmrSsXEw5YBwh0/fyimF9z4Sgnorn7?=
 =?us-ascii?Q?HDYjZng1kVa9QEhfUUsh67S1S+9iPyfva0aIXWJjg8cyePeWwdNNv6Q1Jn2f?=
 =?us-ascii?Q?NMsWpTOVOZ+oGliNVXybVQm8gqhHp7Gh8rMvCa/7c0+MUyunUgw8+Qvn0VwM?=
 =?us-ascii?Q?GbbFVljlyu7Za4nCSIJY0YZEQ/KYVcVG0jInCi86dUdjY+slc+t+mPfMusUM?=
 =?us-ascii?Q?mMellpeADy2e7U4lJWeG7Goy9PnwuN2dSng+yIviOlt9mRgXImUC8Xutlt7a?=
 =?us-ascii?Q?nEiOp62dkhKLl9ssBOziVRMPuM2xnCzpDroacjgmTJwNxMZVxVqVS6ONPVgU?=
 =?us-ascii?Q?s387ZBajJBNFhyo/hoGRvI65gzsLwCa0b9Yhis4r0ontlAxNxfh2cv4Wkms9?=
 =?us-ascii?Q?EXj3+/xAhPfmxxMJ3Y/vbzTKDJURFJBznGirr5arONNXzid75RuFlWFLF+Oe?=
 =?us-ascii?Q?8sZCLKwmQM3Qm/VO1Em7Knw2r0/NMEwVWjY4OG++oOip9EB6lKwQAqfEW4fD?=
 =?us-ascii?Q?hZVenVfb0hBEr5wbDRGVK2efNafTMEDiFrmGIduIb8CQ5cUmzCOq5Ahuok75?=
 =?us-ascii?Q?lDF1upkJ0kcASnnOGTedU/wvaErkR4L1+T5hzcq1SfUNv5AzNFTeXApQhqOt?=
 =?us-ascii?Q?38zOpVEiyd3aQwf4mkf1OoLl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6373
Original-Authentication-Results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: dceb91d6-0639-43ac-d712-08d92fd82e08
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wO8hf2EwL4bcb5fYGyFdFgDaOHqaiihxm1gEEYSU2BYJyl38x1rT9tkMq58xtIlyesoHTzlOKgWec/jmlYDJgiAW2uZeJ2LMGkm4mtc2RWyOuHZf1Zy+X+xLlGnSTpRN7pRkp6hkaYbVDnRvq1hVTf0IgdTBp8OgGbVgD5CCZ4DQIUQ3LQEK0i4ZYWKOMIvEnsd1BMSKi7orWtA06ujq35bUOZ3a8nch+VtXlYRB7JSDcIP7auUdtvcxWCA3obhv1WfB8Rh4WKooujOhip4frFW9dVzBwCB28bin494G5NgpC7w7K97dvXEhpKmE7BDt+OpDuX3kdV5ozxjgjjFMUv9UC1opcw6BCBdqSWw6RIjcBzmPOUxvwPd8+uphr2w2H5fDDtOrUo5bpHiadiIukp+vkcSdjZKQC84WLsUvZrBvkdwcUiASYBGkoJGSSy3vDSlklUkge95XIlRAG3HzSEhR5zKSdE9bR45jYUoGlUcmyAkUl9XNMj395kt+mXI4MVViKktKNxS0n8XMbVioqAfKAVf7uCjixhJavDFW+IxkCyyPx9Br50bzz0vCJIL+qvsWEcsXwI3fXI7ZEpV7iSv9/kqn0ThcTQ65vs7Djah8afvrwuayCMBRNV65jsXRDaj+TcRvPOrvMaoSwUuyoCJNTTE5VyP1a7qqguWksLEl+N++bWAq0wwjQdyzgrEMjxka9cUgvtipxb1qZjfcLh7ZOq750KNN6VhFXMHyLX7UfZ8mV/P5nAdYpQ5yNUAi/cu9RcCebl+Mc5bTU3WJHg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(39850400004)(46966006)(36840700001)(2906002)(8676002)(33656002)(83380400001)(52536014)(47076005)(36860700001)(110136005)(336012)(54906003)(316002)(5660300002)(186003)(26005)(7696005)(55016002)(81166007)(6506007)(4326008)(450100002)(53546011)(356005)(82310400003)(966005)(70586007)(478600001)(70206006)(86362001)(9686003)(8936002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 08:33:07.2973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a76dc2-8cd0-448a-2579-08d92fd833a2
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5001
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Saturday, June 12, 2021 5:28 AM
> To: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
> Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Jonathan Corbet <corbet@lwn.net>;
> Alexander Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
> <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFCv3 2/3] lib/vsprintf.c: make %pD print full path f=
or
> file
>
> On 11/06/2021 17.59, Jia He wrote:
> > We have '%pD' for printing a filename. It may not be perfect (by
> > default it only prints one component.)
> >
> > As suggested by Linus at [1]:
> > A dentry has a parent, but at the same time, a dentry really does
> > inherently have "one name" (and given just the dentry pointers, you
> > can't show mount-related parenthood, so in many ways the "show just
> > one name" makes sense for "%pd" in ways it doesn't necessarily for
> > "%pD"). But while a dentry arguably has that "one primary component",
> > a _file_ is certainly not exclusively about that last component.
> >
> > Hence change the behavior of '%pD' to print full path of that file.
> >
> > Things become more complicated when spec.precision and spec.field_width
> > is added in. string_truncate() is to handle the small space case for
> > '%pD' precision and field_width.
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=3DwimsMqGdzik187YWLb-
> ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com/
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  Documentation/core-api/printk-formats.rst |  5 ++-
> >  lib/vsprintf.c                            | 47 +++++++++++++++++++++--
> >  2 files changed, 46 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/core-api/printk-formats.rst
> b/Documentation/core-api/printk-formats.rst
> > index f063a384c7c8..95ba14dc529b 100644
> > --- a/Documentation/core-api/printk-formats.rst
> > +++ b/Documentation/core-api/printk-formats.rst
> > @@ -408,12 +408,13 @@ dentry names
> >  ::
> >
> >     %pd{,2,3,4}
> > -   %pD{,2,3,4}
> > +   %pD
> >
> >  For printing dentry name; if we race with :c:func:`d_move`, the name
> might
> >  be a mix of old and new ones, but it won't oops.  %pd dentry is a safe=
r
> >  equivalent of %s dentry->d_name.name we used to use, %pd<n> prints ``n=
``
> > -last components.  %pD does the same thing for struct file.
> > +last components.  %pD prints full file path together with mount-relate=
d
> > +parenthood.
> >
> >  Passed by reference.
> >
> > diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> > index f0c35d9b65bf..317b65280252 100644
> > --- a/lib/vsprintf.c
> > +++ b/lib/vsprintf.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/string.h>
> >  #include <linux/ctype.h>
> >  #include <linux/kernel.h>
> > +#include <linux/dcache.h>
> >  #include <linux/kallsyms.h>
> >  #include <linux/math64.h>
> >  #include <linux/uaccess.h>
> > @@ -601,6 +602,20 @@ char *widen_string(char *buf, int n, char *end,
> struct printf_spec spec)
> >  }
> >
> >  /* Handle string from a well known address. */
> > +static char *string_truncate(char *buf, char *end, const char *s,
> > +                        u32 full_len, struct printf_spec spec)
> > +{
> > +   int lim =3D 0;
> > +
> > +   if (buf < end) {
>
> See below, I think the sole caller guarantees this,
>
> > +           if (spec.precision >=3D 0)
> > +                   lim =3D strlen(s) - min_t(int, spec.precision, strl=
en(s));
> > +
> > +           return widen_string(buf + full_len, full_len, end - lim, sp=
ec);
> > +   }
> > +
> > +   return buf;
>
> which is good because this would almost certainly be wrong (violating
> the "always forward buf appropriately regardless of whether you wrote
> something" rule).

Sorry, I don't quite understand why it violates the rules here.

After removing the precision consideration, the codes should look like:
static char *string_truncate(char *buf, char *end, const char *s,
                                    u32 full_len, struct printf_spec spec)
{
        return widen_string(buf + full_len, full_len, end, spec);
}

Please note that in the case of small space with long string name,
The _buf_ had been filled with full path name:
e.g."/dev/testfile"
But the string might be truncated by the small space size.
e.g. "/dev/testf"
So we can't use the original string_nocheck here

Actually it doesn't backward buf here

--
Cheers,
Justin (Jia He)



>
> > +}
> >  static char *string_nocheck(char *buf, char *end, const char *s,
> >                         struct printf_spec spec)
> >  {
> > @@ -920,13 +935,37 @@ char *dentry_name(char *buf, char *end, const
> struct dentry *d, struct printf_sp
> >  }
> >
> >  static noinline_for_stack
> > -char *file_dentry_name(char *buf, char *end, const struct file *f,
> > +char *file_d_path_name(char *buf, char *end, const struct file *f,
> >                     struct printf_spec spec, const char *fmt)
> >  {
> > +   const struct path *path;
> > +   char *p;
> > +   int prepend_len, reserved_size, dpath_len;
> > +
> >     if (check_pointer(&buf, end, f, spec))
> >             return buf;
> >
> > -   return dentry_name(buf, end, f->f_path.dentry, spec, fmt);
> > +   path =3D &f->f_path;
> > +   if (check_pointer(&buf, end, path, spec))
> > +           return buf;
> > +
> > +   p =3D d_path_unsafe(path, buf, end - buf, &prepend_len);
>
> If I'm reading this right, you're using buf as scratch space to write
> however much of the path fits. Then [*]
>
> > +   /* Minus 1 byte for '\0' */
> > +   dpath_len =3D end - buf - prepend_len - 1;
> > +
> > +   reserved_size =3D max_t(int, dpath_len, spec.field_width);
> > +
> > +   /* no filling space at all */
> > +   if (buf >=3D end || !buf)
> > +           return buf + reserved_size;
>
> Why the !buf check? The only way we can have that is the snprintf(NULL,
> 0, ...) case of asking how much space we'd need to malloc, right? In
> which case end would be NULL+0 =3D=3D NULL, so buf >=3D end automatically=
,
> regardless of how much have been "printed" before %pD.
>
> > +
> > +   /* small space for long name */
> > +   if (buf < end && prepend_len < 0)
>
> So if we did an early return for buf >=3D end, we now know buf < end and
> hence the first part here is redundant.
>
> Anyway, as for [*]:
>
> > +           return string_truncate(buf, end, p, dpath_len, spec);
> > +
> > +   /* space is enough */
> > +   return string_nocheck(buf, end, p, spec);
>
> Now you're passing p to string_truncate or string_nocheck, while p
> points somewhere into buf itself. I can't convince myself that would be
> safe. At the very least, it deserves a couple of comments.
>
> Rasmus
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
