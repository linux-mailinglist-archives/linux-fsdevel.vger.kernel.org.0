Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C4305142
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 05:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbhA0EqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 23:46:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48860 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhA0DHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 22:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611716835; x=1643252835;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+Lfrq6bKPUIRhGQ2GsAlHKL+EYR3sq3xdJgGi107m6Q=;
  b=lW2KdoTPi4dvn/e53vqjCgJRuXkFJKp6ZpJJv5AkRZIavst/7Xv0aBzT
   EmGWu3OW+IQBtisSsHSOCSlrO2phT10ladZ9ric+AMNS5z9BlN3mexccF
   u6NNQlvQ6+2jeNEfipbAqF6wUb3k3OGwtezsjJVqPAVaO914mhiJ/wUq+
   dltBgw8lS2eMvsXwdWDnf5SzRaCPG82s7km9fmgbFL+Ih4V7HkENIC0we
   j8lQ7NhLRqzFzVRwhk/BIzJebypPBmB985NDImoPfIo2cq5OWZKn6YT51
   kp3B45vX2tW6TeoOq85MjiCLy6jsu2+x8lXIkLAV3FoXM0QAW1QoIpl/n
   A==;
IronPort-SDR: bOd17N/krdsCn1uTJcVtgvfLZAqj6xtpDQZTxDP/D4yljYGiHED5H+UCDQLD5OKr+XI0sdRq8Q
 2z6ROXzlpDk8lryZRXKMrQ1rsTcd7BFDXz6EmAw7d9D70dMCxmIuhracA74+J75b/eMHkX3Adg
 Kd0xlrSTvlw0Oc7zAPb5O3j3XPcFOIBpNkvH6QcO3t5P/hHcpSccSkGcDtUAis0xBnM6KFRqFR
 6GlvscIf/dbH8jQ92JkaMnsWra0iAKx9J3PEDQs6NttoTLfOviUan5eYJNexNShdqNFAzgsbdg
 hNE=
