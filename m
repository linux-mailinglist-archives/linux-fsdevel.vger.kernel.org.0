Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D391125F286
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 06:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgIGEdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Sep 2020 00:33:03 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24738 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgIGEdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599453180; x=1630989180;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Esz7dFjYz7aBQ1g5ZCpo7hEq3cO8sCCm7vduAf+3huA=;
  b=npWxlJc0korXCRrf9AR1ho+Avo+F+YCIakMvsEiFHIarWKmjlgvVLgTM
   OR6rTRu2i1mm0VqQAWnC/8u4GpQMuTjZXBy35jckxHKmqwbLbz1OTULy/
   xd/2DfxUEanh3LIoQYoq7Yy7CZfEaYcIeUCPNcm80wDhqyucxOqIUkqNx
   YNIK5WerjbSnju4UW2YGjOo3idq3aAmxYq3Sr1skXbwF5ofbd7jxSfeUU
   WkJHCxUa6xnfN3bq1psuCy6bJ/aAiQt4Gu8+OWnsVrkjLhoAQ9Xc7RW7L
   YIWrCmsObvfTLvRB5kpzaeoUgvI0DdnkidaCa+dZ1KuYzEZxOGxFqr31t
   A==;
IronPort-SDR: ygjN6okmXFiOtjb08be+fOH94opLcEEk8kXM1brtVGoZlSvSKpVV1AoZY1EKu0X01HvKR6f7jW
 COdikxlWbTNXXnUtI5hNUpo4Vzbn7ZlgN0aCdq/BMQks6xS65j4hO6/7DBbDIwWfrGptx/xCPI
 ShJE7D1aj5b0p/Qbv7hRNUnn/azH/6oayB4jjM7FCqdNjch8/zSfKL5e1btzgqqzO1MutDk89j
 7ZS8+I58ns3uB9aiEUHQ/YsXCqONH5eeLb63qH+naIlOqAo3VuPY0ETThcoASRIeYLd/e+5WXw
 AtY=
X-IronPort-AV: E=Sophos;i="5.76,400,1592841600"; 
   d="scan'208";a="147931691"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 12:33:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJLph6vPDU4vXZQ/3zZnjGh8F8Gbtyf3fJtyY+Pds4osASTWrbi3rjokopbuSkOGMSpDNawyDyr1mhXrLBHnvjBLlbXeKRxYx3ccI0T/xXQawl1uGP1Ph/ay601p92F+KVPdlmzPfmFhe5IHZktP9aNcFmULQ/yUcqWkXjgeIaxMrEQksvrXfmWkZeMnzzwsitfWbz1iFxnpw2wVbHKijV5Ct9F73OUjR/LdxHRcbouQqeFmeJfyfQALfyX30uNNFhRYgBsJSDRqv9rLDBx5o+nRvoFFOwYleChQcz3B6kgpNnqYS3+5emfkYLO3zcTlUrK+3MBeHt9XOGENv4FuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGcyupywAZ9XJS57kikBmjKJta3LIRF6HdAM6j73d9o=;
 b=dQGaphWJFy0JzpPQdOcA1s48vpZeRk+azTLGpoi9EffTVTJoZ4WN3FAKjmpnmXQxdFepHNvnE8mv+/p3Oa9K2c2CsYIg93BkkDwKro0T0VEuqn9JLekcJtTa6V0P9N0/kk1THJ+JFcr6u0KeyaQfhxECOempYOFvmqIO29V6jGqH8b8eNibzc+YG05cnCmXU8C6RNsc9RPLrwBp/pumnW1O5lbUP34KS8/t/0+g+LFMRC7X1nd9oB8N97jzGEEQCKXwawfsGbVYU6hk2ze6fApD13mLkkCz3qrAcywyfr49L+kXsOI2tJiGjjnR+rSB9VUWyalSBdjRGDzKUR3ZJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGcyupywAZ9XJS57kikBmjKJta3LIRF6HdAM6j73d9o=;
 b=RuwbHSS26eAL12znvHN0ySvYmcBK0PzPfPEkl5IJdbM0e/fXpqpwDKoPyCdQu/mpAtCYYIjKuz4VqkrEjJ7DFI/5xzZVqCCjwk8j3MRJTOkzrp4GIpb+VXPbJ2YrxwjSHa/2NM7J7k1F3BY0EUCxanrgWUp6OieI1YSXxPjRuls=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0758.namprd04.prod.outlook.com (2603:10b6:903:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Mon, 7 Sep
 2020 04:32:58 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 04:32:58 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH 2/3] zonefs: open/close zone on file open/close
