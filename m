Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5402325CBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 05:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhBZEuk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 23:50:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36920 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhBZEui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 23:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614315036; x=1645851036;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hG0o4RrhhJ9Ey7dkScFWLdEleCwYLHv4sLpQAAqdpMQ=;
  b=lVxMr3szdg+Cfd69txGvkysrKNmF48DelWb9odihLiTQFRYrEmbzxl37
   4ESiLDHvoGLBOWINduysx+2pgmpBaopZkdQFXWSFuK+aLJRuUCrCyfd72
   5U6/TZPw2NT/UIJJlVwDnHC7XFuZvVemp5lFwKUXQzoybPqElfmVWacOi
   aA0koPEQGFx5AgIWuVJ+Gf/W20ZNAmQk6nBFb0l41m2sx9C5YpL12txII
   jb6ch3yDk9Frr/NL4JN9SHrhkF8K9H8SIHNMnD5R1a70AM5/0SR0HlRIA
   pPrYRF9/kHoaUEpu4ujzXUaPDZ4iBmNXhcb9S9jrndC4m5wtfpRWDdWKe
   g==;
IronPort-SDR: p9Aw/Iwt/radL1gHfruaNXxatVxnGWDJ/mTID10FDSp8f6RSa986HaoEfIiPb+6Jg1EaNfjy3C
 IrQepZaCQWt8wNC7JIuMp4YVbLVba2v72GOJNgWBhJ5/LQ9BLvyrHEPykcxh4i82hiJeBq+u7I
 1zxhHlxJQVZEj5z/O98s5upTBtyBJr6ip1MQuOgB52lLtG4SBlYzomRLFxuwOIdicPaSoo4/5d
 TcosA4v4KmUh/Q+6DMmEhIFZdPvUhGZpYho2CiOKXxakwAvT+Bh/eadgd9NbNrBizEc4OL+n4b
 Joc=
X-IronPort-AV: E=Sophos;i="5.81,207,1610380800"; 
   d="scan'208";a="271419745"
