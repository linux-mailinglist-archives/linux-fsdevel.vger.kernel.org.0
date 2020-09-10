Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350FC263F94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 10:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgIJIV5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 04:21:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56745 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbgIJIVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599726079; x=1631262079;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/ozYQBdLcvRDPM3SKtYMSQ9qW8nfSYqAHtgxMvNmdjU=;
  b=OdzHp8mY3tZJ4j2tKc9ei85yhiqErfgQp9+p1sO5LacMUDAOIkXhPKka
   XHeztibahuanxfjTPWzT5aOykIW1qak1CvIIQcKjXh9q39K+wsApnNkaN
   l9zv31o3klbCTxrc2HqwENi+HVLQ3FLvICkkVkmKs6BRnyaRmuWNsf2FA
   D7BjhT/hWqMRPPQFWc8fyhptFc9I44vzJmT2Wnge1CFPda24J2bnwXI7f
   dHF0gd9BxFbSJ8bp0Mz9fYE74C9hf2I+UXkAwCSmK+Cw13IfxJ1One5mR
   pqx8kmkUdDY8Joi0lE6H+i7g7dgxbsv1cQU13HMpBbPSWDdcnAbDzAtDN
   g==;
IronPort-SDR: /xpRqoJm93mdRLSH8o8xdzV11SfwsM5CNO9daBSG+tm3kx5q1q1Hd45RI0Q9JdTtz7CWUVxjwB
 uh9xBop4k05fxeiyJHkBpX29+AagOY0XDZddDVa8TcYjChpm6e/nyZVf4cr7PmbsgufykWbQOX
 /FD+dseviyxuLUhkemM4NhJQ2YxcFHQ3glGe9r4Nnz+6gyQUjXh9Sovel04IjAi01K6JopjzBf
 8g/5OebUS0NA2c4NKDrT2+RudveafdkUI80+JSbYkuYkVjayVItVhjRoqBc3UFT3AY9AY40Sjy
 D9o=
X-IronPort-AV: E=Sophos;i="5.76,412,1592841600"; 
   d="scan'208";a="151366278"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 16:21:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZr5O/a8/Z1KUaW7v7+W3kRPOSZEv6yXvQ3sfCy6JjUiUd1WWSHDLer4RmuZGW414iV9v0+rHaUyrpgt7yE71ONpT/EH1v3rvo7PSh5CpzUaaZLKgLUQMfZGwzQchElmVeZ5em+M16gZxrYgm0w0XmUBnsQ+PXbgX5mx2XcUcSA++gWfM8kCUnMr5VkhbXAjqPVJuZI5jWfZ5MyiUsVy/HxkfGPYvqg+WCSk8+0UgicvvS4mVVJj3O7LK/pdT6ivl4gOpladuc1o+P2oPTx4fUP6fZH7GSDTI4GOx/0ymnJbPhnQJbsIcd8qaM9+RDC9ZVVjYm/NUySN+4r23lzLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THmiTJXGQDO/O4wdtww/t37WruqHWZcrf5PbfLyUM8o=;
 b=NM54b/z3Wl7o5OaJXkJgTsHeDWNm82L+qSgt5p+obv5An8B8ieYbn4DelhTaTj6qU9Q7PX0yMETjZ8xUJ2yFOxcsgWrMND0qLdYWfTdB+l/vFDk4Z5Z0QyT1ThfMN3hCgJyCNgAajhH1roFlbPP6quhsRb/+KTvf0mkFy8pSzOhBmmiLhBXRXt1osXTJbuhKPGJs32h520AqGDWWMoocCssGtAmwTegkcLfAfg0JIWVESZ927kCmaSShf8j+gH32u4syb3OngdpepkWV3dzAQD+1PglNwIGdHzzQxDHsZCvju4amotu+T9p0l//duDnOMQ+msccM2O3ATeze333u5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THmiTJXGQDO/O4wdtww/t37WruqHWZcrf5PbfLyUM8o=;
 b=AQApzhFVgasYdedOCr72HhLo7hlB+vKDLWRc+SEo0xdhor1owu2ox/ucwg9ODmlt+Oxx6CaiT1WK3GF1mY1bqpNUBWKqe5yURDcNKrWYtu5igFdXwT2VlxjY6T/Wju1XprLga3oWLdR6r+xburm+1/DxNx6K1dnB1d8/0Son/5E=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0760.namprd04.prod.outlook.com (2603:10b6:903:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 08:21:08 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 08:21:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] zonefs: introduce helper for zone management
Thread-Topic: [PATCH v3 1/3] zonefs: introduce helper for zone management
Thread-Index: AQHWh0htghzcnPDzeEWbDXMuT5e+iw==
Date:   Thu, 10 Sep 2020 08:21:08 +0000
Message-ID: <CY4PR04MB3751170ACE8A6E3973442D22E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200910075957.7307-1-johannes.thumshirn@wdc.com>
 <20200910075957.7307-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:dc48:bbfc:f5cc:32c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d7b60a1-e46c-4845-8e10-08d85562787c
