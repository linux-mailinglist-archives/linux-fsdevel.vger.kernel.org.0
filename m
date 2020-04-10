Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 441B01A3D54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 02:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgDJA2A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 20:28:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54649 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgDJA2A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586478479; x=1618014479;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=uKvi/WenSV/yvb2WYILm68Y3DXjD60nDaY5sOGKBpCA=;
  b=GD9I/PGPtT34b/tzkIZ4M/azeLVI1Pe9DpDaMA8yJnCWRoE3oiSi+g1L
   EWSaJPzd9I3NxMYkFQ2s+3lqCoJRkm3IjKwVH2XcUaTUfBhjS3DGfH8gC
   R82VUPj5YZc+IWZh/QldgUacarvO29TD4EDfWKjXxmgCAFgmXTYosCH/Q
   SmNEL0yfjcOqhmczVSHUZ1fI2/N8Wyn73J2pzPV1HcmeFUCcAQ0V6Yzb1
   Ki58Fgg9oaEGX7i+srtFaD6ejKvWkXWzjtu+844dRM7ojr6ERecNeFiIF
   D64FNHwD2kxhy7LZyjE3Lwsqx4mSo6AkASIkvav/rIqn4Tgg1H+jTtRLG
   w==;
IronPort-SDR: MDCfrOG7RvRVlwzpL0QV+ZVBZGsb5OIEmkJ14j6XMSEb4u5VVgzeC7Pt/qAO/CFoKnP+5XANAZ
 6C+C3tptCjqzQaUQqukMfQ3XiCkG8fJQGIZYI5uhEDdsmtkFcDf90JkMOWwQfpUY4vTBOaEadn
 wMfXDRQIkJtZ6nPcbHiI/h4nhn9ULRnyqHdMjNDdNLkWTVCidfr7ij1noEhX1olKrW3Yhz/Zvt
 v5Swzvf64rJ/5B4x7ZfgPTr2gLObtBHfXrB6/syp+KN0lDIWtxskzRbFgS3c9zawsBk2NIwOXM
 JJc=
X-IronPort-AV: E=Sophos;i="5.72,364,1580745600"; 
   d="scan'208";a="139329198"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 08:27:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWNUrcdQzKP0jGP+HB+vcGFQ366XceJgmMb3LjoLI5y7oq1Yyp5BR1+FRp6rho7YYfdPPwUrWzUXPiw2NZd/nJXmp0APMX5g1Rwksk8qZZXJ2/nkjdAfSRtoYmL6pOX52scgSdDlIHaU42DzoexsggVPU9s5FshD8fQ4pU+yvOtJiutV3E+T2s7VcFggUKx/8xh8jEPw8IFoRKTGeNqLxnvXBpbaYnIT5uFtHEQgFjntKku+46RO1JpaptgnwMPMklAN1xuIXc6h5HzrWDxxCnc16fa4maasddmtjfcSwFw6vjF2zkTuEav/MRu97tMGv6cD1tML+fsGWPHsIrOpRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WsdCL1Mx7J0oHC/QVNpLVFEA6rRhYS9tDI4zWFswSQ=;
 b=ln1yGjhb3dnK0VrbVthOVEAlE3DkTSOYhJKhZ1LpOWqqwL2jRQAERO8zpR4mRelhUOrirSNCz2sljPBUOPPoaWHR/vbhIzupH7UXhLtsuLms7SqLvIAnz6dcNG6lhTMGDJRMl0glmQV37J5VMdXy0WaIJrIBA3/RDFblpnkiiPWgjxPwBpMiMrwYF6NuHKCq82YIW86bWYDbtx/sTcIwLkYMrGGBx8WtF2dZovpR1cvjQ/gbGigEyvUuifoJ4Lzq7EWwoW/slOxif3AvP03XkMnO/Kh314z1znGoJKLdqHsBu/O9L+3rmZk8uEl4lQt/MDltavKv4LW2R2DL1rjEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WsdCL1Mx7J0oHC/QVNpLVFEA6rRhYS9tDI4zWFswSQ=;
 b=YmAZ+wHqBUk7qfx/2GMsYD5udjdOHIJU6U/kPuBfYORgxV5VdiSkQdGpEpo3McQpw/Pqmzrj9wxr9UewtsK+U531BQ0yGtuCvBotfeSxNxH4PoFmKwqeFSHD3g4Tcp737nvv77S1ro5+s5qlZrRb3MwOGXX47jB5X1ApoGFJOhc=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7089.namprd04.prod.outlook.com (2603:10b6:a03:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 10 Apr
 2020 00:27:57 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%5]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 00:27:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 04/10] block: Modify revalidate zones
