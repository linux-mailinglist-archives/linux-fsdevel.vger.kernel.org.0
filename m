Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0B3305D25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313535AbhAZWgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:11 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:52274 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392704AbhAZTIM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:08:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611688089; x=1643224089;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3VIF5GycHJbQS269YSfpSXNQAjp30pAOxeNTLZ5FMZk=;
  b=ms22T4w7bu4h1mWZZcQby8+GL/Ii0MxKUEKKuEuZftRUiSJA4lpD9m1R
   nG1zVGp6S+JPuBejc0oDmzyniVbVwVjURFMFvpqsQYK2cdgYOpd5N/inE
   mke8jDEeN+WfFVtxbwDm+sVgXWJmenPDUlO2Fwui6bT/XIUCQ5hqscT1A
   xaqUmvMbV/ZewTCP7Mx0wcfJE2XhqHxwLrnCijLVDixlwfwM7D84+MA1s
   qt5gGQdl9YPSymr3eVJnt9VnOEblkE9v7+LZoOrCQk8kwpqGvJfV8hp9K
   QcgIser/lGQF2YBkuANiG7T0Yhyh0vwfTADyxQujpAL2S+ZZCvX0rx+Yt
   A==;
IronPort-SDR: WfECXPTZrihgDei06/vGXXmZpLSRbt2S95+EyMkkSgCbWTLqScwy33VYmjqKYjamKVJn0ZBEqm
 6QBp8tz0q+I1M1Bceuy/vf4wMtlUjqQp5JtyYUhR7eOFgySXJqASAnPKOJZZLLq/mDuKM6KyDk
 WYDlZT8/D+09Sx54kk2qcAqG2peu6UvBfF1DFpSF4HbineKFc7G416yFz7z6DHcPhJ0lyYvFof
 7q2tUKuhB+J8TufPhTA1CSjQD4jutE7dY2Kn7yDIiM4WI9ThQA5e+s1pyUwazenDBZMOokzYh4
 qic=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="158380189"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 03:06:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDpIllrIIZNPJqc+4Oi7blRYwervGjGpk2Ouf+y6dvEVhkWT54hKIggA/QSkvKLcmX41ojmJet5BS+rHaJ1c30VHtEj2UlXMvQjN+FxLIhA2rVCsJeb26VKrSSbMA8Z+5r1rFhci23x0np4NOpIiiX0Iwi2mefy/g8SiZ2xLjUaaLE/XlTVM1ZX6ok0293bpAu5Ri3WAMSyQ8cbaiJjBP+mZmC4gpy0zY+lSztbD4EvyZbPnPr/BamhM8kM3oAoConqnX6c4yLL5ep79INIAXaRQUgrXf8LXmoKaZiyY2YHxu8lxjXdY3S9XuIEWy6Ti5MAUFxAgORzsBmVOEQuECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VIF5GycHJbQS269YSfpSXNQAjp30pAOxeNTLZ5FMZk=;
 b=gthlJ3RYfd5cDZMjSg1gXmnzPCKJ7e+SvM16jWjKVX7lrGj6X/U36l53iZ7cPqiIJ23xzdUN1pTJeOUTeBL4K33Y/7oC/ZSxnV0PxygJR/SNXRrO49A65V9VutPozRO12q39Kll9NYHk8CviI+nf+aUhedUm6NwWwVwJTTy5ghnQnttwE/G2wnO6OCfFbjeji2a6+rHLNf3V5SHj0z17GLTO3xsIp8IdVW+e1ybJsHDumNt9d1LXyuZnhV9A+EteK2WvPnMART3yrCIc9nhlb5UIXGus53QMNk5LrJBz8UhbfBva3YEtRGSOKpyGSoMwfQ/c4q6Dfgx/ip7ND84vRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VIF5GycHJbQS269YSfpSXNQAjp30pAOxeNTLZ5FMZk=;
 b=zoeUqqmkxgUi5EFMkVULx6T0xzq4GZwiBtAqf1irsT8W+qGP0AMQGNb8z153opP2CAAsyR0joBF/csj7VF6UvjNiP6HbnS9QMnYblH8yZGaEWUYKfZkBlxW44KdkIOlSqzmsa1g2I2MZnzsLncDNoIVnbddW//zZcr6DJAaRuMI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5895.namprd04.prod.outlook.com (2603:10b6:a03:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 26 Jan
 2021 19:06:55 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 19:06:55 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Amy Parker <enbyamy@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Getting a new fs in the kernel
