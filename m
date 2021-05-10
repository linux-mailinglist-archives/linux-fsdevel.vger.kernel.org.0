Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1047378094
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 11:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbhEJJz5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 05:55:57 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48886 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhEJJzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 05:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620640474; x=1652176474;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SIKNBgD9DbT9cXqMZMVScZfL2tXWZYPa2jzQIuVn8gw=;
  b=fZfRvidW0ffoHt6VoI+3/BwEdkha2kCtiWAvw74ebMSdRrtNhkENeD/0
   64IWeRml8MBpQLtzTxA/aPCyf8mxTlg9OXjg8RQJfjZlTfaJLGDXEzuSQ
   QRruRbLyyDL3na9A5/F/8yY9DpnadRaBI5ACMRGKp5Mn2MPzOSwXwrp4k
   UIFuyZYHET63I8nTt5j/nzUxjONPev/26zDKZstgaJrQJ9slN+sF1Gf1V
   KCH5hju7WYsL+X3W0a8sITFQLTp1HbzO6QjCeX1ilB4s7qRQ9HS95VWY5
   SHZzU2u22gjPVz9Z990KWJ+6yFuFE+A1Y2/HKAw1xAmcVI06dRc3Wvp9u
   g==;
IronPort-SDR: zxFZ1h5gTAkijvMuRH6Z4UKWlPs65+H7nHomulWOJXf6s7VmHmgnX8YBA/o+51v5h+tHW1daxU
 N+EMPCPlCVdyQtPInxwfogaEJ83gSUbBcx6B9Zs/HnQnhS1rKZO4E0py2fFSYsz7uA0rcm2C7o
 A1uZXYAkeHrj9BcdkzxPgUOSSBGZkIBLyEYYsNyfQ9jFUFHF/DeKG8Ps+ZqLndKn4UTBtWNDlv
 K7aDUQhX4FNOcoeP5pCN1AvagG813QldI2mj/DtJSfGU/pkhoZJWmok8WvrTtt5A3TpR0n9/qI
 0NQ=
X-IronPort-AV: E=Sophos;i="5.82,287,1613404800"; 
   d="scan'208";a="271609261"
