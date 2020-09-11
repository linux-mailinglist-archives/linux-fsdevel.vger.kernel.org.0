Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E97F265C67
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 11:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKJXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 05:23:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22757 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgIKJW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599816178; x=1631352178;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vaMYY1VK7MRU71/C7IGIWMpkm/k7YRyFHFXlnSE5j+E=;
  b=WGrK+bKXM8jpgBmVLrfja/Il+gXlkU7gjwdF3lEUZYs8DDoRCePd44ot
   vYKsS5HJ+OKoR8L2c+aCDQlrS8iezC8Ho/c3B/+jyMEhTRHfgfuUKNSRn
   8OAVHcsC3W+QlWCA8AXs0Hzy4xXHAcoZpy/6cIoXAmlpZZqZKXYxRSp2P
   spRooQ1Aa0fpA6E3FRCxU9+tApu5KeC6/+GlZWM3VfOzUnf64erAu/Q0p
   nTTZfa2Jyqqx/1ExhNzlqCtkDmR+muudTjVuHwnVedQ2UdGJkUpIYgUQg
   2XwpwQqpT23Rc/Pv4PvpXY+6uaoknB9MRMxww+soIq9RF5RLNfv3CVqCs
   Q==;
IronPort-SDR: nrHXvUzaT0bKvG9OFRggZg+e3lkBG/KQ01p8a4cp83sEegctYGjFASeplv1fTmpbpqM2Ug3LGX
 L27+q3SUVkmalmy1NnnufIJRYJQ3lm/JXMw5n6pX7cIgRYlvjuOYg7+wMwn9KP+kZpK8b+lp9k
 TV+e1cg/DkFINBTVD6ncLjCAzVCe89+VGIyHwX79uQO078O/f/Ht1zs/D3/2bSrYJr3fFDniSD
 3iyP7lTQMWH6lhfhy/f8RwPZHEfGBid2wT48Iaqo60FNx8DoSXZUKJAB8KbL0Fvl2nAidVfTdQ
 Txs=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="151477861"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 17:22:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwZPvqbvqjKR/8noE6dsWVJ1UccawNWV31JYA5RU99CmMFMH2yrMmArbFpl6tF06CW5aqdcX3t6Y+7dG/qaxjAoeuT72H2jLxVAZOP0JoolatTTZOLdqdO11nH2jIrF4qLZwInNfGRMbu3/9nT4fenPZfDYB70s7V08UI4V14vBW9pS2ezXxbBPgKQ+BZ7jKnHJSbOaczkA1rUIvS914nOSADClrH/76HDhNHapYbVuFok5oWv5gbXGAWWBlJM/WnZHI86oplopHpAS6IY1fNDcvrgq9WQwLkTlq1falaOhzmM2u8737w1+Jx8JraZ72ZdX5/Z/LcRdUfi8XmV+9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+hwJny1qbvQveXmTIAtti/WvSFjf6vsKdqT4/p9WKg=;
 b=mGrHMDg9OHKPuNnClgcMyspyp0C5/2cYIrZnQ2ieGKQUfPKvUIiYlGPTuDcc6VfxewJOINC74IgsLhTk9hIcB2qWaaL71a6LdqbzxUhtjI5KVyFTo5Xp4O/bULooXEbBRpNMXl0LYEBP6iY8LaQBperbHj8o4lYionEyhUiY76e/qwfjWj+XKvy13iGqtBSinALCUPEeigtuEj+TDI+0sSJ+KZMDJ75rhzCjmus8vQVAxyleKJZumvYiSszYT3fF3HEIFTiFV/7YhGVNM6Y9fZA7LKP95bVjiWH/pAnXT4f5sRkJl82q7NTl4zFZjNpoCGywnXx4a+UcoH2iweoudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+hwJny1qbvQveXmTIAtti/WvSFjf6vsKdqT4/p9WKg=;
 b=uP1RZ0O7m2Ve6UX8r+HRFtzZuk8G6zj37JUfHsXZbpGoT6A/r5ZS0i8VqazpTsnYMuPU8ehwRnzGx9SJwqRugkZMIo/1pp4L1q62B+lDlHQVqyjC+DWGWBUMuCCjQxkCBvdLlrTthr7V8QKsId7zxIAK+7Sz4J4hmKOA3LgHKyw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0969.namprd04.prod.outlook.com (2603:10b6:910:55::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 11 Sep
 2020 09:22:54 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 09:22:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 2/4] zonefs: provide zonefs_io_error variant that can
 be called with i_truncate_mutex held
Thread-Topic: [PATCH v5 2/4] zonefs: provide zonefs_io_error variant that can
 be called with i_truncate_mutex held
Thread-Index: AQHWiBmExoXuQWr9dECC3q+XgUED5g==
Date:   Fri, 11 Sep 2020 09:22:54 +0000
Message-ID: <CY4PR04MB37515A6783FB539FD267A6D4E7240@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
 <20200911085651.23526-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:593c:8256:27ca:4ca5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b52cdf3-c45d-4fbb-2d97-08d85634438d
