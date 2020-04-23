Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7F1B5649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgDWHnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:43:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63722 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgDWHnG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587627786; x=1619163786;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/qcw3NEvZ11NnjZsFYWSZfrZBRtxiXGKbKF3p/SPdog=;
  b=nQBX/HvBM/1RrM5AuWLqDIoDdyPGz7cTTKZh6NAlGGVwkrC8Hd9sZQg+
   /e87l416VC05tZWDLEHqXfa79EHDZhlCt3ZCAUpSx9dTsw9t771Ks3zzf
   UK6TvUHO98pFq8gj8FshHFuxM88iAQaKFmTrZICldXNaMnkm9aDxHRP4l
   Dqqfpar5qZ2V5egzOva7lvqSO1qj6aAaEFrIBUE+0CJ+dXk7p4fT3uV4X
   sNaOw0fp1EoFzOTIJgzYEXXG5rKI5so8is/IufBBA2jgls/+Dx6FJwhkm
   E1AjepflwKe1Ag6Q1N3OXRHgR4liP6sX91NiwIb5pS2vw9u1p7hzmArLv
   A==;
IronPort-SDR: 84nxMFtPq92w7W6Zw2yCf6uRbD3rqwXvxT5qnvvD3UWfdIIcV/+P9l4NStthZDJ3qgxrsw+0SC
 roFY2MxJYD9qyqP8z6qLTflAhhR0/M0y/fMcd7CzvCRe8jfw93ldzsX0luACXh2oAGqPWWrFiJ
 QyWyddR8j5FhiVizm6YOQhNZWMXdPMu6/z/YvsQo5+O8kXpEghecO+fsx39O6o+jf9ovwu5cC9
 kuy+tzuxZrJaYasb2heDS1A9zlGRkowIGwFGoS7dVC5NCLF1+JtvG/P5dAlfOrgEwZAgTPDUrM
 eH8=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="140308281"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:43:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfSuq6+2Lu5ulsYcjhyKEfFzLuGqxRBzaonx0k1t/UjXNO6PzlqKF78gH4j//virrs5Sjgwq5VHh3lrsszD1A+RI2p5bWVirGZhDx+nGumEbuU1chP6pqPcCAyHlyS+73h3XeyeUyg5O6CjzDm1NwGP6nQ6AlKH0HKEk6qBstEcBU7okLasn3Hj2nlYnMgXEFculaXzKVe1QXFrJfgzMf2foqS7sxETW1O0gbx9A297UBNjx2piomVtlVKtHiUHcgnE4cOqKOjZtAmcoCJw+RYzi+zyRGA6qH8QtNLaN4xJJo2XuOp2xRwnzW2IRGyzgR1oaE/5hxqClN3mytd4bOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugKDlAtL23p1Qv+9KdqWjjeq1MbTHuLjeVYDVJVrFKo=;
 b=bq01OoJL2ADbntzxIplfouqn+t9pb1KiaZ9sx9Ts9l3irM2e2ycZB9Uqatt4owUDEyVjLRY4gQXGWqGfwjq5KUMo5xgABxOo98E5IrMmBun6sCAGblqICbGWpWe0BlWHkNaiubh5+rkcpaIv+/9/GmZxEbrLlS34WcDhYWdkbT5rYJdG7/8ypwZMSZgOMiH/Zf9B6dh4RhT0IzIeRhG6d42NY7WPWAWj6MqxKzCLKgLDMw/qw+Oi/DLkZEXR72ZoQFc2+0qsG6+gVAqKVKIDWJNgqeA7s+NXwTan+vFKR3z+VE7izuFTjO0a7DGCSRwXmo52QN/wGrZ8rE/IMyd9BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugKDlAtL23p1Qv+9KdqWjjeq1MbTHuLjeVYDVJVrFKo=;
 b=A3WW+DVNp4/IT2t83EqotZmFy8ivESqLOcVVnCMoTi8I4pt3dI689s4npYrvMggKVz5YzdiKp1y0yBquAnJrAy0QKwTrH0TD8NIFpsXNb1RAH4z6CMfRN/KXeOJZwnrFZzU4n/HlHJNVO7DR5RCoZbl3PvYV8kb1Y7bUMmTncYg=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6723.namprd04.prod.outlook.com (2603:10b6:a03:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Thu, 23 Apr
 2020 07:43:03 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:43:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] udf: stop using ioctl_by_bdev
