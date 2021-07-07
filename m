Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C353BE239
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhGGEzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 00:55:35 -0400
Received: from mail-am6eur05on2070.outbound.protection.outlook.com ([40.107.22.70]:19088
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230099AbhGGEzf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 00:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJKPl87XrkncQP+lH/a3pxFV41iRLNTnAggoTxBgGuY=;
 b=0ICOm9STtZ9pyj/34q5cW6P+H0vypaQAotUoa0IBu3fSZnW/1AfRIclKtYP+tN0+qlZKkfyYkQpBPFogSkSgtH69aLK1XiFgEUzkxki5Ckl8BHnkT1vuNih88Te2kh4EHanpnm8lqT6i4AD45ssXsoPHoBw/QLYGPmvJYZ7bFD0=
Received: from AM5P194CA0013.EURP194.PROD.OUTLOOK.COM (2603:10a6:203:8f::23)
 by DB6PR0802MB2311.eurprd08.prod.outlook.com (2603:10a6:4:87::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 04:52:51 +0000
Received: from AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:8f:cafe::90) by AM5P194CA0013.outlook.office365.com
 (2603:10a6:203:8f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend
 Transport; Wed, 7 Jul 2021 04:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT032.mail.protection.outlook.com (10.152.16.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 04:52:50 +0000
Received: ("Tessian outbound 1763b1d84bc3:v97"); Wed, 07 Jul 2021 04:52:49 +0000
X-CR-MTA-TID: 64aa7808
Received: from 7ae97337864e.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 66725628-70E9-4011-8E94-1F57F09CB214.1;
        Wed, 07 Jul 2021 04:52:42 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7ae97337864e.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Jul 2021 04:52:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4hzFBwA4pPQoajm6Uuz7uQBCM1cuBAY5q0kj4eXNVTzSw5LDZ6yL4WhOc3eX/ZfzePcUEdrzBg4HH78Pc08WuUG0GW1K0Z0149liDUqcztsyAodShhoM13mhMVdek8n8CRT5lrjRueFfhmBxgZTiBKCzwpXu1qjyIMv0mUWx4a9z8HkYLTPAswXJOTtIRX11a/NYvNE90MjUCWysflwf5PmU7VMjsyWuiyG08p3wGKy3zqyREZRi/XNlMGyE0p2/QNkR26ohKZRBfPXoMchZJfk2HZ6EOvI7/ewLoMXt+qXN4bVSLyBZjORq0MNeP1W97VPTCuwz7d1aQciUFYNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJKPl87XrkncQP+lH/a3pxFV41iRLNTnAggoTxBgGuY=;
 b=lbKKK5vOkc6Gj/NiZdg+gh4tGlnxhfKK6K/tcZsB+WqrnJa3yVLPTeTNsTBlODmQf9EatwD+F6WUDGpQJTXBP8s1AZ7doyCW1N2EVRKfRNn8cjiGG4L71buit5AWzJKtaSRjXgFEeJfChnBDRh1eYlNefUlloQqaHSPxtGHmgQeTgmtvbiVIemgRksQlxW2ie7f024nz6TDIIGiG/X4reGl0myGQg9rSKWcZeIiRBOV0nIz+tczrVMWqIZFoY6Uk7v9WvLZ0FoZOJ6lViiqBdeJ2c4737MTFzakzdr6/gK8Z2/TC2NeDwq2QqLSXBYkiM74B/fUbEQSlBIv5lUn6Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJKPl87XrkncQP+lH/a3pxFV41iRLNTnAggoTxBgGuY=;
 b=0ICOm9STtZ9pyj/34q5cW6P+H0vypaQAotUoa0IBu3fSZnW/1AfRIclKtYP+tN0+qlZKkfyYkQpBPFogSkSgtH69aLK1XiFgEUzkxki5Ckl8BHnkT1vuNih88Te2kh4EHanpnm8lqT6i4AD45ssXsoPHoBw/QLYGPmvJYZ7bFD0=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4247.eurprd08.prod.outlook.com (2603:10a6:20b:b9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.26; Wed, 7 Jul
 2021 04:52:41 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 04:52:41 +0000
From:   Justin He <Justin.He@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
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
Subject: RE: [PATCH 02/14] d_path: saner calling conventions for
 __dentry_path()
Thread-Topic: [PATCH 02/14] d_path: saner calling conventions for
 __dentry_path()
Thread-Index: AQHXTEjJBmBJOq2FXUq44gPHBJbVjKsksQ3AgBKNt7A=
Date:   Wed, 7 Jul 2021 04:52:41 +0000
Message-ID: <AM6PR08MB4376BFCD3BE5A09C66D177D4F71A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-2-viro@zeniv.linux.org.uk>
 <AM6PR08MB4376D52CD6D690C444918E00F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376D52CD6D690C444918E00F7069@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: F853EA59794D27468D131FF857AB79BE.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: f5fda506-1b94-4e88-3a8e-08d941031300
x-ms-traffictypediagnostic: AM6PR08MB4247:|DB6PR0802MB2311:
X-Microsoft-Antispam-PRVS: <DB6PR0802MB23112B0F4A3EC79CBBDFCEF9F71A9@DB6PR0802MB2311.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5516;OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: aW2UD448AwM8XDPXHh1xQ3oSKVosYPuBqMRPyb3ySN7XEjj+LhpfXN7zpn8emPEU7SHXFjJpWT3p+pLaH2qunL0u1vbyIDXdGCdxC7yQN/uHRBVrrhY7TIcznE+dhILEiBxrFT5RrYY77OlfvMzInaIUeSJY8ixoCOV1ANWFMVaGKuLFcyQIYYIA4d8QKtKxucPKOFnxpXHox4QIvzSU3uynrdi/lhJPq8R0P7qw2dgubhzMd3xdbgxb4pwQihayBsIIbtCtmM7Chc3s8jodxtU/d9wcK8gfSVOoqt2ycrHpEnDoyJxBSjyVqFQZou2Pcn8GoOLxO0Yc8lgclUWAIEXnxkaDtVLwUZZ/x1xJj10DroiSBmF8reSYVLYLgEopYj9eZwQAeZ3pSlgM7AozFTEL2fN96azfhhoWWLvjU73+u+cxUkRhxqazd2AQlbg/fdjO0Wtwhb3WnIuWgZYXuV9aw1CaWySpS2JDf95yOjdY1U3fYmJC4in1ZeWRBRLIOM0PHO/7K+sATY0wQldnj74wuEYcEuYebPMlFy9s/zzm8vQbUIh7dwn3OJpmzscGfozlv0a2bgHobdkcfcD4y6+BH+3mr/xeWDezK/30CbEehEPjs4KNUuo5FPw2jWu6IPAO/n/RQMwHtaFgqkkDwQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(9686003)(186003)(8676002)(478600001)(5660300002)(2906002)(52536014)(53546011)(71200400001)(38100700002)(55016002)(7416002)(26005)(8936002)(4326008)(122000001)(76116006)(66946007)(6506007)(83380400001)(66476007)(66556008)(33656002)(110136005)(7696005)(54906003)(86362001)(64756008)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1o7Am3pmZEVfjxe0DTk8pw55aQ4fi39QjdF1+bexnuAgxaHYuaSZ7YvyUZJ9?=
 =?us-ascii?Q?TaLgZp1i8bBZyinJrXN7B5e9IOPEHajB2a80b8/zYmmXtDEgipHwpD8Hmxdy?=
 =?us-ascii?Q?s5+yvmolYhM9gaS8ZRVeNttnrI58yWd28mXjzwsHwOjm1Kg9d3xeppl8+EFM?=
 =?us-ascii?Q?abRxLhapu6JtKKmP1BD+XYAzQErq7JWvMjjTvcHXFy4rC/5pefkafqfR6DRY?=
 =?us-ascii?Q?BOxsKh+XffrnnMt7IGe3g1O0KQOYZnYq8vbml2GPcKRc8zd27rKRrdHroZZ1?=
 =?us-ascii?Q?o0DsOVz0mwDuXvpSlfrkEdjRAaJ5ss2a02uTjRRLkMhs/nJX1EuVTOKU3iW1?=
 =?us-ascii?Q?1fu5tmzChlO35NfRgkau3uHQybpdc8lEhyP1FU4MZrDOEwKup6hN+YzPZty1?=
 =?us-ascii?Q?L6fP1z79QK5Umffv1f7NaWH1Lj2O9tYovPqTNtiQ/bwWJu+5Lqj7eYLFy/LB?=
 =?us-ascii?Q?Y4RYeqN3kO1QxdkmbCvzfnyHPlxProtGe9K3uxvttiUJzNBXcgaYtu6/wzuL?=
 =?us-ascii?Q?B7MBJAaAqLrg0c7OPZqEQZGaaVPMOif4Q6lsYEz6jtaqFqAr6c4fO9SWP+Vf?=
 =?us-ascii?Q?eR1+ZaSuCZEaa6t6HY1nbYrUKxGEFpz5OoHm98Ujg4zwBRKygcf4tsIgtDnD?=
 =?us-ascii?Q?pq7fwGPZDi0pkdB0YQJdA1e5ExxY4SgmWfbVgUn14pCILjdhJmNMIxexrzAV?=
 =?us-ascii?Q?PadxvwPBcWLkd1nldz1MXqnKJSINP7jtl4MosqOMNBMvt5yZu01GtHFJpigy?=
 =?us-ascii?Q?4AyqsRuiZeypFRxE+GzG2fjZn20uPJ9+mlBE1N1rREYBy/U9tt3GyGM/PfNf?=
 =?us-ascii?Q?ZuCwT9U5Vn3dscnM+THC630JtBnvRhLJ9/nY9/0uZrO+ZwmRj1/LIr5Ws3o0?=
 =?us-ascii?Q?iJ+2+7hUcgFY8L0U2L0DizU28Nn659GE/RjT5MVHrv0ChSZ/t01K7C9320hf?=
 =?us-ascii?Q?A/2diomnNDCft7PgN+YXOYFnon42GUI9iG+Fvcz0mha0qiKw/0jRhgGgL3qU?=
 =?us-ascii?Q?gEX0ajQAIcOIwqWCV++dUgcbMuR5LVi8T7fux/iAhR3CthItaaFdmGWK1xcj?=
 =?us-ascii?Q?PYtgA/LW2wmlLRFYD0He7mR9OL4ZstEbGFpDJk85T2fdXRKYsUsMLqAEbLp+?=
 =?us-ascii?Q?Fx3OidWqxrS5AIhWWw8gRuOZKyFvF79Y9tQ5b4rH6AV4Nsrg0j2vf7fsD0V1?=
 =?us-ascii?Q?eJVL7zfhmwr2y9ao5EUGU9Jjz5CdW1KobcivTCxEJeS0zhqbyoA2xW4g/3X7?=
 =?us-ascii?Q?Fx8fCU+hhu/mC8/DFbpZQsT7MtmKMoDCtLn2pNCkulC7XaOlOjLPGpJfLW4i?=
 =?us-ascii?Q?TMM0lMoXSXa9xNhy7LiYe54I?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4247
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e4d9e804-c848-496e-2086-08d941030d2e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoyO8W0WCmR7+Hw7hZ2pKca4tENPZH1w+CLyKyJpoGvLj1hM9Et7mrenk7LRIC0l+2vUyryLpSgBDipryILSWleN+uMwzxdx+QqddGCS/aovWWe18Jk+Hrsd9qLLtw11JZ7HVtjy5y+7d8Rhu1ddXDhjjw1NgKYzX1dV0UeAvk0l/StVgyMx702PtKDFrzdAKI+YnZelIe8HlrNTyKzoTr+KhyYhT21I/MQKliQhKiskWAtj0LUPf/AeZfK7hxQRqxZj4+7W8epdZ6vQedfrY3TtfZdu/JrOTPUynw/A+XMqkxRpp2MTUOtnE/jncXyl9jb+3Evgj/8ToplFNUdSQY1Weshvd1Lot0hV25kJ582yTntTibS6dOQ13CHjIV0Yc8L27vA6gNq4SKOAXYcaF+KDj1J5oum7vrWBE/D1z7CIvDRuM7xaF5+q2rgiZ/AIcyT6oLidbfjcrWkLI++PB+k6UC+/Y43M+iWCc/eUwyYZGF5O8i0INCIawh3HaewiiMWsXChOn1/IHHP+edqODM8eWX5TnOYF+sVI+31JZ4UHdPJBU0y4CBjdVN1H6NX6H1yifSSi7aU1I8SOzqdm8wWYY2/VsrsQEdkk44zNMcdY4RAxP4Dk7kDvRhZxdzyY/s+BRqAdVOE44onxYMPpZnOJh5mU7lm6+c0zN4IkjWuaRBo9bcuqSt+jtKOXYCIHSMZYGD1gW2imbopbt1nFeg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(376002)(46966006)(36840700001)(450100002)(8676002)(5660300002)(81166007)(336012)(7696005)(186003)(33656002)(53546011)(36860700001)(47076005)(2906002)(356005)(86362001)(82740400003)(4326008)(6506007)(478600001)(70586007)(9686003)(110136005)(8936002)(316002)(54906003)(83380400001)(55016002)(70206006)(26005)(82310400003)(52536014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 04:52:50.7995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fda506-1b94-4e88-3a8e-08d941031300
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT032.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2311
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Justin He
> Sent: Friday, June 25, 2021 5:33 PM
> To: Al Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>
> Cc: Petr Mladek <pmladek@suse.com>; Steven Rostedt <rostedt@goodmis.org>;
> Sergey Senozhatsky <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Heiko
> Carstens <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>; Christia=
n
> Borntraeger <borntraeger@de.ibm.com>; Eric W . Biederman
> <ebiederm@xmission.com>; Darrick J. Wong <darrick.wong@oracle.com>; Peter
> Zijlstra (Intel) <peterz@infradead.org>; Ira Weiny <ira.weiny@intel.com>;
> Eric Biggers <ebiggers@google.com>; Ahmed S. Darwish
> <a.darwish@linutronix.de>; open list:DOCUMENTATION <linux-
> doc@vger.kernel.org>; Linux Kernel Mailing List <linux-
> kernel@vger.kernel.org>; linux-s390 <linux-s390@vger.kernel.org>; linux-
> fsdevel <linux-fsdevel@vger.kernel.org>
> Subject: RE: [PATCH 02/14] d_path: saner calling conventions for
> __dentry_path()
>=20
> Hi Al
>=20
> > -----Original Message-----
> > From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> > Sent: Wednesday, May 19, 2021 8:49 AM
> > To: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Stev=
en
> > Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> > <senozhatsky@chromium.org>; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> > <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Heiko
> > Carstens <hca@linux.ibm.com>; Vasily Gorbik <gor@linux.ibm.com>;
> Christian
> > Borntraeger <borntraeger@de.ibm.com>; Eric W . Biederman
> > <ebiederm@xmission.com>; Darrick J. Wong <darrick.wong@oracle.com>; Pet=
er
> > Zijlstra (Intel) <peterz@infradead.org>; Ira Weiny <ira.weiny@intel.com=
>;
> > Eric Biggers <ebiggers@google.com>; Ahmed S. Darwish
> > <a.darwish@linutronix.de>; open list:DOCUMENTATION <linux-
> > doc@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; linux-s390 <linux-s390@vger.kernel.org>; linux=
-
> > fsdevel <linux-fsdevel@vger.kernel.org>
> > Subject: [PATCH 02/14] d_path: saner calling conventions for
> __dentry_path()
> >
> > 1) lift NUL-termination into the callers
> > 2) pass pointer to the end of buffer instead of that to beginning.
> >
> > (1) allows to simplify dentry_path() - we don't need to play silly
> > games with restoring the leading / of "//deleted" after __dentry_path()
> > would've overwritten it with NUL.
> >
> > We also do not need to check if (either) prepend() in there fails -
> > if the buffer is not large enough, we'll end with negative buflen
> > after prepend() and __dentry_path() will return the right value
> > (ERR_PTR(-ENAMETOOLONG)) just fine.
> >
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/d_path.c | 33 +++++++++++++--------------------
> >  1 file changed, 13 insertions(+), 20 deletions(-)
> >
> > diff --git a/fs/d_path.c b/fs/d_path.c
> > index 01df5dfa1f88..1a1cf05e7780 100644
> > --- a/fs/d_path.c
> > +++ b/fs/d_path.c
> > @@ -326,22 +326,21 @@ char *simple_dname(struct dentry *dentry, char
> > *buffer, int buflen)
> >  /*
> >   * Write full pathname from the root of the filesystem into the buffer=
.
> >   */
> I suggest adding the comments to remind NUL terminator should be prepende=
d
> before invoking __dentry_path()
>=20
Except for my suggestion about adding comments

Reviewed-by: Jia He <justin.he@arm.com>
