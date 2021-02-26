Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB26325CB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZEte (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:49:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32967 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhBZEtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614314972; x=1645850972;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=c6lSyV1WhtlgOrWCtbWDw/7D29bAGVO3XHyw4EU3b9c=;
  b=Zka9Sbzr31jQxZjrctbngFjZ+6ASHTaWvcx14YwzBKi+w/RiZQOLUcEU
   IatYYnOXGgLSXFs2+kP1TkU96KtBLFGIxaQ/XpUQm0EK4+DwwfCyYh6ru
   zATEVPu/u5JItaCmtNw6uhNaxSZS6wWOovL1zeQNhs9d9SNwNRmlsRlMm
   K113sqbRl1f/t/qztF5U1HQQa0Rk472CN+m25RExSv7BLyijaAlSU6961
   40W6PuQ6TtgE6ebWJA4KYKWC6OLP/JLuLqupiuaW5ibC/QeI1Uw5BQGUj
   l3ni2D0J7gsSAHnXOzsXjv+bBSnZMqQdI6M+AYmyL2ZsF8k+vXzH/YjsD
   w==;
IronPort-SDR: Rc7Dp4koCepb4puZcq3a4GjEIQWTmmSgaxvgvF80S+Sx8M7iPAe+jw3jG5L7lcU7LpVRwh80ph
 JOfwypb+iaf1DpUx7UZ38nKzoebsakJFQDIhuKto+4Pmuj98vy2Uqfc4DhTCEJva5jrxd1+cBe
 g8PyE/TPD9zc4ls1jRHm9M+zs/TB5fj0jqdlfHSJxlAWitde5Lg0PaXo9CW4OhQdFMG78U+NwW
 dUNiSNyYgNKSmWT6CQZizNo9J2t6+IEyl2L8VsAaHQ3Uc8fSXRX/kbQe9WFIdbOF9o8gyWwabG
 jms=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="160844409"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:48:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bemWO1TC8jgxdK988uBhJZ4VpBt4XVbHPJvFxVraNps7lQaMpiQA8PLfEvqgVJTelkX0/3aT9jzNYQ5heah6bT9YcQqhRbTdNARikzY3YeSBD6pb6OT8jA1pg6ue9G3fulapbyCFdMwVRHiyQLy+kUfCTYmwQn337344QVnHb11GER0X2Go1+aINXZjoeBBQsm51d6ouLuMGQ55fXWnnzVCBX09t/YCFyJXm/YJZUCQ+Wfpt0sMgIizdtU9BSVVwJnIfbecx7VZD3fm6yoU3K/u5nYFLvYlUi4HXQmcAAo7ZeOAjiXmDCvlf58fJRIMR0b2Jl7c0+IxiLhIjyvSqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SZNOpGCL5UgzibLXsfdbkqkXXmFIxSo8sxhIkrEQjo=;
 b=btNxRG39x5qRBUE3wWAXNwd/QykDJdG1TNMVexKDq7uzuMS11ixHxUaEoLkOLQpmxHWFEVetwkFAvXHfYIBAXiEVDITnGnrnaTd3NJej2uJ1ZOi4PbYwR7Xvl8yBDDvCstOBK78p/51KmSZk3nLZd+fXQ/aLOqAe7rAcktklCAN0EUciMfepMy6Ats/JL1zBk8Wah2y5ZTMb8/2LDVsZ0FhPLktiuY3j8EGJK6zeu8bCFZ7b8i7UOkMIdxWLeQ5QAmtvRg8zo85gmXuuf0447RWQXiXKsdp2HT/95T3/twaolSYe6F4SsmVN2y6VZgcM0q4msDPi9Kb4KRXaH0zOuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SZNOpGCL5UgzibLXsfdbkqkXXmFIxSo8sxhIkrEQjo=;
 b=dd+fUTfbeTYXwbQugF3cVM0lTrQpEf6sNxCPHgUKkL4VbgDl/newWXF0apebsQpUN0aVvS9BtLwbyqBg3nltzBG4YryxkhOGIqk/NNauDSjk/70qmtLQ6JV/GXQjgFR5OCTBM2SAksJsrVos+Xq57B66LRGP/0R3G71sqWWhUhg=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4643.namprd04.prod.outlook.com (2603:10b6:208:4c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 04:48:23 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:48:22 +0000
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
Subject: Re: [RFC PATCH 10/39] blktrace: update blk_add_trace_rq_issue()
Thread-Topic: [RFC PATCH 10/39] blktrace: update blk_add_trace_rq_issue()
Thread-Index: AQHXC0RytpQWEZVOMUiTms/ZiIDiYg==
Date:   Fri, 26 Feb 2021 04:48:22 +0000
Message-ID: <BL0PR04MB6514617237B6418C6B9993DFE79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-11-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 03765f66-d932-45aa-19e6-08d8da11bf30
x-ms-traffictypediagnostic: BL0PR04MB4643:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4643D74C0471CD3513774F0BE79D9@BL0PR04MB4643.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MU/SvfV1jyp6qqvDiejRc4jnK4vh568pGRGgmHf2a3+5AkisnOOF2Enjc1292DjJnbQP24ER/bNGKJtR36GyPQjtPwe6gz13jujn68ukNJQWj/VfvuFoapYu/JeDHb89jsf3WmsLcWO1+2+OTme6+GmG7FqVCdwCKxsWW/zntsnYQL4JjrlOXnz2sO6ScmlFN7zIsDjqTFeyDkdsTOmzvR2fquZDzGAU70CwmC1vsdrpwhsr/Q1I2JvGxcxbYTLMThc9JfglDyw/HHAf/59JVvxg33NnA98cVQBzD2sm72xk1LHNHDA8NeyPrRH9jJtLMSRjmrZgmUT0bueS8X5q+N3gyD2AWF2SWvA+P7Y16k1pi7S4cQZ9b4GjOophNWIIfzx8ytjJrvr0rtPy3esNA7rO7kW64yuoJ7+KaMtKnY9N0IuygpJNYehLAy2xih/ZBWs4WWhlvBtngDTUJn+MAyAMOu4CM/fBjWwpmcuaNiYQmBYrUn4oMtbdWf6wHjIyttD1M14mpbpCP60buhDUuPj0mT/xkq4xJSihBXW6DXPy1IYJ9xoq3VZK4gJ37zxc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(55016002)(6506007)(33656002)(9686003)(71200400001)(5660300002)(2906002)(186003)(53546011)(4326008)(66446008)(64756008)(478600001)(7416002)(66476007)(76116006)(66946007)(86362001)(91956017)(316002)(921005)(83380400001)(8936002)(54906003)(8676002)(66556008)(7696005)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dgjkQM99vihDWdlJM7gg1MbZ8KfH/aVrRi19T2/qv7z5048CnEV3u2jc98+/?=
 =?us-ascii?Q?zAO541mNp6TU8KleXXSwaQo4slaModGs/EXsm9/0xhlA7kUqQ85iHmMGGSUF?=
 =?us-ascii?Q?u92MgtlUq/JHw3RUdYOEdkJnYdWoqE401pGJFH5qAReKb2VtarHYG49IMEkQ?=
 =?us-ascii?Q?JHkKtChS0c0kQ7p3I03SmdjikEwgJQRhri5OHWdE3tMrcNq8FMlvLJmFBERt?=
 =?us-ascii?Q?Sb/b3Sym2OjduLANj7fqRYarE17cn0XZGmus89k6iRhL/MbPYTqiv9YeoZo8?=
 =?us-ascii?Q?mn7IaL+XORLZ06FP/dtRfF6iWGy1oUHYGzqTOLT3NIxvN+nJh+2V8XsbCG7k?=
 =?us-ascii?Q?cMMEVe3Z+2pA5BNyglGuc6uFfbfyMoPc9vyWCB2oKEQkdR44WPl/lIt+2Rik?=
 =?us-ascii?Q?4vg8k4jIOtvW8h5xSZ6UCABWGx0uKmR6yMFI+ZMJoxuxaHQQmzPnof2eUI2r?=
 =?us-ascii?Q?/inbiCjYpl1oeHhi28Bup6HaogMD0V5wVSHibD2rpuBU+8c9LCKw5brPl3Hj?=
 =?us-ascii?Q?N3cj/T8W7W83ulo9fmBvMIfR85r0Axx9Cr8+CJBDL6sUaQ++dHFN/NZoi7Bh?=
 =?us-ascii?Q?6+8YOEP7OWqeA8g+UksFCxcdKcjABzpVgtgWv6GfBc/O5LVmUTacDMbVTkJv?=
 =?us-ascii?Q?yznev663N/k8God1XnLT+orar/iKr1v632jq6hvEORb9fY3xK7ffBeYMmvPV?=
 =?us-ascii?Q?Vw/ALb8tdGBzEWZsoWd4wx72LYZrNURfdYkZp8gnpj2/MffwW084Q1mF3FBw?=
 =?us-ascii?Q?gdJiXlMIbjR+6lpdL3niji7ZfN/THaNQ3R2Wq0VOsmJNAwjariSn2HaQTfMw?=
 =?us-ascii?Q?OcFB1MRecqs513HcdQy8jludDGsQ6UTNx8KTLRSuIrSU2T8sdbVjO/jXEZHI?=
 =?us-ascii?Q?oTMSM7UXPRixYPmlweUNVpr8HkhxI9V+Bvs54BmwyoraMpYUszBzD84Vmxm8?=
 =?us-ascii?Q?kAB/UUflOxhuPTvaKgLaRfuUI6G7KuG0lCRDCNxmt61a5XVF4Mom+qmrPA9U?=
 =?us-ascii?Q?kn+Qozkwj9BTzw2lwhWofSxHm7UMEttDbR+Eu+aDZiwncxYfsAWsEGyzo5/S?=
 =?us-ascii?Q?oQUjXKZphCTu5Z5K0gneAZbKmpTwk5RtSlu1R9FzPQpKgGMVYPI/N6h7DRMf?=
 =?us-ascii?Q?ELsustQvuImwhLFIbu1YnmvKT7ff4E1ZCiuSraS+0BaQD1FgI0A+XS0hXN2Y?=
 =?us-ascii?Q?yMwkARCZgL5rpyLvhagGZm6rLSLpv3wb2KAyG1u+fh6brDjTFrQHnrhRaFw6?=
 =?us-ascii?Q?OMkH0QblYTpudGIcAvzF1pPmzlXrY7oG+hAvCalzCr99Hl5NqNB43ptddt4M?=
 =?us-ascii?Q?5Zvhjxy0G0O61Hv8AsVjjyjJ5zuZ9jTxgKT9pW9GIiKOqfCpUK5VBGlKhvn2?=
 =?us-ascii?Q?qDx6ZPiVhUI2n1FIOtGMpCZ2IcBupT1rio3ewtEqxLDJets09g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03765f66-d932-45aa-19e6-08d8da11bf30
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:48:22.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t8x7tZZf6MxcomVVudNN9EVBMlz5K/UmKPIYYiqGt8EEnEHowNWKzakumMbGRJg22My0EE9HyWpzK/y7gWf0zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4643
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:04, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 20 +++++++++++++++++++-=0A=
>  1 file changed, 19 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 906afa0982c2..e1646d74ac9a 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1158,7 +1158,25 @@ static void blk_add_trace_rq_insert(void *ignore, =
struct request *rq)=0A=
>  =0A=
>  static void blk_add_trace_rq_issue(void *ignore, struct request *rq)=0A=
>  {=0A=
> -	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_ISSUE,=0A=
> +	u64 ta;=0A=
> +	struct blk_trace *bt;=0A=
> +	struct blk_trace_ext *bte;=0A=
> +=0A=
> +	rcu_read_lock();=0A=
> +	bt =3D rcu_dereference(rq->q->blk_trace);=0A=
> +	bte =3D rcu_dereference(rq->q->blk_trace_ext);=0A=
> +	if (likely(!bt) && likely(!bte)) {=0A=
> +		rcu_read_unlock();=0A=
> +		return;=0A=
> +	}=0A=
> +=0A=
> +	if (bt) {=0A=
> +		ta =3D BLK_TA_ISSUE;=0A=
> +	} else if (bte) {=0A=
> +		ta =3D BLK_TA_ISSUE_EXT;=0A=
> +	}=0A=
=0A=
Same comments as for patch 9.=0A=
=0A=
> +	rcu_read_unlock();=0A=
> +	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,=0A=
>  			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
