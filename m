Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0EA1121F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 05:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLDEBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 23:01:23 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17566 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfLDEBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575432083; x=1606968083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NRLBclJoZbwvO/Dd3yZVRQhiyU4z+Y6vrETuZt0iLrc=;
  b=JvToDmVqi+39/hipEFk7sGpVh99dvyxXkUMIJM5EDJwzAP/p7ZCAMo6f
   pPMMWz5fmFszMfnoXaAbhcwvDxlkkqRUd7BlHvVgVe/X5P0/8jg17s+rw
   miaxyIuTSQczRi6AFCKSpA3/QksIWlphyQ9IjBZ809RNoVgLAC7f03tFQ
   xvCPP1atv5PnhsSuc183IDlNcGv2ZL5QEd9fDTtgZyVzG+3RHDAthb8qo
   O7BHkjrbA+3M4juFCWzZHf4WbKnXWEKZX3FPsBNTGVkLrXfYtNzmrAL2R
   xBOWMjRLDmC0UaQ+uETZSReJTO1t9EgJ43+zdLKIN/JqDwr1jONZlqEoi
   Q==;
IronPort-SDR: vHvQYExHywA1oC7SBbhjnXOfKUD2GJuZu01n6VlBAwCtKtJ615qyMrecXOMjFheoI8YuRwnKtJ
 Peu+M/nB8MAIYQKRJgmh34eoTFsastKrujvyczgPLgEUtXKTuGsvyBFLmp91D6RB5csTSdDxZe
 tBU+Fs4MXSQ0LCNIzSgo+IVM0bd89Vk+eldx0lzRmn/c25W0dYGoCMbIBy6nBOLzrzCKe+akqm
 90E+BSz+7jUrweLa1TDVVic+E6kmHx32n10NZRZ8rG+E95NtVemgai1nnm9I0CoiMrUWgdeeuS
 8MI=
X-IronPort-AV: E=Sophos;i="5.69,275,1571673600"; 
   d="scan'208";a="126173766"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 12:01:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfzSajt6fbYTg05T2IFup/R02ncKEhcyaP4FPxmUwr69v3SHSATK4+Rak5mmgEMOIoQQ7QNL5orpkgWGZLLJYJmM4tRZ8CiakvNAjdjSbpWvKs6/9/NOlkg0VHwmx2LxI2dyGQRgclzBfCEo46wWao1W9RTbk6lqQKX0nf7NHbyOc4ty7qgxNIDxFTlN4K4kb8mQAvrwGBtuJ9KR6tiIIDtZzdBx8ev00UN6QBM456jhyNZ1uIlvJYVzJqdd/Jr33VjPCItqLEb8Tgo2R3H3cCpJHOLqJ5rKJUUo9tx5rmT4VOaWQtafQFXXEYhIJTFBcQjCWMYVuWyHDsZ9/mqXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4dBs8+mtj+LYeVUCfYtGpCr/TKNhd/JtzLruwdYEs4=;
 b=liNGdfW5j9bVfVgUbASswmv1jeiH7mi2WLeeBskEh3MCGB23LA4LNXPAZdkZLTqOLDqRfn4EYsFhui3R0VN+aICozDShRnS1T2RRl/tv6NS7bj0ZS9zTn1vfzUbvmEwv6rq1ihkBnimm5b13OUSMKBjGtwOfTRpa5Gfl6YB2xnEPePcfq+tu56h3rLj2a0MobrSIQ35jaqmnj/uIDneBrslECIyqg2QP0Anzx4i9t6Boh7X0RANlbV3TnhNb3RQvGR5voU42uw+x1lGixLlCmx/E0JSGeOq6IAjBZuouI8S8ffkVdL53L3SOuBvdC8hfXYBzbDW/Stf6mTrLW0oSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4dBs8+mtj+LYeVUCfYtGpCr/TKNhd/JtzLruwdYEs4=;
 b=HBbPfCl4BlAl2zip8g32AcCFIkRIjfTjTZvhlyOu/RHQOK2TXDd0ps7X87+PBLDgyIa03VM4S3U0wAoek13DFg/RipXgw4O/I1bogmFMoYAmiU38sI4eWj3QeBAPAgi6Q9hoKQKMXTwF24UW5zuHCAtLQxhnGh3p/xI0x+hOqOI=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.10.135) by
 CY1PR04MB2298.namprd04.prod.outlook.com (10.167.8.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 04:01:21 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::ac1b:af88:c028:7d74]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::ac1b:af88:c028:7d74%11]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 04:01:20 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Javier Gonzalez <javier@javigon.com>
