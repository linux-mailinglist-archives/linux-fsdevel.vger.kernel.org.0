Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026FC26589D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 07:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgIKFME (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 01:12:04 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7119 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKFMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 01:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599801120; x=1631337120;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=K+UFscSyzkZfJo9fawfweifl7g2CjD6i/xozT9wJwiw=;
  b=fvAmNamUZzCQwCu3E6VVnYhNPE1HzjU1P/wiYqc+7ULvVc9NA49ySow1
   1pXaC4vH55VQexYRjIW5GZa4FL3jGkgh/OccioCkH84xwTB5KmZsIs2Hz
   Q/nSst1DvUIGJZ10tf54DlMuOtg+vFgn13o50AxSlpKxzSmf9Qhfp8gA4
   TESNC72uSCWe5miwhvlvqRWxfoTE/xkVvhV/pcmwmscyXDsRLhNYdNvT0
   BPiQXgLWnKdLYDWzy3MKcZVAHJoTGrB2Ldy/JTMZJ7VMrMgoV4w3Rz/1C
   vYLTX2niJ3uhHTfs9T+/caCeEPhqxPPxxolRv23DyRst4udwZXGmThhhN
   w==;
IronPort-SDR: ximeW+oXZ+PqORKhjb0TU9c3C/+HU2y92XJT8J7Dv7tkEyLa52+S2RGwOX8looBHOKqBvl5nKq
 X5Ht1T0I6z1bxeipJ2JtWib51jVqhabjfzmb9tQBQxsox3izQUf9KNmsWPi2EUX2vC5STUAgWA
 3gcQzfB+L3A8YE7Qkz3u/BFqGF7uzuTwBATUZojIe70RSpfhRLPTWmKLYKKVt7pkZ8hcERDKHk
 AJuv5wvBLrlWSPWlnqqvx9/JYfV7p5EfN242jZ8WBqXW2td+YeRuDshWjS5/C4E7ugVpnuz/Xt
 Ag4=
X-IronPort-AV: E=Sophos;i="5.76,414,1592841600"; 
   d="scan'208";a="148331796"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 13:11:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Omf5W6hZsHEPtfu0h1r/430hbcOx3ef5b2lmnj58sn6R942L1G8fe8niViddZJ1n3M+3/E5g8RohLNiytnPHspzoa4ovON8D6Z+kZ84aUnW3EfUvwcCK0dsuxTBk8Jfh+NL/YV1EsMWbh4fgAWbgCyEKJgJXEERnNv5RY6QHHUTl2pniL7MDEJ+XAqg4ZypjCs1nVnLN9mDyWcfpdaUIwnR4OIYgLtjU2k2xt67vlsj9s/CzkjqFT+KouJouqd7iapGw2BWzIsVLQwQeZmAGSWrpwFVXT8HiYnIOuYthF5WRN7aVYAbZhlzatMKQnYxdk8Ae1BKnHz/sLK+G4sNceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKIBTvoQiRKXiMFu7XlpqnCEFu+G1/xo08I06Jzz5rA=;
 b=YHWl+Vdo1paktC4XPPc5XF7k3FbfH/ZADZh3+d3sE62jqJoNNofH39FH1+yTY/DYVvNS56kfvqKc48/thE1zI4jtExaJmIM1QD2hfjjsHr/XrBe4VOpXhM8pb/sXgWz+Hb9kkw86BcymUUjIIwpw9uyiXwHCmbCwl8VaOVF8ERpHTArrKlP/ul5OatHjfQXREsmMTbzUWoOoAJFwlD3cYZCYrrSWwLTMN6+bjylD4FPXouDVcV4mPDSwGK4BlsJj+M6QHGW7cH0gL6IB0wrTy/0ajroTGKDXJ0JIE00Vw3jUNui6UvHY87kdhB/LPR6mWi+9VQzJjiWwIU7QpVtuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKIBTvoQiRKXiMFu7XlpqnCEFu+G1/xo08I06Jzz5rA=;
 b=TS4MZ+7blcO465jcmIvJSMT4ESyj0VrPjL3qhyXF1eX46RNoIzUOHlqK1HFB2Uv2DmjqWHnMaWKkPX14vo/IX6FjFg3mkaTIMbhyZZ+9JGrxPCJ0aJHqeTEH7pfEqtabXEsi59jaZEe6ohdFpMvjBC8iTbs0XlKefW8dE5eMcKk=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0425.namprd04.prod.outlook.com (2603:10b6:903:b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 05:11:58 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Fri, 11 Sep 2020
 05:11:58 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH v4 3/4] zonefs: open/close zone on file open/close
Thread-Index: AQHWh3/4BGo3qjOT4E+ZGeYXIQJ7Qg==
Date:   Fri, 11 Sep 2020 05:11:57 +0000
Message-ID: <CY4PR04MB375116B70163C393E7F058D8E7240@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200910143744.17295-1-johannes.thumshirn@wdc.com>
 <20200910143744.17295-4-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:dc48:bbfc:f5cc:32c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53226b37-d22b-485d-f0ee-08d856113542
x-ms-traffictypediagnostic: CY4PR04MB0425:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0425B767E3FA39F1AA4794EEE7240@CY4PR04MB0425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HsTt6lmA6vB4zDjbMAD5MgYnQDW+iutseI9sLESin6z5J9vC4MD4SgeKthYMz4fCFMzMXUY5BsJMFbbuBshMPEioPKrrKZkmf2VaXC1jW5EXni/M8+sHf/y7M1d/P3JrISKth1iidFfgN10TQnCeAbLCmWpogDumOvCICY5ouOYFIJ0yH8GksWUVW8vfPucSLVqbwXg8YM6LSw1fFXZrcE95TfMdcAOHzX6rwJraTgG/qsNhaxT5prwxNX6nP22QWZf/2+kEW5EHidfwqME2pkjx0KwUOHm85wVB9OWnOfhN4WIkIgEZ3WwfYMgJiP3xUk2zKr0jXZGhvxTii8ItGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(6636002)(8936002)(478600001)(30864003)(186003)(4326008)(5660300002)(2906002)(53546011)(316002)(6862004)(86362001)(6506007)(71200400001)(83380400001)(76116006)(66446008)(7696005)(91956017)(66946007)(33656002)(8676002)(52536014)(64756008)(66556008)(66476007)(9686003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: QU6YKRtISJJyenq53L+0CLHElyIHIviNB5SsmT2G8b9nKCT8dTQGJtOWkUyEtwAg1qukjbAEL/Vb280qg861CV+7TeInK3JtQFASEgt+A89EK60GV7VVHsA3ec4varm9JQp2OLSF2jaI1KsAoyr9sNZVLtCoJ9/M2JaTUlSuDwhYUB4prjbVZ86gR6GvZST5O4Q7AhBtol5424ycUeWjQ+Yve+ARxsSm2nc1op1STGszqPA0mGx555WWqlo7k6Ruf/M5BdRI0nbbpZY9JXbAFtxfSFBLpgwIqtN6QpF5Ud0K36lBmQNUZg+jlfaAj2/xV/3g24QWN3bNZLBHg0Cx9CBC+EABEacYLac4jWrSz1ajO3/3d3Yr62QVmptw1OPSw9cM3dvPAd/b7cDL8xrdFmmUiyo+H/LYvvXTfiTQhgNvaZAgfIr2yCPDIyx+6M28TsnzGtXe/KJ8MzZ3wejuBpX1T8t3rJBmGJdl+PvmzYqdOec1az67DFO6dAzFcgsyF+gisqaNTv5zqF8wXk18+vdqhBZfYpjQNbGub0easz6sCXHfCdJQiIDlPsmQaX3Ype82KRFetU2b+YGHDv6r0PBjhpDB/2AT0OvbUv1QlfXjqmgFg68FPle70XjWjH8WjCKG0ZRcCVIwisW8Ru44YcHztDk7EzmqfiYLOOtBaR06kNj7MfL/+E1HE1m4v8VhoxdU2pS5SqdLa7aM4PAFLg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53226b37-d22b-485d-f0ee-08d856113542
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 05:11:57.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G9MOC4O+tEkHk8aWhyI0ndx16MPEeWMjgut6F4aw1pEmkAYTDQfaquVdQ+sIUZUT5/15G6Dlx3qyhx/zKlkRLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0425
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/10 23:37, Johannes Thumshirn wrote:=0A=
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
>  fs/zonefs/super.c  | 187 ++++++++++++++++++++++++++++++++++++++++++++-=
=0A=
>  fs/zonefs/zonefs.h |  10 +++=0A=
>  2 files changed, 193 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 3db28a06e1a2..0b266b4212df 100644=0A=
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
> @@ -885,8 +928,132 @@ static ssize_t zonefs_file_read_iter(struct kiocb *=
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
> +			 * If the zone open flag is still set, it means that=0A=
> +			 * the zone is neither read-only nor offline now. This=0A=
> +			 * can only happen if sending the REQ_OP_ZONE_CLOSE=0A=
> +			 * request to the drive failed, for whatever reasons.=0A=
> +			 *=0A=
> +			 * It's better to mark the FS read-only (if=0A=
> +			 * __zonefs_io_error hasn't done that already) than to=0A=
> +			 * loose any data.=0A=
=0A=
I do not think it is about loosing data. If this type of error is repeated =
with=0A=
the open zones left as is, you can end up with only these zones being writa=
ble=0A=
and everything else read-only. So better take action and use the remount=0A=
read-only big hammer right away rather than ending up in a weird FS state. =
So=0A=
may be something like:=0A=
=0A=
			/*=0A=
			 * Leaving zones explicitly open may lead to a state=0A=
			 * where most zones cannot be written (zone resources=0A=
			 * exhausted). So take preventive action by remounting=0A=
			 * read-only.=0A=
			 */=0A=
=0A=
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
> @@ -910,6 +1077,7 @@ static struct inode *zonefs_alloc_inode(struct super=
_block *sb)=0A=
>  	inode_init_once(&zi->i_vnode);=0A=
>  	mutex_init(&zi->i_truncate_mutex);=0A=
>  	init_rwsem(&zi->i_mmap_sem);=0A=
> +	zi->i_wr_refcnt =3D 0;=0A=
>  =0A=
>  	return &zi->i_vnode;=0A=
>  }=0A=
> @@ -960,7 +1128,7 @@ static int zonefs_statfs(struct dentry *dentry, stru=
ct kstatfs *buf)=0A=
>  =0A=
>  enum {=0A=
>  	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,=0A=
> -	Opt_err,=0A=
> +	Opt_explicit_open, Opt_err,=0A=
>  };=0A=
>  =0A=
>  static const match_table_t tokens =3D {=0A=
> @@ -968,6 +1136,7 @@ static const match_table_t tokens =3D {=0A=
>  	{ Opt_errors_zro,	"errors=3Dzone-ro"},=0A=
>  	{ Opt_errors_zol,	"errors=3Dzone-offline"},=0A=
>  	{ Opt_errors_repair,	"errors=3Drepair"},=0A=
> +	{ Opt_explicit_open,	"explicit-open" },=0A=
>  	{ Opt_err,		NULL}=0A=
>  };=0A=
>  =0A=
> @@ -1004,6 +1173,9 @@ static int zonefs_parse_options(struct super_block =
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
> @@ -1423,6 +1595,13 @@ static int zonefs_fill_super(struct super_block *s=
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
With the comment fixed, I think this is good.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