Thread-Index: AQHWgq3Y4ys/PNxBsECpyvJxgruBJQ==
Date:   Mon, 7 Sep 2020 04:32:57 +0000
Message-ID: <CY4PR04MB37511ADD5E264A3CA1B982B1E7280@CY4PR04MB3751.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 2d740c27-4f4a-44f0-c7f5-08d852e718f2
x-ms-traffictypediagnostic: CY4PR04MB0758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0758DA87C17C140CD9882212E7280@CY4PR04MB0758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vrOIrdZd6p4cmCOeQHpeCTPNwvQarN9lMmxo9jpgCHNrVvOulGG1DCp8xw67L0mJttlKfdEzZIlXb7GItoI9a5oU+THdw2u/5FlPymgOyXJz5iGlaT0F3hIsIoxpZUd/IUY1rFgA2jo3gN91hQwmcK8YDH8rtFXR1/iDzkgf5TkR5WT2Gz/9+LgeixjMU7G3PnlVTyr5OT2ev1uWCr69LHl0goaPOIbhL6Qqr43i708vyeZLy5m006zIIGZ2wUTRVIfVYgTM7M2UAIUcXiXp/AcnO3MSpK/QIcn757CnpuddtQJQBevS6BtGNef9Ef4oBl67SfYUEPvOUD8i/JG7+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(7696005)(4326008)(6636002)(316002)(53546011)(6506007)(186003)(5660300002)(66946007)(478600001)(52536014)(66556008)(30864003)(33656002)(66446008)(66476007)(64756008)(76116006)(91956017)(83380400001)(6862004)(2906002)(8676002)(8936002)(71200400001)(55016002)(9686003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZmzGjvAHAILZT72Q2f9uogjr86GJys5jKwOzlRDm/lK/onJD1sToPSCoiFhO++FS/gEUm6vyC67hraxETuQrmgnvaMq/tzefNzKRCVNpTDW78DbIEdGJcmP+otl0MrWR2LE5x/CdEHfEbFhKZ0K+dZdKgFkNNOH8v/V9mrsqeaFV65DVb/h83nRoRppK07ooe1GEGy+6Mcs94z3x2PseJ0Azbq0qS/5aAnwRkZU9adalhynqO4m5i/Yx6TiRZTHbXBh3QMPU+sWrSk6ud1JikF5hFD57LlI6NgQLG9S54YjCo4lGeyQZowaXqSQMiOJOH0lrZtk/rvQzm4DAYXN+MBNCWnocaesb+xubT79IgPcFkRT71yrjETDGRiBLa2VmabbCt1fUhqsALIQYCaeJAYbo0JctdAcafmkP1S52aVrHVxNuTdiqcxif4KU1OV9O4bqqDv/Lvl8UUmr0uVWAPL7XCCaNs+XEioKHApNejHDL7bXfnaYbogn+ey532bOha8wS7IQhmRDf9B+3opsBSvlulOH+KCKvOLzVgwx0eryUjZwcW6r2Oq7DixBJJ420Qj2aXKH+lzH7S3n+C/zeFXfpxn2HIVj0dkj1jNGkEbfPNsr2Kd0/p+1/5AdxLqoKnmfvP9aY9nWbshA4CdYIDOwgglbb1nyNWjGsmOl7ZQKd0Z8pWx+HAOt3R73m0DZHZzWVepBlqbabGuX0NmoKbg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d740c27-4f4a-44f0-c7f5-08d852e718f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 04:32:58.0368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7L4sKhtMnTiNdidsg/l//xiX0PpMJh37A5On2QaYRvqskJWrvTi2xHfOOcSVAEBBFMiymB1nAU0T/3Oqc4I96w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0758
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
> +			ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);=0A=
> +			if (ret)=0A=
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
=0A=
Thinking more about this, the main reason a zone close would fail is if the=
 zone=0A=
went into read-only or offline condition. For these, close will fail and sh=
ould=0A=
thus not be attempted or the user will never be able to close the file, and=
 to=0A=
unmount the file system for recovery.=0A=
=0A=
So in case of failure here, zonefs_io_error() should be called to detect=0A=
read-only offline zones and the close error ignored so that the file is ind=
eed=0A=
closed.=0A=
=0A=
Conversely, in zonefs_io_error(), if an open zone (ZONEFS_ZONE_OPEN flag is=
 set)=0A=
is detected as being read-only or offline, the ZONEFS_ZONE_OPEN flag should=
 be=0A=
cleared so that the close zone command is not attempted when that zone file=
 is=0A=
closed.=0A=
=0A=
To avoid complicating this patch or making it too large, maybe add another =
patch=0A=
to handle error path ?=0A=
=0A=
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
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
