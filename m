Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C8977B6AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjHNK2H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 06:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjHNK1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:27:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB2510F
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 03:27:51 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230814102748euoutp020203f440578354657bec4be82e66ab16~7ORn6pVca2919529195euoutp02q
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:27:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230814102748euoutp020203f440578354657bec4be82e66ab16~7ORn6pVca2919529195euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692008868;
        bh=ajwDShxVNbg+HvM3I3kKNILSIkNZ3aZZ+4CsThERfGc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=PEEiuoftIQBaV+3MdjHAcq+AOHJs52eIOn5u3JmuM+HMVZYyXYlgAoEiEg9BZiykj
         yKLZb7XRKXT6i2zIqlePs5u9ZXmt8navMun1IN2qS9bFk6jcQfBEbHkPlxhoL/Y1eQ
         4rdSB1IDGbZpCJAz2msLp0wFb5krH31XgEqIlEMc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230814102748eucas1p1e0aea6b2bc6a373034c4e45484da0d7a~7ORng-eDN0771107711eucas1p1N;
        Mon, 14 Aug 2023 10:27:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9A.7A.42423.4A10AD46; Mon, 14
        Aug 2023 11:27:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230814102748eucas1p269b8a53ed09fae1eb57dce3d2a7de752~7ORnPy8oz1818918189eucas1p2f;
        Mon, 14 Aug 2023 10:27:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230814102748eusmtrp17a0142b0237443c9639ad64688434d14~7ORnPQIuy0364103641eusmtrp1N;
        Mon, 14 Aug 2023 10:27:48 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-42-64da01a4fc0e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F5.73.10549.3A10AD46; Mon, 14
        Aug 2023 11:27:47 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230814102747eusmtip25ea4c33deed995ab619f320df474121a~7ORnCoBWJ1457814578eusmtip2L;
        Mon, 14 Aug 2023 10:27:47 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Mon, 14 Aug 2023 11:27:47 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Mon, 14 Aug
        2023 11:27:46 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Thread-Topic: [PATCH 28/29] xfs: Convert to bdev_open_by_path()
