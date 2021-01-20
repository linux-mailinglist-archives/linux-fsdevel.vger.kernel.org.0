Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885462FD25E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 15:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbhATOJi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 09:09:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29396 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388056AbhATNfj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611149738; x=1642685738;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5IyDtbbq0Ai+Igdal8yM7BLWX5g76602zJiiqAm84CI=;
  b=pbfLRIQFV+DeV+8w3JE+fJqHBd73QjztxWL7QDUQXfwvv0sp7iYkhyNa
   ZkFdP7OlNdCVgRVSNXDLb08JkUaYb2HBKlBvH6/y4WX1ZhT6aird7B8J4
   AmApry9PqoNEQeVJm+NDI3bbf/ue2X2nEQnF2oT4DIgfd+WY1nOP/wdS7
   2NpJrYI1/osczvFa6N41Os6N0m9nuKAbqAmMgJ1/pHOtj+t3oUx73LfWF
   Ld+fpuiosepZXXReZyHOBGpP7jzqRat8NoXG6xh5luaTQIZ7yWmiNlDZ3
   O0P1psqgRiZVLuwV+QPGwO179lSQf4XpGCHMVCe98eu4ZaiVTdQPzlieA
   w==;
IronPort-SDR: Rqq9biSEi/NuYpKpOxYGhQezVq6yTymkj7XPfgPf14liqPrK7VBrrTWcIbibVk2M9DV5T4jyOG
 VSeg+UYfoyIoH2B5Y/ktERqTrCA49dYBIBrXUPwzknTEMFVWhjfa9swR8v9GcNkRoUKownw04Q
 S0yDwz+siTnmENehEJ+NyeLTCM15tuCky8kg3+cZ1wTREJ340KT7d4GVHkRcxxDRrQ+y6kPyk3
 6+o7AvpkXzegENx64LsYArAfnrLcMZej6VVMRNxm3I8S1e61mso9rVogPb/7NG0n1s9rldmFsN
 SUs=
X-IronPort-AV: E=Sophos;i="5.79,361,1602518400"; 
   d="scan'208";a="268221340"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2021 21:34:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBRINeHcFmSyp8YJ+uSnDHwDXqC96JufqvnCAYNZTriiBW8BIhOmO3BD/7MviDndiJBtx8H3cdNvyHf88K2QbmCF//bLDr2uueF+/diladfKNmg/zT2wu+I9wIpa4/B8XaZ32qJYPh/oeOrf2WQ83OYFYzyPF2kFHlZd03wMfy42XE5Y1eGABF+BGt5eYx13GJHZyRCbX8auK6g+ODhQko6k1Mkw9+3/zamggPqONC08ZodxtTCqKPZ+JQWPJG6gWdd/vIRETPW9er9I8hGZ5PrIjHwHoaECUgjg/ve+TIZLxpHFqZjIqeHl/DSEsuP09zMp5kuGcYAuiOfpzYsWvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBvFXSVG0U7LuwInOeSy1pCw3/uYnica0FF1rA6bG4M=;
 b=f279X1MpKDOJbeIYvZAUzhSojjG/spILAaJ/tF9p1HmTbUDSkfvp8Cc64JYq/KVDRslEE/4jge2RY0cfUQuFw5WeOjBu1KE4OPEa/aeQ9vfPD6Pn26zBMkjEfcqTfnRtZjZkWbtOufsTLK3/jzjuejNe0BCtG/voDPbxbD1hJ1e2Uwp1uj5sJRj7ywX+DizVmytRa7QXGtm+3WaJwoSGZ43Jo9MW98PrhUhglxZ+6TR8GslWJl1NtgXK28LQp+bfWbjzKKpV+LsdPhwqrzenbp3BN2lj9ieoZVnxJfPAY6tbHZa/3btXzP0x2uCGHFehR9Rfuwv5VNvge2oXrQqkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBvFXSVG0U7LuwInOeSy1pCw3/uYnica0FF1rA6bG4M=;
 b=k/iRNye9oBumNXAtM55Tz0b+xjteNW18s4LGRP7AnOnNZL56L66zAQZHgkfqKhwhl3h9buuNZdcjBvbqodHZGie0YYXdzajcYXPeUwgzjlKseqN5WSdX0EJ9Ck15Ikb9QL3xpaMp9WmUQiNYjEYJcpbGoO9bTjcAjKDmmi59m6Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2318.namprd04.prod.outlook.com
 (2603:10b6:804:17::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 20 Jan
 2021 13:34:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::146f:bed3:ce59:c87e%3]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 13:34:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v12 01/41] block: add bio_add_zone_append_page
