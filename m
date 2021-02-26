Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36A5325CA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhBZEpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:45:14 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32599 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhBZEpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314711; x=1645850711;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DrzYSSajXVvpJsNwA7eog2VtvyV1tgWzQ7Vpp14VCcA=;
  b=WgcHgMpdw6y8wZHIQzkx0eIWTf/cbAXafAFKuide7b9Iankz0WAecNKM
   tAzi67G45+wmvk29OFWY7ZxK5W21S7NCuptmPsBUnl19RO4nA81CGTUpR
   GIK2Oed1avSaxUlp0ZAn+odetmDdztPm0nNSFUlgHXQidV9uPZdxhZP4W
   UAlGOKHaKQrhJ0PrYH58/m1VRn/Dw/W4qnOcE4sx08+dESB8wUFm7wMri
   fVyHYrIf/D9eRzGf3owfBwfRzx88LqQp4TY9DYdUn+o7VJjz8m2u9TIuf
   +0CKD17vA+6yMhG8vQxXkgzHm5LESsWig5T07HKcMtA/geWVTeX6hIx/+
   A==;
IronPort-SDR: Z8b/QRs9zRRcavYz1/SS5+2Zln7PuXNAnNrsgZCOCpPQwJ5hLix1ilXBzfOiEvnh7f9r56dZdA
 8UJ8prnnrl1GG2qZOyjf22Y2dTaODqGNeq7/tMfJoFgEOnCWlx86FJmFWM1XwqXfax5UGnolGM
 XNwVdfSOId7bOGjKSDXllnkQymmqXM8NOY2egG1QiesfGHa5BMGh/zs64+75l3D5PDwxe3wqkd
 T5e5i2Yti5wv4IM1qWxGcCXrXJpkgvtipHJx2XokNvqwepCwIwS9bhelFZdsXOhXIGJ8z7K+pS
 AaE=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="160844242"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:44:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fy5UHpqO50uziiJkeR5EY9MUGCDOgF6Q8wC1ofNOBwLKasYjAi079MTLfkTveVFGO7aZlJAE6698Gzxv0OM/kFtLQWGwZ+2sqUkQrxie2ybfxLekFMKDehSAT+J2JUWnF7yvUiZKjd6qVmeBX4MJccVnfea1xNQ5e9UDZHQHfj0JDekXfgtOOs+6ri80LeS1ymHGsMphFYdX/8Nykv8ONzSlGPjutPQp5zXaCNNseIQDGb4SJy1kShjfRdVP+blpRUiXaQsSCuHAjZLuVfAZREFAy446C9x/t6xBpZnXhyi/XL4BESTIXzVvbXB7IfrGH27SfuJ14euoBd+POlctCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c7qiobqxG1jeoO4P/EjexpTFotUzcG9Fe0Ow/Yo5As=;
 b=QtmQfAlZJJfLs3EGjyoyr2LjQdaovb4/NqFv6AzPCsFxAhFbanXt7unUWkEi33siiKmNgj2g2S3CGS5CGEnbCKW/D3gW0x2XrWYJvHxEPXbXg9aODJg8nd3ESdKubL+jICB96Vytp/k3I3+EFq1wi8zzC8WueuBzaoo1DZ8em0nX+RNjT5lbQW6xbpS+crs2GNJVPLRha7mUu5FMb6FheNtVnl9eSTuR2x8bc7JKsnqclQ45d7te0twA5SJ6LAnUQ3XhSvvUdL8cJNXJWnrjqyrsyz+gQCYJZXLyyc4eoRqmRRBPoczbghkLNG/lHYg0AfGbrtOMCGmkiTZz+megpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2c7qiobqxG1jeoO4P/EjexpTFotUzcG9Fe0Ow/Yo5As=;
 b=NPYLYnM9dkavSWo9zZEgV3hvrOUSh/lwliijBhwGZc1hYvptB3q+dtQ4UCggIiKnPtHoCmcEIKzqJ4Qk2SMYQqfY/+5Y8v1/V5u3hCJ853ByKXFSvCAMl3INKNcGV6zPXysp6LEtVXXfDili90MgUAETeCZXnvfb2eafitJ4TFc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4609.namprd04.prod.outlook.com (2603:10b6:208:4a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 26 Feb
 2021 04:44:02 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:44:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hch@lst.de" <hch@lst.de>, "osandov@fb.com" <osandov@fb.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/39] blktrace: add core trace API
Thread-Topic: [RFC PATCH 07/39] blktrace: add core trace API
Thread-Index: AQHXC0Rjx2fSayJhhkeZmX+JwdIiPw==
Date:   Fri, 26 Feb 2021 04:44:02 +0000
Message-ID: <BL0PR04MB65140C6FFF7246AD07874152E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-8-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cf12cd88-d50c-4728-3a72-08d8da112401
x-ms-traffictypediagnostic: BL0PR04MB4609:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4609025FBB5676ACB0DF3D00E79D9@BL0PR04MB4609.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nSTWTVEiI8EgM+ljUqUntd8+xkYtQmpZEi8o9gPE7SfSo6tuGuBsgDAke2p125SjVucHyS/JqUfYg8mVOkX3RZskjqN6qpSHUhL5OHBSKbiMuTnGvWDlPfXwC6GJkeGrbUUyd3gxac5dC1LkH8VNJt6903eYbI7ulOJQ6+DQty5ziymMHdqnMm+o3ns/ijo1N3O5YI+fdVGCPcA4VVRt4Ymp0Q49xMzM/pDk75dGq2YbJqcRtaCj13CM1p6IYIvczGRgEIgfQgkjLw9UrATnznis4XYprdEWC/bmMjJxlX5aB+jBO9XobKR7kv7KyxQjHJAN0t6VnR68MFjkR5PUTS2hOZKB7Y/EPoJI0jnGAaG7spVM52WLrNCslmFRj/sZME9KpalSrRMoXxtg6f1q3RzW5th6aFoSAkHI/40ndBLT5JtJ6NbABTjMN0RI0ZusW2VB0KggHeTrOWGNG01KteA9PTNeG6iWM8eBl7ykh/g7E0pWx0QMpDMhi2i21HFnVBK2gzSM5V764hQY67+idqKmlK1SiFke37sbjHZJl+t0AhN7XC8v+S4hI4kFZug7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(64756008)(7416002)(8676002)(86362001)(66476007)(6506007)(186003)(71200400001)(5660300002)(7696005)(76116006)(83380400001)(66946007)(66556008)(2906002)(66446008)(8936002)(316002)(53546011)(921005)(9686003)(55016002)(110136005)(52536014)(54906003)(4326008)(478600001)(91956017)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P+peKg1IfMebPfvv4BCyzpIwjR0sNJjv+yOpRQRI2PolrQVQUOzkXVFcKcEr?=
 =?us-ascii?Q?WEeaIQ5jR+x31KA94U4gPkgmvbtEOtdKqku58nOT0hnb3+8ujgwPC0mNZdA+?=
 =?us-ascii?Q?XVx3EQMmg6vth4TtlJl5n6VD8ABfyDCcGK5gq73JjdF4MXQZkt8M6kbyVEH0?=
 =?us-ascii?Q?2ZYm+LcuSAlrH2vi24djUWizmXa+FAI6kxcGdgbK5381QA5LZM0S2IfKdMym?=
 =?us-ascii?Q?RJ5Aq97wUK1bCoNZxb2Tij6eWi8E+Sdj15dmUca+o3ItmHImnAcS2mF/yVT2?=
 =?us-ascii?Q?R6QXU4amaNIdAepgqfbnTabRgvHyo/kXzsYcxUjoMHO2fWezKQzOsIfff5kl?=
 =?us-ascii?Q?p6XFo01ls2Ifd8jLUekL8jR7vQQk2r171MVwuB8orjTulZ1mZ13gsMkpQGVf?=
 =?us-ascii?Q?onU+uGAwnuaoMMnkbXrI1VM+qMBHXjuN42hL35kFgH2KlQxMxRY2yKpqUrnb?=
 =?us-ascii?Q?50bYyQrJAGxW/3dY29s2qztzA+2YMiJ5djBsvYSABP00CyAThY0xYhCYPgq0?=
 =?us-ascii?Q?ZfP92Aeqn2RZ86OYW/85q4LT9zoZOQv9EIEhRBiRDeNyqGgMXCtumw0Q7o4X?=
 =?us-ascii?Q?4ASlQdgF4u4GECqvCdvg041aikBsYLYk9WTLUkqc8uG/l6TcDke/bPskECIe?=
 =?us-ascii?Q?Gg7Fs9/0OOFX4INX/ZwW6xixTI+x4xRxDAGwzuTwjLD8gQnSsQJN5okbAyac?=
 =?us-ascii?Q?slByHlJwipmRqgAU1rSnJXZlhRU0ZXSjGCbOYyzWdQEf1bblD3ZUnLSBerm5?=
 =?us-ascii?Q?IbOh/IQ1dKZWaWsPOpzfgMzqmuWLB2qJkXsccPlzK6NQHNUlsfq8FC367LGC?=
 =?us-ascii?Q?nw80Ie/sMJ3LeOV48egvaJx+o9CNY2aKSQi8Hydy1IiZwovhFLoSfRmEqoL+?=
 =?us-ascii?Q?1YZwPVsYQEFODB0ZpbZ3WSZfnasZSDq2jXAkoylg22gX3MptATs7c1eUDdVe?=
 =?us-ascii?Q?TjcubaSdEO3ikcqiGDLOl1R4LPsIDlVHETGJPfgEeKLVuzzG37XAHXjvA3wn?=
 =?us-ascii?Q?RWuPO/lJX/P+NUayxA6KHam8tiARRT3PMXDnXDl/yHW6t1lvKYIDdDGD0sj+?=
 =?us-ascii?Q?/3FRZylp0lu1Leh/S0uaE3fUCdk++DB+zgMxzH/rNJiy+ge9eIgK7OJgaR3S?=
 =?us-ascii?Q?VsdqCfa0bamxRsA7LgSYytU6QQcOMcWHWEFg3LVtd7lM67ZjtndsHcsneVvb?=
 =?us-ascii?Q?Kz4UoII+sD4XrnnsQyqsvJ6PwFNMRJi9xmF+n9Jr//33S+Z4wwWDc7hDEgoF?=
 =?us-ascii?Q?6b000KF7q/D1Dcldnu1Sgr8oAt+XRlY96ngYQbGneQ6/pOoNnthGSHx+pwm2?=
 =?us-ascii?Q?0cZP506jItjjpAuVcgPM7vS3enwlVYLtlMfaS8lykUs34p5LytUqhQlOJcFX?=
 =?us-ascii?Q?MJ+WBOZU/rk6Vbswt1xV9RoIx4ukRa0Uo+t49GAVmQDPCprjSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf12cd88-d50c-4728-3a72-08d8da112401
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:44:02.5318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E11k5u9Bf7PhRAdkPDtZM4XSH5jHy1UOmbkJ+I5f2hjEugd7LSGxOL1dWYnmTNGnOkAisAnxQrUlGeZSg/inew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4609
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:03, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
No commit message. Please add one.=0A=
=0A=
=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 130 ++++++++++++++++++++++++++++++++++++++++=
=0A=
>  1 file changed, 130 insertions(+)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index feb823b917ec..1aef55fdefa9 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -462,6 +462,136 @@ static void __blk_add_trace(struct blk_trace *bt, s=
ector_t sector, int bytes,=0A=
>  	local_irq_restore(flags);=0A=
>  }=0A=
>  =0A=
> +/*=0A=
> + * Data direction bit lookup=0A=
> + */=0A=
> +static const u64 ddir_act_ext[2] =3D { BLK_TC_ACT_EXT(BLK_TC_READ),=0A=
> +				 BLK_TC_ACT_EXT(BLK_TC_WRITE) };=0A=
> +=0A=
> +/* The ilog2() calls fall out because they're constant */=0A=
> +#define MASK_TC_BIT_EXT(rw, __name) ((rw & REQ_ ## __name) << \=0A=
> +	  (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT_EXT - __REQ_ ## __name))=0A=
> +=0A=
> +/*=0A=
> + * The worker for the various blk_add_trace*() types. Fills out a=0A=
> + * blk_io_trace structure and places it in a per-cpu subbuffer.=0A=
> + */=0A=
=0A=
The comment is wrong. You are filling a blk_io_trace_ext structure. But I d=
o not=0A=
see why that structure is needed in the first place. So the function below =
may=0A=
not be needed either. Modifying the existing one seems like a simpler appro=
ach=0A=
to me.=0A=
=0A=
> +static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t secto=
r, int bytes,=0A=
> +		     int op, int op_flags, u64 what, int error, int pdu_len,=0A=
> +		     void *pdu_data, u64 cgid, u32 ioprio)=0A=
> +{=0A=
> +	struct task_struct *tsk =3D current;=0A=
> +	struct ring_buffer_event *event =3D NULL;=0A=
> +	struct trace_buffer *buffer =3D NULL;=0A=
> +	struct blk_io_trace_ext *t;=0A=
> +	unsigned long flags =3D 0;=0A=
> +	unsigned long *sequence;=0A=
> +	pid_t pid;=0A=
> +	int cpu, pc =3D 0;=0A=
> +	bool blk_tracer =3D blk_tracer_enabled;=0A=
> +	ssize_t cgid_len =3D cgid ? sizeof(cgid) : 0;=0A=
> +=0A=
> +	if (unlikely(bt->trace_state !=3D Blktrace_running && !blk_tracer))=0A=
> +		return;=0A=
> +=0A=
> +	what |=3D ddir_act_ext[op_is_write(op) ? WRITE : READ];=0A=
> +	what |=3D MASK_TC_BIT_EXT(op_flags, SYNC);=0A=
> +	what |=3D MASK_TC_BIT_EXT(op_flags, RAHEAD);=0A=
> +	what |=3D MASK_TC_BIT_EXT(op_flags, META);=0A=
> +	what |=3D MASK_TC_BIT_EXT(op_flags, PREFLUSH);=0A=
> +	what |=3D MASK_TC_BIT_EXT(op_flags, FUA);=0A=
> +	if (op =3D=3D REQ_OP_ZONE_APPEND)=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_ZONE_APPEND);=0A=
> +	if (op =3D=3D REQ_OP_DISCARD || op =3D=3D REQ_OP_SECURE_ERASE)=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_DISCARD);=0A=
> +	if (op =3D=3D REQ_OP_FLUSH)=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_FLUSH);=0A=
> +	if (unlikely(op =3D=3D REQ_OP_WRITE_ZEROES))=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_WRITE_ZEROES);=0A=
> +	if (unlikely(op =3D=3D REQ_OP_ZONE_RESET))=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET);=0A=
> +	if (unlikely(op =3D=3D REQ_OP_ZONE_RESET_ALL))=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET_ALL);=0A=
> +	if (unlikely(op =3D=3D REQ_OP_ZONE_OPEN))=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_ZONE_OPEN);=0A=
> +	if (unlikely(op =3D=3D REQ_OP_ZONE_CLOSE))=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_ZONE_CLOSE);=0A=
> +	if (unlikely(op =3D=3D REQ_OP_ZONE_FINISH))=0A=
> +		what |=3D BLK_TC_ACT_EXT(BLK_TC_ZONE_FINISH);=0A=
> +=0A=
> +	if (cgid)=0A=
> +		what |=3D __BLK_TA_CGROUP;=0A=
> +=0A=
> +	pid =3D tsk->pid;=0A=
> +	if (act_log_check_ext(bt, what, sector, pid))=0A=
> +		return;=0A=
> +	if (bt->prio_mask && !prio_log_check(bt, ioprio))=0A=
> +		return;=0A=
> +=0A=
> +	cpu =3D raw_smp_processor_id();=0A=
> +=0A=
> +	if (blk_tracer) {=0A=
> +		tracing_record_cmdline(current);=0A=
> +=0A=
> +		buffer =3D blk_tr->array_buffer.buffer;=0A=
> +		pc =3D preempt_count();=0A=
> +		event =3D trace_buffer_lock_reserve(buffer, TRACE_BLK,=0A=
> +						  sizeof(*t) + pdu_len + cgid_len,=0A=
> +						  0, pc);=0A=
> +		if (!event)=0A=
> +			return;=0A=
> +		t =3D ring_buffer_event_data(event);=0A=
> +		goto record_it;=0A=
> +	}=0A=
> +=0A=
> +	if (unlikely(tsk->btrace_seq !=3D blktrace_seq))=0A=
> +		trace_note_tsk_ext(tsk, ioprio);=0A=
> +=0A=
> +	/*=0A=
> +	 * A word about the locking here - we disable interrupts to reserve=0A=
> +	 * some space in the relay per-cpu buffer, to prevent an irq=0A=
> +	 * from coming in and stepping on our toes.=0A=
> +	 */=0A=
> +	local_irq_save(flags);=0A=
> +	t =3D relay_reserve(bt->rchan, sizeof(*t) + pdu_len + cgid_len);=0A=
> +	if (t) {=0A=
> +		sequence =3D per_cpu_ptr(bt->sequence, cpu);=0A=
> +=0A=
> +		t->magic =3D BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT;=0A=
> +		t->sequence =3D ++(*sequence);=0A=
> +		t->time =3D ktime_to_ns(ktime_get());=0A=
> +record_it:=0A=
> +		/*=0A=
> +		 * These two are not needed in ftrace as they are in the=0A=
> +		 * generic trace_entry, filled by tracing_generic_entry_update,=0A=
> +		 * but for the trace_event->bin() synthesizer benefit we do it=0A=
> +		 * here too.=0A=
> +		 */=0A=
> +		t->cpu =3D cpu;=0A=
> +		t->pid =3D pid;=0A=
> +=0A=
> +		t->sector =3D sector;=0A=
> +		t->bytes =3D bytes;=0A=
> +		t->action =3D what;=0A=
> +		t->ioprio =3D ioprio;=0A=
> +		t->device =3D bt->dev;=0A=
> +		t->error =3D error;=0A=
> +		t->pdu_len =3D pdu_len + cgid_len;=0A=
> +=0A=
> +		if (cgid_len)=0A=
> +			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);=0A=
> +		if (pdu_len)=0A=
> +			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);=0A=
> +=0A=
> +		if (blk_tracer) {=0A=
> +			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);=0A=
> +			return;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	local_irq_restore(flags);=0A=
> +}=0A=
> +=0A=
>  static void blk_trace_free(struct blk_trace *bt)=0A=
>  {=0A=
>  	relay_close(bt->rchan);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
