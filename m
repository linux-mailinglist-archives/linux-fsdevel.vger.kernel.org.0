Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2938F3203BA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 06:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhBTFAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Feb 2021 00:00:21 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36409 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhBTFAR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Feb 2021 00:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613797214; x=1645333214;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AsOXh9VcdJqytY3nu0opwXKfAdknCy9wxxLsTIVM8I4=;
  b=ZsvFupsqNERFF6yjVWpqw0kvxzdutGw47bbAnSVOCTkGCVUZ3iPKepIp
   BLXWogiw8w+oDwwflhTpj5dLgrbHxmCCbmdQyCnYebIFEjXBdowBzJ7/2
   kILeUT/8JXYPuWEcLemDf3yLKg1FrRxxQcg5s/k/MLKT+/ULUidSGpWkK
   Vnixlsb9VRZHHR5dt3/3BufX/Ujf4lsYKHv7QEWgSfJQ8h4io4F5o4qiu
   bHTRebKLb0OrLHdwc0LvgHXyI7HCnuCh3CVFWPCw+uUQK8Ltx3vZFNOvH
   nQuShjN5dANk7jCU5I1eFX1XNWBTz3FbWKmibw3RIELYPLNl+lGWjA3UT
   g==;
IronPort-SDR: +ZI/tnOzTXSFCLXHOrRkszhBjnLedQ9YD1Xh6WroEjhpUqpIfdyTTjvfzd/WcQ3OeK+nRxwK6J
 U5R8K9s6OTpBDBV4nMaJMxNmVQE+D8FmdL425RwdkvNZ9RYfp4EspIFHI3zYA+YefwIlrvTlbD
 Zq460g+dWfpnnOxa3kAf2IYqdvMKiPlLcFf3ufB9qwDeS2NljhPcU0k1f3Pw34onYG6XFHg2Z8
 cR8fqCwwbWtfZZ5wlgNO750Ys3Y/dgOHHAn/ZS+KUmHN3h0oO/7xmiNlWS4qk6SFRP8YKqjWxo
 sq8=
