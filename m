Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5FD325CA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhBZEm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:42:28 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40379 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhBZEm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314546; x=1645850546;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fpjGNfbQ2fnUJ+Bp0+r53eesIBWV/oQB9iOewAMPevo=;
  b=eTqJAcm9rpn1UkNGUXNM117YxCtgwVLsdEoJqRDTaUZiU7Pe10VsHew+
   2PKfhar2T0XOMwCDb5oZphfhF55Eu1n8CHXd4l51o7VjI+2Gbf7SUzcnH
   XhyCjsza8LURVT3+rTgFZP4r10sd763Zdmv1zy31BR6TSA2bHyuw3l3ul
   GkSlWI3wZTJjdPKrluO0ZoKYtrlcR0Y85V9CSq7gGnFfpWab1jW5p9DVD
   DTa/+2b8PHuoNrVwxF0GMhrtHNz7S/9yM1LjFvNbZpTxuhmg3oc69eWKJ
   XmDzsnWkMbdX2EuO09ThMjHIVHJGIlu2VZdoRcrvISMla/yxVmlXyzfBk
   Q==;
IronPort-SDR: bOKDpCJPb77Yn9FLBvd98R+2jkob70NrNRW/ZrYzXgeFQiYUPmkIldn5XgwzAl6eGdX4vyHiCi
 8YwZROeQWh6pahnChetRB8V9KBhYNr51gMuxuc4Q9u5Y9vCi2akC6fHDFvq7uTri6eh0+DyMdb
 YS5JVTiMtyqrgOyqYzC9bWMUiqCJ9eJpOdWDOr7SLbcaxXAPSDHgHBeAInzxKyACJwaCOwvtTz
 7t+KJbGarrajVDxPaf9yB6MQ6cV3O5ex8lFgfK8aJ6Tfd6AYKS0fwVXT4deIyCXimdwwRUS8uy
 khk=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="271419342"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:41:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URI9QTX3e8UDAjelt/tcSCSPCUPzr8Uqi7GEJx/pMHGGH+v+kG0M6Tp47jSp9dBpmNvQIVOcc4HE4Xi0F+NXn2AWuhQqBua3iK3q0VhqqBUZbcnWZR6PyudJbaCXdG27volaQzT0oxCWGKzuT/O7Yc5nR2fMLg7g5aL/ANNUQgzNZ0TXdlBwyAZo1Y8NdyccN/5StK9xOVcevWVDe9VxiWVtOskDl+3dgE0+FGMhggUSsGbQU3oczf1WefIhwFZMse+28qHTaZphtuBrO7069IvFM++x/vGTnPdRhRi6K1Rak9f9FBXFnkl+LeQj1zwnOJpAVTgY90zb66qfIyPwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/Si5mKYAAYAx2nUxZcsHaNgMuK6ABTdSuMHcj6ifX0=;
 b=HrshIT1rkgA9P9gsQQFtUr7ctaVURKAjEJHmqDGrF6yZKJeQAob1L5ZZJ5eQTbaWspoNFbz5uABAsq5i81x2VUXITtpdODkTFRtMcqtUaWw3D0rBU0YlgJ5YOjTGn+887t+mBXBfKOByBYaSrRcxEthhj4XQ0y3yoEVKA/rJzKg5bwz3DiNau3mjpOQlxxSqzRVAgaAKPFDmnRmkfbOccZEL83hhIgkdasDfMBdbjvHWzZLErGcz+PpsisHnEIEidcvmm9klfBZey3BNBQzRrlD1dVzWhrRc5nk7yg9XLyi96Q4dGhFGxzZ3c64n+BbXDOo6aSX4NscLadplATGK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/Si5mKYAAYAx2nUxZcsHaNgMuK6ABTdSuMHcj6ifX0=;
 b=yGY0tnJR8p2UQEKmyxulLy0isHd4aiqG+OX78lFGZxa5dtIf0PePZ1Uzjt0l0PFpHs3Uwitc+KPEH2jmSvhlKmJ2k69LKWLpdUY9IinRw5PA1/HyeqeYG+fQP16HIRoAqFtn97fIkierh7EVSXfTan7Yp6Kpdg7coEPrhBVWhyw=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4531.namprd04.prod.outlook.com (2603:10b6:208:44::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 26 Feb
 2021 04:41:19 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:41:19 +0000
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
Subject: Re: [RFC PATCH 06/39] blktrace: add act and prio check helpers
Thread-Topic: [RFC PATCH 06/39] blktrace: add act and prio check helpers
Thread-Index: AQHXC0RcrsJRmzRlhkSw35XmAvOMGA==
Date:   Fri, 26 Feb 2021 04:41:19 +0000
Message-ID: <BL0PR04MB65144CB8123024B54AEEF1C7E79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-7-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38fb4471-1c3d-4b70-5872-08d8da10c2eb
x-ms-traffictypediagnostic: BL0PR04MB4531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4531C32FC0A3A089B38D5E6CE79D9@BL0PR04MB4531.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzGRcFs6gjet2La8D8IzhrUTvrJ8yNhSV3PkFazAvq5in18qfaG+YNYNwzM7/7Bjx1Dmf2wnlcLUcW93eeGPjgN9YrRxj6dW5IP0iyrOmtnVkrMGFYWPGwg+y6zd0fv1h8VSEWDyyXjMfAK83tdu07B+BV0M2LHguz8rn57lOl/JJOh7cwOXnxh9YnkUkWJhITvqGCMTpZQ13h/BEAOqw5mIgWgXGA7i8n8WSB6greAiQ55BsZRYZJcqI0ogyMcxGrSY5+N7sDA1Qld1bHGWbCn8ilIrh04X7XAXfgNrJ57UoO2BsA4dQARjTSfhFC0MI/YTaAb84+pes0TQFOkML2utNG1L4jEYGB+Jpd46xMFCNat1revVJRVb8Zq7Du4ZJ+ynwpLqjOIm44zNPA54VuxRtkl1GgUtaBvYP5EL4Rr+xJOFfEyZlPCE8UuhjswVroUs04qF2NzPPV1/hXABVfUDu/Tun9DYy/9BW7ysVo2W0Y79xY4w+5ledF8IM+oyHtdolhN1z1WiHIy1oHNp1TXHzv9IJ0hhI54PhBdJcBqX0ZeLgHCBNfmFxbaVoL7TZKWF2LE8baqzs3uyOZwkuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(71200400001)(921005)(66556008)(478600001)(66446008)(66476007)(91956017)(4326008)(186003)(8676002)(5660300002)(2906002)(76116006)(6506007)(52536014)(7416002)(64756008)(53546011)(316002)(9686003)(8936002)(33656002)(7696005)(86362001)(54906003)(83380400001)(66946007)(110136005)(55016002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?19X29RtB8qC3h4pu8wn5Qh8xdFfxUfFZ4mjX+UwKhR9JhskfqFQ9NbGKrOMX?=
 =?us-ascii?Q?ye6kdWA6ezqiPTd8OQ5Owc8P9NQcr+WYCoRB+uMG/XYFQ/qgNxCYSYi1jEPm?=
 =?us-ascii?Q?sEEB7uYYhxvDf2+UyI/orh7cL+y6p5yy5RFPYKfHgUnzGpOWxqkO/X5vPEIx?=
 =?us-ascii?Q?qUH/dcU1RHbQdJNAE06X4gFZ3GAD78vAz4vt/Qg97QV3vdIX2XSec8PVyRm7?=
 =?us-ascii?Q?fyg1naDKlLyUuB9Br28RR7iegKz6bDTrNiHxzJUWRBzEcaPvt528gc3NkmX9?=
 =?us-ascii?Q?+VEkYdd/Q2TknTAWRWkmOSAFcdTklh0lKYTY/9cFqruu24BsOX2K19BBSg/f?=
 =?us-ascii?Q?7SdE+UJNS+243Yk02bj8axFfcU8egpzYi6BEPmb1kE1Zw/RTcR+TXzd5688K?=
 =?us-ascii?Q?PqTnAP9FNXhO0AjGUyaUHzD23VD0dV2ksvFTJnBMwo8GrbnBeASiUnVZvKpK?=
 =?us-ascii?Q?gbHA0ROgcW26d0ur7eTBUwC0IN1QC3y0FUP5JUU8uXVRt7TNEYvdTFQHuzuZ?=
 =?us-ascii?Q?a7ZDeBQvCmB/9NKTObH2aHXyZsNyZzRwTJK5YU7VKPihm90eCnXKNwMzYzHm?=
 =?us-ascii?Q?7+D6/R2KxUqvY7H9avT1+8h2LSgbUmV0l0lAxH9Vn0u8kl4K1FukbGhywt5w?=
 =?us-ascii?Q?+ijF8UunR9d2SJ5bFNjf4SyLFVnt0gy2kwP+UkU+A0e7UA3crj3N9U4ViHen?=
 =?us-ascii?Q?DzCEU1//oA6xJC2m2nG7fAZkSz437L5IUQq0+TJBYZDq4+aD6D+bFTh1LjAl?=
 =?us-ascii?Q?pFq8yFqd5GAlCK+sjn3dWEt3+HQ1gkHoSMR4cD/I5B6fqU+bOfrgk9UHZMN2?=
 =?us-ascii?Q?ZFP7rYnMmbpu5EAN3rt9dLHW3ZRu+oGp8kJr1Ebc6bxXtPX3sDk3rx8KmihX?=
 =?us-ascii?Q?Wvuhp0Fx2pCSoktfHuE7hsvFPnLdFgfFIONgGhXj4uLT0kFd+hO37BViekKN?=
 =?us-ascii?Q?cQ0OmBlwspLtbz+lGqQoVq/SwKNTDJeWqQ23FPgX9MnUm6owpbQHiZDTQg9i?=
 =?us-ascii?Q?IF9oUuqL0wV7btmWLyXIVM7Aqno4msGCc5ISZePOOWcMsfcHqJrEJKWY2Sos?=
 =?us-ascii?Q?p7dGFQuvG1YCdCWcYv6l5iEscohotWjqpsYkE+8eluN4H434AaOv8x7GJgUe?=
 =?us-ascii?Q?CaY4PUTxZyVPyzA1WiVcemKxkYTji3xxu9tiOZ0q5BnwqQDEWOLROOFsXtQS?=
 =?us-ascii?Q?blnieX43i0D3uNin1AYo05DFjSE7pTjjYvVwym+P5jCEM01BvfpZyqCOU97V?=
 =?us-ascii?Q?CuOivKhbENWJcW7TvBHwvolNXlESYRNS6te9RA2eRS7DirjQEpkIZkSm7Z+0?=
 =?us-ascii?Q?I21KA2p9VrSd3/axdXLjtwwzs9C+q2zAc0LbMZvq1MAyGzWWlPddY/P0ckhD?=
 =?us-ascii?Q?lJjFa52LrLquiLCYaizrMiYlLKN2ZC5QN491AqLrCC9FgKsWhw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb4471-1c3d-4b70-5872-08d8da10c2eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:41:19.6913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnhUSCpTfpOVZwFh1Uhcwm7iSSeWSnJ2sZuB/pDCL6+ICRbiBlaYtMfAdfH6pI5D1PAS6Qyw7esUo2lzWlNuaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4531
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:03, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 37 +++++++++++++++++++++++++++++++++++++=0A=
>  1 file changed, 37 insertions(+)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 4871934b9717..feb823b917ec 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -311,6 +311,43 @@ static int act_log_check(struct blk_trace *bt, u32 w=
hat, sector_t sector,=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static inline bool prio_log_check(struct blk_trace_ext *bt, u32 ioprio)=
=0A=
> +{=0A=
> +	bool ret;=0A=
> +=0A=
> +	switch (IOPRIO_PRIO_CLASS(ioprio)) {=0A=
> +	case IOPRIO_CLASS_NONE:=0A=
> +		ret =3D (bt->prio_mask & 0x01) ? true : false;=0A=
> +		break;=0A=
> +	case IOPRIO_CLASS_RT:=0A=
> +		ret =3D (bt->prio_mask & 0x02) ? true : false;=0A=
> +		break;=0A=
> +	case IOPRIO_CLASS_BE:=0A=
> +		ret =3D (bt->prio_mask & 0x04) ? true : false;=0A=
> +		break;=0A=
> +	case IOPRIO_CLASS_IDLE:=0A=
> +		ret =3D (bt->prio_mask & 0x08) ? true : false;=0A=
> +		break;=0A=
> +	default:=0A=
> +		/*XXX: print rate limit warn here */=0A=
> +		ret =3D false;=0A=
> +	}=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
> +static inline int act_log_check_ext(struct blk_trace_ext *bt, u64 what,=
=0A=
> +			     sector_t sector, pid_t pid)=0A=
> +{=0A=
> +	if (((bt->act_mask << BLK_TC_SHIFT_EXT) & what) =3D=3D 0)=0A=
> +		return 1;=0A=
> +	if (sector && (sector < bt->start_lba || sector > bt->end_lba))=0A=
> +		return 1;=0A=
> +	if (bt->pid && pid !=3D bt->pid)=0A=
> +		return 1;=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Data direction bit lookup=0A=
>   */=0A=
> =0A=
=0A=
Without the code using these helpers in the same patch, it is hard to see w=
hat=0A=
these are for...=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
