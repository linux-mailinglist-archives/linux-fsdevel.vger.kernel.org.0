Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5030D2854F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 01:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgJFXdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 19:33:14 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:43951 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJFXdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602027193; x=1633563193;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XRdIH1zptBaj3cDjLh8WeIeWnEGOSdg1LrPO88PRJrM=;
  b=Zs+XkBAFwCIO/8HXJH35weACypAADbGHm5MITVEdL+s0p7ZvSvFxLz3D
   CAD+ACvzDoJMJbSRX9Mn6W6EB2iMJ6Z/6ueJEofP/0zYxreDxbQtEnkSR
   D3kVbVUgAWl140kzzuTUTE+UEaTPjKINt+HLtpClcc2Yen5sXtFxLpnRR
   K/SCzW9pDufUXVLAhJgJB4DGRIzXsq5T2fJILQi7bV7Ybg/vcMaK+WO3y
   4cTGDvxpXpzt1V7F87M7uXz5Ld4ycPS+HQWh1g8DsXR6vJbQPHpDzFgTJ
   TWGrxG2e8P1LIi7Hr2RGvwouXbtRCTrwvp4PPyxTC3CH0S60qvYmpe1TZ
   Q==;
IronPort-SDR: JNnGN2GloMZDA8bAzHxSINGJNI6O7wTuE+agMg0iqnRWn0QrkDTBu+6cR21Mwl4FISVjK6CWP5
 1TlQ/WASmYZfLgs9ky0JsvVGu69DmXKVJgEhYvdLgwX/md9AZZpaDkFK1emo0YHD+jA7c+ffNA
 x77/zON88RSxBRnG/fXn+BufCA7K4ITZC6swU4agaogjcK18wjQX3nNRezQ+7O/3FHSHVQBlIf
 xpNOVpwK1KF8LvOHjlnAOL3/HyJzb8o0P4auGJMtdTwhTrYuLpnNR1pryJbXMbdJI2NijY2otk
 ezU=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; 
   d="scan'208";a="259008609"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:33:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYi+KrO2YgBvMZPU4kORaDMZ2qieywvR3W4JTYGbwlmYH/0kz1JJVAQlbPd8AmtyZTyZACExBdMBUEtkF/vVap/EZuXlH7V891d8wdDsNRuMjJ0WtKg7I8gFD16q+WIP+DA0+Tp2aoYvcY+LBl7qAtmm5urwvImSGyJrs05k2XxDmL+6pg/Ampxbn59i0Dqxe1OIjur6k2eaXfufnGgXDnyJvyXFALR3XNS/GwprFr5+Lzrk6zmq1IebW6B+HoHcb+kALvHDnzWl79GEOfVUWCNztrXDL4yigvsiqm88RvGAIcm+KSdIqkayOFVK+brjg3Vpk4bct8X9wwcUvePIcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BRxg2R4/gVokAMwtplm4ACM3b7ilJpGGcCi7vur+Jk=;
 b=MHGjlb7G0Rs6I1aNNf3aFZXb2JqkpfMpL7NPCOQVi+mKIg9MO+zafsuS5bICCi2zIl/7GdmRSa/ne0ApyS8OTr+cYJlH7otZgBUSRTuGA+65A2r8jfHgqdOBW1sqSdaa7+MloSPtqOA5KwpikAnuNKStrjNOshWJls44hveW00sh/dwRuD/2xKMHahRrHO5B8mbCMY4OupZOI2+LUYCo7TWhoTUkF2F+o0h2PuEMkLGUxOAKNxcdDBY5PbqNghWe7TuFXVusImr1SHrrHsGvFpKRMkntvBmOc8oEf2pd4QnVTWfMeHe3Pw3hyrxP+ehK7BbtmtwivLix3vypM9sogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BRxg2R4/gVokAMwtplm4ACM3b7ilJpGGcCi7vur+Jk=;
 b=aJITqJkNyJcAuwDMMcJhkLyLAS3DPYZ+VVeqWVW73fiq0Q7SQe0krMl37FWswETsd/g1YXr1dm0vXNaABS7zIj5BGYDrzEcFxKA45KMrYzUJf9NnQmtQ8NidLWfAJO5MH6s1XBFeoICFhMJrxZ6EOLsqU6fAvPA4LrT1jfzEqME=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0726.namprd04.prod.outlook.com (2603:10b6:903:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Tue, 6 Oct
 2020 23:33:11 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 23:33:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] block: make maximum zone append size configurable
