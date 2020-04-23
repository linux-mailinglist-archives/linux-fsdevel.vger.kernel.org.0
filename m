Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9BA1B563C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgDWHm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:42:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63666 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWHm3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587627749; x=1619163749;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gTF7Z3ZVrqAec4XJpzs3/18TlXZ1h7T+5K9nJODd7do=;
  b=gTGxhNcACQnpROgWZtF3ivMc2UYs4h3uRyoobuA1QlhyCh4Gf2oBIcsh
   LO99Ez3fbt7kOuBFHriZTbxnENI8wTPHiQCDCR0bdX6eSAMtruiPMYK93
   KwDNgozOOgzmEfeostJaVumC26zCX1r5zJWsGXDxCdmJLMgpzCTQj8sBl
   av53m1k+3ojVcFFTquISPSZ/ji2pXv+aSjh10ssYuKDTZaP5ulGOTR2Xd
   RUpxKpJte3Kzr/wXiuhoEXdlwjtjDdg9YH28yBSfwqL6/EiFS8jvn0lWz
   wzrhhl5torilBdhxbJnWEiWkHpY7zP6DAGuVLqz5TUbbYmvy+BOS/uDlX
   g==;
IronPort-SDR: gOHZ2TBbHsjMXSjQMyCNJsf88fHgRsb+87CytUeoRHmR/nvY8V7Xiz11ih4moL2WdFMYWgfEC3
 /W2zxmOMnonbYmBydKqceKkJr7oR2T7l0sLmfe5ATIaVEvWUe0o0ENueXl+bwDC/SFw4JFQguN
 WwWqHkEIWxPcWgKnN0YB3o+K4brQsLFccEWXetuvAhHwssL6G819BH4lGSO1BEwL8W905rWjD/
 28iTFwoCq9jDZpTcI1ZgdODQ0rt/cPsu0g9/TMv5HAOg9QdTznLsa8xv+K91QMMYCCvIt1cCI6
 iPM=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="140308227"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:42:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkvIkBoY2YMwyp51Nq/fDA+edAvCmAantqEJyCcFp9g0rUJCjcsbxT5aG9m7HXh45mT++biaAjFFqeXiZlbWd4s+Haq8Xtsyp662J/QfVwfqXKZqOzMxxCulDYZaH/LN2s6cFKx4iiUc8ohMrypZggsClse0iZAf7hUbt//z9mMYcmbZ12Q2bYz6h0ZzWhfeI0oSYyMKZ/bZgBh1kppNCklf5lAV31HMdeMsNPTGUjC8GdvwCX+/1EKCGBzPLd2/CV5zXJHSl5TffllUIABZhh7M1wpoaXHalbLv5FFsdggTXOcsY8Uvqmcpiq/fT+zj8bMOwNB/a0IjRDRcsaRycA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIu0rroR7MhPRYSnVWIIeI/LgJ25yn2ZE24Jd5UrY3Q=;
 b=GSzMZin4n13asYPv6cPfN3lqsyBRWZekcJLJueVM+sO1gBTfGFuDQuJLCOD3uiCta+uWAyNOZSluUiIS2zn6f9SI1OXD2D9cZ60fzQwJDXwJRz88kbMN+EP8mUntVFyMY587EZNt4ODqT8G97vXtt5EFL0CAxRoWDDNCetYM1Ruwvvb2dCFjn6CxQECtKwcNaS+M9MaNgWk8dY9iuxpSq8DhU3X86XdM2yuBBXvpL4ilUTOQecuMjcKXYa7zrczweWvbea8QyW4BqGsSXW8Z2ruCPyOVkEaZgC6L5pDN0z/cicit50FBurUsIIZSl/lnVD8PE/fnmjfzsgUJA6yM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIu0rroR7MhPRYSnVWIIeI/LgJ25yn2ZE24Jd5UrY3Q=;
 b=wWDgy4g3lSO5MXu1DZhF9oJOlxSPGrkFsYUcUA2NxiXxR3XiKkFKf4ifnO+SIBdd+3nUiozmBsJvXZsaP7UzX7etDbLLOLTu0fM5MGO2X7PGY7Z55TBc5uW4uoKtLKo5JEuCRVlAc4SsHgu+mRerK8i4hWxlxEnMVPAF2/PAEis=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6723.namprd04.prod.outlook.com (2603:10b6:a03:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:42:26 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:42:26 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] hfsplus: stop using ioctl_by_bdev