Received: from mail-bn8nam08lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 10 May 2021 17:54:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+AZbNyIn2fXzOwNpCR5z3usy6qId4zEzgFe4FT9XeIxR/kh0v7oh1FVl3wHw1oUCLK2y85Z3Akyq8jni+Lm7PFS8rc7pVhxE4yyAzyv24hDS9/YAuFX2GS06fftWgVyiVhboRIGB4G3kcA9OxZsUYdnXVjRXm+mBEeghwycjUMuQMfQ0oiQocAToc8s0cGf0DCRtimddRdtcN6zJAfiwisCINcU8+ibzwRUpqyaO4z8sHDC4S7AqmpqxNqijVSHFhgI52vOmh+Ir2Gvm0ZLna9mWdgzswsvT9yS6Og3BbRbI1pdmxW8yKARdrkzplT1KgEIaLofZbjsyyhpVDRjDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g++3T34vzzgEORox0W3YtFraWFkZx1Y1v+VyTE6gXFo=;
 b=gZZ6DU0LSpM0mF5v85I4NnT8ISNagkrIrKw1mQWdtSWAECvV8a3riZSPkWPFP/hhb/Wwq7n8PuCU+OlfqB3Qn4L7i1ie3aP/DpmI9pCqlmz6Dfvqg2FPBRGw8Im9gLHymqj1mP9SG9fCD2ehh4QTllKjms6wUdwGi+LUyaZQD4OW7+NWoOFK4XeW1iABhpjvku5Hq9sWIV2Ql9TVoL5seyrC8S+3vKxspf6U0PKAkJ9vcdzQ0E0KXk3X+RxiB3VZONkIhyiDhlNm6TskRwMQjZ/UKSJ39u+QmMtCG7zW35vX8PRE9PsQC+aNdsKnwQpnDBWE6HSui9XPNlNM7GBGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g++3T34vzzgEORox0W3YtFraWFkZx1Y1v+VyTE6gXFo=;
 b=pAMG+EcoSx8akEtu5D1SQsIugAe7yowuYFjGt0u6etpf6wzRm0sBFDQuvSAjE9S6GEcHWhKM2JWCL2GsFh76ZAppIVSErF5oJ+OjF6CO2o7w6EoxKGiEt7yQGKWelDK3dhg+RgFigxLNwRSRevB2i0vQUs+aQmKXyCdIMng+uJY=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB3883.namprd04.prod.outlook.com (2603:10b6:5:b1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Mon, 10 May
 2021 09:54:06 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 09:54:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     wjc <wjc@cdjrlc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "jth@kernel.org" <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: Macros with complex values should be enclosed in
 parentheses
Thread-Topic: [PATCH] zonefs: Macros with complex values should be enclosed in
 parentheses
Thread-Index: AQHXRX11OHivFlBitU+zFIRsPOKalw==
Date:   Mon, 10 May 2021 09:54:06 +0000
Message-ID: <DM6PR04MB7081D6946B12E3866502B833E7549@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210510091800.50799-1-wjc@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cdjrlc.com; dkim=none (message not signed)
 header.d=none;cdjrlc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:252b:a4e0:3a13:8dfb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3844cf4-4e00-4bda-c71d-08d913998d0d
x-ms-traffictypediagnostic: DM6PR04MB3883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB3883B8B2D4E03A32ADA349A7E7549@DM6PR04MB3883.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GegS8nxDbKmIF5x6Pj8vHdFgeofKdegAVC5hx2xoeZ/Z7FJXNWoDNderzKBR1CX3XVPvMpLOdZFkwriQkpI4FzGpBwKT7Gzh0wyT6zgr4RSSMIRpsJz6+2E+ccn9u+PsQB+m5iUGAUwWYRcTPCc8rDPxBhyt9966wMYDmz8lHI5Yx8t7VSBI/6klMA/iB5ek6xE+6xsK33a6Ib9uRVyvvAnaPfd+UvZ788+0ykFpMMD7s69ZVMY2LkBLCnohzSyTMeA5JQGr3HZd+6qzkTrAtboHvhqG3m6lrwG+CNtX3tUlvjJOpGKE9+qg5SRExjAiXkOwbrEXzdkZZvMJ8fXBhvVpokBmQJNJgJ54LQi7hjH+E01EwnDHgGqGVozHpYmMhze5exdbiKH75xwst3xpzM9/cpUgWmSOn82DrAjZjtz243iBlqXTKFBwjBZmLd3LVFCxY4ufgGahOiHGZUMYq0ZT5E61Agl2WuigZGp37dNK8CzKzkpnklPDtLO39PeMJ7NeqjWrkCBruhlX5wylgahV7thu4B95ST2r2nRmnUxokQDnpQ30XX+FBtv2EodfodlDe1JdFeWiIZCPDb27tvCEr7Sz2RrpFySdLk9Mg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39850400004)(366004)(136003)(66946007)(76116006)(66476007)(91956017)(316002)(8936002)(83380400001)(33656002)(54906003)(71200400001)(8676002)(2906002)(110136005)(186003)(66556008)(66446008)(64756008)(86362001)(38100700002)(122000001)(55016002)(7696005)(52536014)(5660300002)(6506007)(53546011)(9686003)(4744005)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2hvVasmElgqoB/u9ifCdmIlC+hyDoYrjU8NZB10hQXh7UwGRBDGLnKgNiRQk?=
 =?us-ascii?Q?y5cWZL4E5WG0NnVTKS/wPTVfoGceBNI7NapaKVFETvNuWGK3hmG1AUf6/cTq?=
 =?us-ascii?Q?/8S30WBlw4RX4FCZ9p2gxAUvatZyBDi8/tFLGvSQFRY0gN1nxsm3rXX2DLw4?=
 =?us-ascii?Q?QAV9ONVvDzJHzWanYQ5tXjSYP4To49lsM/6n4XQsf2gBB5rOPiKKikCOWiRh?=
 =?us-ascii?Q?7fm8KOkbOH9Rm29H2644scvdYwJtADmLJze9kVCZ9paoCWzvDPP6xezyKfiF?=
 =?us-ascii?Q?WKlYIWLacnKI9VJkpJ6pV/q1lCdFhoKdVhs5+EdEKI4jFQSkS3QVsfC+NUf8?=
 =?us-ascii?Q?eCa5eEBgjehV/kraJYE4KCfSUI1rA4EFZ+V3Wyz1EXsrQvJNx+v1fzgN5IQm?=
 =?us-ascii?Q?O0eJfGdfTiOAZ0wJA3mHT7OePFXDrrYVtKBG/sJEm8meCMbHu+6myYWPIsq6?=
 =?us-ascii?Q?bEqvsMHfm5mQhXsUzjfSzWL8DF2kK8GTCugFLFvvB3leJbMgXgOxSDa5ip/0?=
 =?us-ascii?Q?tftIeomdttmUcMKdpg6iifE4jd9QmCmpaEgoH6wVz2N4aARBVbNv+bdu7/j7?=
 =?us-ascii?Q?F7iPD3roNNOXoLEhT1kLPAwbLE5WJc4wA54ZaOvkyO7E03nF6FWeXXrQd1Ne?=
 =?us-ascii?Q?o4fLCOgyvO9aXX9AxCq8PSAUQSi/QJZDn47ZqEy8ih55ex+ymxVAxrhPCtBO?=
 =?us-ascii?Q?u4RttcqBVQn+LE/z4OxHjWi6+mI5dtuKndkJDRLRA+v4qIc6Mh5fzIxbs16d?=
 =?us-ascii?Q?b8woBML56aKz0V/PUcksy2dPIEXRl/O5TSJE+fvI2hwnla3IRetyftwYUrxu?=
 =?us-ascii?Q?uzu0cdfHSaatPh3mqoqMtPKdtLhxb3m9RfbtT6hin/PX+9zIitEBXNcdLoP8?=
 =?us-ascii?Q?QZGRgeEuIxb7wutPc05jrHHz3Cp100vpYXfC6hRyYRpq1NxlLp0vg99td6qN?=
 =?us-ascii?Q?kNH6hddHZFzuNOd4fIOSxkJ6gou5FNcjYcK4ShGAdDwdvoZ/BfdPIK4tAIYe?=
 =?us-ascii?Q?NrTdmhZ7vaKTaZzxDtsj6TMlRIfe3HxYvnuLt21PEr+ee6h1WBnGCV9eLCHg?=
 =?us-ascii?Q?uTjekomOGy1ZXwEd2RABCyDQ57i/6t0MUpSPEWhb3jd15LI7t0Lh469hurfv?=
 =?us-ascii?Q?jomMe6W7IZEGPsNoHXRZF6LMxWApK2l5kJYzMm5y7YrQ8EkS7Nu9hYLZej4f?=
 =?us-ascii?Q?qk8q4qG2glZ2m0PJux1RLsz3ZPAmz/+QwSfaSZWAqX3fpqwtMgAtlYsFGVf+?=
 =?us-ascii?Q?/Ak5Zyp1dGCq3bwfOaMptIYtqiIXNAwuwx+ayjOLLM1gB4FP6pg46NvQs7XP?=
 =?us-ascii?Q?HA3g5TwgOl9JnNfu8Is+NUSW6VsRyqPp/rFFQ2+5zucokCpn2a9NQueWYPtF?=
 =?us-ascii?Q?vL3XU0GAZGO09LwoOsEv1ECbwUUknh/xROdP5IVztCsh5ZdGrg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3844cf4-4e00-4bda-c71d-08d913998d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 09:54:06.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j+wbbPqMhWoWJe68fyz9GsfCYou/FjA32dsU41+TNNXqMffBFsF6hptoxmTaGOAMdX54RKl44EjMxFhkAX8dHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB3883
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/05/10 18:18, wjc wrote:=0A=
> Macros with complex values should be enclosed in parentheses=0A=
> =0A=
> Signed-off-by: wjc <wjc@cdjrlc.com>=0A=
=0A=
Please use your full name for your Signed-off-by tag.=0A=
=0A=
> ---=0A=
>  fs/zonefs/trace.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h=0A=
> index f369d7d50303..5b0c87d331a1 100644=0A=
> --- a/fs/zonefs/trace.h=0A=
> +++ b/fs/zonefs/trace.h=0A=
> @@ -17,7 +17,7 @@=0A=
>  =0A=
>  #include "zonefs.h"=0A=
>  =0A=
> -#define show_dev(dev) MAJOR(dev), MINOR(dev)=0A=
> +#define show_dev(dev) (MAJOR(dev), MINOR(dev))=0A=
=0A=
This macro is used in TP_printk() to specify 2 print arguments. Changing it=
 like=0A=
you did does not even compile. Seriously, at least please compile test.=0A=
=0A=
If this is from a static code analyzer, then suppressing the warning needs =
to be=0A=
done by removing this macro entirely.=0A=
=0A=
>  =0A=
>  TRACE_EVENT(zonefs_zone_mgmt,=0A=
>  	    TP_PROTO(struct inode *inode, enum req_opf op),=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