Received: from mail-bn8nam08lp2048.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.48])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 12:49:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLvbY8fp6t8d7dy7NZzOsQLLvL97wVPssKG5ZUv/gdk8M9TNCAWuURVFitY+09JiI8FeFWS2+Q2jlf535qzAnc1rB0fAbtU5XLF1UECSopCrhYvTvEZVK9KOyf+B8s4Vg/j2LaF/Dz/auMI3r9/ubuOEh22shZFGOuxJZUivVu/TRapDNw07Bq4knKtE083WfBqvFTVZia2JABaElVetODJyj2luVovTCS1OvR1RHvllKE5vWvaHwGp0FMHdPqA2rOk8dSmWsf6Ikw1KEJeS1B/mAWM2qO/ZK8GQsqRc1UEKTFXbCW5dSHIkyMSXFbnKTp/SSPcjo1H/P8Y7HyWO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzmBEVrYwx8jiJpbx6RtE8odwWsf21LF3jKKedfu41E=;
 b=cqvd5Xw4nCCC+aI512pMn77MgbTDyNXa2kFq6uxETFRkCFUz9IyOWgp9b7/9gxb2/Q8ZixhwpJh0sc7WaYazL3SBVU+VVmbFE1OwDovn626uFsaNQIKb+xfnU7frIYBual4TfDsbBacDEE+PiNJthwc7Ur8LTE/jfTXB92Cmo+Ya89ZY32l6hVOPuQvAvkQQUN8SGmXC/lqN/Latwvtn+iiufqVwwAtihnpGha2LElh+xm5e9Y7JzxsSPuUFOrav44XZ2S3wQjcVFG0Wg1fRs7IywU4bhyfgAZa+ib9IHjwWARjVek9aRjTmlZz7vBL/oDY7W+rzhPt2A56kW0q4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzmBEVrYwx8jiJpbx6RtE8odwWsf21LF3jKKedfu41E=;
 b=iMqUbSAELOlasqVJbVL0GEGvhPR4engwqQmBxbnISKswUY+NCvNvUlJNwcoftV4CzfmiJGwWMXdwnpEYh4GkzWkGt1qi9vALCSenyUfd6S1PI1dyz6pWcbFe51fUyghBpUzyyef1GQs1vH3aslt5i4d1wIf3+AX6T3iB25iaQgQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4643.namprd04.prod.outlook.com (2603:10b6:208:4c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 04:49:29 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:49:29 +0000
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
Subject: Re: [RFC PATCH 13/39] blktrace: update blk_add_trace_bio()
Thread-Topic: [RFC PATCH 13/39] blktrace: update blk_add_trace_bio()
Thread-Index: AQHXC0R/LIu9yya0uEmtJ+d5NjA13A==
Date:   Fri, 26 Feb 2021 04:49:29 +0000
Message-ID: <BL0PR04MB6514F16DE15CAC134E5C68BEE79D9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
 <20210225070231.21136-14-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9e3:2590:6709:ee46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94074f19-9289-4e65-3ef2-08d8da11e696
x-ms-traffictypediagnostic: BL0PR04MB4643:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB46437103B4148FA360AF5235E79D9@BL0PR04MB4643.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:66;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XpTn/IdGeJNjP0oUtvhlrBEopZCwFXUMWaQ2qOSQXYjq1c1RMk5UTNGhygdm+A5up7t8EybNF8WDSA2slYAAWG8XjTQpAdqgIOdJ4XPiluyjhIdqxBIkzBirqIZusniCRa3eZ2hzPwuk56KCSSEYyVaEwTE1DntFGlMXN+UfiT661f8ZbRe480xXhwfwFBfc6saGy+Xs+BzVXf8Yg+00C51DXLjazsJGMpl6ilsGa3sKPLU5DeA1CLfS7BLsyInfeYVsNCUg/8TMfDjlpSmt+weC6eSo+oCsVatrr3DVJawuQoso8117R8zeZkJcN3TwOH2GULSDNdZwYTBX2pxiEs0nMiKN8GHvBfGOVfYbwZkp5yqqqPwGT3TaT4XdLgj/PzFFHl4tfSkNMnCJk5l+8IBQIbOZNg/3ezwoOc8Hx0siUVNOGnQ4UzNc5RZfsXDeIKiL/S3vIf3ttxeoxT9jCBGmNgAwtaUEqBCGvw5mTqDak8ew2wYw1kujI5WmU+SfbOonlMtVUIgOx5r++Rp1GLoPzCRITUydicP7DlLaDOeFXpB2gh9D5tNC0UNH6Shb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(55016002)(6506007)(33656002)(9686003)(15650500001)(71200400001)(5660300002)(2906002)(186003)(53546011)(4326008)(66446008)(64756008)(478600001)(7416002)(66476007)(76116006)(66946007)(86362001)(91956017)(316002)(921005)(83380400001)(8936002)(54906003)(8676002)(66556008)(7696005)(110136005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?o+S0sfUHprL1FxjrVns8cqjltlUbgQ9bOzzZtFbgCevDJ/Yhwkul+dx6D/UK?=
 =?us-ascii?Q?EbECj9asnkuIaWc2qyKY+k2oX2oS0zk6tb3SdB7xABBykTNkPucFoYHZSgMp?=
 =?us-ascii?Q?ixdf5F2qjR/34kpA9OKTeykAoyXaP353i+l5yU0okPmKvLeyOmXrN/zYm6h7?=
 =?us-ascii?Q?npsahO2WdY3YTLdlQW6wrX4gzFHuY0qlI5TNWDHT29Qigg6VDrXJFwy+st+n?=
 =?us-ascii?Q?F0f/afj4wLds3Z9+HBErD+9YC4pEJd4cN31bWO6nI7PQHXlfHmBrmaAbejrm?=
 =?us-ascii?Q?FaPBw5oG0s6g2Wm1+Xqar2d0EwirhQDGo/KqVqDhYv2KXcgmqK483/LIR++C?=
 =?us-ascii?Q?jTu/NZ2IQJQqL/zyFrarQODH1oVH51kHnbesW0PVLEPJ4aQ4CDKNxxIxpHmk?=
 =?us-ascii?Q?NeNhzKRJLLH1DXpp/ycM6kQO089v5jDd4FMH2P3JfIJv6IR4PdZPebDS9Dh1?=
 =?us-ascii?Q?iXjMNMcGQKmKO423JJRQtfeQ/LQVG8u83z6sUkcZw58FFLlVvDP9omogRCjV?=
 =?us-ascii?Q?9njv226m4c/NpkRzaiLTLXWmwqP5Icj+2/qglZFJuyqqLocnJ5GDjyyA4slC?=
 =?us-ascii?Q?RDZf8a4Zp4ZgWx9ZwM+5l81vRQhcMLIq/VRQ7kllIzX9JhRycn8GBEKRf4gy?=
 =?us-ascii?Q?X9CUvY3t94TrhXxX6e/BkM5U/tApRAScpPkgRWAzKEH3dRXAe6nTcj2sF5pN?=
 =?us-ascii?Q?ZabJkduwHWHu1mAEGBSpK7alxaq1JKqtTNUBON300UsZcfzWzeBWMCT8qWcO?=
 =?us-ascii?Q?JNdYi9G1oedqhKga/w6hUj0Iuya0lbGnI4vr6XIDw6qa32eznxcbbw47/AT/?=
 =?us-ascii?Q?dgOTBsU6nR0oiFUNTCfiD0m3x8Ryg2CmLoTeWasgZlrRaEUzuTrxkpDgsPNu?=
 =?us-ascii?Q?Dmy+pydb+yfFyeRP7MlQmB/svnTQBqvNaKnyJzM64oWyHht0fwpyotm9KdqA?=
 =?us-ascii?Q?72v/nl0+v3/rx7YEF2f2/4ufx3lPh6Kev8+FUUB2hb8UssCzL1ToHyS/b6Lg?=
 =?us-ascii?Q?tJc9LqFuRsDuDLytZRdFvTkZYaSHxnqPCmmlOObdbkT4EYzNidiG5+hTCqmf?=
 =?us-ascii?Q?3+eoBXZZ9UnwQIdL4lck6/6+/dgpQveJW47FI+KacloIHWJhUrlFpbT94qMt?=
 =?us-ascii?Q?SXmj24ZJNNxZ1nojZxzoosy1Dly/W08RDzLWaMkOblshl5ZcpYZ8W93KG/Y+?=
 =?us-ascii?Q?+GSbenwQzTUvf156wGr8bjtVJgxwdq2Itj6SJpeR8f9q/iL9SHhjP2IqTjHu?=
 =?us-ascii?Q?UhwomouhxMy+HIeB9MWlkqfpPb2OXkZKWcuJScqXWcscCOPHiHQBtrED1AhU?=
 =?us-ascii?Q?4fYTyzqOhve9DukC9SFTxKJl6E2jDKR/FOwqMcKotAQk0074JmdDpzTS9Wof?=
 =?us-ascii?Q?LCK5crKYRRoGlKDdpQU+6O/iEqNGg+Po1Eoe4R+aMXMjQacNtg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94074f19-9289-4e65-3ef2-08d8da11e696
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 04:49:29.0342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BS/LPsB4Y2dIL19637GsyzHZh08xWg6sHG4oW6dO38mhxZ8x3MJKfXzxJy6k4dxDlsRk+OIvLKdwMmwthvR8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4643
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/02/25 16:04, Chaitanya Kulkarni wrote:=0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
No commit message.=0A=
=0A=
> ---=0A=
>  kernel/trace/blktrace.c | 21 ++++++++++++++++-----=0A=
>  1 file changed, 16 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 07f71a052a0d..14658b2a3fc8 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -1247,20 +1247,31 @@ static void blk_add_trace_rq_complete(void *ignor=
e, struct request *rq,=0A=
>   *=0A=
>   **/=0A=
>  static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,=
=0A=
> -			      u32 what, int error)=0A=
> +			      u64 what, int error)=0A=
>  {=0A=
>  	struct blk_trace *bt;=0A=
> +	struct blk_trace_ext *bte;=0A=
>  =0A=
>  	rcu_read_lock();=0A=
>  	bt =3D rcu_dereference(q->blk_trace);=0A=
> -	if (likely(!bt)) {=0A=
> +	bte =3D rcu_dereference(q->blk_trace_ext);=0A=
> +	if (likely(!bt) && likely(!bte)) {=0A=
>  		rcu_read_unlock();=0A=
>  		return;=0A=
>  	}=0A=
>  =0A=
> -	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,=0A=
> -			bio_op(bio), bio->bi_opf, what, error, 0, NULL,=0A=
> -			blk_trace_bio_get_cgid(q, bio));=0A=
> +	if (bt) {=0A=
> +		__blk_add_trace(bt, bio->bi_iter.bi_sector,=0A=
> +				bio->bi_iter.bi_size, bio_op(bio),=0A=
> +				bio->bi_opf, (u32)what, error, 0, NULL,=0A=
> +				blk_trace_bio_get_cgid(q, bio));=0A=
> +	} else if (bte) {=0A=
> +		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,=0A=
> +				    bio->bi_iter.bi_size, bio_op(bio),=0A=
> +				    bio->bi_opf, what, error, 0, NULL,=0A=
> +				    blk_trace_bio_get_cgid(q, bio),=0A=
> +				    bio_prio(bio));=0A=
> +	}=0A=
>  	rcu_read_unlock();=0A=
>  }=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
