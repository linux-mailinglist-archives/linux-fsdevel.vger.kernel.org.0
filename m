Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E325F1F8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 05:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgIGDGp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 23:06:45 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50470 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgIGDGm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599448001; x=1630984001;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GmX6okvrm8IqIwOwpyjom8amEZTA6+EAvRQj+I9ukno=;
  b=lSM1Wn3dDKZUjJTj/gblZnFoM1Yw33gMGVDbQ3avw2458qgzWYuV0Mxi
   z6ur3j59a6ZC38LlCHb7EoxnoncQJtoIEedMWKATFppGIojTZhoNlVJqo
   pZgpEP0YQW1ND6wH/t4ex52khCn2V3JwP8P22HYbvqFyNvGfYf1heii2b
   lgkIjekWziVeBYK8FQ+kI8YjcvImDZe1nfe0o17xzqFO3nW401+8J4nB9
   fOYXd5nIUjuZgt/XuJ+uNg1t47QPSc31/3BqsQX9hnmQxmNGxSUi356Q7
   inhI1wmtYa5YdpQyHoGgwChsQRkU5q4n3FkvDDPizoz//8bkE5eEFLduT
   g==;
IronPort-SDR: qysT1zQ78aatTsdYhVRUC7CD/TgPqx/VH40RC+RcQBDW3jH2ZJKI2gmlKdBcp1ICXvsanLGDJ0
 +BDQD2T/6UuVAX0qbkUVEvztrESylu9dGHysJ2lG94jI0jzTfXU6MpA5s+BHu6Z+S4uaR1JnKp
 3b8WhRf5wxtHO7k07K2ZazYPrpp0DnQ6/45Fm4hFSbGL+C5uNl5CmRRxTgCjac/BReFvl19ACm
 yjn4qiBS8MckFrU+44rgQ625co9XZ+tucShzp6n4OES7d5P0RhepFlScOJQwsP3J2rQ1d9WJw+
 QeM=
