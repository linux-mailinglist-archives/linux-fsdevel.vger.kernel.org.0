Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18C71A42B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 08:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgDJG4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Apr 2020 02:56:03 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58650 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJG4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586501764; x=1618037764;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7XUoxTu5M3YPj3FMNjbRzQVw1oJ68aRv4UtlIbEw6pY=;
  b=h/x0O9hOabaJ6P7gBtZPYMVuqAHa4J4Sc2Y/1wApf+GedVbEx+Nh8SD2
   rPWevWuG6GUPo1cCPNmSBrqmY/0adMTFDqUAd7EpBZh6P/qUoZpCdmSJm
   7fWm/88YP1a3KhQ8d0XFz1fbyYIvIFq8nOgIbEcuOLxiglpSqDTawjI/t
   GwPXmczolDQfi9Wzq4gR87gOEP7FoctotA2KNQD4tvLyd1qiEdjJgtjrF
   tUGlMYi2cqnMXt3zUoC1yg3Rl22cE0KdwKyXoyqhefKrJgX14IkoZ0w57
   n2n3TJD4di9EE7cv9Myk/EyvlAWWh4C1MtRLbGW1R2f9W1S3wAwM8grCY
   w==;
IronPort-SDR: HKN+2SPasYru/RBxKQuyAFmoBE4x8B52MI7TkutpBDkfxVQQGn+OsCfQQRuxNZzcUX5R67b++6
 ObVx2dRm3guvsER0hrk666SdaLw+Rj8/G6PsmGG8yqEOAAfjY4so1FcoQP7VN3AaB7dz7qjs2i
 FfYctzOvYMAbRLZx/Ehcd4/5GXfKPt3jMORhPtFR3RjHZKBMQk52mvgbTgi13W1Dl1AKuwoWQc
 930I/M0qa4+2p2aqdYDBnhGyKZ5tdNx6XbW5pA8xjO4j3I/it63uwmxCwUJ+h90+8O5v1gdPIE
 mCk=
X-IronPort-AV: E=Sophos;i="5.72,364,1580745600"; 
   d="scan'208";a="139355771"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 14:55:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WxulM4i31JhaN0SYpxL7o5vAO+VhQnE4X7VKvpJsqtsxuODviLzftd4Mq7dCcPuOXJH47nhTXzjXDw0oYmtHpDj685NRYWcRrassOPmFSPYQoY67l/jUyioTGW1bsmfsAQ6FEpawOMxZ3huk2SVlvkpsiqgo78AmEFu0sZebCCQer/siBBLUKG05Eg0AHZviSU0VwAEuL/pIdx3ujPpYYJsZs3YSmewBPCcWU3IDZtaqPlSL0GxH/l5LW+ea0mGqT4mDUEXf/WO33FyxnCKUqCS7OoGNi1k1vbRjrvhS/0ZGywmErNEyc5IgPcYEDrooKMHpVjwM5QktmqZZZBip+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UFqYTvuRh2Cp4z07KaqizSTW1AgczNfubxlSefeR2w=;
 b=SWrFLqgJZUUwDtPzWPAXpWjF0OrF98/8oxZNrEJjGXRk5ghi5ZkFPHX3WUJjfJW/BnW9iPJYd26BlyIQdLDuQ6bLS2RWpTdPU+agRpSxgBF/6QstnJTyN+m/3Sz3X/n9Z5BMTZvUafaQkus4d3j4xM0VbotzsmfXlYfEqFVya+hQTxIMk9IgJRXGGN3JNTiaRml8sSIgW3MnvwCRAIO2YNwdes4w87tXeV4LNIerkXA8Hm44NAE+SfQqJWcRNAXYzvSkdEXkTZbd9oNMlmqA6WEUnDiKrDONxQUzx/olGY6ajL/lhg//NFkWP2kNKaPypBfDSLwVpm+N9efL99YImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UFqYTvuRh2Cp4z07KaqizSTW1AgczNfubxlSefeR2w=;
 b=EVbHxKAY6z1eSHUJnyrWwsDT6rEonDUi+2SXdbjVmZO9wvkCXZBTyh4yZFOXtGPIbc9MY+ZFLs1qPf+u+7qqv0q9Zhfbk6+Ta+z7yMbgObuSuhPnpFJFHgx/uK72HOl1n4Rh7B0Q27toK+mNvergY87+KIE7BWVNM4rWW7Vb3og=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6963.namprd04.prod.outlook.com (2603:10b6:a03:228::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.19; Fri, 10 Apr
 2020 06:55:50 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%5]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 06:55:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 04/10] block: Modify revalidate zones
Thread-Topic: [PATCH v5 04/10] block: Modify revalidate zones
Thread-Index: AQHWDo9+dU9QlzdbjUScm/Oxc3MPOg==
Date:   Fri, 10 Apr 2020 06:55:50 +0000
Message-ID: <BY5PR04MB69007B6372470777101EB3C1E7DE0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-5-johannes.thumshirn@wdc.com>
 <20200410064037.GD4791@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39384ff5-749f-44bc-f05c-08d7dd1c34ac
