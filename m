Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE2174591
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 08:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgB2HtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 02:49:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40414 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgB2HtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 02:49:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id l184so329817pfl.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2020 23:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1Tc8q1bCYaVDwEHfP3z5ONHs/bVcpptjbrlHUSGbA6A=;
        b=oJ//ZGlEHqTWeokM62RVnQ70I1/Rh+uJ24G/PidJHX5DCKzlU1i+AYjuPGQVNWJqjJ
         E8wCYHzDuWO6+12Uv/48ENh37HcVQXdLyiZHDiPOR1iya/OXmkZ+TP7o5sjbifrLgkSL
         BRMr2p1JwA3bu3kkXP3PwrxUkUGcrjHJJQWzn1r5bbS4EFYYlk9poUyhIv9uzdZSpXGS
         F6TAXXL9sJHiBfycEN0cvMBcSgTs5Q+eoJruVevDkJtbLtqq3Uh2V0OMduMnepZlIfC7
         Xi3aMy37Asse/RR60N2u1C2Ox3hPpCTv3vuO2KTqrgc8dMjjBGvFeJnHU/Uktk2VxjB+
         ahrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1Tc8q1bCYaVDwEHfP3z5ONHs/bVcpptjbrlHUSGbA6A=;
        b=uY+56lTxWzz6Qnr8+vpra318bRIyKh39tOEaOK84viF2lc7jELmy7O/AJ5tHeeCd5l
         Jx0z6sMq+qolB+ZY96LE6p1uuzzc3+wfjSwmhF6OyqvlrR1M5EFDD2dXc8iKNGIvp7gf
         69+6VHyN1+8yjUeE9o3/f69vEBvmsTibjDNE6SylfGENnp7C2/6Q/7Fo0dVkaOCtBjMb
         yIidDRi0M54tMZMyQNO+ZpZDkaSQnfoiqblLBLS/4WhLVBT9DCUxs96/cKb9s43zyh1f
         46x4lAW8v/1I3wAyKfvah4eJM+bi3RMCrpu3pJC6eCnfvJdhUy3mGzJHaAwC4l1oLt+4
         oRqA==
X-Gm-Message-State: APjAAAVghXHotP3sDgNi2Rmwx/VpqTEVDNUqGEpzxjcJWZuHyZtdspGw
        7vwwQAzDNqxzsG2jiIx6kubMOg==
X-Google-Smtp-Source: APXvYqx8vbO7aETyHP1bgowjIxjAfP3oVEXtcmAjnQ6njqZ6vsGHmGZrW2zaK95nM9c+TbCfIMDVlQ==
X-Received: by 2002:a63:e942:: with SMTP id q2mr8828973pgj.323.1582962558782;
        Fri, 28 Feb 2020 23:49:18 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id e12sm3452498pgb.67.2020.02.28.23.49.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 23:49:18 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <26E49EB9-DAD4-4BAB-A7A7-7DC6B45CD2B8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_552BA912-D5EE-4356-9927-E75254633E37";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: use non-movable memory for superblock readahead
Date:   Sat, 29 Feb 2020 00:49:13 -0700
In-Reply-To: <20200229001411.128010-1-guro@fb.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Theodore Ts'o <tytso@mit.edu>, Gioh Kim <gioh.kim@lge.com>,
        Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