X-IronPort-AV: E=Sophos;i="5.81,192,1610380800"; 
   d="scan'208";a="160387174"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2021 12:59:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giktCt46pnV4XlX0FhuKu26jYScjk9Su4SQsfT9i7tSBMERU3t3Kglv3Mtu7miZdmhdn73AhABRzZoClXhpQVcBEy2t359iGR0H6aZsxPn5p1U+D8Lh2iKeWUHdLz3hdW/qICyAzxCSfvuNj9NwU2rTJ6vIvRhF2vXfRdG+Rb5qmu7ipGk9okUR3dNZ5ZDRNAA6SYH8U5oMkt9Fvg4YbU4mjNPfbIFtf3bQCLU+fpwSgDzLvHg1TMrJw+BB9OoA+k2qXLlOhaDanlqFKj6O0EEldwt/coCvGyEmjGqCQyb9IA7bq4Brv72tfr1Jg7Hu7i7fdgNw+tEat8qEj5JRhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K23pIem2bWd0e+PJFN/EThlyAwcD/2HLJal4ZzUEeLY=;
 b=SxSOaaZ9iOh+LpbADbOtRIczGS5RaBBjmRjGBQfr6EjTeCt64IK4Rlm4H5VHgSJa7dbU1Iy+ezVCXbYanQyPxMlErdAjdwrrrawL3YwqE86D9UDpJYSTbc9/zoI0zsKldTFCiNe83ieXa1VtXvylwOUiO/DyNBVDSH7vnnn1nr3+DxBpyini+0sy/xBDcSl84RTNWQlbCY9C3pGeGIdlCVqqlCgdlGwSqj16fcpKZnjYObGUiXscuDT4/UG0n2GGNzlorE1ks+ojy5BkrqH79JNwdcrfvSAi61XSKna0qe6ZNHkqH1MJzVC2fE1SVWrkOX4+HZA90WLWrURgFkaHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K23pIem2bWd0e+PJFN/EThlyAwcD/2HLJal4ZzUEeLY=;
 b=dr/b/D3Ewq4c+J0YHoT1LB9qgW4f4XBpHjCeqcFS3MJ7ajd0MGygko5Ju3Pkq4btcbd1uV7kPTyraTMv/bEc+Uy3exJ1awaMwXCsPQhr2uduu7Tk+N65GeAVXZ6Ol8989ANv6w9yDdbvYxh5xwiHCBKIxUHpQ61YsKjYuNHdkBc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6596.namprd04.prod.outlook.com (2603:10b6:208:1cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sat, 20 Feb
 2021 04:59:05 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Sat, 20 Feb 2021
 04:59:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "selvajove@gmail.com" <selvajove@gmail.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Topic: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Index: AQHXByxWhY0q9dGq/EW9B8B+rRJ+Hw==
Date:   Sat, 20 Feb 2021 04:59:05 +0000
Message-ID: <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8564:8d20:cd78:c10b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5babe2b-4586-438c-e8bf-08d8d55c3f90
x-ms-traffictypediagnostic: BL0PR04MB6596:
x-microsoft-antispam-prvs: <BL0PR04MB659656E0EF6A1CDE80666073E7839@BL0PR04MB6596.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:212;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJGWCLj4DiBFG5CDe5afglJGPqVYJXQjAupO4WfrrrGnz2pSywIfv9mTUfj72QExxlITqjWEVc0hcXgBblc3+WEFIdYjmOq7j99Mg+D/c6EHhMmbguCQnANazKDM+qddpHztk6/gIgsBJl7c9Nuf7LXnSvGbyou2BMISTQ5Ocl1LwVIqJiEi74p7YgUUGCuApHNtmIT9WF+1IDrjTHJxFfxavw2CU9zW3VZ+sn4emYR2VgUGTNkdvXvolVctJynez9PGXweyVMJ7SzIxpatv4eol4AlArpMlQLU/Z+qijCHnMRxqdOi2jFLZsMGNur+FJwjAS3tsY4NlrCOOPtTiJ0hVB0mCKoBDiTffV91vakzLzFk001yOUNrGABUi42m66UjBup6GUSkOEUUwq9+HIa8zZhdbDbhbIhaBvz0kEXOE3FrRUZpkVwv+SRZC5hOuqDW5jjO1bhjJ84s3m9RfTMdYKVBRY6zn0iCrfim9ysztDJfg3BWRPExd3PFDaYUYZd2QgLgKXq2CMBNaTZZYsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(66556008)(52536014)(4326008)(478600001)(55016002)(66446008)(186003)(8676002)(64756008)(66476007)(86362001)(33656002)(5660300002)(66946007)(76116006)(54906003)(30864003)(7416002)(71200400001)(7696005)(6506007)(8936002)(110136005)(66574015)(9686003)(316002)(53546011)(83380400001)(91956017)(2906002)(579004)(559001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?t3MoaFVTto4ASbrrzVA5RNp8PswKiwY7TlkBpTLxLYXQDOLnK75M+YR8nY?=
 =?iso-8859-1?Q?SzmFh8AibEW+Sfyq0VM49DTM469OGqpLuwrGRWeFsRZEt0/kwG50mvmn4t?=
 =?iso-8859-1?Q?Mni6s+4RHkZvbBy/QnfOT8n35sMCzivmegno27EUGLuKzkZjcAyMZlTY3o?=
 =?iso-8859-1?Q?BE9ieTxqtM9QTraZ4o0UzEomFsEJ0mBG1hgcoyD+p4mHTlFc9zEM8xxL1w?=
 =?iso-8859-1?Q?/SDv5xdL4+TUeXdf5PUySi3licFImUbqQk+hl22gWXpQIkAhVYaxksA4+C?=
 =?iso-8859-1?Q?aBx0objpgqEgjCSZ0/NjVizeS376QNpaBUSZG4pfE4TMw8KktXG3bcJwp7?=
 =?iso-8859-1?Q?rVyLCyVUv3w7wGO3aAU8jxeAc17a5h1XUIOmNwkIaLu38FC5B7sl9p1D/Z?=
 =?iso-8859-1?Q?COqUWzUEH6h+HZ01oUmVFO92Z1v/l5tef9HmbkrdhxQc2AI8p2i1/VQa9G?=
 =?iso-8859-1?Q?1J/BevCvksxnq8EIwb8nnULJ7ouwe8EN9OtysFRzurjEW0HEX3u+oTxYsO?=
 =?iso-8859-1?Q?XVf8reU5EYyoKXJUIDUfZILoDlemBplZldcFu85DS7xOcjMiZehs8WmdIX?=
 =?iso-8859-1?Q?q3JL5rsKB1vX/hi+8Uxqu4/SEAIdjupI6g3un6RAF9Mr2zDF0nQ/H8yNxx?=
 =?iso-8859-1?Q?VsfqH96+xP36qKbHIqb1hCaNRw4P8Lgnc/N7AFk1pBMaKEpNGIYXmIAgxK?=
 =?iso-8859-1?Q?fW5gcFxHFTTzYCoZfV7Rf+2I6J1yE1R6jgZ+gfQYnzERwSQHOJWIAR4Z65?=
 =?iso-8859-1?Q?Rpt3wBAHxXAThdoa7NCIYQIyu047gyVOsd+eeSw9j4xKoGsWiQ5uRAG5vZ?=
 =?iso-8859-1?Q?dKIrbQQk2bYVPpPw0yklXtnCgUDeZRS9kh7GTK6fiDiii5Nj4fg99Rq+c6?=
 =?iso-8859-1?Q?n/IR3wKh9kfGyMjcEoWVC9q8ZIoyw95AxAzbkIJdj90xs/PqIBh7fNdQEp?=
 =?iso-8859-1?Q?/Zn0k931pc1ekv0i9fYPqteEHa38DOCq34wW6rO8QW2eJ2BDQf30Jrq8HS?=
 =?iso-8859-1?Q?Qyp59SWtXuwYn2FWvkkNvjcMlvZWCMWUHJBXQmTri741/JwxJb2WRZwM7p?=
 =?iso-8859-1?Q?gn0yt2xq7FUwUloMzqnPi+3MVPjT0Z2STfkwzVdv2w2ecWM88O3CFqRaU+?=
 =?iso-8859-1?Q?slIbTW9mVTnxVQsPqVfpZJOr3eF4IC6sCBKEfiTUuJV7RVZ4UM8d+XyUpb?=
 =?iso-8859-1?Q?PlP6DrLUC+u5W3tobVUjNPsk0NYKSXmkxXVkJg0Oqbgb8f5pSXyuuZyylf?=
 =?iso-8859-1?Q?ou1LEzqYqodiu8VIoRwt6urAJfzSgbxUC1VkfnGctU3c9gJZ8jIcXesiXY?=
 =?iso-8859-1?Q?jbGLnV2hsAmihysCopE4OkJi+5qMbDyFYfEV9OJYhb9Or5jQZDN+wK9tTv?=
 =?iso-8859-1?Q?idkJpGN/nDxi7SuDiRBHlc8zr62LXMeW0L+7aat1LbImkcBG75eIdBj1CS?=
 =?iso-8859-1?Q?AxaFoXdLVoGiSD6G/Pfk2GhhK1Ft/opuajLgUA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5babe2b-4586-438c-e8bf-08d8d55c3f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2021 04:59:05.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMIKy0SE062u2yGnIACGuF7f1lb89/pAGx49OIE2J5dWf8Ydv8X6L4nnNB7GGPsUEYC1CiPhQeGiRr4Zz9uMCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6596
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/20 11:01, SelvaKumar S wrote:=0A=
> Add new BLKCOPY ioctl that offloads copying of one or more sources=0A=
> ranges to a destination in the device. Accepts a 'copy_range' structure=
=0A=
> that contains destination (in sectors), no of sources and pointer to the=
=0A=
> array of source ranges. Each source range is represented by 'range_entry'=
=0A=
> that contains start and length of source ranges (in sectors).=0A=
> =0A=
> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create=0A=
> bio with control information as payload and submit to the device.=0A=
> REQ_OP_COPY(19) is a write op and takes zone_write_lock when submitted=0A=
> to zoned device.=0A=
> =0A=
> If the device doesn't support copy or copy offload is disabled, then=0A=
> copy operation is emulated by default. However, the copy-emulation is an=
=0A=
> opt-in feature. Caller can choose not to use the copy-emulation by=0A=
> specifying a flag 'BLKDEV_COPY_NOEMULATION'.=0A=
> =0A=
> Copy-emulation is implemented by allocating memory of total copy size.=0A=
> The source ranges are read into memory by chaining bio for each source=0A=
> ranges and submitting them async and the last bio waits for completion.=
=0A=
> After data is read, it is written to the destination.=0A=
> =0A=
> bio_map_kern() is used to allocate bio and add pages of copy buffer to=0A=
> bio. As bio->bi_private and bio->bi_end_io are needed for chaining the=0A=
> bio and gets over-written, invalidate_kernel_vmap_range() for read is=0A=
> called in the caller.=0A=
> =0A=
> Introduce queue limits for simple copy and other helper functions.=0A=
> Add device limits as sysfs entries.=0A=
> 	- copy_offload=0A=
> 	- max_copy_sectors=0A=
> 	- max_copy_ranges_sectors=0A=
> 	- max_copy_nr_ranges=0A=
> =0A=
> copy_offload(=3D 0) is disabled by default. This needs to be enabled if=
=0A=
> copy-offload needs to be used.=0A=
> max_copy_sectors =3D 0 indicates the device doesn't support native copy.=
=0A=
> =0A=
> Native copy offload is not supported for stacked devices and is done via=
=0A=
> copy emulation.=0A=
> =0A=
> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
> Signed-off-by: Chaitanya Kulkarni <kch@kernel.org>=0A=
> ---=0A=
>  block/blk-core.c          | 102 ++++++++++++++++--=0A=
>  block/blk-lib.c           | 222 ++++++++++++++++++++++++++++++++++++++=
=0A=
>  block/blk-merge.c         |   2 +=0A=
>  block/blk-settings.c      |  10 ++=0A=
>  block/blk-sysfs.c         |  47 ++++++++=0A=
>  block/blk-zoned.c         |   1 +=0A=
>  block/bounce.c            |   1 +=0A=
>  block/ioctl.c             |  33 ++++++=0A=
>  include/linux/bio.h       |   1 +=0A=
>  include/linux/blk_types.h |  14 +++=0A=
>  include/linux/blkdev.h    |  15 +++=0A=
>  include/uapi/linux/fs.h   |  13 +++=0A=
>  12 files changed, 453 insertions(+), 8 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
> index 7663a9b94b80..23e646e5ae43 100644=0A=
> --- a/block/blk-core.c=0A=
> +++ b/block/blk-core.c=0A=
> @@ -720,6 +720,17 @@ static noinline int should_fail_bio(struct bio *bio)=
=0A=
>  }=0A=
>  ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);=0A=
>  =0A=
> +static inline int bio_check_copy_eod(struct bio *bio, sector_t start,=0A=
> +		sector_t nr_sectors, sector_t max_sect)=0A=
> +{=0A=
> +	if (nr_sectors && max_sect &&=0A=
> +	    (nr_sectors > max_sect || start > max_sect - nr_sectors)) {=0A=
> +		handle_bad_sector(bio, max_sect);=0A=
> +		return -EIO;=0A=
> +	}=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Check whether this bio extends beyond the end of the device or partit=
ion.=0A=
>   * This may well happen - the kernel calls bread() without checking the =
size of=0A=
> @@ -738,6 +749,75 @@ static inline int bio_check_eod(struct bio *bio, sec=
tor_t maxsector)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Check for copy limits and remap source ranges if needed.=0A=
> + */=0A=
> +static int blk_check_copy(struct bio *bio)=0A=
> +{=0A=
> +	struct blk_copy_payload *payload =3D bio_data(bio);=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
> +	sector_t max_sect, start_sect, copy_size =3D 0;=0A=
> +	sector_t src_max_sect, src_start_sect;=0A=
> +	struct block_device *bd_part;=0A=
> +	int i, ret =3D -EIO;=0A=
> +=0A=
> +	rcu_read_lock();=0A=
> +=0A=
> +	bd_part =3D __disk_get_part(bio->bi_disk, bio->bi_partno);=0A=
> +	if (unlikely(!bd_part)) {=0A=
> +		rcu_read_unlock();=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	max_sect =3D  bdev_nr_sectors(bd_part);=0A=
> +	start_sect =3D bd_part->bd_start_sect;=0A=
> +=0A=
> +	src_max_sect =3D bdev_nr_sectors(payload->src_bdev);=0A=
> +	src_start_sect =3D payload->src_bdev->bd_start_sect;=0A=
> +=0A=
> +	if (unlikely(should_fail_request(bd_part, bio->bi_iter.bi_size)))=0A=
> +		goto out;=0A=
> +=0A=
> +	if (unlikely(bio_check_ro(bio, bd_part)))=0A=
> +		goto out;=0A=
=0A=
There is no rcu_unlock() in that out label. Did you test ?=0A=
=0A=
> +=0A=
> +	rcu_read_unlock();=0A=
> +=0A=
> +	/* cannot handle copy crossing nr_ranges limit */=0A=
> +	if (payload->copy_nr_ranges > q->limits.max_copy_nr_ranges)=0A=
> +		goto out;=0A=
> +=0A=
> +	for (i =3D 0; i < payload->copy_nr_ranges; i++) {=0A=
> +		ret =3D bio_check_copy_eod(bio, payload->range[i].src,=0A=
> +				payload->range[i].len, src_max_sect);=0A=
> +		if (unlikely(ret))=0A=
> +			goto out;=0A=
> +=0A=
> +		/* single source range length limit */=0A=
> +		if (payload->range[i].len > q->limits.max_copy_range_sectors)=0A=
> +			goto out;=0A=
=0A=
ret is not set. You will return success with this.=0A=
=0A=
> +=0A=
> +		payload->range[i].src +=3D src_start_sect;=0A=
> +		copy_size +=3D payload->range[i].len;=0A=
> +	}=0A=
> +=0A=
> +	/* check if copy length crosses eod */=0A=
> +	ret =3D bio_check_copy_eod(bio, bio->bi_iter.bi_sector,=0A=
> +				copy_size, max_sect);=0A=
> +	if (unlikely(ret))=0A=
> +		goto out;=0A=
> +=0A=
> +	/* cannot handle copy more than copy limits */=0A=
> +	if (copy_size > q->limits.max_copy_sectors)=0A=
> +		goto out;=0A=
=0A=
Again ret is not set... No error return ?=0A=
=0A=
> +=0A=
> +	bio->bi_iter.bi_sector +=3D start_sect;=0A=
> +	bio->bi_partno =3D 0;=0A=
> +	ret =3D 0;=0A=
> +out:=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Remap block n of partition p to block n+start(p) of the disk.=0A=
>   */=0A=
> @@ -827,14 +907,16 @@ static noinline_for_stack bool submit_bio_checks(st=
ruct bio *bio)=0A=
>  	if (should_fail_bio(bio))=0A=
>  		goto end_io;=0A=
>  =0A=
> -	if (bio->bi_partno) {=0A=
> -		if (unlikely(blk_partition_remap(bio)))=0A=
> -			goto end_io;=0A=
> -	} else {=0A=
> -		if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))=0A=
> -			goto end_io;=0A=
> -		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))=0A=
> -			goto end_io;=0A=
> +	if (likely(!op_is_copy(bio->bi_opf))) {=0A=
> +		if (bio->bi_partno) {=0A=
> +			if (unlikely(blk_partition_remap(bio)))=0A=
> +				goto end_io;=0A=
> +		} else {=0A=
> +			if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))=0A=
> +				goto end_io;=0A=
> +			if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))=0A=
> +				goto end_io;=0A=
> +		}=0A=
>  	}=0A=
>  =0A=
>  	/*=0A=
> @@ -858,6 +940,10 @@ static noinline_for_stack bool submit_bio_checks(str=
uct bio *bio)=0A=
>  		if (!blk_queue_discard(q))=0A=
>  			goto not_supported;=0A=
>  		break;=0A=
> +	case REQ_OP_COPY:=0A=
> +		if (unlikely(blk_check_copy(bio)))=0A=
> +			goto end_io;=0A=
> +		break;=0A=
>  	case REQ_OP_SECURE_ERASE:=0A=
>  		if (!blk_queue_secure_erase(q))=0A=
>  			goto not_supported;=0A=
> diff --git a/block/blk-lib.c b/block/blk-lib.c=0A=
> index 752f9c722062..97ba58d8d9a1 100644=0A=
> --- a/block/blk-lib.c=0A=
> +++ b/block/blk-lib.c=0A=
> @@ -150,6 +150,228 @@ int blkdev_issue_discard(struct block_device *bdev,=
 sector_t sector,=0A=
>  }=0A=
>  EXPORT_SYMBOL(blkdev_issue_discard);=0A=
>  =0A=
> +int blk_copy_offload(struct block_device *dest_bdev, struct blk_copy_pay=
load *payload,=0A=
> +		sector_t dest, gfp_t gfp_mask)=0A=
=0A=
Simple copy is only over the same device, right ? So the name "dest_bdev" i=
s a=0A=
little strange.=0A=
=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(dest_bdev);=0A=
> +	struct bio *bio;=0A=
> +	int ret, payload_size;=0A=
> +=0A=
> +	payload_size =3D struct_size(payload, range, payload->copy_nr_ranges);=
=0A=
> +	bio =3D bio_map_kern(q, payload, payload_size, gfp_mask);=0A=
> +	if (IS_ERR(bio)) {=0A=
> +		ret =3D PTR_ERR(bio);=0A=
> +		goto err;=0A=
=0A=
This will do a bio_put() on a non existent bio...=0A=
=0A=
> +	}=0A=
> +=0A=
> +	bio->bi_iter.bi_sector =3D dest;=0A=
> +	bio->bi_opf =3D REQ_OP_COPY | REQ_NOMERGE;=0A=
> +	bio_set_dev(bio, dest_bdev);=0A=
> +=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
> +err:=0A=
> +	bio_put(bio);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +int blk_read_to_buf(struct block_device *src_bdev, struct blk_copy_paylo=
ad *payload,=0A=
> +		gfp_t gfp_mask, sector_t copy_size, void **buf_p)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(src_bdev);=0A=
> +	struct bio *bio, *parent =3D NULL;=0A=
> +	void *buf =3D NULL;=0A=
> +	int copy_len =3D copy_size << SECTOR_SHIFT;=0A=
> +	int i, nr_srcs, ret, cur_size, t_len =3D 0;=0A=
> +	bool is_vmalloc;=0A=
> +=0A=
> +	nr_srcs =3D payload->copy_nr_ranges;=0A=
> +=0A=
> +	buf =3D kvmalloc(copy_len, gfp_mask);=0A=
> +	if (!buf)=0A=
> +		return -ENOMEM;=0A=
> +	is_vmalloc =3D is_vmalloc_addr(buf);=0A=
> +=0A=
> +	for (i =3D 0; i < nr_srcs; i++) {=0A=
> +		cur_size =3D payload->range[i].len << SECTOR_SHIFT;=0A=
> +=0A=
> +		bio =3D bio_map_kern(q, buf + t_len, cur_size, gfp_mask);=0A=
> +		if (IS_ERR(bio)) {=0A=
> +			ret =3D PTR_ERR(bio);=0A=
> +			goto out;=0A=
> +		}=0A=
> +=0A=
> +		bio->bi_iter.bi_sector =3D payload->range[i].src;=0A=
> +		bio->bi_opf =3D REQ_OP_READ;=0A=
> +		bio_set_dev(bio, src_bdev);=0A=
> +		bio->bi_end_io =3D NULL;=0A=
> +		bio->bi_private =3D NULL;=0A=
> +=0A=
> +		if (parent) {=0A=
> +			bio_chain(parent, bio);=0A=
> +			submit_bio(parent);=0A=
> +		}=0A=
> +=0A=
> +		parent =3D bio;=0A=
> +		t_len +=3D cur_size;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
> +	bio_put(bio);=0A=
> +	if (is_vmalloc)=0A=
> +		invalidate_kernel_vmap_range(buf, copy_len);=0A=
=0A=
But blk_write_from_buf() will use the buffer right after this.. Is this rea=
lly OK ?=0A=
=0A=
> +	if (ret)=0A=
> +		goto out;=0A=
> +=0A=
> +	*buf_p =3D buf;=0A=
> +	return 0;=0A=
> +out:=0A=
> +	kvfree(buf);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +int blk_write_from_buf(struct block_device *dest_bdev, void *buf, sector=
_t dest,=0A=
> +		sector_t copy_size, gfp_t gfp_mask)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(dest_bdev);=0A=
> +	struct bio *bio;=0A=
> +	int ret, copy_len =3D copy_size << SECTOR_SHIFT;=0A=
> +=0A=
> +	bio =3D bio_map_kern(q, buf, copy_len, gfp_mask);=0A=
> +	if (IS_ERR(bio)) {=0A=
> +		ret =3D PTR_ERR(bio);=0A=
> +		goto out;=0A=
> +	}=0A=
> +	bio_set_dev(bio, dest_bdev);=0A=
> +	bio->bi_opf =3D REQ_OP_WRITE;=0A=
> +	bio->bi_iter.bi_sector =3D dest;=0A=
> +=0A=
> +	bio->bi_end_io =3D NULL;=0A=
> +	ret =3D submit_bio_wait(bio);=0A=
> +	bio_put(bio);=0A=
> +out:=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +int blk_prepare_payload(struct block_device *src_bdev, int nr_srcs, stru=
ct range_entry *rlist,=0A=
> +		gfp_t gfp_mask, struct blk_copy_payload **payload_p, sector_t *copy_si=
ze)=0A=
> +{=0A=
> +=0A=
> +	struct request_queue *q =3D bdev_get_queue(src_bdev);=0A=
> +	struct blk_copy_payload *payload;=0A=
> +	sector_t bs_mask, total_len =3D 0;=0A=
> +	int i, ret, payload_size;=0A=
> +=0A=
> +	if (!q)=0A=
> +		return -ENXIO;=0A=
> +=0A=
> +	if (!nr_srcs)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	if (bdev_read_only(src_bdev))=0A=
> +		return -EPERM;=0A=
> +=0A=
> +	bs_mask =3D (bdev_logical_block_size(src_bdev) >> 9) - 1;=0A=
> +=0A=
> +	payload_size =3D struct_size(payload, range, nr_srcs);=0A=
> +	payload =3D kmalloc(payload_size, gfp_mask);=0A=
> +	if (!payload)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	for (i =3D 0; i < nr_srcs; i++) {=0A=
> +		if (rlist[i].src & bs_mask || rlist[i].len & bs_mask) {=0A=
> +			ret =3D -EINVAL;=0A=
> +			goto err;=0A=
> +		}=0A=
> +=0A=
> +		payload->range[i].src =3D rlist[i].src;=0A=
> +		payload->range[i].len =3D rlist[i].len;=0A=
> +=0A=
> +		total_len +=3D rlist[i].len;=0A=
> +	}=0A=
> +=0A=
> +	payload->copy_nr_ranges =3D i;=0A=
> +	payload->src_bdev =3D src_bdev;=0A=
> +	*copy_size =3D total_len;=0A=
> +=0A=
> +	*payload_p =3D payload;=0A=
> +	return 0;=0A=
> +err:=0A=
> +	kfree(payload);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +int blk_copy_emulate(struct block_device *src_bdev, struct blk_copy_payl=
oad *payload,=0A=
> +			struct block_device *dest_bdev, sector_t dest,=0A=
> +			sector_t copy_size, gfp_t gfp_mask)=0A=
> +{=0A=
> +	void *buf =3D NULL;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D blk_read_to_buf(src_bdev, payload, gfp_mask, copy_size, &buf);=
=0A=
> +	if (ret)=0A=
> +		goto out;=0A=
> +=0A=
> +	ret =3D blk_write_from_buf(dest_bdev, buf, dest, copy_size, gfp_mask);=
=0A=
> +	if (buf)=0A=
> +		kvfree(buf);=0A=
> +out:=0A=
> +	return ret;=0A=
> +}=0A=
=0A=
I already commented that this should better use the dm-kcopyd design, which=
=0A=
would be far more efficient than this. This will be slow...=0A=
=0A=
Your function blkdev_issue_copy() below should deal only with issuing simpl=
e=0A=
copy (amd later scsi xcopy) for devices that support it. Bring the dm-kcopy=
d=0A=
interface in the block layer as a generic interface for hadling emulation.=
=0A=
Otherwise you are repeating what dm does, but not as efficiently.=0A=
=0A=
> +=0A=
> +/**=0A=
> + * blkdev_issue_copy - queue a copy=0A=
> + * @src_bdev:	source block device=0A=
> + * @nr_srcs:	number of source ranges to copy=0A=
> + * @rlist:	array of source ranges in sector=0A=
> + * @dest_bdev:	destination block device=0A=
> + * @dest:	destination in sector=0A=
> + * @gfp_mask:   memory allocation flags (for bio_alloc)=0A=
> + * @flags:	BLKDEV_COPY_* flags to control behaviour=0A=
> + *=0A=
> + * Description:=0A=
> + *	Copy array of source ranges from source block device to=0A=
> + *	destination block devcie. All source must belong to same bdev and=0A=
> + *	length of a source range cannot be zero.=0A=
> + */=0A=
> +=0A=
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,=0A=
> +		struct range_entry *src_rlist, struct block_device *dest_bdev,=0A=
> +		sector_t dest, gfp_t gfp_mask, int flags)=0A=
> +{=0A=
> +	struct request_queue *q =3D bdev_get_queue(src_bdev);=0A=
> +	struct request_queue *dest_q =3D bdev_get_queue(dest_bdev);=0A=
> +	struct blk_copy_payload *payload;=0A=
> +	sector_t bs_mask, copy_size;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mask,=0A=
> +			&payload, &copy_size);=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
> +=0A=
> +	bs_mask =3D (bdev_logical_block_size(dest_bdev) >> 9) - 1;=0A=
> +	if (dest & bs_mask) {=0A=
> +		return -EINVAL;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	if (q =3D=3D dest_q && q->limits.copy_offload) {=0A=
> +		ret =3D blk_copy_offload(src_bdev, payload, dest, gfp_mask);=0A=
> +		if (ret)=0A=
> +			goto out;=0A=
> +	} else if (flags & BLKDEV_COPY_NOEMULATION) {=0A=
=0A=
Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why would =
that=0A=
user say "Fail on me if the device does not support copy" ??? This is a wei=
rd=0A=
interface in my opinion.=0A=
=0A=
> +		ret =3D -EIO;=0A=
> +		goto out;=0A=
> +	} else=0A=
=0A=
Missing braces. By you do not need all these else after the gotos anyway.=
=0A=
=0A=
> +		ret =3D blk_copy_emulate(src_bdev, payload, dest_bdev, dest,=0A=
> +				copy_size, gfp_mask);=0A=
> +=0A=
> +out:=0A=
> +	kvfree(payload);=0A=
> +	return ret;=0A=
> +}=0A=
> +EXPORT_SYMBOL(blkdev_issue_copy);=0A=
> +=0A=
>  /**=0A=
>   * __blkdev_issue_write_same - generate number of bios with same page=0A=
>   * @bdev:	target blockdev=0A=
> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
> index 808768f6b174..4e04f24e13c1 100644=0A=
> --- a/block/blk-merge.c=0A=
> +++ b/block/blk-merge.c=0A=
> @@ -309,6 +309,8 @@ void __blk_queue_split(struct bio **bio, unsigned int=
 *nr_segs)=0A=
>  	struct bio *split =3D NULL;=0A=
>  =0A=
>  	switch (bio_op(*bio)) {=0A=
> +	case REQ_OP_COPY:=0A=
> +			break;=0A=
=0A=
Why would this even be called ? Copy BIOs cannot be split, right ?=0A=
=0A=
>  	case REQ_OP_DISCARD:=0A=
>  	case REQ_OP_SECURE_ERASE:=0A=
>  		split =3D blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);=0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 43990b1d148b..93c15ba45a69 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -60,6 +60,10 @@ void blk_set_default_limits(struct queue_limits *lim)=
=0A=
>  	lim->io_opt =3D 0;=0A=
>  	lim->misaligned =3D 0;=0A=
>  	lim->zoned =3D BLK_ZONED_NONE;=0A=
> +	lim->copy_offload =3D 0;=0A=
> +	lim->max_copy_sectors =3D 0;=0A=
> +	lim->max_copy_nr_ranges =3D 0;=0A=
> +	lim->max_copy_range_sectors =3D 0;=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_set_default_limits);=0A=
>  =0A=
> @@ -565,6 +569,12 @@ int blk_stack_limits(struct queue_limits *t, struct =
queue_limits *b,=0A=
>  	if (b->chunk_sectors)=0A=
>  		t->chunk_sectors =3D gcd(t->chunk_sectors, b->chunk_sectors);=0A=
>  =0A=
> +	/* simple copy not supported in stacked devices */=0A=
> +	t->copy_offload =3D 0;=0A=
> +	t->max_copy_sectors =3D 0;=0A=
> +	t->max_copy_range_sectors =3D 0;=0A=
> +	t->max_copy_nr_ranges =3D 0;=0A=
=0A=
You do not need this. Limits not explicitely initialized are 0 already.=0A=
But I do not see why you can't support copy on stacked devices. That should=
 be=0A=
