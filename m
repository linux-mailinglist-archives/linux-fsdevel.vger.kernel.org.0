Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F5D3028F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 18:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbhAYRcx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 12:32:53 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28318 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbhAYRcc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611595951; x=1643131951;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9Q4GfYulpIGixGAfnFrtKqVh/gTdxLMxdYgEUz3wIQE=;
  b=CRkTUptTky1wAZEciyI5ssxC6E83Hl+iIujM3MSGSFqIiZga+GC3tXPy
   v2p2OCjD5TLSmNdN3z/zIRkeX/3W9zj0sO1AhbxZb0qK/pFvYcHxCjf4i
   AB1YZGhQsF7GAnb+zcPFH/A1f//Vk09RXebvZfeDTz3qGYC8MbsmCBO1V
   4xT5ZUmsSpfTMHwe6KI6BRAc/23H14IAYQ67L6Qw9jLI7nxrAX+ZtmZpr
   ZSkCcDqZvNMT12SLAbBepK7q1nGvsCnxV+X6uDQFTsL0DcT2lnMH+1QNz
   0YA8gwz8ZZ8pGyg4y9xFlZ9oBgzyzbx1dxPMDKa5r65ZLfjKCGsfK9hfg
   A==;
IronPort-SDR: kxQILlYNOFXIryrMaDc8as9WY+4tQpEeUde4umlGt1e5hlPcOE/yUGYmBElW6jk1F5tkmn5lcB
 bDTnvcQIsCMtfyUghriyOmKx+F+LoofmcpbT/brULad4/eu1Hio34xbytfRgpTKvF5Rf86kOQO
 yw6OuDIePBfvXEDtjeS4bOPHRswJ0wGQBLfjLj6xqPyNrCOdowBxAJ+UzWYcyfBl5PdW596SvB
 7kFF7ch6O0r4k/4f0P+y5/GQdAlxAH4YPEe0ipimFC8IoF9jVE7Fi2IKgXxeesCWYzwTrJHzgg
 hAA=
X-IronPort-AV: E=Sophos;i="5.79,374,1602518400"; 
   d="scan'208";a="162716528"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 01:31:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDuHqOZiSgHPbiLkZKqbRpV8nh2AQ/2SuJ1HHyzExVzR1fscIoBsgoXHVQUTJkej6lKZnd2QdA3bjaRKtT6cYebDLeC5IpA/tFHBhqNB3cFnglb8pSho+yEbxE3Z20Wms94LfOIqeu7aTC+nBGsldGDNNxvpgFMkrEqLw+Oo5x02DsV332YbUvsu2/XaUcTPY+MtL/BX7NVP4mwJGR6frN9EXVv4xQg1QRoTs/WnkIT+JGyC+0KCP9Vk1uoXobHg2y/xG8U7kO9LynuHaIgi2p2I/ddc/Y8R3NsNfm7BQ8Mc+ni2Tey446lAU+k/hT24bmZxewerrfkiaDlnOQjVCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuErFjTy0m7cEIyYOHAd0th3GI9OvUAVWCLf/pcEn3Y=;
 b=HtMzzQ8vD+Xx04fjGn1r4mk5W/7f0Z9PhG4k52F0EBPdu/6yRl0QagbJ7NHtwK+jW4MYBh/+utM4lRGhooV1qUibSjue2vg5qjS2YAENBHdZnszbMlVsK9oXWgKB6ze5INNnkw3EObwL04gt89dfmDpJD2CDxPqpdehltJMKgG2f9txh8ADRyzApBVqg+fHlDPD/viFO9+G/ooLi+f9auJ6E2ybHfnNAfr4XMVQT283IKBhHukM090fmqG3dWaiJnGW98qO+vBn+C/TruUNJT0i4KSplHq3tgO1AkSiwyL3qiyNKRZ+4LfyBGK5xbgsylvdhgjeCnajWh68E1F5UcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuErFjTy0m7cEIyYOHAd0th3GI9OvUAVWCLf/pcEn3Y=;
 b=IYsK5iVFCfRar/hE0EbK1QmOsJxY6rrtuzUFW8eg2rvBwEqi5mCXFdhtBws8+rqT0zhYZfcSaXPBwNtCu7JnUFr/hAMpLOJNG93ucKwpCpTnHhOyLySH9x09z1ob+vt5dTsVtUQJHqoX14QxpRAkVlYh0WXqytCZDfRbGoh3yO0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.19; Mon, 25 Jan
 2021 17:31:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 17:31:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v13 01/42] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v13 01/42] block: add bio_add_zone_append_page
