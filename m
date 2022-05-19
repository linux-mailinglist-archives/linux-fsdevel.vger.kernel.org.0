Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345D752CDC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbiESH7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiESH7b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:59:31 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A137BF1;
        Thu, 19 May 2022 00:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652947170; x=1684483170;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mbJvuIx3HwTQ0FMunggQFkn+bCs/J96P9NqH3gzjaxo=;
  b=SEDKGvs5hqSxSGgEEa9pvxconDDZVzaaIVhSrxZJDlLpJWGGFx3CnMjt
   cKAquWxz8SmK27+AT3+H7RfCRCUPLOp5Nvtz+ZE8CkcetEkQi4AU3HxX7
   a0988JQ/4mdmd0/p0f1u3ohjoVXZQASfAPi5ZE/mB1W/mi8Axd9FkHEtL
   dc5jA3XrQ/ca//JfY6cnTOfe9mglc49TcZI+gvGlFw0VvmgQ3siZYIosV
   Mpi1CGsJXkxbz078m0Iyk6QAvw9KJM+hO5mD3XanZbMfwR43R3uAnizzt
   Wps1SNO5brZK8S7qxEW5/+niB2VgetYWyNiy/Ze6tsFKe3XH+nrJMFLZ6
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,237,1647273600"; 
   d="scan'208";a="312747531"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2022 15:59:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuEySeB57ZDxSwDHfp1F4vwtVHEilnsbmB9yFFIWc9t0cFPmmZiqgGZBTNU42eBKwPmtiro2cg9ZI9WQxixQ4rrnPcG3+ujyhi/h71ZSr2JikhX0Vcb2B0VO8ErinnamGFu9+QoiNHdAozZ1cjE1+OqL3Q7pIYrTkPoyQ8NpnoS3pZ2P5RQO8Jjnc2pKkty56GLnCAKUv7IB++AxZI7oaVB5abHfUhY3X8iioGJb1u5z3MmhYJD0XojRs47sw5rZdbSvSlXHSiiyTVehXHTueDEVqrJLCTk+LKZRzfvBsB5iIARKr2Ug5v1olG4BNg1Qh5iFpm5t2pkWcZ/pKcEFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77eTUi+otyfRdDlf0NHaMboEsjiOGAU4EQVHkJ3fIz4=;
 b=JwSdS6UqJmHPuDBZrpsnyhmcLveklo8ocM5G29M2BWEKwNeWLuR50DJ1lTyHOUcW2bfnUnZNkXm9MY+b8oPFGmIujCZTpc4qGVapsEp9DW0D/DwXQdZfuyaKUHhOCyymplDXSnZmYpeIRx4xOaWsuvJK0WreN2k9+VTQDIFo26Y/LW0wIDORy2homEUHD3m19KkGSnPgWfR2l/S2W+3DzNW+94OT/AZdc3VP/Ips/iTIMprX7x1JazpeHu0sWAjMALAervT5EGdEwilod35Ak6PcG5et1K5LpU9orOEnWVoO5kSC0AMD19/DHbpp46OuYO/VZDr/A07Rh4q+gM86kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77eTUi+otyfRdDlf0NHaMboEsjiOGAU4EQVHkJ3fIz4=;
 b=RIO7aDqSgaqTi64IYDmeNNQ0u7jHEuxuf7+TwaLubIqwhp9OUNvpsj87dHCi1tJDJFN5ZdMUMlwI/eYFIH1HRAAQmOsttdrFzoMFS/UxJiUFbsPjPcIxJ/fn3DqCZKIjBTpF/yvipglm+iI/5In8nfrTykwOx/JxIyHXAc5lw0w=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CY4PR04MB0185.namprd04.prod.outlook.com (2603:10b6:903:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Thu, 19 May
 2022 07:59:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::65d0:a39a:4bca:3eb5]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::65d0:a39a:4bca:3eb5%6]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 07:59:28 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices align
 with sb log offsets
Thread-Topic: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Thread-Index: AQHYaUWuK9pdWulqgUKkXVqwDmJuba0l2iwA
Date:   Thu, 19 May 2022 07:59:27 +0000
Message-ID: <20220519075926.6h4ka3qbo3vv26ve@naota-xeon>
References: <20220516165416.171196-1-p.raghav@samsung.com>
 <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
 <20220516165416.171196-9-p.raghav@samsung.com>
