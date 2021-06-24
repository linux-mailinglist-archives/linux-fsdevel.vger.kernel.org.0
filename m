Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4B3B26FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jun 2021 07:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhFXFvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 01:51:07 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:44779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229448AbhFXFvG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGf7vuc/13KjO9rvaABKyL0MXeLBbzogwbX3+bEmDTo=;
 b=LKPQE+1a1KjzhPo4FsOVPI2SQEfNKQ5zRdcrqZfP0zL6NLNk5euaN9GeDBrBWodQZToRBPsJ/efYJ63SACZunY3vQuMm52swAp68LW+y8u5P0iILlsScTVSERe3DgP42VuMu1Jvkzd7qH8eEh3o6FsWv6jhji/1b0758k1RyzO4=
Received: from AM6P193CA0079.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::20)
 by AM6PR08MB3511.eurprd08.prod.outlook.com (2603:10a6:20b:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 24 Jun
 2021 05:48:43 +0000
Received: from VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::2d) by AM6P193CA0079.outlook.office365.com
 (2603:10a6:209:88::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Thu, 24 Jun 2021 05:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT059.mail.protection.outlook.com (10.152.19.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 05:48:43 +0000
Received: ("Tessian outbound f88ae75fbd47:v96"); Thu, 24 Jun 2021 05:48:42 +0000
X-CR-MTA-TID: 64aa7808
Received: from 8a8ab8cecc87.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 68A585B4-376A-4AAB-B345-C10271672674.1;
        Thu, 24 Jun 2021 05:48:35 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8a8ab8cecc87.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Jun 2021 05:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O3EpgHppdFbASVX+wbPIdSEvts7UVd6gJg1jHxjUtah5i/I5HP/S2fnP/ddfdexHQeM/TeuF07t02jKkmb/307j5Ygg+5qovqO0I6MXpmiFjQoYhsTLIa4i6hyVj0Yt6pXIuA1F5TLPioxHFKCQWv/ALeaOLJQKXjUpqHKEB/5XhImBO8zLYiA160BRUwxquBu71bjCvqxLd/MQrXpdstJ/cBnMttigFGExQk8Vq2xvkMhBkWWcpcYvI0ykzESE7FGEfg4QWfWdCJVp/L8WfCmwbJVL68rhW7bpODRjz3ksMs3F7yRvA1UB78wpHKRGAupRpn8yW+rSIuxtCgy6Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGf7vuc/13KjO9rvaABKyL0MXeLBbzogwbX3+bEmDTo=;
 b=dYII2K/kXquDSRrkZcvzFEuRZhTSYb1GoL7p2l4DHtUqLkcMTsOFp1okto6SS/hmkOvb73Nqm99CazgflgSkDyOS2q0C3J4aIcJCZGJRpNahTACAgO/RXMplR8SD5dJVZ2WRgwIBnwTmCzsyT1MPyK3RPb3k6dxgA5VPXZncRuubANca0sHgWef+O+3NiladCCV+ry4s9TW4jlAt3RZmQGgBLy0ddjPtH/DhnAGS78bzTwZVpvRXDE66m+SF/nw75pEIjWQO8FvHGvMoQb42gipOstAc2qxL/J1M0Pzp77YauSELBnwJC6myfnMY6/2jI5CfX1DTJ4fIZ8j7J0jlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGf7vuc/13KjO9rvaABKyL0MXeLBbzogwbX3+bEmDTo=;
 b=LKPQE+1a1KjzhPo4FsOVPI2SQEfNKQ5zRdcrqZfP0zL6NLNk5euaN9GeDBrBWodQZToRBPsJ/efYJ63SACZunY3vQuMm52swAp68LW+y8u5P0iILlsScTVSERe3DgP42VuMu1Jvkzd7qH8eEh3o6FsWv6jhji/1b0758k1RyzO4=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4616.eurprd08.prod.outlook.com (2603:10a6:20b:6f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 24 Jun
 2021 05:48:33 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 05:48:33 +0000
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
Thread-Index: AQHXZ/O2Q2C8pppNxUmz5hfVzQksAKshT1uAgAFX4HA=
Date:   Thu, 24 Jun 2021 05:48:32 +0000
Message-ID: <AM6PR08MB4376C83428D8D5F61C0BF3F2F7079@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20210623055011.22916-1-justin.he@arm.com>
 <20210623055011.22916-2-justin.he@arm.com>
 <YNL6jcrN42YjDWpB@smile.fi.intel.com>
In-Reply-To: <YNL6jcrN42YjDWpB@smile.fi.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: BADE444C8BDC4443BC77793284F21392.0
x-checkrecipientchecked: true
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: cedc95fe-60ef-4c77-d2b6-08d936d3b9d6
x-ms-traffictypediagnostic: AM6PR08MB4616:|AM6PR08MB3511:
X-Microsoft-Antispam-PRVS: <AM6PR08MB3511B5BC179793635257DE2FF7079@AM6PR08MB3511.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 20GW/LGBYI4tZtG5WoAkGSK/tg+Y/p44pwlg2C6JruYA1DT5qMUJ1k/ppwFkgR8vZpGw41uoskDWMn1p+otWwvvOJFP2DY6t40t3PfQMR0x7eGoBu+JuCpc4vkKSfBbEwJxg2EnlfByhzr7KuTR0NX9fq1kOTe8Nu4AC+GNEjMdZK8cuVWuuXGEdAmHeAQ1pthh/cz2wax0m0jc3WtQx+0UoUt+cMc8nS64x9XbhI/hfgBdA4BEuYwi+Ef4OR9I6zVJuy95MibPj/MVN5qQpzSBFGGFPxjeTTHhA356GGbUiDkvQnJlB99lQ6wZqqj7f9S/Pe+LRlCYGnlEKDmKWAF0xLfg5OOBUXbx92nfou6qEe90Don1qcMr+GsrirSeHoGsNnbTpumZtfutFfYKZ02qsMYfsGzmT6NBa4kYfqckQF9ki4djuEVSnq9tHGmng2Noj1pSE1bK0XFjp0hoVKra7RpxUSXnsUD13/yN/3+zIPP6wWssk7iXwE+fCW2dDzysOfbgReEsB70TAVcMuddVmV13UTLDAyeqs6b5Y3JRwMirt1X1OtSqtiK2MrBkORqlsQbbJV052MwxkG0r+Y+RkqTjYVKXs8U7bFQ4Cgbc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(9686003)(86362001)(478600001)(316002)(6916009)(5660300002)(7696005)(8676002)(52536014)(4326008)(122000001)(33656002)(38100700002)(186003)(53546011)(83380400001)(66946007)(6506007)(54906003)(26005)(66446008)(66476007)(66556008)(64756008)(7416002)(55016002)(8936002)(71200400001)(2906002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BmuE7T7TP000iI9BgNwksoZYWbOjHoFAspFx4tb40/6515Nx/v4zLlFX042v?=
 =?us-ascii?Q?wEjuBGuYul2LAU3AJsuD5HJifkipTPNb/3CEyT4e89zA2XfkScYSpmGq869u?=
 =?us-ascii?Q?J2mvjgERt+GS5boGIkMaDoJYGKxkMRRrD6qa8/Q4+gb8gszVl4uUFn/uMa82?=
 =?us-ascii?Q?fA6IDNRvcnYBC4iADYucnkaSzjZ1uBy8r3q9eRKfDnqHqzo+fba1lQ8SBJU2?=
 =?us-ascii?Q?XTfs9JGcHozUR/9tRMm19MPOJIvu9uGexXKVLwYWOBgzZulcE05mfq8Xl//C?=
 =?us-ascii?Q?+OUJ8uXkeGQ+K+6wFLhCXkZYQ86AL8ZudD40vLtX9/of3ov4OWJpmz5bfBfu?=
 =?us-ascii?Q?bfoElNFtk730uVYNarBrymHbs7FLotNNyE4jqv4iCS0Xz984JSHK/a1LiF5m?=
 =?us-ascii?Q?tr8vGRRfXr5/LP4I9UEc9BMGZnE9Tz7WCrQPUwp8PKVUJQvXmaNtEyqh8R5l?=
 =?us-ascii?Q?csxUvcT3/THRoAapTIngNrKpWIx4V1FbCao5bPXl/4A1sjFbdrM4cTIo/Oh0?=
 =?us-ascii?Q?36mug+ocDpEYbmVcDEcHRuE+uNWgFezce+WcKaI2sqpJE29LuhI+iQaXlhzF?=
 =?us-ascii?Q?aNmD5jXSwIh3YDQBj67tPFIU824HnVEfXi/PuyhRoQ0MpFkjzHQDGBBXlJcf?=
 =?us-ascii?Q?2Z4ZXOHKQqd0wcjd6Fr/qHXpopmDuFZoDoYZib7pohChHDXRkC7WZmVbSL2l?=
 =?us-ascii?Q?+zHqYP/sIE8pQsG8dthg+IoU0tMvpa6Z0msMVgCrWh1Nf6QyK44pkxnouxdI?=
 =?us-ascii?Q?1cjQ3GHSMK8SB3K2CrnV8mwl5QUjComQJX926qizrSrYw993a53Tz+jri8st?=
 =?us-ascii?Q?cCQBcmMLMonHhPYn9Ui0WSft+BW/nQPEjaCS7R9lpm+IFova5rLNtov5dVlT?=
 =?us-ascii?Q?ngZ9oPwVgdUr1v7roeuvwfSNmkVDtT01juWcIlG5iydRjX4MRX2js6h5s9mj?=
 =?us-ascii?Q?wiSt0xJmKuobixmeEwgZZS1B8LHpIG+7+9iEGUB0X8+KQEYa/boc8LiFKP+Y?=
 =?us-ascii?Q?i4utsGXVvpKNs5Ri2j+MuGw61o8DW14i6DpSiUThk3zxSRr5mX7QuNZNu7oS?=
 =?us-ascii?Q?26lm/5vY8z3J/SNUDla8DBSqcXhCwZwT1Rh7dp0cmYGQISoBLkqx9jSRtAOu?=
 =?us-ascii?Q?xlY5DZT/HFc7FscdS3naA7ioI/x7qNsBAFyG1hUZh6aDTG0QXP76TKfBgYTP?=
 =?us-ascii?Q?U+hOwgA02d7Yh+15crl6EtF9ocT3ltynlZ22wVDQG5AbYZUngeIpaKlJcs2p?=
 =?us-ascii?Q?IEs83djRNX7e3Xyk1uUfnNMZkgx/i8LguGp25IqxWx112I53+cSbX53BrjEV?=
 =?us-ascii?Q?koEbnZukCtbWe1ZeR/ZkLKzA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4616
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 87c7069a-6511-4c60-4f9e-08d936d3b3bc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7Ey0wGZXU/VU8SDjomfwXPNZ9SaMfUay340rSIxYFXjhkLoiEkdyktEJQM4UTQq4PEBUK2iEgmgYcILmSxV63kK4Q9WjNIrdEtq0GyfhZ0rlcuPwUIo38LUOGW3oSr/M5OVkN1LA6BHmhAJHnneH3Q1UiVWcSUIF0uU8Au07jA8Pmn4YvrEDVSxn0qc6/gdezfCbwyhDfDqMvusVMIHMmZKN1uO47RX4NGgIOyuiClzKgg1RM4n0wHM7m09b2fOCy9sCOO7mMhcZ5/J4EY6Xj7rYpgT+dccBYT4JaPNCIMnt3y/ltQ/cx+zTocie81RKS1lfWJegGkMHwp+fMXJl5DE961i7L2IztBI3GI44lUHLJjIQksfSN5DWAccTpjvuQdr7x4qkI6NTFwqoyAix3IgWJ4N7T6oFh0C7j33yC4LeN9bqMM0cOHoBBBlZQ+10H/fV1gcZLjKHsdDQPspcfJFiasyyoZFagv3TCmYjJt+TYIZXgHYRFcBwwAcE+MmGDy+b8NyJXqw8H05IvYUhBBqtmvm4SeODB55VNp9yPlT4Dzfu2HDY0bob403trru525lRD+9UhjAZPTUxcotroY8kZwb7AXgdHHkjSuinVOLb/idhU0Y7v15fRVfq0zb6w8mcI6AAMespubrieCAFCMOFhm4d6rSrHCFBWicdE4=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(186003)(54906003)(450100002)(52536014)(47076005)(86362001)(82740400003)(82310400003)(2906002)(316002)(70586007)(70206006)(8936002)(4326008)(8676002)(5660300002)(55016002)(478600001)(53546011)(336012)(81166007)(356005)(33656002)(9686003)(6506007)(83380400001)(26005)(7696005)(6862004)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 05:48:43.1539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cedc95fe-60ef-4c77-d2b6-08d936d3b9d6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3511
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andy

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Wednesday, June 23, 2021 5:11 PM
> To: Justin He <Justin.He@arm.com>
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
> Subject: Re: [PATCH v2 1/4] fs: introduce helper d_path_unsafe()
>=20
> On Wed, Jun 23, 2021 at 01:50:08PM +0800, Jia He wrote:
> > This helper is similar to d_path() except that it doesn't take any
> > seqlock/spinlock. It is typical for debugging purposes. Besides,
> > an additional return value *prenpend_len* is used to get the full
> > path length of the dentry, ingoring the tail '\0'.
> > the full path length =3D end - buf - prepend_length - 1.
> >
> > Previously it will skip the prepend_name() loop at once in
> > __prepen_path() when the buffer length is not enough or even negative.
> > prepend_name_with_len() will get the full length of dentry name
> > together with the parent recursively regardless of the buffer length.
>=20
> ...
>=20
> >  /**
> >   * prepend_name - prepend a pathname in front of current buffer pointe=
r
> > - * @buffer: buffer pointer
> > - * @buflen: allocated length of the buffer
> > - * @name:   name string and length qstr structure
> > + * @p: prepend buffer which contains buffer pointer and allocated leng=
th
> > + * @name: name string and length qstr structure
> >   *
> >   * With RCU path tracing, it may race with d_move(). Use READ_ONCE() t=
o
> >   * make sure that either the old or the new name pointer and length ar=
e
>=20
> This should be separate patch. You are sending new version too fast...
> Instead of speeding up it will slow down the review process.

Okay, sorry about sending the new version too fast.
I will slow it down and check carefully before sending out.
>=20
> ...
>=20
> > +	const char *dname =3D smp_load_acquire(&name->name); /* ^^^ */
>=20
> I have commented on the comment here. What does it mean for mere reader?
>=20

Do you suggest making the comment "/* ^^^ */" more clear?
It is detailed already in prepend_name_with_len()'s comments:
> * Load acquire is needed to make sure that we see that terminating NUL,
> * which is similar to prepend_name().

Or do you suggest removing the smp_load_acquire()?

> > +	int dlen =3D READ_ONCE(name->len);
> > +	char *s;
> > +	int last_len =3D p->len;
>=20
> Reversed xmas tree order, please.
>=20
> The rule of thumb is when you have gotten a comment against a piece of co=
de,
> try to fix all similar places at once.

Sorry, I misunderstood it, will change it with reverse xmas tree order.

--
Cheers,
Justin (Jia He)


