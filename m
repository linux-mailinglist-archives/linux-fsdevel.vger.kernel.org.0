Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 502A01A3D61
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Apr 2020 02:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgDJAaw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 20:30:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:54898 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgDJAav (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:30:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586478652; x=1618014652;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p7v9U0SsukbefNwM+uuvsP0Z6kltoDOKapj9hh/wrcc=;
  b=hRgPYdhuelAf2wC1i5wTtiuiT4rGuD5Efz4qEHccHWu8lz1WWpM5bX70
   3SorrILwtws5u7QRZlcya4TKQCh69wtKtJYZL7+jpL4wXwIAC37hEtz9E
   roCYu9hqCA8ctxrSZ6Yk39yu1QnaSJ+ib2/CEgexpjAY5a23iTtn9m4WI
   U8HE0aKq1YLy9vsgSPEBcr4z5xxln00+z845e7Gl1Su62LFlBQE/iLsfC
   5n9SiVcv3xfnH8n9mX98WiZwD9mO/Lg8JWCOPslXcvPbszLEVlnKiWg28
   fmJpTFfas8+rcD3JoXaxSvZ0Dxlm93kX8f1N3OKlA4yAG/ZOA9XoeNhhF
   A==;
IronPort-SDR: ++MPOiYlXpfQGKzczjHvGtDkhcoZ+GLGyk6XtTzuUxVncrjMhCpQOBhc7Vl+NfJ5U7IEwbDJFc
 NukufxydY2dWSqmR0fOznf0g6uICb6edbsJ+F930MXcg6+mgxM4KsWqRs+SIigbwCiSDnCzitZ
 K6P+fa0kBF5ZSDJynkie3iHiWFdEw7h8jvPxM+Xnu49oQfcRgzuTKf4wNa10iqNCNrIJO8IiJl
 j3kGq9L/LlkwUoT420272HX2VYGsJEcmNIAs5cv2W2OuGtEDStWZe2ZH/XCGDJMLvFNfMDo+il
 rPk=
X-IronPort-AV: E=Sophos;i="5.72,364,1580745600"; 
   d="scan'208";a="139329308"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 08:30:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELq7N98q+xHUBwAd/Q51d0d9ayQnVhkwa7sgXidRHbnZnpoH+ruLlklgQyPJ//uoHKA5UTBamUbJHdVqdmKE/lhnsgQhVpGlCUuh7aHlj4Mx3rJLs5e91uLqMGYUGjkjwu35pFpXwSS8f3YjKgHylzOrOSiFtdKwKy7tX9gYim/XFY7H7x/ezZuZ8+fnM/Won/KRQA5fOTDmVIwsQ4cbyRacsXzg7cHAVtOM5ZyplJHpuqM7hogPDL77N+8C2jq90rNbm1Qj+gSGjN2xs6P8WQzMDTS3l7AdXbfRdPedX+wlvIqZDwEFwHQYB953iogNatL6PSV2j2HAK1qLjMiaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Jtt5Fu9wJXReZZiZfeCfAraAWehpeZ1epcwhYFJNA=;
 b=FMHHLdQ/kp5hJdBFYDobZ2XEZ22A6G6vkG3lE3xrw1qR5doCp81QD4rIwMnxabR9qL0EHYZf9B+OsXxs0WPmkTWDyriZBoOi6avzdABNYjhSe8QEMXnYoSrBo+t/mqwntf38KEifZLxJjjqd6faDUyttBdJBcG58FvLbzHPVKrQn4jHMAPDDBmnJurkLzsGgxBoiBPxGheriCtmtxBSorak5127sf9X/d/Wkdmel7g8KF3+328gos8P6k/7fJU28cNbl+OFymcEKB9C1A3nsmqBPBGuipQ2KBUCVk2bYYwQSHcqmE9aKJ8IOgegR7yHk1JQu6CBxDp9YKlTJc2zK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2Jtt5Fu9wJXReZZiZfeCfAraAWehpeZ1epcwhYFJNA=;
 b=Fdy1cyzfIKK80+MXIDZy5uSeS7Is+NNWyaOTOE9BhnBtr0gapANlh0d+6dUeaLGqwzbyNoWQ+vDSbxnKYgQbQ4udZ3YPrJK6CYqobDyEizgJUj6Qf9JgoeqVfJTYqrOauUcBAH7reH8Yu9vMb+LbaKbbX5jQyWSXIviScLXArqE=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7089.namprd04.prod.outlook.com (2603:10b6:a03:22f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 10 Apr
 2020 00:30:49 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%5]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 00:30:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWDo9/RWYxXXt5mUiQz7E3KbTAdg==
Date:   Fri, 10 Apr 2020 00:30:49 +0000
Message-ID: <BY5PR04MB69009F2779EF698E5E66095AE7DE0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eef979ed-cc72-46b4-d4ee-08d7dce66b4c
x-ms-traffictypediagnostic: BY5PR04MB7089:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7089044846704B502C411823E7DE0@BY5PR04MB7089.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(33656002)(6506007)(7696005)(52536014)(8676002)(81156014)(71200400001)(2906002)(316002)(76116006)(4326008)(53546011)(64756008)(66446008)(66476007)(66556008)(66946007)(86362001)(478600001)(9686003)(54906003)(110136005)(30864003)(26005)(5660300002)(8936002)(81166007)(186003)(55016002)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofdTXiHdZXSCfKdMwK3bPWLRqQiunfaY/45/f/sBSDh4Lkf1YfwUkSAftfjf5toUB7K/hYmZov3h13cLIH9NHHbUq4JJ4J9TbVn0J2pHp0YxNIKQuTaEr5soPKgdWF7qDaqIRAHcGAKyDa360JY1eoSm5gQ/WlBvyPYFC5odHc6mJmatXLVF8wMtAF6BGGGUQkfjvml34He4S0gd1Cv62TqPalcKZNGqnkxu0twpiQM+GglnZwfZ4k8nF/bzbFTt57PXZ76lPEBzf3WFElqgUqx7O91SUcaKZXgrLBjdzlFj4/cpqcPh7LXXZV97bLvwyYNqXFIfy90LubVBSJnF4QQ5XamawvlGHivvAEdrW23PZ4si3bTXN5SVMLMlgKnSm6OKw1bn4qZtVPKufUCfiiQ32g0jqsFzaV26XPRie31j0XxI9KOEWlXZt3+M9g2d
x-ms-exchange-antispam-messagedata: nRo7Yi6lh00fdxtjB+1/BeP0tHcCmIMJBzwpr8zDiQIpULIzO6et2u9dTdjkJdhtmOShJ4uqv2Y+/bUK1yBF5QX+SErnmKzOXf+yF1IAz7+U15gucgGbMLaZ6d3s3bjLop5ROwRzOJ63auKKNtRNCA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef979ed-cc72-46b4-d4ee-08d7dce66b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 00:30:49.4939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gDXrm0NFlU1+XzySlPbdcnW2z4ijLWZ2hu6YfzoTZ2KAlwtAYQp3U3g538OKL5qdlr95l6DWFUaTfaV15Zg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7089
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/04/10 1:54, Johannes Thumshirn wrote:=0A=
> Emulate ZONE_APPEND for SCSI disks using a regular WRITE(16) with a=0A=
> start LBA set to the target zone write pointer position.=0A=
> =0A=
> In order to always know the write pointer position of a sequential write=
=0A=
> zone, the queue flag QUEUE_FLAG_ZONE_WP_OFST is set to get an=0A=
=0A=
We dropped QUEUE_FLAG_ZONE_WP_OFST. The wp offset initialization uses=0A=
serialization of blk_revalidate_disk_zones() and the revalidate callback no=
w.=0A=
You need to update the commit message to reflect that change.=0A=
=0A=
> initialized write pointer offset array attached to the device request=0A=
> queue. The values of the cache are maintained in sync with the device=0A=
> as follows:=0A=
> 1) the write pointer offset of a zone is reset to 0 when a=0A=
>    REQ_OP_ZONE_RESET command completes.=0A=
> 2) the write pointer offset of a zone is set to the zone size when a=0A=
>    REQ_OP_ZONE_FINISH command completes.=0A=
> 3) the write pointer offset of a zone is incremented by the number of=0A=
>    512B sectors written when a write or a zone append command completes=
=0A=
> 4) the write pointer offset of all zones is reset to 0 when a=0A=
>    REQ_OP_ZONE_RESET_ALL command completes.=0A=
> =0A=
> Since the block layer does not write lock zones for zone append=0A=
> commands, to ensure a sequential ordering of the write commands used for=
=0A=
> the emulation, the target zone of a zone append command is locked when=0A=
> the function sd_zbc_prepare_zone_append() is called from=0A=
> sd_setup_read_write_cmnd(). If the zone write lock cannot be obtained=0A=
> (e.g. a zone append is in-flight or a regular write has already locked=0A=
> the zone), the zone append command dispatching is delayed by returning=0A=
> BLK_STS_ZONE_RESOURCE.=0A=
> =0A=
> To avoid the need for write locking all zones for REQ_OP_ZONE_RESET_ALL=
=0A=
> requests, use a spinlock to protect accesses and modifications of the zon=
e=0A=
> write pointer offsets. This spinlock is initialized from sd_probe() using=
=0A=
> the new function sd_zbc_init().=0A=
> =0A=
> Co-developed-by: Damien Le Moal <Damien.LeMoal@wdc.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> ---=0A=
> Changes to v4:=0A=
> - fix brace nit=0A=
> - fix write-locking rules=0A=
> - revalidate zone reworked=0A=
> ---=0A=
>  drivers/scsi/sd.c     |  26 +++-=0A=
>  drivers/scsi/sd.h     |  40 ++++-=0A=
>  drivers/scsi/sd_zbc.c | 344 ++++++++++++++++++++++++++++++++++++++++--=
=0A=
>  3 files changed, 391 insertions(+), 19 deletions(-)=0A=
> =0A=
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c=0A=
> index 2710a0e5ae6d..05a7abd4295d 100644=0A=
> --- a/drivers/scsi/sd.c=0A=
> +++ b/drivers/scsi/sd.c=0A=
> @@ -1206,6 +1206,14 @@ static blk_status_t sd_setup_read_write_cmnd(struc=
t scsi_cmnd *cmd)=0A=
>  		}=0A=
>  	}=0A=
>  =0A=
> +	if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
> +		ret =3D sd_zbc_prepare_zone_append(cmd, &lba, nr_blocks);=0A=
> +		if (ret) {=0A=
> +			scsi_free_sgtables(cmd);=0A=
> +			return ret;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
>  	fua =3D rq->cmd_flags & REQ_FUA ? 0x8 : 0;=0A=
>  	dix =3D scsi_prot_sg_count(cmd);=0A=
>  	dif =3D scsi_host_dif_capable(cmd->device->host, sdkp->protection_type)=
;=0A=
> @@ -1287,6 +1295,7 @@ static blk_status_t sd_init_command(struct scsi_cmn=
d *cmd)=0A=
>  		return sd_setup_flush_cmnd(cmd);=0A=
>  	case REQ_OP_READ:=0A=
>  	case REQ_OP_WRITE:=0A=
> +	case REQ_OP_ZONE_APPEND:=0A=
>  		return sd_setup_read_write_cmnd(cmd);=0A=
>  	case REQ_OP_ZONE_RESET:=0A=
>  		return sd_zbc_setup_zone_mgmt_cmnd(cmd, ZO_RESET_WRITE_POINTER,=0A=
> @@ -2055,7 +2064,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)=0A=
>  =0A=
>   out:=0A=
>  	if (sd_is_zoned(sdkp))=0A=
> -		sd_zbc_complete(SCpnt, good_bytes, &sshdr);=0A=
> +		good_bytes =3D sd_zbc_complete(SCpnt, good_bytes, &sshdr);=0A=
>  =0A=
>  	SCSI_LOG_HLCOMPLETE(1, scmd_printk(KERN_INFO, SCpnt,=0A=
>  					   "sd_done: completed %d of %d bytes\n",=0A=
> @@ -3371,6 +3380,10 @@ static int sd_probe(struct device *dev)=0A=
>  	sdkp->first_scan =3D 1;=0A=
>  	sdkp->max_medium_access_timeouts =3D SD_MAX_MEDIUM_TIMEOUTS;=0A=
>  =0A=
> +	error =3D sd_zbc_init_disk(sdkp);=0A=
> +	if (error)=0A=
> +		goto out_free_index;=0A=
> +=0A=
>  	sd_revalidate_disk(gd);=0A=
>  =0A=
>  	gd->flags =3D GENHD_FL_EXT_DEVT;=0A=
> @@ -3408,6 +3421,7 @@ static int sd_probe(struct device *dev)=0A=
>   out_put:=0A=
>  	put_disk(gd);=0A=
>   out_free:=0A=
> +	sd_zbc_release_disk(sdkp);=0A=
>  	kfree(sdkp);=0A=
>   out:=0A=
>  	scsi_autopm_put_device(sdp);=0A=
> @@ -3484,6 +3498,8 @@ static void scsi_disk_release(struct device *dev)=
=0A=
>  	put_disk(disk);=0A=
>  	put_device(&sdkp->device->sdev_gendev);=0A=
>  =0A=
> +	sd_zbc_release_disk(sdkp);=0A=
> +=0A=
>  	kfree(sdkp);=0A=
>  }=0A=
>  =0A=
> @@ -3664,19 +3680,19 @@ static int __init init_sd(void)=0A=
>  	if (!sd_page_pool) {=0A=
>  		printk(KERN_ERR "sd: can't init discard page pool\n");=0A=
>  		err =3D -ENOMEM;=0A=
> -		goto err_out_ppool;=0A=
> +		goto err_out_cdb_pool;=0A=
>  	}=0A=
>  =0A=
>  	err =3D scsi_register_driver(&sd_template.gendrv);=0A=
>  	if (err)=0A=
> -		goto err_out_driver;=0A=
> +		goto err_out_ppool;=0A=
>  =0A=
>  	return 0;=0A=
>  =0A=
> -err_out_driver:=0A=
> +err_out_ppool:=0A=
>  	mempool_destroy(sd_page_pool);=0A=
>  =0A=
> -err_out_ppool:=0A=
> +err_out_cdb_pool:=0A=
>  	mempool_destroy(sd_cdb_pool);=0A=
>  =0A=
>  err_out_cache:=0A=
> diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h=0A=
> index 50fff0bf8c8e..f7a4d6fcac6b 100644=0A=
> --- a/drivers/scsi/sd.h=0A=
> +++ b/drivers/scsi/sd.h=0A=
> @@ -79,6 +79,12 @@ struct scsi_disk {=0A=
>  	u32		zones_optimal_open;=0A=
>  	u32		zones_optimal_nonseq;=0A=
>  	u32		zones_max_open;=0A=
> +	u32		*zones_wp_ofst;=0A=
> +	spinlock_t	zones_wp_ofst_lock;=0A=
> +	u32		*rev_wp_ofst;=0A=
> +	struct mutex	rev_mutex;=0A=
> +	struct work_struct zone_wp_ofst_work;=0A=
> +	char		*zone_wp_update_buf;=0A=
>  #endif=0A=
>  	atomic_t	openers;=0A=
>  	sector_t	capacity;	/* size in logical blocks */=0A=
> @@ -207,17 +213,32 @@ static inline int sd_is_zoned(struct scsi_disk *sdk=
p)=0A=
>  =0A=
>  #ifdef CONFIG_BLK_DEV_ZONED=0A=
>  =0A=
> +int sd_zbc_init_disk(struct scsi_disk *sdkp);=0A=
> +void sd_zbc_release_disk(struct scsi_disk *sdkp);=0A=
>  extern int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buff=
er);=0A=
>  extern void sd_zbc_print_zones(struct scsi_disk *sdkp);=0A=
>  blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct scsi_cmnd *cmd,=0A=
>  					 unsigned char op, bool all);=0A=
> -extern void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_byt=
es,=0A=
> -			    struct scsi_sense_hdr *sshdr);=0A=
> +unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_by=
tes,=0A=
> +			     struct scsi_sense_hdr *sshdr);=0A=
>  int sd_zbc_report_zones(struct gendisk *disk, sector_t sector,=0A=
>  		unsigned int nr_zones, report_zones_cb cb, void *data);=0A=
>  =0A=
> +blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t =
*lba,=0A=
> +				        unsigned int nr_blocks);=0A=
> +=0A=
>  #else /* CONFIG_BLK_DEV_ZONED */=0A=
>  =0A=
> +static inline int sd_zbc_init(void)=0A=
> +{=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static inline void sd_zbc_exit(void) {}=0A=
> +=0A=
> +static inline void sd_zbc_init_disk(struct scsi_disk *sdkp) {}=0A=
> +static inline void sd_zbc_release_disk(struct scsi_disk *sdkp) {}=0A=
> +=0A=
>  static inline int sd_zbc_read_zones(struct scsi_disk *sdkp,=0A=
>  				    unsigned char *buf)=0A=
>  {=0A=
> @@ -233,9 +254,18 @@ static inline blk_status_t sd_zbc_setup_zone_mgmt_cm=
nd(struct scsi_cmnd *cmd,=0A=
>  	return BLK_STS_TARGET;=0A=
>  }=0A=
>  =0A=
> -static inline void sd_zbc_complete(struct scsi_cmnd *cmd,=0A=
> -				   unsigned int good_bytes,=0A=
> -				   struct scsi_sense_hdr *sshdr) {}=0A=
> +static inline unsigned int sd_zbc_complete(struct scsi_cmnd *cmd,=0A=
> +			unsigned int good_bytes, struct scsi_sense_hdr *sshdr)=0A=
> +{=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static inline blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *=
cmd,=0A=
> +						      sector_t *lba,=0A=
> +						      unsigned int nr_blocks)=0A=
> +{=0A=
> +	return BLK_STS_TARGET;=0A=
> +}=0A=
>  =0A=
>  #define sd_zbc_report_zones NULL=0A=
>  =0A=
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
> index ee156fbf3780..53cfe998a3f6 100644=0A=
> --- a/drivers/scsi/sd_zbc.c=0A=
> +++ b/drivers/scsi/sd_zbc.c=0A=
> @@ -11,6 +11,7 @@=0A=
>  #include <linux/blkdev.h>=0A=
>  #include <linux/vmalloc.h>=0A=
>  #include <linux/sched/mm.h>=0A=
> +#include <linux/mutex.h>=0A=
>  =0A=
>  #include <asm/unaligned.h>=0A=
>  =0A=
> @@ -19,11 +20,36 @@=0A=
>  =0A=
>  #include "sd.h"=0A=
>  =0A=
> +static unsigned int sd_zbc_get_zone_wp_ofst(struct blk_zone *zone)=0A=
> +{=0A=
> +	if (zone->type =3D=3D ZBC_ZONE_TYPE_CONV)=0A=
> +		return 0;=0A=
> +=0A=
> +	switch (zone->cond) {=0A=
> +	case BLK_ZONE_COND_IMP_OPEN:=0A=
> +	case BLK_ZONE_COND_EXP_OPEN:=0A=
> +	case BLK_ZONE_COND_CLOSED:=0A=
> +		return zone->wp - zone->start;=0A=
> +	case BLK_ZONE_COND_FULL:=0A=
> +		return zone->len;=0A=
> +	case BLK_ZONE_COND_EMPTY:=0A=
> +	case BLK_ZONE_COND_OFFLINE:=0A=
> +	case BLK_ZONE_COND_READONLY:=0A=
> +	default:=0A=
> +		/*=0A=
> +		 * Offline and read-only zones do not have a valid=0A=
> +		 * write pointer. Use 0 as for an empty zone.=0A=
> +		 */=0A=
> +		return 0;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,=0A=
>  			       unsigned int idx, report_zones_cb cb, void *data)=0A=
>  {=0A=
>  	struct scsi_device *sdp =3D sdkp->device;=0A=
>  	struct blk_zone zone =3D { 0 };=0A=
> +	int ret;=0A=
>  =0A=
>  	zone.type =3D buf[0] & 0x0f;=0A=
>  	zone.cond =3D (buf[1] >> 4) & 0xf;=0A=
> @@ -39,7 +65,14 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp,=
 u8 *buf,=0A=
>  	    zone.cond =3D=3D ZBC_ZONE_COND_FULL)=0A=
>  		zone.wp =3D zone.start + zone.len;=0A=
>  =0A=
> -	return cb(&zone, idx, data);=0A=
> +	ret =3D cb(&zone, idx, data);=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	if (sdkp->rev_wp_ofst)=0A=
> +		sdkp->rev_wp_ofst[idx] =3D sd_zbc_get_zone_wp_ofst(&zone);=0A=
> +=0A=
> +	return 0;=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> @@ -229,6 +262,134 @@ static blk_status_t sd_zbc_cmnd_checks(struct scsi_=
cmnd *cmd)=0A=
>  	return BLK_STS_OK;=0A=
>  }=0A=
>  =0A=
> +#define SD_ZBC_INVALID_WP_OFST	(~0u)=0A=
> +#define SD_ZBC_UPDATING_WP_OFST	(SD_ZBC_INVALID_WP_OFST - 1)=0A=
> +=0A=
> +static int sd_zbc_update_wp_ofst_cb(struct blk_zone *zone, unsigned int =
idx,=0A=
> +				    void *data)=0A=
> +{=0A=
> +	struct scsi_disk *sdkp =3D data;=0A=
> +=0A=
> +	lockdep_assert_held(&sdkp->zones_wp_ofst_lock);=0A=
> +=0A=
> +	sdkp->zones_wp_ofst[idx] =3D sd_zbc_get_zone_wp_ofst(zone);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static void sd_zbc_update_wp_ofst_workfn(struct work_struct *work)=0A=
> +{=0A=
> +	struct scsi_disk *sdkp;=0A=
> +	unsigned int zno;=0A=
> +	int ret;=0A=
> +=0A=
> +	sdkp =3D container_of(work, struct scsi_disk, zone_wp_ofst_work);=0A=
> +=0A=
> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +	for (zno =3D 0; zno < sdkp->nr_zones; zno++) {=0A=
> +		if (sdkp->zones_wp_ofst[zno] !=3D SD_ZBC_UPDATING_WP_OFST)=0A=
> +			continue;=0A=
> +=0A=
> +		spin_unlock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +		ret =3D sd_zbc_do_report_zones(sdkp, sdkp->zone_wp_update_buf,=0A=
> +					     SD_BUF_SIZE,=0A=
> +					     zno * sdkp->zone_blocks, true);=0A=
> +		spin_lock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +		if (!ret)=0A=
> +			sd_zbc_parse_report(sdkp, sdkp->zone_wp_update_buf + 64,=0A=
> +					    zno, sd_zbc_update_wp_ofst_cb,=0A=
> +					    sdkp);=0A=
> +	}=0A=
> +	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +=0A=
> +	scsi_device_put(sdkp->device);=0A=
> +}=0A=
> +=0A=
> +static blk_status_t sd_zbc_update_wp_ofst(struct scsi_disk *sdkp,=0A=
> +					  unsigned int zno)=0A=
> +{=0A=
> +	/*=0A=
> +	 * We are about to schedule work to update a zone write pointer offset,=
=0A=
> +	 * which will cause the zone append command to be requeued. So make=0A=
> +	 * sure that the scsi device does not go away while the work is=0A=
> +	 * being processed.=0A=
> +	 */=0A=
> +	if (scsi_device_get(sdkp->device))=0A=
> +		return BLK_STS_IOERR;=0A=
> +=0A=
> +	sdkp->zones_wp_ofst[zno] =3D SD_ZBC_UPDATING_WP_OFST;=0A=
> +=0A=
> +	schedule_work(&sdkp->zone_wp_ofst_work);=0A=
> +=0A=
> +	return BLK_STS_RESOURCE;=0A=
> +}=0A=
> +=0A=
> +/**=0A=
> + * sd_zbc_prepare_zone_append() - Prepare an emulated ZONE_APPEND comman=
d.=0A=
> + * @cmd: the command to setup=0A=
> + * @lba: the LBA to patch=0A=
> + * @nr_blocks: the number of LBAs to be written=0A=
> + *=0A=
> + * Called from sd_setup_read_write_cmnd() for REQ_OP_ZONE_APPEND.=0A=
> + * @sd_zbc_prepare_zone_append() handles the necessary zone wrote lockin=
g and=0A=
> + * patching of the lba for an emulated ZONE_APPEND command.=0A=
> + *=0A=
> + * In case the cached write pointer offset is %SD_ZBC_INVALID_WP_OFST it=
 will=0A=
> + * schedule a REPORT ZONES command and return BLK_STS_IOERR.=0A=
> + */=0A=
> +blk_status_t sd_zbc_prepare_zone_append(struct scsi_cmnd *cmd, sector_t =
*lba,=0A=
> +					unsigned int nr_blocks)=0A=
> +{=0A=
> +	struct request *rq =3D cmd->request;=0A=
> +	struct scsi_disk *sdkp =3D scsi_disk(rq->rq_disk);=0A=
> +	unsigned int wp_ofst, zno =3D blk_rq_zone_no(rq);=0A=
> +	blk_status_t ret;=0A=
> +=0A=
> +	ret =3D sd_zbc_cmnd_checks(cmd);=0A=
> +	if (ret !=3D BLK_STS_OK)=0A=
> +		return ret;=0A=
> +=0A=
> +	if (!blk_rq_zone_is_seq(rq))=0A=
> +		return BLK_STS_IOERR;=0A=
> +=0A=
> +	/* Unlock of the write lock will happen in sd_zbc_complete() */=0A=
> +	if (!blk_req_zone_write_trylock(rq))=0A=
> +		return BLK_STS_ZONE_RESOURCE;=0A=
> +=0A=
> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +=0A=
> +	wp_ofst =3D sdkp->zones_wp_ofst[zno];=0A=
> +	if (wp_ofst =3D=3D SD_ZBC_UPDATING_WP_OFST) {=0A=
> +		/* Write pointer offset update in progress: ask for a requeue */=0A=
> +		ret =3D BLK_STS_RESOURCE;=0A=
> +		goto err;=0A=
> +	}=0A=
> +=0A=
> +	if (wp_ofst =3D=3D SD_ZBC_INVALID_WP_OFST) {=0A=
> +		/* Invalid write pointer offset: trigger an update from disk */=0A=
> +		ret =3D sd_zbc_update_wp_ofst(sdkp, zno);=0A=
> +		goto err;=0A=
> +	}=0A=
> +=0A=
> +	wp_ofst =3D sectors_to_logical(sdkp->device, wp_ofst);=0A=
> +	if (wp_ofst + nr_blocks > sdkp->zone_blocks) {=0A=
> +		ret =3D BLK_STS_IOERR;=0A=
> +		goto err;=0A=
> +	}=0A=
> +=0A=
> +	/* Set the LBA for the write command used to emulate zone append */=0A=
> +	*lba +=3D wp_ofst;=0A=
> +=0A=
> +	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +=0A=
> +	return BLK_STS_OK;=0A=
> +=0A=
> +err:=0A=
> +	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +	blk_req_zone_write_unlock(rq);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * sd_zbc_setup_zone_mgmt_cmnd - Prepare a zone ZBC_OUT command. The ope=
rations=0A=
>   *			can be RESET WRITE POINTER, OPEN, CLOSE or FINISH.=0A=
> @@ -269,16 +430,104 @@ blk_status_t sd_zbc_setup_zone_mgmt_cmnd(struct sc=
si_cmnd *cmd,=0A=
>  	return BLK_STS_OK;=0A=
>  }=0A=
>  =0A=
> +static bool sd_zbc_need_zone_wp_update(struct request *rq)=0A=
> +{=0A=
> +	switch (req_op(rq)) {=0A=
> +	case REQ_OP_ZONE_APPEND:=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
> +	case REQ_OP_ZONE_RESET:=0A=
> +	case REQ_OP_ZONE_RESET_ALL:=0A=
> +		return true;=0A=
> +	case REQ_OP_WRITE:=0A=
> +	case REQ_OP_WRITE_ZEROES:=0A=
> +	case REQ_OP_WRITE_SAME:=0A=
> +		return blk_rq_zone_is_seq(rq);=0A=
> +	default:=0A=
> +		return false;=0A=
> +	}=0A=
> +}=0A=
> +=0A=
> +/**=0A=
> + * sd_zbc_zone_wp_update - Update cached zone write pointer upon cmd com=
pletion=0A=
> + * @cmd: Completed command=0A=
> + * @good_bytes: Command reply bytes=0A=
> + *=0A=
> + * Called from sd_zbc_complete() to handle the update of the cached zone=
 write=0A=
> + * pointer value in case an update is needed.=0A=
> + */=0A=
> +static unsigned int sd_zbc_zone_wp_update(struct scsi_cmnd *cmd,=0A=
> +					  unsigned int good_bytes)=0A=
> +{=0A=
> +	int result =3D cmd->result;=0A=
> +	struct request *rq =3D cmd->request;=0A=
> +	struct scsi_disk *sdkp =3D scsi_disk(rq->rq_disk);=0A=
> +	unsigned int zno =3D blk_rq_zone_no(rq);=0A=
> +	enum req_opf op =3D req_op(rq);=0A=
> +=0A=
> +	/*=0A=
> +	 * If we got an error for a command that needs updating the write=0A=
> +	 * pointer offset cache, we must mark the zone wp offset entry as=0A=
> +	 * invalid to force an update from disk the next time a zone append=0A=
> +	 * command is issued.=0A=
> +	 */=0A=
> +	spin_lock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +=0A=
> +	if (result && op !=3D REQ_OP_ZONE_RESET_ALL) {=0A=
> +		if (op =3D=3D REQ_OP_ZONE_APPEND) {=0A=
> +			/* Force complete completion (no retry) */=0A=
> +			good_bytes =3D 0;=0A=
> +			scsi_set_resid(cmd, blk_rq_bytes(rq));=0A=
> +		}=0A=
> +=0A=
> +		/*=0A=
> +		 * Force an update of the zone write pointer offset on=0A=
> +		 * the next zone append access.=0A=
> +		 */=0A=
> +		if (sdkp->zones_wp_ofst[zno] !=3D SD_ZBC_UPDATING_WP_OFST)=0A=
> +			sdkp->zones_wp_ofst[zno] =3D SD_ZBC_INVALID_WP_OFST;=0A=
> +		goto unlock_wp_ofst;=0A=
> +	}=0A=
> +=0A=
> +	switch (op) {=0A=
> +	case REQ_OP_ZONE_APPEND:=0A=
> +		rq->__sector +=3D sdkp->zones_wp_ofst[zno];=0A=
> +		/* fallthrough */=0A=
> +	case REQ_OP_WRITE_ZEROES:=0A=
> +	case REQ_OP_WRITE_SAME:=0A=
> +	case REQ_OP_WRITE:=0A=
> +		if (sdkp->zones_wp_ofst[zno] < sd_zbc_zone_sectors(sdkp))=0A=
> +			sdkp->zones_wp_ofst[zno] +=3D good_bytes >> SECTOR_SHIFT;=0A=
> +		break;=0A=
> +	case REQ_OP_ZONE_RESET:=0A=
> +		sdkp->zones_wp_ofst[zno] =3D 0;=0A=
> +		break;=0A=
> +	case REQ_OP_ZONE_FINISH:=0A=
> +		sdkp->zones_wp_ofst[zno] =3D sd_zbc_zone_sectors(sdkp);=0A=
> +		break;=0A=
> +	case REQ_OP_ZONE_RESET_ALL:=0A=
> +		memset(sdkp->zones_wp_ofst, 0,=0A=
> +		       sdkp->nr_zones * sizeof(unsigned int));=0A=
> +		break;=0A=
> +	default:=0A=
> +		break;=0A=
> +	}=0A=
> +=0A=
> +unlock_wp_ofst:=0A=
> +	spin_unlock_bh(&sdkp->zones_wp_ofst_lock);=0A=
> +=0A=
> +	return good_bytes;=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * sd_zbc_complete - ZBC command post processing.=0A=
>   * @cmd: Completed command=0A=
>   * @good_bytes: Command reply bytes=0A=
>   * @sshdr: command sense header=0A=
>   *=0A=
> - * Called from sd_done(). Process report zones reply and handle reset zo=
ne=0A=
> - * and write commands errors.=0A=
> + * Called from sd_done() to handle zone commands errors and updates to t=
he=0A=
> + * device queue zone write pointer offset cahce.=0A=
>   */=0A=
> -void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_bytes,=0A=
> +unsigned int sd_zbc_complete(struct scsi_cmnd *cmd, unsigned int good_by=
tes,=0A=
>  		     struct scsi_sense_hdr *sshdr)=0A=
>  {=0A=
>  	int result =3D cmd->result;=0A=
> @@ -294,7 +543,18 @@ void sd_zbc_complete(struct scsi_cmnd *cmd, unsigned=
 int good_bytes,=0A=
>  		 * so be quiet about the error.=0A=
>  		 */=0A=
>  		rq->rq_flags |=3D RQF_QUIET;=0A=
> +		goto unlock_zone;=0A=
>  	}=0A=
> +=0A=
> +	if (sd_zbc_need_zone_wp_update(rq))=0A=
> +		good_bytes =3D sd_zbc_zone_wp_update(cmd, good_bytes);=0A=
> +=0A=
> +=0A=
> +unlock_zone:=0A=
> +	if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND)=0A=
> +		blk_req_zone_write_unlock(rq);=0A=
> +=0A=
> +	return good_bytes;=0A=
>  }=0A=
>  =0A=
>  /**=0A=
> @@ -396,11 +656,48 @@ static int sd_zbc_check_capacity(struct scsi_disk *=
sdkp, unsigned char *buf,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static void sd_zbc_revalidate_zones_cb(struct gendisk *disk, void *data)=
=0A=
> +{=0A=
> +	struct scsi_disk *sdkp =3D scsi_disk(disk);=0A=
> +=0A=
> +	swap(sdkp->zones_wp_ofst, sdkp->rev_wp_ofst);=0A=
> +}=0A=
> +=0A=
> +static int sd_zbc_revalidate_zones(struct scsi_disk *sdkp,=0A=
> +				   unsigned int nr_zones)=0A=
> +{=0A=
> +	int ret;=0A=
> +=0A=
> +	/*=0A=
> +	 * Make sure revalidate zones are serialized to ensure exclusive=0A=
> +	 * updates of the temporary array sdkp->rev_wp_ofst.=0A=
> +	 */=0A=
> +	mutex_lock(&sdkp->rev_mutex);=0A=
> +=0A=
> +	sdkp->rev_wp_ofst =3D kvcalloc(nr_zones, sizeof(u32), GFP_NOIO);=0A=
> +	if (!sdkp->rev_wp_ofst) {=0A=
> +		ret =3D -ENOMEM;=0A=
> +		goto unlock;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D __blk_revalidate_disk_zones(sdkp->disk,=0A=
> +					sd_zbc_revalidate_zones_cb, NULL);=0A=
> +	kvfree(sdkp->rev_wp_ofst);=0A=
> +	sdkp->rev_wp_ofst =3D NULL;=0A=
> +=0A=
> +unlock:=0A=
> +	mutex_unlock(&sdkp->rev_mutex);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigned char *buf)=0A=
>  {=0A=
>  	struct gendisk *disk =3D sdkp->disk;=0A=
> +	struct request_queue *q =3D disk->queue;=0A=
>  	unsigned int nr_zones;=0A=
>  	u32 zone_blocks =3D 0;=0A=
> +	u32 max_append;=0A=
>  	int ret;=0A=
>  =0A=
>  	if (!sd_is_zoned(sdkp))=0A=
> @@ -420,10 +717,14 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsig=
ned char *buf)=0A=
>  	if (ret !=3D 0)=0A=
>  		goto err;=0A=
>  =0A=
> +	max_append =3D min_t(u32, logical_to_sectors(sdkp->device, zone_blocks)=
,=0A=
> +			   q->limits.max_segments << (PAGE_SHIFT - 9));=0A=
> +	max_append =3D min_t(u32, max_append, queue_max_hw_sectors(q));=0A=
> +=0A=
>  	/* The drive satisfies the kernel restrictions: set it up */=0A=
> -	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, sdkp->disk->queue);=0A=
> -	blk_queue_required_elevator_features(sdkp->disk->queue,=0A=
> -					     ELEVATOR_F_ZBD_SEQ_WRITE);=0A=
> +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);=0A=
> +	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);=0A=
> +	blk_queue_max_zone_append_sectors(q, max_append);=0A=
>  	nr_zones =3D round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks=
);=0A=
>  =0A=
>  	/* READ16/WRITE16 is mandatory for ZBC disks */=0A=
> @@ -443,8 +744,8 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, unsigne=
d char *buf)=0A=
>  =0A=
>  	if (sdkp->zone_blocks !=3D zone_blocks ||=0A=
>  	    sdkp->nr_zones !=3D nr_zones ||=0A=
> -	    disk->queue->nr_zones !=3D nr_zones) {=0A=
> -		ret =3D blk_revalidate_disk_zones(disk);=0A=
> +	    q->nr_zones !=3D nr_zones) {=0A=
> +		ret =3D sd_zbc_revalidate_zones(sdkp, nr_zones);=0A=
>  		if (ret !=3D 0)=0A=
>  			goto err;=0A=
>  		sdkp->zone_blocks =3D zone_blocks;=0A=
> @@ -475,3 +776,28 @@ void sd_zbc_print_zones(struct scsi_disk *sdkp)=0A=
>  			  sdkp->nr_zones,=0A=
>  			  sdkp->zone_blocks);=0A=
>  }=0A=
> +=0A=
> +int sd_zbc_init_disk(struct scsi_disk *sdkp)=0A=
> +{=0A=
> +	if (!sd_is_zoned(sdkp))=0A=
> +		return 0;=0A=
> +=0A=
> +	sdkp->zones_wp_ofst =3D NULL;=0A=
> +	spin_lock_init(&sdkp->zones_wp_ofst_lock);=0A=
> +	sdkp->rev_wp_ofst =3D NULL;=0A=
> +	mutex_init(&sdkp->rev_mutex);=0A=
> +	INIT_WORK(&sdkp->zone_wp_ofst_work, sd_zbc_update_wp_ofst_workfn);=0A=
> +	sdkp->zone_wp_update_buf =3D kzalloc(SD_BUF_SIZE, GFP_KERNEL);=0A=
> +	if (!sdkp->zone_wp_update_buf)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +void sd_zbc_release_disk(struct scsi_disk *sdkp)=0A=
> +{=0A=
> +	kvfree(sdkp->zones_wp_ofst);=0A=
> +	sdkp->zones_wp_ofst =3D NULL;=0A=
> +	kfree(sdkp->zone_wp_update_buf);=0A=
> +	sdkp->zone_wp_update_buf =3D NULL;=0A=
> +}=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