Thread-Index: AQHZzpn3frOw3CirWEi0FotpS5lDtg==
Date:   Mon, 14 Aug 2023 10:27:46 +0000
Message-ID: <3wo4aepjfabkpoqovt3d5j2fysgjahvd2dfli42nzjzfdklxp5@zsgzkmifxsbm>
In-Reply-To: <20230811110504.27514-28-jack@suse.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.67]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <281D9B9158C24A4583606B48DD4B4AA6@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xSYRjHe885wIHCjmTxrHtm66KS3al1W7Oiti7f2lxLSE9qoiJIWK4k
        u2iuko2mEy3NLmhbLimTxLChRmRpZRfFVtPILnwosZtGrODYxrffs+f/vL/nffeSuKCKNZlM
        Sc+ilekyeTibR9y+P9wRfRk5E2N6zSHiLleIuF1XhYnLSo5h4rvOSHHTXQchbvSaOevZkpvV
        CySma6fYkkeVrRzJkGn6TiKOtzqRlqccoJUL10p5yboLJYTi6fLs7ptXkBYNRhYiLgnUUui+
        UUQUIh4poKoRmJ53cJjiGwL9DzPbnxJQQwga+uH/RJXxE4sJGRFYdAUYU/wLfen8hpjiEQKv
        pWs0VoPAp+8h/PNsaj5YHSaOn8OoPdBWey8gxP0TzxzvWf7GBGot1P9qZjOhdWDRtrIYFsG5
        6jLMzwQ1By40PQ0wn9oGtU1/AhkutQTcRifyM6KmQX/NSECGU0Jwuiow5hKhUFXWhDM8CXyN
        fWyGo+DxKxdiOAbqr1gJhmdBwf0eNnNOFFRaPKO8EuztPzCGI+HqRTfO7BMKjlJX4FmBaubC
        s3f5o4JYGMwv4zA8AT7bb3F0KMoQtJ8hyGEIchiCHIYgRyViXUNCWq1KS6JVi9JpjUglS1Op
        05NECRlpJvTvG7X77B4zOv95UGRDGIlsCEg8PIzv3PwyUcBPlB08RCsz4pVqOa2yoSkkES7k
        R65xJAioJFkWnUrTClr5v4uR3MlabJeOzN5iVhYWxvePVey592RgnGb5i1LJ4poCzYYXlSX9
        RsXeGKIz2VeUihXzf61oGO+r06+quLFx2b4nRS17dz+M1poJ6ekp8+QbZuauHrtJvXFJXlvF
        ke8db1X73A8/WH4meFzSr/pyXqvFnIdzb51JlcSl9GWWRsi1BcOiMa/3v5e1nPTaL/8c0HvS
        3DN3xL/pHJHmjxiLx+EaU4785NzruS68rbc2InbiUnq/MLrZmvP768AdtadF42486EZTM6x0
        RNjHo+XWrV06aVb5EUWb1ynAiHW2GblbhQd6vVn2hj+HOobPzh5Df3jwKe+E7dX8xdnbow+H
        ZG6/hErrjocTqmTZogW4UiX7C5ShDPu1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURjAO7t3Dwvruikehlmtt9bV6aZb2QyiXFFZQYT2sKmXKU1n926W
        FbGKyBaRoSFttqa5TCux6bLyVbKUYVFqag2LyGVMsdRM0h7mvAb77/cdvt/3OHwchFvO5HPS
        MzUEmalQCVhz0ba/rR/W3gLO1HDdj2hJp2u+pC2vhCExFp5jSBqcoZL6BgcqefL7EXsjS159
        J0RurbjIkr8w29ny79bgXWgiHkOqtRpicZqa0mwQ7BdKInChVIJHiKS4MDL64LoIsSBMFpNK
        qNKzCTJMdhhPyzMVolntUcffVluADoyE6oEPB2IiWFLmZnqYi1kAtF/fTr8HwQdjXUyaefB3
        t56lB3Onc0YAHLIOIXTwAsCqcj2gg3IA3X/62B6Fha2GjQ7rDPtjh+DzyqdsTxLiMTocn2fq
        8jAZtP1sYtFJsbBOZ2fSjMOCO0aGh1FsOTTVt8+wL7YDVtb/mZ01EQ7nmlEP+2CRcLDMCTwM
        sIXwU/nkTGMEC4RO100GvQMGS+tfITQHQHff39nd1sCXPS5Aczi0WRpRmpfA3JZ3LLrOGmiu
        G51lKWxtG2fQHApvFw8i9Gx+0HHdheaBIINXa4OXbvDSDV66wUs3A2YF8Ce0VIYygxLilCKD
        0mYq8RR1hhVM38zDlonqR8A0MII3AwYHNAPIQQT+vs647lSub6oi5wRBqpNIrYqgmoF4+u+u
        IvyAFPX00WVqkoRR4WKhKEoaLpZGRQoCfbdm5Sq4mFKhIY4QRBZB/vcYHB++jrHe9sMhqwna
        5XcNTra6G23mK0WjsHROdnAvdeRXmHJBcEgolXD6ffdUsU9RQVxynZFXmbzC4jDHdsZ29k1x
        rY/T9dqJc6sS+nPmJV7sdedf2hww4l45KRi39BDjqmeGC+2rswQHeGSZ7NuiazsGttWWzPvY
        JV8+6upvGjLU3C9+vS2Oxy8A8QUb1KzNos/2+4O9Y3a+CM3hxnQcPanr35vQXOpCtlxYxja9
        3x14D6t6cJ5U5WdPVHT2Tn1VgpBvHXu2fzha0r/yxj7FeJl4p0n8ZuzVJumionWWqvh844Bh
        4Rfj+qW1pxw5x3412dSFTbKYyyfOYHcBe3iMPNsgFKBUmkIYgpCU4h82bS9IvAMAAA==
X-CMS-MailID: 20230814102748eucas1p269b8a53ed09fae1eb57dce3d2a7de752
X-Msg-Generator: CA
X-RootMTR: 20230814102748eucas1p269b8a53ed09fae1eb57dce3d2a7de752
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230814102748eucas1p269b8a53ed09fae1eb57dce3d2a7de752
References: <20230810171429.31759-1-jack@suse.cz>
        <20230811110504.27514-28-jack@suse.cz>
        <CGME20230814102748eucas1p269b8a53ed09fae1eb57dce3d2a7de752@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Jan,

