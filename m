Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA5294A67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 11:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407500AbgJUJVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 05:21:42 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:29759 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394365AbgJUJVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603272954; x=1634808954;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QhGUdLD02Qe+0fvCbZlnAjmsYMhrRg7gPYJSnXSEEJ8=;
  b=Dp4ZYp3NxOUnM4B/oQEKSlQB4bLECdOe+L6yWkkVUoWzyhRKJsvfQU+o
   Vt4ihWY4MWAtzg19nR1vsIbgDrG2Qfq51U9L/b4rO3b4WTx/wgN4CcFIY
   Gv53iYEcDDbcfSNVB7flm6eF2F5SNkfizarj1Xhb1rOrsSqXsDay5P+Ff
   9KKQvFTYTknCjDpY2OLlK393vh5UCZjyVfZFBkzouTC79HlJLckkldfTM
   rwttreUvx4Maa+MKwJuzT7dxvhqU5oGpFjN5klBzx9XSslf8xaevtdmkt
   7vyCQ7Ii+C+WMFRF8o8L3/wGhdig9OKKtp4zCM1qDkmlVcGh5spW2PNUi
   Q==;
IronPort-SDR: 0pJbtO1479UVWI9wUmGgwQJpKtPIa8Jt7lP+U0X5l9RmfF3XRVlK+A8RrpfNcnJCoTz4v1To4C
 Vd35RabyVXWXTlyxyDxiH8RDH6qoh+l5j5L7+bAb4I56qTDDvilBs0MJvjPxpwFccuOwhY/sHA
 Lbj5D0polpYjoH15yQEmhtpBLJatvXacU2yGwIaVg7145wVlwhemO/X4x6Pcc/GSmnCkGpW6js
 E0rmRbKnumbmY09qbxtTG76h+3hr+VIcICXzQAbQN/UOkDnqgxSoFxifEIfWenEX+w3ZAPyoZA
 4WM=
X-IronPort-AV: E=Sophos;i="5.77,400,1596470400"; 
   d="scan'208";a="253998581"
Received: from mail-sn1nam02lp2050.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.50])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 17:35:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOeRDJaAEYvpQwQcUtnIDdfEMc5bQ9aAWxLu/GvccyrvFHj7dv//K30sBJRRoQJHPYFwHbD2WkQdupkp/AxgLC/x+bqJINCSBGw9IPFpowetzemOzh8ma9hM4sOz+lvs2bZ91qDM/WHOX1qQetdQ0pBblWhPyxROX9NBy9SwtJx4Mee5WUDPlF54frxs8zMzZ+mREy1kf7WZbPLQD5ubQ8lRIgk2ptN+1OeKHbwRoqcN/SI/rqpU3bCYo/H9EWc0d5v3Upgeu/OlG5uFJnlJ4HkBgcj3vIbqURRceNy7tuuzyVZ0uox2dXVaxJ/fvazA+ekrUyD47U87wvXOVVhcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+l+RV+LIjzx1q7AzY7ADzebeC7Dg7uJ+Hosr0n/jrc=;
 b=FX8tYjhqEd9YQmZTX8HZ1lWIPdmXmTDGb5RbV62spxRGS7hFAL/35UiN2G26McDzy9ioqcWuMhQcUg9HfeUfCgxCxYfAynFmJ/g2YKVN7BS7b3zX8dTOGvqnuPB+y0cX5qfCuUaDDM7S+K6W7Cj0FHt2RYoPnp56B+Y6ehS1RQjSsEUeFjNWR3iwE2WmuCoalxC2mgwJv9oMfg2xMQ5oxFQrPrhwwfKdryMFyxo81SfIBVsvrezNTjsHmj+kwBX5AqK5BSjyqAP4PmZz8YjUWVqq4pkX1Y86TE4IyPVqUvg8/M9tYzBzqdmCzhEO241Baz+QhnZWSuh6Vtl3GTaeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+l+RV+LIjzx1q7AzY7ADzebeC7Dg7uJ+Hosr0n/jrc=;
 b=QwLkdDkkCq5S7DbuxYVBiFyx1XcSmWwsWn4HNXxKQ+9MCIcr0BvVG+k9hSTHNzMEohXH6vAo93qPYZQqKQr8AG8Idm4y0kd2Ok3JlopRoaiIXNanRjuBGPXAkV2ktjBB5pttBBl9/AYwhXCHatgt8NVdOniDB4yrOA2Uzju8HMU=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 09:21:36 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 09:21:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "hch@infradead.org" <hch@infradead.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "jack@suse.cz" <jack@suse.cz>, "tj@kernel.org" <tj@kernel.org>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] Block layer filter - second version
Thread-Topic: [PATCH 1/2] Block layer filter - second version
Thread-Index: AQHWp4k5hT7f6E8upUaS4nmh2j0rHg==
Date:   Wed, 21 Oct 2020 09:21:36 +0000
Message-ID: <BL0PR04MB65141320C7BF75B7142CA30CE71C0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <1603271049-20681-1-git-send-email-sergei.shtepa@veeam.com>
 <1603271049-20681-2-git-send-email-sergei.shtepa@veeam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: veeam.com; dkim=none (message not signed)
 header.d=none;veeam.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:ccac:9944:3b6:800f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b331c5ef-9cce-4343-19e5-08d875a2b5b3