x-ms-traffictypediagnostic: CY4PR04MB0760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0760E9E27E45892C5BDF6D34E7270@CY4PR04MB0760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDW/iX2X2DCD2PbiDB5NQsazl5jT2QBkvRmnvnkZnbhYeU1b7Jx+F8gN5P5dPxYIMCt6UTPTADOMc/ONLRHhDOfQoMnPPuXgHoWpbQfbqdTHkUcMnQbzQJIBSELSL21FDBCdzt9iVBxXBdI0NEvawOh/MWZ1xjKgmIxukqAHW+9Ex3bCOte8ZGX61WsHrU1PiEzgV7Erixt7zmbH2VCn5ysUwxekaoT5YtZVniPuGvGWnaPHHCoBcA8TslDy6AXMEeRzMPC7zngp0hAyHr7vpu4TxM1BirsdOmeQDQGIExwsbDpYiAIcd9N6AB7jehsHlE6RmuDaKZ3MG+m5RN3qKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(66946007)(6636002)(71200400001)(91956017)(83380400001)(76116006)(55016002)(316002)(53546011)(86362001)(6506007)(33656002)(9686003)(7696005)(66556008)(66476007)(64756008)(66446008)(5660300002)(8676002)(4326008)(2906002)(8936002)(52536014)(478600001)(186003)(6862004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yEFBHhBJXZ7XI9fH5t0AowQjOwgQuj8TiRrML0rDgs1R6WG35uMuIFRHqz7PtpMZZx6rz82toeNI901rcPXMtPyS5oAOpZONPGG6u336XiMxLuph8I9Szblf6ALOcIJarRoO/p2P6JJoxDWwkE0aCWkDG3dAKvZQE4CfXIvzlZhEcdl/j5xUBzhvmCFzyxC420cCu79NKxeHqDJz5X0LhZYBRaI5X2N4ArLzs2GxO6+BzNn0XgtbT9wl+B0KjwxoxCv4CesSniCJQizrozcV45KW4ifmuBM6aD5YJyOV0X/wZbXOYU5KfkcBFlIFsSN6jv5CujrctU1LCZYHXn1uxBG8VSlCP1nPVZgVu9U8Jfi36bqgzn1ReRkD63PqXaZqOTwQ8GxRo+EhCKSmjuDtqo6x0k6jTDr/i9qTTQOfLfzzlsGaVCxwx2rCpL2VokrrHNoPnF15bThzs29VKr/Nh1l0iohXEZ304N/xXHt00JiSemckWai83B1sqJN8/BrRY5lNPBHU08B8WSyXXTmZGnXH4eTZLBGUiC4V/uoVI/jPhl0Wk76tiFxrpSGT+pN2Aj89RDvV1m2L/1AacZItjwBw3clpR9YLFTeBb2s4MNciV27xIY5QZox26h1cV3bEHlrKi+S9w657hoqS6oEXVDKftr7XbuSIVrBZEZ9zUs4+uotK6nOtWLshY24wMb/GPMcO30ro6RACe/Flc8LhlQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7b60a1-e46c-4845-8e10-08d85562787c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 08:21:08.8125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OFhOS7FCmGlxUZrqnQYzN6llA+mMGm4HfRJQMweFu5FPYFnK0bywOBBSwCCceIJ4rmvSY680obGhtdXKRwN4tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0760
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/10 17:00, Johannes Thumshirn wrote:=0A=
> Introduce a helper function for sending zone management commands to the=
=0A=
> block device.=0A=
> =0A=
> As zone management commands can change a zone write pointer position=0A=
> reflected in the size of the zone file, this function expects the truncat=
e=0A=
> mutex to be held.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> ---=0A=
> Changes to v2:=0A=
> - add missing '\n'=0A=
> =0A=
> Changes to v1:=0A=
> - centralize failure logging=0A=
> ---=0A=
>  fs/zonefs/super.c | 29 ++++++++++++++++++++++-------=0A=
>  1 file changed, 22 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 8ec7c8f109d7..6e13a5127b01 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -24,6 +24,26 @@=0A=
>  =0A=
>  #include "zonefs.h"=0A=
>  =0A=
> +static inline int zonefs_zone_mgmt(struct inode *inode,=0A=
> +				   enum req_opf op)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +	int ret;=0A=
> +=0A=
> +	lockdep_assert_held(&zi->i_truncate_mutex);=0A=
> +=0A=
> +	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,=0A=
> +			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);=0A=
> +	if (ret) {=0A=
> +		zonefs_err(inode->i_sb,=0A=
> +			   "Zone management operation %s at %llu failed %d\n",=0A=
> +			   blk_op_str(op), zi->i_zsector, ret);=0A=
> +		return ret;=0A=
> +	}=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t=
 length,=0A=
>  			      unsigned int flags, struct iomap *iomap,=0A=
>  			      struct iomap *srcmap)=0A=
> @@ -397,14 +417,9 @@ static int zonefs_file_truncate(struct inode *inode,=
 loff_t isize)=0A=
>  	if (isize =3D=3D old_isize)=0A=
>  		goto unlock;=0A=
>  =0A=
> -	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,=0A=
> -			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);=0A=
> -	if (ret) {=0A=
> -		zonefs_err(inode->i_sb,=0A=
> -			   "Zone management operation at %llu failed %d",=0A=
> -			   zi->i_zsector, ret);=0A=
> +	ret =3D zonefs_zone_mgmt(inode, op);=0A=
> +	if (ret)=0A=
>  		goto unlock;=0A=
> -	}=0A=
>  =0A=
>  	zonefs_update_stats(inode, isize);=0A=
>  	truncate_setsize(inode, isize);=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