Thread-Topic: [PATCH 7/7] udf: stop using ioctl_by_bdev
Thread-Index: AQHWGT8E+au4mBM55E6ziMxUj9P3kw==
Date:   Thu, 23 Apr 2020 07:43:03 +0000
Message-ID: <BY5PR04MB6900BB48751678C5F736F7D2E7D30@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-8-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e94bc12-013a-40c6-501b-08d7e759f499
x-ms-traffictypediagnostic: BY5PR04MB6723:
x-microsoft-antispam-prvs: <BY5PR04MB6723EC17738ECC2DF3970D1BE7D30@BY5PR04MB6723.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(7416002)(4326008)(33656002)(2906002)(5660300002)(86362001)(7696005)(64756008)(66556008)(316002)(66476007)(66446008)(52536014)(66946007)(186003)(478600001)(76116006)(6506007)(54906003)(55016002)(110136005)(53546011)(26005)(81156014)(71200400001)(9686003)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5MnX+E0YfTHYIE0V0QmgBKk0CnZ15LVaEgANB76SgMf4ircViSy3AggLwdFo6QfqwGDa24PruD/nQhPW2AW7uMIUg7/x97FfASQGGoxfVgyKLACTGB5JLLwyvZ0tIkWF/roK+k2iMrrL9KsAOc4TeYk4kLQiU3Evg+sYTxOM7P8Xzuqp1Xosb+T0GZAm6mAeLzVSV1i1XtZGHofYsSaRFoJTtALkAzN9zlx7AfjLimMmKoIy6X0F9jw5pbPviautLm5XSpQGmRsYHFX84a5yZiNrTXXvwU3D4JM6Q7d3GO5fZnrb9eHL5qz9ymhc79WhYNuhtd79qYa8TKWqv3nfx7AAcbNBJWPAbnBMljIcZ1wsj98zzTFHwG/GH9EaN4Pq1woqxyvXgQwiXEbCzh5ER+nw8m4F0/f3khXevLXZJLcThsCLusJX2qmTtY5ZJFH
x-ms-exchange-antispam-messagedata: fTmdO5P9/iB7VzxeIKOswEkxssBBvRPm0ZGGx5lpI8fOTRK23uAZ+Zla9WS9nj4yXwZqQggceAJ1YwIBtzpiaxFjmU+0k5BTR8/z5mc5nuvsCZPagJgxOZfUXbHETCiNaS+Aw2r0gmUu8EbP1ClS/w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e94bc12-013a-40c6-501b-08d7e759f499
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:43:03.6106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tHbLjStLbji7QDFVj18uSE4YwlwruyDW0mKIV+Pc8Cy52DnbMoe3E/etOMQzrcbP8g3LZ8JxMmCJKWNCIhS/JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6723
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/23 16:15, Christoph Hellwig wrote:=0A=
> Instead just call the CD-ROM layer functionality directly.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  fs/udf/lowlevel.c | 29 +++++++++++++----------------=0A=
>  1 file changed, 13 insertions(+), 16 deletions(-)=0A=
> =0A=
> diff --git a/fs/udf/lowlevel.c b/fs/udf/lowlevel.c=0A=
> index 5c7ec121990d..f1094cdcd6cd 100644=0A=
> --- a/fs/udf/lowlevel.c=0A=
> +++ b/fs/udf/lowlevel.c=0A=
> @@ -27,41 +27,38 @@=0A=
>  =0A=
>  unsigned int udf_get_last_session(struct super_block *sb)=0A=
>  {=0A=
> +	struct cdrom_device_info *cdi =3D disk_to_cdi(sb->s_bdev->bd_disk);=0A=
>  	struct cdrom_multisession ms_info;=0A=
> -	unsigned int vol_desc_start;=0A=
> -	struct block_device *bdev =3D sb->s_bdev;=0A=
> -	int i;=0A=
>  =0A=
> -	vol_desc_start =3D 0;=0A=
> -	ms_info.addr_format =3D CDROM_LBA;=0A=
> -	i =3D ioctl_by_bdev(bdev, CDROMMULTISESSION, (unsigned long)&ms_info);=
=0A=
> +	if (!cdi) {=0A=
> +		udf_debug("CDROMMULTISESSION not supported.\n");=0A=
> +		return 0;=0A=
> +	}=0A=
>  =0A=
> -	if (i =3D=3D 0) {=0A=
> +	ms_info.addr_format =3D CDROM_LBA;=0A=
> +	if (cdrom_multisession(cdi, &ms_info) =3D=3D 0) {=0A=
>  		udf_debug("XA disk: %s, vol_desc_start=3D%d\n",=0A=
>  			  ms_info.xa_flag ? "yes" : "no", ms_info.addr.lba);=0A=
>  		if (ms_info.xa_flag) /* necessary for a valid ms_info.addr */=0A=
> -			vol_desc_start =3D ms_info.addr.lba;=0A=
> -	} else {=0A=
> -		udf_debug("CDROMMULTISESSION not supported: rc=3D%d\n", i);=0A=
> +			return ms_info.addr.lba;=0A=
>  	}=0A=
> -	return vol_desc_start;=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
>  unsigned long udf_get_last_block(struct super_block *sb)=0A=
>  {=0A=
>  	struct block_device *bdev =3D sb->s_bdev;=0A=
> +	struct cdrom_device_info *cdi =3D disk_to_cdi(bdev->bd_disk);=0A=
>  	unsigned long lblock =3D 0;=0A=
>  =0A=
>  	/*=0A=
> -	 * ioctl failed or returned obviously bogus value?=0A=
> +	 * The cdrom layer call failed or returned obviously bogus value?=0A=
>  	 * Try using the device size...=0A=
>  	 */=0A=
> -	if (ioctl_by_bdev(bdev, CDROM_LAST_WRITTEN, (unsigned long) &lblock) ||=
=0A=
> -	    lblock =3D=3D 0)=0A=
> +	if (!cdi || cdrom_get_last_written(cdi, &lblock) || lblock =3D=3D 0)=0A=
>  		lblock =3D i_size_read(bdev->bd_inode) >> sb->s_blocksize_bits;=0A=
>  =0A=
>  	if (lblock)=0A=
>  		return lblock - 1;=0A=
> -	else=0A=
> -		return 0;=0A=
> +	return 0;=0A=
>  }=0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
