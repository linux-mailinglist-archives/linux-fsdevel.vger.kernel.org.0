Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE063C803B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 10:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238553AbhGNIgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 04:36:16 -0400
Received: from mail-eopbgr150077.outbound.protection.outlook.com ([40.107.15.77]:64833
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238432AbhGNIgP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 04:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZUEwNmmWVfd+xYLbhx9YRcm+DY2e5QX1KxNCZFPYO4=;
 b=5845bupHqgOv9A1JA6zvZtJ5qbkuvumU/wG1li0mB6kt0P7Q6mO8aV/8QiuEWDJNmX8tOF0mBhOSiqaCvO9EREFF34Y/j+bh2jvig5xKf20RNtmDl7QC8+Tyh3doQ8w/Veg8ucvH5Bybq99R6bH9CvipkkNOi+N92Q7SbwdoWEw=
Received: from DB8PR03CA0020.eurprd03.prod.outlook.com (2603:10a6:10:be::33)
 by DBAPR08MB5815.eurprd08.prod.outlook.com (2603:10a6:10:1ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 08:33:19 +0000
Received: from DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:be:cafe::4a) by DB8PR03CA0020.outlook.office365.com
 (2603:10a6:10:be::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 14 Jul 2021 08:33:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT043.mail.protection.outlook.com (10.152.20.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 08:33:19 +0000
Received: ("Tessian outbound bbfc4df8f27e:v99"); Wed, 14 Jul 2021 08:33:19 +0000
X-CR-MTA-TID: 64aa7808
Received: from 0b994ed5765f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id BD80BC00-6407-43F9-B7AF-590E24D397B5.1;
        Wed, 14 Jul 2021 08:33:13 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0b994ed5765f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 14 Jul 2021 08:33:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQn+WriTCDHmcugOAin8vetUE3W/cJRrBxO5LmjeV9JyVTpwJzk2pcxNn3ObRrTfSso3cEdodB+FgjggMvzj9WoiO9OvM74lYRMLTNCHOJQuPkT/jZc6SZ5etC8jMNd4uiQAYcV0/71P/rpvekCq+bkdTCF7yQfIGIg1g2CFL0HP8kxKOHoe/QOu5KV7ngx/MD5A32ECIZnCtStP10V6ZUjgwL3QzS+TSQFPNZq7efoSKvM8YBLXWUv3bpsGh+Q3u3GWBy3ta+BeItLo+8mHMI0mzmtcnCo7CbIluELEZPwxapaaqOiKKwdmLpHV6yhSpRcC4/JG4PwKjNc7gou1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZUEwNmmWVfd+xYLbhx9YRcm+DY2e5QX1KxNCZFPYO4=;
 b=O0c8ySzrFgszdQgS/5A1H+xHk2I2vdc6/inKV7xRrlE0QaEmhZPtuL2nQcdKpqGteF/f0NvRvfmkEPp+FbuaHb9fCD+3c9VXKzWBBklgeAU0hXzu91CpiesooIHLEg4MiTah47jAStVD8TtREx/2bdJEUOlnJNayZXk5rEJYKQaNZhO0oQ1urGu2cgc5ZY9cQ9Z2BxHCIUaMiuNY9qafLREEX1ildobiLLIOx4JukryDn8qxSJGdUU08ObgbxsZOGiL6r16C+JMMkps0HCiWpZ72J4mtBtkQwRAq6NgjCxol8yDA7Rtp2lNDQnoJjMGrVN9P83hseqOpY+GumbvH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZUEwNmmWVfd+xYLbhx9YRcm+DY2e5QX1KxNCZFPYO4=;
 b=5845bupHqgOv9A1JA6zvZtJ5qbkuvumU/wG1li0mB6kt0P7Q6mO8aV/8QiuEWDJNmX8tOF0mBhOSiqaCvO9EREFF34Y/j+bh2jvig5xKf20RNtmDl7QC8+Tyh3doQ8w/Veg8ucvH5Bybq99R6bH9CvipkkNOi+N92Q7SbwdoWEw=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3255.eurprd08.prod.outlook.com (2603:10a6:209:43::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.24; Wed, 14 Jul
 2021 08:33:10 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4308.027; Wed, 14 Jul 2021
 08:33:10 +0000
From:   Justin He <Justin.He@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
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
Subject: RE: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Thread-Topic: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
Thread-Index: AQHXZ/O2Q2C8pppNxUmz5hfVzQksAKshT1uAgAFX4HCAH54xYA==
Date:   Wed, 14 Jul 2021 08:33:10 +0000
Message-ID: <AM6PR08MB4376DB011A86FCD8C76FE80DF7139@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-2-justin.he@arm.com>
 <YNL6jcrN42YjDWpB@smile.fi.intel.com>
 <AM6PR08MB4376C83428D8D5F61C0BF3F2F7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376C83428D8D5F61C0BF3F2F7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 9A719F0C0077E84BB7B8B96274E8026C.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: c7f565c3-017d-4ed6-07dc-08d946a208ca
x-ms-traffictypediagnostic: AM6PR08MB3255:|DBAPR08MB5815:
X-Microsoft-Antispam-PRVS: <DBAPR08MB581506676BD93DEB3BE8AEAAF7139@DBAPR08MB5815.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:2582;OLM:2582;
X-MS-Exchange-SenderADCheck: 1
x-ms-exchange-antispam-relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oI8q+zaRRGbOOMAwah9XEruXwK/wq29Zqbw32JFAul8JSDE8ws40J2lWDTZStbbbqghLjfX+MMztH5aWMXDnCQ2du93V2b/+Tun/LGgp5QtCeymYw7DvG5MVtBrbI9BClxpeelQRGOijampWk1vWTz9WjOj+W9SfXFmeS+M7jvkb5hc8WIUojZ0tyT4c5vrg5hwALh6Us2/tJlTou8wiSgdAlG+M245gpAzdpnLbvrnBI8XkRMeXJ0Zd7dLEaZcdEIlXGEw4b5yFKu3+UiIi7eGR4Oo6g7npJ4aTyJtSqIbuRORLm7HAJSDqn/agJnp95rAJjmo1maTcYqggQWAeOaDp61/7E+DS8vn7espHHz+yFoocL0aLrOqm5/igWEPPE/G1/v0/iOj8Rejk6sL4m/5piMDgmFv3pmoaAnXfpWJCsjyk31/P8OQvq2bc3MMcLwOaE0QyFovrDVQV109mustTL7q0YwNwoEQIqOwLeV+PNDcscjaEaXCd3POLvW9yYLUe7IdusUV976YRNI3etDkyPDyOlf8i+7cDDLIUXFBhVlJJj9VB0M3b+sESOVed0OY6L57+5uPPKatnrRgnbiV5YoqASFzSm/Y+5iCSY8ZBuvvLm/Zc4tD3xJzavygrmaL76zscUIE6NUpK4KJRLNhZToKl4WWmQm3iRHdgn0dNFwqzwRAogVXZnPBdi29YXixiwVYehe47/juRVKD+5Q==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(5660300002)(4326008)(83380400001)(316002)(66556008)(2906002)(8936002)(86362001)(71200400001)(38100700002)(8676002)(66946007)(66476007)(76116006)(53546011)(186003)(33656002)(52536014)(7416002)(7696005)(6506007)(54906003)(6916009)(478600001)(64756008)(66446008)(122000001)(9686003)(55016002)(26005)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1/dKVPt+LakOQ9aULDU92f/SaCnkxyuG1q0zWpYhQqPOWhFzo5I+4V78rMgj?=
 =?us-ascii?Q?ob4LEQ6rZtPdONqx6dmLmBQ7Uzla45h/EIhbBrgttOy14lo6EKAfNqgtyBIR?=
 =?us-ascii?Q?3c1F6nk5X0uH/yGXXoupgwuUbNkbdJvLlEj9+YtxKK6CtQOlT5x0hVydlw88?=
 =?us-ascii?Q?30ErjlqcU9C/jJ4DCu7nXRu4o5V3J3lHTT/vDctagWManKi2Wwb/wN1ViKwK?=
 =?us-ascii?Q?AXt5K1lYSxkJ4bAE97oJGmUeTvj1H3LG/9aojl2f8oChbCSTG/SDUm1DAvHu?=
 =?us-ascii?Q?140RmJpPkuGIiEmTdsECkvoW9C3q13nrK44Qd3vUrWuc4B4+pP8B2wcIV2fc?=
 =?us-ascii?Q?leJI2OwH3TdZEPian8m6XvH/qKmiHekzFIrZ7itQVRKXvT1mPv8hEefqIffL?=
 =?us-ascii?Q?TyiSgSRW46wNB8dZA931vbMIwwx9L0S6Ea3c5cmOoIOtep9nqvtAK6E9WTB6?=
 =?us-ascii?Q?IPcfnH+k/0pnLJ1L0B8LMwH3QH4jcSUSpMU5/OckE8VD7w3X6AeKwOuMaO23?=
 =?us-ascii?Q?f/A2O2+Q5evzGHfdYv6CoKD1DDsaq4OYkXszQEEauq/X3yuausqgYVmajx/q?=
 =?us-ascii?Q?jlwa3putZl6k0cJljy2cpHdbaS3tE/0Mu5sn2u7uaVPOm/kCwM4GfMeoIWlt?=
 =?us-ascii?Q?aa1KaHOjdZXuJ7gWpqw3exX/A2yw9rrCkzQ6PfqSMGDw3seutrYCW4X4YRGa?=
 =?us-ascii?Q?Ee1Kd6S8KBjxU2MV2iKPCHM18Mhnl8x77CHYC2NInEuPpVoFty0UiQZtvajn?=
 =?us-ascii?Q?KeBZB4hl5L9x93Bgg9Ym37mGzN2sHa3x/MvD0Hbdohm+N4gA5UR/xx9lGgCW?=
 =?us-ascii?Q?R/R2NmJJ7ri8DbszLttsDFxMNNw++JFmlgyQ3e3kglEFw3YxMdQutcazz0O3?=
 =?us-ascii?Q?R9tcpui6+ztSKDzvozB2pgOMFQEjhdN7Q1WrQZQ7KzdUXlN/ePHOTbR/NuWX?=
 =?us-ascii?Q?RsRsEE3WmIjNuEKNZ753CO+tXu7WgVoFra48A47C9gE9o68oRGrv2vN2AE5V?=
 =?us-ascii?Q?rDEwxi6aLtgh2jWXm0/ip47nj4vLOKEV77UsRBXaomrplEE6MpairP7lv9Q5?=
 =?us-ascii?Q?stnQpGzIYoYe5v5i2c/TZAMS77weBVvo7H6bbbgAupqj0ciO0KgrNOZcxIf1?=
 =?us-ascii?Q?WwTcZPUZJM46cbzdfFtPBwnKn6/o1lBMHM4JpYZ0J1dCq1TuLiGMKCrqV3k+?=
 =?us-ascii?Q?eqXadoCGpeZ+ynI63A6FN/Kzd2SCsNdzNc8gaJ5djRRpxtNag4CZBfCsQiEt?=
 =?us-ascii?Q?7x+wb3XDOoBwBLWyXn3VtZ0gpu08TwKD0qzGUUG9ztGtRejADFV+oXv/gNjP?=
 =?us-ascii?Q?CwZpE6UfyFUvxVBfqk6uB7fW?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3255
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: ae83a823-5c0e-4a4f-a6c3-08d946a2035d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8+buOxL6A/2oVlDRZEC39RiucQIEHJnwdncJQFoN5+9Io+UwC1xrNTQXcBJfy3utAq8+klilx3zSBTNd7sou1m7AVxuDQDhDkjloEVOCNhrRYEggXHW8CCtG7PdnpUH/Hb2Th6QYeKSQwx/lpRGmzQfE3RwBfv79OoA+kLkIwl/Xxs/JVNXTAWOVn29htAAeOUcoz8zrXNQKjE9Po8gYT9fMsQmVomv5hhuPSx2oqgcmVahdPKygYAfN2KHk9AOcL2subU9EkXMSv8oiceKo5wdhjJe1bIV9/qgvMHNf8bDR6+6K8eJ1wqKoDEWX63d5Y2bGMH0Gb+6YC1cMPUjBMoU0MS2xUFyQ2/pbX2NUClN0LZDsipf4/czhLoNtzSgJ0hbTmNovkmzMZxncqYoH/kl4uj24gmJiJ94q9QfdWW+vJA3a1fD/Nv1uJgVn/Tm4E12szHsjpA5lCwM/IBQ7c9r095VvoVxzFt1k3fkJAEYWezBpyj9M8UlDNmV6mg6eoaSnU/Kb5JjmizWSfg9SKyBVG0/7dbNkbSIuANE97cxojxxTJS9xnD56da9NekB3Xh/hQJpKbykP+zQGekgXsshAawvQl2EzHjdXPyUNA8SUEpHzIBd/FCNjQWRTkFQbKPYtleR9SdpWaCKBEWymSMV7d46n1WBc6nsN2jPPyp4CPKf8+OZjGTsggwttGBPZDf2E2uCnO0rkQwrn+RMXZw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(36860700001)(356005)(70586007)(86362001)(55016002)(2906002)(82740400003)(70206006)(5660300002)(478600001)(6862004)(336012)(82310400003)(9686003)(81166007)(316002)(8936002)(186003)(83380400001)(53546011)(54906003)(6506007)(26005)(7696005)(33656002)(8676002)(450100002)(52536014)(4326008)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 08:33:19.5580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f565c3-017d-4ed6-07dc-08d946a208ca
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5815
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andy

> -----Original Message-----
> From: Justin He
> Sent: Thursday, June 24, 2021 1:49 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>; Christoph
> Hellwig <hch@infradead.org>; nd <nd@arm.com>
> Subject: RE: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
>=20
> Hi Andy
>=20
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Wednesday, June 23, 2021 5:11 PM
> > To: Justin He <Justin.He@arm.com>
> > Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org=
>;
> > Sergey Senozhatsky <senozhatsky@chromium.org>; Rasmus Villemoes
> > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> > Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> > foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> > Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.d=
e>;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > fsdevel@vger.kernel.org; Matthew Wilcox <willy@infradead.org>; Christop=
h
> > Hellwig <hch@infradead.org>; nd <nd@arm.com>
> > Subject: Re: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
> >
> > On Wed, Jun 23, 2021 at 01:50:08PM +0800, Jia He wrote:
> > > This helper is similar to d_path() except that it doesn't take any
> > > seqlock/spinlock. It is typical for debugging purposes. Besides,
> > > an additional return value *prenpend_len* is used to get the full
> > > path length of the dentry, ingoring the tail '\0'.
> > > the full path length =3D end - buf - prepend_length - 1.
> > >
> > > Previously it will skip the prepend_name() loop at once in
> > > __prepen_path() when the buffer length is not enough or even negative=
.
> > > prepend_name_with_len() will get the full length of dentry name
> > > together with the parent recursively regardless of the buffer length.
> >
> > ...
> >
> > >  /**
> > >   * prepend_name - prepend a pathname in front of current buffer
> pointer
> > > - * @buffer: buffer pointer
> > > - * @buflen: allocated length of the buffer
> > > - * @name:   name string and length qstr structure
> > > + * @p: prepend buffer which contains buffer pointer and allocated
> length
> > > + * @name: name string and length qstr structure
> > >   *
> > >   * With RCU path tracing, it may race with d_move(). Use READ_ONCE()
> to
> > >   * make sure that either the old or the new name pointer and length
> are
> >
> > This should be separate patch. You are sending new version too fast...
> > Instead of speeding up it will slow down the review process.
>=20
> Okay, sorry about sending the new version too fast.
> I will slow it down and check carefully before sending out.
> >
> > ...
> >
> > > +	const char *dname =3D smp_load_acquire(&name->name); /* ^^^ */
> >
> > I have commented on the comment here. What does it mean for mere reader=
?
> >
>=20
> Do you suggest making the comment "/* ^^^ */" more clear?
> It is detailed already in prepend_name_with_len()'s comments:
> > * Load acquire is needed to make sure that we see that terminating NUL,
> > * which is similar to prepend_name().
>=20
> Or do you suggest removing the smp_load_acquire()?

This smp_load_acquire() is to add a barrier btw ->name and ->len. This is t=
he
pair of smp_store_release() in __d_alloc().
Please see the details in=20
commit 7088efa9137a15d7d21e3abce73e40c9c8a18d68

    fs/dcache: Use release-acquire for name/length update
   =20
    The code in __d_alloc() carefully orders filling in the NUL character
    of the name (and the length, hash, and the name itself) with assigning
    of the name itself.  However, prepend_name() does not order the accesse=
s
    to the ->name and ->len fields, other than on TSO systems.  This commit
    therefore replaces prepend_name()'s READ_ONCE() of ->name with an
    smp_load_acquire(), which orders against the subsequent READ_ONCE() of
    ->len.  Because READ_ONCE() now incorporates smp_read_barrier_depends()=
,
    prepend_name()'s smp_read_barrier_depends() is removed.  Finally,
    to save a line, the smp_wmb()/store pair in __d_alloc() is replaced
    by smp_store_release().

I prefer to keep it as previous, what do you think of it?


--
Cheers,
Justin (Jia He)


