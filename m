Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4EC265C71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgIKJYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 05:24:41 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2014 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgIKJYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:24:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599816277; x=1631352277;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7l7U75YjZypCsmjPOkI221ORbQnM032ZfbwoHuCu4Tw=;
  b=cKZfS0/FmlbhmDz/g6tRxYW3EPsPZfg12RqMxwVsERTq9rCCkiVRR2zL
   qi0nvDxgs7UQ+wDtImOYB5smPbXoYZp7HIM9UIP5ODAzmTnTcFpoeu7hs
   x9y5h4CLOBSf4A2QnqNIXdZh63ncbit89w4vbl3MDsxvjO1FapzzThDiT
   CHY1VHldjdeTGH5GCXmc9CggPOZou1TGAGsvefQtw4x3MN8fnxGnnbIio
   WAtSffVB2Qfya0iijEWxtU4yTr5BzIvCJDTuxahe9GhCOMFMEiElUyk5m
   zvInW3U0SWNW/xUN2ROiRNY5LANISjnpLZ6IvSMLdTXxZllXMkWo10JbA
   w==;
IronPort-SDR: f9gryWWNJy3t1L/RxMp/SDv7DWDOSlCOG7UAe/+He4JCACxaYR3Kfs7YQCaxSvEXOs2Ty+ebK/
 K/Nm0erXlBjLah9sBunBJ8Wxxk0Oyj1LeRJ1KRtTcjXDL6ovJi5eKroWoifotpYOj9btTn4dO4
 ilvAL2AIAER7LXVSLdFfKUPxE0egs4+fl/VdCDT29ML2q2oLtVByGp3qVpGtEAp2iL5RyZh6cU
 RvbXvxbDN05D1SaaxuMhgkLahZdu5ud2kGtQeDmDK10WSVPwt27S1wAXkRMHpHc/ZsWdFmetof
 EGI=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="147115835"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 17:24:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic5xOQchBPq/lMv+hSsDj1Bn0fl2pPeXQc+MFKOjDmHCVgptlb9Crs7fqPvfKI8mmmtLQ03A4ORWVNVNRQwnQC9HEN7CpwGWOLfdwh1+HXJPPVndBjcwi3l8Obs8XvRYFDN4uA2MLk3ok5EhsE/uryjqC7naig0QSWthVCwIXW1hBULdLTf2XmP9bocbrUeCUTAbwqOlQvq1kUYv59aVAEeshLbhy3GRxPcuQO7CmneyJdBy+xgbs0EbmS3QEQ9z/1iX+LeEJImcW6HfML+V9NGIAuabYhdtHxwh+o9EB4fxLjgXwaOwOnSnonmribnYqCo/Jnk1erNhX+y7Fg4zUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MojDIxwWA2jFfozLVP4PL9VtmuTb5lwA5s7X9jDTOg=;
 b=kRY2+16fUffra7rnZZ2OHTRjJrIfnEN8lOgf2fNUmJURfu+kIsWBcXQr7lzaYFuCc6Y3ZeHqdKbf7ead16lSnMQlaSNKCKw/1masnB6pTYZ5ikIqAQsruGHIn6CSRB7X1IxX7GA51Lkz3HCXEIUYtLlM4aZjO5F7nLa2rZ0gn5ZGtLhDdyJRhTBLAI5zCbnMZKoY6b973EJ3tuDexugZxrBeHsDl4yenUO6+04JG8rWsKHvgts4GAdoveWqVDkJhhjgWl1b5iRGTA6mWdiAFfpc3uPW5joWUxUR0Im4OX6l4/hvCAEX+NQmZOOlCf1cKsovkBmrG6NViPG+X4DwWQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MojDIxwWA2jFfozLVP4PL9VtmuTb5lwA5s7X9jDTOg=;
 b=pa4MRrQWAsuUm7kWohJDlHSOQ1chBLYmWtno/lmrFDEQfrGahdU0G0PAtv5g/CyQa9VCxNGW5YsSm3KEvu7wJve50dmpl/hcUxhZ8rwIldZE9j/2gIf4oBa3VzP6oGwllXzPsGdlyDiw/qqSZoUOjohGbhAyUBR7VOG5ZCSML6Q=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0969.namprd04.prod.outlook.com (2603:10b6:910:55::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Fri, 11 Sep
 2020 09:24:30 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 09:24:30 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 3/4] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH v5 3/4] zonefs: open/close zone on file open/close
Thread-Index: AQHWiBmE4lW5tRQsrkaMxT/W/mfplw==
Date:   Fri, 11 Sep 2020 09:24:30 +0000
Message-ID: <CY4PR04MB37514233C9911908A4185283E7240@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200911085651.23526-1-johannes.thumshirn@wdc.com>
 <20200911085651.23526-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:593c:8256:27ca:4ca5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b194f92-ed8e-4a47-d36d-08d856347ce0