On Fri, Aug 11, 2023 at 01:04:59PM +0200, Jan Kara wrote:
> Convert xfs to use bdev_open_by_path() and pass the handle around.
>
> CC: "Darrick J. Wong" <djwong@kernel.org>
> CC: linux-xfs@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/xfs/xfs_buf.c   | 11 +++++-----
>  fs/xfs/xfs_buf.h   |  3 ++-
>  fs/xfs/xfs_super.c | 54 +++++++++++++++++++++++++---------------------
>  3 files changed, 37 insertions(+), 31 deletions(-)
>
> diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
> index 15d1e5a7c2d3..461a5fb6155b 100644
> --- a/fs/xfs/xfs_buf.c
> +++ b/fs/xfs/xfs_buf.c
> @@ -1989,7 +1989,7 @@ xfs_setsize_buftarg_early(
>  struct xfs_buftarg *
>  xfs_alloc_buftarg(
>  	struct xfs_mount	*mp,
> -	struct block_device	*bdev)
> +	struct bdev_handle	*bdev_handle)
>  {
>  	xfs_buftarg_t		*btp;
>  	const struct dax_holder_operations *ops =3D NULL;
> @@ -2000,9 +2000,10 @@ xfs_alloc_buftarg(
>  	btp =3D kmem_zalloc(sizeof(*btp), KM_NOFS);
>
>  	btp->bt_mount =3D mp;
> -	btp->bt_dev =3D  bdev->bd_dev;
> -	btp->bt_bdev =3D bdev;
> -	btp->bt_daxdev =3D fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off,
> +	btp->bt_bdev_handle =3D bdev_handle;
> +	btp->bt_dev =3D  bdev_handle->bdev->bd_dev;
> +	btp->bt_bdev =3D bdev_handle->bdev;
> +	btp->bt_daxdev =3D fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_o=
ff,
>  					    mp, ops);
>
>  	/*
> @@ -2012,7 +2013,7 @@ xfs_alloc_buftarg(
>  	ratelimit_state_init(&btp->bt_ioerror_rl, 30 * HZ,
>  			     DEFAULT_RATELIMIT_BURST);
>
> -	if (xfs_setsize_buftarg_early(btp, bdev))
> +	if (xfs_setsize_buftarg_early(btp, btp->bt_bdev))

This can now be simplified to one parameter. And use the btp->bt_bdev
directly when invoking bdev_logical_block_size.

>  		goto error_free;
>
>  	if (list_lru_init(&btp->bt_lru))
> diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
> index 549c60942208..f6418c1312f5 100644
> --- a/fs/xfs/xfs_buf.h
> +++ b/fs/xfs/xfs_buf.h
> @@ -92,6 +92,7 @@ typedef unsigned int xfs_buf_flags_t;
>   */
>  typedef struct xfs_buftarg {
>  	dev_t			bt_dev;
> +	struct bdev_handle	*bt_bdev_handle;
>  	struct block_device	*bt_bdev;
>  	struct dax_device	*bt_daxdev;
>  	u64			bt_dax_part_off;
> @@ -351,7 +352,7 @@ xfs_buf_update_cksum(struct xfs_buf *bp, unsigned lon=
g cksum_offset)
>   *	Handling of buftargs.
>   */
>  struct xfs_buftarg *xfs_alloc_buftarg(struct xfs_mount *mp,
> -		struct block_device *bdev);
> +		struct bdev_handle *bdev_handle);
>  extern void xfs_free_buftarg(struct xfs_buftarg *);
>  extern void xfs_buftarg_wait(struct xfs_buftarg *);
>  extern void xfs_buftarg_drain(struct xfs_buftarg *);
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 5340f2dc28bd..6189f726b309 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -381,14 +381,15 @@ STATIC int
>  xfs_blkdev_get(
>  	xfs_mount_t		*mp,
>  	const char		*name,
> -	struct block_device	**bdevp)
> +	struct bdev_handle	**handlep)
>  {
>  	int			error =3D 0;
>
> -	*bdevp =3D blkdev_get_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
> -				    mp->m_super, &fs_holder_ops);
> -	if (IS_ERR(*bdevp)) {
> -		error =3D PTR_ERR(*bdevp);
> +	*handlep =3D bdev_open_by_path(name, BLK_OPEN_READ | BLK_OPEN_WRITE,
> +				     mp->m_super, &fs_holder_ops);
> +	if (IS_ERR(*handlep)) {
> +		error =3D PTR_ERR(*handlep);
> +		*handlep =3D NULL;
>  		xfs_warn(mp, "Invalid device [%s], error=3D%d", name, error);
>  	}
>
> @@ -397,11 +398,10 @@ xfs_blkdev_get(
>
>  STATIC void
>  xfs_blkdev_put(
> -	struct xfs_mount	*mp,
> -	struct block_device	*bdev)
> +	struct bdev_handle	*handle)
>  {
> -	if (bdev)
> -		blkdev_put(bdev, mp->m_super);
> +	if (handle)
> +		bdev_release(handle);
>  }
>
>  STATIC void
> @@ -409,16 +409,18 @@ xfs_close_devices(
>  	struct xfs_mount	*mp)
>  {
>  	if (mp->m_logdev_targp && mp->m_logdev_targp !=3D mp->m_ddev_targp) {
> -		struct block_device *logdev =3D mp->m_logdev_targp->bt_bdev;
> +		struct bdev_handle *logdev_handle =3D
> +			mp->m_logdev_targp->bt_bdev_handle;
>
>  		xfs_free_buftarg(mp->m_logdev_targp);
> -		xfs_blkdev_put(mp, logdev);
> +		xfs_blkdev_put(logdev_handle);
>  	}
>  	if (mp->m_rtdev_targp) {
> -		struct block_device *rtdev =3D mp->m_rtdev_targp->bt_bdev;
> +		struct bdev_handle *rtdev_handle =3D
> +			mp->m_rtdev_targp->bt_bdev_handle;
>
>  		xfs_free_buftarg(mp->m_rtdev_targp);
> -		xfs_blkdev_put(mp, rtdev);
> +		xfs_blkdev_put(rtdev_handle);
>  	}
>  	xfs_free_buftarg(mp->m_ddev_targp);
>  }
> @@ -439,7 +441,7 @@ xfs_open_devices(
>  {
>  	struct super_block	*sb =3D mp->m_super;
>  	struct block_device	*ddev =3D sb->s_bdev;
> -	struct block_device	*logdev =3D NULL, *rtdev =3D NULL;
> +	struct bdev_handle	*logdev_handle =3D NULL, *rtdev_handle =3D NULL;
>  	int			error;
>
>  	/*
> @@ -452,17 +454,19 @@ xfs_open_devices(
>  	 * Open real time and log devices - order is important.
>  	 */
>  	if (mp->m_logname) {
> -		error =3D xfs_blkdev_get(mp, mp->m_logname, &logdev);
> +		error =3D xfs_blkdev_get(mp, mp->m_logname, &logdev_handle);
>  		if (error)
>  			goto out_relock;
>  	}
>
>  	if (mp->m_rtname) {
> -		error =3D xfs_blkdev_get(mp, mp->m_rtname, &rtdev);
> +		error =3D xfs_blkdev_get(mp, mp->m_rtname, &rtdev_handle);
>  		if (error)
>  			goto out_close_logdev;
>
> -		if (rtdev =3D=3D ddev || rtdev =3D=3D logdev) {
> +		if (rtdev_handle->bdev =3D=3D ddev ||
> +		    (logdev_handle &&
> +		     rtdev_handle->bdev =3D=3D logdev_handle->bdev)) {
>  			xfs_warn(mp,
>  	"Cannot mount filesystem with identical rtdev and ddev/logdev.");
>  			error =3D -EINVAL;
> @@ -474,18 +478,18 @@ xfs_open_devices(
>  	 * Setup xfs_mount buffer target pointers
>  	 */
>  	error =3D -ENOMEM;
> -	mp->m_ddev_targp =3D xfs_alloc_buftarg(mp, ddev);
> +	mp->m_ddev_targp =3D xfs_alloc_buftarg(mp, sb->s_bdev_handle);
>  	if (!mp->m_ddev_targp)
>  		goto out_close_rtdev;
>
> -	if (rtdev) {
> -		mp->m_rtdev_targp =3D xfs_alloc_buftarg(mp, rtdev);
> +	if (rtdev_handle) {
> +		mp->m_rtdev_targp =3D xfs_alloc_buftarg(mp, rtdev_handle);
>  		if (!mp->m_rtdev_targp)
>  			goto out_free_ddev_targ;
>  	}
>
> -	if (logdev && logdev !=3D ddev) {
> -		mp->m_logdev_targp =3D xfs_alloc_buftarg(mp, logdev);
> +	if (logdev_handle && logdev_handle->bdev !=3D ddev) {
> +		mp->m_logdev_targp =3D xfs_alloc_buftarg(mp, logdev_handle);
>  		if (!mp->m_logdev_targp)
>  			goto out_free_rtdev_targ;
>  	} else {
> @@ -503,10 +507,10 @@ xfs_open_devices(
>   out_free_ddev_targ:
>  	xfs_free_buftarg(mp->m_ddev_targp);
>   out_close_rtdev:
> -	xfs_blkdev_put(mp, rtdev);
> +	xfs_blkdev_put(rtdev_handle);
>   out_close_logdev:
> -	if (logdev && logdev !=3D ddev)
> -		xfs_blkdev_put(mp, logdev);
> +	if (logdev_handle && logdev_handle->bdev !=3D ddev)
> +		xfs_blkdev_put(logdev_handle);
>  	goto out_relock;
>  }
>
> --
> 2.35.3
>=
