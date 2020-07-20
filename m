Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C537225E9F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 14:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGTMfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 08:35:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:5380 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbgGTMfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595248499; x=1626784499;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+haA79o1PBqtkiNweiTLpULIL4B1seEGhjmhkh/qIV4=;
  b=aUzrFwTSiFPIMbixcv79XP+Ld9F2yEeIf4BarYKPuOFdgxTGsRP2EuG5
   I7aJoJssYc2c18+dWqM4eCpQSwWp959P6WjQKb3tQF+YqDOoPNt8Ts9YN
   vo+oftvwuMMOikb4cj51NvCiegtdVM7hOB2C9/Nd0ahKTIpyiZzl2luqa
   PYH+OmI2fWjTA9KwB/SBYppb0VWMSKN7+X1GOmPPL9gg9XgDJOd9MPsiF
   ZIxjcKLK1Z60cBh9jNpeKSj9uGKd+N8TiYmWDe9nZlMJqdtpEWKxO1cEW
   WFjof1uy3c/lbJTjWXFzsWaG8tR4NCb5mAYF9oMi9+hQhuKRY4I9lwXED
   w==;
IronPort-SDR: KnsJ76rWqvE/pKzbcM5SNtLJWvmmPi9Dwz35dFFyqL3MMAxzUZiUCDHHVC1ROrmC1R2XZeEZBz
 irAB6puBFOLxR0Lbzh8d48Hh5IW/7e7FGJagS4JM8iXuFbZfdVLFkko98Ll70K1Ffi7IkIrV+6
 kLSpX8QyQnT0sXAlvztv3JZQa7LXVNufWflR3oIaebwcvAi9yqDXtRNoK9CVqNekkft6LXdDIu
 8wo9y4BNLcHRe7yOe/EBA2pwWOzd9QE7JAYPXgbJbwCadQ+eysc5M6yvh6upiekP0f11/7Lffy
 wn0=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="144184030"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 20:34:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFbRBLtBU67Xk5lT10XX9OG6k9yKmnGARtl+Cvaz4/A6ATv9kZtQXQhpVUzWVbFwzq/pac/bfnJlf8DLM9YKe/21ASy72KmKE+xDvyDgSFQcpx6Yxs64FTLuP4bBR2P3w9vdLIFZDgxiBEP3HjVMnJx2oORneyhqe9Y4HHZdxElmj8jwUKrEWqZfS99kNOiiC1c+JYe3dl0INU3H32S5lSAPC5Dqtz4bTTaE0ES93neWB2tZ9VtCkIOalI3dJ2vsxU+j5xrzbSoxraDnqyJEZVtqPtoRUch08s8ajdnTRR3hEa37lu1k4D9+D84CzRwNXNhil+fLDxWJcHb/xiprKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bco847PVqOom3AhsUFrhE07Nh6Zieu4AcIlba9Kut8E=;
 b=jl6x2iJ2r9TMhXaiedbOdaxzAQ6dA5xOFiU6rkvbDpIxjpdrTjhcdxL9iGtGiz5V4QmvRWIXFx79SoQQjiLv07WuqZCSokG+5Loprxez3k4/r5cuZqFSrdQDxjpd0vHyHfa7Q76EYIcAVLb640ziGmvMezyW1rmRK5vULBbMAovrO/eQF1uqVeAU3b1UpycKphRL5zaaI7nW6YbxYwXGBoZoulPq4xkAwOcE799Cf/AEfiiFvoUdUWGHR5llUtsGHl2/fwT1gRQPp1k7fCKijlIVfV07a/FahL/hyJHCtHYt3ydNh2JHuNmcpD15G4Lzp2JtoD0mExgC4sbj4lzswg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bco847PVqOom3AhsUFrhE07Nh6Zieu4AcIlba9Kut8E=;
 b=PLYgO9j5bi8CgfYpz8I6AVMH3JLUaGiB8jpQMBrZ+RdI+yhacYlAdiVHxkfLz+Bqcx0W+rqAzDVeyCrj5jqAcdSbqO+F7NZ3iHmP4XjkLXvQRh3rVX6ijbdbLzrrYU3AWVOlU4ug8Mruwks56neUqzwcxaZfvZVCLWFKSfwcdMU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3636.namprd04.prod.outlook.com (2603:10b6:910:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 12:34:57 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 12:34:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] zonefs: add zone-capacity support
