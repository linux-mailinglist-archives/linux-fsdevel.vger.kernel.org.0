Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FA331D32B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 01:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhBPXws (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 18:52:48 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:37286 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBPXwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 18:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613519565; x=1645055565;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AKgKGwKjnO+5QoFgQinLjAWoKRSJyqQeMZt06j6U+5Y=;
  b=TNn9x7Zr1DyrcEzGQsmNRsxu4OHGTYCzZQXCaEVPzMtRsQFw/yVnWB0K
   itybIhwKnRHsRZ891/20aTzGbXumDuoL8TsgMw4ebiTZSiJK0Ln8TgaE3
   dj0MoOJNR1OJfVh2GP1eghpEY4zxRqB0/kdiJ8MYlgu4RetdPWeHpYRwg
   4R/0F8VqKlxwStYZyUKqEq0UBgTJUtR+3i4WNUPW44DY2AItcGCs+5FDL
   PeRBcRNa5C4969Rvk+Tp4CFkxGxg7t0nG8PhUH9tRZkelBqKHBq0QI2Pq
   w4RQq5qvXzb2DRSDrOiqyX6fMi6nLnrN2AxZJAw4sqJ2+xglvqPB5nYvL
   Q==;
IronPort-SDR: JfkwFpB+uPyNiLTB2MI9V7lj0w5yxoZ3Vj/3WbDHwBfPKyWkq/MbqjwhVWecOfApjOXmA3CPcD
 e0NvFNQ0zlAVrDlLnKjcxBt2iXWodqOsemXjWc3kYksHOZADS0dnPN7KNphtyoSOup+QvKCcq2
 1NFaFvLM30eP/2Z81bwdHJciTRyULZUFp+Vkn6WvvksF5n4lwD3WEY8FnmXD0PdkSDC9br0p8z
 z4E8+Xg48GIYvoV2xTGlDGwAg/G8jkqtGA/urJcQfskDhVZfx+rRU2QW0vA7PdDpRSZlo6wgG7
 TGg=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; 
   d="scan'208";a="161278517"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 07:51:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR272gHGl6msF14uLZQQK3/E27H5kUoZjgcZ4LWZa0GscpQnzjteuJIDcua/q76O4YhMq8Sdlzi6qt2zawuwi7thcIo3M++r8udpFB4CkLKRRxLoJbC6kg320IeOnzU3Yydrm375Js5OAjY5cDoa8zzujY8opmJbXDGNOFRrfCQfU6ImUjMJ/+OwkT3nRNbMT9XVJPvkOUtfhYM8mqWomV9cevaMcwAaB2rkRafXck7CNJ/xpMqv9s4rRS3qNztBT6hyWkDeW3Td2bVbfzxjC0Tu1a7UhAbKXp1cU+pgLAw3FXwCgQpiz44gVc477jAsnm3tDEMb9NzZbYHatJHAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKgKGwKjnO+5QoFgQinLjAWoKRSJyqQeMZt06j6U+5Y=;
 b=CUBI5hQkyTMZVu7kWKYecYfqoIGv4CllK6n1irTTnO2BTUBJPioNM4y353vl8QjJnvSDkx4dTyEGeS+2gTwi2yLle2YMob+1+qA8Pj6yNwYrlSlw9pRHCCzWLZX2DL/pr3IKhxCdRCE3LcriVE4Fs3fvvO603w1Q33SQHBZzc1iVJgRAAxupUvOscbsIjVl//ouk1JSLLVjCqVv8pyOKPed7F7Jp/Xav2zeZE1kP9Bp9/pkxKy6HL9tlLKVqo13AHhga0g/1yDYAc1B4vqFA9NQ4+fqrOYFC1Qpt70Vl1RyOMILKTJOJ00tXpORtPsr7DcIOgZNljWEQ6mX+Je3OXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKgKGwKjnO+5QoFgQinLjAWoKRSJyqQeMZt06j6U+5Y=;
 b=yYFoYCwy4zRuHbDcS7rjCZsweIweIHYGPI3bCefETT3bZO44ehpe6mpkt3Gsmd7GCvypdPFbmJ1b9jPcIDE+WKFUs4tnUP+WYoe/lRRhQhHj+7q2RNomA6JEdJQIwvpyUqTYEBLZfZaSHjxYqNHqSNRwUZ0Msg0fTxdDJ0F8Ctw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4664.namprd04.prod.outlook.com (2603:10b6:a03:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Tue, 16 Feb
 2021 23:51:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Tue, 16 Feb 2021
 23:51:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Hyeongseok Kim <hyeongseok@gmail.com>,
        "namjae.jeon@samsung.com" <namjae.jeon@samsung.com>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] exfat: add initial ioctl function
Thread-Topic: [PATCH v2 1/2] exfat: add initial ioctl function
Thread-Index: AQHXBLQ3E7G2/hieYkujh2Rjf/9pjQ==
Date:   Tue, 16 Feb 2021 23:51:32 +0000
Message-ID: <BYAPR04MB4965E7E1A47A3EF603A3E34C86879@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210216223306.47693-1-hyeongseok@gmail.com>
 <20210216223306.47693-2-hyeongseok@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 123f6031-0ed9-46dc-b7b1-08d8d2d5c969
x-ms-traffictypediagnostic: BYAPR04MB4664:
x-microsoft-antispam-prvs: <BYAPR04MB4664CBE3533950A195C4855B86879@BYAPR04MB4664.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:765;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnkvxgGtwICQ4hNZ9lpMTRvcBwnLOEcYiPcjk95fE9w1PLVIcqYhiubfcUNchb88SkVmBwIyhWL/M7eTd621D9n0WOoxZjLZKZBKTvGn4yttCGuhofVJmC6KLdpy8ut1vb+LeHvfUjsDP57rAHzPJ5X8i+qhF6bbGt3FvqOO5pvlD+DttjpXoXByeW2Zv6zM/34M8GWGrz8DhqZLjVdF2NtJqM2D9zvb4u9gRO4WA5C0rAK7m9ism/cc2pLZaiJ4qTzioeECusoPVVI5ZEEhN50cv4yb7lj5UoAhmuehaXHaGgojKe5EHtB8rXMxSlN1Q8MoB1UbdZe5atrveQE+ZEmyczU+TcXHnRc1KMiXKtx8KN3VvuNXTdW2pVngSltSgYXpHztYQf+26Zvjp5OHDcCq0bWVJwyawiyunF8fyaTe4Qc+uUrC6aKAm7DUBMu1C7C02CWyWfcNq79ENTu+yAl/heoHRJshLe0cK+D8OMAvian7e3LY8JCibe0cjwzC67HHSy4uwsJYaHzeFDnBaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(558084003)(110136005)(316002)(52536014)(66946007)(64756008)(66446008)(5660300002)(4326008)(478600001)(33656002)(186003)(26005)(8676002)(55016002)(9686003)(66476007)(53546011)(6506007)(7696005)(76116006)(54906003)(86362001)(66556008)(71200400001)(8936002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NmsXJpyuWjJYOZsW2r3Hs4W12a9gAHoOrJKVBz0SQgeFCUFSNzG2XfM6tr/v?=
 =?us-ascii?Q?QF3ulzLJOenUqfdpwRqPGx6xveGaM4QdUdbJ6BGE1Hw7sU2iNnMl74Nn1dGH?=
 =?us-ascii?Q?4SmEE60vR0sFOnVLj2gl49jIrwZjiD7HkDd6YC92dr6qvxu0Wmr4DC+5PeUA?=
 =?us-ascii?Q?NpCvsH0mU3v7VzNtFO/6fVbi4LtkzPYy+hC1pSQzPQMrEd/21PCruWI00Lb5?=
 =?us-ascii?Q?s0QF4FqPVCaGqQkfgbpJX9sFN/IKQN+arbr9tPXgvzppPCKX5SkYHyBlZXEb?=
 =?us-ascii?Q?tsNZMcr+AuvlSNAoVI+0AFBKRub3qcS0q9CA5sNZbYeRmQNIGlykW52Bg0Nx?=
 =?us-ascii?Q?MtjmL7E9MIwzSsh/lAKhblC5vNLyZLDjFAyiUmO35HvWee9nYPSWzBxTXE2G?=
 =?us-ascii?Q?Wkd5nAzzTw5+zCfuRNw+RBM/8fktsnUEjDWsO7OGS34pgC22Q9YzoWqOiWqP?=
 =?us-ascii?Q?ojLSmwqxAXuptyfW0tof+yfJhMChDuM99iBtF/eEc0RLZKWpG7MWoSIJISXE?=
 =?us-ascii?Q?4IoHkEBMR0A7woq/owQP+tH4KHUe+WIupxIGzWdEAIO2XCGo1tVKapeIRiVO?=
 =?us-ascii?Q?43xg992+klYv3LobHSkwFf7sDp0AQ6DcVM/Cj3GIE6VVylVbO6wxxncSIba8?=
 =?us-ascii?Q?IZiFTZ3sIjoMTVqpAjXO6J0arZuHNDQvE6tmrA+yZLGuvZITOO0SyG+taNqd?=
 =?us-ascii?Q?6HF3jXG5byEM+Cws5R0lZMbgLlAdT36GxrdpNtv9OoE4mVY+8DIErvdIjwm/?=
 =?us-ascii?Q?cSfED5bAGUxR4a3oq1tVxsEhgTmhIFawBoafbzywHFsOSazVPeQFSEhYPz8c?=
 =?us-ascii?Q?MPa0yxZE1j4i6+WzDbsKe5jKWIR8b1RSsreGozSejjyf0dTyik2ECsSbUhRy?=
 =?us-ascii?Q?e1Oivu4pTPPs5K6WSsBDSA88zL9JJfLirzViOMDqxC2hUmFAEEZJCPrBJgkN?=
 =?us-ascii?Q?KBPAAMRVc7IjqfsiJwaHzKqpFoif9W2hbvE3P4ZIntaqkgRV7v2CCB8p9NJW?=
 =?us-ascii?Q?mNWtz142rlP0PnYL50T/tbxwJDHtJzbjQQyHZmCw5exu0EXNBIlGTJIq3BGP?=
 =?us-ascii?Q?YBb59ViYWgX/NVELAJXJn1pV2nGRa0AhKQQc3KZxAmXYA0tQpMDsKVzSA2xe?=
 =?us-ascii?Q?i9BMUPgF8wNA+goK8nJCccPUZ4cmBkNTWEUJjBebOu2xJNJ75Wx9jyAm0sm+?=
 =?us-ascii?Q?d2op2AS+EabYC5PxrBHLIuiSPLbut6ZbzG6KxfTebH9FLzrFS4BS0It0o/GH?=
 =?us-ascii?Q?o37aSMqUXdF4BidBG/841AoSwTgImSC4aV/SeFMRND9M/b6oqe9Zin7U9JkV?=
 =?us-ascii?Q?z8O+cerEqLhCE0cXm+W9iKRd?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123f6031-0ed9-46dc-b7b1-08d8d2d5c969
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2021 23:51:32.1001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4zeXJj7D+1uyR8A7vh4Uf7XSD3ojqjW2hLAMlmogKAcFxLttTM7onHEoFI9d8vAo9P7Jsbq4woO0LasK91UD64Q2wIn7kmjd21wY4Gtaus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4664
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/16/21 14:36, Hyeongseok Kim wrote:=0A=
> Initialize empty ioctl function=0A=
>=0A=
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>=0A=
This patch doesn't do much, but this commit log could be better.=0A=
=0A=
Also from my experience there is not point in introducing an empty=0A=
function.=0A=