X-IronPort-AV: E=Sophos;i="5.76,400,1592841600"; 
   d="scan'208";a="147926571"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 11:06:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdV90PIhd0d0oMkEtsSP4Ha23lVuNGq4QK6b89MPCrPxsMqa7fNmcOPa94dm83Y0lP26ufU782moQpBRqBMq2boC80JNSKO6nnR8O1sGGdw93erNKXiSqkJS2a+Y9SAt640lrxATxPAwSJ35jI9NvB2uLzV4L98aJeJ8sZT672ip+TtTqEH06xX9GLyTGy+VGe0OxKaQ1OPHy1LYqFecq9/BC4dpuDYOQ08Nz/ts+/Woe2UwqnN5Sj+qjjVf9TBxgJtTuH6sL/q88aVrcM1VWxD09WQuLw7ZcXbxmrhrQfmVWDtckk1dvi2cJptm9hCbpjezHUazvAAUXneBZMYjZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/EQ85SuzeoA6bWfbpGjFuBkH0/uDuUTuzkVDzKL5XI=;
 b=nVazV5KIdRx7m2Se6Hb0hmgzhiy1R16IE/P9t+6B73tj0W8TYxdCq8cCG8AiZljxDFgnalkrUDQhh3+upuf6ff4bPw2d9eFSSKZMa4lmtoO2fp1rjO7f5/WwcTnXwZqYdAa1V/ZOqA4ywyRWmAEKnrYa+osTfBqNRmaPBvnuS1h73vvh8VTgpIvj0tsW2+EY6mYWTM5JkromJdkiC8AAoFJsQdi8XaGixALI0PEhk5IC1tFoa3ndX8K/BQN0rKMYFhLYjUFNJ/zDlJSjaBGjJdE2Jdt98ZvEpvi2QMG9F2LCmyRbUMJ8FW49EcWrPP0gbwTcz/DqOp1SeMqgjBLi4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/EQ85SuzeoA6bWfbpGjFuBkH0/uDuUTuzkVDzKL5XI=;
 b=jJOwrJoBtoMnv6eZLcztoHW2axVvUMuzwv8q/egNZjqjkAwBufPe7cSPjUC8DsJcXg1TuqnVNG+QgXPu6Goc/Em9dyoy+Gm9IpuD3EbgQkhGAUHloWcW3FtXid6VZQdL7/aNQ6jd+ltJsXPHnWWNw7DiaOyvkp9hXzj/aqPkv1o=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0760.namprd04.prod.outlook.com (2603:10b6:903:ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 03:06:39 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 03:06:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Index: AQHWgq3Y4ys/PNxBsECpyvJxgruBJQ==
Date:   Mon, 7 Sep 2020 03:06:38 +0000
Message-ID: <CY4PR04MB375199CF79949920633AE2F1E7280@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200904112328.28887-1-johannes.thumshirn@wdc.com>
 <20200904112328.28887-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8193e44e-3baf-4a65-83aa-08d852db09de
x-ms-traffictypediagnostic: CY4PR04MB0760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB076035E75F074726D9CAC436E7280@CY4PR04MB0760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:178;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QXd2VkYJ+z5alqUGRSc2isFY2SUQdD0ZPZKKLD0rW5R0k2L2Op2kr/INCJ/HLXwPzF5KQyOgSeR97nzf3gR0NoCV6jsqH+6q866iPaSmpM0mk6SfWr/ZCbDMsiLAX4t/kPfvFiGSDLCsq+sJ2L+sNPOZy5TuM8uxQDoz2HCPNTm1654JMLfkSEjp+GGEF7HPA+mdhHxR2ePiK+uOgrndNjln72rDYMWli/nHY93/fvae3Zqg6FEVAhqnRUdWUgfdQLYHMtp7m7rqRtOytXiAoonIKR2QwwT/I7Vrz1g6Xs5yKzJ9nFJHSDKV/jEgiUH7ALa8J7Jv7Z5LybIfLwUGuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(316002)(76116006)(186003)(6862004)(53546011)(2906002)(91956017)(6506007)(66946007)(64756008)(66446008)(71200400001)(66556008)(66476007)(83380400001)(478600001)(6636002)(7696005)(8676002)(9686003)(55016002)(8936002)(5660300002)(33656002)(52536014)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4b/uSW8nfoFvdVwEWNXM3cpA0j76NAOIxiA/mvhUhFFvXGStwh2WtAp0Wml/lL/aL3euX6aSB/GQTGaY7smmdjNbeoZehb+yNV6fOPgwYJQjMAwyvW/4cjBijiZkKNf71wqrO32crwutdPBF+6v4hLJn/IZ6NLDHycSJWBtNTAIfa9dNxpytK1R/79Rzz0pp4tfWhHNUKQV0qyvIT/W2cnXSvutas5CzM+xfw2R+/o0Q2Mx3AQXwqKoiCnnC+0xL+g+eKD/OELow993kYwffv9Hx0Y4IcgPgyyxxAgCm8a4FtfNq6VEWvffv12p37ETrY6HBXXcmdHJtqMF7+PdbzYsE3SsmnR/v8xhSDi0GoPUnPSo/apSLHAvbkjVt9YdRftBq0TrfuwWXwRaBd5OZ1mjK+C2sTFdKslFVFWhVqUEJqTHA/xXMSwNAHCzChziKZ1Tkw95EUfZpMUEoxC2B2FQ0LJzzfw0/ckyQbp8dEjeYDZzz+TP2Bm1jPIa0Dm94USitua4CRNNxdSsSR46rFMoESYpidSuE8DHXI3Zwww9i5NnyKtzpC7/xRQOL5+BvY4kZ13sHwtUIbCaF6AEv9s8yh/q34sA6uOmZl903HNuNJXcVKez0GO3vSt5etgJksYEctp04tRu710n82pKOwLfajKRDtu6R7H4s+NibWLxjT5R2k4Q4RKhHza6hAwk6PSvRXwyztVxziMoiAM+ORA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8193e44e-3baf-4a65-83aa-08d852db09de
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 03:06:38.8214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLvT+8eH5mTE8Cb591PyQPLZb8jzKh6uMURqCAQ1DXO0gGICyv8gXLqae2ZMs+XHH74mJjnDR44U5Cop4zjnfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0760
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/04 20:23, Johannes Thumshirn wrote:=0A=
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
> zone that has active writers.=0A=
=0A=
May be you meant something like "leave a zone not active after a truncate w=
hen=0A=
the zone file is open for writing" ?=0A=
=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/super.c  | 152 +++++++++++++++++++++++++++++++++++++++++++--=
=0A=
>  fs/zonefs/zonefs.h |  10 +++=0A=
>  2 files changed, 158 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 9573aebee146..3e32050d2de8 100644=0A=
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
> +			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);> +			if (ret)=0A=
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
> @@ -335,7 +409,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,=0A=
>  	 * invalid data.=0A=
>  	 */=0A=
>  	zonefs_update_stats(inode, data_size);=0A=
> -	i_size_write(inode, data_size);=0A=
> +	zonefs_i_size_write(inode, data_size);=0A=
>  	zi->i_wpoffset =3D data_size;=0A=
>  =0A=
>  	return 0;=0A=
> @@ -425,6 +499,25 @@ static int zonefs_file_truncate(struct inode *inode,=
 loff_t isize)=0A=
