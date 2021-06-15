Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E257A3A77A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFOHJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:09:29 -0400
Received: from mail-am6eur05on2064.outbound.protection.outlook.com ([40.107.22.64]:34572
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230303AbhFOHJZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGDVvZ+LeichQcdkXM18hrhGv5p5/mP4F/YbHFu8u8o=;
 b=OU22xLsGLnK95RpAYgDyUVAtnXB3Rz2XQuwqGTKtNlBcBiETcl93hGuN0aaMsQd1byHxsaqtIdjowMNivnOI+sUGeiaNQnfxJeeVTFaldl5WDs5Au8CpQNJTs8/M4PZiGkTVQxjcFr/5tPIlBIpZX2T/TMetI6BZw3/NKv/q048=
Received: from DB6PR0402CA0003.eurprd04.prod.outlook.com (2603:10a6:4:91::13)
 by DB9PR08MB7116.eurprd08.prod.outlook.com (2603:10a6:10:2c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 07:07:12 +0000
Received: from DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:91:cafe::51) by DB6PR0402CA0003.outlook.office365.com
 (2603:10a6:4:91::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 07:07:12 +0000
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
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 07:07:12 +0000
Received: ("Tessian outbound a65d687b17e4:v93"); Tue, 15 Jun 2021 07:07:12 +0000
X-CR-MTA-TID: 64aa7808
Received: from 3b3d5d3f099f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0EAD656D-A827-4ACB-9DCD-C3AD0E98DCEC.1;
        Tue, 15 Jun 2021 07:07:06 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3b3d5d3f099f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 15 Jun 2021 07:07:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVIZoYND0No7wmeM1vhSYOO91kMV75MUDtDoKUJYj8934yGy0Sxs9754n7q/qYjUnVKqWgv3lf/5K3WYWpY8Qld8eb4Epw2Xtfr3jzx1Blcd+u9DUpAVoBYe1rbwid7wt5TZNOF7wTzBq21KyhQZecXq1xjiSQj6/aI8mXrQuzgi74Suy5Dw9TZneJA5tx1sCckXBES/ZRWL8ANRNZDagMC9gIYIsjAFQmMLvVpBBqt31zlq6xUnuXu3FwiD28OTCpdC3C9nFFr6/l9fXAs/dY2MoH+sekbCiAj2BBA/nlQjeYyCD2TtrVjs4kx9x/UKENm3Ql8ycdgDyb+4My7AVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGDVvZ+LeichQcdkXM18hrhGv5p5/mP4F/YbHFu8u8o=;
 b=YkksnSA/tpVaf8bcraj+pBmvdI009Naz228KG4zYpYLgb2HWaDCsXooCS9Zi8vVZmwZKR88xsv+hGhSxHr/8rsNj5328krqdKmfwn5Kc7HVWT5JkKmV5GoBgEBZ1M+cuO98uD6PkAsAckGBqsLufGSc3o309+/JxqyE/vB+at9uDIojziREkKb/TU90lG5W5o0fUbzlTmwD5pcoOfelODkM1DFQnGj+Mph4KqwPkoZNbhkh4X0aV4/B+f9Wntu6fDFQJ3Rczf5zAupqhJQw1iRAQDHmRFh/VlHfgf/RdsEh939SNOPpHxoN7jK+pAyRuvY/1iHh5bUEw9BRfrD4+MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGDVvZ+LeichQcdkXM18hrhGv5p5/mP4F/YbHFu8u8o=;
 b=OU22xLsGLnK95RpAYgDyUVAtnXB3Rz2XQuwqGTKtNlBcBiETcl93hGuN0aaMsQd1byHxsaqtIdjowMNivnOI+sUGeiaNQnfxJeeVTFaldl5WDs5Au8CpQNJTs8/M4PZiGkTVQxjcFr/5tPIlBIpZX2T/TMetI6BZw3/NKv/q048=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM7PR08MB5367.eurprd08.prod.outlook.com (2603:10a6:20b:dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 07:07:04 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 07:07:04 +0000
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
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Thread-Topic: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
Thread-Index: AQHXXtr4yj2ZFiynnEqJXnMpAugWBKsTqoYAgAEBowA=
Date:   Tue, 15 Jun 2021 07:07:03 +0000
Message-ID: <AM6PR08MB4376096643BA02A1AE2BA8F4F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com> <YMd5StgkBINLlb8E@alley>
In-Reply-To: <YMd5StgkBINLlb8E@alley>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 2DC21A78FD7EDB4ABB40625A5A316901.0
x-checkrecipientchecked: true
Authentication-Results-Original: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: da03d176-45d5-4387-e95f-08d92fcc32f8
x-ms-traffictypediagnostic: AM7PR08MB5367:|DB9PR08MB7116:
X-Microsoft-Antispam-PRVS: <DB9PR08MB71169828F2AAE7F931528FA6F7309@DB9PR08MB7116.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: BsqczMLda2QPYZYS3SuRXVdfHVZakzxRmniwPIIoKEFAb5D1o3wKf798ukuFvOqMg/ofJGdZU4pCW8b8pISKLjDrdy7LFuLE5qvfXCJNNME8kInD46c24ecVn2kAfjJbG7QnbZoNZZ8LW98g+KNpmtB7FpHgaHTc1DydNRlv+1Nac7Vymqkwyg/dt8QVwl5ZcM2mIqsFqFcAiKYb23yP/e3dJXtrkq1gIaWG3nVYLsGPy3bV2H/ssqKnHQ8rq2MwzrzcmzB2Ty342wCLDfRt0gCqt5doMCFfRrnHJyiAisl+ZaW38XRhvajOsQWlB/G54BHL1wYvIX8s4iDvu/zR3wJxCtAI7X87DI7wNuDp2H+Ntj+jorEXAvFv9VYwf3YmcPtFF3t+ITyW3Zj20sRsdfLTsIu6feSXZIW0acPDyVv+vSdam+JHwuVWlMYoMgDtFyGt3NUhBjFueG7eCSEwdoxvu2uqVQh6D7oc3q97N8L51+kGG4aCaH9bc3BEQWpvtf0cb30TH+t6F2JCPkUwxU1CeI/W8Vvg8Xj/GOX1a7PI/j+C+RZs4K1jLjcOilWYNzO7wMrIPum4N4hWAmfkH4URoJ/qAK2PNTgQdK/HOsc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(396003)(376002)(39850400004)(7416002)(76116006)(6506007)(86362001)(66946007)(9686003)(53546011)(316002)(55016002)(8936002)(186003)(52536014)(33656002)(54906003)(5660300002)(64756008)(71200400001)(66446008)(83380400001)(478600001)(122000001)(4326008)(6916009)(2906002)(66476007)(8676002)(26005)(66556008)(38100700002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kLRvvdNYoE9XxsaSYZA89T4YCOgfvFKvxtE7EPM6HSJSx60JU8tj2ChijNY1?=
 =?us-ascii?Q?wyjFp4A0O4Nh93wP24/Ef5Kl6sHZ5idxvPqGg2yvUhRWYSOIBKTZ0cMbBTXB?=
 =?us-ascii?Q?dmk++g4FRq7Dr973MGPZjCLSBhokcZqVd9Hlozuj6cL+Rx9J2/3TBAwUkgbZ?=
 =?us-ascii?Q?S5GiMKAr32jhC83u+uLQCl7rWlMuhvuSywv8+VbtUUcdRboz4PTSo6G+p4rT?=
 =?us-ascii?Q?A93qjAAVzHxTA0yhbsfKo89gmG37OhAt8KhnyJMxT/EOM+CQhhBBXp/v8evH?=
 =?us-ascii?Q?UGWrRxXq+Tuhm86SE+L/qcW5vZby+fFsCil3mYbloci1J+5VK9w9iHTSCEjq?=
 =?us-ascii?Q?5wMYJJ39ucp/F1+iMzjQ8LzP90PdJG1ARSKPWVNY98p8IMeS1HxJ9+t2C4zK?=
 =?us-ascii?Q?ZlHBHGwwe6RUxe4aJ5sIAeFek+QgZFTE/08n/GAh6h0nDkemm7eDkYC+wmOw?=
 =?us-ascii?Q?5+t0hym/zEqNZbNsjPeJP9uNN5OT2O3xDstFKb++5v18OvJI1tQidBiVGrAw?=
 =?us-ascii?Q?Bxk2PCD90JWdD/dbjcLn2t/34ApBEBQmdtDl6u5EF8DNxlu1fAc1wiMZcfT9?=
 =?us-ascii?Q?tYWayARnrHBTMQEx/C+rMZrE+MRJSajqHRSNPK5PiJcEG3j/gboaMHuj/0sA?=
 =?us-ascii?Q?y2TTXFfGIenc9peIh4/5bp8RE0QqMwyr5pWFeuF16SfTWr5rKygjX5JG24QO?=
 =?us-ascii?Q?JkzzjPcJOFUVIAZpNYi36J+HGnk91pzTZeasVIc12pBRd0vcq3dYg7f6XW8D?=
 =?us-ascii?Q?tmxLlbOMmgpglCleld7mSpQ6v20rK6996e6563lsQrvheJlrdUfcNXQYsk3S?=
 =?us-ascii?Q?Hwr4mok3nnRICJYGnQQx4BvbNxd0Xvk+e+jL96Ehp/aw1qlhr8+DZlFRWYun?=
 =?us-ascii?Q?PLVQnGD/oGjtwATV/242BIe1qFI1vdD4M4tkiJQ+EPMaHn2iTi3FPRCVwSMV?=
 =?us-ascii?Q?gqp3kaHZWawRx/wr2Ayw0d7VjCJLuQ58JiG+OBBnmN0s4FpPaB/v+00ov7ty?=
 =?us-ascii?Q?X9poRcxNLY+mzV8un2NLt6DRJT/VUYHtBdE/HX5n5S8M71VGaYW1Y42M2aJR?=
 =?us-ascii?Q?4z6NQ7b8SvGtx7M++GZOCYG8VbP+eVtxqdXb/qaYPlbpgzd/SZqsxTOTUB6O?=
 =?us-ascii?Q?RgbWSNVOuCo/ybKGTqqL5jKVROpHvfiYx28dof+/A86y9i9U+yvrP7TBfx4M?=
 =?us-ascii?Q?MagC6QXhBUVDO4KvfuatzTTM66AHSIsqfKQeMHM7RoCcNFHyhCCzWAmQqFKP?=
 =?us-ascii?Q?I485VGCmoy6bIhcstIsjBeJvCRkhkEFtOsffCIAEMQm/8q3hnbSzLCa1dJjI?=
 =?us-ascii?Q?ik0JJIoRufYarrwxGeMgzk4Q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5367
Original-Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 63eb9a8f-efc1-4aa9-861e-08d92fcc2e1e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0ouTffWdCpsF2DhNia6H2onVdI5L+hHGGWkXdmXRA/bYd8BmaTyr/Gb8qnwq5FQCzcaRAI/iWefusxVGV2cC6ehTh+WsHYwPzIdcG0Y8iQaPjvkr4TI2Wlruv1lZQoXNS2pI7iZNjxIbjdC8mqVEoVOhKY71v4c64idavDt82OWXDfF6qB6HF1Wipf4qhf/jmR9ySDjlQWGypKZjLglYMLuqZaACsk4/ZXvdbDLnDthkrhYi2isnEzv35nx6bWHw3HdXIw3OPa7Y6YvTkMiM2KTD9SFlo4iKvqYzyIY+a1h2D8ggmvcuP5ALQ93FSV/Azmn6GysywH/iYvZmHclnScqUKGbk+AHBXVZ8OT5waFZxb32g6xqNwHdD/Yn78xpFVjyngYoAOljzIglYQsSE6JogflepU8iCK6kFXAZh42CDdaMZRK9EH9/It/zyVSIx5KGs2Eu/WCRfBWBJPkb/ZRbNy+EcjQdoZDhn59A2mhMw6OQPWDPJLgGybp8CIud7w2z14RHFcZ2gYxNaL/MRApjgwt5PqnfVSH5N4CuT0CfSDJoLqp+EDsL77QrJ0hZE1Owize1fIj1I13fqq9Z7Udf0LqR2K58113xKIOEo7Vjd7uL7ni5LxLM1jS356zMOXC8BNsrx2rHMiayqKO+4H3+B+8y21RMBfAjH6tdUmk=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(356005)(6506007)(53546011)(81166007)(70206006)(52536014)(82310400003)(4326008)(478600001)(2906002)(336012)(33656002)(70586007)(450100002)(7696005)(26005)(54906003)(8936002)(47076005)(82740400003)(6862004)(83380400001)(36860700001)(55016002)(86362001)(9686003)(8676002)(186003)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 07:07:12.4513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da03d176-45d5-4387-e95f-08d92fcc32f8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7116
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Petr

> -----Original Message-----
> From: Petr Mladek <pmladek@suse.com>
> Sent: Monday, June 14, 2021 11:44 PM
> To: Justin He <Justin.He@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Jonathan Corbet <corbet@lwn.net>; Alexander
> Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
> foundation.org>; Peter Zijlstra (Intel) <peterz@infradead.org>; Eric
> Biggers <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>=
;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> fsdevel@vger.kernel.org
> Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
>
> On Fri 2021-06-11 23:59:53, Jia He wrote:
> > After the behaviour of specifier '%pD' is changed to print full path
> > of struct file, the related test cases are also updated.
> >
> > Given the string is prepended from the end of the buffer, the check
> > of "wrote beyond the nul-terminator" should be skipped.
> >
> > Signed-off-by: Jia He <justin.he@arm.com>
> > ---
> >  lib/test_printf.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/test_printf.c b/lib/test_printf.c
> > index ec0d5976bb69..3632bd6cf906 100644
> > --- a/lib/test_printf.c
> > +++ b/lib/test_printf.c
> > @@ -78,7 +80,7 @@ do_test(int bufsize, const char *expect, int elen,
> >             return 1;
> >     }
> >
> > -   if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE +
> PAD_SIZE - (written + 1))) {
> > +   if (!is_prepend_buf && memchr_inv(test_buffer + written + 1,
> FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
> >             pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the n=
ul-
> terminator\n",
> >                     bufsize, fmt);
> >             return 1;
> > @@ -496,6 +498,27 @@ dentry(void)
> >     test("  bravo/alfa|  bravo/alfa", "%12pd2|%*pd2", &test_dentry[2],
> 12, &test_dentry[2]);
> >  }
> >
> > +static struct vfsmount test_vfsmnt =3D {};
> > +
> > +static struct file test_file __initdata =3D {
> > +   .f_path =3D { .dentry =3D &test_dentry[2],
> > +               .mnt =3D &test_vfsmnt,
> > +   },
> > +};
> > +
> > +static void __init
> > +f_d_path(void)
> > +{
> > +   test("(null)", "%pD", NULL);
> > +   test("(efault)", "%pD", PTR_INVALID);
> > +
> > +   is_prepend_buf =3D true;
> > +   test("/bravo/alfa   |/bravo/alfa   ", "%-14pD|%*pD", &test_file, -1=
4,
> &test_file);
> > +   test("   /bravo/alfa|   /bravo/alfa", "%14pD|%*pD", &test_file, 14,
> &test_file);
> > +   test("   /bravo/alfa|/bravo/alfa   ", "%14pD|%-14pD", &test_file,
> &test_file);
>
> Please, add more test for scenarios when the path does not fit into
> the buffer or when there are no limitations, ...

Indeed, thanks


--
Cheers,
Justin (Jia He)



IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