Thread-Topic: [PATCH v3 1/2] zonefs: add zone-capacity support
Thread-Index: AQHWXpFiAiOWUFMiLkqkaLlmvGI/vQ==
Date:   Mon, 20 Jul 2020 12:34:56 +0000
Message-ID: <CY4PR04MB37519A139219C1D788BCA048E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720122903.6221-1-johannes.thumshirn@wdc.com>
 <20200720122903.6221-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6606a184-4ed9-46d0-0e09-08d82ca94fbe
x-ms-traffictypediagnostic: CY4PR0401MB3636:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB3636E21D4426BC846DAB60BAE77B0@CY4PR0401MB3636.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c8CIK9ZeNjz96V19Il96mrj1u4NQE/+4eDporDHggcB7xEtEUtkVGpoyNYheKloYGHHrbc7MZmWOHuBwQsj6ppmhHVHbnNUGKbMhvl90X6uQbNvkKAUVw2fOXiBzJAAZl1vg/VfOArK51iTKz8D4XHynjR1YTRlLvnebQhR//qQWn+XR+XUisZYLxBx4TX3RspIlkxZrIetQBhKsD4wMosTRWwbtYWMOAl06oEWIpIGV2dIhXT9GlaWYLEtfkbIy6Yw2k3oheruxHj/TY6Do6ifXQEtvFs33P/LGgBo/Wbdh7eaQGATbuNf69sO/rvVz1EiKsEZOhaZlBEl+ZViFIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(71200400001)(6862004)(6636002)(33656002)(83380400001)(55016002)(2906002)(52536014)(9686003)(4326008)(478600001)(186003)(53546011)(66446008)(316002)(5660300002)(66476007)(66946007)(26005)(76116006)(91956017)(66556008)(86362001)(8676002)(7696005)(8936002)(64756008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ancjp0cdrTtPqFcg0b26n5dkhF7QwaB8C6VQ814brHkDJLRMkoY4wNO3dT/ZNCoJWCCloUt8xfV/78U2DKYqh7BjzcVBlrHQAzjJBsnw5KWTVMP80eUrBS15NMSNs+YHumsz486KsSkAze48s1Wc2rxrhzYiwxfhHRWWeMmdUhjsIS6TeJ1flcARahZS7qnS2e+JqJcDWRrbMDqVOkDx2acPaQ7Is54kWHWq/aEVg7nWd0FY8NwXek1H+Psz3I5d0MSMsZDW4EDh3mPkqXzkwqPNazK64f0kP2iaNUlvejeMAsMvYb6YvbIkf666mjlcJ0FjOjBsv22yBlN6d7bDQhJq83XIwNwa6knNwVnSQT0Y8yNPjlME9xb2zSF4FfXlSO8njRI66MqZNKjEMVCF/hnMKvA5z1pCxRP3vzqkb5TAJ0hbmDTwOzktoKmVyWS9beta2soW/Uj41PziMmMY5EB2Ynl5PKC++I01las0L3Lhn6lTX9zoayX9BGKrZkdZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6606a184-4ed9-46d0-0e09-08d82ca94fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 12:34:57.0016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKwL40ki2cQkbFEYcs93+dACqwnfwR+rlWWtGoIfNj/8oAj3K0E+bLCNOs45rqUMKwEEI4o1QOwQD5BkGDDNww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3636
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/20 21:29, Johannes Thumshirn wrote:=0A=
> In the zoned storage model, the sectors within a zone are typically all=
=0A=
> writeable. With the introduction of the Zoned Namespace (ZNS) Command=0A=
> Set in the NVM Express organization, the model was extended to have a=0A=
> specific writeable capacity.=0A=
> =0A=
> This zone capacity can be less than the overall zone size for a NVMe ZNS=
=0A=
> device or null_blk in zoned-mode. For other ZBC/ZAC devices the zone=0A=
> capacity is always equal to the zone size.=0A=
> =0A=
> Use the zone capacity field instead from blk_zone for determining the=0A=
> maximum inode size and inode blocks in zonefs.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c  | 15 +++++++++++----=0A=
>  fs/zonefs/zonefs.h |  3 +++=0A=
>  2 files changed, 14 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index abfb17f88f9a..b7aefb1b896f 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -335,7 +335,7 @@ static void zonefs_io_error(struct inode *inode, bool=
 write)=0A=