Thread-Index: AQHW8IbzSZfcMzGXs0GKDBI5eLFroA==
Date:   Mon, 25 Jan 2021 17:31:20 +0000
Message-ID: <SN4PR0401MB35987B7E6E5815571E49A7659BBD9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
 <94eb00fce052ef7c64a45b067a86904d174e92fb.1611295439.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6cc58bf-d6da-4eef-6df6-08d8c15707c1
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB367975FC3FA8C08145358BC39BBD9@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 19AVZCojIAFkL3KIdwVNTeXvp4AE/mCXhYeJUnf5Uer2jy0o29Hkf1kguzczOih4cY2aWnIIkSvM8sV9tFdZTQWR8ogZygHeVUllVWVODdmtKbPZK+gJnDQ7VWrCs2ddBgkR7nuyZaw+XIaM/lNTNZq3pzY0uxt9sU3AETc5Nday9ku0p+WOYgHig+b5td6RXiXZsL0HHo0wECYWHRABXsVAuclZWgiORhAWhDFrHx0d/ZRxcx1vOi0DK4dCnbmgU996mqGP7kXBzPQtO8nY69iKo7oGeGFJcWXq0AT8OIto9E0hve7C9289DcxfwO9M+nb9iGk4CDjPuymI8Hh8aOm+Pyr8eMWk+BC68Ekkz/Gdk70VRC8jZlu4EgP969CGbZBFLcsQmhzthd774moc6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(7696005)(9686003)(66556008)(8936002)(66446008)(64756008)(4326008)(55016002)(66476007)(66946007)(71200400001)(8676002)(76116006)(91956017)(33656002)(52536014)(54906003)(478600001)(2906002)(6506007)(53546011)(110136005)(83380400001)(86362001)(5660300002)(26005)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+DAga5dAWaBU4EmU4xQoxkOCu9jl09/LSNw/2fpCoYgF4XMPbaU5+rd5n3uP?=
 =?us-ascii?Q?i/XW7HIVvF2dA6GR7qv03IAbWFvRFgPPjNLa4v5PZbf+ck3HBXlj5AIAxvKM?=
 =?us-ascii?Q?jR9+peZqU6udFDt74Tydd8h7/IWF1mEQY63OYDWQ+QByjkx99+rqiKMdfLqO?=
 =?us-ascii?Q?7aYUX5P/rj6V98gfsMkQqa2WXMnB9Z2ciWjSaKUvFBrs/wKwdNYkaG2Uzg+0?=
 =?us-ascii?Q?dJo8ynYTupYf8CtFepRZp9VwK/XUZ4ermMd5HxDOPWz5q/JLznjafw7vm8Ud?=
 =?us-ascii?Q?Nwyb6pfOmDA9s7gdoT1MiINYAwXC7/+vUivNnhhPTqFWeH0XeRyR6MKocBXW?=
 =?us-ascii?Q?k6GoCqNQtkMr6dWxJ9Ct7xegbmeUCfasX3q5vhYsgp1aXH8Q33FI3nZLTkhL?=
 =?us-ascii?Q?G+DQFTUgDO71yrLl5DYjp5yiMpLG+y35cdU+hvW4FgGh3NbhzCPOW2d7XqDm?=
 =?us-ascii?Q?cwtfkbyGJU76FcgqzsKhucWOQxZCeqes67ueYbMfGGDT919Phb3Q841GgkY2?=
 =?us-ascii?Q?Y1ljymO4JtiEPCZFbfqtwm5OcmssbMZc/2oz7iM4Muiqvbr94cFNO5Fg7iRG?=
 =?us-ascii?Q?mfh9kPK7LwRWcV0gfFEWLw08KgRHdcxNEa0CdehIg9OdmcVl7n6JwoK87YR+?=
 =?us-ascii?Q?hLgmmZiM/YjrbkMJMa4uvhgb+HusDHITif7u3qnAYStq+IthQYNPvFMcE/2r?=
 =?us-ascii?Q?Kcq7roM6J4TotCxD0O6NEYIIefV5d5Xv6UKCTYqzm8jesoLW49TKD21IM8K5?=
 =?us-ascii?Q?REk8qYYIgAlJitNtEkg8AT+oR/jFSuyj5KHt+Lc+JWr8/yPy8TVRNpHnPh11?=
 =?us-ascii?Q?Z/u3QGJar/in6XE4XiZ6a9Kb9/+ybPpDVwvKFxKRy3uCi3tDWTO31nWpfxeF?=
 =?us-ascii?Q?PJvMt1sQxmD2NetLkDR385COGTLtu068+9LosxRM+cfs3Cl/6+o3l4M2UEZX?=
 =?us-ascii?Q?N33V83hUuaevH1OJmC6uBbaUxbUAGNagej82LtiokfzdVrhBbS+69HlVBTb2?=
 =?us-ascii?Q?HzBGCWJPeF0NB2Nvp58lH9F8N5FJKswJEy2tr17pFFSZi0fuzbrysycklIht?=
 =?us-ascii?Q?GAEGKX2UBGb96uqJhoMmoWiDjWkZHA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cc58bf-d6da-4eef-6df6-08d8c15707c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 17:31:20.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FljgXWe3O4uabZfY5lkNKPu0ko/SAL+6SwjuO4rbD93tulwkrANSDlgK8+11jihWak+BAPP3U5mtlZcdlIje93AiaZed6699dnC6F2ymY/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/01/2021 07:22, Naohiro Aota wrote:=0A=
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which=
=0A=
> is intended to be used by file systems that directly add pages to a bio=
=0A=
> instead of using bio_iov_iter_get_pages().=0A=
> =0A=
> Cc: Jens Axboe <axboe@kernel.dk>=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
=0A=
=0A=
=0A=
Jens ping?=0A=
=0A=
=0A=
> ---=0A=
>  block/bio.c         | 33 +++++++++++++++++++++++++++++++++=0A=
>  include/linux/bio.h |  2 ++=0A=
>  2 files changed, 35 insertions(+)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 1f2cc1fbe283..2f21d2958b60 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -851,6 +851,39 @@ int bio_add_pc_page(struct request_queue *q, struct =
bio *bio,=0A=
>  }=0A=
>  EXPORT_SYMBOL(bio_add_pc_page);=0A=
>  =0A=
> +/**=0A=
> + * bio_add_zone_append_page - attempt to add page to zone-append bio=0A=
> + * @bio: destination bio=0A=
> + * @page: page to add=0A=
> + * @len: vec entry length=0A=
> + * @offset: vec entry offset=0A=
> + *=0A=
> + * Attempt to add a page to the bio_vec maplist of a bio that will be su=
bmitted=0A=
> + * for a zone-append request. This can fail for a number of reasons, suc=
h as the=0A=
> + * bio being full or the target block device is not a zoned block device=
 or=0A=
> + * other limitations of the target block device. The target block device=
 must=0A=
> + * allow bio's up to PAGE_SIZE, so it is always possible to add a single=
 page=0A=
> + * to an empty bio.=0A=
> + *=0A=
> + * Returns: number of bytes added to the bio, or 0 in case of a failure.=
=0A=
> + */=0A=
> +int bio_add_zone_append_page(struct bio *bio, struct page *page,=0A=
> +			     unsigned int len, unsigned int offset)=0A=
> +{=0A=
> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
> +	bool same_page =3D false;=0A=
> +=0A=
> +	if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_ZONE_APPEND))=0A=
> +		return 0;=0A=
> +=0A=
> +	if (WARN_ON_ONCE(!blk_queue_is_zoned(q)))=0A=
> +		return 0;=0A=
> +=0A=
> +	return bio_add_hw_page(q, bio, page, len, offset,=0A=
> +			       queue_max_zone_append_sectors(q), &same_page);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(bio_add_zone_append_page);=0A=
> +=0A=
>  /**=0A=
>   * __bio_try_merge_page - try appending data to an existing bvec.=0A=
>   * @bio: destination bio=0A=
> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
> index 1edda614f7ce..de62911473bb 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -455,6 +455,8 @@ void bio_chain(struct bio *, struct bio *);=0A=
>  extern int bio_add_page(struct bio *, struct page *, unsigned int,unsign=
ed int);=0A=
>  extern int bio_add_pc_page(struct request_queue *, struct bio *, struct =
page *,=0A=
>  			   unsigned int, unsigned int);=0A=
> +int bio_add_zone_append_page(struct bio *bio, struct page *page,=0A=
> +			     unsigned int len, unsigned int offset);=0A=
>  bool __bio_try_merge_page(struct bio *bio, struct page *page,=0A=
>  		unsigned int len, unsigned int off, bool *same_page);=0A=
>  void __bio_add_page(struct bio *bio, struct page *page,=0A=
> =0A=
=0A=
