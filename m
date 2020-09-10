Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8AF263FE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 10:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgIJIcK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 04:32:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21439 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbgIJIbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599726730; x=1631262730;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NZkLfDxUi4p7RWYuxgdjZChG83JzqvMs1wtwazw8iAI=;
  b=V10HtXW5G0oNSXJnsOYWDO0vMuDMiB++x3jti67dtP/QxpuRrdKOn4u+
   TwHa5GcFRHMxhD5dMg2+hbFqiieAZpfEO1cNQVxkM574sCkO6Ug24wsFa
   viL1XrUZJXEvWAjyh7REf4/OCkDzbd1PALZwWk0BhwdTYSABV8mi7eXfF
   9wiWLWx99bKn1wnY+Kx5XZiIoxe/e5wZjPpu79Q+scEEnXXBuIGGJLvgo
   tex7OkbtDCBrpAKvkKb+Unb4RBI7ZvlgleCukqnj6MV7K53l80YAD6XgL
   YnEzZluU8rqbfQaNeofOj3hyf2IRPINPG4wa9KOObxHlvcqe66zunCvIx
   w==;
IronPort-SDR: YP+h0oG6Ylt6XgdQZvVsHAoiZEoLUXdBUQSbdPUf37HyuvzVnjN4u66NcLRiLh+Hn+8UdPKrwS
 tStkGfik/+fT3wx/FfqxPWhTat7JHzZYPzDh0dFS+FqbMtoi6bK/eAoGDrMH0Qr5B2pE9DWTuc
 naQcGtalm3SOgD2/rotn1kmv9H0PoTkeBZ1x8YUl68n7la0IP1IJDojRsF6UdWK1Iy6ImXE+wp
 yf5uCpeSHT7DIavR1BmC00rISvjUbiw6RhuUGAdl3L8lvT1ocHox+vXXKsoNZVgrpV8507g6b1
 GaE=
X-IronPort-AV: E=Sophos;i="5.76,412,1592841600"; 
   d="scan'208";a="250312001"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 16:32:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn/s5nytDC9HWjN1Kjt2EhtrFHLrEhl3FbTngPv9CY19o0De0tGDHBF4iRWs7/6y8xeSxcy/kpm34Sm7g5LRWwHHgpZdksX7LfS8lzVD9ZT5gCNpFSpPgn3LHQEAXqNaC6Z026VEMsaYttSkwTHOdXDGkTrH/VxuZhr/0DasBN6LJ+vDky1wkcQ7LCSWeB+oFFllcX0bGHI5MgQsTnC0UGR+RSlxsJbADkPcUyf3SK8zNhf7N6AeOc2CCIhLbLb/x/YeJu8bwZhd7UwnRRfhhl5XvY2t2HvuKfnG37nOmQClsU84MbpmOFC+B8/cdXaan0fKnm+juP9qf0bsTOmxXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSPs/qiL7BBJl83//92y28UxMQbQO2Xz5aLb4SKrdxA=;
 b=kwyCFvZvbcrv7pZOm4Mi566P2eatCmBQMjBDDAYUwHqsCBY12Dq4rtGX6pCbgPSm8bMX0gQ/VycG79jDducR8JFBEUs91XXp0wfM67TNkBwCakaRCKyo5gOOEDe2ZPDdLEBVkFD6AY0nFHscgPEfjyf0FawMnKesUfCHRelfuYUoW3lxO1HgUPBF1qHThCgfycBznGLTtzPaS8a7tbZhaaZugkrb8ocGNavDR6f00SixgeuywtHelCJwj7zPXxNJu0r+SrtlgzM3/Pk+u9udZcHZfySd5/fNRZg5UW7iUOGIob32u/4aHNDqfMVwQ9n7orCE+WzmNjr6R2L5+0ADRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSPs/qiL7BBJl83//92y28UxMQbQO2Xz5aLb4SKrdxA=;
 b=hSejTneeToUs4TpJ5sRWuqDidnFm24QG966zHvv5pQqlh+XmqotX/hMgpY4bnsCCe0xg4ZWKbyqHQQNjfd7GJJtmjfIvRAVaPAc2plRlH1T9yUxnXWLb9oCDM8L2ZvL6Hus6qmIVkcZGUrSeOwlPJCutFp0lc0bbC5AFo8aS2qM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1031.namprd04.prod.outlook.com (2603:10b6:910:51::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 10 Sep
 2020 08:31:35 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 08:31:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH v3 2/3] zonefs: open/close zone on file open/close
