Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFDC2E8F05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 01:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbhADAOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 19:14:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4607 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbhADAOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 19:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1609719363; x=1641255363;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=67OEO2SKU02zJEiyqTXjfG9nCYJvp9pPd2tL6qqhuDI=;
  b=ciALCw+WpG/xpq1kdT4LR+Rb5S6KpUZGhdaK6M6IGsqGO4LmPqcc+CrS
   KCHGYuryZd8DKaRJjdQKfCU/GA/OAM6Kt2wxGLKD/BQz8zvMd8573z75+
   b6luv+S9oY21oG/UbEkpF3lFOCRI2GlMKlEiV4ss3cZ0dx6z/xZ1/HjAw
   MDFJnSyjJCZ0QjYtu2lRUnIQWJB3910c01J43FHZMkEuyOhaEfEdVudSS
   zN9evlTqTvpMxm1VtSE5r25EBkJfB+gNeH0M0yTcCRLBmoU4M8TmWM8To
   mjlEt8oSz0E9yCgQG/QYLJFJbgLceI3y1nkDNWXLk324OkJN52Djy6duG
   w==;
IronPort-SDR: vfy3X0dOGz/cmSIf/bzOlcDVACN2Bwz5BonCB/YebLwKzdVk5Yr/4bW1//LsO44RDoacS4xzSo
 vTPua305+JCEo+Xg0oH18k3i3df7kRnFzXmDvuCLsz83FoI4UYagzUY63VujlqVkpkv5wswO2c
 e0QJ4sLqA5i5odu+wrL5ZDSrjN2DFUSgCCjABfB4uNnr/4FIPnomOfP7R7V8cvrdPSkm3TL/q2
 03VDb5aQbXqSAn3yEKP9ZdCL7WJC7qz/s88/llYiuILDEMRV5brsJfRRk8ID0yXXMJgOKSjqRl
 eKI=