Thread-Topic: Getting a new fs in the kernel
Thread-Index: AQHW8///osNsQgyXb0SMzho9ts3DIg==
Date:   Tue, 26 Jan 2021 19:06:55 +0000
Message-ID: <BYAPR04MB4965F2E2624369B34346CC5686BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:b091:5edc:1473:bf45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fb7ef1f-d23a-47e6-d495-08d8c22d8c59
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-microsoft-antispam-prvs: <BYAPR04MB589510CEA0EAD7738BE2952786BC9@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9TFET4Z/YjOByiA3FttzFJbapCoFm5qteMNcvIPkv+LUQC8J0zTKmaW0BgjOC2jFIT0ZCczhThPsmFwYqpXVf8a6oWE5y7U8pObvtAo25bwg8vLqdJLXTZs3Fc5vRJjDhyS4X2FhWgy6BkrtJnP7+aWLQ1rARYBETxKZD5pKmGqpnw72bWD7BJFR8jR6XhquqYu73RhGskoZMRabc4KKSykuJyCANvG41CHhKnFuOOw5d6QFfNvAtQ/HK65TbbhlwKCrdWqKvqoPjGAznPvpUhspdVaNsQlVjQX99xaLGydjHmRpnaxvzRx/VWtRySa9M5Yqk/vElA4EbZ/Au4+ZWO2pFVK2DB698aQcoqdeDBXcdd4n6cAB9t9klbSGgPVBnN8TX5z3dztZ3P+M1TP8aA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(478600001)(53546011)(6506007)(7696005)(316002)(2906002)(66556008)(33656002)(55016002)(110136005)(8676002)(8936002)(9686003)(83380400001)(186003)(71200400001)(5660300002)(52536014)(4744005)(66946007)(66446008)(64756008)(66476007)(76116006)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hF0A495AxQQHNauEjib8Rjiw5EVPqIXMxKwEAJRsQkYavM9FH7vohT7dVdZK?=
 =?us-ascii?Q?jXvnyJfOOUbLhDcUzqQKnWMUdyzrC7nIw0y3uIlwYFkpJBnHlj/oqdC8lvDG?=
 =?us-ascii?Q?F46YSf5sgb3ghgpL5byW76abAY2lV5Lq7OCWwJsfQ1V7LCXcLR5iIZCUuBGb?=
 =?us-ascii?Q?/C0bNGI7ncK/PRH4Poho31XJ8TcYBsFoivAOuC+4JMrotMdw2wwq9KGMZ4vi?=
 =?us-ascii?Q?DjwpeaTRqKCRqg90szsx8fsbbm+wD5hgRNslsia6DPiEUt9agpVKX3g5aso6?=
 =?us-ascii?Q?p9U6qzEtd58P8x/JSRKd0ixa8z6RHQZLTC+MfyhJLdZLAechD+QaJu8gkJtg?=
 =?us-ascii?Q?lr1wyowCcJQeXipE/vJETdguh4t9PqTsa5BQ7pvWaVe+WfAxv/pfWah3P0tY?=
 =?us-ascii?Q?O8Uo+M2H16wVM7qRyge2h829NE5JPY3HOjbEpGC5c5un4IFxb4TsDdTpmDp6?=
 =?us-ascii?Q?PFFGvC6t5CpguI0klTZPnCk+6RLC78BQM9XX6rUGs/mOdGrIBZ9ucrBa81JM?=
 =?us-ascii?Q?IvtMXkJjMkdAyYmbE+i7bRtxvq1xLfvPTZjkffvRLQEGxpPkqCG4n1NRvHcD?=
 =?us-ascii?Q?pQFRH/bPOA08fGUieYCf3dqerrR8ZnP2bZGz3o2DenZirfPDBPWJ5JhqsF66?=
 =?us-ascii?Q?ClK2TFudge2R2NYxbjYoUDS4kftOiSSUZQx7pczZa0aLU5Ggo5Ve32do6/kP?=
 =?us-ascii?Q?xJHPSsq/2grQ/9PgRqZJ2UtpyMU3l8a18SzsPn+acxBzLmg1wyGDtw1y7lWa?=
 =?us-ascii?Q?r30G3MrIdHa9kKJlGEgdk9mUVVbgAl55QHvWKsA3dcQpsG49JSsaZfuq3jZe?=
 =?us-ascii?Q?WQbSz6zOW15dkraAFOKB+BnGXPCBZC3I0fmgoF8WlBDya5N5E58tjAOhI3gm?=
 =?us-ascii?Q?fJCC4cXD4/p4jTxn8Uto5oljDJ5f1ohZ/mgnr0HBd+GwgcSnJHa3yhD6ons8?=
 =?us-ascii?Q?7qHRkHQNBAFfTm/ORHFEhHp3BPV2ixO5hM8uchywkO60FmpqVgLh95erV7CL?=
 =?us-ascii?Q?apUur8uffR8XZXK/0XKkOqzeWNRgaKZo9BKBWriQ2Z55vCnaVHXnBH+THt49?=
 =?us-ascii?Q?VbXcb+gJNcDIoX+IdZ6LJOQ9gT1QvLTSEhl6vKjQO40bOz6tPMQH5BjaND5K?=
 =?us-ascii?Q?ixDqG1PJ9Bbjxh19kP4Ulix3oMfKEu87Ww=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb7ef1f-d23a-47e6-d495-08d8c22d8c59
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 19:06:55.5550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0guGezbuRVjxwd8LhvGYFgrhYTk8qUxWi16NuGS4jAIE/9X73OYlZVAt248Xk4JDxm26z+MWd2iSf1kq1O6fu+/HEpXxYqZ0onBBAj/Qtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amy,=0A=
=0A=
On 1/26/21 8:26 AM, Amy Parker wrote:=0A=
> Kernel development newcomer here. I've begun creating a concept for a=0A=
> new filesystem, and ideally once it's completed, rich, and stable I'd=0A=
> try to get it into the kernel.=0A=
>=0A=
> What would be the process for this? I'd assume a patch sequence, but=0A=
> they'd all be dependent on each other, and sending in tons of=0A=
> dependent patches doesn't sound like a great idea. I've seen requests=0A=
> for pulls, but since I'm new here I don't really know what to do.=0A=
>=0A=
> Thank you for guidance!=0A=
>=0A=
> Best regards,=0A=
> Amy Parker=0A=
> she/her/hers=0A=
>=0A=
From what I've seen you can post the long patch-series as an RFC and get th=
e=0A=
=0A=
discussion started.=0A=
=0A=
The priority should be ease of review and not the total patch-count.=0A=
=0A=
=0A=