In-Reply-To: <20220516165416.171196-9-p.raghav@samsung.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c1be9c4-5f5a-46ca-3042-08da396d7f96
x-ms-traffictypediagnostic: CY4PR04MB0185:EE_
x-microsoft-antispam-prvs: <CY4PR04MB0185D8F46F90B48A3E3ADE168CD09@CY4PR04MB0185.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPTtZvGaDzov0qmE/4snG3XCS2e5fV1ofS7DXxoeI6+0AwitSamPDucpBmvPaYHDt6s+qfd0jS4rL0ikasJn/fiTej9eKA3cFglKUSjmybLA4uV6WR6mHerY8cRmUJDLi4LMtnpSzyRL5I8dmdf89A2T3fH0/II4s9Hn0xmnhA6KhJX4Do9S00v59UBw24o8zR+9W7d2IkOJ1+ztNGd1HKpopVJAjbMhyFsHwBnj4NTlPcPH9ZXu7IOW1q8kwK9rqI1fxDzDTV/IY3II9jGL1KQvCD5G0WRtNJoosjhSH+Ms4ozp+6dPBp676hJX9NY7LrRxL3hEo9/FjAgh91OnH4EQZ0PykgQHPJ3wuzzvPtVBXmxDVHMn0j0vBVwNZJGSE2B7Y/I0yZ5FZtciyUnLv7uYJYApwifbl5vVzdXTnYA6UHZSEBsy7Xl4SYmFPXRCEt8FFPcdq+B39x3OHWh5OQUy3KGxBiLsaAYhsQGYoLV9v0XTVEn6kS2FGv/NoYq6YGniCtsjillU6vRKHGzWpO6KvUVLPleDkDJ2pUUh7D4KPJwKj2RnWeObxFpVLXbY7Cf4oqku/0f93Be+nRqccGUMPDGhunFThTrjgFaFaws86JRO/9bO0llDp24T1YbkKLZlx0P/PymOTvJOn+/LvshOaodManM1720lM849sPt7QUTHlLTwEwvYjRi+eOYeS8BFfxy17X9ny9+exMrzhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(2906002)(6486002)(316002)(8676002)(83380400001)(66556008)(4326008)(66476007)(38100700002)(82960400001)(71200400001)(6506007)(33716001)(91956017)(7416002)(76116006)(66446008)(66946007)(122000001)(508600001)(1076003)(186003)(6916009)(64756008)(26005)(6512007)(5660300002)(86362001)(38070700005)(54906003)(8936002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0XmuPBaHCfJ6a0hZb0AY6Beme9KkZ6YkZSdDbQpu9TtESSupukodetyobN3s?=
 =?us-ascii?Q?L+6zYJ12L7ZEhl6gOnaxQq279nrMK4vJB/6g2VF0GsMv8b7xfceuzSe8ZQyZ?=
 =?us-ascii?Q?TdQ9Fxas6klCiMMRtxg/CvYLaGYc34BWoHsv0a9FI9D/eXGx/UszgWImUPdA?=
 =?us-ascii?Q?zVd/cdXX1kg81fscOrX/qh1gMvhY6od6E22tUcXtXzZ0dKqxosrGDnySFEbU?=
 =?us-ascii?Q?oN4EoePDOgSG+AEi9/kYPMeaNKfPM+MqFcBwBYidYtXuE2aFp+nGfu2VzK8N?=
 =?us-ascii?Q?y6Cvk86TKWpoVmhPecPHNK7F+xqnnUJof6dja2f/1rJ6tydynzM1WbsnjKpO?=
 =?us-ascii?Q?YuQDjBmlQqgYyD+Arfm4/dWjzIIJF22ZIlFtOGsiGzaQn1P5qlwYRAzwyjS3?=
 =?us-ascii?Q?x1YdUCpUOsmDW3t/I97M1CyYqObUxOYhYC0Gi1ELgCR6ukaClPFIpLtkVRCH?=
 =?us-ascii?Q?0GdjADumknm58SjAQZ2nVSsgZbDQGEb8d3G52lebZPAhjEnLygHB3mPAmOa1?=
 =?us-ascii?Q?pW93L7h0rgZl8unQcZnj22Wc5KLM6pzuVzwLzAdBKe4L2gZtoeta9E6GzWF2?=
 =?us-ascii?Q?R5feTZyE7S09YaSZNhytoGbXLcsncL2XlCWS4/Hs5vf+TBMkRpjPJoof1+3t?=
 =?us-ascii?Q?89tOfwHQJ2LX1IPmpqAa3mwfEpphS3/DARC+wDoLdMbM6/VXKtyGKBQ0eAvF?=
 =?us-ascii?Q?Lg1qX+Xt97Hvzu0O9P2z18qnacKQ5e7Lz/HCf1eiJg1afog3guErVPrdkiqr?=
 =?us-ascii?Q?LGkJ25h6REGZ7uLLpe4BvcsjWbdsuSAvMYxoTKzZ6T/2ncjjoYMCTHxmmCmo?=
 =?us-ascii?Q?QuD9kWFFDD2rWYx0zB3j/M+DjdwEAg/CSriWw8L+1pQtfy5Z50Kve1cnWow7?=
 =?us-ascii?Q?D0Mq94NOcWhnUJqFSAqdNfWvulcwYDbUYKNQg0VOIsuyYqN/gXd2GnjwPPZk?=
 =?us-ascii?Q?mnSs82ZeqjGXHpiRADT1uug0SjDBFHIlVzCBhLiT/nPF6AiBC4LumHYSbU7+?=
 =?us-ascii?Q?bAkJ0VoR3wMZ7etEvkaDRPL3wu1cEPLo1ukVEpB2bFIoROHurFaKfacUqsjw?=
 =?us-ascii?Q?T+VbqI71j3ZRkLG/Irl/EoOVcOh88+3xD35XwYo2xTyNQJi5zp+QvWLJSYz2?=
 =?us-ascii?Q?1ql749EVevSKS6Kkfkh5BsZ1j4K+rJo+JgYWuIgI9lXs6AJlAhQ5IricsA5F?=
 =?us-ascii?Q?+0tT8OTTQ7QmXOJ4wfLsbSqhID2w2eIxXiwP+lcan8uV0aDuUqvIiF0DNKuD?=
 =?us-ascii?Q?16Gx2eVq9TJqNZhA8GwjKdvKf4J8mM1RDSq2yJw4jE7xk7NgGiv51FwnMkQG?=
 =?us-ascii?Q?gb3wo7T2mly9b8mRsW+ELccb3gZmZmReJTMBc6Qx75+9yjXItw62Mg46b4jt?=
 =?us-ascii?Q?LmyWAoolrcmh1e2OIzRth59nieUtcp6HBEd6x4bpXayJGf+rznSGiK4DWu6s?=
 =?us-ascii?Q?w2GldoP1fm8E2p1szoeaVbryZ2la4LT/K0bpLnYdhuLBlAUu+iq4aFiR+lCJ?=
 =?us-ascii?Q?QSJvlOzkW4a6IlcKKOB6Z6zQ7fgm+LiJ+FbPk6DPg86yCvLzoSPY8Z3BNL+Z?=
 =?us-ascii?Q?vl/7BxIr8rHPA7u7Vhdub2tQ0vtO5sfAwmuImXFIq8KXlQCFj7iLZFFFT8KQ?=
 =?us-ascii?Q?zhQZmN/sSZ+Ym4e/C5DIZITEBMYnGxp8cY4Au2IhE4pftPnKEb7UtqBwjVhS?=
 =?us-ascii?Q?wzjse+4UOuQY4n2DnIgpkmHSgG6WJzUTbpDa5R5KpCFYRftliaBjTwFgf5w1?=
 =?us-ascii?Q?zZm0P4kndXjiuBjgMjk0h+zy9dhEobw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F953BA55E83C847B01213B4210A659D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1be9c4-5f5a-46ca-3042-08da396d7f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 07:59:28.0645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2Zog4ru/vb4vmw93OTC8/MzTsV9ZvamhHuiG2Y3PXn/vnIcYCac56mdrjWVvYTZ8FsSeD6zmJwTktbWjq2m8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0185
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 06:54:11PM +0200, Pankaj Raghav wrote:
> Superblocks for zoned devices are fixed as 2 zones at 0, 512GB and 4TB.
> These are fixed at these locations so that recovery tools can reliably
> retrieve the superblocks even if one of the mirror gets corrupted.
>=20
> power of 2 zone sizes align at these offsets irrespective of their
> value but non power of 2 zone sizes will not align.
>=20
> To make sure the first zone at mirror 1 and mirror 2 align, write zero
> operation is performed to move the write pointer of the first zone to
> the expected offset. This operation is performed only after a zone reset
> of the first zone, i.e., when the second zone that contains the sb is FUL=
L.
>=20
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  fs/btrfs/zoned.c | 68 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 3023c871e..805aeaa76 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -760,11 +760,44 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_inf=
o *info)
>  	return 0;
>  }
> =20
> +static int fill_sb_wp_offset(struct block_device *bdev, struct blk_zone =
*zone,
> +			     int mirror, u64 *wp_ret)
> +{
> +	u64 offset =3D 0;
> +	int ret =3D 0;
> +
> +	ASSERT(!is_power_of_two_u64(zone->len));
> +	ASSERT(zone->wp =3D=3D zone->start);
> +	ASSERT(mirror !=3D 0);
> +
> +	switch (mirror) {
> +	case 1:
> +		div64_u64_rem(BTRFS_SB_LOG_FIRST_OFFSET >> SECTOR_SHIFT,
> +			      zone->len, &offset);
> +		break;
> +	case 2:
> +		div64_u64_rem(BTRFS_SB_LOG_SECOND_OFFSET >> SECTOR_SHIFT,
> +			      zone->len, &offset);
> +		break;
> +	}
> +
> +	ret =3D  blkdev_issue_zeroout(bdev, zone->start, offset, GFP_NOFS, 0);
> +	if (ret)
> +		return ret;
> +
> +	zone->wp +=3D offset;
> +	zone->cond =3D BLK_ZONE_COND_IMP_OPEN;
> +	*wp_ret =3D zone->wp << SECTOR_SHIFT;
> +
> +	return 0;
> +}
> +
>  static int sb_log_location(struct block_device *bdev, struct blk_zone *z=
ones,
> -			   int rw, u64 *bytenr_ret)
> +			   int rw, int mirror, u64 *bytenr_ret)
>  {
>  	u64 wp;
>  	int ret;
> +	bool zones_empty =3D false;
> =20
>  	if (zones[0].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {
>  		*bytenr_ret =3D zones[0].start << SECTOR_SHIFT;
> @@ -775,13 +808,31 @@ static int sb_log_location(struct block_device *bde=
v, struct blk_zone *zones,
>  	if (ret !=3D -ENOENT && ret < 0)
>  		return ret;
> =20
> +	if (ret =3D=3D -ENOENT)
> +		zones_empty =3D true;
> +

I think, we don't need this. We need to issue the zeroout when
zones[0]->cond =3D=3D BLK_ZONE_COND_EMPTY && !is_power_of_2(...) after send=
ing
ZONE_RESET if necessary. No?

>  	if (rw =3D=3D WRITE) {
>  		struct blk_zone *reset =3D NULL;
> +		bool is_sb_offset_write_req =3D false;
> +		u32 reset_zone_nr =3D -1;
> =20
> -		if (wp =3D=3D zones[0].start << SECTOR_SHIFT)
> +		if (wp =3D=3D zones[0].start << SECTOR_SHIFT) {
>  			reset =3D &zones[0];
> -		else if (wp =3D=3D zones[1].start << SECTOR_SHIFT)
> +			reset_zone_nr =3D 0;
> +		} else if (wp =3D=3D zones[1].start << SECTOR_SHIFT) {
>  			reset =3D &zones[1];
> +			reset_zone_nr =3D 1;
> +		}
> +
> +		/*
> +		 * Non po2 zone sizes will not align naturally at
> +		 * mirror 1 (512GB) and mirror 2 (4TB). The wp of the
> +		 * 1st zone in those superblock mirrors need to be
> +		 * moved to align at those offsets.
> +		 */
> +		is_sb_offset_write_req =3D
> +			(zones_empty || (reset_zone_nr =3D=3D 0)) && mirror &&
> +			!is_power_of_2(zones[0].len);
> =20
>  		if (reset && reset->cond !=3D BLK_ZONE_COND_EMPTY) {
>  			ASSERT(sb_zone_is_full(reset));
> @@ -795,6 +846,13 @@ static int sb_log_location(struct block_device *bdev=
, struct blk_zone *zones,
>  			reset->cond =3D BLK_ZONE_COND_EMPTY;
>  			reset->wp =3D reset->start;
>  		}
> +
> +		if (is_sb_offset_write_req) {
> +			ret =3D fill_sb_wp_offset(bdev, &zones[0], mirror, &wp);
> +			if (ret)
> +				return ret;
> +		}
> +
>  	} else if (ret !=3D -ENOENT) {
>  		/*
>  		 * For READ, we want the previous one. Move write pointer to
> @@ -851,7 +909,7 @@ int btrfs_sb_log_location_bdev(struct block_device *b=
dev, int mirror, int rw,
>  	if (ret !=3D BTRFS_NR_SB_LOG_ZONES)
>  		return -EIO;
> =20
> -	return sb_log_location(bdev, zones, rw, bytenr_ret);
> +	return sb_log_location(bdev, zones, rw, mirror, bytenr_ret);
>  }
> =20
>  int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int r=
w,
> @@ -877,7 +935,7 @@ int btrfs_sb_log_location(struct btrfs_device *device=
, int mirror, int rw,
> =20
>  	return sb_log_location(device->bdev,
>  			       &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror],
> -			       rw, bytenr_ret);
> +			       rw, mirror, bytenr_ret);
>  }
> =20
>  static inline bool is_sb_log_zone(struct btrfs_zoned_device_info *zinfo,
> --=20
> 2.25.1
> =
