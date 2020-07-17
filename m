Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91AB4223798
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgGQJEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 05:04:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55198 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgGQJEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594976661; x=1626512661;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hTFa1Pyp0OIaptqi/0aUh/NwYGLPY4uDzlj/05zZY3s=;
  b=Wsk5p60Q9kXBg2094tSfqwzd6tBPVftT4c6DxmleVtnpjdgVK74160LQ
   j7i2wPESg4m9t4VdRbawRZSQYYsM3dHLVJbGv/8SCZ3dNZyxua0NCpdRJ
   lzC140Km+etA7ADLcjSWmyWDUyPRhN06ssYr4kWTQAcTtKw6DTDbsjdUc
   LiJx8O8eMzSkFByEAzmlWF/hwnBl9512rkMHLD1igmY9yY1OziHwtjjl5
   p/R5pP7gdWfwQDVq4jXS1CNaWYhHrcwIm6/HLUWsMiiIeaoOWwr9GcSCQ
   Dnx8VJBO8Vz8DNXLSiDJpAQGkmBhgEPs1EYLTAc8nvcjPyHkD38rNUV1L
   g==;
IronPort-SDR: 6dUmfuFf3Qczbp7MtCQbhn5Mmb4b9jWbwipULHZ6fnx61C6hwyALGpq9df04cox5dLgCxW4ehy
 nCE2V3EYQ9gmSZVMO260gM65NNpms+ymIh09FoLnrU8jYsrIQof+kxl9wBHXCnZwJ9ulMBRXXh
 5p5rnoTM9gNR/pHrIue8sIpqi+eFzEygdzgJXjFDVhl98y86a1rBJN5bUAq8JE9fMj+jW10Cev
 Iwf8sYwHl6V+DcjLyRozOpnjfP+oGkB57mOEGX5BCu5w22x/nS6/ZnUTFBr1kOckW5iJ69kcbp
 Xxo=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="147009515"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 17:04:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oi6P8nHNXdMO2On90YgpE5T8bZ29ucMC9b4HQ2cBBx3STBGv4KEPc+V0wgVL18hlSxMQ7TeZjIYsJqKql5j2zHtO0R/DQemSFCVxYWi+wK81AS9HmR8D+zARV4XrPezQkFkxSc9RrRkhXCQkxOBy8CgfoU+iPjO0ePxxcpS36wR2b8GmgfDaRfxgeHzKL8r536g5BsAIBr+Rzd3R4P+v6VT0ip8kaqrDR76DO1UqPTEs59FJFTapdD3+G7GueYbNTP+NUJeULqJIdtgjOpeMyK5nVAZiQasBTu0ju74Azz5FLk/3mHiBAHdCgS0FBzcaKAHPdNeY4O+FaRIZOAi6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNwkX1GyYsDrwID0kJacT8VzWUdBht8r7Hyjd8sz2xo=;
 b=T8mBoNnOx7jqK8qJk6jpwXF+9qYHbAK1uU/crSmzVd+nF1I2zoksoXAa0h8FZSJj1DaJLed6CtLUL4zoSErbzlIWadRIQ5EbLLPDkgLvjGlnWCHtAv+4Dcuk2Cfg/PI5nBVwUcEbuSXfWGllydLzHquGQqO+/hKEA4BkoHnM+y+uEiQ7lj+P7hJeOgEyFU22/jZBIQVExRp5s9lDKbOKzkLJwhTz16dVzlhp3kc1IpdCfvLFgWuA8SB8MPDvEFTD6NXtmfVvcbRRlQ3Z6uXB4paoxem9iy3d1ilcHI5OTDqscgdkqNjrEgsEFdLslsYSoVZYG3I0hpY56pJmMF3kpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNwkX1GyYsDrwID0kJacT8VzWUdBht8r7Hyjd8sz2xo=;
 b=DiLouaq5aVhnfZIRLrKBwOKzPZMDT4NffOxk40n7lfLIAXd48xn04ZGrSSXMc9oiPPDCisFfsWhTZHLbh+JsFcZs95l2Bpe8o0+0hIN/TKMGuzeSdv28vQiaX5hEcjJ2G+LvRTyyIks22Wz5HsbDtXODqq4zbzQI8DSaZm70Mx8=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0249.namprd04.prod.outlook.com (2603:10b6:903:37::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 09:04:18 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3174.022; Fri, 17 Jul 2020
 09:04:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] zonefs: add zone-capacity support
Thread-Topic: [PATCH 1/2] zonefs: add zone-capacity support
Thread-Index: AQHWW1opm7Z+s1JNaUyxbfx3W7+0Gw==
Date:   Fri, 17 Jul 2020 09:04:18 +0000
Message-ID: <CY4PR04MB3751D69A4D359090952DD358E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716101614.3468-1-johannes.thumshirn@wdc.com>
 <20200716101614.3468-2-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 643fb82f-13b8-4914-1483-08d82a306381
