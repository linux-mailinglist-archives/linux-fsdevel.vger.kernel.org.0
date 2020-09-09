Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE21262EC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgIIMyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 08:54:14 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17637 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbgIIMxh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599656023; x=1631192023;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MNNhQ5Ny+qEg4JzQ9yAe9URIKQ6NxwbnWAKW56hqaA0=;
  b=F0Zb6r0RiLq7IBMOasTpoQFDxt7Hk8A+g7CLukpTrCY+wnDF/i4lUBnW
   QSY60CGcom2yBSIKYX4ezGz9eFDiD0zdqDytISKc9IBrOeb2gK4Jw04rZ
   d/3TmK5DXmpdRJyEG4UAYU3CVxSLL66Y6sBp9PZsa8IfwnlZIeWZrGzem
   tBm13AaPOc4FaL95s+nFN+9a9jreIVvu3XR1vbXUE5qjFMeTRqA/Y8oFP
   88fC7c5Q32gtuUossDLfQDX8hOg9+l17ePFt+nmQuxv9fK5XRjBYYKurk
   1gx8vmCuZLqFft2JTnmiyekNdrsDOzNCrSp+hZ9Ep+RATYZ/pGxD5n4pj
   A==;
IronPort-SDR: JLib7vCwjbdaIfgoY0YhfwB/CmsMZSjG+S2fBPm+80TXvgNNekE6Trxd5xdLAsFtk1EBP5hjUX
 kE8Pt1WiyUPVSIQ8/7G0xQJP4B5YRIu8hr820EN5VSatknK4M2f2P7PNn13MD+XMpibXzqrcPu
 Zj3S+cGp6NPK87oDCquTu7vt/+DgRRSFrmFGjdyFVXdfEdOj0FlTwiXO5pOdRcH7uQCu/oFjvQ
 +2Vy8jzHS+Z1/bjwDJt2hBmx+HOeHEpF2Fob2uom9yHbx001tCP2DIGN+Y2VAJdFPHYsB9r4Lv
 gds=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="148152039"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 20:43:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NanqDoJ+3hIPlayQs68KCDnZ773jQxkx+XyfSpnOWGRnhNaXhgLGaR4l81kJGBNTQ1rOmeMoQ5ycjm9AI8nmB+rctdbxK6b1l+kuKlIbUOK1Guo76vpE9t8bVfwT9HKQ1qLrTobrNCEz6Fz8t4qteJ5GHjzMpNQMjZdJ0f8qTiAUYuPjTN6cu/tZYV2iEUj0V0eXC9Lx/DXNHjeHVkMgkOEoFjcLv/v7Oi4rozYBIdr6ZTk0yIakhkQly4ZuDC3gLU/GDQdt2zU+M6eHJnfqIG3u++ZaBqWG1aRHEjjEhVjIdEwhTOhkzZN/llmPS+i34X+xxMB+dSlueiZvY05vKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zchHDUIKJYRiOVmB4q2vP510S2ahBqi865MpyyqvHYM=;
 b=hFtRw1lvfgZd6KSrAcI9HnqxOlWlpKF3GXVDWEWO6dvdVgtPo6kAX3KdOOr0X+4GPki9QuYnL73k1EbbU8ktrEWKC1GIhxWSixqkh2WFwMDTPlhhOl2NuPuTqo4uxJFka77Z2FxJiQ4/Xyddwwf2RpUjkLrdRj2Kwq4JeByrMtESivNSKFBhK6QaeyJYcWK5CFO1VXodebVgaRCCgdGAq+D3DYuZvLRF5Oy72rKA5LAe6xinRp424JVhtBJPqNJPGY3jm/e9fXw70vbtbMrGIONzUVG5rCAHOqYMTi+HksaNOiRFG0eY7jKvLjkWDWetf6AYkPXyNib+6gpx4FSoKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zchHDUIKJYRiOVmB4q2vP510S2ahBqi865MpyyqvHYM=;
 b=rhfjMSMuacAqoYFN+be3CiGGjmECCj6Ex75P27JwH5iwrvrlL8LvzyqVbVUjYRcfMsY3KP4GuYOrfcdNEBlswkH2JSiYuejBQkHP9KOJ3VbXblvLt2GNWEmg6jKPJrOg3lTvS0tQ0prlRp5va9xXyPKBSaxMwXP7D7cmqQOrLwM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0374.namprd04.prod.outlook.com (2603:10b6:903:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 12:43:28 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 12:43:28 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] zonefs: introduce helper for zone management
