Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5023B78B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234343AbhF2TgW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 15:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhF2TgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 15:36:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20DC061760
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 12:33:53 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 59-20020a9d0ac10000b0290462f0ab0800so15949154otq.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 12:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YS2WgG+tm1E7PR+z7d8KIk2kzEbs0O6AT9o1/tVCqkY=;
        b=U3n9RwRXoJqysAEH+Lfdr+UguX2OEsKtMAF/USgVtXNCVreoTQim2CLR48JS18vska
         bmE3ofHMYRmRtU2YxWA9svI8OJEeXbMSFtzB30Em5xtphQiqf7tHqUhySlMIJpoMojXd
         lrqsit/Htx+PTQ3nIqybve/hPT8sLVk6/hKIRqfeCH/wnokzkTM40qjAWKY0EuRaNbsI
         BPQsAinHpb1RNDB7M9nIth2ZnP8R5rG3ctapDXz3T8wI2mzlWuH/XCjByQtLr+RTbUoc
         jbKbyqTrrIGw1OOn/z7r2Y95BDm3KRZNtB9M8+esbS2W4NgZpHncaaR+iqEhGjxX2WSr
         g/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YS2WgG+tm1E7PR+z7d8KIk2kzEbs0O6AT9o1/tVCqkY=;
        b=nd68kFh5qieyOAnHzmqmKZJ/GMY6i0grquetAl07GuF4dr+3vzDwSOSwvfnNFBFwvH
         W4WluJBJ0WWyhf8MzbmjvxHIwnmMWAhfy3Op0l4x67Q2gFzjKDoBhAy5FrT0YGuflNz5
         eXP4cuAoKGAipC2O0TDKdLp7juobjhIvocu/BZzYoF2zzBh2UCT1qgjoGbH8NYjWJRPC
         WEJugzN51KCWNo0dhHUoVnXgaqawP7nOZrmnHad56uztD8FKWEkbWNPUO4Vktgzon1Nv
         D18UKRagfplSwsfxzF4XRyRn2WhK9C84nJt1OITbH+rlUiQTB2vuAjKBJfE0fqabe5zY
         TAFw==
X-Gm-Message-State: AOAM533eTF2V5A6HqHVns9G7WPBUFRizoXs25ysrFXbLkz0s3QFLQKJL
        I8VFz5WfHcCFz0U4w3SWmxeakg==
X-Google-Smtp-Source: ABdhPJwzuGWcwChFeYdw7UOh8XgXDPZE3DrYTHwi1cKl8VKgs4RjCo48nSOMn6uoYe1M6Ba66k+ZLw==
X-Received: by 2002:a05:6830:1f51:: with SMTP id u17mr5919112oth.25.1624995232643;
        Tue, 29 Jun 2021 12:33:52 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:f8e3:a853:8646:6bc8])
        by smtp.gmail.com with ESMTPSA id 35sm4374415oth.49.2021.06.29.12.33.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 12:33:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 3/3] hfs: add lock nesting notation to hfs_find_init
From:   Viacheslav Dubeyko <slava@dubeyko.com>
In-Reply-To: <20210629144803.62541-4-desmondcheongzx@gmail.com>
Date:   Tue, 29 Jun 2021 12:33:46 -0700
Cc:     gustavoars@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <763B3E9F-1D48-4D0E-830C-8260D2329627@dubeyko.com>
References: <20210629144803.62541-1-desmondcheongzx@gmail.com>
 <20210629144803.62541-4-desmondcheongzx@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 29, 2021, at 7:48 AM, Desmond Cheong Zhi Xi =
<desmondcheongzx@gmail.com> wrote:
>=20
> Syzbot reports a possible recursive lock:
> =
https://syzkaller.appspot.com/bug?id=3Df007ef1d7a31a469e3be7aeb0fde0769b18=
585db
>=20
> This happens due to missing lock nesting information. =46rom the logs,
> we see that a call to hfs_fill_super is made to mount the hfs
> filesystem. While searching for the root inode, the lock on the
> catalog btree is grabbed. Then, when the parent of the root isn't
> found, a call to __hfs_bnode_create is made to create the parent of
> the root. This eventually leads to a call to hfs_ext_read_extent which
> grabs a lock on the extents btree.
>=20
> Since the order of locking is catalog btree -> extents btree, this
> lock hierarchy does not lead to a deadlock.
>=20
> To tell lockdep that this locking is safe, we add nesting notation to
> distinguish between catalog btrees, extents btrees, and attributes
> btrees (for HFS+). This has already been done in hfsplus.
>=20
> Reported-and-tested-by: =
syzbot+b718ec84a87b7e73ade4@syzkaller.appspotmail.com
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
> fs/hfs/bfind.c | 14 +++++++++++++-
> fs/hfs/btree.h |  7 +++++++
> 2 files changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index 4af318fbda77..ef9498a6e88a 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -25,7 +25,19 @@ int hfs_find_init(struct hfs_btree *tree, struct =
hfs_find_data *fd)
> 	fd->key =3D ptr + tree->max_key_len + 2;
> 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
> 		tree->cnid, __builtin_return_address(0));
> -	mutex_lock(&tree->tree_lock);
> +	switch (tree->cnid) {
> +	case HFS_CAT_CNID:
> +		mutex_lock_nested(&tree->tree_lock, =
CATALOG_BTREE_MUTEX);
> +		break;
> +	case HFS_EXT_CNID:
> +		mutex_lock_nested(&tree->tree_lock, =
EXTENTS_BTREE_MUTEX);
> +		break;
> +	case HFS_ATTR_CNID:
> +		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> 	return 0;
> }
>=20
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 4ba45caf5939..0e6baee93245 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -13,6 +13,13 @@ typedef int (*btree_keycmp)(const btree_key *, =
const btree_key *);
>=20
> #define NODE_HASH_SIZE  256
>=20
> +/* B-tree mutex nested subclasses */
> +enum hfs_btree_mutex_classes {
> +	CATALOG_BTREE_MUTEX,
> +	EXTENTS_BTREE_MUTEX,
> +	ATTR_BTREE_MUTEX,
> +};
> +
> /* A HFS BTree held in memory */
> struct hfs_btree {
> 	struct super_block *sb;
> --=20
> 2.25.1
>=20

Looks good to me.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.