>  		goto unlock;=0A=
>  	}=0A=
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
> @@ -603,7 +696,7 @@ static int zonefs_file_write_dio_end_io(struct kiocb =
*iocb, ssize_t size,=0A=
>  		mutex_lock(&zi->i_truncate_mutex);=0A=
>  		if (i_size_read(inode) < iocb->ki_pos + size) {=0A=
>  			zonefs_update_stats(inode, iocb->ki_pos + size);=0A=
> -			i_size_write(inode, iocb->ki_pos + size);=0A=
> +			zonefs_i_size_write(inode, iocb->ki_pos + size);=0A=
>  		}=0A=
>  		mutex_unlock(&zi->i_truncate_mutex);=0A=
>  	}=0A=
> @@ -884,8 +977,47 @@ static ssize_t zonefs_file_read_iter(struct kiocb *i=
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
> +	if (zonefs_file_use_exp_open(inode, file))=0A=
> +		return zonefs_close_zone(inode);=0A=
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
> @@ -909,6 +1041,7 @@ static struct inode *zonefs_alloc_inode(struct super=
_block *sb)=0A=
>  	inode_init_once(&zi->i_vnode);=0A=
>  	mutex_init(&zi->i_truncate_mutex);=0A=
>  	init_rwsem(&zi->i_mmap_sem);=0A=
> +	zi->i_wr_refcnt =3D 0;=0A=
>  =0A=
>  	return &zi->i_vnode;=0A=
>  }=0A=
> @@ -959,7 +1092,7 @@ static int zonefs_statfs(struct dentry *dentry, stru=
ct kstatfs *buf)=0A=
>  =0A=
>  enum {=0A=
>  	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,=0A=
> -	Opt_err,=0A=
> +	Opt_explicit_open, Opt_err,=0A=
>  };=0A=
>  =0A=
>  static const match_table_t tokens =3D {=0A=
> @@ -967,6 +1100,7 @@ static const match_table_t tokens =3D {=0A=
>  	{ Opt_errors_zro,	"errors=3Dzone-ro"},=0A=
>  	{ Opt_errors_zol,	"errors=3Dzone-offline"},=0A=
>  	{ Opt_errors_repair,	"errors=3Drepair"},=0A=
> +	{ Opt_explicit_open,	"explicit-open" },=0A=
>  	{ Opt_err,		NULL}=0A=
>  };=0A=
>  =0A=
> @@ -1003,6 +1137,9 @@ static int zonefs_parse_options(struct super_block =
*sb, char *options)=0A=
>  			sbi->s_mount_opts &=3D ~ZONEFS_MNTOPT_ERRORS_MASK;=0A=
>  			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_ERRORS_REPAIR;=0A=
>  			break;=0A=
> +		case Opt_explicit_open:=0A=
> +			sbi->s_mount_opts |=3D ZONEFS_MNTOPT_EXPLICIT_OPEN;=0A=
> +			break;=0A=
>  		default:=0A=
>  			return -EINVAL;=0A=
>  		}=0A=
> @@ -1422,6 +1559,13 @@ static int zonefs_fill_super(struct super_block *s=
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
Apart from the commit message nit, looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
