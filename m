Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5891C4D7961
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 03:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235926AbiCNCc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Mar 2022 22:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiCNCc4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:32:56 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB5117D;
        Sun, 13 Mar 2022 19:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647225106; x=1678761106;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4X9qH6md3ony398BMbDt4KwSqwv7UakHNJ19w+/+kDw=;
  b=A2atLCs6PjLeJeEIG70vGRAPLILpV+0WALZ2WN9K+3fTclQh8VB0JtI5
   5qKK9jVVFhZScdEgdwwJBET0A03G/PoNjp+o9wnFwKtoPK5YGOqXCtzZv
   IzCSH3GwvzZ5P6IWfSIOVo/PR5HzEQbxh42ZHwP2byZ1MYH16VdFJfF6L
   w9PgQBCqg5sZrjUUrxLLQz+FRVeKojK4206mEn42oE3tvRl7IEJ9zEf8E
   IqX1u2eSDJ10c7LRRg6te1GLMLIawaf029lVfsMd2d0/Cnj4TfcMtFgic
   qy24q8tAGh/oQXO6tETkfkc/2LNT1/6Eb8hKXQDJUV2DO9q7Oh+ayY9VL
   g==;
X-IronPort-AV: E=Sophos;i="5.90,179,1643644800"; 
   d="scan'208";a="200099824"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 10:31:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFC3IOpVbqIRGoPzXez7umuyNcM6Ifi511y3UzlpvlAIT8Ay7CxnWwTWq6sPbrfLAseM8BQkYlcuOSOO2REA/RqZtWBVSCrFcsuQt++g6d7mlzjFivqqpozePqoPXIW75J3GEvo6EWExZj/y2Hwxc5KFYeuzn1biEzRs/5cue0WW7Kl2nfsLncy+FdZrE0peamGaxburQTrMFel5eBdoWzbzMkary6741IMNdtEIRKDPYabm6vv3a+3WZT7VUZcQWZqXL9sppGCyV5ujHvtnMafEiWpwoN10qA3UTvnYGz+mnuthU+OBKrz/qzbtnGVmQv2VH2XHyq+vgpajEAtCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/0h3Uc88hQqCeXorELYezr7+z08wGFbvOXQk5xwnhI=;
 b=LCpab7wAkjl6DWMpljdIhkXBn53f31XnkHbhBKKdBpszaPwjgl2/leU0iLrZnHVGpQLNOfDH0ryr9jjwH686dVAV8qeA+IJZNdZXenQdImt+H+ZSI1obei0bMfxfYDsE9mTQf7t5HF/J7w+H0K6kJAuBUHbeabMwwr/fD9Bgvrj+ul3BUg92ZFFwtoFmQEY2ARNFc0xwizlYD6umTW/WrXVSjNueN0PRHK4l7uZwY4HeqUywe2iKM7WXmFsGEM82ecVyh3HBlu5j6y+1jcQ5S+GyD5skJs9agLnX/axaYdp3u7MWPJRlcudDZTXLds239l3MHGEf7zJcfZRx/zAk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/0h3Uc88hQqCeXorELYezr7+z08wGFbvOXQk5xwnhI=;
 b=qJudND31L+oay75orEafYahKTQwf9Mod2YufD5bfxcgY4xxieeHIl2/zX3p6dX91l/mlbX4g5eey32Ost4J8l8Vxeylyo9b3vkLd8wLBftm9A++m1+gaYvNg96uMZbqKmqXHNeYfa/Y+Z9fMGm4qHmmbn2QOdpbJzo+SGMtx++U=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CY4PR04MB0886.namprd04.prod.outlook.com (2603:10b6:910:53::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 02:31:45 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 02:31:45 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Filipe Manana <fdmanana@kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH 2/4] btrfs: mark device addition as sb_writing
Thread-Topic: [PATCH 2/4] btrfs: mark device addition as sb_writing
Thread-Index: AQHYNRsO6R6lbAYy/UuvPTOcTTVHXKy6PFEAgAPwwwA=
Date:   Mon, 14 Mar 2022 02:31:45 +0000
Message-ID: <20220314023144.cejaefhbc7lwpiwv@naota-xeon>
References: <cover.1646983176.git.naohiro.aota@wdc.com>
 <09e63a62afe0c03bac24cfbfe37316f97e13e113.1646983176.git.naohiro.aota@wdc.com>
 <Yita2kwuHzjCkH+z@debian9.Home>