X-IronPort-AV: E=Sophos;i="5.78,472,1599494400"; 
   d="scan'208";a="260307682"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 08:14:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATC7cbFQBAPIrfJgwk9z0FFqH/P17gMg1OsIW35k3ExCWlf/0ruyoYWcQLH/lGaYTPhRwtwHB45KCUf4Cfpc71TZAjL3/TLc05a/dCH/uNdlDS69xfemJOdALVsHJ+i8UwIgeQ5EelK+V5d8oxCoeybLLV5bsnr7Sc4ew0/tXG9iMa0vgdIjfcBgD3Jp3KF6PyMz7mXCK1ffz79A+rmkXbGYewAF6gvzXlfr+ZV97/vdd6fCznLOdYmbnsglqj/MIcCTiVDSFxrHE/K9dn75teiio3Xqf4Y8h5AI1T9PCbHqFqsQBOjkejFPg7zOfs8IzCZyKRj73uXMsxswvtiKzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugEcEvQIrTg0lbZMczId/LnAgEI7Tl+eIB0dRypF0Gc=;
 b=E8ARnojtANwb+rXv7a95uP6MMMj9I0PmH2jPOoillLyNhM9JON0u5IBFGSjLry3b+/JcmP9A9w8sD56ASWk2Ta4Cl0G7S2IlOHNmRK7QbQTKvb8GfspqohQRf3/4xmZ1QZAyKZ+0O+9C1buX5KBmVZZ6CH57OLUzNIcIbLR/kwi/D2Il60gTzaI62R5mmFGjr0v8PoGeRo0YFI+3D8sTrt8RvavWQ5hybaKOhQ4L3Gg7Llxhg6Kdo9Wl53XMnTEvyFffwi3XzVxYQ48Okpi7hg4Ps0jbgI0td4WUNU1NLR7fIJmXzlPZWGLtOor2qg3/nE4raWlaqa8vnhc1XVSiZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugEcEvQIrTg0lbZMczId/LnAgEI7Tl+eIB0dRypF0Gc=;
 b=MnyQjCoTeCylybRuIbPvtMLsewpeKfZOHeZZENDSNwv8URNnWIxQsmTfTf6+aICfMekXlsBetDIbhkbee8Yz3qfh4sMEb2ue2JT9E01ChmfnYufUf4H+VknZjmjQpgQJPVIdSMTXCq9mAjVTajRLRtUj2hOrEs53xTYO4Gy74rc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6480.namprd04.prod.outlook.com (2603:10b6:208:1ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Mon, 4 Jan
 2021 00:13:14 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::2dbb:7e01:f076:eca0%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 00:13:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Dave Chinner <dchinner@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>, Johannes Thumshirn <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: select CONFIG_CRC32
Thread-Topic: [PATCH] zonefs: select CONFIG_CRC32
Thread-Index: AQHW4hmPWfupDlNDd0GDhgcXQokfWg==
Date:   Mon, 4 Jan 2021 00:13:13 +0000
Message-ID: <BL0PR04MB6514586554F9091C131A7CDFE7D20@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210103214358.1997428-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:4d2:96cc:b27d:4f9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbc6a9da-382a-41f3-8816-08d8b0458727
x-ms-traffictypediagnostic: MN2PR04MB6480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6480A970F0A00721281C982AE7D20@MN2PR04MB6480.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5cBEk656eJCrbTv0q1LZ/QdVt1DqI1ZAQDJYbTd/tXzliwur3WQdhRmzxWj8jSVPR9cTLsRNBK7x458ZeJ41gIx10KDJW8DdcY/VsTBBBw+JT2o2ztL8ZvZFzGobtop3XkHOtrEx08zIZFUcVhOVCi05Wu5k7juzLLXSfquUl10DJQYotarVgEkj0OyJKehPab9UinP0xZIpaAuowAIR2rkJyQHppeR/etCy/dCPTgXIPZ4eUu8dZfjxZIMt7smxHvD0vGKrZzE7WHE16133zOtc4wiNWAaSI5OAnpJu0ziw4ImfSkc+RRiRwGpm96WrUdyFbFf1ZPJm33iUKoquGBRItfSOQPYAfScHGepspYvmHFasJuaeDgYUSJVijk8D9QCBK4/GatJ0JagMEvS0hQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39850400004)(346002)(76116006)(91956017)(2906002)(66556008)(55016002)(9686003)(66446008)(66476007)(66946007)(64756008)(54906003)(478600001)(186003)(110136005)(316002)(86362001)(5660300002)(33656002)(4744005)(6506007)(71200400001)(8676002)(53546011)(7696005)(52536014)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jC2/7D4vlBjnR2Uk6TTEYXISofPx9IVS3KOCbrTwlg+Ar1COs90A0Y/5Wwo9?=
 =?us-ascii?Q?WVdiz2HqBIcQtWE0mdiJEt8hAvhOq/jDeZWwLI+WH1eXVQOvoPd81TEb7M9A?=
 =?us-ascii?Q?qmV9VVzljNRNtWXWXbt8RVYIdVDSHWawwSSOAdXe69B2QuBTnn98HB7/EZp4?=
 =?us-ascii?Q?mJDIpfizB5//9oGqrdzd6j/QZKImZAhnf5r2yXkCbcK8gH2QivUgm/S9siYU?=
 =?us-ascii?Q?53ke0d2e9aA6V3+pns09ED5Xi6q0y4VSwPKalGHp+KoJ1/NPwW6BjKEj0MKH?=
 =?us-ascii?Q?jX6MIakMyUxcfg1y5RpWGDu+2uG3cS+HSRYtq07eufF5JlSKWvH0FOE8/Tlg?=
 =?us-ascii?Q?4g+e20x/GgRRcKLC++ECJD620dNSYh54m87hIYk6j07Rc/QzrY6nWIRi2lhu?=
 =?us-ascii?Q?UVaHz02GzR/BNM63j3gRfgHe0F1l/OVE+RfdFgL+YLvWEifUpgU/H/0wJmHB?=
 =?us-ascii?Q?VzlwDZ1dTFUfRo753KcgjKNVVNWY1HS04DclCf+Fa5yLif/oVKH2CZPz42AG?=
 =?us-ascii?Q?z2NQ+JsN0/sqZiKU3pvcDNOnd9yWRs6oMRwNQ8RVDL5XwiRNHF4iplGZdzGI?=
 =?us-ascii?Q?yroCtdt0DpWF9cWFYJj3mGxAPg04b/1U116x2hSH7oge0/zquFKjQUtm3vA2?=
 =?us-ascii?Q?jLZUauT5THlnbI3Pdva7bN1mhRkpxPsUKe6DWIpoFiqnvLiqWRPTH9n8Mbyx?=
 =?us-ascii?Q?YH9ZrOHZHC780Qm+o4M/OqAVU72TlhciTgnDQBuYidl9CjcswefzrP4xi4xQ?=
 =?us-ascii?Q?GdM6usGnTLGjf982NswI6clYqWwNK/d+lK6ZT0iVIpOp9LD0WoWQJNxVYL+0?=
 =?us-ascii?Q?deC+w1rstKyUl0dEeuU7EeHINPAHMrziQsImfqpgzgFFO83osvgOSUNapYQF?=
 =?us-ascii?Q?YyVw1lHPb2f9feNSx0DQVQxRvXF2XlQy8tlB3Wc2bvnF7W338q6QwOo4yKcN?=
 =?us-ascii?Q?pQu1ks5ooOJUiWBZoeogQXnFxYU72KAqdmXK842M89Qq5FbIxM7fVj70f/2C?=
 =?us-ascii?Q?xVdTwhpYUcu/050OkJ+Ga21kuAOwpKGHAXcUkg4eTQewUKL1CnXDrCnaxm+D?=
 =?us-ascii?Q?zphELCeW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc6a9da-382a-41f3-8816-08d8b0458727
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 00:13:13.9174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydasZfS6CJ8mUY7wa1QMyYVqAQAqjxZ7tjtED6nuv5awNqcYg7baO5BCgCmQla1U8nJRkac4ReKKN+jc/Y9KwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6480
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/04 6:44, Arnd Bergmann wrote:=0A=
> From: Arnd Bergmann <arnd@arndb.de>=0A=
> =0A=
> When CRC32 is disabled, zonefs cannot be linked:=0A=
> =0A=
> ld: fs/zonefs/super.o: in function `zonefs_fill_super':=0A=
> =0A=
> Add a Kconfig 'select' statement for it.=0A=
> =0A=
> Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")=0A=
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>=0A=
> ---=0A=
>  fs/zonefs/Kconfig | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig=0A=
> index ef2697b78820..827278f937fe 100644=0A=
> --- a/fs/zonefs/Kconfig=0A=
> +++ b/fs/zonefs/Kconfig=0A=
> @@ -3,6 +3,7 @@ config ZONEFS_FS=0A=
>  	depends on BLOCK=0A=
>  	depends on BLK_DEV_ZONED=0A=
>  	select FS_IOMAP=0A=
> +	select CRC32=0A=
>  	help=0A=
>  	  zonefs is a simple file system which exposes zones of a zoned block=
=0A=
>  	  device (e.g. host-managed or host-aware SMR disk drives) as files.=0A=
> =0A=
=0A=
Applied. Thanks Arnd !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