Thread-Topic: [PATCH] block: make maximum zone append size configurable
Thread-Index: AQHWm+sZVX11KkT2FEibKlALVuOHjQ==
Date:   Tue, 6 Oct 2020 23:33:11 +0000
Message-ID: <CY4PR04MB375140F36014D95A7AA439A8E70D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <8fe2e364c4dac89e3ecd1234fab24a690d389038.1601993564.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1d8:5f02:9c5c:7c1f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e9ecdbf-2005-440b-840e-08d86a503063
x-ms-traffictypediagnostic: CY4PR04MB0726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0726674DE28FC5C37A936822E70D0@CY4PR04MB0726.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kth3ku3xElnF8iUuugABvBQegosmn0NxS1oqYJ8eSK+O+mqd6vkiwdykcvZZS7T+PnS0fTk3oecqUooE5NE+vkBAY+zSJ2bW1ksPNyIZM0p/XZE7iASYHHPTduNxuI9Mrf4Ah9vBrjP2+ktZVH84LIcxPey/IFlAiw96uirpzh6IW0xyw22qI3GlLnN/5rQCe/wFdhLJtVyLarLegtDGCIOnzygHFZbIYQDqWaW3mVwHGLdGqQVb9aUs51f4vVHfi3BNb+x7JLcfjN7reki7j4+Yb1VV6E35FftRqL+Q2oFCnlr98hnkyza4SLXg8gLdj8b0snrqPz47XM64DwPJLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(91956017)(33656002)(83380400001)(66446008)(64756008)(66556008)(66946007)(76116006)(66476007)(5660300002)(52536014)(6506007)(7696005)(53546011)(110136005)(54906003)(186003)(55016002)(8936002)(4326008)(9686003)(8676002)(498600001)(71200400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VFsReaTq527sbZ3BKpnv1kjG/ljzH43u/LOkbeZo1UdhHHB2MCdIJYVyh10bvWyzFjjnbybO0gyZDZhuQFDCfOsNwJtq6eCmBeOBDsokHdhn5OMOmdQOZgQLoZJ3t3Df7/SGZTqXxHcCUP9Sdy1bxImvAYwMOwuWHlBjClpw+5fKa6wOGevLSD3/fBI9nKdc70qykvApzwOHtfRBQgS+slQj6uvJDxfSERPcW/MTCDzHYoCIMythKQBhrn6xLMhNOO7QjE+acQ3o8kL4SBprf3nV3rrLzrolBFSvpl7w8jQJZIH6qMpe46T5xuwhwpSMQvAclKMqrqubsU/D235oOEsg79SS1rJsQYuPuNPvxCWB//uFmJ3e3jmNAdaZYuc/uTAvlR3X5vZNm0RoypPoV4O3Gs9wPlchBmZsFpx8lJRSqnaFtyhkeD3JfHByuG54JEulI1HyzsKK6Qv/xT0+WT+VlsR4Dyy5hGXf/taSXHSAVQ62dyI9h0xMnpLjhSdySDzcH+o3dt+1UwYHy35CVn8noIZ90TXQWxWmASGsIaeIumZfTY/06kq8TSAH6doQKL5pM5w7rpHHwc2l14TloJRif3YGRGZ5MV1zUqJ87lq57oM5/aG0RA4ieqnRVAo9OKtgDeuAuPDmyhQMqkKJgfKh1/bzKrp2UzCm4HtCzZlpyg0roEsA1XsLAtKKnBo/siK0lInSWCpez9fujkoz0w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9ecdbf-2005-440b-840e-08d86a503063
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 23:33:11.3362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: We31Zzsm7g4Lsw6E2uUGKdIoxLQiD/cOV3KZynsVzpOeqichOAhZ61jcKYzx/uBnetWoAb9ZI3NF36tYR/vVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0726
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/06 23:15, Johannes Thumshirn wrote:=0A=
> Martin rightfully noted that for normal filesystem IO we have soft limits=
=0A=
> in place, to prevent them from getting too big and not lead to=0A=
> unpredictable latencies. For zone append we only have the hardware limit=
=0A=
> in place.=0A=
> =0A=
> Add a soft limit to the maximal zone append size which is gated by the=0A=
> hardware's capabilities, so the user can control the IO size of zone=0A=
> append commands.=0A=
> =0A=
> Reported-by: Martin K. Petersen <martin.petersen@oracle.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  block/blk-settings.c           | 10 ++++++----=0A=
>  block/blk-sysfs.c              | 33 ++++++++++++++++++++++++++++++++-=0A=
>  drivers/block/null_blk_zoned.c |  2 +-=0A=
>  drivers/nvme/host/core.c       |  2 +-=0A=
>  drivers/scsi/sd_zbc.c          |  2 +-=0A=
>  include/linux/blkdev.h         |  3 ++-=0A=
>  6 files changed, 43 insertions(+), 9 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 4f6eb4bb1723..e4ff7546dd82 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -222,11 +222,11 @@ void blk_queue_max_write_zeroes_sectors(struct requ=
est_queue *q,=0A=
>  EXPORT_SYMBOL(blk_queue_max_write_zeroes_sectors);=0A=
>  =0A=
>  /**=0A=
> - * blk_queue_max_zone_append_sectors - set max sectors for a single zone=
 append=0A=
> + * blk_queue_max_hw_zone_append_sectors - set max sectors for a single z=
one append=0A=
>   * @q:  the request queue for the device=0A=
>   * @max_zone_append_sectors: maximum number of sectors to write per comm=
and=0A=
>   **/=0A=
> -void blk_queue_max_zone_append_sectors(struct request_queue *q,=0A=
> +void blk_queue_max_hw_zone_append_sectors(struct request_queue *q,=0A=
>  		unsigned int max_zone_append_sectors)=0A=
>  {=0A=
>  	unsigned int max_sectors;=0A=
> @@ -244,9 +244,11 @@ void blk_queue_max_zone_append_sectors(struct reques=
t_queue *q,=0A=
>  	 */=0A=
>  	WARN_ON(!max_sectors);=0A=
>  =0A=
> -	q->limits.max_zone_append_sectors =3D max_sectors;=0A=
> +	q->limits.max_hw_zone_append_sectors =3D max_sectors;=0A=
> +	q->limits.max_zone_append_sectors =3D min_not_zero(max_sectors,=0A=
> +							 q->limits.max_zone_append_sectors);=0A=
>  }=0A=
> -EXPORT_SYMBOL_GPL(blk_queue_max_zone_append_sectors);=0A=
> +EXPORT_SYMBOL_GPL(blk_queue_max_hw_zone_append_sectors);=0A=
>  =0A=
>  /**=0A=
>   * blk_queue_max_segments - set max hw segments for a request for this q=
ueue=0A=
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
> index 76b54c7750b0..087b7e66e638 100644=0A=
> --- a/block/blk-sysfs.c=0A=
> +++ b/block/blk-sysfs.c=0A=
> @@ -226,6 +226,35 @@ static ssize_t queue_zone_append_max_show(struct req=
uest_queue *q, char *page)=0A=
>  	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);=0A=
>  }=0A=
>  =0A=
> +static ssize_t=0A=
> +queue_zone_append_max_store(struct request_queue *q, const char *page,=
=0A=
> +				    size_t count)=0A=
> +{=0A=
> +	unsigned long max_hw_sectors =3D q->limits.max_hw_zone_append_sectors;=
=0A=
> +	unsigned long max_sectors;=0A=
> +	ssize_t ret;=0A=
> +=0A=
> +	ret =3D queue_var_store(&max_sectors, page, count);=0A=
> +	if (ret < 0)=0A=
> +		return ret;=0A=
> +=0A=
> +	max_sectors >>=3D SECTOR_SHIFT;=0A=
> +	max_sectors =3D min_not_zero(max_sectors, max_hw_sectors);=0A=
> +=0A=
> +	spin_lock_irq(&q->queue_lock);=0A=
> +	q->limits.max_zone_append_sectors =3D max_sectors;=0A=
> +	spin_unlock_irq(&q->queue_lock);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
=0A=
Hmmm. That is one more tunable knob, and one that the user/sysadmin may not=
=0A=
consider without knowing that the FS is actually using zone append. E.g. bt=
rfs=0A=
does, f2fs does not. I was thinking of something simpler:=0A=
=0A=
* Keep the soft limit zone_append_max_bytes/max_zone_append_sectors as RO=
=0A=
* Change its value when the generic soft limit max_sectors is changed.=0A=
=0A=
Something like this:=0A=
=0A=
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
index 7dda709f3ccb..78817d7acb66 100644=0A=
--- a/block/blk-sysfs.c=0A=
+++ b/block/blk-sysfs.c=0A=
@@ -246,6 +246,11 @@ queue_max_sectors_store(struct request_queue *q, const=
 char=0A=
*page, size_t count)=0A=
        spin_lock_irq(&q->queue_lock);=0A=
        q->limits.max_sectors =3D max_sectors_kb << 1;=0A=
        q->backing_dev_info->io_pages =3D max_sectors_kb >> (PAGE_SHIFT - 1=
0);=0A=
+=0A=
+       q->limits.max_zone_append_sectors =3D=0A=
+               min(q->limits.max_sectors,=0A=
+                   q->limits.max_hw_zone_append_sectors);=0A=
+=0A=
        spin_unlock_irq(&q->queue_lock);=0A=
=0A=
        return ret;=0A=
=0A=
The reasoning is that zone appends are a variation of write commands, and s=
ince=0A=
max_sectors will gate the size of all read and write commands, it should al=
so=0A=
gate the size zone append writes. And that avoids adding yet another tuning=
 knob=0A=
for users to get confused about.=0A=
=0A=
Martin,=0A=
=0A=
Thoughts ?=0A=
=0A=
=0A=
=0A=
> +=0A=
> +static ssize_t queue_zone_append_max_hw_show(struct request_queue *q, ch=
ar *page)=0A=
> +{=0A=
> +	unsigned long long max_sectors =3D q->limits.max_hw_zone_append_sectors=
;=0A=
> +=0A=
> +	return sprintf(page, "%llu\n", max_sectors << SECTOR_SHIFT);=0A=
> +}=0A=
> +=0A=
>  static ssize_t=0A=
>  queue_max_sectors_store(struct request_queue *q, const char *page, size_=
t count)=0A=
>  {=0A=
> @@ -584,7 +613,8 @@ QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_ze=
roes_data");=0A=
>  =0A=
>  QUEUE_RO_ENTRY(queue_write_same_max, "write_same_max_bytes");=0A=
>  QUEUE_RO_ENTRY(queue_write_zeroes_max, "write_zeroes_max_bytes");=0A=
> -QUEUE_RO_ENTRY(queue_zone_append_max, "zone_append_max_bytes");=0A=
> +QUEUE_RW_ENTRY(queue_zone_append_max, "zone_append_max_bytes");=0A=
> +QUEUE_RO_ENTRY(queue_zone_append_max_hw, "zone_append_max_hw_bytes");=0A=
>  =0A=
>  QUEUE_RO_ENTRY(queue_zoned, "zoned");=0A=
>  QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");=0A=
> @@ -639,6 +669,7 @@ static struct attribute *queue_attrs[] =3D {=0A=
>  	&queue_write_same_max_entry.attr,=0A=
>  	&queue_write_zeroes_max_entry.attr,=0A=
>  	&queue_zone_append_max_entry.attr,=0A=
> +	&queue_zone_append_max_hw_entry.attr,=0A=
>  	&queue_nonrot_entry.attr,=0A=
>  	&queue_zoned_entry.attr,=0A=
>  	&queue_nr_zones_entry.attr,=0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index 3d25c9ad2383..b1b08f2a09bd 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -98,7 +98,7 @@ int null_register_zoned_dev(struct nullb *nullb)=0A=
>  		q->nr_zones =3D blkdev_nr_zones(nullb->disk);=0A=
>  	}=0A=
>  =0A=
> -	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);=0A=
> +	blk_queue_max_hw_zone_append_sectors(q, dev->zone_size_sects);=0A=
>  =0A=
>  	return 0;=0A=
>  }=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index c190c56bf702..b2da0ab9d68a 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -2217,7 +2217,7 @@ static int nvme_revalidate_disk(struct gendisk *dis=
k)=0A=
>  =0A=
>  		ret =3D blk_revalidate_disk_zones(disk, NULL);=0A=
>  		if (!ret)=0A=
> -			blk_queue_max_zone_append_sectors(disk->queue,=0A=
> +			blk_queue_max_hw_zone_append_sectors(disk->queue,=0A=
>  							  ctrl->max_zone_append);=0A=
>  	}=0A=
>  #endif=0A=
> diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c=0A=
> index 0e94ff056bff..9412445d4efb 100644=0A=
> --- a/drivers/scsi/sd_zbc.c=0A=
> +++ b/drivers/scsi/sd_zbc.c=0A=
> @@ -705,7 +705,7 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)=
=0A=
>  			   q->limits.max_segments << (PAGE_SHIFT - 9));=0A=
>  	max_append =3D min_t(u32, max_append, queue_max_hw_sectors(q));=0A=
>  =0A=
> -	blk_queue_max_zone_append_sectors(q, max_append);=0A=
> +	blk_queue_max_hw_zone_append_sectors(q, max_append);=0A=
>  =0A=
>  	sd_zbc_print_zones(sdkp);=0A=
>  =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index cf80e61b4c5e..e53ea384c15d 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -336,6 +336,7 @@ struct queue_limits {=0A=
>  	unsigned int		max_hw_discard_sectors;=0A=
>  	unsigned int		max_write_same_sectors;=0A=
>  	unsigned int		max_write_zeroes_sectors;=0A=
> +	unsigned int		max_hw_zone_append_sectors;=0A=
>  	unsigned int		max_zone_append_sectors;=0A=
>  	unsigned int		discard_granularity;=0A=
>  	unsigned int		discard_alignment;=0A=
> @@ -1141,7 +1142,7 @@ extern void blk_queue_max_write_same_sectors(struct=
 request_queue *q,=0A=
>  extern void blk_queue_max_write_zeroes_sectors(struct request_queue *q,=
=0A=
>  		unsigned int max_write_same_sectors);=0A=
>  extern void blk_queue_logical_block_size(struct request_queue *, unsigne=
d int);=0A=
> -extern void blk_queue_max_zone_append_sectors(struct request_queue *q,=
=0A=
> +extern void blk_queue_max_hw_zone_append_sectors(struct request_queue *q=
,=0A=
>  		unsigned int max_zone_append_sectors);=0A=
>  extern void blk_queue_physical_block_size(struct request_queue *, unsign=
ed int);=0A=
>  extern void blk_queue_alignment_offset(struct request_queue *q,=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