In-Reply-To: <Yita2kwuHzjCkH+z@debian9.Home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930ede70-c2c5-4dce-f12b-08da0562c849
x-ms-traffictypediagnostic: CY4PR04MB0886:EE_
x-microsoft-antispam-prvs: <CY4PR04MB08860BDD76B7F5D7D566CA0D8C0F9@CY4PR04MB0886.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGXr/LbqmjJRhYH59wiEu0mMWVf1he9XcWzCMijaL6e95u9ShquuBt+GEqASTLCr3kEGIJvt0PXujGtlqBS/3oYuzM0SaZLMoHOMw518gAVITFhAMTQanDi8YmhYrCvUaNhejeTQQGcC+3kVVMt2lp3bo/PK5VqJWPK3pBLu29krDIOTh8C250i7gvQd7SolvoFNVM5ptfjgr738M7AmK5eKEQzBfELWCv1mpcrXeDriGFfP6Qn8fDdlAZ836I0ndJTgwZSc55r5/zmMB60rGvi6h8Sdt22IvRCRaNw6a1GPwj2eJ/qF8KdYhvEc3VhjGBkTR5E6zY6jbWQ1dE1KCRYD+O0gWE5T990Ki0z/8GF3KQBBJz0GV90MKBaBrrde0yIj3kXORXELPxRpEyducY3GFBpa5irTKRiCcRh4w/NrOHA8HG/ZpHlTvPsbO/rTVvvvlWXqgQAr1PBth7swb5wEQK9+xL4CZfB+/KfpXzt7xZSHUhL5+KXf2mCf1ZGSj8p35wfmYBB0LBCUbaZPgJQYgsuzDbV7fYHiuOouHVTFqXanaEjW8uXlEF8CrpsAWrl/MV/CRAoLvonD2CV/UZBvInOnEP3O/LbIXiTgaXImsz/9sLq0TtqQVQ9IbDO51F/qNODflFm6n3d4cahfONwiljZTDtbCTlJxPq/IYF9OOCZvkIz4+A137yPiT5hwR9b5NPS9NFNVaeLi2nt5jQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6506007)(54906003)(9686003)(6512007)(2906002)(38070700005)(6916009)(316002)(122000001)(38100700002)(82960400001)(508600001)(66556008)(66476007)(86362001)(66446008)(64756008)(5660300002)(8676002)(66946007)(71200400001)(4326008)(91956017)(6486002)(76116006)(83380400001)(8936002)(33716001)(186003)(26005)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QGz1bbG6H4mvLCf+0YOutmz4xlYkY2GpiWNdBM3P/HKyiTNzrhJtWkumWszH?=
 =?us-ascii?Q?SmPl8ZtAK/3iid3flAHLVMDmANdZSbNPcTFNBqWQXEpKD8gdUkAcmmHJN20L?=
 =?us-ascii?Q?eQnEIh58PAKE7e3dKb4juJ4oTM1IrnXhr+nB2ipovB5nbR29y9Pto2d9F1+Y?=
 =?us-ascii?Q?SOXv6hhdycbsWjtFG3/7MuKyVe/sd1NbPjrxz8gEcM/4FAWOAasubtGeY+II?=
 =?us-ascii?Q?5Z7pV8sUwdZtUdABHMmTEDBUkbpLnNhXJWVG6UIpDrSkerq/ACpk3MbKDSUV?=
 =?us-ascii?Q?U8DULzfyTalHTqRky/Hix44sJ94Hyj1EmRmbWuRYF1uWI1wh8rQB7Fsj06Uk?=
 =?us-ascii?Q?bcoTSSc482U7HxTyR4tFPLs8iMrqTfPmkW8z2mq88LdXt9x5BHwbbao1ag6j?=
 =?us-ascii?Q?yUzGexuvaydqKpFioyDVProedO/0U+mwauH6OikUQZuOp2fYLiZubhIwhCVM?=
 =?us-ascii?Q?Z3J0EEx6ut5YLJUZDY3bByYSghY5jMQuDmrmScH9ErBx7cjE6TRJwxhBuBxy?=
 =?us-ascii?Q?eO37zXzXmEVCf0D88EFZKtsrBynhZM8LqIdFJMi7SO1poJx0YhOITZ+twwn8?=
 =?us-ascii?Q?FDPcDP7Nxcsa41fzu7w2s4pi1HaCZFJZ7am++reW+BUrt94gK+pPmwTHKTgD?=
 =?us-ascii?Q?6yqRVzyw4iNqLMsvCYcuTgcebCwLQwkAtbxtCIZig5OqajnVuIQ0S8sxnhHh?=
 =?us-ascii?Q?aC68+0jGrtmWN5m4l8mhEyK0I6+vyFFzjssItKeXOONHV1hQSJDAEXCeg1Xp?=
 =?us-ascii?Q?1Iv0dkvBxFo82WAAdOBII2m61GAcgT3cGAv1WUVNTYcbWQQTp1twC5z+gcuP?=
 =?us-ascii?Q?pd2ntMkE6Ljh5/8C5q63nfoi3GnCtfHoOR4+A09e+5PwVrjEcoJKWE4b+7Pm?=
 =?us-ascii?Q?2tfzeW2M9xqB56D7mlgZO9bgCEiiQ/wXtRv0rm8GwhLx1ghwWhKMTp3z9oOI?=
 =?us-ascii?Q?XDW1fMTXmtZzf3C4CQ4CvK79frV+TLWzHIyU1LRWZozcACfSUY0wl2UX78Wk?=
 =?us-ascii?Q?D8npWMP9Qq8JIQeM7fEj28qhsh7a2UWXudrwxiTjFJErG1nQUgqhWEIgx09c?=
 =?us-ascii?Q?kgFa4iWkWkI5q6Na3IKef7WrV32zTks6Nar45NCsHSLSpoFZJ/3gC0wyQk4f?=
 =?us-ascii?Q?lW9uPG+uN6SI9RNqajvCQdHgRNg4xcGJaYPrCU2ISw9+JFbn9IK5hXTRTrQX?=
 =?us-ascii?Q?HpcjvaCHa3jFsnqkEUuJgfrrJjIvr2P60yhJR9oKi9RIwbfshMFlK+qOVQ5l?=
 =?us-ascii?Q?3Lj9TaBRMvFjdksffHjvJ+8HweDJ0IxUnZYP0whN7RKNcCTiZfkDILHOaT9f?=
 =?us-ascii?Q?7YkQOAvEEwru2mc7J48zH9EUSwTqO56qA1z0xZlEaUr+y/5KQk3TzSie4Nxu?=
 =?us-ascii?Q?mX2drX7Yxa+3TKdyRmiH6E61oY/4YcQ5biL2nMEZFSNuk+mIucwyourisjmk?=
 =?us-ascii?Q?S8+io9PedadXDiUNWANurjgnFiELsXASmYva5Okt8rDskqL+tgqKhQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2766574527163248BF5DE007B747F3B3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930ede70-c2c5-4dce-f12b-08da0562c849
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 02:31:45.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmzCAUWvAss9MazQWzLDGJxiOykvn8zzelv6QfEbmGeAB6L/a8k0KtHkYFagtfwYSX99tfEq3l4EmOb86PK78g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0886
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 02:21:14PM +0000, Filipe Manana wrote:
> On Fri, Mar 11, 2022 at 04:38:03PM +0900, Naohiro Aota wrote:
> > btrfs_init_new_device() calls btrfs_relocate_sys_chunk() which incurs
> > file-system internal writing. That writing can cause a deadlock with
> > FS freezing like as described in like as described in commit
> > 26559780b953 ("btrfs: zoned: mark relocation as writing").
> >=20
> > Mark the device addition as sb_writing. This is also consistent with
> > the removing device ioctl counterpart.
> >=20
> > Fixes: 5accdf82ba25 ("fs: Improve filesystem freezing handling")
>=20
> Same comment as the previous patch about this.
>=20
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/ioctl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 238cee5b5254..ffa30fd3eed2 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -3484,6 +3484,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_i=
nfo *fs_info, void __user *arg)
> >  		return -EINVAL;
> >  	}
> > =20
> > +	sb_start_write(fs_info->sb);
>=20
> Why not use mnt_want_write_file(), just like all the other ioctls that ne=
ed
> to do some change to the fs?

This is just because there are no "struct file *" here.

> We don't have the struct file * here at btrfs_ioctl_add_dev(), but we hav=
e
> it in its caller, btrfs_ioctl().

So, I'll fix the patch in this way. Thanks.

> Thanks.
>=20
> >  	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_ADD)) {
> >  		if (!btrfs_exclop_start_try_lock(fs_info, BTRFS_EXCLOP_DEV_ADD))
> >  			return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
> > @@ -3516,6 +3517,7 @@ static long btrfs_ioctl_add_dev(struct btrfs_fs_i=
nfo *fs_info, void __user *arg)
> >  		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
> >  	else
> >  		btrfs_exclop_finish(fs_info);
> > +	sb_end_write(fs_info->sb);
> >  	return ret;
> >  }
> > =20
> > --=20
> > 2.35.1
> > =
