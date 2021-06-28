Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5883A3B5888
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 07:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhF1FQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 01:16:30 -0400
Received: from mail-eopbgr80059.outbound.protection.outlook.com ([40.107.8.59]:23110
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhF1FQ3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPQIQFbIU8u6CIvTao91xHE2XXT/TxBmn8Zo7g7fddM=;
 b=OLJkh1rF6fj2VbEEN0K+WJp+n+ZgyY1fxNleM6MCaAyqU5fiFjtC/1e3jxNO4ROj9IL6lRNBiTvLickS4ZaOoYC2vb1cz5KmHD8gTlfVn0Q8aftiiPoJJ5Inlt+6jAjEbSWixjUG+PjKKIuSg+76CZ3bVOM+9gqhYPohAUx8qs0=
Received: from AS8PR04CA0108.eurprd04.prod.outlook.com (2603:10a6:20b:31e::23)
 by DB8PR08MB4060.eurprd08.prod.outlook.com (2603:10a6:10:a7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Mon, 28 Jun
 2021 05:13:59 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31e:cafe::a3) by AS8PR04CA0108.outlook.office365.com
 (2603:10a6:20b:31e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend
 Transport; Mon, 28 Jun 2021 05:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 05:13:59 +0000
Received: ("Tessian outbound 40f076a73fdc:v97"); Mon, 28 Jun 2021 05:13:59 +0000
X-CR-MTA-TID: 64aa7808
Received: from 622c3f658d4e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F592E39A-9735-460D-A8EE-564765E275BC.1;
        Mon, 28 Jun 2021 05:13:53 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 622c3f658d4e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 28 Jun 2021 05:13:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNW2+3jJGLBKYQt74cfq62wvAnbA9NVgAW2pp34PBYkzbXOZ8TaoEIXc0LiLD+BU/klcvUkJv4oDgg2DD2fyrJUQCh3Oul8PvJRnFfIKt8rn7ARXavCu72h6cDFQRDqPKZSMACVn+nNT7FSVniRrfzYMRfxa14T/RzmiAqTD83P4SBSULEgjs26G82DuzrAh3ZdIFevH8FfC0h7F4bzHrEe5cvJ7tu83VPEJzcktWbRhziFzM79Q3WJP1TD+nn9TAvSjDSBviZbLGNWG5zU/tEmf/mhdKJZQwpe5VcHsZwFBiJM876+Y8f5Lwl3Gb9x6MzDItZ3Tj5eEmzKPJBm/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPQIQFbIU8u6CIvTao91xHE2XXT/TxBmn8Zo7g7fddM=;
 b=FxcicqIw7aHCvGs9+TZQQCwddplzieaxfgAd57mQ0KtcvpWXMwTvt52MjEeZAzOqRJPSp3vNkapeJ9E9azdFRCxj+jNEb3UzOsnfAmDdr8hVZv+4PErZIFyOluCkuvXB9AKkH0GRepG+w8PJsItvq426y83t48zubzkMDw1kc6v+2KgxbXMzSDewKPOWgfnpkwtnskAycn0OOvRdXzRKjQmvRuggrQ1bG3tuwB3RlT7YhE5KHPfkOo4ymGBNUmqSBjRUGj4VU0dDEw5zeJoJifiM0n/5kzfBNmZhYSZyOfC22oO3K9sOsSOx374egVxyh6SW4jDuKiy6nToiKFng+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPQIQFbIU8u6CIvTao91xHE2XXT/TxBmn8Zo7g7fddM=;
 b=OLJkh1rF6fj2VbEEN0K+WJp+n+ZgyY1fxNleM6MCaAyqU5fiFjtC/1e3jxNO4ROj9IL6lRNBiTvLickS4ZaOoYC2vb1cz5KmHD8gTlfVn0Q8aftiiPoJJ5Inlt+6jAjEbSWixjUG+PjKKIuSg+76CZ3bVOM+9gqhYPohAUx8qs0=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3845.eurprd08.prod.outlook.com (2603:10a6:20b:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Mon, 28 Jun
 2021 05:13:51 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 05:13:51 +0000
From:   Justin He <Justin.He@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd <nd@arm.com>,
        Justin He <Justin.He@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Thread-Topic: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Thread-Index: AQHXZ/O2Q2C8pppNxUmz5hfVzQksAKskxYzg
Date:   Mon, 28 Jun 2021 05:13:51 +0000
Message-ID: <AM6PR08MB43762FF7E76E4C7A0CD36314F7039@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-2-justin.he@arm.com>
In-Reply-To: <20210623055011.22916-2-justin.he@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: FA8DE3739038B84CB897A293E76A0613.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 671498b7-c74f-48f3-4b5a-08d939f3895d
x-ms-traffictypediagnostic: AM6PR08MB3845:|DB8PR08MB4060:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB40608C54C3EC0F901CEDEA58F7039@DB8PR08MB4060.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:3631;OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: rcd4lxJ+7JV7iQxLMYRDwgHo63LVbu2k9saA20ehDVVq1GDp8H7mShuPUoOnSb5GZASgemxoEza8qDtEEIOK67OkLZUTtJNLMbEMLDDoAf2Aqs6+KJfqJXj0NZUXUltTAE9go3xnLpNH0WSF8lQEMt9lRUChGh3Ja3AKj0hG7KnjlDMOWKOqs5quK+kTGIntYBBfOpx+kFfoXHsjtJK0OZKN8u5cHTjFzxvOCZRG7sGWi3Z17kJhsa3lMn+nl/wI+Snt/7heiQzq3GJ3JOHJkw6GODNCsT7ykNJylyMrmvAfGcwD34XVk8UFqyIBBcU6IQztJ0qArvc69ZY8FRuKe+eUxKgwk8M5YqN/0PU42RRFgw7euWpb6pzgYG2IfCPjfMeCSlWx8weOI+i4Jcw5KuArbU1aO1VsGBqjXS1uGoHorPPhv9i7jZleNftTHzo86brJIZio+UdFCXm3XManfMXBRQZM1LC4KKLi9XPJVfqaH6Rd4VSSzHUTkkXPRGB8ESSfKnjIuC7BGfYLG12W7lxxHyA7xU4q7rjHw0woJfSRUZcrb5yDcT7KXSLFMWyl4FV16/apm0cZOhJogg2cHWuv04IBpQMVA++bYaalMpRG1Lxy6ies6m+G1jd07MvU1h7ibNU8vYnTM3TtkqiVkw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39850400004)(26005)(71200400001)(54906003)(316002)(52536014)(186003)(66476007)(76116006)(122000001)(6506007)(53546011)(478600001)(38100700002)(2906002)(66556008)(110136005)(5660300002)(7696005)(66446008)(64756008)(7416002)(4326008)(55016002)(8676002)(83380400001)(66946007)(86362001)(9686003)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iX6EGo93Z2KvUc4XZaNBOJeLWlgFB/R2Lvp0A8vH+Nxc75i9MU3jv4jMuOj+?=
 =?us-ascii?Q?LmdcIWfKL/PARXSCuj7e03uQWe41GNndZNW6DggSQCzbDcRB/UJM03eD0p5k?=
 =?us-ascii?Q?XOfqJLwNcNXPbA4PDvk2uD03SM/knyyAP0b0kBaKdNNLcINMium3WJBRNhF+?=
 =?us-ascii?Q?eEb7GDGCKcuu70EKmnWYKnb5EpUBnC7Ee3WlGWpGzzFTbo5GKn1aqF95ZHKm?=
 =?us-ascii?Q?+NgkEu4cmtpgK83GPE0lmKR6Nql6wMwKe0m+CJOh0NsOdUl6oV55D3MOWikb?=
 =?us-ascii?Q?DaeEB2BkcDtWh7eAIPNGbPUGi+mfzgVNuT52RC9LDPnxP9uN0B09iznAjXGF?=
 =?us-ascii?Q?S8HDE1nq7aU7b4Vig9kS/Cvc4Kk59DHr4jfyUKyLvanwc2dMI2MFBAM1e6p4?=
 =?us-ascii?Q?wOIO22PXUAzSybbQgDfGEMgFlpu3RR6Z52HywtP97BwW5Zih72hZDCIuoyS4?=
 =?us-ascii?Q?L8G6n1fu6QavrR2ae4Z7lTRfxqrwb4A3mICmxG1Qv5hmv/PbeO0Z6ZrFAn5F?=
 =?us-ascii?Q?em+NhOkcSTmitAmNpJMZECpugOOFzppFJOPpF+551968CcN1Iu0uLiROcduh?=
 =?us-ascii?Q?6Wh3SyMUJvRUkIqMS01KqbTwxCNqhCJWgLqulgpEv656KKheyLyenxOF8bXy?=
 =?us-ascii?Q?y4n8PeK0buwR6AQHmigA+C/K4Pxzdqt+rLhgkIcnKqEU/C+fGBW0330c04Qy?=
 =?us-ascii?Q?ad+uiZpp2MfF0k0JZVkwZ85XutjleKdPMPelwSAsLkwiw9D9X4k7NvNh/KLO?=
 =?us-ascii?Q?EUxcTgGYoL52Z2xV6lSDV0zQVwCijEOtZx9HdPIz1+HrHT2Ef3B3ghCO2cAI?=
 =?us-ascii?Q?pb7QpyNiuiOntBTkGZPKsauAOvsRGi3uEC8CcqI/nImkyNEYF/0q5tGxGAQ9?=
 =?us-ascii?Q?JdfGQ68XhPhbI7UFE5AhzAO4YKlXKbrw3G98ViygbGdBuLv9AaS7+oj7/6b2?=
 =?us-ascii?Q?zY/r2dQk6sgz//6lT9pXiWIKQbrJ8SqWD+clxniLeSWZbXPtaUpXNn/nJLdG?=
 =?us-ascii?Q?SuR4N650PzW0/d8+XVFQStB0AXFYsLYBfWRHT1egqiWIMQiOPiMb8oy/NOCD?=
 =?us-ascii?Q?ML1PNgKmbRlIOcf8YKjgxtlGF6pG02BXN4TvydR0s6FM+6z9pICY+hPU9ijO?=
 =?us-ascii?Q?u2hctAgjgAPGmOYpzMlN3b8R3OTgdTuSRwClpoFarPk+CPft0MaUHj2LLxQk?=
 =?us-ascii?Q?2zhpTdV3Z/wUmNwO7BTbgjAlWuHr64zVnGehubmaOehhJ8wa3lQH7bywlv2k?=
 =?us-ascii?Q?L/BixtI7rp8zojvrWSaWMAcCvwwXvPinS/ptfqjOxkaLoydVBO5hTiuw0+3S?=
 =?us-ascii?Q?I9daNkiQDUk30qDZZ9X7VrKN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3845
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 4deaeeb0-3b01-4f9a-ddbe-08d939f384a8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EqZ+vSzhcQuc59o5KTsQ8JPKuD8AuFpjn21VpdMqVIt3dbGFgFirRVNZfxvQ+fUDNvJ8UPVZsMH5LvIuD6ud9pKXF5Psn1CmAp6rNeLyqzw4j6yYXZ5W1rCKpjJhUbj66RJFM3Vfgx+9/Aokg2irVxfQ3QOXEgItZrHzem2JKxTWD13CmcuqeAYPZsMZN+pyTbfqSXEZCBb/mdKwtAsttjB+5wAbktvcGJsjudV3cJkKPE7GuOZZTPuKZCt4chMels12sRx42S+ZsE7j+669iBU9ttwGYVj0Q8UIateVGYlwxIQPx+g7eDYbrRkG+sFmQDfeZB9mBYxhWqF3A6uz3RU59I3tyZTVWOuLbSc0NFcvqnZ7oehv0OczcaqWo78CWXuZXMf3iXlcnXoIaNt+RXdLoOSmB0XmYu6xROeOZ9KCX8U1jZb/EA1UfijxGPskJuXqQdLkD6ZQIO9FvjYtW+0aUrnqbb2T6X6SHWQA+GGdkHUKWPdRCyxtDCSAGE3AYpaSIblo3z6hVEnbKMhyzmpcdw1vzMMo1uS1DEWbK5tNhb6VmjRBox7wN2lW3z54i9HBSBdiq/+W+s/VDAKlbupt2veKSshq8LJ85M2Raq1SPSdsQMPvQcVxz+2AlKLdnixYOv4RazRl2FAV2gMPnijSW/unbjmXDq3z+6GTyA1ZtleIrYM1Pjyh9JgTxObwIT968e/P59UJSgrpAKgKiQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(136003)(376002)(46966006)(36840700001)(86362001)(478600001)(4326008)(83380400001)(450100002)(356005)(2906002)(81166007)(26005)(186003)(7696005)(107886003)(36860700001)(82740400003)(6506007)(70586007)(52536014)(5660300002)(33656002)(336012)(9686003)(47076005)(110136005)(54906003)(82310400003)(70206006)(53546011)(55016002)(8936002)(316002)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 05:13:59.2875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 671498b7-c74f-48f3-4b5a-08d939f3895d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4060
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andy, Petr

> -----Original Message-----
> From: Jia He <justin.he@arm.com>
> Sent: Wednesday, June 23, 2021 1:50 PM
> To: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
> <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>; Christoph
> Hellwig <hch@infradead.org>; nd <nd@arm.com>; Justin He <Justin.He@arm.co=
m>
> Subject: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
>=20
> This helper is similar to d_path() except that it doesn't take any
> seqlock/spinlock. It is typical for debugging purposes. Besides,
> an additional return value *prenpend_len* is used to get the full
> path length of the dentry, ingoring the tail '\0'.
> the full path length =3D end - buf - prepend_length - 1.
>=20
> Previously it will skip the prepend_name() loop at once in
> __prepen_path() when the buffer length is not enough or even negative.
> prepend_name_with_len() will get the full length of dentry name
> together with the parent recursively regardless of the buffer length.
>=20
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  fs/d_path.c            | 122 ++++++++++++++++++++++++++++++++++++++---
>  include/linux/dcache.h |   1 +
>  2 files changed, 116 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/d_path.c b/fs/d_path.c
> index 23a53f7b5c71..7a3ea88f8c5c 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -33,9 +33,8 @@ static void prepend(struct prepend_buffer *p, const cha=
r
> *str, int namelen)
>=20
>  /**
>   * prepend_name - prepend a pathname in front of current buffer pointer
> - * @buffer: buffer pointer
> - * @buflen: allocated length of the buffer
> - * @name:   name string and length qstr structure
> + * @p: prepend buffer which contains buffer pointer and allocated length
> + * @name: name string and length qstr structure
>   *
>   * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
>   * make sure that either the old or the new name pointer and length are
> @@ -68,9 +67,84 @@ static bool prepend_name(struct prepend_buffer *p,
> const struct qstr *name)
>  	return true;
>  }
>=20
> +/**
> + * prepend_name_with_len - prepend a pathname in front of current buffer
> + * pointer with limited orig_buflen.
> + * @p: prepend buffer which contains buffer pointer and allocated length
> + * @name: name string and length qstr structure
> + * @orig_buflen: original length of the buffer
> + *
> + * p.ptr is updated each time when prepends dentry name and its parent.
> + * Given the orginal buffer length might be less than name string, the
> + * dentry name can be moved or truncated. Returns at once if !buf or
> + * original length is not positive to avoid memory copy.
> + *
> + * Load acquire is needed to make sure that we see that terminating NUL,
> + * which is similar to prepend_name().
> + */
> +static bool prepend_name_with_len(struct prepend_buffer *p,
> +				  const struct qstr *name, int orig_buflen)
> +{
> +	const char *dname =3D smp_load_acquire(&name->name); /* ^^^ */
> +	int dlen =3D READ_ONCE(name->len);
> +	char *s;
> +	int last_len =3D p->len;
> +
> +	p->len -=3D dlen + 1;
> +
> +	if (unlikely(!p->buf))
> +		return false;
> +
> +	if (orig_buflen <=3D 0)
> +		return false;
> +
> +	/*
> +	 * The first time we overflow the buffer. Then fill the string
> +	 * partially from the beginning
> +	 */
> +	if (unlikely(p->len < 0)) {
> +		int buflen =3D strlen(p->buf);
> +
> +		/* memcpy src */
> +		s =3D p->buf;
> +
> +		/* Still have small space to fill partially */
> +		if (last_len > 0) {
> +			p->buf -=3D last_len;
> +			buflen +=3D last_len;
> +		}
> +
> +		if (buflen > dlen + 1) {
> +			/* Dentry name can be fully filled */
> +			memmove(p->buf + dlen + 1, s, buflen - dlen - 1);
> +			p->buf[0] =3D '/';
> +			memcpy(p->buf + 1, dname, dlen);
> +		} else if (buflen > 0) {
> +			/* Can be partially filled, and drop last dentry */
> +			p->buf[0] =3D '/';
> +			memcpy(p->buf + 1, dname, buflen - 1);
> +		}
> +
> +		return false;
> +	}
> +
> +	s =3D p->buf -=3D dlen + 1;
> +	*s++ =3D '/';
> +	while (dlen--) {
> +		char c =3D *dname++;
> +
> +		if (!c)
> +			break;
> +		*s++ =3D c;
> +	}
> +	return true;
> +}
> +
>  static int __prepend_path(const struct dentry *dentry, const struct moun=
t
> *mnt,
>  			  const struct path *root, struct prepend_buffer *p)
>  {
> +	int orig_buflen =3D p->len;
> +
>  	while (dentry !=3D root->dentry || &mnt->mnt !=3D root->mnt) {
>  		const struct dentry *parent =3D READ_ONCE(dentry->d_parent);
>=20
> @@ -97,8 +171,7 @@ static int __prepend_path(const struct dentry *dentry,
> const struct mount *mnt,
>  			return 3;
>=20
>  		prefetch(parent);
> -		if (!prepend_name(p, &dentry->d_name))
> -			break;
> +		prepend_name_with_len(p, &dentry->d_name, orig_buflen);

I have new concern here.
Previously,  __prepend_path() would break the loop at once when p.len<0.
And the return value of __prepend_path() was 0.
The caller of prepend_path() would typically check as follows:
  if (prepend_path(...) > 0)
  	do_sth();

After I replaced prepend_name() with prepend_name_with_len(),
the return value of prepend_path() is possibly positive
together with p.len<0. The behavior is different from previous.

The possible ways I figured out to resolve this:
1. parameterize a new one *need_len* for prepend_path
2. change __prepend_path() to return 0 instead of 1,2,3
if p.len<0 at that point

the patch of solution 2 looks like(basically verified):
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -144,6 +144,7 @@ static int __prepend_path(const struct dentry *dentry, =
const struct mount *mnt,
                          const struct path *root, struct prepend_buffer *p=
)
 {
        int orig_buflen =3D p->len;
+       int ret =3D 0;
=20
        while (dentry !=3D root->dentry || &mnt->mnt !=3D root->mnt) {
                const struct dentry *parent =3D READ_ONCE(dentry->d_parent)=
;
@@ -161,19 +162,27 @@ static int __prepend_path(const struct dentry *dentry=
, const struct mount *mnt,
                        mnt_ns =3D READ_ONCE(mnt->mnt_ns);
                        /* open-coded is_mounted() to use local mnt_ns */
                        if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
-                               return 1;       // absolute root
+                               ret =3D 1;        // absolute root
                        else
-                               return 2;       // detached or not attached=
 yet
+                               ret =3D 2;        // detached or not attach=
ed yet
+
+                       break;
                }
=20
-               if (unlikely(dentry =3D=3D parent))
+               if (unlikely(dentry =3D=3D parent)) {
                        /* Escaped? */
-                       return 3;
+                       ret =3D 3;
+                       break;
+               }
=20
                prefetch(parent);
                prepend_name_with_len(p, &dentry->d_name, orig_buflen);
                dentry =3D parent;
        }
+
+       if (p->len >=3D 0)
+               return ret;
+
        return 0;
 }

What do you think of it?

--
Cheers,
Justin (Jia He)


