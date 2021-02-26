Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646F4325C98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBZEeS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:34:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:47739 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhBZEeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314054; x=1645850054;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FhQ1UlK3o+LfuwcKWjBcghuNrfPPVFAUO4Tjdn/N/Dc=;
  b=hB185723x6aWheoHVrEDzbZW9dMNmti7gM6Ti33Usk6GCHB1dAZaiKfL
   bJ45/IML8ZcEHLYWM4BNZ2El4mCD0MgejpwXV4WawU7DvRSITqntCbyWH
   gxkfS7MbO7RCD1HNVyOE/ggz16i6Y9sNfjnYYqwrbMhzRlJKPttqqtF3u
   vf2XsFxcUq7TzFIWnx3zjVM0vk/XL2fED9yfiPrz9Uq+lYW8XWY/dTrCP
   avkK/Y1CkVeqLw+TFHRmKMCzAIF9mxIf1h1O9r+UuYjfCw91SDLrRANwD
   CKWZpN6dksJRpeInvkeGGxPFhGcASxJMka5tgyXXSCqsUpXGmG7IsexKd
   w==;
IronPort-SDR: RflF09T1VIXS3DIBn4uGJG6UZ5ghCJNcOeEicL3zBa1WXFCK7Nldg/DMRohk8yxFcxIHkZ4hNE
 ldp1nRwkOm+9S3RykDlttghoeSG/6wO194x1vMHg2NVfWgiMZz3MzAU/zej3SSdf5Ti70iwbt/
 uaeCYyA48OoOZfCws9avwCDx8jTZ+4AgffkC0yaBLQzO3+ilzZi6/AfjCAExAi0DxEdfyBDfa1
 4VINN3QsAkp8c+Gcxz2359igdvZuxZalOwqCdrBa7/dqM3xXTKnaOUtdKKayQqpZtr3TdK5OF0
 bf8=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="160872513"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:33:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYj9NBjzWKtYM4781hcUJ8zucer7m2xdF6lMJR2CxrdHB8+FZaFT1dN9gZpD3UG9WnaCmD1DmdIww2LXzPPFAgJeuGDHIS+GiUqVsFvJOt+GtwoLJLWcZJSXxTNhYUbtswB8P9J6VY9P0UzCW90/YF64aP72B4UhqqVu7Cpf5DnswTMtXeSqha7ZX3Z68jmDi+4mbaQcdfYo5tByfgtyZMWUuw64ywmfB4z4v+kS6ea50ZJaizQvt+prjuydW5kLUoTFHUmcuVbYcXfxlpkFfaaeCfiHKw9p5zha83Ut3Oo4WavjRNEX0pb9IxaoRVsOIuILHFf8i+/FPhOGMqozhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmDmwl33V3v5NBMgPx6WUS1CehJYjUXnRyBceOHf1g0=;
 b=ceUwXvzrL07ILktWI08F+PcpvezB57sHSsFtdWn1sUll/yS6SFezGNbeZmfSwwxgra4j1EunA9xBLWS4ucGcBU0XuCp9lWX1Oj7WEcwzTGBEX/9kPkdBmeLUlibeF0SnIxiH5d0wEsvWCHJAHXQAYyEMXtYmTYq/x7nEhIXbozhwIFf7LeS05rZ+n69nAyi/gNstspJYSYUU5KaI4+xnLvVLQDUZ1kjx8NJ3OWzr1mGkNTMDnci11GxqJdRjcQME0PQERVp0xF1xTm+X33Vkd8XMNAdx/Wu/98KOw82NkPlyTO44HQXW43DV5BHel9rp60RwNh6dH8TQOpxMh2aIPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmDmwl33V3v5NBMgPx6WUS1CehJYjUXnRyBceOHf1g0=;
 b=fprrtbzQ/aJUdpgvIilBBw6e+a633XX+0Ep4qrmM8vvG2VPVfH1gDa9eVNrW46vgSUBmFL5PoTPCqeC1u4UWB1ODq/oIsFy8OJyAZNWsT1fDQJcKAi3Jk7ULf/+FH6qDrjnA2m0S4cefvnwj1a4S33G8NLYzHcr5Q6VwWx92tc4=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6515.namprd04.prod.outlook.com (2603:10b6:208:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 04:33:04 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:33:04 +0000
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
Subject: Re: [RFC PATCH 02/39] blktrace_api: add new trace definition
Thread-Topic: [RFC PATCH 02/39] blktrace_api: add new trace definition
Thread-Index: AQHXC0RGDnRNRhoDJUScyfITlJvwwg==
Date:   Fri, 26 Feb 2021 04:33:04 +0000
Message-ID: <BL0PR04MB6514AF2D208F9A7BBA5C093BE79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6381b85d-c901-410d-6936-08d8da0f9b9c
x-ms-traffictypediagnostic: BL0PR04MB6515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB6515CA00A06EF370A74B7F95E79D9@BL0PR04MB6515.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szGwQE4Lxq+TQaWNSpTxRjJ26fCp97fBY8KRf8khE5B3J+cnazzJ/6rhqsZUUExNGNfPh9+lyacFoYwDTFKcCLxasdxXS8/r4Bl9Eo2nykxyTROFblcqPxCnpGb+nuyTEylds5BuEgvB9AKiaCuSo7n5DoR6kPPttv6WsraIELVQ5UBxuH4v3yvYs2RGOE4SXNA6VDHEVg6QMG+/5xdBX7PXbpr8EP1GLT9u0jpLqxZHQgc2YERaWHbHK0vSoP8Hbor8pFPjiL+kF7pp1fQT2iBDYNqGp0MJm611R6vppnRZguazO7Mj5JG5h2WYgq70Ky4FsG5PyiHYYWtpuctgmKtN1VCQrXWTCNxa+psdDS8lgZAL1ogIS9cKRkSP0GynUadCIvlPv1G/2TmrrmGIOY/5Ditsf7YPDdQrVG4V2M0l6wuo2o272QOiX2n2n4mot+ThsXav5rOjTd4dlNj1TRca4gb6NbF3rExxnRItmTXvl2ggTR5/I0vxfGYQJI7wEPjH2VbPB0VsrvY5qj/Yd3iGh8mdTZnFoLOXbaMf59oBnwSVpr+LDNvj6J4PUj7j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8936002)(5660300002)(71200400001)(52536014)(86362001)(54906003)(33656002)(921005)(186003)(110136005)(316002)(7696005)(8676002)(4326008)(6506007)(66476007)(66556008)(66446008)(66946007)(76116006)(91956017)(64756008)(478600001)(53546011)(2906002)(9686003)(55016002)(7416002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IIVNez3REMpma6xCUdJVR/QFp3TINVGUB55l3rfhN8H9iKuQWB4xxzlfv7hj?=
 =?us-ascii?Q?oDNu2vRbMJeeVA5pnY1EWOHOKletgJGb/olxgjrXhdfny6DhcfJopC5QcVhT?=
 =?us-ascii?Q?ugCNHTL8vExZl4nHCmNQJAB7K6Q1c5e128NoRCKhPxnjtLenrnqajJA9UVW2?=
 =?us-ascii?Q?oedxztnlzhFWf9KJJsmrMj5NbPdg+pwbgi6jImvQBYPRI9Zwb/Q1eO+WOK/I?=
 =?us-ascii?Q?CvUA355e7dQdSGT7nAiRVV5XDeJjoToobIyDmZe3Dew/hF/9ZYYe0N9LPjrk?=
 =?us-ascii?Q?ms2974uZHuiPGb906fm0AErBN1ePLoeQYc6Cbe2tZ86s2Twes7wh4CPbWwEJ?=
 =?us-ascii?Q?rlJ6j2wPu+ge15VunnbARkauTZDiz2J6DbHOJcQtkg5LCiyWgFalOB/Ai/jI?=
 =?us-ascii?Q?kHCFFScAT8+CBO+q3TTdYcTj7Z3iqSYkvVPgIN73PuLp/9rHSpQVoy2oft+l?=
 =?us-ascii?Q?nASUc3Jw00xhHxv9Ttl16vJYdoX5l8ZF3lK+oyfF8LLfdccKHnlTgIWgJmqq?=
 =?us-ascii?Q?WZh7MHgRUzlAQmBPtQzCoINja5tcDpu5BgwPvrtQZIGFtMBG9/A3F7qVqKaT?=
 =?us-ascii?Q?f5UUdG5evKhUGXuDpWnS+BfBMFht8n1aDF0E1JJwPpXd/tuNHFNchJrETrXy?=
 =?us-ascii?Q?nqrZoyq3L9+mBqydycnqLYFKTnK5yOy/PCT/yXoJTmaaz3UhUi2Bhm+BpKfk?=
 =?us-ascii?Q?6WLmbyuo95cZTUHpvR9inHu/wImY80lTf5IyVSFSeXmRNIXA0J9kvBUPA6Mm?=
 =?us-ascii?Q?MkIvHIytW/o8HMLGA9c7PL3+tFE9vUYH9Ci+SvyzfZZzt5WFpqJMOrzlh5Uu?=
 =?us-ascii?Q?VDXyL+slGNc1whslFgiGcE7Tj+IDizWo8sJ4qqMP5xSH2yZmqamiiNwwPgWp?=
 =?us-ascii?Q?2r2G1tysYuz/ewgKI/HJ4izuSJttp2TuDEprhx1QmRuBdyrskopHhC9Xnwnw?=
 =?us-ascii?Q?p3lG+7qIDOtJOeIf7RkcOYVBkp0H9NrZ2Y41t+IHaKdJ+Lh8Q45tGyboa4P1?=
 =?us-ascii?Q?LGgOUcVmMRBMySKK5KHpunQWQ/s+iW8T6mzjlEAbVLOz7TyaMy5sitf64wx0?=
 =?us-ascii?Q?iWFVsGZJnbGCavIQDQ9nqLtBk30Mg5qCEivoRm6rzZIozgqCIWR9h10CsXne?=
 =?us-ascii?Q?EKHcV3IpSVOuEGjg4YhDxZKaKKvSMHPULd2PDfpsjnpCD3Nc0Rpfb/Cel4Ic?=
 =?us-ascii?Q?mRH9uSZvbpU/RXg1p91WqM144lbLRdnfZmcSE71qc5FRE627UB1AEFYsiyya?=
 =?us-ascii?Q?/I4jT/pAofF6yshHTeffdvlF32Zg6ctAJD0KjnFicVT2czNXn3TCmX5zxIXC?=
 =?us-ascii?Q?BniZ+W7nzgECNqqmTIY4qaNhvBXQLX29lo3sMjkxkpDFKHXE+nxaY1t98ipo?=
 =?us-ascii?Q?HobspyBQ78qgp3qGi7n8A162hgcReDmj0X3zSyhydFUCKXi/Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6381b85d-c901-410d-6936-08d8da0f9b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:33:04.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lUDmmTyE72M9FOVpQHe2FNALxsPdvfPSQSUAla62C/w9mlFAPlFKL+ybziP9uzXApFZUSCDh1O1fa6A6fFV5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6515
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:03, Chaitanya Kulkarni wrote:=0A=
> This patch adds new structure similar to struct blk_trace to support=0A=
> block trace extensions.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  include/linux/blktrace_api.h | 18 ++++++++++++++++++=0A=
>  1 file changed, 18 insertions(+)=0A=
> =0A=
> diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h=
=0A=
> index a083e15df608..6c2654f45ad2 100644=0A=
> --- a/include/linux/blktrace_api.h=0A=
> +++ b/include/linux/blktrace_api.h=0A=
> @@ -27,6 +27,24 @@ struct blk_trace {=0A=
>  	atomic_t dropped;=0A=
>  };=0A=
>  =0A=
> +struct blk_trace_ext {=0A=
> +	int trace_state;=0A=
> +	struct rchan *rchan;=0A=
> +	unsigned long __percpu *sequence;=0A=
> +	unsigned char __percpu *msg_data;=0A=
> +	u64 act_mask;=0A=
> +	u32 prio_mask;=0A=
> +	u64 start_lba;=0A=
> +	u64 end_lba;=0A=
> +	u32 pid;=0A=
> +	u32 dev;=0A=
> +	struct dentry *dir;=0A=
> +	struct dentry *dropped_file;=0A=
> +	struct dentry *msg_file;=0A=
> +	struct list_head running_ext_list;=0A=
> +	atomic_t dropped;=0A=
> +};=0A=
=0A=
A comment describing what this structure is for would be nice.=0A=
=0A=
> +=0A=
>  struct blkcg;=0A=
>  =0A=
>  extern int blk_trace_ioctl(struct block_device *, unsigned, char __user =
*);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
