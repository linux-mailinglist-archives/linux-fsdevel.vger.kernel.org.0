Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90952262FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 16:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgIIOd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 10:33:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34732 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbgIIMws (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599655974; x=1631191974;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YNhIq+fpFTUFx1RGXRdGvbsv2VLPksndYj59ALTho7Y=;
  b=SbIQYk5a/mAuEwgt5o+dlGbWxfBwzL8kBQFr3L+r1SD2gELo9wYlS4Ct
   Ore89A+dVkfaDmAGGR+iqJDeZGZHR2TcDCr42noMFMBVGolmPQhvYZxbE
   IdkgJNAiOoAneysnhJVwMeuyHSjOcgnGTTAu/hRBzFsgFH5ZKmYPkDqCv
   RTKpOG0NsdDvLU/90YIzJyhrbd16Wb0RCq8+379jH1OwMs45Ijd1HQjdW
   WW18MxwEVFTnxSRxLIE3SLnxdTUvl58R2jCZN6Q3EJZUgJO1U3vCChXGe
   AZ4hq2rTbV38wYVkdWuRj5MGyS/i5L2GybdzuxmsGF8IZsMl+Q5DeGcfC
   w==;
IronPort-SDR: +KjhwYJi5n/nHz/+nWWjlt6PnISRHUn+HVlXwkdkebCK65I4eUHTHMSTLaZixNshZaWmLH8pk6
 rhDt3ne6+xcdcC+L4ePZomzA87YYB/9q3TqRD2A0JKyIlNkDLQVqI1pPrDMfsJHL4MzroP96gF
 Bs2gEOfXnNMDg5Ao8wVeRIYFphpePrzGqqnUT88ZnOFRZmccmekS5cVKWkOxf8xFg4qylecxqF
 gqI9mRGCfLq+BmV2w81zyOelUnqnytAnOlEuALMHt+BouvFT83LPm3H19sobQCE8G1TP8UgNhu
 Gs0=
X-IronPort-AV: E=Sophos;i="5.76,409,1592841600"; 
   d="scan'208";a="151280426"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 09 Sep 2020 20:50:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQLfvv1x4uHYVDoDhqwfJoCuPSWCiuDObSpVN8opsxcRUa3uJszbj5hwTSNp/HRbwLXEaq9F/Mo59WD47/533pRY9CY0aCmmnyBHwcGrj4p6y5pu0q7ZVFVmOFO2TQYc6mnWRQ8jDAogcy7NPlyrHkoiRafogkc+igZtxJ1ISEvBMxPs6nDLX/OUAgxmR9cTOF46j09iXZ7fu9gYipORS5Te6+4ktDHm2oYxpD9nEyEj6FUjoBcmVtGqF/zJoRT1xJ2H/GUnrda6gLfwCjMbb5UadXkDWOH+CLtO2je6SiFOhcaPHmeInGX58ZFewkOYgDSqnaGhbWDTAa3J25HScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq8SxxY7i4trUl5OJuucCwhCl1hAr3axy22x/Eafn+g=;
 b=m9hQ+MWzaL7OSFVDdaQ79tPsy6aGCuriW/LibBIpufeRcF43Fm9PcmFKnBpOma3S/twTBuXeDOPMc80eDsp1KY929CpEl5d2APfqTAnelqYw6+b7xl0Lw8rBpQezywU1AsR3oLq8J5T2VVSJRjHMTBVazH206xW9TxkX0JNIY2Cz1zhQ1yZvXHmPIqQjWtpBHl9NauW3E3tSwYjislq26rbheGerPzXV3IXm3HguMyp5atjXNcZ/0FPZU/N8ap5oeCoQUxRjhykGEJdTg0eiPig8KtEyLcdrTzlI8zPVX0yetdgYF/fvStuHHwuEeDx2ETPvDQZXvhB/czgws/xGig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fq8SxxY7i4trUl5OJuucCwhCl1hAr3axy22x/Eafn+g=;
 b=puJeycRuSpGFrTOTQrGmmuIyoDWVLy5+NGSfRQ/tfdKkRXIgkLqkuu7gWuNYzQPQuchSP8Y13gfqoLIfNTJZ0wU9YZnWoRWuuOyyMFM5BskgFDNDeIKFqwdvp+9IWsFbucTFLZgiLvX7XkWLFSPcSeWHX8XVnv5bYhhq4Mtz1aw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0727.namprd04.prod.outlook.com (2603:10b6:903:e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 12:50:07 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 12:50:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] zonefs: open/close zone on file open/close
Thread-Topic: [PATCH v2 2/3] zonefs: open/close zone on file open/close
Thread-Index: AQHWhpOyiIfYDafhGEyPwro1z3H7Pw==
Date:   Wed, 9 Sep 2020 12:50:07 +0000
Message-ID: <CY4PR04MB3751CFEAF07FAFF3A2E48156E7260@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909102614.40585-1-johannes.thumshirn@wdc.com>
 <20200909102614.40585-3-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1c31:4ce8:636b:3f7e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1252d989-f615-4a49-1d26-08d854bee152
x-ms-traffictypediagnostic: CY4PR04MB0727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB072746DBA878F6722C4A14F8E7260@CY4PR04MB0727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ck6AenvI3V8Ao5SB2JLki0h8xh/WThgYPlFCSgq6J8ZnQvc0jiVmbitqbPqHwHW7CRzook22N3jHcGLsNB8Dr2oAEKu5GAZFsHkTpzxDeuW0OVbn3iWhq70rtBlIih9B8xi4L6Aus+3PONIMLcFxIBNL2tji0VNWTl2H4X+bG8MgSPtywHLxSM0ArB3cpJfmJMW7WL7PfGlbx5YR2CBypyEAfon6Eh+1f3vfEF3p4ROvEbPFuGV+A20c4fIrCbofIanMasxG/Cd0p6iMVBj55n1jOvrI0Ic/dRT759cf3NMS04oCNQ5VLpgIXlmIeec0iC7zFBCkxJSDHyoaAjxceA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(7696005)(66946007)(478600001)(8676002)(186003)(9686003)(55016002)(86362001)(2906002)(83380400001)(4326008)(6862004)(8936002)(6636002)(5660300002)(64756008)(66556008)(33656002)(66476007)(76116006)(66446008)(91956017)(71200400001)(53546011)(316002)(52536014)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6GT0Lb7Q5RhU09NQnwLJ5GJORFtwc1F/XTgpPEPoA5Ot3FLq9T59II4UPFNeIhYLl/V54y6k7Ogm/+OBUv4khPNjD34s7UixjNrSliOH3uW7t4w4BTjWI1okAwQw29l0QLd7E40zIVUD8LrTi+GzB/4GhwIFdSPyrYnv+wy4OLA0sdHMvaOa7WxEIEeEPbxygQRA4oAW+GHHxAPulyYGO9/X0WDYTXtKDm44yn17zggHEXIepX3DLssW6QXETa1uiXvXR3VXfNzFqSGWLoUtGzhbFhqkW4oXi4zQbwuGYqooxiOK7xA4VWGzKl6mEMM86vrLi3ILD8wjy9bZewokOy6qZc1qrPM4u2v4IE2bwrxzYHfzaxCzQWJulEfv3ZvMlUv9RM1xXKgzPGyWC2J/uzqPLigEXe3JPbFEk/RKGgzgZ1xtIwjraI14LLRxiCj+xlyP1Cm1+BKAM8dIACwzIIN98qcNQL0cHCnK/G3lnaUgKfJVjfYJkqaJHRP78VyveLzscYYu+iOoC/TDI09cFKiVN6q/qA/gi10BV7YmaQhNo2R6mBoxUq874AgJisHEJmUclmBK2DgIa1a3bVwlXgGtVnlf3wQmnOJUz9S+zQurXNuAxJ7EqNTPh3fJYz2dkbPnkxlKkvN5plnKU/UbvuNm7uLCnh6aquAYMefmtrkmGn78ybAr5fEAhFb+ytDtL2AKrnI21bEhTMotlFqKZg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1252d989-f615-4a49-1d26-08d854bee152
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 12:50:07.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SAvnBemeYBoL4pubHdxi9RUGmNOZLF+n2UR424aAYm9cG+ju71bAJoSdbCSbTcmKmkbPi79FXUSu+jZj7mIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0727
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/09/09 19:26, Johannes Thumshirn wrote:=0A=
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
>  fs/zonefs/super.c  | 160 +++++++++++++++++++++++++++++++++++++++++++--=
=0A=
>  fs/zonefs/zonefs.h |  10 +++=0A=
>  2 files changed, 166 insertions(+), 4 deletions(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index dc828bd1210b..07717df2fac9 100644=0A=
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
> @@ -421,6 +495,25 @@ static int zonefs_file_truncate(struct inode *inode,=
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
> @@ -599,7 +692,7 @@ static int zonefs_file_write_dio_end_io(struct kiocb =
*iocb, ssize_t size,=0A=
>  		mutex_lock(&zi->i_truncate_mutex);=0A=
>  		if (i_size_read(inode) < iocb->ki_pos + size) {=0A=
>  			zonefs_update_stats(inode, iocb->ki_pos + size);=0A=
> -			i_size_write(inode, iocb->ki_pos + size);=0A=
> +			zonefs_i_size_write(inode, iocb->ki_pos + size);=0A=
>  		}=0A=
>  		mutex_unlock(&zi->i_truncate_mutex);=0A=
>  	}=0A=
> @@ -880,8 +973,55 @@ static ssize_t zonefs_file_read_iter(struct kiocb *i=
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
=0A=
OK. But zonefs_io_error() needs to clear the zone open flag if the zone wen=
t=0A=
read-only or offline. Otherwise the zone flag will be left as is, and also =
you=0A=
will end up getting an error on close if the zone already transitioned to=
=0A=
read-only or offline during IOs.=0A=
=0A=
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
> @@ -905,6 +1045,7 @@ static struct inode *zonefs_alloc_inode(struct super=
_block *sb)=0A=
>  	inode_init_once(&zi->i_vnode);=0A=
>  	mutex_init(&zi->i_truncate_mutex);=0A=
>  	init_rwsem(&zi->i_mmap_sem);=0A=
> +	zi->i_wr_refcnt =3D 0;=0A=
>  =0A=
>  	return &zi->i_vnode;=0A=
>  }=0A=
> @@ -955,7 +1096,7 @@ static int zonefs_statfs(struct dentry *dentry, stru=
ct kstatfs *buf)=0A=
>  =0A=
>  enum {=0A=
>  	Opt_errors_ro, Opt_errors_zro, Opt_errors_zol, Opt_errors_repair,=0A=
> -	Opt_err,=0A=
> +	Opt_explicit_open, Opt_err,=0A=
>  };=0A=
>  =0A=
>  static const match_table_t tokens =3D {=0A=
> @@ -963,6 +1104,7 @@ static const match_table_t tokens =3D {=0A=
>  	{ Opt_errors_zro,	"errors=3Dzone-ro"},=0A=
>  	{ Opt_errors_zol,	"errors=3Dzone-offline"},=0A=
>  	{ Opt_errors_repair,	"errors=3Drepair"},=0A=
> +	{ Opt_explicit_open,	"explicit-open" },=0A=
>  	{ Opt_err,		NULL}=0A=
>  };=0A=
>  =0A=
> @@ -999,6 +1141,9 @@ static int zonefs_parse_options(struct super_block *=
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
> @@ -1418,6 +1563,13 @@ static int zonefs_fill_super(struct super_block *s=
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