x-ms-traffictypediagnostic: BY5PR04MB6963:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB696325363CDE95DA2830B0A0E7DE0@BY5PR04MB6963.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(186003)(2906002)(316002)(33656002)(6506007)(53546011)(26005)(7696005)(110136005)(54906003)(66946007)(76116006)(6636002)(66476007)(64756008)(66446008)(71200400001)(66556008)(52536014)(478600001)(5660300002)(4326008)(55016002)(9686003)(8936002)(8676002)(81156014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZUlDa4c4yR6ysP2s+p55gfqcn+QXHK8HKZMmFAz1FctDMzSDtxgzHNJBv7XOPzBxsGEQ0MoLrICSi9J1bG1fg/TDNvgG3Kk1j9H2EPFA0QBtbd6Q7uGuoe83gCC3NbUq9Rd2FflgVvwkDvQjbeDtetWeRnOcXLHbFmR+DEaT/AmMZzYxU8j6JFfc4pw+5oDrcq748uKxd0SxZ94/jicpjpnFSsibVSbE3Zf6IhiwX5t9nmG/uyRQOje+Mr6UB0lysr5/HZkjWAS3j4hHXUw9mPNWEoU+CS2TU94j02uLvS9/R082b3gIjZ0paULAPwU9uSFiOnrMWv4Iq1ToIqu2eGSPzeRIHJMT8k308oz1nTv/c9LpO2PIKHEkNgUMWtwFrja/3KIi2Eyb84EU5hMz3tQ9UDpXXeKO+XKHU0MkAB3Q3VzYE0x1oxtXkW60+UXq
x-ms-exchange-antispam-messagedata: PY5V67U2OfnXNgjN2hypT7vHIYjoxad5snQuVBtxn9K0CpO10/CiJII9HWqtR4xTwL2j0dAhcMwqt65A91XErEuP+WzEsL4H4Tnczz65y479NnHHa2bhbhe2ETViyAeRV+wPkFp32lZPBNZuT6z4hQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39384ff5-749f-44bc-f05c-08d7dd1c34ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 06:55:50.7949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ed0uu6cxVoEaXFggiqLHNyPz8mkRxqw9sZ+zMdEHpv7K6u8LX1Y1mvmgjorzkp+bKcT4sXwQ/L5faECIt7f8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6963
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/10 15:40, Christoph Hellwig wrote:=0A=
> On Fri, Apr 10, 2020 at 01:53:46AM +0900, Johannes Thumshirn wrote:=0A=
>> From: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>=0A=
>> Modify the interface of blk_revalidate_disk_zones() to add an optional=
=0A=
>> revalidation callback function that a driver can use to extend checks an=
d=0A=
>> processing done during zone revalidation. The callback, if defined, is=
=0A=
>> executed time after all zones are inspected and with the queue frozen.=
=0A=
>> blk_revalidate_disk_zones() is renamed as __blk_revalidate_disk_zones()=
=0A=
>> and blk_revalidate_disk_zones() implemented as an inline function callin=
g=0A=
>> __blk_revalidate_disk_zones() without no revalidation callback specified=
,=0A=
>> resulting in an unchanged behavior for all callers of=0A=
>> blk_revalidate_disk_zones().=0A=
> =0A=
> The data argument to __blk_revalidate_disk_zones and the cllback is now=
=0A=
> unused.  I also think we now merge __blk_revalidate_disk_zones and=0A=
> blk_revalidate_disk_zones instead of having two versions for a grand=0A=
> total of two callers.  Something like this on top of your whole branch:=
=0A=
=0A=
Yes, indeed. Even simpler. Will add this change to v6.=0A=
=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 6c37fec6859b..0e7763a590e5 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -437,23 +437,21 @@ static int blk_revalidate_zone_cb(struct blk_zone *=
zone, unsigned int idx,=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> - * __blk_revalidate_disk_zones - (re)allocate and initialize zone bitmap=
s=0A=
> + * blk_revalidate_disk_zones - (re)allocate and initialize zone bitmaps=
=0A=
>   * @disk:		Target disk=0A=
> - * @revalidate_cb:	LLD callback=0A=
> - * @revalidate_data:	LLD callback argument=0A=
> + * @update_driver_data:	Callback to update driver data on the frozen dis=
k=0A=
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
> - * If the @revalidate_cb callback function is not NULL, the callback wil=
l be=0A=
> - * executed with the device request queue frozen after all zones have be=
en=0A=
> + * If the @update_driver_data callback function is not NULL, the callbac=
k will=0A=
> + * be executed with the device request queue frozen after all zones have=
 been=0A=
>   * checked.=0A=
>   */=0A=
> -int __blk_revalidate_disk_zones(struct gendisk *disk,=0A=
> -				revalidate_zones_cb revalidate_cb,=0A=
> -				void *revalidate_data)=0A=
> +int blk_revalidate_disk_zones(struct gendisk *disk,=0A=
> +		void (*update_driver_data)(struct gendisk *disk))=0A=
>  {=0A=
>  	struct request_queue *q =3D disk->queue;=0A=
>  	struct blk_revalidate_zone_args args =3D {=0A=
> @@ -487,8 +485,8 @@ int __blk_revalidate_disk_zones(struct gendisk *disk,=
=0A=
>  		q->nr_zones =3D args.nr_zones;=0A=
>  		swap(q->seq_zones_wlock, args.seq_zones_wlock);=0A=
>  		swap(q->conv_zones_bitmap, args.conv_zones_bitmap);=0A=
> -		if (revalidate_cb)=0A=
> -			revalidate_cb(disk, revalidate_data);=0A=
> +		if (update_driver_data)=0A=
> +			update_driver_data(disk);=0A=
>  		ret =3D 0;=0A=
>  	} else {=0A=
>  		pr_warn("%s: failed to revalidate zones\n", disk->disk_name);=0A=
> @@ -500,4 +498,4 @@ int __blk_revalidate_disk_zones(struct gendisk *disk,=
=0A=
>  	kfree(args.conv_zones_bitmap);=0A=
>  	return ret;=0A=
>  }=0A=
> -EXPORT_SYMBOL_GPL(__blk_revalidate_disk_zones);=0A=
> +EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index b664be0bbb5e..f7beb72a321a 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -71,7 +71,7 @@ int null_register_zoned_dev(struct nullb *nullb)=0A=
>  	struct request_queue *q =3D nullb->q;=0A=
>  =0A=
>  	if (queue_is_mq(q)) {=0A=
> -		int ret =3D blk_revalidate_disk_zones(nullb->disk);=0A=
> +		int ret =3D blk_revalidate_disk_zones(nullb->disk, NULL);=0A=
>  =0A=
>  		if (ret)=0A=
>  			return ret;=0A=
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
> index 53cfe998a3f6..893d2e0da255 100644=0A=
> --- a/drivers/scsi/sd_zbc.c=0A=
> +++ b/drivers/scsi/sd_zbc.c=0A=
> @@ -656,7 +656,7 @@ static int sd_zbc_check_capacity(struct scsi_disk *sd=
kp, unsigned char *buf,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> -static void sd_zbc_revalidate_zones_cb(struct gendisk *disk, void *data)=
=0A=
> +static void sd_zbc_update_zone_data(struct gendisk *disk)=0A=
>  {=0A=
>  	struct scsi_disk *sdkp =3D scsi_disk(disk);=0A=
>  =0A=
> @@ -680,8 +680,7 @@ static int sd_zbc_revalidate_zones(struct scsi_disk *=
sdkp,=0A=
>  		goto unlock;=0A=
>  	}=0A=
>  =0A=
> -	ret =3D __blk_revalidate_disk_zones(sdkp->disk,=0A=
> -					sd_zbc_revalidate_zones_cb, NULL);=0A=
> +	ret =3D blk_revalidate_disk_zones(sdkp->disk, sd_zbc_update_zone_data);=
=0A=
>  	kvfree(sdkp->rev_wp_ofst);=0A=
>  	sdkp->rev_wp_ofst =3D NULL;=0A=
>  =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index a730cacda0f7..d970c36cb8d3 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -353,8 +353,6 @@ struct queue_limits {=0A=
>  typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,=
=0A=
>  			       void *data);=0A=
>  =0A=
> -typedef void (*revalidate_zones_cb)(struct gendisk *disk, void *data);=
=0A=
> -=0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
>  =0A=
>  #define BLK_ALL_ZONES  ((unsigned int)-1)=0A=
> @@ -364,14 +362,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);=
=0A=
>  extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,=
=0A=
>  			    sector_t sectors, sector_t nr_sectors,=0A=
>  			    gfp_t gfp_mask);=0A=
> -int __blk_revalidate_disk_zones(struct gendisk *disk,=0A=
> -				revalidate_zones_cb revalidate_cb,=0A=
> -				void *revalidate_data);=0A=
> -static inline int blk_revalidate_disk_zones(struct gendisk *disk)=0A=
> -{=0A=
> -	return __blk_revalidate_disk_zones(disk, NULL, NULL);=0A=
> -}=0A=
> -=0A=
> +int blk_revalidate_disk_zones(struct gendisk *disk,=0A=
> +		void (*update_driver_data)(struct gendisk *disk));=0A=
>  extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t =
mode,=0A=
>  				     unsigned int cmd, unsigned long arg);=0A=
>  extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mod=
e,=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