Thread-Topic: [PATCH 5/7] hfsplus: stop using ioctl_by_bdev
Thread-Index: AQHWGT8NPdskV3ohNU+tD+3v4fgM/A==
Date:   Thu, 23 Apr 2020 07:42:26 +0000
Message-ID: <BY5PR04MB690068E22B67AB977BDB8046E7D30@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa7290e9-9e7d-4f27-57dd-08d7e759de6b
x-ms-traffictypediagnostic: BY5PR04MB6723:
x-microsoft-antispam-prvs: <BY5PR04MB67236CB0975285DAC3C7E983E7D30@BY5PR04MB6723.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(7416002)(4326008)(33656002)(2906002)(5660300002)(86362001)(7696005)(64756008)(66556008)(316002)(66476007)(66446008)(52536014)(66946007)(186003)(478600001)(76116006)(6506007)(54906003)(55016002)(110136005)(53546011)(26005)(81156014)(71200400001)(9686003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Q21LItyGKHauNVcJSVh5pJwb2tjiftImhHBiwRwhstqAq2YWa/HDntAAV/2G3SrCgsiWTcKElVoqpZcS5aNrpei78Ntr3uyfD2k6/qi6AZnkno65h8My3SCS3LXPhHqPgNA+AA3CqxwA3G+WvLsyqqb7g2c5xiwvm46leqA1WisHpYnGBaFULHYUr7en2PS4aPyODgAQY6suy6SNrVCOJoZEE1iJgMGrl07xUehLwVGWVfZG8QXnjp9nPgQLVjzzsftVDKtsV3s6EqUBL5gBVQE4gJZQdhYWguJaXzLlyZryaB8Ah2AbM6fa/LBt7eGUna3iHgP1F/0wbkwJOFE65AFQecZ55QqGmI9xfJYKTU+W+vM7rHJv2PkSEQSEeMvhRq3GHGfryrOvJ0JSvGIfLhi0QUa9W1++dI20CoNyjFtZUx9cM4pz5M9NEb8bJOd
x-ms-exchange-antispam-messagedata: XIQFpWMJqSIOVN5HPb12k5ClcLACaPPN97cH0XL5LGviNQ/sIZSpUwIQndmvJvBvtXQPkZEkD06quOpn2ndbMuWLTPcaR3ZednBJcii6etqMpv0n8k0ACFh9BZkz9woK3svrHcKl89ECWavK4DQWLw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7290e9-9e7d-4f27-57dd-08d7e759de6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:42:26.3895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIdRNDFjtTaVUjviDigg0SsBNycixSqx4yjVqG0ZcEsjBIOF/8fzVdDg156xvsBPk/5xoPatcLOloAXHsp2igQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6723
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/23 16:16, Christoph Hellwig wrote:=0A=
> Instead just call the CD-ROM layer functionality directly.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  fs/hfsplus/wrapper.c | 33 ++++++++++++++++++---------------=0A=
>  1 file changed, 18 insertions(+), 15 deletions(-)=0A=
> =0A=
> diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c=0A=
> index 08c1580bdf7a..61eec628805d 100644=0A=
> --- a/fs/hfsplus/wrapper.c=0A=
> +++ b/fs/hfsplus/wrapper.c=0A=
> @@ -127,31 +127,34 @@ static int hfsplus_read_mdb(void *bufptr, struct hf=
splus_wd *wd)=0A=
>  static int hfsplus_get_last_session(struct super_block *sb,=0A=
>  				    sector_t *start, sector_t *size)=0A=
>  {=0A=
> -	struct cdrom_multisession ms_info;=0A=
> -	struct cdrom_tocentry te;=0A=
> -	int res;=0A=
> +	struct cdrom_device_info *cdi =3D disk_to_cdi(sb->s_bdev->bd_disk);=0A=
>  =0A=
>  	/* default values */=0A=
>  	*start =3D 0;=0A=
>  	*size =3D i_size_read(sb->s_bdev->bd_inode) >> 9;=0A=
>  =0A=
>  	if (HFSPLUS_SB(sb)->session >=3D 0) {=0A=
> +		struct cdrom_tocentry te;=0A=
> +=0A=
> +		if (!cdi)=0A=
> +			return -EINVAL;=0A=
> +=0A=
>  		te.cdte_track =3D HFSPLUS_SB(sb)->session;=0A=
>  		te.cdte_format =3D CDROM_LBA;=0A=
> -		res =3D ioctl_by_bdev(sb->s_bdev,=0A=
> -			CDROMREADTOCENTRY, (unsigned long)&te);=0A=
> -		if (!res && (te.cdte_ctrl & CDROM_DATA_TRACK) =3D=3D 4) {=0A=
> -			*start =3D (sector_t)te.cdte_addr.lba << 2;=0A=
> -			return 0;=0A=
> +		if (cdrom_read_tocentry(cdi, &te) ||=0A=
> +		    (te.cdte_ctrl & CDROM_DATA_TRACK) !=3D 4) {=0A=
> +			pr_err("invalid session number or type of track\n");=0A=
> +			return -EINVAL;=0A=
>  		}=0A=
> -		pr_err("invalid session number or type of track\n");=0A=
> -		return -EINVAL;=0A=
> +		*start =3D (sector_t)te.cdte_addr.lba << 2;=0A=
> +	} else if (cdi) {=0A=
> +		struct cdrom_multisession ms_info;=0A=
> +=0A=
> +		ms_info.addr_format =3D CDROM_LBA;=0A=
> +		if (cdrom_multisession(cdi, &ms_info) =3D=3D 0 && ms_info.xa_flag)=0A=
> +			*start =3D (sector_t)ms_info.addr.lba << 2;=0A=
>  	}=0A=
> -	ms_info.addr_format =3D CDROM_LBA;=0A=
> -	res =3D ioctl_by_bdev(sb->s_bdev, CDROMMULTISESSION,=0A=
> -		(unsigned long)&ms_info);=0A=
> -	if (!res && ms_info.xa_flag)=0A=
> -		*start =3D (sector_t)ms_info.addr.lba << 2;=0A=
> +=0A=
=0A=
White space change here, but I think it's ok. I do like a blank line before=
=0A=
return :)=0A=
=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