References: <20200229001411.128010-1-guro@fb.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_552BA912-D5EE-4356-9927-E75254633E37
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 28, 2020, at 5:14 PM, Roman Gushchin <guro@fb.com> wrote:
>=20
> Since commit a8ac900b8163 ("ext4: use non-movable memory for the
> superblock") buffers for ext4 superblock were allocated using
> the sb_bread_unmovable() helper which allocated buffer heads
> out of non-movable memory blocks. It was necessarily to not block
> page migrations and do not cause cma allocation failures.
>=20
> However commit 85c8f176a611 ("ext4: preload block group descriptors")
> broke this by introducing pre-reading of the ext4 superblock.
> The problem is that __breadahead() is using __getblk() underneath,
> which allocates buffer heads out of movable memory.
>=20
> It resulted in page migration failures I've seen on a machine
> with an ext4 partition and a preallocated cma area.
>=20
> Fix this by introducing sb_breadahead_unmovable() and
> __breadahead_gfp() helpers which use non-movable memory for buffer
> head allocations and use them for the ext4 superblock readahead.
>=20
> v2: found a similar issue in __ext4_get_inode_loc()
>=20
> Fixes: 85c8f176a611 ("ext4: preload block group descriptors")
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Cc: Andrew Perepechko <andrew.perepechko@seagate.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Gioh Kim <gioh.kim@lge.com>
> Cc: Jan Kara <jack@suse.cz>
> ---
> fs/buffer.c                 | 11 +++++++++++
> fs/ext4/inode.c             |  2 +-
> fs/ext4/super.c             |  2 +-
> include/linux/buffer_head.h |  8 ++++++++
> 4 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4299e100a05b..25462edd920e 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1414,6 +1414,17 @@ void __breadahead(struct block_device *bdev, =
sector_t block, unsigned size)
> }
> EXPORT_SYMBOL(__breadahead);
>=20
> +void __breadahead_gfp(struct block_device *bdev, sector_t block, =
unsigned size,
> +		      gfp_t gfp)
> +{
> +	struct buffer_head *bh =3D __getblk_gfp(bdev, block, size, gfp);
> +	if (likely(bh)) {
> +		ll_rw_block(REQ_OP_READ, REQ_RAHEAD, 1, &bh);
> +		brelse(bh);
> +	}
> +}
> +EXPORT_SYMBOL(__breadahead_gfp);
> +
> /**
>  *  __bread_gfp() - reads a specified block and returns the bh
>  *  @bdev: the block_device to read from
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fa0ff78dc033..b131fedc6b77 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4348,7 +4348,7 @@ static int __ext4_get_inode_loc(struct inode =
*inode,
> 			if (end > table)
> 				end =3D table;
> 			while (b <=3D end)
> -				sb_breadahead(sb, b++);
> +				sb_breadahead_unmovable(sb, b++);
> 		}
>=20
> 		/*
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index ff1b764b0c0e..fb2338a5220e 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4331,7 +4331,7 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 	/* Pre-read the descriptors into the buffer cache */
> 	for (i =3D 0; i < db_count; i++) {
> 		block =3D descriptor_loc(sb, logical_sb_block, i);
> -		sb_breadahead(sb, block);
> +		sb_breadahead_unmovable(sb, block);
> 	}
>=20
> 	for (i =3D 0; i < db_count; i++) {
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 7b73ef7f902d..b56cc825f64d 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -189,6 +189,8 @@ struct buffer_head *__getblk_gfp(struct =
block_device *bdev, sector_t block,
> void __brelse(struct buffer_head *);
> void __bforget(struct buffer_head *);
> void __breadahead(struct block_device *, sector_t block, unsigned int =
size);
> +void __breadahead_gfp(struct block_device *, sector_t block, unsigned =
int size,
> +		  gfp_t gfp);
> struct buffer_head *__bread_gfp(struct block_device *,
> 				sector_t block, unsigned size, gfp_t =
gfp);
> void invalidate_bh_lrus(void);
> @@ -319,6 +321,12 @@ sb_breadahead(struct super_block *sb, sector_t =
block)
> 	__breadahead(sb->s_bdev, block, sb->s_blocksize);
> }
>=20
> +static inline void
> +sb_breadahead_unmovable(struct super_block *sb, sector_t block)
> +{
> +	__breadahead_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
> +}
> +
> static inline struct buffer_head *
> sb_getblk(struct super_block *sb, sector_t block)
> {
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_552BA912-D5EE-4356-9927-E75254633E37
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5aF3oACgkQcqXauRfM
H+DmDA/+Lh5/EfT0j+1JYuSwWDUxSq/N/0RkdgTuDAcQ2b0Q3gYAkODlF+Jao1cc
kVPGoua1zXfz0qQX2WdlW7coVqOcMj508SWNEN+H0gzjtpbWkR0nj0HmGEClwln1
fRnX+duceB/2Olks/YZVulbSKZ+TTeOxj5cJqvnEQ8/JnfQyzFAZ7TiY43jq/vEv
nGsIBHMfNOWHjq0i0pXFQf8CHXNdNwTgL7b75UH+P9YPnbrUUtWz0+X1zQPe4XNW
44iUis99wRDuLKIlfifoA0RG3Cfd+Hs/RDO3H9DAHI+PIY+VIEwjI+qi66jg8tWi
kd6Q3dkfXMoW40B9w7Njygvuq0JlfugcOzIq/MaXPlkToJMcwRmQ92jE2xjVZN42
iN6TOwSZzYVcAkFd5nd8bmO0RGMv67uHgA/rBXMObwqvKCigJ4lfc58AYnuOJ6w4
JLyqgcVNEPyvDj5Wn963JDy0QLnR6hB+XGuy9+u3NLEIT1l8mK02mzysxgC35NfJ
9zRERTICe6Oej1imdORAV9UIEZ/5RWeHVRmQUrrHw9yzIMS52dzEq2HtjsZRCIBL
YqTCPtZKgauIL5fw1clOOEknLJpFSNp06FwMS0WppAEdnJ5cYu9y58QjhtH8iDAl
9N4ZpGzfw4PbDBL3EzPQISk5P15nBDhRNr7xUtWpYlj3eqezi4U=
=xaAM
-----END PGP SIGNATURE-----

--Apple-Mail=_552BA912-D5EE-4356-9927-E75254633E37--
