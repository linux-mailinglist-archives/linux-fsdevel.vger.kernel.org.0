Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 487FC168867
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 21:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgBUUkb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 15:40:31 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37940 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgBUUka (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:40:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so1572216pgn.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2020 12:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=j03hnTjPsBfir0Nox78vfTL7k3vASulpASEG8GdxSwA=;
        b=Gq+a7Tz+yPUi78mKDnBzWnpasIVXPdKKcEWwXocn2dNvN0rLRdSP3mToE8uQLJlUEo
         TURR7ynWSLemQId2EzzbXQ8benNZg5NWGOglEOBdgy3h1dZf1dTNUvk7x0c9m1RaC0o2
         k6sx1BcrrO1CUo7AOVCbxEHqmV9MUOOJveR6CUoGsZNRCoIQEMvRD5jTf46l45/Zf0fz
         poo5/+6eE/zWOHUT4GGmoVezljvrgn2WLuVKmHzAD0yST2dFZ2oqa71fXnSevR8A0YCb
         /8xbJYEQdupwdIlQIAEEykv/CzbOkLCI+X4HJdHbMOXXoZNzOg0l8euh8hKz0B/r/Ap8
         Sv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=j03hnTjPsBfir0Nox78vfTL7k3vASulpASEG8GdxSwA=;
        b=fglVOiDliPWRVFBOGmXAmkMA0X2dFvV21ZR3MJNqO3sGclrrxnAezKah/7ibQwuN7U
         2NFfQFCrCv/Zw08nOh7exAf/lieR9cnJRT3xby4uXy5KFd3tNhzIgq7y0lXc6yOE5g75
         lKwbaflQWJKqR+1Xbt++RRbisOtwczNSk0VG9CJr+tnkTBNHAmlEP1edlvU0UM/LqkBl
         YYOZ4wi13gmjZZEaoI1ef7kq+vY+/Fpq59+S+VZye2ulr8iVSmLdTfHlwwGC6FsZ5s+q
         EhEJzR5GHUYz1IuUQC9uefI+Gi5zzo2j4OAm5GTk4KzpqjKoBQTiulTrb+WBJZx1uc6K
         fd6w==
X-Gm-Message-State: APjAAAWgf+QP+eUvqLsEw4zl/fKhTiacPAqTam7hiVM/EuPwaWtTm8MF
        0vWJj98LUpOUDVyxsf7gdnynkvhk9T5MpQ==
X-Google-Smtp-Source: APXvYqzu87st5xVU4vqGre8XTaL7l6OCGkHXv/gXyigDrb6WJ57JFQTk03IejRMBiVYUeUNplX4NKA==
X-Received: by 2002:a63:36c2:: with SMTP id d185mr42016113pga.59.1582317628681;
        Fri, 21 Feb 2020 12:40:28 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y15sm3254431pgj.78.2020.02.21.12.40.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 12:40:27 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6B909F7B-2C55-4D5D-AAFA-467F1A852B24@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5BABCC3E-C177-4038-AA9E-86DEAA743FD2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: use non-movable memory for superblock readahead
Date:   Fri, 21 Feb 2020 13:40:02 -0700
In-Reply-To: <20200221192035.180546-1-guro@fb.com>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Perepechko <andrew.perepechko@seagate.com>,
        Theodore Ts'o <tytso@mit.edu>, Gioh Kim <gioh.kim@lge.com>,
        Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
References: <20200221192035.180546-1-guro@fb.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_5BABCC3E-C177-4038-AA9E-86DEAA743FD2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 21, 2020, at 12:20 PM, Roman Gushchin <guro@fb.com> wrote:
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
> Fixes: 85c8f176a611 ("ext4: preload block group descriptors")
> Signed-off-by: Roman Gushchin <guro@fb.com>

Makes sense.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Cc: Andrew Perepechko <andrew.perepechko@seagate.com>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Gioh Kim <gioh.kim@lge.com>
> Cc: Jan Kara <jack@suse.cz>
> ---
> fs/buffer.c                 | 11 +++++++++++
> fs/ext4/super.c             |  2 +-
> include/linux/buffer_head.h |  8 ++++++++
> 3 files changed, 20 insertions(+), 1 deletion(-)
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
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 3a401f930bca..6a10f7d44719 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4321,7 +4321,7 @@ static int ext4_fill_super(struct super_block =
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






--Apple-Mail=_5BABCC3E-C177-4038-AA9E-86DEAA743FD2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5QQDYACgkQcqXauRfM
H+BBjxAAlmV92opkdGquanhWcY0p1p8AapfFz1mlRtN3l7J7yyvJ+03hbx5bLKQx
WbU0QvZQwseMJJAzjJgOeKyTrxUiqimNGsKlqlkXBvEabOtAd9PkkrTV/w8/sdPi
vAG4KfRm/JypzEnpetYT0YJFNW1OkoCAF2hEmZy7vPBTugPWTQT79VCwKrC8+0VY
rNkOqCYKs86Z3Mm1ocQboxEq0cNFHWNcFrElU8G5KemhdVACXs4BckEZ/iXFeiQd
Hx/HWW0Yj0304jvGyDlkh1K9zkZNxj7rV7kPVgEr69N8FWcgQCBft+zljpTTJY/6
E3ASvp+dd/2OMO+xQrihZbv02EO5TW30K1f4X1NTsG97CRPpiwa3JiFUUGjP9I2s
/REuj3FhC54qpD487HhK3WN4ji+gaAmYsjghAV/P68Hevd/EWU/k8Fhsq7SXbr2B
LnkBS9BloRC3Ca14QqG6hJL5KOnUXEcmIHu8eXzb3Yyg3EQhGZ8c/xFqBISNrL58
JxT2cVaTFXDuhpYWEusXTGsSQke1X/duXJuEMm+VDXGY0DQQlGN2J6jSb7TXvr9r
+iZuTapW+0Pq1OqSRS/eTKcbH02vSnwoTKMe4Zh/xc+mwDJT6hH8GTikZl3kxaBb
xi1f+LPwr8/w0BBZfbvJLVUpdufUao+7VFbI3kZVoyjlurXBNu8=
=nxwv
-----END PGP SIGNATURE-----

--Apple-Mail=_5BABCC3E-C177-4038-AA9E-86DEAA743FD2--