Thread-Topic: [PATCH v2 1/3] zonefs: introduce helper for zone management
Thread-Index: AQHWhpOxULvZ1tIzsU24cdJHudOQgw==
Date:   Wed, 9 Sep 2020 12:43:28 +0000
Message-ID: <CY4PR04MB375130E0FFC0A1438D346E89E7260@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
 <20200909102614.40585-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1c31:4ce8:636b:3f7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 595b118b-2a02-486c-aeb5-08d854bdf36a
x-ms-traffictypediagnostic: CY4PR04MB0374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0374C3A00BA26579CCD87CF5E7260@CY4PR04MB0374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T9PdFECAAOZTefqHuV1JjdMQYr1wv4Bon+5jmt5ohAXUOM/6bDLZcn/CzrVN3v2IdoTaZhTL/qghzD8nPksu4LV4yyswcjo2QccNeRGkjs9rhTTMn8ZfNqk0r8TjldvoA1hrGuRftgkJVtkKy7mVVcSQCyyuKWrliasq6FpcrmRR6/p2kcvWJE5lYZMY7ZN5yRB8bVGRI3PuFBdU9sPgByTA4lpY43S2BSeRj0EShDU9wruccuZpqycO+WmkRRL56ARHQKx1CYhkjBRWuwOGPSgvXOBQLLlp7uQurVlDlMp0pMVNiviouGTzQ/eQOh2YA4c59P6UW0ZOHwSzoa9tKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(55016002)(478600001)(53546011)(6506007)(7696005)(9686003)(6862004)(86362001)(2906002)(6636002)(5660300002)(4326008)(52536014)(76116006)(66946007)(316002)(83380400001)(8676002)(66446008)(66476007)(64756008)(66556008)(91956017)(33656002)(186003)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: IicC8xGepWwads1Z3zzmnuCg1FuHEsDWU4qk+6SokyW9sopo6hmyH0CoHk1SmzCI0FN6lVTZ/dVq5LVArcCD9G78Wu5sTQBl/vYliDdfEdVk76MCQy8vKeoDYd6lJtGOpcC2539Nyxhb4972AmpdnKAK6Bjru1SZVZDDLyZth9fd5QdLktIUPnwH3neNmuHv0iQtXoX6Qow5z1SMB9rrBDUKUjsFk0TnymCzBH+d3CXGj92z5UAUX79bCwCELXZ2dfeC7E2SP03V9O0kOM7H+NpZsqCt2Eaj50Gzi/IZRqbvW17UOSzUrHZkzeq/MHGnPxwq12Bte9/EFJ7y+1BXoDMCWayOnGS5Z7+owUry3q3HeRQrE6m6zFZ92GN/WRczi1soM8F+i6ZsWfIsuLoCJy3bFj6ICPVOMaHS2zqSIuskI5lZAkEl198XMu23y1GGKCSriYHGq0JjC9OegfIyxwu5E3JRqFarN32WVRCz4RX03Ilgy0gUbXlgJnNrVp/0R7QUaXrkgpntYMgYZCCU0+A8Kk1NKhIZ3Yi97DHwjnyTiEwsFlJH2KqQSV/EHxBoKN+fY/SOA0tG32gD7oGMKIUGlQ1Jh0n1odTqogHRcPx0LClu1kQaa/8upWVyYRFVV+I86INNX3qVh+LY7pFYhxvq/XaLBsuTcPmuF848vUIWVxjs2ElN5LV4ZDme75yLYEKvH4KkU+WiyKJ4CS35gw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595b118b-2a02-486c-aeb5-08d854bdf36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 12:43:28.1892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GpMrzfh8hfsD785dek3JB8K+KRY3O7NAmNFFkW4pGgWZcuRbclrO/WG5wSRbWAmen6IUtc5Tb7+/iql75iieiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0374
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/09 19:26, Johannes Thumshirn wrote:=0A=
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
> Changes to v1:=0A=
> - centralize failure logging=0A=
> ---=0A=
>  fs/zonefs/super.c | 29 ++++++++++++++++++++++-------=0A=
>  1 file changed, 22 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 8ec7c8f109d7..dc828bd1210b 100644=0A=
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
> +			   "Zone management operation %s at %llu failed %d",=0A=
=0A=
It looks like it was not there in the first place, but there is a "\n" miss=
ing=0A=
at the end of the format string.=0A=
=0A=
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
Apart from the nit above, looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