Thread-Topic: [PATCH v5 04/10] block: Modify revalidate zones
Thread-Index: AQHWDo9+dU9QlzdbjUScm/Oxc3MPOg==
Date:   Fri, 10 Apr 2020 00:27:57 +0000
Message-ID: <BY5PR04MB690032EB738B8C7DB3D95D40E7DE0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-5-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09ee518a-8ac9-435c-5257-08d7dce604a7
x-ms-traffictypediagnostic: BY5PR04MB7089:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7089805BAC8A87A97BADC16FE7DE0@BY5PR04MB7089.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(33656002)(6506007)(7696005)(52536014)(8676002)(81156014)(71200400001)(2906002)(316002)(76116006)(4326008)(53546011)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(478600001)(9686003)(54906003)(110136005)(26005)(5660300002)(8936002)(81166007)(186003)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H55D/NeisKYEf+n2HdkwwaShn2r0XR7K1KHKe9Y+4NZb7MXKqf+JsdbhKOvUMBt4MTzMGnz8dqBhUyAYw+RVdBgJtcZA2BNSc5oAJpN5YnT/lKnERG54b/gX+bIQsgAWgaGL87D8S/wizBrOLKTsWSdWPLkDOBxbTbPlO00qO8QwEz9F/cmClt9aOoWikkS9aN73vAD3DDpcQlcFxpn3wkQ5orRt2kv6TJSFbjH64zx+JYl18KTZBEzhJK9OSgk/2oksB4U+9cT1zaDb8/x1Bn5akaB6sbhO74MjZ080SlNYsv7pzZBmFgdsMepibyT1lKEiwPMf17ErEwZq4UTw41l7xcw1mMc6o9gEErO645Z+13xZ56ih5N0lAavvtBRk5yB054J42N5O7nmSEXHP2WTe8IGYaD6cFTbveugY+O8/MnEkYIMfk1Qu9h7JWa4V
x-ms-exchange-antispam-messagedata: 6mo2OdGjU+f1sUeiRLfWZ6FIZ0mm8HRY0nXegqJWX+V3vF4k0RXLzRypF4aUjmGRFltiAa1nqLAbp62gc8bxUh91walf3XcW2su5N9HitbnBwY02VDPpPp7gSY0Lk32eTDtHK9D2E1Gw3nC+d5Vj3w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ee518a-8ac9-435c-5257-08d7dce604a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 00:27:57.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F8gwTMiWNiKFUTDCIZ77t6I2xkCyFyiXzZMYVHBtWkdyRuEPhJu07x3nPp0dUZFwAmt+MUdXoQkOZ5YIEuC6FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7089
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/10 1:54, Johannes Thumshirn wrote:=0A=
> From: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> =0A=
> Modify the interface of blk_revalidate_disk_zones() to add an optional=0A=
> revalidation callback function that a driver can use to extend checks and=
=0A=
> processing done during zone revalidation. The callback, if defined, is=0A=
> executed time after all zones are inspected and with the queue frozen.=0A=
> blk_revalidate_disk_zones() is renamed as __blk_revalidate_disk_zones()=
=0A=
> and blk_revalidate_disk_zones() implemented as an inline function calling=
=0A=
> __blk_revalidate_disk_zones() without no revalidation callback specified,=
=0A=
> resulting in an unchanged behavior for all callers of=0A=
> blk_revalidate_disk_zones().=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  block/blk-zoned.c      | 19 ++++++++++++++-----=0A=
>  include/linux/blkdev.h | 10 +++++++++-=0A=
>  2 files changed, 23 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 00b025b8b7c0..6c37fec6859b 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -437,20 +437,27 @@ static int blk_revalidate_zone_cb(struct blk_zone *=
zone, unsigned int idx,=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> - * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps=
=0A=
> - * @disk:	Target disk=0A=
> + * __blk_revalidate_disk_zones - (re)allocate and initialize zone bitmap=
s=0A=
> + * @disk:		Target disk=0A=
> + * @revalidate_cb:	LLD callback=0A=
> + * @revalidate_data:	LLD callback argument=0A=
>   *=0A=
>   * Helper function for low-level device drivers to (re) allocate and ini=
tialize=0A=
>   * a disk request queue zone bitmaps. This functions should normally be =
called=0A=
>   * within the disk ->revalidate method for blk-mq based drivers.  For BI=
O based=0A=
>   * drivers only q->nr_zones needs to be updated so that the sysfs expose=
d value=0A=
>   * is correct.=0A=
> + * If the @revalidate_cb callback function is not NULL, the callback wil=
l be=0A=
> + * executed with the device request queue frozen after all zones have be=
en=0A=
> + * checked.=0A=
>   */=0A=
> -int blk_revalidate_disk_zones(struct gendisk *disk)=0A=
> +int __blk_revalidate_disk_zones(struct gendisk *disk,=0A=
> +				revalidate_zones_cb revalidate_cb,=0A=
> +				void *revalidate_data)=0A=
>  {=0A=
>  	struct request_queue *q =3D disk->queue;=0A=
>  	struct blk_revalidate_zone_args args =3D {=0A=
> -		.disk		=3D disk,=0A=
> +		.disk			=3D disk,=0A=
=0A=
Ooops... whitespace change here.=0A=
=0A=
=0A=
>  	};=0A=
>  	unsigned int noio_flag;=0A=
>  	int ret;=0A=
> @@ -480,6 +487,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk)=
=0A=
>  		q->nr_zones =3D args.nr_zones;=0A=
>  		swap(q->seq_zones_wlock, args.seq_zones_wlock);=0A=
>  		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);=0A=
> +		if (revalidate_cb)=0A=
> +			revalidate_cb(disk, revalidate_data);=0A=
>  		ret =3D 0;=0A=
>  	} else {=0A=
>  		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);=0A=
> @@ -491,4 +500,4 @@ int blk_revalidate_disk_zones(struct gendisk *disk)=
=0A=
>  	kfree(args.conv_zones_bitmap);=0A=
>  	return ret;=0A=
>  }=0A=
> -EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);=0A=
> +EXPORT_SYMBOL_GPL(__blk_revalidate_disk_zones);=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index e591b22ace03..a730cacda0f7 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -353,6 +353,8 @@ struct queue_limits {=0A=
>  typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,=
=0A=
>  			       void *data);=0A=
>  =0A=
> +typedef void (*revalidate_zones_cb)(struct gendisk *disk, void *data);=
=0A=
> +=0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
>  =0A=
>  #define BLK_ALL_ZONES  ((unsigned int)-1)=0A=
> @@ -362,7 +364,13 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);=
=0A=
>  extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,=
=0A=
>  			    sector_t sectors, sector_t nr_sectors,=0A=
>  			    gfp_t gfp_mask);=0A=
> -extern int blk_revalidate_disk_zones(struct gendisk *disk);=0A=
> +int __blk_revalidate_disk_zones(struct gendisk *disk,=0A=
> +				revalidate_zones_cb revalidate_cb,=0A=
> +				void *revalidate_data);=0A=
> +static inline int blk_revalidate_disk_zones(struct gendisk *disk)=0A=
> +{=0A=
> +	return __blk_revalidate_disk_zones(disk, NULL, NULL);=0A=
> +}=0A=
>  =0A=
>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t =
mode,=0A=
>  				     unsigned int cmd, unsigned long arg);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