x-ms-traffictypediagnostic: MN2PR04MB6446:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6446539CC5688219DF3CB5D9E71C0@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNffdvXlVbJITc3b76x0Q60wResqmK2prNTSm9odDIy1AWfs1crk67niEMwgaymJLFRczpNteWIJqsSN1lOrdzfsVWokRPE9p9qyw7QlNQ8D20K90Jajts+wvLenM5ePsC+OfS49kFZBZgCYLW+B0wA5gB20Lc+ly/dpVJIZEVz1WYVURmlcCE3rQGmyYAOOzSo+IwhuFCPRP4PmLvBCSxVPcRkNxCV9RI4NADiZuAX/MBckIPd3T4Bq0uIVTOwYM6dG1fTwiSKWVh4rpdgWvQ/nmo4cV4+SKGW5suIz7ndorIpqFOALpORNvAXq28/hmUDlgZtW2Qxy7YKxZ4pUmeQ7tMEkgc6mXJDLAOliuGxI/Zlxaq/4Q/Cwh/jDzXe7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(316002)(83380400001)(76116006)(66556008)(91956017)(110136005)(478600001)(5660300002)(55016002)(71200400001)(66446008)(64756008)(6506007)(52536014)(8676002)(53546011)(7696005)(66476007)(8936002)(7416002)(2906002)(9686003)(66946007)(30864003)(186003)(86362001)(33656002)(921003)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: G4poOBjz+kfgTGLmUFqvlsIDv3CDMKqA8r8gkSqWKiGJ42FZ9HxHJ5cL2/SPTlsC+n4mHpvzSMIpPGM3js2StCQVxVjQkVQHyOUb4Xz84cm12IBAQJQePL1vykmW52jhPZ5GUzdEpYNCMTr7HWKjy+e4KFy9p38p+JRh7tKX8uAQq2K2gTfXOYfGKnfaf0/GpwsDapMtlJDjPAksJtKNYQ7rmyTy8gvpDem6K4gLKmCXgHNaQvU9oa9YcNG6dYNom/1PtbiXtW7+g9wPHVFrcKR04RDBuTe7UtjLUhL4xPr6oJXJMuwVKB5TmdGUnKjXJz4A2eqDFnqY/aL4WOSMJpCGnGpY2Q9esVCKRGp7Hr3AdgZx/ayJGwWjZ/KhgjqVxc0qAPg8/yaTrSQHzrPjpErlxdMpEa24vGEynpNqNwB0ZM3ai6NCKU1CmffOmF98Y2H3t0lwB8e/bSZysM5u0h/kR+CcG9d/alEzyLGk62PK5QAdhuvocs7qxVF9+emNrB3sWULDZT0fPreicohdqi41GyizK/MKAhsmviauCeApzg2ewBq73uvT8w4c9u2iAB/HsjZWAlGfdV5OhTqJ8ogmAV7B8wCC8suliqr2LBBRleAoxVQtWRWU5HDwik/WX+Pn6U+iFonb1WUC3EUmDQ+ptNIxYC2HO7sq+GzVhJ0S80SammpFcgpDD2COQpfNF3ZZJjXde0pzyAMOLZKQSA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b331c5ef-9cce-4343-19e5-08d875a2b5b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 09:21:36.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IP/+glXHG82Pfe0oad6snAoYR7r6gQQNB20PbJ15t4AABCtB4JAvPFrLxxMViMBsLpAEO1giTKMfFB9by5qtnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/21 18:04, Sergei Shtepa wrote:=0A=
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>=0A=
> ---=0A=
>  block/Kconfig               |  11 ++=0A=
>  block/Makefile              |   1 +=0A=
>  block/blk-core.c            |  52 +++++--=0A=
>  block/blk-filter-internal.h |  29 ++++=0A=
>  block/blk-filter.c          | 286 ++++++++++++++++++++++++++++++++++++=
=0A=
>  block/partitions/core.c     |  14 +-=0A=
>  fs/block_dev.c              |   6 +-=0A=
>  fs/direct-io.c              |   2 +-=0A=
>  fs/iomap/direct-io.c        |   2 +-=0A=
>  include/linux/bio.h         |   4 +-=0A=
>  include/linux/blk-filter.h  |  76 ++++++++++=0A=
>  include/linux/genhd.h       |   8 +-=0A=
>  kernel/power/swap.c         |   2 +-=0A=
>  mm/page_io.c                |   4 +-=0A=
>  14 files changed, 471 insertions(+), 26 deletions(-)=0A=
>  create mode 100644 block/blk-filter-internal.h=0A=
>  create mode 100644 block/blk-filter.c=0A=
>  create mode 100644 include/linux/blk-filter.h=0A=
> =0A=
> diff --git a/block/Kconfig b/block/Kconfig=0A=
> index bbad5e8bbffe..a308801b4376 100644=0A=
> --- a/block/Kconfig=0A=
> +++ b/block/Kconfig=0A=
> @@ -204,6 +204,17 @@ config BLK_INLINE_ENCRYPTION_FALLBACK=0A=
>  	  by falling back to the kernel crypto API when inline=0A=
>  	  encryption hardware is not present.=0A=
>  =0A=
> +config BLK_FILTER=0A=
> +	bool "Enable support for block layer filters"=0A=
> +	default y=0A=
> +	depends on MODULES=0A=
> +	help=0A=
> +	  Enabling this lets third-party kernel modules intercept=0A=
> +	  bio requests for any block device. This allows them to implement=0A=
> +	  changed block tracking and snapshots without any reconfiguration of=
=0A=
> +	  the existing setup. For example, this option allows snapshotting of=
=0A=
> +	  a block device without adding it to LVM.=0A=
> +=0A=
>  menu "Partition Types"=0A=
>  =0A=
>  source "block/partitions/Kconfig"=0A=
> diff --git a/block/Makefile b/block/Makefile=0A=
> index 8d841f5f986f..b8ee50b8e031 100644=0A=
> --- a/block/Makefile=0A=
> +++ b/block/Makefile=0A=
> @@ -38,3 +38,4 @@ obj-$(CONFIG_BLK_SED_OPAL)	+=3D sed-opal.o=0A=
>  obj-$(CONFIG_BLK_PM)		+=3D blk-pm.o=0A=
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+=3D keyslot-manager.o blk-crypto.o=
=0A=
>  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+=3D blk-crypto-fallback.o=
=0A=
> +obj-$(CONFIG_BLK_FILTER)	+=3D blk-filter.o=0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 10c08ac50697..cc06402af695 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -1216,23 +1216,20 @@ blk_qc_t submit_bio_noacct(struct bio *bio)=0A=
>  EXPORT_SYMBOL(submit_bio_noacct);=0A=
=0A=
Probably best to have this as its own patch last in the series.=0A=
=0A=
>  =0A=
>  /**=0A=
> - * submit_bio - submit a bio to the block device layer for I/O=0A=
> - * @bio: The &struct bio which describes the I/O=0A=
> - *=0A=
> - * submit_bio() is used to submit I/O requests to block devices.  It is =
passed a=0A=
> - * fully set up &struct bio that describes the I/O that needs to be done=
.  The=0A=
> - * bio will be send to the device described by the bi_disk and bi_partno=
 fields.=0A=
> + * submit_bio_direct - submit a bio to the block device layer for I/O=0A=
> + * bypass filter.=0A=
> + * @bio:  The bio describing the location in memory and on the device.=
=0A=
>   *=0A=
> - * The success/failure status of the request, along with notification of=
=0A=
> - * completion, is delivered asynchronously through the ->bi_end_io() cal=
lback=0A=
> - * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io(=
) has=0A=
> - * been called.=0A=
> + * Description:=0A=
> + *    This is a version of submit_bio() that shall only be used for I/O=
=0A=
> + *    that cannot be intercepted by block layer filters.=0A=
> + *    All file systems and other upper level users of the block layer=0A=
> + *    should use submit_bio() instead.=0A=
> + *    Use this function to access the swap partition and directly access=
=0A=
> + *    the block device file.=0A=
>   */=0A=
> -blk_qc_t submit_bio(struct bio *bio)=0A=
> +blk_qc_t submit_bio_direct(struct bio *bio)=0A=
>  {=0A=
> -	if (blkcg_punt_bio_submit(bio))=0A=
> -		return BLK_QC_T_NONE;=0A=
> -=0A=
>  	/*=0A=
>  	 * If it's a regular read/write or a barrier with data attached,=0A=
>  	 * go through the normal accounting stuff before submission.=0A=
> @@ -1282,8 +1279,35 @@ blk_qc_t submit_bio(struct bio *bio)=0A=
>  =0A=
>  	return submit_bio_noacct(bio);=0A=
>  }=0A=
> +EXPORT_SYMBOL(submit_bio_direct);=0A=
=0A=
EXPORT_SYMBOL_GPL=0A=
=0A=
> +=0A=
> +/**=0A=
> + * submit_bio - submit a bio to the block device layer for I/O=0A=
> + * @bio: The &struct bio which describes the I/O=0A=
> + *=0A=
> + * submit_bio() is used to submit I/O requests to block devices.  It is =
passed a=0A=
> + * fully set up &struct bio that describes the I/O that needs to be done=
.  The=0A=
> + * bio will be send to the device described by the bi_disk and bi_partno=
 fields.=0A=
> + *=0A=
> + * The success/failure status of the request, along with notification of=
=0A=
> + * completion, is delivered asynchronously through the ->bi_end_io() cal=
lback=0A=
> + * in @bio.  The bio must NOT be touched by thecaller until ->bi_end_io(=
) has=0A=
> + * been called.=0A=
> + */=0A=
> +void submit_bio(struct bio *bio)=0A=
> +{=0A=
> +	if (blkcg_punt_bio_submit(bio))=0A=
> +		return;=0A=
> +=0A=
> +#ifdef CONFIG_BLK_FILTER> +	blk_filter_submit_bio(bio);=0A=
> +#else=0A=
> +	submit_bio_direct(bio);=0A=
> +#endif=0A=
=0A=
=0A=
	if (IS_ENABLED(CONFIG_BLK_FILTER))=0A=
		blk_filter_submit_bio(bio);=0A=
	else=0A=
		submit_bio_direct(bio);=0A=
=0A=
is much cleaner...=0A=
=0A=
=0A=
> +}=0A=
>  EXPORT_SYMBOL(submit_bio);=0A=
>  =0A=
> +=0A=
>  /**=0A=
>   * blk_cloned_rq_check_limits - Helper function to check a cloned reques=
t=0A=
>   *                              for the new queue limits=0A=
=0A=
=0A=
The remaining should probably be a different patch before the above change.=
=0A=
=0A=
> diff --git a/block/blk-filter-internal.h b/block/blk-filter-internal.h=0A=
> new file mode 100644=0A=
> index 000000000000..d456a09f50db=0A=
> --- /dev/null=0A=
> +++ b/block/blk-filter-internal.h=0A=
> @@ -0,0 +1,29 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +=0A=
> +/*=0A=
> + *=0A=
> + * Block device filters internal declarations=0A=
> + */=0A=
> +=0A=
> +#ifndef BLK_FILTER_INTERNAL_H=0A=
> +#define BLK_FILTER_INTERNAL_H=0A=
> +=0A=
> +#ifdef CONFIG_BLK_FILTER=0A=
> +#include <linux/blk-filter.h>=0A=
> +=0A=
> +void blk_filter_part_add(struct hd_struct *part, dev_t devt);=0A=
> +=0A=
> +void blk_filter_part_del(struct hd_struct *part);=0A=
> +=0A=
> +#else /* CONFIG_BLK_FILTER */=0A=
> +=0A=
> +=0A=
=0A=
double blank line=0A=
=0A=
> +static inline void blk_filter_part_add(struct hd_struct *part, dev_t dev=
t)=0A=
> +{ };=0A=
> +=0A=
> +static inline void blk_filter_part_del(struct hd_struct *part)=0A=
> +{ };=0A=
> +=0A=
> +#endif /* CONFIG_BLK_FILTER */=0A=
> +=0A=
> +#endif=0A=
> diff --git a/block/blk-filter.c b/block/blk-filter.c=0A=
> new file mode 100644=0A=
> index 000000000000..f6de16c45a16=0A=
> --- /dev/null=0A=
> +++ b/block/blk-filter.c=0A=
> @@ -0,0 +1,286 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +=0A=
> +#include <linux/genhd.h>=0A=
> +#include <linux/bio.h>=0A=
> +#include <linux/blkdev.h>=0A=
> +#include "blk-filter-internal.h"=0A=
> +#include <linux/rwsem.h>=0A=
> +=0A=
> +=0A=
=0A=
Again here=0A=
=0A=
> +LIST_HEAD(filters);=0A=
> +DECLARE_RWSEM(filters_lock);=0A=
> +=0A=
> +static void blk_filter_release(struct kref *kref)=0A=
> +{=0A=
> +	struct blk_filter *flt =3D container_of(kref, struct blk_filter, kref);=
=0A=
> +=0A=
> +	kfree(flt);=0A=
> +}=0A=
> +=0A=
> +static inline void blk_filter_get(struct blk_filter *flt)=0A=
> +{=0A=
> +	kref_get(&flt->kref);=0A=
> +}=0A=
> +=0A=
> +static inline void blk_filter_put(struct blk_filter *flt)=0A=
> +{=0A=
> +	kref_put(&flt->kref, blk_filter_release);=0A=
> +}=0A=
> +=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_part_add() - Notify filters when a new partition is added.=
=0A=
> + * @part: The partition for new block device.=0A=
> + * @devt: Device id for new block device.=0A=
> + *=0A=
> + * Description:=0A=
> + *    When the block device is appears in the system, call the filter=0A=
> + *    callback to notify that the block device appears.=0A=
> + */=0A=
> +void blk_filter_part_add(struct hd_struct *part, dev_t devt)=0A=
> +{=0A=
> +	down_read(&filters_lock);=0A=
> +	if (!list_empty(&filters)) {=0A=
> +		struct list_head *_list_head;=0A=
> +=0A=
> +		list_for_each(_list_head, &filters) {=0A=
> +			void *filter_data;=0A=
> +			bool attached =3D false;=0A=
> +			struct blk_filter *flt;=0A=
> +=0A=
> +			flt =3D list_entry(_list_head, struct blk_filter, link);=0A=
> +=0A=
> +			attached =3D flt->ops->part_add(devt, &filter_data);=0A=
> +			if (attached) {=0A=
> +				blk_filter_get(flt);=0A=
> +				part->filter =3D flt;=0A=
> +				part->filter_data =3D filter_data;=0A=
> +				break;=0A=
> +			}=0A=
> +		}=0A=
> +	}=0A=
> +	up_read(&filters_lock);=0A=
> +}=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_part_del() - Notify filters when the partition is deleted.=
=0A=
> + * @part: The partition of block device.=0A=
> + *=0A=
> + * Description:=0A=
> + *    When the block device is destroying and the partition is releasing=
,=0A=
> + *    call the filter callback to notify that the block device will be=
=0A=
> + *    deleted.=0A=
> + */=0A=
> +void blk_filter_part_del(struct hd_struct *part)=0A=
> +{=0A=
> +	struct blk_filter *flt =3D part->filter;=0A=
> +=0A=
> +	if (!flt)=0A=
> +		return;=0A=
> +=0A=
> +	flt->ops->part_del(part->filter_data);=0A=
> +=0A=
> +	part->filter_data =3D NULL;=0A=
> +	part->filter =3D NULL;=0A=
> +	blk_filter_put(flt);=0A=
> +}=0A=
> +=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_submit_bio() - Send new bio to filters for processing.=0A=
> + * @bio: The new bio for block I/O layer.=0A=
> + *=0A=
> + * Description:=0A=
> + *    This function is an implementation of block layer filter=0A=
> + *    interception. If the filter is attached to this block device,=0A=
> + *    then bio will be redirected to the filter kernel module.=0A=
> + */=0A=
> +void blk_filter_submit_bio(struct bio *bio)=0A=
> +{=0A=
> +	bool intercepted =3D false;=0A=
> +	struct hd_struct *part;=0A=
> +=0A=
> +	bio_get(bio);=0A=
> +=0A=
> +	part =3D disk_get_part(bio->bi_disk, bio->bi_partno);=0A=
> +	if (unlikely(!part)) {=0A=
> +		bio->bi_status =3D BLK_STS_IOERR;=0A=
> +		bio_endio(bio);=0A=
> +=0A=
> +		bio_put(bio);=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	down_read(&part->filter_rw_lockup);=0A=
> +=0A=
> +	if (part->filter)=0A=
> +		intercepted =3D part->filter->ops->filter_bio(bio, part->filter_data);=
=0A=
> +=0A=
> +	up_read(&part->filter_rw_lockup);=0A=
> +=0A=
> +	if (!intercepted)=0A=
> +		submit_bio_direct(bio);=0A=
> +=0A=
> +	disk_put_part(part);=0A=
> +=0A=
> +	bio_put(bio);=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_filter_submit_bio);=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_register() - Register block layer filter.=0A=
> + * @ops: New filter callbacks.=0A=
> + *=0A=
> + * Return:=0A=
> + *     Filter ID, a pointer to the service structure of the filter.=0A=
> + *=0A=
> + * Description:=0A=
> + *    Create new filter structure.=0A=
> + *    Use blk_filter_attach to attach devices to filter.=0A=
> + */=0A=
> +void *blk_filter_register(struct blk_filter_ops *ops)=0A=
> +{=0A=
> +	struct blk_filter *flt;=0A=
> +=0A=
> +	flt =3D kzalloc(sizeof(struct blk_filter), GFP_KERNEL);=0A=
> +	if (!flt)=0A=
> +		return NULL;=0A=
> +=0A=
> +	kref_init(&flt->kref);=0A=
> +	flt->ops =3D ops;=0A=
> +=0A=
> +	down_write(&filters_lock);=0A=
> +	list_add_tail(&flt->link, &filters);=0A=
> +	up_write(&filters_lock);=0A=
> +=0A=
> +	return flt;=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_filter_register);=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_unregister() - Unregister block layer filter.=0A=
> + * @filter: filter identifier.=0A=
> + *=0A=
> + * Description:=0A=
> + *    Before call blk_filter_unregister() and unload filter module all=
=0A=
> + *    partitions MUST be detached. Otherwise, the system will have a=0A=
> + *    filter with non-existent interception functions.=0A=
> + */=0A=
> +void blk_filter_unregister(void *filter)=0A=
> +{=0A=
> +	struct blk_filter *flt =3D filter;=0A=
> +=0A=
> +	down_write(&filters_lock);=0A=
> +	list_del(&flt->link);=0A=
> +	up_write(&filters_lock);=0A=
> +=0A=
> +	blk_filter_put(flt);=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_filter_unregister);=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_attach() - Attach block layer filter.=0A=
> + * @devt: The block device identification number.=0A=
> + * @filter: Filter identifier.=0A=
> + * @filter_data: Specific filters data for this device.=0A=
> + *=0A=
> + * Return:=0A=
> + *    Return code.=0A=
> + *    -ENODEV - cannot find this device, it is OK if the device does not=
 exist yet.=0A=
> + *    -EALREADY - this device is already attached to this filter.=0A=
> + *    -EBUSY - this device is already attached to the another filter.=0A=
> + *=0A=
> + * Description:=0A=
> + *    Attach the device to the block layer filter.=0A=
> + *    Only one filter can be attached to a single device.=0A=
> + */=0A=
> +int blk_filter_attach(dev_t devt, void *filter, void *filter_data)=0A=
> +{=0A=
> +	int ret =3D 0;=0A=
> +	struct blk_filter *flt =3D filter;=0A=
> +	struct block_device *blk_dev;=0A=
> +=0A=
> +=0A=
> +	blk_dev =3D bdget(devt);=0A=
> +	if (!blk_dev)=0A=
> +		return -ENODEV;=0A=
> +=0A=
> +	blk_filter_freeze(blk_dev);=0A=
> +=0A=
> +	if (blk_dev->bd_part->filter) {=0A=
> +		if (blk_dev->bd_part->filter =3D=3D flt)=0A=
> +			ret =3D -EALREADY;=0A=
> +		else=0A=
> +			ret =3D -EBUSY;=0A=
> +	} else {=0A=
> +		blk_filter_get(flt);=0A=
> +		blk_dev->bd_part->filter =3D flt;=0A=
> +		blk_dev->bd_part->filter_data =3D filter_data;=0A=
> +	}=0A=
> +=0A=
> +	blk_filter_thaw(blk_dev);=0A=
> +=0A=
> +	bdput(blk_dev);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_filter_attach);=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_detach() - Detach block layer filter.=0A=
> + * @devt: The block device identification number.=0A=
> + *=0A=
> + * Description:=0A=
> + *    Detach the device from the block layer filter.=0A=
> + *    Do not forget detach all devices before calling the=0A=
> + *    blk_filter_unregister() function and unload the module!=0A=
> + */=0A=
> +void blk_filter_detach(dev_t devt)=0A=
> +{=0A=
> +	struct blk_filter *flt;=0A=
> +	struct block_device *blk_dev;=0A=
> +=0A=
> +	blk_dev =3D bdget(devt);=0A=
> +	if (!blk_dev)=0A=
> +		return;=0A=
> +=0A=
> +	blk_filter_freeze(blk_dev);=0A=
> +=0A=
> +	flt =3D blk_dev->bd_part->filter;=0A=
> +	if (flt) {=0A=
> +		blk_dev->bd_part->filter_data =3D NULL;=0A=
> +		blk_dev->bd_part->filter =3D NULL;=0A=
> +		blk_filter_put(flt);=0A=
> +	}=0A=
> +=0A=
> +	blk_filter_thaw(blk_dev);=0A=
> +=0A=
> +	bdput(blk_dev);=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_filter_detach);=0A=
=0A=
All the EXPORT_SYMBOL should probably be EXPORT_SYMBOL_GPL.=0A=
=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_freeze() - Lock bio submitting.=0A=
> + * @bdev: The block device pointer.=0A=
> + *=0A=
> + * Description:=0A=
> + *    Stop bio processing.=0A=
> + */=0A=
> +void blk_filter_freeze(struct block_device *bdev)=0A=
> +{=0A=
> +	down_write(&bdev->bd_part->filter_rw_lockup);=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_filter_freeze);=0A=
> +=0A=
> +/**=0A=
> + * blk_filter_thaw() - Unlock bio submitting.=0A=
> + * @bdev: The block device pointer.=0A=
> + *=0A=
> + * Description:=0A=
> + *    Resume bio processing.=0A=
> + */=0A=
> +void blk_filter_thaw(struct block_device *bdev)=0A=
> +{=0A=
> +	up_write(&bdev->bd_part->filter_rw_lockup);=0A=
> +}=0A=
> +EXPORT_SYMBOL(blk_filter_thaw);=0A=
> diff --git a/block/partitions/core.c b/block/partitions/core.c=0A=
> index 722406b841df..6b845e98b9a1 100644=0A=
> --- a/block/partitions/core.c=0A=
> +++ b/block/partitions/core.c=0A=
> @@ -11,6 +11,7 @@=0A=
>  #include <linux/blktrace_api.h>=0A=
>  #include <linux/raid/detect.h>=0A=
>  #include "check.h"=0A=
> +#include "../blk-filter-internal.h"=0A=
>  =0A=
>  static int (*check_part[])(struct parsed_partitions *) =3D {=0A=
>  	/*=0A=
> @@ -320,9 +321,11 @@ int hd_ref_init(struct hd_struct *part)=0A=
>   */=0A=
>  void delete_partition(struct gendisk *disk, struct hd_struct *part)=0A=
>  {=0A=
> -	struct disk_part_tbl *ptbl =3D=0A=
> -		rcu_dereference_protected(disk->part_tbl, 1);=0A=
> +	struct disk_part_tbl *ptbl;=0A=
> +=0A=
> +	blk_filter_part_del(part);=0A=
>  =0A=
> +	ptbl =3D rcu_dereference_protected(disk->part_tbl, 1);=0A=
>  	/*=0A=
>  	 * ->part_tbl is referenced in this part's release handler, so=0A=
>  	 *  we have to hold the disk device=0A=
> @@ -412,6 +415,9 @@ static struct hd_struct *add_partition(struct gendisk=
 *disk, int partno,=0A=
>  	p->nr_sects =3D len;=0A=
>  	p->partno =3D partno;=0A=
>  	p->policy =3D get_disk_ro(disk);=0A=
> +#ifdef CONFIG_BLK_FILTER=0A=
> +	init_rwsem(&p->filter_rw_lockup);=0A=
> +#endif=0A=
>  =0A=
>  	if (info) {=0A=
>  		struct partition_meta_info *pinfo;=0A=
> @@ -469,6 +475,9 @@ static struct hd_struct *add_partition(struct gendisk=
 *disk, int partno,=0A=
>  	/* everything is up and running, commence */=0A=
>  	rcu_assign_pointer(ptbl->part[partno], p);=0A=
>  =0A=
> +	/*inform filter about a new partition*/=0A=
> +	blk_filter_part_add(p, devt);=0A=
> +=0A=
>  	/* suppress uevent if the disk suppresses it */=0A=
>  	if (!dev_get_uevent_suppress(ddev))=0A=
>  		kobject_uevent(&pdev->kobj, KOBJ_ADD);=0A=
> @@ -552,6 +561,7 @@ int bdev_del_partition(struct block_device *bdev, int=
 partno)=0A=
>  		goto out_unlock;=0A=
>  =0A=
>  	sync_blockdev(bdevp);=0A=
> +=0A=
>  	invalidate_bdev(bdevp);=0A=
>  =0A=
>  	delete_partition(bdev->bd_disk, part);=0A=
> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
> index 8ae833e00443..431eae17fd8f 100644=0A=
> --- a/fs/block_dev.c=0A=
> +++ b/fs/block_dev.c=0A=
> @@ -237,7 +237,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct =
iov_iter *iter,=0A=
>  	if (iocb->ki_flags & IOCB_HIPRI)=0A=
>  		bio_set_polled(&bio, iocb);=0A=
>  =0A=
> -	qc =3D submit_bio(&bio);=0A=
> +	qc =3D submit_bio_direct(&bio);=0A=
>  	for (;;) {=0A=
>  		set_current_state(TASK_UNINTERRUPTIBLE);=0A=
>  		if (!READ_ONCE(bio.bi_private))=0A=
> @@ -400,7 +400,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  				polled =3D true;=0A=
>  			}=0A=
>  =0A=
> -			qc =3D submit_bio(bio);=0A=
> +			qc =3D submit_bio_direct(bio);=0A=
>  =0A=
>  			if (polled)=0A=
>  				WRITE_ONCE(iocb->ki_cookie, qc);=0A=
> @@ -421,7 +421,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_ite=
r *iter, int nr_pages)=0A=
>  			atomic_inc(&dio->ref);=0A=
>  		}=0A=
>  =0A=
> -		submit_bio(bio);=0A=
> +		submit_bio_direct(bio);=0A=
>  		bio =3D bio_alloc(GFP_KERNEL, nr_pages);=0A=
>  	}=0A=
>  =0A=
> diff --git a/fs/direct-io.c b/fs/direct-io.c=0A=
> index 183299892465..d9bb1b6f6814 100644=0A=
> --- a/fs/direct-io.c=0A=
> +++ b/fs/direct-io.c=0A=
> @@ -459,7 +459,7 @@ static inline void dio_bio_submit(struct dio *dio, st=
ruct dio_submit *sdio)=0A=
>  		sdio->submit_io(bio, dio->inode, sdio->logical_offset_in_bio);=0A=
>  		dio->bio_cookie =3D BLK_QC_T_NONE;=0A=
>  	} else=0A=
> -		dio->bio_cookie =3D submit_bio(bio);=0A=
> +		dio->bio_cookie =3D submit_bio_direct(bio);=0A=
=0A=
All these changes are unnecessary if you reverse things: submit_bio() is ke=
pt as=0A=
the direct version (as today) and you use a "submit_bio_filtered()" where n=
eeded.=0A=
=0A=
>  =0A=
>  	sdio->bio =3D NULL;=0A=
>  	sdio->boundary =3D 0;=0A=
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c=0A=
> index c1aafb2ab990..e05f20ce8b5f 100644=0A=
> --- a/fs/iomap/direct-io.c=0A=
> +++ b/fs/iomap/direct-io.c=0A=
> @@ -73,7 +73,7 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio,=
 struct iomap *iomap,=0A=