feasible taking the min() for each of the above limit.=0A=
=0A=
> +=0A=
>  	/* Physical block size a multiple of the logical block size? */=0A=
>  	if (t->physical_block_size & (t->logical_block_size - 1)) {=0A=
>  		t->physical_block_size =3D t->logical_block_size;=0A=
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
> index b513f1683af0..625a72541263 100644=0A=
> --- a/block/blk-sysfs.c=0A=
> +++ b/block/blk-sysfs.c=0A=
> @@ -166,6 +166,44 @@ static ssize_t queue_discard_granularity_show(struct=
 request_queue *q, char *pag=0A=
>  	return queue_var_show(q->limits.discard_granularity, page);=0A=
>  }=0A=
>  =0A=
> +static ssize_t queue_copy_offload_show(struct request_queue *q, char *pa=
ge)=0A=
> +{=0A=
> +	return queue_var_show(q->limits.copy_offload, page);=0A=
> +}=0A=
> +=0A=
> +static ssize_t queue_copy_offload_store(struct request_queue *q,=0A=
> +				       const char *page, size_t count)=0A=
> +{=0A=
> +	unsigned long copy_offload;=0A=
> +	ssize_t ret =3D queue_var_store(&copy_offload, page, count);=0A=
> +=0A=
> +	if (ret < 0)=0A=
> +		return ret;=0A=
> +=0A=
> +	if (copy_offload && q->limits.max_copy_sectors =3D=3D 0)=0A=
> +		return -EINVAL;=0A=
> +=0A=
> +	q->limits.copy_offload =3D copy_offload;=0A=
> +	return ret;=0A=
> +}=0A=
=0A=
This is weird. If you want to allow a user to disable copy offload, then us=
e=0A=
max_copy_sectors. This one should be read-only and only indicate if the dev=
ice=0A=
supports it or not. I also would actually change this one into=0A=
max_copy_hw_sectors, immutable, indicating the max copy sectors that the de=
vice=0A=
supports, and 0 for no support. That would allow an easy implementation of=
=0A=
max_copy_sectors being red/write for controlling enable/disable.=0A=
=0A=
> +=0A=
> +static ssize_t queue_max_copy_sectors_show(struct request_queue *q, char=
 *page)=0A=
> +{=0A=
> +	return queue_var_show(q->limits.max_copy_sectors, page);=0A=
> +}=0A=
> +=0A=
> +static ssize_t queue_max_copy_range_sectors_show(struct request_queue *q=
,=0A=
> +		char *page)=0A=
> +{=0A=
> +	return queue_var_show(q->limits.max_copy_range_sectors, page);=0A=
> +}=0A=
> +=0A=
> +static ssize_t queue_max_copy_nr_ranges_show(struct request_queue *q,=0A=
> +		char *page)=0A=
> +{=0A=
> +	return queue_var_show(q->limits.max_copy_nr_ranges, page);=0A=
> +}=0A=
> +=0A=
>  static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *=
page)=0A=
>  {=0A=
>  =0A=
> @@ -591,6 +629,11 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");=0A=
>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");=0A=
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");=0A=
>  =0A=
> +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");=0A=
> +QUEUE_RO_ENTRY(queue_max_copy_sectors, "max_copy_sectors");=0A=
> +QUEUE_RO_ENTRY(queue_max_copy_range_sectors, "max_copy_range_sectors");=
=0A=
> +QUEUE_RO_ENTRY(queue_max_copy_nr_ranges, "max_copy_nr_ranges");=0A=
> +=0A=
>  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");=0A=
>  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");=0A=
>  QUEUE_RW_ENTRY(queue_poll, "io_poll");=0A=
> @@ -636,6 +679,10 @@ static struct attribute *queue_attrs[] =3D {=0A=
>  	&queue_discard_max_entry.attr,=0A=
>  	&queue_discard_max_hw_entry.attr,=0A=
>  	&queue_discard_zeroes_data_entry.attr,=0A=
> +	&queue_copy_offload_entry.attr,=0A=
> +	&queue_max_copy_sectors_entry.attr,=0A=
> +	&queue_max_copy_range_sectors_entry.attr,=0A=
> +	&queue_max_copy_nr_ranges_entry.attr,=0A=
>  	&queue_write_same_max_entry.attr,=0A=
>  	&queue_write_zeroes_max_entry.attr,=0A=
>  	&queue_zone_append_max_entry.attr,=0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 7a68b6e4300c..02069178d51e 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -75,6 +75,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)=
=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
>  	case REQ_OP_WRITE_SAME:=0A=
>  	case REQ_OP_WRITE:=0A=
> +	case REQ_OP_COPY:=0A=
>  		return blk_rq_zone_is_seq(rq);=0A=
>  	default:=0A=
>  		return false;=0A=
> diff --git a/block/bounce.c b/block/bounce.c=0A=
> index d3f51acd6e3b..5e052afe8691 100644=0A=
> --- a/block/bounce.c=0A=
> +++ b/block/bounce.c=0A=
> @@ -254,6 +254,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_s=
rc, gfp_t gfp_mask,=0A=
>  	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;=0A=
>  =0A=
>  	switch (bio_op(bio)) {=0A=
> +	case REQ_OP_COPY:=0A=
>  	case REQ_OP_DISCARD:=0A=
>  	case REQ_OP_SECURE_ERASE:=0A=
>  	case REQ_OP_WRITE_ZEROES:=0A=
> diff --git a/block/ioctl.c b/block/ioctl.c=0A=
> index d61d652078f4..0e52181657a4 100644=0A=
> --- a/block/ioctl.c=0A=
> +++ b/block/ioctl.c=0A=
> @@ -133,6 +133,37 @@ static int blk_ioctl_discard(struct block_device *bd=
ev, fmode_t mode,=0A=
>  				    GFP_KERNEL, flags);=0A=
>  }=0A=
>  =0A=
> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,=0A=
> +		unsigned long arg, unsigned long flags)=0A=
> +{=0A=
> +	struct copy_range crange;=0A=
> +	struct range_entry *rlist;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (!(mode & FMODE_WRITE))=0A=
> +		return -EBADF;=0A=
> +=0A=
> +	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))=0A=
> +		return -EFAULT;=0A=
> +=0A=
> +	rlist =3D kmalloc_array(crange.nr_range, sizeof(*rlist),=0A=
> +			GFP_KERNEL);=0A=
> +	if (!rlist)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	if (copy_from_user(rlist, (void __user *)crange.range_list,=0A=
> +				sizeof(*rlist) * crange.nr_range)) {=0A=
> +		ret =3D -EFAULT;=0A=
> +		goto out;=0A=
> +	}=0A=
> +=0A=
> +	ret =3D blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, crange.de=
st,=0A=
> +			GFP_KERNEL, flags);=0A=
> +out:=0A=
> +	kfree(rlist);=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,=0A=
>  		unsigned long arg)=0A=
>  {=0A=
> @@ -458,6 +489,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, fmode_t mode,=0A=
>  	case BLKSECDISCARD:=0A=
>  		return blk_ioctl_discard(bdev, mode, arg,=0A=
>  				BLKDEV_DISCARD_SECURE);=0A=
> +	case BLKCOPY:=0A=
> +		return blk_ioctl_copy(bdev, mode, arg, 0);=0A=
>  	case BLKZEROOUT:=0A=
>  		return blk_ioctl_zeroout(bdev, mode, arg);=0A=
>  	case BLKREPORTZONE:=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index 1edda614f7ce..164313bdfb35 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -71,6 +71,7 @@ static inline bool bio_has_data(struct bio *bio)=0A=
>  static inline bool bio_no_advance_iter(const struct bio *bio)=0A=
>  {=0A=
>  	return bio_op(bio) =3D=3D REQ_OP_DISCARD ||=0A=
> +	       bio_op(bio) =3D=3D REQ_OP_COPY ||=0A=
>  	       bio_op(bio) =3D=3D REQ_OP_SECURE_ERASE ||=0A=
>  	       bio_op(bio) =3D=3D REQ_OP_WRITE_SAME ||=0A=
>  	       bio_op(bio) =3D=3D REQ_OP_WRITE_ZEROES;=0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 866f74261b3b..5a35c02ac0a8 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -380,6 +380,8 @@ enum req_opf {=0A=
>  	REQ_OP_ZONE_RESET	=3D 15,=0A=
>  	/* reset all the zone present on the device */=0A=
>  	REQ_OP_ZONE_RESET_ALL	=3D 17,=0A=
> +	/* copy ranges within device */=0A=
> +	REQ_OP_COPY		=3D 19,=0A=
>  =0A=
>  	/* SCSI passthrough using struct scsi_request */=0A=
>  	REQ_OP_SCSI_IN		=3D 32,=0A=
> @@ -506,6 +508,11 @@ static inline bool op_is_discard(unsigned int op)=0A=
>  	return (op & REQ_OP_MASK) =3D=3D REQ_OP_DISCARD;=0A=
>  }=0A=
>  =0A=
> +static inline bool op_is_copy(unsigned int op)=0A=
> +{=0A=
> +	return (op & REQ_OP_MASK) =3D=3D REQ_OP_COPY;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Check if a bio or request operation is a zone management operation, w=
ith=0A=
>   * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special =
case=0A=
> @@ -565,4 +572,11 @@ struct blk_rq_stat {=0A=
>  	u64 batch;=0A=
>  };=0A=
>  =0A=
> +struct blk_copy_payload {=0A=
> +	sector_t	dest;=0A=
> +	int		copy_nr_ranges;=0A=
> +	struct block_device *src_bdev;=0A=
> +	struct	range_entry	range[];=0A=
> +};=0A=
> +=0A=
>  #endif /* __LINUX_BLK_TYPES_H */=0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 699ace6b25ff..2bb4513d4bb8 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -337,10 +337,14 @@ struct queue_limits {=0A=
>  	unsigned int		max_zone_append_sectors;=0A=
>  	unsigned int		discard_granularity;=0A=
>  	unsigned int		discard_alignment;=0A=
> +	unsigned int		copy_offload;=0A=
> +	unsigned int		max_copy_sectors;=0A=
>  =0A=
>  	unsigned short		max_segments;=0A=
>  	unsigned short		max_integrity_segments;=0A=
>  	unsigned short		max_discard_segments;=0A=
> +	unsigned short		max_copy_range_sectors;=0A=
> +	unsigned short		max_copy_nr_ranges;=0A=
>  =0A=
>  	unsigned char		misaligned;=0A=
>  	unsigned char		discard_misaligned;=0A=
> @@ -621,6 +625,7 @@ struct request_queue {=0A=
>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */=0A=
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active =
*/=0A=
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */=0A=
> +#define QUEUE_FLAG_SIMPLE_COPY	30	/* supports simple copy */=0A=
>  =0A=
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\=0A=
>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\=0A=
> @@ -643,6 +648,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, s=
truct request_queue *q);=0A=
>  #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_fl=
ags)=0A=
>  #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->qu=
eue_flags)=0A=
>  #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_fl=
ags)=0A=
> +#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_SIMPLE_COPY, &(q)->queue_f=
lags)=0A=
>  #define blk_queue_zone_resetall(q)	\=0A=
>  	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)=0A=
>  #define blk_queue_secure_erase(q) \=0A=
> @@ -1069,6 +1075,9 @@ static inline unsigned int blk_queue_get_max_sector=
s(struct request_queue *q,=0A=
>  		return min(q->limits.max_discard_sectors,=0A=
>  			   UINT_MAX >> SECTOR_SHIFT);=0A=
>  =0A=
> +	if (unlikely(op =3D=3D REQ_OP_COPY))=0A=
> +		return q->limits.max_copy_sectors;=0A=
> +=0A=
=0A=
I would agreee with this if a copy BIO was always a single range, but that =
is=0A=
not the case. So I am not sure this makes sense at all.=0A=
=0A=
>  	if (unlikely(op =3D=3D REQ_OP_WRITE_SAME))=0A=
>  		return q->limits.max_write_same_sectors;=0A=
>  =0A=
> @@ -1343,6 +1352,12 @@ extern int __blkdev_issue_discard(struct block_dev=
ice *bdev, sector_t sector,=0A=
>  		sector_t nr_sects, gfp_t gfp_mask, int flags,=0A=
>  		struct bio **biop);=0A=
>  =0A=
> +#define BLKDEV_COPY_NOEMULATION	(1 << 0)	/* do not emulate if copy offlo=
ad not supported */=0A=
> +=0A=
> +extern int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,=
=0A=
> +		struct range_entry *src_rlist, struct block_device *dest_bdev,=0A=
> +		sector_t dest, gfp_t gfp_mask, int flags);=0A=
=0A=
No need for extern.=0A=
=0A=
> +=0A=
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */=0A=
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes =
*/=0A=
>  =0A=
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h=0A=
> index f44eb0a04afd..5cadb176317a 100644=0A=
> --- a/include/uapi/linux/fs.h=0A=
> +++ b/include/uapi/linux/fs.h=0A=
> @@ -64,6 +64,18 @@ struct fstrim_range {=0A=
>  	__u64 minlen;=0A=
>  };=0A=
>  =0A=
> +struct range_entry {=0A=
> +	__u64 src;=0A=
> +	__u64 len;=0A=
> +};=0A=
> +=0A=
> +struct copy_range {=0A=
> +	__u64 dest;=0A=
> +	__u64 nr_range;=0A=
> +	__u64 range_list;=0A=
> +	__u64 rsvd;=0A=
> +};=0A=
> +=0A=
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definit=
ions */=0A=
>  #define FILE_DEDUPE_RANGE_SAME		0=0A=
>  #define FILE_DEDUPE_RANGE_DIFFERS	1=0A=
> @@ -184,6 +196,7 @@ struct fsxattr {=0A=
>  #define BLKSECDISCARD _IO(0x12,125)=0A=
>  #define BLKROTATIONAL _IO(0x12,126)=0A=
>  #define BLKZEROOUT _IO(0x12,127)=0A=
> +#define BLKCOPY _IOWR(0x12, 128, struct copy_range)=0A=
>  /*=0A=
>   * A jump here: 130-131 are reserved for zoned block devices=0A=
>   * (see uapi/linux/blkzoned.h)=0A=
> =0A=
=0A=
Please test your code more thoroughly. It is full of problems that you shou=
ld=0A=
have detected with better testing including RO devices, partitions and erro=
r=0A=
path coverage.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
