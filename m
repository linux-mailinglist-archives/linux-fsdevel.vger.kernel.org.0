Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A440435B7BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 02:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbhDLAZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Apr 2021 20:25:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:52761 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbhDLAZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Apr 2021 20:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618187100; x=1649723100;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QktRStDHXTZ2JVtSw3lo74M5RcMQaguQwZ3kBFEkTSA=;
  b=WpZJ02PNpO/dpOYB/REZAY5udlZ2WQvXqhSGnOXmMQB0aeJcGmCaYSnO
   Ay4/iFLr6QCO8JWs3UTs9T3Pz35l3zQBrvqf8JLcXSq16mVoj0iTUWNDd
   bJTn+tvwnFnLvwh7Ga2qkR+2sPWegJcqxCAuBNm2wv2+fNJVteZGE6cQl
   Y9Bsp6hV8l4kdgaxSyQhxL3z9bTLv8UE+9MSBDo8b+1/dM+COAPvD+cVP
   aaHgZ1tL4A+RX43YU0vRWcDdF8GyMIH9iRohPVLkbgvHpK7MwefveBxIC
   a30TKJyTYayxm1uS3P7Uh1EdNFy7NiVWM6DY35HS2SP57Y5FIP1kumx9l
   A==;
IronPort-SDR: MoB0AcKdAkU1M9NU1RhB1BrRSxuYQpkuD0xqLCdDmAaHOBp4oHwjD83yvp8HiFrAlugug2NPJm
 QIXtD0T7/d/6Hp8DD7TIpOfe88oA5CJMTTn8oc1i/8vpRg4L5EKXjlqabrKl38Nf60tSuNlRr2
 ym6TJOjWUFOABZwJ1u9fgXF+L4xgSV5b4BR04EoS8KQJbeJrjmntRQ6Q3ohhVTfaskZJNGE9Ch
 LWxcFNAtjercruMhQZaU8ocKKqMDcWgP+TmHyu1eyqhaVue3DWzEiuZDnLprBu/l8Gznhuh8HY
 UvI=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; 
   d="scan'208";a="165273425"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 08:24:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI2CM/MY7rXEydcUqXwO+AeinRgxrTUHb1kWJxU1p+J6SRUQssddEo2quFUtbOfj3DR9c5r3vbEcq1RnSa22WRlVIAWJ4L9oM8chcH0ci8UmnuGo936FR9YmS1eCQEtIRI60ztEXpGrIOYTCaMoS4qp8FqpVLjgvw8IjqvUVk0Mxpoo0I8xDUeIwGvX5Q/P7FIss5PpVn8pUdF3Acw/q5GzCxaonz1SbCVqsYnki/C51t1K+UZkhrFlne3g2J0+jOhwLeWVLuv1taGa0WQLHODcl16q6dO4fcYBqI9xzzuxAhQmQr/cCNURhTQHQxvMprsWDJ1lghadDysPDzpMJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkIK2VIEnDJZ3GNb0B027KqAStnV3i5L/AiXnbaywbo=;
 b=mxrgtMl6jqEDQfRH5arYZq2ANNltflf/ehTB2TF/aGTZ+OZ34vzcem+OyKCmo+xUq6zSA5FV4h73YVDHPcxucNwk2ZlC1yalGwaJBvVsVQa0Jo7N0f9Ny3jz4vLox0rLJIAgMGZ+Y6iogA4MUcUpFIlhn1AGBP3onjapCJMkzD3GLc+cCwI1t+oF8uvcKL2rie03ExW1Tw0xDxT1idGGDHKnlKz8Zyx77SoG8bUznCLGJslf+ZSpAqhwCumvW08L8b2VU1IaSDzl9VjYikku/x7jucqr40h62iQMgLMJIp3P4rKbpUFTMYg73/sb9dJFVtx4lMw0B4BTbT9q3luRSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkIK2VIEnDJZ3GNb0B027KqAStnV3i5L/AiXnbaywbo=;
 b=bJfG2ezKotkhq/optX4rKvhyhsfjJnfSqU+33+g5VOQTCuFB5gLsGFw3stGsoj7m26UKxbbJrFR7U1D3S7nvwKCQXobM7t2TszbWPAn0OX/JfNalEOWzlaueVdG+qUoEiilKQmdQUuz4Z59r07qTcLbyBNuCMGHjbnehjmEXoBc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6546.namprd04.prod.outlook.com (2603:10b6:208:1c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 00:24:56 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 00:24:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Selva Jove <selvajove@gmail.com>
CC:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Topic: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Index: AQHXByxWhY0q9dGq/EW9B8B+rRJ+Hw==
Date:   Mon, 12 Apr 2021 00:24:56 +0000
Message-ID: <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com>
 <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vb6GgaU9QdTQaq3=dGuoNCuWorLrGCF8gC5LEdFBESFcA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1134:9421:2151:4ee3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cb7d7f6b-48de-4f67-4e77-08d8fd496655
x-ms-traffictypediagnostic: BL0PR04MB6546:
x-microsoft-antispam-prvs: <BL0PR04MB6546F1721CC6CB32123BED96E7709@BL0PR04MB6546.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1EnMG0d2IPKRSfPon7FvRAiK+E4Ted8XbRe1NZP4wgBjWnnfoxy63tFuIAnYl42I73Ncx6pFt21qjyVGgWyeBj7kn5MnmMJ7Xk3KNMebEZaYwjL0JrlHJEuUVmOOXclXiZmW7TktUnZa1uLppxdUChzSJ+14C9nydKBztjAooDdeiCpjai9UlyuyQlxTlL9P02oc1X/r1BwOAjdEXMLFdIkzlUJKSjTmTDSFGEGUndssjZZ3RkycdCvZ6JAqDUiNRFFdgV+XWfHaBXSFMSTk8awypxiwp2F7/4Fn9wv34t++NQY6HJcgZGARRjuBhCbpudLDBk/7w2N9YsO0lfNeGwL0Q/8SjWRhSVTLRXIHgC9h1JqPuh3R9kHpAciwh32zvZvi1Ko90eBmm5+R/1XZztSnyZaxe20fjFPN+XfXQTaJ4rBFfeIDGzmdpctPs1npC8KFnurKbmy1Pvd0a/O03SDypF8afKNUUAyhoCCHojIzyGwicsCTiojlkDtkaN7iVRj9IvZ4skyyULX7LCtXq14+xKdMLGWLe83z7LH9SDUd8FVrELr+MQX2mwmcd0xOfJ61YNockXGGaYN18inYibr3z92bpLHAVSw8oDdwOXUt1C8ydXHwqjY/4/JijjJEfJwxIwli+HrUMAc7DYCnM31Mtet0937cyStRJdx59maxyv2d3LlG66iR1wZ/OQD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(966005)(66446008)(76116006)(52536014)(66556008)(5660300002)(91956017)(64756008)(66476007)(66946007)(53546011)(8936002)(316002)(186003)(71200400001)(7416002)(8676002)(6506007)(83380400001)(54906003)(38100700002)(86362001)(4326008)(55016002)(2906002)(9686003)(7696005)(33656002)(478600001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cg5e4KiF9MF0naCX6i/ThYaTi/PMz9Nq4Qp+fUbtzlypI3Q8u+PAL/NnlsFX?=
 =?us-ascii?Q?+X0dJ/9bWGNMkRQ6dyN7/wSlrR0sMjNDHcFDo7oeGu+RB6WaS9BgocUKA1V3?=
 =?us-ascii?Q?2OkA8ROEcyqfOEWh4qziV7m01RMmRhnJa+pBBspl1Y8oZ4YLBkDdaEK2ucEL?=
 =?us-ascii?Q?PDvZ2f2u73hSZ9csAIPLOV4BPuu/wC9PH+Kg/+L2P+8B2RsRqNT3oFmdL5QH?=
 =?us-ascii?Q?0x/S3kCNAK+H9uW8nAIkJHhq5jhlQaFu6uwVoY3ckP9QwtnMA0SBlQYPqOjJ?=
 =?us-ascii?Q?Oin/EIphZQAmSNJ/1sFfZBqGR8vQX9zVI8wnVVfx3OZESuDo7W2ZCnU7gL8y?=
 =?us-ascii?Q?sDd11UhW9WXF0E4bu4s0NGJFJyXl6x7Vo729LGC071+5NICm5nA5cyBb4oWN?=
 =?us-ascii?Q?5nPFKjHme25f1OuDQ407cGLWCOLwt8t6zREFHg2f8qIjbDOMFe9dfFSNgaBQ?=
 =?us-ascii?Q?lVkLrbamKiZo9FI8cMhMYTgMx4uqgiXz2qWw3fSEBWoQAYzx466F15Wops5t?=
 =?us-ascii?Q?5pkf5ixjfKiBJlSdlY6ifEuExNYFQ05qyn+g+q1QOwK1othIcf6N/sXuQ/kc?=
 =?us-ascii?Q?xuz0pzrsiHX0/LBgth9hW2oACTDPOr7ouZ0MSL+ihDPFI8xqCqWySEuCyplt?=
 =?us-ascii?Q?KoXsRotdZ8teK9uoH/Assx/2ojVPxSpn89qXxKDfc6mI3f6bLqiTf7sUpwTQ?=
 =?us-ascii?Q?oL3hdnGXjoJIWXEvNdeY0y60N5VKgaw1TYORhBhWoUsqCLFd1g51QjwY5bHu?=
 =?us-ascii?Q?0rXeVr0+9yymxh6hoYw20CCgwFd11+xWWULzb7F1OakJEAQNfe+jI/TzkWmp?=
 =?us-ascii?Q?c2tZB0Nyh6rYYrHxfu8TH+muU4qxEmXs3w1l06v0gJYMTFi3Qd25Nu9CfSUQ?=
 =?us-ascii?Q?KrjqyKbk/Hdk2BuHXHBzjUQbiGWubM2KH2MFtAWk8J+bDFh2ac+6OdAjTQPB?=
 =?us-ascii?Q?cJ5JafZs6pIOpb3MtrK2aORhk+F3+Yql8iFcCiuE8GcHy8wma4/RssF+jLXw?=
 =?us-ascii?Q?O6vgxfm1DrGoW8tBIaRdMnOuqIg5h8NOLIfhyVgfwRqwxMWzaJBoPYZuLqmH?=
 =?us-ascii?Q?67QOadByky1KerItYCpUJkAOcAdlbC2RPxQk0sclVdyuNmo9S561ga6ba5IU?=
 =?us-ascii?Q?1jvhuQYvbPnqK21G+TNM0kU6pBWhwzIVTQwKK5vrN024PBntK6Bo8T/u1Bul?=
 =?us-ascii?Q?NvEpoqKAzVxWr0R4NUL8l8cY7QpB/9FKKJOkYGRkSGYrwBGEzUj0nNibNaao?=
 =?us-ascii?Q?ml0ODX55izkND40PqK0ZuQfz33t4YSvJRvSqJqyXx4oe59yQ6xEejXUNR0Lx?=
 =?us-ascii?Q?8DPIfT2X5QQRZo+QX80ak+9lTe6u2lSB5Pd6DosJ4Sbqxa3jnzW7QJ7dzGr7?=
 =?us-ascii?Q?DjtTrox0wZ1xUanWqY4weJalD/6urHNVCLdzvt6cQ5TPFfiMYA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7d7f6b-48de-4f67-4e77-08d8fd496655
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 00:24:56.3345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oa66vKcD59q7C168B7+dNoSz1+UahsJaSgObpMgDTUTxV5ujbzS1mgHyik5e5dfQG1h8C8SEIdr2M52qsMObRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6546
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/07 20:33, Selva Jove wrote:=0A=
> Initially I started moving the dm-kcopyd interface to the block layer=0A=
> as a generic interface.=0A=
> Once I dig deeper in dm-kcopyd code, I figured that dm-kcopyd is=0A=
> tightly coupled with dm_io()=0A=
> =0A=
> To move dm-kcopyd to block layer, it would also require dm_io code to=0A=
> be moved to block layer.=0A=
> It would cause havoc in dm layer, as it is the backbone of the=0A=
> dm-layer and needs complete=0A=
> rewriting of dm-layer. Do you see any other way of doing this without=0A=
> having to move dm_io code=0A=
> or to have redundant code ?=0A=
=0A=
Right. Missed that. So reusing dm-kcopyd and making it a common interface w=
ill=0A=
take some more efforts. OK, then. For the first round of commits, let's for=
get=0A=
about this. But I still think that your emulation could be a lot better tha=
n a=0A=
loop doing blocking writes after blocking reads.=0A=
=0A=
[...]=0A=
>>> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,=0A=
>>> +             struct range_entry *src_rlist, struct block_device *dest_=
bdev,=0A=
>>> +             sector_t dest, gfp_t gfp_mask, int flags)=0A=
>>> +{=0A=
>>> +     struct request_queue *q =3D bdev_get_queue(src_bdev);=0A=
>>> +     struct request_queue *dest_q =3D bdev_get_queue(dest_bdev);=0A=
>>> +     struct blk_copy_payload *payload;=0A=
>>> +     sector_t bs_mask, copy_size;=0A=
>>> +     int ret;=0A=
>>> +=0A=
>>> +     ret =3D blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mas=
k,=0A=
>>> +                     &payload, &copy_size);=0A=
>>> +     if (ret)=0A=
>>> +             return ret;=0A=
>>> +=0A=
>>> +     bs_mask =3D (bdev_logical_block_size(dest_bdev) >> 9) - 1;=0A=
>>> +     if (dest & bs_mask) {=0A=
>>> +             return -EINVAL;=0A=
>>> +             goto out;=0A=
>>> +     }=0A=
>>> +=0A=
>>> +     if (q =3D=3D dest_q && q->limits.copy_offload) {=0A=
>>> +             ret =3D blk_copy_offload(src_bdev, payload, dest, gfp_mas=
k);=0A=
>>> +             if (ret)=0A=
>>> +                     goto out;=0A=
>>> +     } else if (flags & BLKDEV_COPY_NOEMULATION) {=0A=
>>=0A=
>> Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why wou=
ld that=0A=
>> user say "Fail on me if the device does not support copy" ??? This is a =
weird=0A=
>> interface in my opinion.=0A=
>>=0A=
> =0A=
> BLKDEV_COPY_NOEMULATION flag was introduced to allow blkdev_issue_copy() =
callers=0A=
> to use their native copying method instead of the emulated copy that I=0A=
> added. This way we=0A=
> ensure that dm uses the hw-assisted copy and if that is not present,=0A=
> it falls back to existing=0A=
> copy method.=0A=
> =0A=
> The other users who don't have their native emulation can use this=0A=
> emulated-copy implementation.=0A=
=0A=
I do not understand. Emulation or not should be entirely driven by the devi=
ce=0A=
reporting support for simple copy (or not). It does not matter which compon=
ent=0A=
is issuing the simple copy call: an FS to a real device, and FS to a DM dev=
ice=0A=
or a DM target driver. If the underlying device reported support for simple=
=0A=
copy, use that. Otherwise, emulate with read/write. What am I missing here =
?=0A=
=0A=
[...]=0A=
>>> @@ -565,6 +569,12 @@ int blk_stack_limits(struct queue_limits *t, struc=
t queue_limits *b,=0A=
>>>       if (b->chunk_sectors)=0A=
>>>               t->chunk_sectors =3D gcd(t->chunk_sectors, b->chunk_secto=
rs);=0A=
>>>=0A=
>>> +     /* simple copy not supported in stacked devices */=0A=
>>> +     t->copy_offload =3D 0;=0A=
>>> +     t->max_copy_sectors =3D 0;=0A=
>>> +     t->max_copy_range_sectors =3D 0;=0A=
>>> +     t->max_copy_nr_ranges =3D 0;=0A=
>>=0A=
>> You do not need this. Limits not explicitely initialized are 0 already.=
=0A=
>> But I do not see why you can't support copy on stacked devices. That sho=
uld be=0A=
>> feasible taking the min() for each of the above limit.=0A=
>>=0A=
> =0A=
> Disabling stacked device support was feedback from v2.=0A=
> =0A=
> https://patchwork.kernel.org/project/linux-block/patch/20201204094659.127=
32-2-selvakuma.s1@samsung.com/=0A=
=0A=
Right. But the initialization to 0 is still not needed. The fields are alre=
ady=0A=
initialized to 0.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
