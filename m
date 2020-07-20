Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90267225B49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGTJUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 05:20:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:49696 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgGTJUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595236814; x=1626772814;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XMhT0luJJHm/+DfAfaTw9kBWTozkyhC4mKZ89mYNeaU=;
  b=gxx5WZt1L9oipZ1Ynm4meirylWtlVhK/Zr7bhjtxIqKnlD/Ke3tEp71O
   LPebR74bcne//GfaQwgiJ4Vj1f6Mz4h/kRuEFC/Bv7vWi5WNtpU9QdzT+
   Jf/TzDEu0GPwVOV3hvoA4WnpHyxgqzCwOY1SevsCn9R3QNFe83uK3WsZD
   bgROWx6INas173LTTar5c1VZafkkAdxkGHHfpEoV1VIcac6oAewXrUjCC
   mRZG3Kz4+CebTrdwdMYtGfVrIGSVmZh4HskMegqmRzz/OSSgWIpNMlfwR
   B6xe13FjQsiskuMS2Fuy05VIGC9ZTsm5fOzFzhDVbzQ+BOg6QUc/DKSRl
   A==;
IronPort-SDR: eqr2Jgk6npcjlEJPlZZm1JDQl8Ns85HorwEuhRJc1PJrRsR8hjMxPCkNgIVDwiQcWfMxkofg14
 6x0JQoPC588U20bzClnYKBUIDZKgxgJNNBETHjC8O4nZm8j97cOzCgHVFWTJsJxddzplA3v6na
 xNa6YN1IwP1k/ebJuY7RachRWFJ8E6CTEbiA0uDrdx8u1jlBKz8YOqRactUdEBxFTCHykK0//C
 UUgnQKTDWPwo96DWCSnzrnfIPyVLK7GNuyLCKZKJujlZMmaNO3EOtInUZhf1WV0dC7Jg/50UcH
 p18=
X-IronPort-AV: E=Sophos;i="5.75,374,1589212800"; 
   d="scan'208";a="142902550"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jul 2020 17:20:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNqFtytXs0pfwMdd1vP8G3/GNlbwLfiSdFe5MfkIztG5qZ6Kz3VQPUJRgvoPyca9kyumrvj350YExOakAvmv9noa3KclIFmGOB1wE+KESNjF731g+K2lzbBt0o3t0HgbSa18qb6bfT9HtxM00dGrR7s2qqk5mUwFlv/vza5P9xU9MsEXOalHdGKWLfHbmmQcpr1vSgF1wkz7ZHIjhch9mljCNzhzfmimyZICzuJCfCFoZPXjWQJVDsuy0EuHPQx131H01OgKiWyKiU77r7X4yAQPs48/RaRsf5pCLWZsrFAP9UXqbsghqzQpe9pOCuns/qLAy4vG1SpNvKzBn4pIow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXm+yTIXpKb67do52opeRP8oMaA8cu5qhlAPfitBG3M=;
 b=HGwU9b55nYlvE0p8StRm1hN9RESY0XJhekbdzd9/CbcEUyznV+Y8EfghvcnzWepIrTJ1FZVvqyd9YlFaziY5MFbv8luyHYebhIRMvCaHFiHv/28U+dHI/OKoMh+n+5elyeNF47VefDLBzL2P8vYfQegVzTn6aBHBM1I5LWtb6Q1escnlwvXRPbTb6yuuewT1dds7++X3c4EMJxWgcPh3wM/t/qEtfnVVjt8FMcinXxQEqoRuCWMqOPNyLSnh6iuGH/ZI+XZa6ltwfxTYJEP/hA8WtVEGkyUK/Df8WJLxcKYMHnclkc5tQ/8LwPT2BuTC8drthDS7fXBK8SPdsHtIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXm+yTIXpKb67do52opeRP8oMaA8cu5qhlAPfitBG3M=;
 b=nQqdpt9ft99yAAUVb3ferru1bBkoM9VRW234qkp2Gjmf9pNMWN/7e6rob1Ep0NUulQMjellIpR3qY189YWlEcAMcu+oDfqSbP65Qo+/JdNPoke6JaT+yVcaogzQZIEObI1J7Wg1lzrxNyZ4To6KsRvRyegSeINmQglnDIu7rNos=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0343.namprd04.prod.outlook.com (2603:10b6:903:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 09:20:11 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:20:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] zonefs: add zone-capacity support
Thread-Topic: [PATCH v2 1/2] zonefs: add zone-capacity support
Thread-Index: AQHWXnMSScbt+Awg/EaeZ+kG8l2qhA==
Date:   Mon, 20 Jul 2020 09:20:11 +0000
Message-ID: <CY4PR04MB3751C4B5971BA6D6697BFF94E77B0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200720085208.27347-1-johannes.thumshirn@wdc.com>
 <20200720085208.27347-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d76c1bbe-3fe7-494d-23d1-08d82c8e1ab7