>  				file_inode(dio->iocb->ki_filp),=0A=
>  				iomap, bio, pos);=0A=
>  	else=0A=
> -		dio->submit.cookie =3D submit_bio(bio);=0A=
> +		dio->submit.cookie =3D submit_bio_direct(bio);=0A=
>  }=0A=
>  =0A=
>  static ssize_t iomap_dio_complete(struct iomap_dio *dio)=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index c6d765382926..5b0a32697207 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -10,6 +10,7 @@=0A=
>  #include <linux/ioprio.h>=0A=
>  /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */=0A=
>  #include <linux/blk_types.h>=0A=
> +#include <linux/blk-filter.h>=0A=
>  =0A=
>  #define BIO_DEBUG=0A=
>  =0A=
> @@ -411,7 +412,8 @@ static inline struct bio *bio_kmalloc(gfp_t gfp_mask,=
 unsigned int nr_iovecs)=0A=
>  	return bio_alloc_bioset(gfp_mask, nr_iovecs, NULL);=0A=
>  }=0A=
>  =0A=
> -extern blk_qc_t submit_bio(struct bio *);=0A=
> +extern blk_qc_t submit_bio_direct(struct bio *bio);=0A=
> +extern void submit_bio(struct bio *bio);=0A=
>  =0A=
>  extern void bio_endio(struct bio *);=0A=
>  =0A=
> diff --git a/include/linux/blk-filter.h b/include/linux/blk-filter.h=0A=
> new file mode 100644=0A=
> index 000000000000..f3e79e5b4586=0A=
> --- /dev/null=0A=
> +++ b/include/linux/blk-filter.h=0A=
> @@ -0,0 +1,76 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +=0A=
> +/*=0A=
> + * API declarations for kernel modules utilizing block device filters=0A=
> + */=0A=
> +=0A=
> +#ifndef BLK_FILTER_H=0A=
> +#define BLK_FILTER_H=0A=
> +=0A=
> +#ifdef CONFIG_BLK_FILTER=0A=
> +#include <linux/kref.h>=0A=
> +=0A=
> +struct blk_filter_ops {=0A=
> +	/*=0A=
> +	 * Intercept bio callback.=0A=
> +	 *=0A=
> +	 * Returns true if the request was intercepted and placed in the=0A=
> +	 * queue for processing. Otherwise submit_bio_direct() calling=0A=
> +	 * needed.=0A=
> +	 */=0A=
> +	bool (*filter_bio)(struct bio *bio, void *filter_data);=0A=
> +=0A=
> +	/*=0A=
> +	 * Callback to a request to add block device to the filter.=0A=
> +	 *=0A=
> +	 * Returns true if the block device will be filtered.=0A=
> +	 * p_filter_data gets a pointer to data that is unique to=0A=
> +	 * this device.=0A=
> +	 */=0A=
> +	bool (*part_add)(dev_t devt, void **p_filter_data);=0A=
> +=0A=
> +	/*=0A=
> +	 * Callback to remove block device from the filter.=0A=
> +	 */=0A=
> +	void (*part_del)(void *filter_data);=0A=
> +};=0A=
> +=0A=
> +struct blk_filter {=0A=
> +	struct list_head link;=0A=
> +	struct kref kref;=0A=
> +	struct blk_filter_ops *ops;=0A=
> +};=0A=
> +=0A=
> +/*=0A=
> + * Register/unregister device to filter=0A=
> + */=0A=
> +void *blk_filter_register(struct blk_filter_ops *ops);=0A=
> +=0A=
> +void blk_filter_unregister(void *filter);=0A=
> +=0A=
> +/*=0A=
> + * Attach/detach device to filter=0A=
> + */=0A=
> +int blk_filter_attach(dev_t devt, void *filter, void *filter_data);=0A=
> +=0A=
> +void blk_filter_detach(dev_t devt);=0A=
> +=0A=
> +/*=0A=
> + * For a consistent state of the file system use the freeze_bdev/thaw_bd=
av.=0A=
> + * But in addition, to ensure that the filter is not in the state of=0A=
> + * intercepting the next BIO, you need to call black_filter_freeze/blk_f=
ilter_thaw.=0A=
> + * This is especially actual if there is no file system on the disk.=0A=
> + */=0A=
> +=0A=
> +void blk_filter_freeze(struct block_device *bdev);=0A=
> +=0A=
> +void blk_filter_thaw(struct block_device *bdev);=0A=
> +=0A=
> +/*=0A=
> + * Filters intercept function=0A=
> + */=0A=
> +void blk_filter_submit_bio(struct bio *bio);=0A=
> +=0A=
> +#endif /* CONFIG_BLK_FILTER */=0A=
> +=0A=
> +#endif=0A=
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h=0A=
> index 4ab853461dff..514fab6b947e 100644=0A=
> --- a/include/linux/genhd.h=0A=
> +++ b/include/linux/genhd.h=0A=
> @@ -4,7 +4,7 @@=0A=
>  =0A=
>  /*=0A=
>   * 	genhd.h Copyright (C) 1992 Drew Eckhardt=0A=
> - *	Generic hard disk header file by  =0A=
> + *	Generic hard disk header file by=0A=
>   * 		Drew Eckhardt=0A=
>   *=0A=
>   *		<drew@colorado.edu>=0A=
> @@ -75,6 +75,12 @@ struct hd_struct {=0A=
>  	int make_it_fail;=0A=
>  #endif=0A=
>  	struct rcu_work rcu_work;=0A=
> +=0A=
> +#ifdef CONFIG_BLK_FILTER=0A=
> +	struct rw_semaphore filter_rw_lockup; /* for freezing block device*/=0A=
> +	struct blk_filter *filter; /* block layer filter*/=0A=
> +	void *filter_data; /*specific for each block device filters data*/=0A=
> +#endif=0A=
>  };=0A=
>  =0A=
>  /**=0A=
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c=0A=
> index 01e2858b5fe3..5287346b87a1 100644=0A=
> --- a/kernel/power/swap.c=0A=
> +++ b/kernel/power/swap.c=0A=
> @@ -283,7 +283,7 @@ static int hib_submit_io(int op, int op_flags, pgoff_=
t page_off, void *addr,=0A=
>  		bio->bi_end_io =3D hib_end_io;=0A=
>  		bio->bi_private =3D hb;=0A=
>  		atomic_inc(&hb->count);=0A=
> -		submit_bio(bio);=0A=
> +		submit_bio_direct(bio);=0A=
>  	} else {=0A=
>  		error =3D submit_bio_wait(bio);=0A=
>  		bio_put(bio);=0A=
> diff --git a/mm/page_io.c b/mm/page_io.c=0A=
> index e485a6e8a6cd..4540426400b3 100644=0A=
> --- a/mm/page_io.c=0A=
> +++ b/mm/page_io.c=0A=
> @@ -362,7 +362,7 @@ int __swap_writepage(struct page *page, struct writeb=
ack_control *wbc,=0A=
>  	count_swpout_vm_event(page);=0A=
>  	set_page_writeback(page);=0A=
>  	unlock_page(page);=0A=
> -	submit_bio(bio);=0A=
> +	submit_bio_direct(bio);=0A=
>  out:=0A=
>  	return ret;=0A=
>  }=0A=
> @@ -434,7 +434,7 @@ int swap_readpage(struct page *page, bool synchronous=
)=0A=
>  	}=0A=
>  	count_vm_event(PSWPIN);=0A=
>  	bio_get(bio);=0A=
> -	qc =3D submit_bio(bio);=0A=
> +	qc =3D submit_bio_direct(bio);=0A=
>  	while (synchronous) {=0A=
>  		set_current_state(TASK_UNINTERRUPTIBLE);=0A=
>  		if (!READ_ONCE(bio->bi_private))=0A=
> =0A=
=0A=
Separate into multiple patches: one that introduces the filter functions/op=
s=0A=
code and another that changes the block layer where needed.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