x-ms-traffictypediagnostic: CY4PR04MB0969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0969A953F90FB1F4792CD780E7240@CY4PR04MB0969.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBN1CG2W5/S0RZ2mCmre6p5Z1x7Emm36w5l0Ew3gHFzcuYgM0saVajPaPXbDu5DyJ4WD+IG/rtL+YmxiLKkBWtslGbP0Qw+J1g7xT4PVzRv6Tx65HtpVEFFxIr72N/8Ll/HM5F3uzV4gfXYc/TKJpUiXB/TGkadLECdQwhU5uyVY1dsaPJL8msZW19b+IshLBrCizP5OgYEStcJj+PsxlsgA3y/DgMVUkScJWVKAQndSkiPXkm/mTg5xbKnD+lMRSOlweckwPvjYVoOF7Kd57V7pTyb3wcbyYjHRWQGqShavbE6xU0o+1pe1Pwu+9x/IVL5KkUlfcHXDaP/OTSLNxpJm1V4MKegnjdxBGjXIH0cnNY3x7nGPreR+4hxcDwXf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6506007)(53546011)(5660300002)(8676002)(2906002)(316002)(9686003)(55016002)(186003)(7696005)(6862004)(478600001)(83380400001)(33656002)(91956017)(66946007)(76116006)(66476007)(86362001)(66446008)(71200400001)(4326008)(64756008)(6636002)(52536014)(66556008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ymGMZIFuDl2VT5jZG3vua5zwMGoaRYfATXkRtTMgTt6mnCJTxBKdXqcf2iB+7M6W84ry+zFkeU1kh+PECY4eVK7f/vhaH7cuv93z09hyfJ7pg3YQqpOPvVSysVRnOCTWAg4WJz/gLPNSe62yJXgE1djO52cuDHEdXP2hVNOeZYykujcm3cYnXZqTB1z2JrP6KFxCiZIrUkBVQ8Ug2Q9nS8YiPnenYqS+UWPuD7ikz0U1EBSug/1087vT7laffK7zgr7LNJ7TTrVJ6AMJk5pkz41n6xZBKBcf5ay+R1VzfkZ++BWfZ4x18Dw42D9ZWM1o7cOEhBhNu+61p0VpXio3ol64egeU4Xjx8CCt3JvhGloj/WxVikO1lM1ugRVDyAXEKCHDGYnJ4t1Me7fjJEtPZ+GGkcuT9qPfgw/JaS181rmZHVwBYNw6mLxg2Em90NJ51E7ANh/f8hY77TjV42L53hTtYXB3+BehlYZkR61+BuGGBaIkKHCgg5sqc8MQM/L13GnKuAMeI6aMDJX9jSIXS3l6bev3FJiaFW4GKOihSZP1UnLz0nUsqdD54CKAsVVJUBAO9aOJ/j63Kv6qzVnOvrfkw/A7a1ukc7uXveoSin3tUXL0LdXdPby/Os6gxBWGadrAFEqR83SzXQEFO7mbQU+m8lESqkyQcGXO3ku7sos6AIVGjRuyIo3B2aNmAeiZ1bWm9l7jItCl6LuvCaeqrQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b52cdf3-c45d-4fbb-2d97-08d85634438d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 09:22:54.3074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /HtfN1ZIrNP0S89zDAiS0fhGU1ArAloORpgGCUD5QRsTzjBDVcbPtTCl9sNpZ1pHsjxO1qbuU7jKIIXf2WWNpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0969
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/11 17:57, Johannes Thumshirn wrote:=0A=
> Subsequent patches need to call zonefs_io_error() with the i_truncate_mut=
ex=0A=
> already held, so factor out the body of zonefs_io_error() into=0A=
> __zonefs_io_error() which can be called from with the i_truncate_mutex=0A=
> held.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c | 11 ++++++++---=0A=
>  1 file changed, 8 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 6e13a5127b01..4309979eeb36 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -348,7 +348,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,=0A=
>   * eventually correct the file size and zonefs inode write pointer offse=
t=0A=
>   * (which can be out of sync with the drive due to partial write failure=
s).=0A=
>   */=0A=
> -static void zonefs_io_error(struct inode *inode, bool write)=0A=
> +static void __zonefs_io_error(struct inode *inode, bool write)=0A=
>  {=0A=
>  	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>  	struct super_block *sb =3D inode->i_sb;=0A=
> @@ -362,8 +362,6 @@ static void zonefs_io_error(struct inode *inode, bool=
 write)=0A=
>  	};=0A=
>  	int ret;=0A=
>  =0A=
> -	mutex_lock(&zi->i_truncate_mutex);=0A=
> -=0A=
>  	/*=0A=
>  	 * Memory allocations in blkdev_report_zones() can trigger a memory=0A=
>  	 * reclaim which may in turn cause a recursion into zonefs as well as=
=0A=
> @@ -379,7 +377,14 @@ static void zonefs_io_error(struct inode *inode, boo=
l write)=0A=
>  		zonefs_err(sb, "Get inode %lu zone information failed %d\n",=0A=
>  			   inode->i_ino, ret);=0A=
>  	memalloc_noio_restore(noio_flag);=0A=
> +}=0A=
>  =0A=
> +static void zonefs_io_error(struct inode *inode, bool write)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +=0A=
> +	mutex_lock(&zi->i_truncate_mutex);=0A=
> +	__zonefs_io_error(inode, write);=0A=
>  	mutex_unlock(&zi->i_truncate_mutex);=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