x-ms-traffictypediagnostic: CY4PR04MB0343:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB03434573133D8E9F42432ECDE77B0@CY4PR04MB0343.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Opod2ziSbmvTGE9Ep8mCMk2m3c8vpZHa+XviEBFUCyCfvJGumwG7v4TV9ufiH1rWKjnn51GsgfKlkkO2N6IurdqBSfxwUkJ08gtxnC0UIoqLxccrtDuFsmhrAN2d5ea+ItPLOqr5Uk3G86rAiNqkfxeSDngMOfnzcVMApd+Y5rhQ7mSI10KyoDEQwQdHsHD5p4XiHg9HXWmYhLFq4+Alue0ZXFDxO+B6adiXudx9X/Gfn8uXkq9kFgNNsAFjvz8J3vFMAg+5S4xzLBR5BCLJ54z9N+Zyn0hULeL8nACx45qFvhUJ8v4AJAFlzhZHs4SokzV/202PdyiEZ8qfaAEXxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(6636002)(8936002)(55016002)(7696005)(9686003)(316002)(91956017)(66476007)(5660300002)(33656002)(64756008)(76116006)(2906002)(66946007)(66446008)(86362001)(66556008)(83380400001)(71200400001)(52536014)(26005)(186003)(6862004)(8676002)(4326008)(478600001)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vCRh+uuz9XwatP9cAaFyFd//uAXH3ZmwVEWaJ6yLkDpgBT0O9jFcasVuxtpkz7WrIdG0MpScHtR4++duzii781xaBUM9Y9hYTd54fYvVmbSL/ge7AWSMP76Zt54MlUV3Lb7J/B4aHpA+YoFFIviRIOqZwgat3V+3+qBooLoafHzGCJbZg2EACDHqgCYIPmadrjjLNrzIClYZw7X8vRPT0kHN15v12uYi+LWMOGLFytW7hY5GOVsnXHR3Ee16EE2V3qz71E0//RR5Am89wbWShlyRghqq+VEwd6hmu2fHyzilc3osgYYorrdlCJkZYbpJ2Wi/X2y33ql/XmWszg0gdmfp1mPeAKGes5obGws9wtdkWl6pvrJi9WXvHRuCgk3IaCBMZiGWkLxIooi1O/3ZsEigDisyUqFIoScSKG24XclCMo1GQkNbLytqJq1AtnJJv+XtF9v7kBvO0r9QmzkX8MOtyWjjpPARrI5T8NUk0wknHQ78Nfp7eseSmXSK2Gbg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76c1bbe-3fe7-494d-23d1-08d82c8e1ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 09:20:11.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n+QFQbrlI7eAURoK10MObVH42X+tJYY4ILRRs8Y3Z84a2MQK7f8Ov4sWvHNJ8LlBmFy2BidsV1GVaPR/xMEMfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0343
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/20 17:52, Johannes Thumshirn wrote:=0A=
> In the zoned storage model, the sectors within a zone are typically all=
=0A=
> writeable. With the introduction of the Zoned Namespace (ZNS) Command=0A=
> Set in the NVM Express organization, the model was extended to have a=0A=
> specific writeable capacity.=0A=
> =0A=
> This zone capacity can be less than the overall zone size for a NVMe ZNS=
=0A=
> device. For other zoned block devices like ZBC or null_blk in zoned-mode=
=0A=
> the zone capacity is always equal to the zone size.=0A=
=0A=
null_blk has the zone_capacity option now to emulate ZNS smaller zone=0A=
capacities. But that option applies to sequential zones only. null_blk=0A=
conventional zones always have a capacity equal to zone size. Is it what yo=
u=0A=
meant to say here ?=0A=
=0A=
> =0A=
> Use the zone capacity field instead from blk_zone for determining the=0A=
> maximum inode size and inode blocks in zonefs.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c  | 11 +++++++----=0A=
>  fs/zonefs/zonefs.h |  3 +++=0A=
>  2 files changed, 10 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index b13c332a3513..337249f98cae 100644=0A=
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
> @@ -1051,14 +1051,16 @@ static void zonefs_init_file_inode(struct inode *=
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
> @@ -1169,6 +1171,7 @@ static int zonefs_create_zgroup(struct zonefs_zone_=
data *zd,=0A=
>  				else if (next->cond =3D=3D BLK_ZONE_COND_OFFLINE)=0A=
>  					zone->cond =3D BLK_ZONE_COND_OFFLINE;=0A=
>  			}=0A=
> +			zone->capacity =3D zone->len;=0A=
>  		}=0A=
=0A=
Normally, conventional zones on all known zoned devices will always have a =
zone=0A=
capacity equal to the zone size. But I would rather check that this is the =
case=0A=
here as the AGGRCNV option can only work if zone capacity is equal to the z=
one=0A=
size. So something like:=0A=
=0A=
=0A=
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
index abfb17f88f9a..db4853c7ec75 100644=0A=
--- a/fs/zonefs/super.c=0A=
+++ b/fs/zonefs/super.c=0A=
@@ -1164,12 +1164,17 @@ static int zonefs_create_zgroup(struct zonefs_zone_=
data *zd,=0A=
                                if (zonefs_zone_type(next) !=3D type)=0A=
                                        break;=0A=
                                zone->len +=3D next->len;=0A=
+                               zone->capacity +=3D next->capacity;=0A=
                                if (next->cond =3D=3D BLK_ZONE_COND_READONL=
Y &&=0A=
                                    zone->cond !=3D BLK_ZONE_COND_OFFLINE)=
=0A=
                                        zone->cond =3D BLK_ZONE_COND_READON=
LY;=0A=
                                else if (next->cond =3D=3D BLK_ZONE_COND_OF=
FLINE)=0A=
                                        zone->cond =3D BLK_ZONE_COND_OFFLIN=
E;=0A=
                        }=0A=
+                       if (zone->capacity !=3D zone->len) {=0A=
+                               zonefs_err(sb, "Invalid conventional zone=
=0A=
capacity\n");=0A=
+                               ret =3D -EINVAL;=0A=
+                       }=0A=
                }=0A=
=0A=
would be better.=0A=
=0A=
=0A=
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
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