Subject: Re: [PATCH v2] f2fs: Fix direct IO handling
Thread-Topic: [PATCH v2] f2fs: Fix direct IO handling
Thread-Index: AQHVqf/EcUMid82cv0W5f8BjBRO52KepWvgA
Date:   Wed, 4 Dec 2019 04:01:20 +0000
Message-ID: <20191204040120.gwcfglulpnlywc47@shindev.dhcp.fujisawa.hgst.com>
References: <20191126075719.1046485-1-damien.lemoal@wdc.com>
 <20191126234428.GB20652@jaegeuk-macbookpro.roam.corp.google.com>
 <20191203173308.GA41093@jaegeuk-macbookpro.roam.corp.google.com>
In-Reply-To: <20191203173308.GA41093@jaegeuk-macbookpro.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6cd1789e-fec7-419d-f7b8-08d7786e9f40
x-ms-traffictypediagnostic: CY1PR04MB2298:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2298AE162C66534BB3703EEFED5D0@CY1PR04MB2298.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(53546011)(6506007)(25786009)(9686003)(11346002)(71190400001)(76176011)(6512007)(81166006)(14444005)(256004)(66446008)(76116006)(3846002)(6116002)(8676002)(99286004)(66476007)(64756008)(229853002)(5660300002)(66556008)(91956017)(1076003)(6246003)(4326008)(7736002)(305945005)(102836004)(14454004)(71200400001)(26005)(86362001)(66946007)(6436002)(2906002)(478600001)(316002)(446003)(186003)(8936002)(6486002)(44832011)(54906003)(81156014)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2298;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cPHlhWbR+s4JMyrbEb2iu4hqfblc6eT5uAuOvKWWJX4Sf5G0M2jQV9cPQNRJOux9/vCMrQVLZQpx6HNMws4+XYW3nA1LiUVyCPHWOsVcf5mF/gxrc/YuRMfpW1MtabXKthyndq7SDN4tnnLL9tKXTo6DaFNDYGWIshp2LptlhbWIFu1WozD/CHIWnbm4yLV10uCMwEBlybinec0GIZAKJSOzwhNvzVzmTHit1hJWFHf2ZNJ8hMBQaA9Ehtsd6ZPkHvia70Cw+kctr4tEe/iwTmH1OdPInzD4wEeGQgZgDxMFj53hLHX8XwMU0XS1e9qo8CWDE7mtj4WKHx6ApFl/dQLyJfG27YkKYVxqhhyQosFenrPGJ+0sw6+5gFcsxguLg8xb9YzJ+JjslrHrZrN/ixJTpLHIBdLL6A4wjiDPmmrHTPg4ICdNIpGMAiqLIYyT
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4642912A1089F4E859D707B968C3FE1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd1789e-fec7-419d-f7b8-08d7786e9f40
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 04:01:20.7996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VX2aMjOzrg/T/ODQg9pnbIIE+gVoDXBclFxcXmgWDy8bA0iqfbV28gjw5auWm6TbvcfMHv+uIZ44jtQv3mR/9F1PVOVrb5j92uWEKwjqDBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2298
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Dec 03, 2019 / 09:33, Jaegeuk Kim wrote:
> Thank you for checking the patch.
> I found some regressions in xfstests, so want to follow the Damien's one
> like below.
>=20
> Thanks,
>=20
> =3D=3D=3D
> From 9df6f09e3a09ed804aba4b56ff7cd9524c002e69 Mon Sep 17 00:00:00 2001
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> Date: Tue, 26 Nov 2019 15:01:42 -0800
> Subject: [PATCH] f2fs: preallocate DIO blocks when forcing buffered_io
>=20
> The previous preallocation and DIO decision like below.
>=20
>                          allow_outplace_dio              !allow_outplace_=
dio
> f2fs_force_buffered_io   (*) No_Prealloc / Buffered_IO   Prealloc / Buffe=
red_IO
> !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
>=20
> But, Javier reported Case (*) where zoned device bypassed preallocation b=
ut
> fell back to buffered writes in f2fs_direct_IO(), resulting in stale data
> being read.
>=20
> In order to fix the issue, actually we need to preallocate blocks wheneve=
r
> we fall back to buffered IO like this. No change is made in the other cas=
es.
>=20
>                          allow_outplace_dio              !allow_outplace_=
dio
> f2fs_force_buffered_io   (*) Prealloc / Buffered_IO      Prealloc / Buffe=
red_IO
> !f2fs_force_buffered_io  No_Prealloc / DIO               Prealloc / DIO
>=20
> Reported-and-tested-by: Javier Gonzalez <javier@javigon.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Using SMR disks, I reconfirmed that the reported problem goes away with thi=
s
modified patch also. Thanks.