Thread-Topic: [PATCH v12 01/41] block: add bio_add_zone_append_page
Thread-Index: AQHW6wtfLhyEpPQ4f0yEeJ2i3A71OQ==
Date:   Wed, 20 Jan 2021 13:34:25 +0000
Message-ID: <SN4PR0401MB35989D795E51F9C2D5F9AE0E9BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <8d02dae71ff7ec934bc3155850e2e2b030b7dbbe.1610693037.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c4:1c01:1587:d74f:253e:d796]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d1431d4-7649-4e77-00cf-08d8bd481ab6
x-ms-traffictypediagnostic: SN2PR04MB2318:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN2PR04MB23183138C0A4BD48D52F141B9BA20@SN2PR04MB2318.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6VLwl+6LRdGYicX+auaEixuZxZ7WNPKPsa9y2snLtLkEnLf41+Q81h+FTZui3yUHIMgbTAS/2e5TvotwAGc7bJ6jPXxm1aPO0paS1+8ZRgFJbhuQppijfENqba+4LehKnLlDeU5vcz0RXviQ34hmmnfGfDo+96f6skGHLZ/gZOzbKhrx7KLgC2BSuvlkh4SD4+bWBMBBo8EMG4l9qv5Q/rSZecSsTBpWT/XJgFLgOCX6Nhus8+g5LGIuzxT9dBnimZgYOUnKDHgxG1yo3tJT+7lw4fA6RpAPkWppCioAJy6h2VHjZO4E2HlTHwXpCm3ru3jFuwAGT+U74mf/C+xXWLiFT6ufKisPO7iSWXz12aUTnxKXxcKfKknry/1VXHI5D5H7nVglHjlVZFlVyPWuTu/Df4C3R1tLjXV4qSMYI9N2y41JBSoiBvjC6xD6n41goqLn1dmlCOoZasFZnsEOwP8hHfJWluxVdByn4qvftp7ng0s+Y8k30UDqekR+/w9M2uZ/9H+W8FYXz0ME2HE7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(55016002)(2906002)(83380400001)(91956017)(53546011)(6506007)(76116006)(66476007)(8936002)(66446008)(64756008)(5660300002)(8676002)(66946007)(54906003)(6916009)(66556008)(33656002)(316002)(7696005)(478600001)(86362001)(9686003)(4326008)(52536014)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hZShK1nuwxtN0Eu97mKd+M+JHHzOLSgIzCbka3WePrc5f9udGJPzmwWT/hqU?=
 =?us-ascii?Q?VRRjfGcq66/z1c62OWatvvg2/5q81QeGkzQ6WR5y4V7i3d86UqeX3OlRuibW?=
 =?us-ascii?Q?kXtLAmxolDhHr0TenFUDcYJbkDKLSX/k/9ss0C+AlY4d3o42pJ8XpA3vqNUP?=
 =?us-ascii?Q?OazzdB1jNHC8Uc6jZzHZExUpDS5AzFLKr2bNQtvLHxxZEBqji5n/gMF9eBfQ?=
 =?us-ascii?Q?0wt2/TNBcr/yt3lclfCGKDw+c8QfD4qrPIMsq2ROYdhFxs9WW8KzPsKlkSJ2?=
 =?us-ascii?Q?xq3QHYYUsXW2lwtb28GLd5ntKnSi2WmKy/ftp+pW7NckSadZLtw95I666L4r?=
 =?us-ascii?Q?g5wtc3K2nnWRI8GMZyBZghkminb54pGDvfQExoUXpzoV54NQOW0Qq9rSfAwp?=
 =?us-ascii?Q?8B1g3m3S9c3GP8tKW2pUTPWPB8idKoYqkgzkjXPGeYkF+McLfzRb1rkTldvE?=
 =?us-ascii?Q?mWk5+8Os7fUk9UERxXMiaIMe77lSgCKbJRNQy3HsqtZ28WVhrOdegmRrjefE?=
 =?us-ascii?Q?F2xH/2rFGWYNBghqBGN2+LWLmpZxKyqDmE4mWqNlHB9MWc/rBEByZrqYTKyS?=
 =?us-ascii?Q?q3p4QNadUCxcVs+B6BK2QckE1zfpBOQO7bmAQDHClOpg6o45/LxokeJbf5hC?=
 =?us-ascii?Q?jJulQy/9CT9sAjdCMQiocLQjIqfnaQddp1YZatiY0T9vNEFsxx8OtnS7hjvS?=
 =?us-ascii?Q?T0EvKgaVyFoA6gBwwRKI+dQNgYegNyN0xQpwpEigbJCfEVZbdsCVs1ZknLOY?=
 =?us-ascii?Q?rCFGLdd88myU2FAIFntx8XB8LR+6oZ9x4i/AUT9/t8aDp2N4oFB5kvrkYwqo?=
 =?us-ascii?Q?mK+yvdoFK7P4rsZvuR5lvO8GixLjU9hL8J6Nu7ch0MaJt/Mb6vOdGPhx0YP6?=
 =?us-ascii?Q?OQUfIddUWp7oWnmRwYFMZ1iGErpflXhQ+muiYtHB0rchFSowIeRnrcOIsDNr?=
 =?us-ascii?Q?Q0o34Y8l11afbczqhY/JYa2qgS07iGTrNLcsAmEbyfzU9nykYtTfu5ks2/zM?=
 =?us-ascii?Q?3UeMI6ecMrJWNaV5k6ULaHT0jGNhxClE65fT8lXtmV1+O1eOuNvU0KlWQI8K?=
 =?us-ascii?Q?Af8Xq375?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1431d4-7649-4e77-00cf-08d8bd481ab6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 13:34:25.4746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B5zlkiIjqjgusbPSsspVUdTnpRqwYdVpGZjNui3Sy9FjMUQlL/O1EXA2uAgTT8BTZfMcQJ9XO8+0yis/fNTD6NWE0qXnHfSuDXBM33gki3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2318
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/01/2021 07:55, Naohiro Aota wrote:=0A=
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> Add bio_add_zone_append_page(), a wrapper around bio_add_hw_page() which=
=0A=
> is intended to be used by file systems that directly add pages to a bio=
=0A=
> instead of using bio_iov_iter_get_pages().=0A=
> =0A=
> Cc: Jens Axboe <axboe@kernel.dk>=0A=
=0A=
Jens, can I have an Ack fro you on this one? Christoph and Josef are fine w=
ith=0A=
it.=0A=
=0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> ---=0A=
>  block/bio.c         | 33 +++++++++++++++++++++++++++++++++=0A=
>  include/linux/bio.h |  2 ++=0A=
>  2 files changed, 35 insertions(+)=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index fa01bef35bb1..a5c534bfe999 100644=0A=
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
> index c6d765382926..7ef300cb4e9a 100644=0A=
> --- a/include/linux/bio.h=0A=
> +++ b/include/linux/bio.h=0A=
> @@ -442,6 +442,8 @@ void bio_chain(struct bio *, struct bio *);=0A=
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