X-IronPort-AV: E=Sophos;i="5.79,378,1602518400"; 
   d="scan'208";a="158407335"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 10:29:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LufwbBSCRTqXvlXjMridfkJzFslm9YWc7BOPpyydXtV+Wk1qzTb1WvIrOfDVCuHh5OIIC6pwI4I82Byv/DHnasawBDLjvAswlb4Vf3i5USn6PPKPjXUoVTcdvS8/a2A/FVir7B+RH0m9ICUS+uCRsA+40eYwDziFiGCRBsPkIgxToGANn0zYlM3yCaA3pscWrXJw/tbw22fYVbhl45kgqsCwyprQTduoc3oIdHxaAd2Sbj91l/qWFlZv61ibQwnSwed6W8XuwTpWXZHs3Y8Wmg2WNJml3KzO1DboVPGMLO02oP4EtrxjUKIJ9t19coc/Xuhb9CYzqrcvvRKMr1TcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmxY+crs2Kg33Ra/1PNKx7/EXEDwlX8f87cnaJnIePw=;
 b=ixYjWlhwD2cBgi8MhFs4ZccIDJXtV7ZlTORvw3JzElhdN/sN/1DT8efQBkgWpX0tb1anJZ71jl6dfzOM7lMW7kGGbHi1YLLr4VXDimjNbSJZfS67kinzs80f9sceWywepb8yBqWHfeqc/Lryk38aKA+5LCYfUXzQ/6uDM6HfanYZcm0evRm7gQ7lsa7KOmnLwCbreqUJV/IGCncYOvcVrIdH++xbaNeBB5hLrs8cS9kCS6CSZD6j1+Rvy2qdva5PIamL5UN5mwOS/eYQMIskL6KaSyiduefFh6G+D+dcl4x0Td2JbpThs1Zgi3racQ5mpUV2b8iG2Xt3qBTuytpC+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmxY+crs2Kg33Ra/1PNKx7/EXEDwlX8f87cnaJnIePw=;
 b=SCWmdOCLVFP9Km1kOTN2GgUioRdiWsEWOaYJgby+b3Tg1/5LzQLaiURcmh1Ouoy1HxL85Wg2JjOJPeJJLZqd8b697F6BG8ZcGhRqSq6pTJfzmy17EaTsIj114NVa9cKE1tygy7qjkwvCDYrvxhO9MTTPp6/JQFfOE0AhUJ4j+b4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4530.namprd04.prod.outlook.com (2603:10b6:208:4d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Wed, 27 Jan
 2021 02:29:38 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 02:29:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: add tracepoints for file operations
Thread-Topic: [PATCH] zonefs: add tracepoints for file operations
Thread-Index: AQHW9CDXoKv2mAVjwUeHLK4ckyExyw==
Date:   Wed, 27 Jan 2021 02:29:38 +0000
Message-ID: <BL0PR04MB6514E76332BF7874540E884CE7BB9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <7395c37618a567d71adc14951658007bc985d072.1611692445.git.johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:59be:e05f:a0a7:a46c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 80761844-11be-4a2a-4e8d-08d8c26b64fb
x-ms-traffictypediagnostic: BL0PR04MB4530:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB453034E7D07BBF9FC1EB4F05E7BB9@BL0PR04MB4530.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J3iLKv1lyONKNSnKqZQdQbg+hUxh+GyV6t49d3dtZSkmGFX9GGhsffTrioW/5LAWfvmVhENuK8CYtHM8pSkmm9JRlthDfZ2wOftifgP0VwBObsfcl4rUTShBwrpCQODaVSPaQyj8CJ00Hf3M8NcvybG/EhLKe2hOcoMAURWJE+p4CT+UjFrarl8dd24oMcpsP2ygDoBL6gviXknyJtrXiwBfT2mN5tKBayhMLVex1Y0YhzebZQybEalAbPa0vZcDmxKIfoh0OGnkVjuxtOfT0+mhtMO0XIvCyRZOhU8MhiXoheR2ELaQPOgJhcZzCzzd2Y/nefeKO+jmV86fV721DZxHMBnyvaX6ioWUO5/ynyZ0K/PW7oWlO6ioXNgmLRLn+jc2KtNOXnFWsg4d649ztwB/o4ClMcUFBwLRwkFgsj3+XAwrIY4+dITYu7GTsP/MfihX4Tvrug+353XZ+pmQdJ0dekmZld9L91d627A1xcaykUHkvZOV/DpMTMyJhu58aTJ33XnED7MKw094yCSK2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(186003)(4326008)(76116006)(5660300002)(91956017)(66946007)(9686003)(71200400001)(53546011)(8936002)(6636002)(478600001)(64756008)(316002)(6862004)(86362001)(55016002)(52536014)(66446008)(2906002)(8676002)(83380400001)(6506007)(33656002)(66556008)(7696005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?O5VBUSm3bEk+1hIJZVBK4FinG9SlV/w6bvsjvfOsLfzXt3i00d2vnyK7iuRG?=
 =?us-ascii?Q?yRY3DW/HexBEYaQ1vilOlak0MbrN8Q5A+GCSOJFrgtgRUTx9meNPRZQymBqR?=
 =?us-ascii?Q?Lgf1IIYAyFs+CN2gPqHix2kXvs7y+wbpoUvXr16YeJVW9DLI2AHB+8YmMGyn?=
 =?us-ascii?Q?u/6xa6tBiwu8ncXt/8uF2tXFxpyC57DOq1Go+5Dj/xzDprESh64gMTLq0RCf?=
 =?us-ascii?Q?jC6QsF1r/nOUaXqU9pLNMbpwQuiOzypBAbGUEWD4AHZRO0VrC+ja3NDQFztY?=
 =?us-ascii?Q?XgAoQYzOQR85Ay6kAcfkKAdTqwjwslTxCcDZFyxM+4lbG4p9o4SX21zXGW4R?=
 =?us-ascii?Q?7zbKP4rerGS2g5q/NVVYeCxUXKPAOIh05yf+L+2oWMjVE9RZeOyexKKOfjIt?=
 =?us-ascii?Q?5S/kpt5VhY3TpdzNknYaKgwXu4fLSU8l3F8R5K6By495CGPnblpdhkZT65aO?=
 =?us-ascii?Q?+oVOcIpqysNfw/LmkcobNAyTmR2EK2X+nC4NoyHaDiAFj1v35+2Kz2J0f7fr?=
 =?us-ascii?Q?YNrdkvaeW5o0M93fQmRzmhQyapFKbyi+h6mpIQ6vpUNxnrqtYt1tYIV4dS9T?=
 =?us-ascii?Q?yDxGyrPld9f2fQX4RgL0J/2oErwrBQIYRWR13BRNcKD/k1g1plplT2uMa7IQ?=
 =?us-ascii?Q?mahwe0nifWHcVmCrIf6/x/zCMye5dl3Whtxzxw/gzrJYsTj0kYB0gztJmkms?=
 =?us-ascii?Q?MqemZ4hylwidDl8/NuEbtuEnZRg8kOiGJSeDDhQP7jZuQ/xKCl4URdnwhdbn?=
 =?us-ascii?Q?NgBYH4V5AZGigeyn00Yqu/vjUHe5UlCAjm7Mrvt0/YyryMleApun1/uupGWy?=
 =?us-ascii?Q?CPUh2EtF0hKJ0QwV5hP5Az4EYRXSrlLVjT/Mz+QbyV49SmT4+oytF/Llai19?=
 =?us-ascii?Q?U4UNM1QgiOEOljMb8FOS6j1sCT/1t2irJjXqikSLbpsr6UczZLP7TFrby1e/?=
 =?us-ascii?Q?AIyRTCgfW8RAAouhBbQ2ZN+GZKnpj8SyIrDZu3TNG1T9LQB8lDKG1imzMzpg?=
 =?us-ascii?Q?RRdXVsrwb582J+klOGKs/GqVhRZYvSG4MIXsxZFRRZmgY36b3c/rpQjHh5Vi?=
 =?us-ascii?Q?1ABQVq23h6KSoXUT0FgUXIdfLi6+Bju6qSgSqGAkvYy12psH2py7YSGdFIvX?=
 =?us-ascii?Q?bmZnVMTKUAShCvqSgztWKcArChJjpdU6RA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80761844-11be-4a2a-4e8d-08d8c26b64fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 02:29:38.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPNBiM1jUjD+O3ob53gZPr+zf/0pUQSiUp4IP0m++3LvnmqOaH6is2Gy9oQJiPf5tKzJxW/Q+6qx/qcViNnTmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4530
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/27 5:21, Johannes Thumshirn wrote:=0A=
> Add tracepoints for file I/O operations to aid in debugging of I/O errors=
=0A=
> with zonefs.=0A=
> =0A=
> The added tracepoints are in:=0A=
> - zonefs_zone_mgmt() for tracing zone management operations=0A=
> - zonefs_iomap_begin() for tracing regular file I/O=0A=
> - zonefs_file_dio_append() for tracing zone-append operations=0A=
> =0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  fs/zonefs/Makefile |   2 +=0A=
>  fs/zonefs/super.c  |   7 +++=0A=
>  fs/zonefs/trace.h  | 103 +++++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  3 files changed, 112 insertions(+)=0A=
>  create mode 100644 fs/zonefs/trace.h=0A=
> =0A=
> diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile=0A=
> index 75a380aa1ae1..33c1a4f1132e 100644=0A=
> --- a/fs/zonefs/Makefile=0A=
> +++ b/fs/zonefs/Makefile=0A=
> @@ -1,4 +1,6 @@=0A=
>  # SPDX-License-Identifier: GPL-2.0=0A=
> +ccflags-y				+=3D -I$(src)=0A=
> +=0A=
>  obj-$(CONFIG_ZONEFS_FS) +=3D zonefs.o=0A=
>  =0A=
>  zonefs-y	:=3D super.o=0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index bec47f2d074b..96f0cb0c29aa 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -24,6 +24,9 @@=0A=
>  =0A=
>  #include "zonefs.h"=0A=
>  =0A=
> +#define CREATE_TRACE_POINTS=0A=
> +#include "trace.h"=0A=
> +=0A=
>  static inline int zonefs_zone_mgmt(struct inode *inode,=0A=
>  				   enum req_opf op)=0A=
>  {=0A=
> @@ -32,6 +35,7 @@ static inline int zonefs_zone_mgmt(struct inode *inode,=
=0A=
>  =0A=
>  	lockdep_assert_held(&zi->i_truncate_mutex);=0A=
>  =0A=
> +	trace_zonefs_zone_mgmt(inode, op);=0A=
>  	ret =3D blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,=0A=
>  			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);=0A=
>  	if (ret) {=0A=
> @@ -100,6 +104,8 @@ static int zonefs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,=0A=
>  	iomap->bdev =3D inode->i_sb->s_bdev;=0A=
>  	iomap->addr =3D (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;=0A=
>  =0A=
> +	trace_zonefs_iomap_begin(inode, iomap);=0A=
> +=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> @@ -703,6 +709,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *i=
ocb, struct iov_iter *from)=0A=
>  	ret =3D submit_bio_wait(bio);=0A=
>  =0A=
>  	zonefs_file_write_dio_end_io(iocb, size, ret, 0);=0A=
> +	trace_zonefs_file_dio_append(inode, size, ret);=0A=
>  =0A=
>  out_release:=0A=
>  	bio_release_pages(bio, false);=0A=
> diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h=0A=
> new file mode 100644=0A=
> index 000000000000..d86f66c28e50=0A=
> --- /dev/null=0A=
> +++ b/fs/zonefs/trace.h=0A=
> @@ -0,0 +1,103 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +/*=0A=
> + * zonefs filesystem driver tracepoints.=0A=
> + *=0A=
> + * Copyright (C) 2020 Western Digital Corporation or its affiliates.=0A=
=0A=
2021 :)=0A=
=0A=
> + */=0A=
> +=0A=
> +#undef TRACE_SYSTEM=0A=
> +#define TRACE_SYSTEM zonefs=0A=
> +=0A=
> +#if !defined(_TRACE_ZONEFS_H) || defined(TRACE_HEADER_MULTI_READ)=0A=
> +#define _TRACE_ZONEFS_H=0A=
> +=0A=
> +#include <linux/tracepoint.h>=0A=
> +#include <linux/trace_seq.h>=0A=
> +#include <linux/blkdev.h>=0A=
> +=0A=
> +#include "zonefs.h"=0A=
> +=0A=
> +#define show_dev(dev) MAJOR(dev), MINOR(dev)=0A=
> +=0A=
> +TRACE_EVENT(zonefs_zone_mgmt,=0A=
> +	    TP_PROTO(struct inode *inode, enum req_opf op),=0A=
> +	    TP_ARGS(inode, op),=0A=
> +	    TP_STRUCT__entry(=0A=
> +			     __field(dev_t, dev)=0A=
> +			     __field(ino_t, ino)=0A=
> +			     __field(int, op)=0A=
> +			     __field(sector_t, sector)=0A=
> +			     __field(sector_t, nr_sectors)=0A=
> +	    ),=0A=
> +	    TP_fast_assign(=0A=
> +			   __entry->dev =3D inode->i_sb->s_dev;=0A=
> +			   __entry->ino =3D inode->i_ino;=0A=
> +			   __entry->op =3D op;=0A=
> +			   __entry->sector =3D ZONEFS_I(inode)->i_zsector;=0A=
> +			   __entry->nr_sectors =3D=0A=
> +				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;=0A=
> +	    ),=0A=
> +	    TP_printk("bdev=3D(%d,%d), ino=3D%lu op=3D%s, sector=3D%llu, nr_sec=
tors=3D%llu",=0A=
> +		      show_dev(__entry->dev), __entry->ino,=0A=
> +		      blk_op_str(__entry->op), __entry->sector,=0A=
> +		      __entry->nr_sectors=0A=
> +	    )=0A=
> +);=0A=
> +=0A=
> +TRACE_EVENT(zonefs_file_dio_append,=0A=
> +	    TP_PROTO(struct inode *inode, ssize_t size, ssize_t ret),=0A=
> +	    TP_ARGS(inode, size, ret),=0A=
> +	    TP_STRUCT__entry(=0A=
> +			     __field(dev_t, dev)=0A=
> +			     __field(ino_t, ino)=0A=
> +			     __field(sector_t, sector)=0A=
> +			     __field(ssize_t, size)=0A=
> +			     __field(loff_t, wpoffset)=0A=
> +			     __field(ssize_t, ret)=0A=
> +	    ),=0A=
> +	    TP_fast_assign(=0A=
> +			   __entry->dev =3D inode->i_sb->s_dev;=0A=
> +			   __entry->ino =3D inode->i_ino;=0A=
> +			   __entry->sector =3D ZONEFS_I(inode)->i_zsector;=0A=
> +			   __entry->size =3D size;=0A=
> +			   __entry->wpoffset =3D ZONEFS_I(inode)->i_wpoffset;=0A=
> +			   __entry->ret =3D ret;=0A=
> +	    ),=0A=
> +	    TP_printk("bdev=3D(%d, %d), ino=3D%lu, sector=3D%llu, size=3D%zu, w=
poffset=3D%llu, ret=3D%zu",=0A=
> +		      show_dev(__entry->dev), __entry->ino, __entry->sector,=0A=
> +		      __entry->size, __entry->wpoffset, __entry->ret=0A=
> +	    )=0A=
> +);=0A=
> +=0A=
> +TRACE_EVENT(zonefs_iomap_begin,=0A=
> +	    TP_PROTO(struct inode *inode, struct iomap *iomap),=0A=
> +	    TP_ARGS(inode, iomap),=0A=
> +	    TP_STRUCT__entry(=0A=
> +			     __field(dev_t, dev)=0A=
> +			     __field(ino_t, ino)=0A=
> +			     __field(u64, addr)=0A=
> +			     __field(loff_t, offset)=0A=
> +			     __field(u64, length)=0A=
> +	    ),=0A=
> +	    TP_fast_assign(=0A=
> +			   __entry->dev =3D inode->i_sb->s_dev;=0A=
> +			   __entry->ino =3D inode->i_ino;=0A=
> +			   __entry->addr =3D iomap->addr;=0A=
> +			   __entry->offset =3D iomap->offset;=0A=
> +			   __entry->length =3D iomap->length;=0A=
> +	    ),=0A=
> +	    TP_printk("bdev=3D(%d,%d), ino=3D%lu, addr=3D%llu, offset=3D%llu, l=
ength=3D%llu",=0A=
> +		      show_dev(__entry->dev), __entry->ino, __entry->addr,=0A=
> +		      __entry->offset, __entry->length=0A=
> +	    )=0A=
> +);=0A=
> +=0A=
> +#endif /* _TRACE_ZONEFS_H */=0A=
> +=0A=
> +#undef TRACE_INCLUDE_PATH=0A=
> +#define TRACE_INCLUDE_PATH .=0A=
> +#undef TRACE_INCLUDE_FILE=0A=
> +#define TRACE_INCLUDE_FILE trace=0A=
> +=0A=
> +/* This part must be outside protection */=0A=
> +#include <trace/define_trace.h>=0A=
> =0A=
=0A=
Looks good to me. I will fix the Copyright date when applying.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