> ---
>  fs/f2fs/data.c | 13 -------------
>  fs/f2fs/file.c | 43 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 33 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a034cd0ce021..fc40a72f7827 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1180,19 +1180,6 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, st=
ruct iov_iter *from)
>  	int err =3D 0;
>  	bool direct_io =3D iocb->ki_flags & IOCB_DIRECT;
> =20
> -	/* convert inline data for Direct I/O*/
> -	if (direct_io) {
> -		err =3D f2fs_convert_inline_inode(inode);
> -		if (err)
> -			return err;
> -	}
> -
> -	if (direct_io && allow_outplace_dio(inode, iocb, from))
> -		return 0;
> -
> -	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
> -		return 0;
> -
>  	map.m_lblk =3D F2FS_BLK_ALIGN(iocb->ki_pos);
>  	map.m_len =3D F2FS_BYTES_TO_BLK(iocb->ki_pos + iov_iter_count(from));
>  	if (map.m_len > map.m_lblk)
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index c0560d62dbee..0e1b12a4a4d6 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3386,18 +3386,41 @@ static ssize_t f2fs_file_write_iter(struct kiocb =
*iocb, struct iov_iter *from)
>  				ret =3D -EAGAIN;
>  				goto out;
>  			}
> -		} else {
> -			preallocated =3D true;
> -			target_size =3D iocb->ki_pos + iov_iter_count(from);
> +			goto write;
> +		}
> =20
> -			err =3D f2fs_preallocate_blocks(iocb, from);
> -			if (err) {
> -				clear_inode_flag(inode, FI_NO_PREALLOC);
> -				inode_unlock(inode);
> -				ret =3D err;
> -				goto out;
> -			}
> +		if (is_inode_flag_set(inode, FI_NO_PREALLOC))
> +			goto write;
> +
> +		if (iocb->ki_flags & IOCB_DIRECT) {
> +			/*
> +			 * Convert inline data for Direct I/O before entering
> +			 * f2fs_direct_IO().
> +			 */
> +			err =3D f2fs_convert_inline_inode(inode);
> +			if (err)
> +				goto out_err;
> +			/*
> +			 * If force_buffere_io() is true, we have to allocate
> +			 * blocks all the time, since f2fs_direct_IO will fall
> +			 * back to buffered IO.
> +			 */
> +			if (!f2fs_force_buffered_io(inode, iocb, from) &&
> +					allow_outplace_dio(inode, iocb, from))
> +				goto write;
> +		}
> +		preallocated =3D true;
> +		target_size =3D iocb->ki_pos + iov_iter_count(from);
> +
> +		err =3D f2fs_preallocate_blocks(iocb, from);
> +		if (err) {
> +out_err:
> +			clear_inode_flag(inode, FI_NO_PREALLOC);
> +			inode_unlock(inode);
> +			ret =3D err;
> +			goto out;
>  		}
> +write:
>  		ret =3D __generic_file_write_iter(iocb, from);
>  		clear_inode_flag(inode, FI_NO_PREALLOC);
> =20
> --=20
> 2.19.0.605.g01d371f741-goog
>=20
>=20

--
Best Regards,
Shin'ichiro Kawasaki=