Thread-Index: AQHWh0hw9oz3UtCFPEyhM7qLqlQ7TQ==
Date:   Thu, 10 Sep 2020 08:31:34 +0000
Message-ID: <CY4PR04MB3751BBFE03D7DD81765EA3AAE7270@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200910075957.7307-1-johannes.thumshirn@wdc.com>
 <20200910075957.7307-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:dc48:bbfc:f5cc:32c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c78bdb3-b5fc-4f8a-9314-08d85563eda1
x-ms-traffictypediagnostic: CY4PR04MB1031:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB10314A2B33A62C7869C80659E7270@CY4PR04MB1031.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8sJ2SH/vx2FkzEQKt9iGzJGKV2QAy5GNnOhnmLBmpr1KTFRMnm3UlOgH2Ez6qR/neYvRxe2tTqI8PcG/DkYT7e1jCgaTAl32fQ26L6b30eRMx4rJeA7CeZ8wmw6PMrgtl3v7xGKJXTdPRbl8oyLrDxkAG8YQ3qV7CV+I4sKAUXyspdZu5+Wibp31q0NAFprTfbuYHqOu8lLdOXrFJ0yh1Op9yDxLf1QNF2Ai5YXCjMhcRKaTadoSigJP8ALb9itQks65OxpjfHtiY0HAfgj4R34DSCNtyVtVKsla60C8Jzi/eUQd1FYYBgkSjw9kOizYNQhZze6fFJhqOs4MzudPcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(64756008)(7696005)(9686003)(6636002)(5660300002)(86362001)(478600001)(52536014)(71200400001)(66476007)(66946007)(30864003)(53546011)(91956017)(4326008)(6506007)(76116006)(186003)(2906002)(83380400001)(8936002)(6862004)(33656002)(66446008)(316002)(55016002)(8676002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VKqR+VCFHDVBID2H0bGo0uO2ZT4PB04mInV077wZjKfIlxfBRPcOuD545PX+zoVv8mNMDM/e0faeuAwE4+Lb8ExWTlgBOmGufpvz4efj/A6EMA9+5BYaBBMBN/FaHXouV8xd9x7FAC14I7Z0qZZ9OcewMKGafxMpneW+qONxzfYggRWwBh1/ToGeoAnGBU42RHvaIeSW2q4WYFsIMHgf2mNp00DPQ8y+Ml4ls6aJNLZwSqOPvnzJpUhR/0x6VF2f+E1R/xto7CLu7XnWBCvzBcICp/sHKFf/HF7mLHEgnX01VqZ+k57yrnzy3sm1LBSlV0UXUvo/pEtDyStmT0/HpwNM9N4UJKTbM+O/Bm3ToyH3cA5ch76W2xlwkhj5zeLOokjcKYmXfW9l9PMg+ol5u+sRz7dGGt1YUU/vh+OHwZoyynWywWO2XocDkSUX75rlLlGHyKDgWgSQ62cSWJv9R4kQ2wri1hlZtDd4bjbCz/nctZjT/O1/sQSfpErfzHH6ZGX8AUesrLOZbL1Z3q58pFq85vAHypPUUiMM7V1CnYdriBNvMNrQbUjUfMVKo5770K95fdW34r7qkXm1BI+LfvezoyZVdV5kW4tWurNyIIrKlA5yqUocRJSur7bFcpy9AaAAWyMdwnqFEt6YPDsiXsWncuKOs/OcusFqvMbE3DFs7guJ26BjR4eUbUQVoJDZFm1QvfKgbYw2RZ/H8O/euA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c78bdb3-b5fc-4f8a-9314-08d85563eda1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 08:31:34.8163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28NXF+xaFvqjjwbpuqK0NMw24qts1yEVNsvw20z1gABuTccmqoe44LezgyvbTtZ55F022vaTc6LBypAaGQDM7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1031
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/10 17:00, Johannes Thumshirn wrote:=0A=
> NVMe Zoned Namespace introduced the concept of active zones, which are=0A=
> zones in the implicit open, explicit open or closed condition. Drives may=
=0A=
> have a limit on the number of zones that can be simultaneously active.=0A=
> This potential limitation translate into a risk for applications to see=
=0A=
> write IO errors due to this limit if the zone of a file being written to =
is=0A=
> not already active when a write request is issued.=0A=
> =0A=
> To avoid these potential errors, the zone of a file can explicitly be mad=
e=0A=
> active using an open zone command when the file is open for the first=0A=
> time. If the zone open command succeeds, the application is then=0A=
> guaranteed that write requests can be processed. This indirect management=
=0A=
> of active zones relies on the maximum number of open zones of a drive,=0A=
> which is always lower or equal to the maximum number of active zones.=0A=
> =0A=
> On the first open of a sequential zone file, send a REQ_OP_ZONE_OPEN=0A=
> command to the block device. Conversely, on the last release of a zone=0A=
> file and send a REQ_OP_ZONE_CLOSE to the device if the zone is not full o=
r=0A=
> empty.=0A=
> =0A=
> As truncating a zone file to 0 or max can deactivate a zone as well, we=
=0A=
> need to serialize against truncates and also be careful not to close a=0A=
> zone as the file may still be open for writing, e.g. the user called=0A=
> ftruncate(). If the zone file is not open and a process does a truncate()=
,=0A=
> then no close operation is needed.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
> Changes to v2:=0A=
> - Clear open flag on error (Damien)=0A=
> ---=0A=
>  fs/zonefs/super.c  | 171 +++++++++++++++++++++++++++++++++++++++++++--=
=0A=
>  fs/zonefs/zonefs.h |  10 +++=0A=
>  2 files changed, 177 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 6e13a5127b01..749f022ae7f6 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -44,6 +44,80 @@ static inline int zonefs_zone_mgmt(struct inode *inode=
,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static int zonefs_open_zone(struct inode *inode)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
> +	int ret =3D 0;=0A=
> +=0A=
> +	mutex_lock(&zi->i_truncate_mutex);=0A=
> +=0A=
> +	zi->i_wr_refcnt++;=0A=
> +	if (zi->i_wr_refcnt =3D=3D 1) {=0A=
> +=0A=
> +		if (atomic_inc_return(&sbi->s_open_zones) > sbi->s_max_open_zones) {=
=0A=
> +			atomic_dec(&sbi->s_open_zones);=0A=
> +			ret =3D -EBUSY;=0A=
> +			goto unlock;=0A=
> +		}=0A=
> +=0A=
> +		if (i_size_read(inode) < zi->i_max_size) {=0A=
> +			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);=0A=
> +			if (ret) {=0A=
> +				zi->i_wr_refcnt--;=0A=
> +				atomic_dec(&sbi->s_open_zones);=0A=
> +				goto unlock;=0A=
> +			}=0A=
> +			zi->i_flags |=3D ZONEFS_ZONE_OPEN;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +unlock:=0A=
> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static int zonefs_close_zone(struct inode *inode)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +	int ret =3D 0;=0A=
> +=0A=
> +	mutex_lock(&zi->i_truncate_mutex);=0A=
> +=0A=
> +	zi->i_wr_refcnt--;=0A=
> +	if (!zi->i_wr_refcnt) {=0A=
> +		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
> +=0A=
> +		if (zi->i_flags & ZONEFS_ZONE_OPEN) {=0A=
> +			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);=0A=
> +			if (ret)=0A=
=0A=
It may be better to call zonefs_io_error(inode, false) here instead of in=
=0A=
zonefs_file_release(). The reason is that if the zone went read-only or off=
line,=0A=
you also want to do the atomic_dec(&sbi->s_open_zones)... This is important=
 if=0A=
the fs is mounted with repair, zone-ro or zone-offline option as the only z=
one=0A=
affected by error recovery is the one that was the source of the error. So =
with=0A=
these options, we do not want to keep that zone accounted as open in=0A=
s_open_zones counter...=0A=
=0A=
The other way to do this, may be simpler, would be to do the=0A=
atomic_dec(&sbi->s_open_zones) in zonefs_io_error() together with clearing =
the=0A=
ZONEFS_ZONE_OPEN flag.=0A=
=0A=
> +				goto unlock;=0A=
> +			zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;=0A=
> +		}=0A=
> +=0A=
> +		atomic_dec(&sbi->s_open_zones);=0A=
> +	}=0A=
> +=0A=
> +unlock:=0A=
> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static inline void zonefs_i_size_write(struct inode *inode, loff_t isize=
)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +=0A=
> +	i_size_write(inode, isize);=0A=
> +	/*=0A=
> +	 * A full zone is no longer open/active and does not need=0A=
> +	 * explicit closing.=0A=
> +	 */=0A=
> +	if (isize >=3D zi->i_max_size)=0A=
> +		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;=0A=
> +}=0A=
> +=0A=
>  static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t=
 length,=0A=
>  			      unsigned int flags, struct iomap *iomap,=0A=
>  			      struct iomap *srcmap)=0A=
> @@ -321,6 +395,17 @@ static int zonefs_io_error_cb(struct blk_zone *zone,=
 unsigned int idx,=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> +	/*=0A=
> +	 * If the filesystem is mounted with the explicit-open mount option, we=
=0A=
> +	 * need to clear the ZONEFS_ZONE_OPEN flag if the zone transitioned to=
=0A=
> +	 * the read-only or offline condition, to avoid attempting an explicit=
=0A=
> +	 * close of the zone when the inode file is closed.=0A=
> +	 */=0A=
> +	if ((sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) &&=0A=
> +	    (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE ||=0A=
> +	     zone->cond =3D=3D BLK_ZONE_COND_READONLY))=0A=
> +		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;=0A=
=0A=
See above: you need to decrement sbi->s_open_zones too.=0A=
=0A=
> +=0A=
>  	/*=0A=
>  	 * If error=3Dremount-ro was specified, any error result in remounting=
=0A=
>  	 * the volume as read-only.=0A=
> @@ -335,7 +420,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,=0A=
>  	 * invalid data.=0A=
>  	 */=0A=
>  	zonefs_update_stats(inode, data_size);=0A=
> -	i_size_write(inode, data_size);=0A=
> +	zonefs_i_size_write(inode, data_size);=0A=
>  	zi->i_wpoffset =3D data_size;=0A=
>  =0A=
>  	return 0;=0A=
> @@ -421,6 +506,25 @@ static int zonefs_file_truncate(struct inode *inode,=
 loff_t isize)=0A=
>  	if (ret)=0A=
>  		goto unlock;=0A=
>  =0A=
> +	/*=0A=
> +	 * If the mount option ZONEFS_MNTOPT_EXPLICIT_OPEN is set,=0A=
> +	 * take care of open zones.=0A=
> +	 */=0A=
> +	if (zi->i_flags & ZONEFS_ZONE_OPEN) {=0A=
> +		/*=0A=
> +		 * Truncating a zone to EMPTY or FULL is the equivalent of=0A=
> +		 * closing the zone. For a truncation to 0, we need to=0A=
> +		 * re-open the zone to ensure new writes can be processed.=0A=
> +		 * For a truncation to the maximum file size, the zone is=0A=
> +		 * closed and writes cannot be accepted anymore, so clear=0A=
> +		 * the open flag.=0A=
> +		 */=0A=
> +		if (!isize)=0A=
> +			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_OPEN);=0A=
> +		else=0A=
> +			zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;=0A=
> +	}=0A=
> +=0A=
>  	zonefs_update_stats(inode, isize);=0A=
>  	truncate_setsize(inode, isize);=0A=
>  	zi->i_wpoffset =3D isize;=0A=
> @@ -599,7 +703,7 @@ static int zonefs_file_write_dio_end_io(struct kiocb =
*iocb, ssize_t size,=0A=
>  		mutex_lock(&zi->i_truncate_mutex);=0A=
>  		if (i_size_read(inode) < iocb->ki_pos + size) {=0A=
>  			zonefs_update_stats(inode, iocb->ki_pos + size);=0A=
> -			i_size_write(inode, iocb->ki_pos + size);=0A=
> +			zonefs_i_size_write(inode, iocb->ki_pos + size);=0A=
>  		}=0A=
>  		mutex_unlock(&zi->i_truncate_mutex);=0A=
>  	}=0A=
> @@ -880,8 +984,55 @@ static ssize_t zonefs_file_read_iter(struct kiocb *i=
ocb, struct iov_iter *to)=0A=
>  	return ret;=0A=
>  }=0A=
>  =0A=
> +static inline bool zonefs_file_use_exp_open(struct inode *inode, struct =
file *file)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
> +=0A=
> +	if (!(sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN))=0A=
> +		return false;=0A=
> +=0A=
> +	if (zi->i_ztype !=3D ZONEFS_ZTYPE_SEQ)=0A=
> +		return false;=0A=
> +=0A=
> +	if (!(file->f_mode & FMODE_WRITE))=0A=
> +		return false;=0A=
> +=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +static int zonefs_file_open(struct inode *inode, struct file *file)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D generic_file_open(inode, file);=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	if (zonefs_file_use_exp_open(inode, file))=0A=
> +		return zonefs_open_zone(inode);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static int zonefs_file_release(struct inode *inode, struct file *file)=
=0A=
> +{=0A=
> +	/*=0A=
> +	 * If we explicitly open a zone we must close it again as well, but the=
=0A=
> +	 * zone management operation can fail (either due to an IO error or as=
=0A=
> +	 * the zone has gone offline or read-only). Make sure we don't fail the=
=0A=
> +	 * close(2) for user-space.=0A=
> +	 */=0A=
> +	if (zonefs_file_use_exp_open(inode, file))=0A=
> +		if (zonefs_close_zone(inode))=0A=
> +			zonefs_io_error(inode, false);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static const struct file_operations zonefs_file_operations =3D {=0A=
> -	.open		=3D generic_file_open,=0A=
> +	.open		=3D zonefs_file_open,=0A=
> +	.release	=3D zonefs_file_release,=0A=
>  	.fsync		=3D zonefs_file_fsync,=0A=
>  	.mmap		=3D zonefs_file_mmap,=0A=
>  	.llseek		=3D zonefs_file_llseek,=0A=
> @@ -905,6 +1056,7 @@ static struct inode *zonefs_alloc_inode(struct super=
_block *sb)=0A=
>  	inode_init_once(&zi->i_vnode);=0A=
>  	mutex_init(&zi->i_truncate_mutex);=0A=
>  	init_rwsem(&zi->i_mmap_sem);=0A=
> +	zi->i_wr_refcnt =3D 0;=0A=
>  =0A=
>  	return &zi->i_vnode;=0A=
>  }=0A=
> @@ -955,7 +1107,7 @@ static int zonefs_statfs(struct dentry *dentry, stru=
ct kstatfs *buf)=0A=
>  =0A=
>  enum {=0A=
>  	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,=0A=
> -	Opt_err,=0A=
> +	Opt_explicit_open, Opt_err,=0A=
>  };=0A=
>  =0A=
>  static const match_table_t tokens =3D {=0A=
> @@ -963,6 +1115,7 @@ static const match_table_t tokens =3D {=0A=
>  	{ Opt_errors_zro,	"errors=3Dzone-ro"},=0A=
>  	{ Opt_errors_zol,	"errors=3Dzone-offline"},=0A=
>  	{ Opt_errors_repair,	"errors=3Drepair"},=0A=
> +	{ Opt_explicit_open,	"explicit-open" },=0A=
>  	{ Opt_err,		NULL}=0A=
>  };=0A=
>  =0A=
> @@ -999,6 +1152,9 @@ static int zonefs_parse_options(struct super_block *=
sb, char *options)=0A=
>  			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;=0A=
>  			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_REPAIR;=0A=
>  			break;=0A=
> +		case Opt_explicit_open:=0A=
> +			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_EXPLICIT_OPEN;=0A=
> +			break;=0A=
>  		default:=0A=
>  			return -EINVAL;=0A=
>  		}=0A=
> @@ -1418,6 +1574,13 @@ static int zonefs_fill_super(struct super_block *s=
b, void *data, int silent)=0A=
>  	sbi->s_gid =3D GLOBAL_ROOT_GID;=0A=
>  	sbi->s_perm =3D 0640;=0A=
>  	sbi->s_mount_opts =3D ZONEFS_MNTOPT_ERRORS_RO;=0A=
> +	sbi->s_max_open_zones =3D bdev_max_open_zones(sb->s_bdev);=0A=
> +	atomic_set(&sbi->s_open_zones, 0);=0A=
> +	if (!sbi->s_max_open_zones &&=0A=
> +	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {=0A=
> +		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount opt=
ion\n");=0A=
> +		sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_EXPLICIT_OPEN;=0A=
> +	}=0A=
>  =0A=
>  	ret =3D zonefs_read_super(sb);=0A=
>  	if (ret)=0A=
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h=0A=
> index 55b39970acb2..51141907097c 100644=0A=
> --- a/fs/zonefs/zonefs.h=0A=
> +++ b/fs/zonefs/zonefs.h=0A=
> @@ -38,6 +38,8 @@ static inline enum zonefs_ztype zonefs_zone_type(struct=
 blk_zone *zone)=0A=
>  	return ZONEFS_ZTYPE_SEQ;=0A=
>  }=0A=
>  =0A=
> +#define ZONEFS_ZONE_OPEN	(1 << 0)=0A=
> +=0A=
>  /*=0A=
>   * In-memory inode data.=0A=
>   */=0A=
> @@ -74,6 +76,10 @@ struct zonefs_inode_info {=0A=
>  	 */=0A=
>  	struct mutex		i_truncate_mutex;=0A=
>  	struct rw_semaphore	i_mmap_sem;=0A=
> +=0A=
> +	/* guarded by i_truncate_mutex */=0A=
> +	unsigned int		i_wr_refcnt;=0A=
> +	unsigned int		i_flags;=0A=
>  };=0A=
>  =0A=
>  static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)=0A=
> @@ -154,6 +160,7 @@ enum zonefs_features {=0A=
>  #define ZONEFS_MNTOPT_ERRORS_MASK	\=0A=
>  	(ZONEFS_MNTOPT_ERRORS_RO | ZONEFS_MNTOPT_ERRORS_ZRO | \=0A=
>  	 ZONEFS_MNTOPT_ERRORS_ZOL | ZONEFS_MNTOPT_ERRORS_REPAIR)=0A=
> +#define ZONEFS_MNTOPT_EXPLICIT_OPEN	(1 << 4) /* Explicit open/close of z=
ones on open/close */=0A=
>  =0A=
>  /*=0A=
>   * In-memory Super block information.=0A=
> @@ -175,6 +182,9 @@ struct zonefs_sb_info {=0A=
>  =0A=
>  	loff_t			s_blocks;=0A=
>  	loff_t			s_used_blocks;=0A=
> +=0A=
> +	unsigned int		s_max_open_zones;=0A=
> +	atomic_t		s_open_zones;=0A=
>  };=0A=
>  =0A=
>  static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
