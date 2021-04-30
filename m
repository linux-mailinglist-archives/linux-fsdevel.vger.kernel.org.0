Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753B936F59D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 08:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhD3GOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 02:14:41 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:15101
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229482AbhD3GOk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xt+ciQo9MZmDdamzsWu5juJGzMa2KDa9gWWNOhPRfU=;
 b=28BXapyZjrFJU33mJw15wj+qzgdLOCZwVH+mI83TKexYmMOxgjVuY1d1n2/9P51FB41TP9b8B7VMPvb8oeDlKpFObskxNkOmw29DwLvHhdHlTELbaVz8zZVfVA1lMDu2BSQd1DNTsdIvALL3b+eBtI68ESdo/JTboWtpFSaLYgg=
Received: from AM5PR0602CA0023.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::33) by VI1PR08MB4414.eurprd08.prod.outlook.com
 (2603:10a6:803:f3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 06:13:49 +0000
Received: from AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:a3:cafe::d8) by AM5PR0602CA0023.outlook.office365.com
 (2603:10a6:203:a3::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Fri, 30 Apr 2021 06:13:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT019.mail.protection.outlook.com (10.152.16.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 06:13:48 +0000
Received: ("Tessian outbound aff50003470c:v91"); Fri, 30 Apr 2021 06:13:48 +0000
X-CR-MTA-TID: 64aa7808
Received: from 7733dd73b165.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B7634B1A-D1B8-40A8-921C-CF36BD2F7B22.1;
        Fri, 30 Apr 2021 06:13:42 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7733dd73b165.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 30 Apr 2021 06:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/xZQjUxxnnsoopVWjJ98z/pzsGpHMzWcwgEHfda9uBfq+WvM1xFK99Crr3OJqc0AQvG7E0wW1XYbSh5BkiB/lYjNvQJmZxiVhlMSeJ5kOygY/V6c1lVW9Da47g9BET2u8ZrhPywsFOmJYh136RGXP2zCrhq8FAjQxevTIQymKgd0n/Y33N4bOCINC0nWb8E6Lukt0xzxV7D4RH3OjSEng3VHI6JSShFAmVOuXTs+7mgWsSkbfW6NTH9wkL2T57/4xDG2tAaOEEhNK3EhB8bAgwqo+fxS/bk/pUDAsvsHjQHT56Gvy88qnlaBuBqhmPJ/Stfl2jKKIyLRfH+Jui6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xt+ciQo9MZmDdamzsWu5juJGzMa2KDa9gWWNOhPRfU=;
 b=U7wWTy3DzizGgssY3x11gJFMJFydPEirJkas9LIajg9TDGeCdaWC11wTI6UULUczDYkA4K1/m7sTDLC+gUfFjSSXYsfpBsvhRmPhhHt367b29BSqQ+SWHvqLGNRJB0YIy3aG44r30jeoNG1835saEfmxtPLjm8/9z8ulCPu5tJRQCyDM+8JrBmDgvQUafTJxpM5m8tG1f54q6QzN0HmoLR5fHOrqmcTnDgKwSoNMpyJPRzTBjm73ZIbFOP1jbnaD9bbFSww7cGXm+8IaJhXWoNOsNNJJcxMLviKvqgfV8D6yOjnZXQvIMHou7/EBgA2rAIIE+6dFeQAuOQPfRUriMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xt+ciQo9MZmDdamzsWu5juJGzMa2KDa9gWWNOhPRfU=;
 b=28BXapyZjrFJU33mJw15wj+qzgdLOCZwVH+mI83TKexYmMOxgjVuY1d1n2/9P51FB41TP9b8B7VMPvb8oeDlKpFObskxNkOmw29DwLvHhdHlTELbaVz8zZVfVA1lMDu2BSQd1DNTsdIvALL3b+eBtI68ESdo/JTboWtpFSaLYgg=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB2951.eurprd08.prod.outlook.com (2603:10a6:209:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 30 Apr
 2021 06:13:40 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::18c4:33fd:d055:fe60%3]) with mapi id 15.20.4065.027; Fri, 30 Apr 2021
 06:13:40 +0000
From:   Justin He <Justin.He@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: RE: [GIT PULL] iomap: new code for 5.13-rc1
Thread-Topic: [GIT PULL] iomap: new code for 5.13-rc1
Thread-Index: AQHXO51Cqf1NQAhE30CBg6xQ5yY+C6rIx96AgAACK4CAAKr1AIAABfQAgAAAxgCAAAleAIAABo8AgACaL4CAAOfgAIAAqT2AgACvAzCAAAKiAIAALCYw
Date:   Fri, 30 Apr 2021 06:13:40 +0000
Message-ID: <AM6PR08MB437611323F93C76F0D2703C6F75E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <CAHk-=wjrpinf=8gAjxyPoXT0jbK6-U3Urawiykh-zpxeo47Vhg@mail.gmail.com>
 <20210428061706.GC5084@lst.de>
 <CAHk-=whWnFu4wztnOtySjFVYXmBR4Mb2wxrp6OayZqnpKeQw0g@mail.gmail.com>
 <20210428064110.GA5883@lst.de>
 <CAHk-=wjeUhrznxM95ni4z+ynMqhgKGsJUDU8g0vrDLc+fDtYWg@mail.gmail.com>
 <1de23de2-12a9-2b13-3b86-9fe4102fdc0c@rasmusvillemoes.dk>
 <CAHk-=wimsMqGdzik187YWLb-ru+iktb4MYbMQG1rnZ81dXYFVg@mail.gmail.com>
 <26d06c27-4778-bf75-e39a-3b02cd22d0e3@rasmusvillemoes.dk>
 <CAHk-=whJmDjTLYLeF=Ax31vTOq4PHXKo6JUqm1mQNGZdy-6=3Q@mail.gmail.com>
 <AM6PR08MB43769965CAF732F1DEA4A37AF75E9@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <YIt3uKBQnlxHAo/Q@zeniv-ca.linux.org.uk>
In-Reply-To: <YIt3uKBQnlxHAo/Q@zeniv-ca.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 8B1AB2B3E2F57341AF14470D3E82197C.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 7db5d18c-e976-4c8d-331f-08d90b9f1e7b
x-ms-traffictypediagnostic: AM6PR08MB2951:|VI1PR08MB4414:
X-Microsoft-Antispam-PRVS: <VI1PR08MB44145FBC8C8A8B633B1B1D8AF75E9@VI1PR08MB4414.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:6108;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: H8S1cKKVWuG/86pT0GAkQxSMMY/wuM0FhKxuQjJcDjxtcTbn6JODHMRkBUU5OiV1el15MFe5+agoOCLrjgnVjKbqs3qq8OmvpVy4mKX0skhGV6CdRlOtkaf0wo0fwF3TTDcpYHFGWtSA8hY4zlVXRKVAclGCy/T+iAyNDS2OLZvY+JeBrEy1M35x20OywEfLe+MAFOkLpuW4X0Cp7CEXY19Pfro3BS44i3OmwrTxYcUS5nlrY8v5QVfnnrrYFgAAxz1Lek0pgsIajwDTs5Zz5B9LmEcj4MDXAxbF9XUNhbnDo3XXQfiK/Nr5F7jwN8kMPQ9L+4NDGndf6ocmHwNrukEohz5egu1WoXouejwe2+rRaj6zUdOs1lWXdnQqUO4ZExoGZ1svUuJpZ2XRYb5p55wH5GY03ZNwy7zZUMh0jNyiN45zShzL0OjokNt24u/zPYqNnXaM4P1zT2JbDPLig5CNghViS8L+uWs4TWnTqdG/p5aF4tfJCtTyfq/e/WDgu14RIOmZE4zcLz8053L+R9iVDSeJCgBC4vQ72+N1vHsdb//6BGrl3b/hAvaS+5sT2ghod6QF8pATbFfN71EtJNa2ve6incMquJfLQpoRw+E=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(71200400001)(6506007)(122000001)(55016002)(38100700002)(26005)(478600001)(4326008)(66946007)(86362001)(7696005)(186003)(2906002)(52536014)(83380400001)(6916009)(7416002)(316002)(8936002)(66556008)(66476007)(66446008)(9686003)(5660300002)(33656002)(53546011)(8676002)(54906003)(76116006)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IJPvIyVQMuo6lD0/0oQz1Ooju07CQPyV3RMvU1yiT8++jGW5wqeqixE/mKV7?=
 =?us-ascii?Q?heqhqNgqTvEKf+F9jgXy5zomN7XquRUj+juOOPGoShWnviy1iqbrLMavp/7K?=
 =?us-ascii?Q?kykX9Ad35rlUmm62uuoKqTzj6Gg479tFkS3iTPrzulBIafzCUylyn2aa48py?=
 =?us-ascii?Q?nuyQ+2R+8BD5l4WTgyseR2S8XP3hNtZU2hylLkah2sS61LG2i3KaxXhPqPCE?=
 =?us-ascii?Q?XWAHqtJF0WSBYVl4uPtp8NomQJUGfSjv2nLxBamWJV5y5uTXyOxHrvJGMwbH?=
 =?us-ascii?Q?ko2I8XjYbqWfk4mpk/cs4CRhk5cGc67eSoTDMb8ymu/SVqiSFcMAWO9xilvz?=
 =?us-ascii?Q?/mYewxcHvBClzmsmisGybV8YwQFDnNOjBg8yHOADDhmpA4WYJoufBMPor97S?=
 =?us-ascii?Q?ROEBi3nJwIKEISNJ66spW1XO2G7ExOcMc3cg/DdNn26bbp2QWBJqoqxh8Uh4?=
 =?us-ascii?Q?27C3kJA4N+meBPijEjA5tfNvqrJZrkf2kzD6NHDtgzQ/LHKUvHaFOEwV90TQ?=
 =?us-ascii?Q?dqzHEx140AK1rXzbYauXZMx1T4L7pH5gdciTVU/+S3I3EGQq5GC4ESHChkHY?=
 =?us-ascii?Q?vDIsv0GTOZYzuv8zKOf4+3nO8jLQdfvbm72KBUtG/WiEmiXGnznqOEKdXGkN?=
 =?us-ascii?Q?rwHiASkIhQSwsENOkOU41EL9lNy7znMc1BegwfGSzQN25WpCyag03WvAtwyA?=
 =?us-ascii?Q?2LOKuF6porGV4IxwZXW0J+/d+gBYi35qPjxNQREQSz5PgYQEKQNP3kTReTTH?=
 =?us-ascii?Q?a9BUNQOerdx2Sx+kPcA2cErYFbJ9qk8pTvsjXAc0tecDI0LGdwWHlBZE4/Ec?=
 =?us-ascii?Q?xAdU9bhGUbQ/OHbYgryHg3h1gzND+1XAdR+AUdP0P9X9z3N7vK6mmiRKxIjs?=
 =?us-ascii?Q?K5+24t62Jun6HQGlQ3Wz72h92L5PQ7TsBATpOejCRvBr6gh1fSTZMIR/RXLy?=
 =?us-ascii?Q?40gBORkiC/9/wlJXd7A6qNav0Kr+fGk/WdSlh8D9nL2ro1i4DZX9QARjDm41?=
 =?us-ascii?Q?Kj2Dp7uBN4p0PBFk9FSjZobyUSl9KRtp21FuIKyHG0m8oBZc/lHgtkpEP8l4?=
 =?us-ascii?Q?bqVPa3tSUlRAjVLEB8AF0Vf5NlqMEMo96jjyDjHBzBZSlc+oxTwByVYkyf1T?=
 =?us-ascii?Q?iiHVNbiXXgsGqdHM8lddnnT5twF1yV+CYkvqb5GcQzeY7r5xa9VGh+ZZNMgn?=
 =?us-ascii?Q?AtrYPULBiQmh1BpLpoJXFXxG9Eesuyx3ho5Rz5Tzda71mFiW6xr2YQjLNULm?=
 =?us-ascii?Q?avs9ouqfXB6lbUPDuyLcRAVKnDM+HfGlK3lJffSKcdFSFvckFOsjNAcgFoVB?=
 =?us-ascii?Q?LfdPEH+L9rbIslZkNFP4JBUV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB2951
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5d6654d8-44ad-4277-bfa1-08d90b9f197c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +lYsLxneRo4KIiBHN2pgxozuvYwDzXAVlNSD2In4Wguqukw8hvjbpnC3WZH6wKF6qToVIk5BSOG3YO8VqLYyIYa9H1GKZ5EBryctv0mWfEL6FbcSq+5kyhZAIMmhNfJp26lT5fmzbI645scTJ7Cs+9/0Vv4OBrzRUuYFhWYPrNFcq7hoS5wVepIxkni8eNRI9irYXm/hl0pbhSloqedFQyxYllb863bTE4J31B4k7Cprsk6upmIjV4+OsbDgiQuPucdpt4HeiZ6bF/zFzFFKQn4Nt1IiScSb3W/zzf4kADL+6P/fz3pEw24V8Mo1qTSED/pxEnWmUapHqLZs8d8aU6clrsIlawscXMOjeLj4IuaYfmOdhewnBc0nev0vUYImJcPQvPomm9MakmQyq3Eo3SklwmqAamsjFr9TJmI+6SJ5gYatymcOnlaN0Snuk6gSxvkVTP7WO5E2tvUD9ZJBwowvZzchjys3iA1pH2qXN1zQyqN1TjsPWugy42dRA4X0nFMXDyc2qIE57aUiJA4KM5F3LEI1P2UE9wJjmnoFYaF2GHcBuONs59mPSF7waAumHUkQ9IBxGCJydj0wcV8JRXZBTCjZlVHrQo0yIKZA+sxMR9N00jJmE3vka5SFwsnSaeil5gKZiFqWeJHx+/3dklv6NjoFoT/jcxuork1wEzg4SkT2iYcPiB+NthOzyX0e
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(26005)(8676002)(316002)(478600001)(8936002)(4326008)(450100002)(336012)(34020700004)(47076005)(70206006)(70586007)(5660300002)(9686003)(82310400003)(186003)(356005)(82740400003)(107886003)(81166007)(53546011)(6506007)(83380400001)(55016002)(86362001)(52536014)(33656002)(2906002)(36860700001)(7696005)(54906003)(6862004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 06:13:48.7692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db5d18c-e976-4c8d-331f-08d90b9f1e7b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4414
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al Viro

> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Friday, April 30, 2021 11:21 AM
> To: Justin He <Justin.He@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Christoph Hellwig <hch@lst.de>; Darrick J. Wo=
ng
> <djwong@kernel.org>; linux-fsdevel <linux-fsdevel@vger.kernel.org>; linux=
-
> xfs <linux-xfs@vger.kernel.org>; Dave Chinner <david@fromorbit.com>; Linu=
x
> Kernel Mailing List <linux-kernel@vger.kernel.org>; Eric Sandeen
> <sandeen@sandeen.net>; Andy Shevchenko <andy.shevchenko@gmail.com>
> Subject: Re: [GIT PULL] iomap: new code for 5.13-rc1
>
> On Fri, Apr 30, 2021 at 03:17:02AM +0000, Justin He wrote:
>
> > Is it a good idea to introduce a new d_path_nolock() for
> file_dentry_name()?
> > In d_path_nolock(), if it detects that there is conflicts with mount_lo=
ck
> > or rename_lock, then returned NULL as a name of that vfsmount?
>
> Just what does vfsmount have to do with rename_lock?  And what's the poin=
t
> of the entire mess, anyway?

Sorry, do you suggest not considering rename_lock/mount_lock at all for fil=
e_dentry_name()?

--
Cheers,
Justin (Jia He)


IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