>  	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>  	unsigned int noio_flag;=0A=
>  	unsigned int nr_zones =3D=0A=
> -		zi->i_max_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);=0A=
> +		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);=0A=
>  	struct zonefs_ioerr_data err =3D {=0A=
>  		.inode =3D inode,=0A=
>  		.write =3D write,=0A=
> @@ -398,7 +398,7 @@ static int zonefs_file_truncate(struct inode *inode, =
loff_t isize)=0A=
>  		goto unlock;=0A=
>  =0A=
>  	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,=0A=
> -			       zi->i_max_size >> SECTOR_SHIFT, GFP_NOFS);=0A=
> +			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);=0A=
>  	if (ret) {=0A=
>  		zonefs_err(inode->i_sb,=0A=
>  			   "Zone management operation at %llu failed %d",=0A=
> @@ -1050,14 +1050,16 @@ static void zonefs_init_file_inode(struct inode *=
inode, struct blk_zone *zone,=0A=
>  =0A=
>  	zi->i_ztype =3D type;=0A=
>  	zi->i_zsector =3D zone->start;=0A=
> +	zi->i_zone_size =3D zone->len << SECTOR_SHIFT;=0A=
> +=0A=
>  	zi->i_max_size =3D min_t(loff_t, MAX_LFS_FILESIZE,=0A=
> -			       zone->len << SECTOR_SHIFT);=0A=
> +			       zone->capacity << SECTOR_SHIFT);=0A=
>  	zi->i_wpoffset =3D zonefs_check_zone_condition(inode, zone, true, true)=
;=0A=
>  =0A=
>  	inode->i_uid =3D sbi->s_uid;=0A=
>  	inode->i_gid =3D sbi->s_gid;=0A=
>  	inode->i_size =3D zi->i_wpoffset;=0A=
> -	inode->i_blocks =3D zone->len;=0A=
> +	inode->i_blocks =3D zi->i_max_size >> SECTOR_SHIFT;=0A=
>  =0A=
>  	inode->i_op =3D &zonefs_file_inode_operations;=0A=
>  	inode->i_fop =3D &zonefs_file_operations;=0A=
> @@ -1164,12 +1166,17 @@ static int zonefs_create_zgroup(struct zonefs_zon=
e_data *zd,=0A=
>  				if (zonefs_zone_type(next) !=3D type)=0A=
>  					break;=0A=
>  				zone->len +=3D next->len;=0A=
> +				zone->capacity +=3D next->capacity;=0A=
>  				if (next->cond =3D=3D BLK_ZONE_COND_READONLY &&=0A=
>  				    zone->cond !=3D BLK_ZONE_COND_OFFLINE)=0A=
>  					zone->cond =3D BLK_ZONE_COND_READONLY;=0A=
>  				else if (next->cond =3D=3D BLK_ZONE_COND_OFFLINE)=0A=
>  					zone->cond =3D BLK_ZONE_COND_OFFLINE;=0A=
>  			}=0A=
> +			if (zone->capacity !=3D zone->len) {=0A=
> +				zonefs_err(sb, "Invalid conventional zone capacity\n");=0A=
> +				ret =3D -EINVAL;=0A=
=0A=
Need "goto free;" here. Forgot it too in the code snippet I sent..=0A=
=0A=
> +			}=0A=
>  		}=0A=
>  =0A=
>  		/*=0A=
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h=0A=
> index ad17fef7ce91..55b39970acb2 100644=0A=
> --- a/fs/zonefs/zonefs.h=0A=
> +++ b/fs/zonefs/zonefs.h=0A=
> @@ -56,6 +56,9 @@ struct zonefs_inode_info {=0A=
>  	/* File maximum size */=0A=
>  	loff_t			i_max_size;=0A=
>  =0A=
> +	/* File zone size */=0A=
> +	loff_t			i_zone_size;=0A=
> +=0A=
>  	/*=0A=
>  	 * To serialise fully against both syscall and mmap based IO and=0A=
>  	 * sequential file truncation, two locks are used. For serializing=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