x-ms-traffictypediagnostic: CY4PR04MB0249:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0249E63A3CFEB21A429220B2E77C0@CY4PR04MB0249.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XrOcwlvCYKOolP+mAMy4BkOpm5tNINJk8V69hzhFIrX42Nn53IvrSUf6xaqPGh+9ZhYy6guvLw+3AfODWixOFBP4X4XVN+vcjrv8q/Va2m5EepsqOGYxz5TfqM+eU7Jy4sQejsWWwyjjg1NWL2nSmVXjYl55adz0fciNnqSsrwsBgrgH04+5fuxU/2gQ++mB7RfckQAZD/B+jndbNF02L36LzN7G+TSiIceIyGVkmBzFmH1ssp/Ed9fBKvZtXO37oawXWsy5lr5dXAeVoLmPeGkcFlqSWtYuOqRL8rZ7sDGx2Zi+dvAIVqcBjJK5PYSq2wRMwixCQenFl452Al8ehw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(33656002)(71200400001)(86362001)(83380400001)(6862004)(316002)(52536014)(4326008)(66946007)(66446008)(64756008)(66556008)(66476007)(26005)(91956017)(8676002)(76116006)(53546011)(55016002)(9686003)(6506007)(7696005)(186003)(5660300002)(2906002)(8936002)(478600001)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aIeo3J3qS93I878b/VLpxvuE83GJxREYBbRfc5j7/SwXsaAaqUvrGAkqUhoxtRbw//tWv/SSAaKd0H+7xU0ZMpHSlKB1bW0+x+ZuLqNBDL1Z6582lasuMLiHxnvJ0B67OpO4X8EZ5iMF5kPzrRXyAc3ONIZGRogdm+G8bkuSNhOg0Ks9y4PrBUpYbpAoxAAz7jzIFg/CaSahHzcSqcLUOCc/2/4tgRuVNvCN5HY7QiVPej4EUnJBmxd7ig0eI4D07OJdD/nfjVeLIy0F95dl5u8mMHWXbk6oQL9QvFGVEpNZeWqcy+KhhYZtlwVDwMHcjjaCLo0pVspnXXIzCmUuRhYuznjXLXq9Qrep0BevijAP+ceK8rQsZwZ90/b3ovFvSGlQsbUncQNG8voi5kA3jrXkSUvXGRUCYHCigbVmN+Fj8Q+8HkhgyRWuqFaTnE1q2X0p7VtegN2wtbMDPxDk5WKPwP/sumNnN+E6+QwS4PDLfCunTQIEAKZqMIDDFzli
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643fb82f-13b8-4914-1483-08d82a306381
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 09:04:18.8406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /epSEkJVXDyxmmQS1TC8MUmHjCUyl+ZyBCkGeraEtTOgbL6IxfQORKvSmWFSsZ88lM4hEaVnM358Aa7Gxa/yIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0249
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/07/16 19:16, Johannes Thumshirn wrote:=0A=
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
> =0A=
> Use the zone capacity field instead from blk_zone for determining the=0A=
> maximum inode size and inode blocks in zonefs.=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c  | 9 +++++----=0A=
>  fs/zonefs/zonefs.h | 3 +++=0A=
>  2 files changed, 8 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 07bc42d62673..5b7ced5c643b 100644=0A=
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
> @@ -1050,14 +1050,15 @@ static void zonefs_init_file_inode(struct inode *=
inode, struct blk_zone *zone,=0A=
>  =0A=
>  	zi->i_ztype =3D type;=0A=
>  	zi->i_zsector =3D zone->start;=0A=
> +	zi->i_zone_size =3D zone->len << SECTOR_SHIFT;=0A=
>  	zi->i_max_size =3D min_t(loff_t, MAX_LFS_FILESIZE,=0A=
> -			       zone->len << SECTOR_SHIFT);=0A=
> +			       zone->capacity << SECTOR_SHIFT);=0A=
=0A=
For conventional zones with the aggr_cnv format option, zone->len has the t=
otal=0A=
size of the aggregated zones. zone->capacity needs to have this value too. =
So=0A=
may be add something like:=0A=
=0A=
	zi->i_zone_size =3D zone->len << SECTOR_SHIFT;=0A=
	if (type =3D=3D ZONEFS_ZTYPE_CNV)=0A=
		zone->capacity =3D zone->len;=0A=
=0A=
here.=0A=
=0A=
Also, you should check in zonefs_create_zgroup() that for conventional zone=
s,=0A=
the zone capacity must be equal to the zone size when the aggr_cnv option i=
s=0A=
enabled. And you can addup the capacities in that funtion too in place of t=
he=0A=
above change.=0A=
=0A=
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
