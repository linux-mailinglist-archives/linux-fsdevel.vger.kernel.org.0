Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C81B55FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgDWHkp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 03:40:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:17571 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDWHko (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587627646; x=1619163646;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mgWuB4fBDGsA2likv923XFLGnnP1Q6R6R7fGb8barcg=;
  b=Uy4tl8Lm3PwAZOLccEUgX7go2s5HtTIUrr9qB5si/ERTPA2NgwOLpsjs
   9wR/frCJXBtFoZqPk4OWg+jsqt7y6/I+dxcGWPvU7nl5l7Iz6EmPK/HJG
   Vq5kcx7pO16twVNPp17MWrp/VBAHDeAMWSq/UbL7y5LV9aM7hhviEu/i6
   Y5GWD7+mu6YDVnCT6LPh5N2VYTus4wDKKFjXYX4TFtENGE6HIzOJiSrcQ
   6sZS30FA8TOBA7pdiQDd+4ae6iEtcC1//PaBqy8nme2h0w1wFX+85FVmO
   lxjxfzwSLv15aOCPE5E6Fl4p06qZGdIX/Xr7WJ0IbJd2E7IFPLLare8y4
   g==;
IronPort-SDR: Td0tyOxJrenx/KJDpwny+iaFB0WYCw7IRYk3dbHSo+Frs9PUnuxd3TFUZKccEE2Xh6D3XsrAEa
 23DayTwRNA/oShPu847Tz0E+sUdMwhAd3g48zF+i7R5nlWC7JXVrTGP/GhlCKDnB+gph22Qx3w
 dGnCoPO1TilLFVmxOGFlRvICUY64Cg67f2c8Y7xlGsyhM7W0G9t/ZBXyfl8VIIHSordiPYf9EB
 xda4LQcriL93234UeXEKN2Fuufuvc+SWchecjmSipZuIAtZhnfj6hvRhLICWZlWFSlKDc5OfVr
 HCA=
X-IronPort-AV: E=Sophos;i="5.73,306,1583164800"; 
   d="scan'208";a="238437107"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2020 15:40:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyWzH/ObQ1Fi0pWkA+zTGtDauCyfiuVnKRgjtZ61N/KIv8eyAAcB5c0yWOvlVMnRdc6WTOKNHq/H1IGHKf6Hsi/gDFesGPf4GrBRPTnjapf/JOnbVcOsvEQ3uXwoL85aWnqK47i6w9F6Cai0evCrtmd3j3KtWoDqiufvSBZNN8ODZHGEbi7f8/za1ZPX43EYZOE8OrfqxQ10DyRUavCNtMNSArlIbB38o9MU3HNPh8J8xXGialvY1Upr0B7Y0adCCzxUj27Afm3x0p95j0/1DHnQqfFXP2Uy6vcd6+dsd3Ir79gpnphTHgivQjvtGo67uXq0iF0jJJSvtHOOQNmNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnwQzZfmulIvY3OmSd6STvOhyxKBSRtfcKDYeumxkhw=;
 b=X1EHwQwqDcCmA2BHNMbJ40X9G+e2rCrAXwqDG4QSrE8M6ZJho9uWtY1ySz4Rt4XLhBf4iU0klKyQ3uYgLc0vtfmz4HtcFRwx7mDLmz38IxAaMHJqojoyTs73hEnPhfSYopcURkIKAAOAQLzxOPpVauvdsATRqFZMt8KaGdjavLwDCCAmCn+maRiVXoaWJjXxmz5R7OXeVt7UuR6wCvxFmx5yHGYIunaWFTEZiCdZ20xklhE7F/dEdpe4ob3d8woCRUHHUTge7hOJ10IVeGWEUydPgF+bQcGkix+EC8oC0ghOULlIOvSyjZhYJnnIXc/FCqNgXbA6BMK4Cv8aAaA9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnwQzZfmulIvY3OmSd6STvOhyxKBSRtfcKDYeumxkhw=;
 b=QL9HvR2WRj0VYRYMNQo23iYRqpTFWe1BLQSSpLln8EyNyLBA00AZrZ2YWuOXARhCFtq4xEHccyjgcRHZ+0VZRAr84At/H+9DyXWVmWGL2Ty2C9p+rVE331xSyrc7BIy+BlwkrGTAjpDwH+DVc3BUVTZuSAJMbPMuAYcbXZX0TH4=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7076.namprd04.prod.outlook.com (2603:10b6:a03:222::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Thu, 23 Apr
 2020 07:40:40 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 07:40:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tim Waugh <tim@cyberelk.net>, Borislav Petkov <bp@alien8.de>,
        Jan Kara <jack@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] block: add a cdrom_device_info pointer to struct
 gendisk
Thread-Topic: [PATCH 1/7] block: add a cdrom_device_info pointer to struct
 gendisk
Thread-Index: AQHWGT77nWKFLvac9USA8vZMcoH19A==
Date:   Thu, 23 Apr 2020 07:40:40 +0000
Message-ID: <BY5PR04MB6900D254672137CF0FA07136E7D30@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200423071224.500849-1-hch@lst.de>
 <20200423071224.500849-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43fa2caf-1c44-4f0f-4a07-08d7e7599f1e
x-ms-traffictypediagnostic: BY5PR04MB7076:
x-microsoft-antispam-prvs: <BY5PR04MB7076C046D249D0DA74132C75E7D30@BY5PR04MB7076.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(52536014)(8936002)(66476007)(33656002)(7416002)(5660300002)(81156014)(86362001)(316002)(64756008)(66556008)(186003)(66446008)(8676002)(110136005)(66946007)(26005)(4326008)(76116006)(9686003)(54906003)(6506007)(55016002)(53546011)(2906002)(7696005)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YjeJQy5mID92foA6wR9g7sAKhUQDUBTwYzSRtVRT9fiGl5mXOpb4lAgLqVQHhPUiIBYwYoCCaI4lF6W7VdTJQzyA8NH4A/BFQW2DbIE1X2gBVkmvmLT1VQuvF0moT/1vvodYVY0DDX7jkWygFkt+FizVU/psSpJvXgtHgJ0bJVRs/FfcyRXFPkZFlZnlX4L9MYMj/6zmIb+HkYl1fDLwgEXboLeMxQOPBKF2Aj4sm/mteiNow9TfegP+fN6dS2t9gk0o2TwBya3UdxNL7zcHd0hyDg6fCpXPfWVuuV4cAbQ5wfEMghxB9LpjS5KoW68TvsgeKT8xiHeqsgG0TdVrazZEwJo/eyaDhX0ApMQZM8AqgmJAFJDs+NSbMSsJUzPf3fh0hcXksQx9MpAjd+i8aeTqydpvm+3dL56WGdXanVlNNZAsLOorEMsZusDASKy+
x-ms-exchange-antispam-messagedata: AFfODAB3WE3fWA/regQGMSe1O79cMOZ+piDyPS9/82lpCPbapSQGKeqP5t9HnktegIKb+i4Ez89MyqqEBXErLkZ+MsCNdvc3Ytm0z9zbrXRnVoTWoGkgb6eO5I8ia7WON+OpSd5MlNiPA0cEHLM+Sg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fa2caf-1c44-4f0f-4a07-08d7e7599f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 07:40:40.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwMr+2nppbqE0hQ3YPRsm5bG03A5NO9VNGDQNaBMtxJpsPf38ZBUeK8GAa5QqVDqJyuQiGduyC54ykRqgudafg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7076
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/23 16:15, Christoph Hellwig wrote:=0A=
> Add a pointer to the CDROM information structure to struct gendisk.=0A=
> This will allow various removable media file systems to call directly=0A=
> into the CDROM layer instead of abusing ioctls with kernel pointers.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  drivers/block/paride/pcd.c | 2 +-=0A=
>  drivers/cdrom/cdrom.c      | 5 ++++-=0A=
>  drivers/cdrom/gdrom.c      | 2 +-=0A=
>  drivers/ide/ide-cd.c       | 3 +--=0A=
>  drivers/scsi/sr.c          | 3 +--=0A=
>  include/linux/cdrom.h      | 2 +-=0A=
>  include/linux/genhd.h      | 9 +++++++++=0A=
>  7 files changed, 18 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c=0A=
> index cda5cf917e9a..5124eca90e83 100644=0A=
> --- a/drivers/block/paride/pcd.c=0A=
> +++ b/drivers/block/paride/pcd.c=0A=
> @@ -1032,7 +1032,7 @@ static int __init pcd_init(void)=0A=
>  =0A=
>  	for (unit =3D 0, cd =3D pcd; unit < PCD_UNITS; unit++, cd++) {=0A=
>  		if (cd->present) {=0A=
> -			register_cdrom(&cd->info);=0A=
> +			register_cdrom(cd->disk, &cd->info);=0A=
>  			cd->disk->private_data =3D cd;=0A=
>  			add_disk(cd->disk);=0A=
>  		}=0A=
> diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c=0A=
> index faca0f346fff..a1d2112fd283 100644=0A=
> --- a/drivers/cdrom/cdrom.c=0A=
> +++ b/drivers/cdrom/cdrom.c=0A=
> @@ -586,7 +586,7 @@ static int cdrom_mrw_set_lba_space(struct cdrom_devic=
e_info *cdi, int space)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> -int register_cdrom(struct cdrom_device_info *cdi)=0A=
> +int register_cdrom(struct gendisk *disk, struct cdrom_device_info *cdi)=
=0A=
>  {=0A=
>  	static char banner_printed;=0A=
>  	const struct cdrom_device_ops *cdo =3D cdi->ops;=0A=
> @@ -601,6 +601,9 @@ int register_cdrom(struct cdrom_device_info *cdi)=0A=
>  		cdrom_sysctl_register();=0A=
>  	}=0A=
>  =0A=
> +	cdi->disk =3D disk;=0A=
> +	disk->cdi =3D cdi;=0A=
> +=0A=
>  	ENSURE(cdo, drive_status, CDC_DRIVE_STATUS);=0A=
>  	if (cdo->check_events =3D=3D NULL && cdo->media_changed =3D=3D NULL)=0A=
>  		WARN_ON_ONCE(cdo->capability & (CDC_MEDIA_CHANGED | CDC_SELECT_DISC));=
=0A=
> diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c=0A=
> index c51292c2a131..09b0cd292720 100644=0A=
> --- a/drivers/cdrom/gdrom.c=0A=
> +++ b/drivers/cdrom/gdrom.c=0A=
> @@ -770,7 +770,7 @@ static int probe_gdrom(struct platform_device *devptr=
)=0A=
>  		goto probe_fail_no_disk;=0A=
>  	}=0A=
>  	probe_gdrom_setupdisk();=0A=
> -	if (register_cdrom(gd.cd_info)) {=0A=
> +	if (register_cdrom(gd.disk, gd.cd_info)) {=0A=
>  		err =3D -ENODEV;=0A=
>  		goto probe_fail_cdrom_register;=0A=
>  	}=0A=
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c=0A=
> index dcf8b51b47fd..40e124eb918a 100644=0A=
> --- a/drivers/ide/ide-cd.c=0A=
> +++ b/drivers/ide/ide-cd.c=0A=
> @@ -1305,8 +1305,7 @@ static int ide_cdrom_register(ide_drive_t *drive, i=
nt nslots)=0A=
>  	if (drive->atapi_flags & IDE_AFLAG_NO_SPEED_SELECT)=0A=
>  		devinfo->mask |=3D CDC_SELECT_SPEED;=0A=
>  =0A=
> -	devinfo->disk =3D info->disk;=0A=
> -	return register_cdrom(devinfo);=0A=
> +	return register_cdrom(info->disk, devinfo);=0A=
>  }=0A=
>  =0A=
>  static int ide_cdrom_probe_capabilities(ide_drive_t *drive)=0A=
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c=0A=
> index d2fe3fa470f9..f9b589d60a46 100644=0A=
> --- a/drivers/scsi/sr.c=0A=
> +++ b/drivers/scsi/sr.c=0A=
> @@ -794,9 +794,8 @@ static int sr_probe(struct device *dev)=0A=
>  	set_capacity(disk, cd->capacity);=0A=
>  	disk->private_data =3D &cd->driver;=0A=
>  	disk->queue =3D sdev->request_queue;=0A=
> -	cd->cdi.disk =3D disk;=0A=
>  =0A=
> -	if (register_cdrom(&cd->cdi))=0A=
> +	if (register_cdrom(disk, &cd->cdi))=0A=
>  		goto fail_put;=0A=
>  =0A=
>  	/*=0A=
> diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h=0A=
> index 528271c60018..4f74ce050253 100644=0A=
> --- a/include/linux/cdrom.h=0A=
> +++ b/include/linux/cdrom.h=0A=
> @@ -104,7 +104,7 @@ extern unsigned int cdrom_check_events(struct cdrom_d=
evice_info *cdi,=0A=
>  				       unsigned int clearing);=0A=
>  extern int cdrom_media_changed(struct cdrom_device_info *);=0A=
>  =0A=
> -extern int register_cdrom(struct cdrom_device_info *cdi);=0A=
> +extern int register_cdrom(struct gendisk *disk, struct cdrom_device_info=
 *cdi);=0A=
>  extern void unregister_cdrom(struct cdrom_device_info *cdi);=0A=
>  =0A=
>  typedef struct {=0A=
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h=0A=
> index 058d895544c7..f9c226f9546a 100644=0A=
> --- a/include/linux/genhd.h=0A=
> +++ b/include/linux/genhd.h=0A=
> @@ -217,11 +217,20 @@ struct gendisk {=0A=
>  #ifdef  CONFIG_BLK_DEV_INTEGRITY=0A=
>  	struct kobject integrity_kobj;=0A=
>  #endif	/* CONFIG_BLK_DEV_INTEGRITY */=0A=
> +#if IS_ENABLED(CONFIG_CDROM)=0A=
> +	struct cdrom_device_info *cdi;=0A=
> +#endif=0A=
>  	int node_id;=0A=
>  	struct badblocks *bb;=0A=
>  	struct lockdep_map lockdep_map;=0A=
>  };=0A=
>  =0A=
> +#if IS_REACHABLE(CONFIG_CDROM)=0A=
> +#define disk_to_cdi(disk)	((disk)->cdi)=0A=
> +#else=0A=
> +#define disk_to_cdi(disk)	NULL=0A=
> +#endif=0A=
> +=0A=
>  static inline struct gendisk *part_to_disk(struct hd_struct *part)=0A=
>  {=0A=
>  	if (likely(part)) {=0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