x-ms-traffictypediagnostic: CY4PR04MB0969:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0969FC628BBE9AB7C5E0CE25E7240@CY4PR04MB0969.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gc5LEgxSayMs7PE/+h32M7crZ4EB1etuj5ukE2uTwRV6U3oNpcsQsf5J7E/qM77zu4tGf2A7OvIRyKA37gAHPTE2o1KxQpzaLquE5rQMT1oYRIRyKSc8uGWLhBM9J0tCW1IkLZBZCybuw9Yg/BJQbK5ssDWLAoPxxq9a64day8Hfs6G9O6gUrfQeoHLsbl6qWfKj1a4kyjnb7VA6XaXpeo+nzP5ymuH6CQB2UOjQyU3LZM8AeoBDxRB2bo9f0bLJBcWnbJvcTE1ca/5w8CuxHNUVreEj5ioJDhoF5OO3ufAH9+K0JFjxP7w2xQCvOno6IS3Bqlyiz/LsiandTNbc7o8ULqBJJaO4R5JWcLy5JjOGwNUPUP12EgP5QFwsBbvK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(66476007)(66946007)(76116006)(478600001)(83380400001)(33656002)(91956017)(6636002)(52536014)(8936002)(66556008)(86362001)(66446008)(64756008)(4326008)(71200400001)(2906002)(316002)(53546011)(5660300002)(6506007)(8676002)(30864003)(186003)(6862004)(7696005)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nk1xmXAHQB2wZbfeCthYsQinjxunvS7FqAofrvPqkIr079P0ORSkPBoJJtDcHze/xCOan8iX+r+sT0kpDUqWIrw2yTsPP6X3p7GIXeQCeDk9ijolzCwQOfxnqEesTS1D5Yaz0QFcJf3aWZwBe5rJ0ye9/43JbvUWMnOGPmrKyqLKDccFGMFX511AC/IYXMAGtupip1gyqWYjYzsZuVSpOQ2u+QSs2em0yfRx/TOMCaiwoVuKOtTJrVA3a+zmiRatHcYFNwraJmWDvNtGnaAW1qBuPyKPBKtCUH+sBrPXOZrOiN+motbJTjHI359me1qCeq7oaKa44ON7ec8TLtokLCfbua7/pVOQYDcX+AOnWJNUaSv60Pm0P9buSKXz8OYp+dLn9FF3s2qXaOcV213mIzFDhlCf4ZAimL1vvnRjcYLmALKZy+zh95KxLEZxXmyDwqVMgUGagddlIZ/oFSqNHVygqwDUqx6i9ahRinFa07u5jKlPnfl9X/n4zhDbEG3UmJH6rJszjHjVGWZASWy+yl8pbyD+t/lNUm8SPIhhMRaBSgcANe8cV3jACOqdRTXSyNjHRAzL9e0mGFe0qv0UnRcOQguB8bvYXkZEpsw4OETsVinup8M0b1FFaUuapfu4qUb57nPcEDUPcLEss7O3nqW+11J5pYh3r29cy5ruN1myqPMqRCLXsMs4BKxSDup/tvOT5BGuzWqF5uTy7Lb5XA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b194f92-ed8e-4a47-d36d-08d856347ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 09:24:30.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdjZ0j+70Nv328K6kUx2I8GQ+Obydk+UH1YfepQsz8DUofneXNZ/ciINOYYSfE1iXvbj3hjMDP+u0KISQ9iV+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0969
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/11 17:57, Johannes Thumshirn wrote:=0A=
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
>  fs/zonefs/super.c  | 183 ++++++++++++++++++++++++++++++++++++++++++++-=
=0A=
>  fs/zonefs/zonefs.h |  10 +++=0A=
>  2 files changed, 189 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 4309979eeb36..64cc2a9c38c8 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -44,6 +44,19 @@ static inline int zonefs_zone_mgmt(struct inode *inode=
,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
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
> @@ -321,6 +334,17 @@ static int zonefs_io_error_cb(struct blk_zone *zone,=
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
> +=0A=
>  	/*=0A=
>  	 * If error=3Dremount-ro was specified, any error result in remounting=
=0A=
>  	 * the volume as read-only.=0A=
> @@ -335,7 +359,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, =
unsigned int idx,=0A=
>  	 * invalid data.=0A=
>  	 */=0A=
>  	zonefs_update_stats(inode, data_size);=0A=
> -	i_size_write(inode, data_size);=0A=
> +	zonefs_i_size_write(inode, data_size);=0A=
>  	zi->i_wpoffset =3D data_size;=0A=
>  =0A=
>  	return 0;=0A=
> @@ -426,6 +450,25 @@ static int zonefs_file_truncate(struct inode *inode,=
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
> @@ -604,7 +647,7 @@ static int zonefs_file_write_dio_end_io(struct kiocb =
*iocb, ssize_t size,=0A=
>  		mutex_lock(&zi->i_truncate_mutex);=0A=
>  		if (i_size_read(inode) < iocb->ki_pos + size) {=0A=
>  			zonefs_update_stats(inode, iocb->ki_pos + size);=0A=
> -			i_size_write(inode, iocb->ki_pos + size);=0A=
> +			zonefs_i_size_write(inode, iocb->ki_pos + size);=0A=
>  		}=0A=
>  		mutex_unlock(&zi->i_truncate_mutex);=0A=
>  	}=0A=
> @@ -885,8 +928,128 @@ static ssize_t zonefs_file_read_iter(struct kiocb *=
iocb, struct iov_iter *to)=0A=
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
> +static void zonefs_close_zone(struct inode *inode)=0A=
> +{=0A=
> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
> +	int ret =3D 0;=0A=
> +=0A=
> +	mutex_lock(&zi->i_truncate_mutex);=0A=
> +	zi->i_wr_refcnt--;=0A=
> +	if (!zi->i_wr_refcnt) {=0A=
> +		struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
> +		struct super_block *sb =3D inode->i_sb;=0A=
> +=0A=
> +		/*=0A=
> +		 * If the file zone is full, it is not open anymore and we only=0A=
> +		 * need to decrement the open count.=0A=
> +		 */=0A=
> +		if (!(zi->i_flags & ZONEFS_ZONE_OPEN))=0A=
> +			goto dec;=0A=
> +=0A=
> +		ret =3D zonefs_zone_mgmt(inode, REQ_OP_ZONE_CLOSE);=0A=
> +		if (ret) {=0A=
> +			__zonefs_io_error(inode, false);=0A=
> +			/*=0A=
> +			 * Leaving zones explicitly open may lead to a state=0A=
> +			 * where most zones cannot be written (zone resources=0A=
> +			 * exhausted). So take preventive action by remounting=0A=
> +			 * read-only.=0A=
> +			 */=0A=
> +			if (zi->i_flags & ZONEFS_ZONE_OPEN &&=0A=
> +			    !(sb->s_flags & SB_RDONLY)) {=0A=
> +				zonefs_warn(sb, "closing zone failed, remounting filesystem read-onl=
y\n");=0A=
> +				sb->s_flags |=3D SB_RDONLY;=0A=
> +			}=0A=
> +		}=0A=
> +		zi->i_flags &=3D ~ZONEFS_ZONE_OPEN;=0A=
> +dec:=0A=
> +		atomic_dec(&sbi->s_open_zones);=0A=
> +	}=0A=
> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
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
> +		zonefs_close_zone(inode);=0A=
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
> @@ -910,6 +1073,7 @@ static struct inode *zonefs_alloc_inode(struct super=
_block *sb)=0A=
>  	inode_init_once(&zi->i_vnode);=0A=
>  	mutex_init(&zi->i_truncate_mutex);=0A=
>  	init_rwsem(&zi->i_mmap_sem);=0A=
> +	zi->i_wr_refcnt =3D 0;=0A=
>  =0A=
>  	return &zi->i_vnode;=0A=
>  }=0A=
> @@ -960,7 +1124,7 @@ static int zonefs_statfs(struct dentry *dentry, stru=
ct kstatfs *buf)=0A=
>  =0A=
>  enum {=0A=
>  	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,=0A=
> -	Opt_err,=0A=
> +	Opt_explicit_open, Opt_err,=0A=
>  };=0A=
>  =0A=
>  static const match_table_t tokens =3D {=0A=
> @@ -968,6 +1132,7 @@ static const match_table_t tokens =3D {=0A=
>  	{ Opt_errors_zro,	"errors=3Dzone-ro"},=0A=
>  	{ Opt_errors_zol,	"errors=3Dzone-offline"},=0A=
>  	{ Opt_errors_repair,	"errors=3Drepair"},=0A=
> +	{ Opt_explicit_open,	"explicit-open" },=0A=
>  	{ Opt_err,		NULL}=0A=
>  };=0A=
>  =0A=
> @@ -1004,6 +1169,9 @@ static int zonefs_parse_options(struct super_block =
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
> @@ -1423,6 +1591,13 @@ static int zonefs_fill_super(struct super_block *s=
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
>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
