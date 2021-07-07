Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0A13BE415
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 10:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhGGIGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 04:06:03 -0400
Received: from mail-am6eur05on2053.outbound.protection.outlook.com ([40.107.22.53]:17121
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230438AbhGGIGC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 04:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcYC5cBym5GQkUNaVALgfEj6BV5bjesBqeRoKeYfkyE=;
 b=8GzA3vdFU9F9fuR80DRY3+7zfqrQ5Ft5txzKgRXJ1yuSxxAwlGzpztCqnxWdKTpY2uxrF6M9umjU4UeSvYYl1iUJhVCXuYEquzErkL5E6LVOS3Im3XwAdqWrKi35Ly3Msetvap+TnnyF+DGd966wfcV8ePDa7iwj3yoV7e8Df34=
Received: from AM9P192CA0005.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::10)
 by DB6PR08MB2789.eurprd08.prod.outlook.com (2603:10a6:6:20::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 08:03:18 +0000
Received: from VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:21d:cafe::44) by AM9P192CA0005.outlook.office365.com
 (2603:10a6:20b:21d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 7 Jul 2021 08:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT062.mail.protection.outlook.com (10.152.18.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 08:03:18 +0000
Received: ("Tessian outbound 71a9bd19c2b9:v97"); Wed, 07 Jul 2021 08:03:17 +0000
X-CR-MTA-TID: 64aa7808
Received: from d79dbf58031a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D7BEA32E-B19F-4C9C-8A87-3F85D5472BD6.1;
        Wed, 07 Jul 2021 08:03:11 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d79dbf58031a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Jul 2021 08:03:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ND3k/CATt/TX+cGbPOSzVv54Wlv500MCWqwUawfbxZGexgGNQGdDsoYx+jifVl6gsRlslMyaY0UhMkzftZ5yyTeWUyMmyEEPNDXWQ9GnHf467k3DwCsgdNd3uprGzoZPvnEaA9h+QGwcC5GgcfO6Pcf3stYCFvAQPL8pNQBN3CAuqxY32b1W6WWRQc3EG4gPkySm0UnuO+bB7nuW2+MkjN0Qe9hGw3gMgwG7jKcrQ0jfyXTIAivySWlkXZO93/SjhNcWiKs3r2Htnl/GhOpFgFSz/J+cJVbdQvFDEGFfnmxhYeHoWhWBl3dJvrIp9m2EiTZ1kEmcvFscCRgnkA9xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcYC5cBym5GQkUNaVALgfEj6BV5bjesBqeRoKeYfkyE=;
 b=MrnrRFQxKPTXGF7vSh3D+lLVQdxoDOcynV4OkwPY+17QURQv5rH8Q8V6er0wKEUolTKPXC9h058ld1r4W7fGSS07+E3IHjIYoxGX5eSi9DEmNfwrJWX+KJJGvYVWtJCAQuF1HE4Cd3xK3Wa0lz4loitrggqadlwORBkg7jri+qoieG6/+Ye0p/z2RU4Dg28x5Dk4hnZH+bJFHM7mYEFlpPDvwY4IOcgXDBrFPjCpf8woGcPDS3lZ4hg/Wvxv1clNu640ehUil5wPmfqMRVYOL7LVLgcMKjPHFqQSx4TZEPqG5SaW+ct8TeA5WSFXkUM0+8PxssOSi+kqDecgEM5gnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcYC5cBym5GQkUNaVALgfEj6BV5bjesBqeRoKeYfkyE=;
 b=8GzA3vdFU9F9fuR80DRY3+7zfqrQ5Ft5txzKgRXJ1yuSxxAwlGzpztCqnxWdKTpY2uxrF6M9umjU4UeSvYYl1iUJhVCXuYEquzErkL5E6LVOS3Im3XwAdqWrKi35Ly3Msetvap+TnnyF+DGd966wfcV8ePDa7iwj3yoV7e8Df34=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4820.eurprd08.prod.outlook.com (2603:10a6:20b:d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 7 Jul
 2021 08:03:08 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3452:c711:d09a:d8a1%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 08:03:08 +0000
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
Subject: RE: [PATCH 14/14] getcwd(2): clean up error handling
Thread-Topic: [PATCH 14/14] getcwd(2): clean up error handling
Thread-Index: AQHXTEjJAj7h27rt3Eik//EOepGs96s3dFYw
Date:   Wed, 7 Jul 2021 08:03:08 +0000
Message-ID: <AM6PR08MB437677A0DE106C4A241BDA1CF71A9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <YKRfI29BBnC255Vp@zeniv-ca.linux.org.uk>
 <20210519004901.3829541-1-viro@zeniv.linux.org.uk>
 <20210519004901.3829541-14-viro@zeniv.linux.org.uk>
In-Reply-To: <20210519004901.3829541-14-viro@zeniv.linux.org.uk>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 0731D9DE48A4654DA8C4366DA349AA2C.0
x-checkrecipientchecked: true
Authentication-Results-Original: zeniv.linux.org.uk; dkim=none (message not
 signed) header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=arm.com;
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 11eb6ecb-bdc2-4a08-0896-08d9411dae86
x-ms-traffictypediagnostic: AM6PR08MB4820:|DB6PR08MB2789:
X-Microsoft-Antispam-PRVS: <DB6PR08MB27890E745363C21803F85C3CF71A9@DB6PR08MB2789.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:147;OLM:147;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: R+FJzWEo7LiwIfj6yCRVlA1PseFz39+lP6QYFOgIzSvzA6BVAnmOdAWV9wSaRUgIEnBwnH4/4Vr3TlBvWsJFIZ7EUX/4fa8CCIeySwm1L8QPv1+nPS4yY8PnsSfGhMcPQtjgti99rqHWz5Hztx2JN+pUN9+9vF8wsy9eY0/OKy8KR6dKz683oTW9ULxB4g6FeeHw5eaCmK0amYNi8O498SIfzyVEXbYq4AxQrJp5CTdRPMPZAbz52r8tsh9TWlw8XyHHMMokTjHdJH6i2VhjAoxEDK/viNp2QKNPqb0by2oMp/N+RWOAhea0GKsR4DK+B9C9WR9SRm1y10JyULEwKwt51SwIuwNm4RcxV0s8fDf90gWa50KPC8Z2Z1Y52I92Q39lNKOc1VtmGhsuKonTERY2zMfDgT6IcBShDeMzD8GSI6aag9cUZuhjXo+BPYXl771CrVbadlcw2jyvTdEcd1w19Qcu09xmzw7ALoz+buwDKwcwOtxnRSz2KXzXNrViy/b0DCw+JBS9/SOnMEW8KekO45jYQFYD7VD1NkoOy6LInsZk0SytiyV3xG02kKeZ4Yl/DpSvTF7VmcFmfxEWJn3aDJUsBVJAKkfBbg/4VJaxoN57gsVGBEMX8dP/2zBnD90c5C28Bs8ycrx/L84K8w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(2906002)(86362001)(5660300002)(8936002)(9686003)(4744005)(26005)(110136005)(478600001)(83380400001)(54906003)(316002)(76116006)(33656002)(8676002)(122000001)(66476007)(7696005)(38100700002)(64756008)(55016002)(66946007)(6506007)(186003)(71200400001)(7416002)(66446008)(52536014)(4326008)(66556008)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: F9gSbP5nwaOQni4b9r71VsQWdFEwK6zGvTe6/fuMHYzRfaAFcFHsfPQK4QnnaRG2xzJomZzJd/vPcdBPVqPcXxGOAecnUuYVJtqELRPLLhfKq3uzo4Av6/iGSigpXV7XcYNx2xETcbWmYAzt+mjlEps+udL+PARDc8OtKpQWI3Jx0aQ6Id/CmU0TbdgjIQ/vTbxAO3LnDpZfdWFDTYkGLXZMvVGfWHArKKLB9v5XIzJmMN4mtNSuI35KkK0yJS771dBfHXx25/KkoglnHc1VhCOz9ZA2UU23mZtBDfgtPUP2EIs5E+zuFWVxqYXmK7kn9LmZSwNFCDeTn6dr81ulBhd0nmVkCBMaitUSI9TPEoSKcGCEG/YNtpNditggzfU6SChAdBVKaFs/ZiA1Djm1BNrYzGczRGu3e+DRdviwHrypHSwTaEReqFcUt+IwcjVPSgC18PBH8qYQYk3NIveqI6yYiArOJtKnwoPjmNrRSfrjop9XfJsIc6ZkldgQmUBR57/4u4hKOiB09REf9hHC/S5YlgWJaUUOE10CBM+3wz6XhydfL9kCeoLxM9pSfjE8M6kjxbL6lJZNnxdU5X8re9q9fFpaEoXeknxbKXTyPWArkx5vCQnO7PbnwCepVPrzzksdyqb84zEsjBAuR6PIaSztGVSdEFx/H5iHfxyONexdxY00uwtjF1tN2RnCMhlnYMpvr8DPNCKDT5GytlOlm0zJudtCTKKwf3KQq7ecECk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4820
Original-Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 089c6d87-7bba-4608-0184-08d9411da888
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdpQh/zZkOzbLOXk0uos3NBF5umbvwRhefwf4dBKd1LVEFzQ0l2dH5VoAMVW0+S5S7UL9RvslMoAw21tnjvFU2RkojqLO5qtZgqSv6r1kB1ekF+SLynXpPOfY38WS0ABT7bj1+swOBrs5utVko8d8+Rm+scMSyacJPhDPj+goMIxiD2374KRd12CjHL5Wq35LpI0MqgleWy5cwHygLBc5xsYcuemxZe+vF+Ha8ckNGAhKQqzPhf80jHtHhiJogQR2BtULhuEyJy910ToP5V6JO3ZIkrooN1bXWw2phqKWfCKnj4kutCP8FjD5vcHpGGzckZj7D8aooi5mx1zZAunPIxrcJj4ZMvRgwohwdIX5WYHRFFlW3YOcTpeswQh47b7r2034c4xv88MQNMHa+1d83nwLVkVYOzl4VvSjUysRfL1q7VFTLTS3DtXx+swaqpfpXZyOPTL6Ds1b61RXjRcbUnT4THfmtenSXP5o3+rlGSgH312ehKkpeF8lXkNd01M97xPpm2EF7w6Bki3D/aEsWBVwJUt9K2tGwz/QQgDl/Kd6n1cgo1t633w8T2z4GWeQuPH8QtvYjJs02yM/5ImJq1SBGI2bNvUEhaV+tN3128eQJ98VpHx8OWUGyu4MlkSoCi+YmfiuR3SdiJeRbBSxaq+tfIsOmH3z8GF+mrxZM0n0qwGLsbXbTnSPKyW72uF6H+1iQzuGSnsRoutYdSzMA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(136003)(396003)(376002)(46966006)(36840700001)(478600001)(110136005)(26005)(336012)(55016002)(7696005)(186003)(4326008)(47076005)(83380400001)(9686003)(54906003)(33656002)(8676002)(82740400003)(8936002)(5660300002)(316002)(53546011)(356005)(36860700001)(70586007)(70206006)(82310400003)(86362001)(52536014)(81166007)(2906002)(450100002)(6506007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 08:03:18.5243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eb6ecb-bdc2-4a08-0896-08d9411dae86
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2789
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> -----Original Message-----
> From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
> Sent: Wednesday, May 19, 2021 8:49 AM
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
> Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
> <senozhatsky@chromium.org>; Andy Shevchenko
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
> Subject: [PATCH 14/14] getcwd(2): clean up error handling
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Jia He <justin.he@arm.com>

--
Cheers,
Justin (Jia He)
