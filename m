Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727C93936A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 21:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhE0Tud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbhE0Tuc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 15:50:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36A8C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 12:48:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v12so472630plo.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 May 2021 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7u+DFIut9SqCS/XVsWkAkpJzHtHQ1b1Q4EJvXmbpC8A=;
        b=vYrQxqk4hOue1v8BKZ7sKsorrlXKSzgBwOROVHZ5YvB8M5tZhktoPtJD+DWZ0oYEZR
         r23j9cxuB0vjIyeYYnQhI0hftrrfu3pkJDitGr7oH1IzJWbF/1XIFJP/Er3K3fL7x+HQ
         v0QhmXdFeSjnR8xgEgzXPCzKc5wvbDC6txZinNEKUoi24z4kkrnrG48sZ+MNvtUq/fBi
         EHYJ8aQrA6TUaTGOGCylmZwby0quLCyl59lmRUNVO/NI0UAqwFNdK+QKC3n3O3lc0uCI
         hNV+17oO9/HVK90ofZR/cxfMadzmro7RQKiW9mQ+NCM05M9i1XjO503HuFAUn38RxfIk
         UCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7u+DFIut9SqCS/XVsWkAkpJzHtHQ1b1Q4EJvXmbpC8A=;
        b=UH6DUBtst5zCT4iFVAKSGsJp2F1EL3qgZvlhs3khH3NtJ1AMBAsYCp3xW+QYgdwPrt
         3BUazhUk11kAp0MiPLFI/IQb9i8a6IHlevRoEEkYGY4kUKmFcoLyiZyCBKLTixbRla8P
         Kftyqk1HfXRzWeI6i3BRNZA/E04e/qkR8Ks4Lp0Rf37Rz3fCeV6cnhMf8+Z2Dzor2ROZ
         3MQ4aeD4tEllI+2qYVR5Yc/4OKDGFiRs2FWie2w5LVsE69mNtWjcGqgLny2Paq5zd4jk
         10t35ej1ekeDqJuVoWH7qV2ip9naB4n2ATOoK6DmGwKADYzVq1xY0fuTKv4f9s6Ac1hK
         SWDw==
X-Gm-Message-State: AOAM532nDnqQB7PFMvFOTu4b9YkDLf0QGqSvtQ6cY8z8ih8ZhMYzY3/B
        rIbSZ/cUV9Elsa5LKI+ouqsc6Q==
X-Google-Smtp-Source: ABdhPJyQIaMNVxO3naGeHkI+P47Sq8qkMaY39quKxeYAu+Ct3chlpRTQmbVgYQnM8GO3IVYyRz3wYA==
X-Received: by 2002:a17:902:b687:b029:eb:6491:b3f7 with SMTP id c7-20020a170902b687b02900eb6491b3f7mr4660729pls.38.1622144937705;
        Thu, 27 May 2021 12:48:57 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i13sm2545570pgg.30.2021.05.27.12.48.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 12:48:57 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FE449796-7F83-41D8-9F3A-555B7B65B5DE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_92503AC5-DEEF-4307-ADDC-CD91BA817B4A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH V2 2/7] ext4: add new helper interface
 ext4_try_to_trim_range()
Date:   Thu, 27 May 2021 13:48:55 -0600
In-Reply-To: <72360aac-48f9-95c6-539f-739464f9fc9e@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        lishujin@kuaishou.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <a602a6ba-2073-8384-4c8f-d669ee25c065@gmail.com>
 <72360aac-48f9-95c6-539f-739464f9fc9e@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_92503AC5-DEEF-4307-ADDC-CD91BA817B4A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 26, 2021, at 2:43 AM, Wang Jianchao <jianchao.wan9@gmail.com> =
wrote:
>=20
> There is no functional change in this patch but just split the
> codes, which serachs free block and does trim, into a new function
> ext4_try_to_trim_range. This is preparing for the following async
> backgroup discard.
>=20
> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 102 =
++++++++++++++++++++++++++++++------------------------
> 1 file changed, 57 insertions(+), 45 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d81f1fd22..f984f15 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5685,6 +5685,54 @@ static int ext4_trim_extent(struct super_block =
*sb,
> 	return ret;
> }
>=20
> +static int ext4_try_to_trim_range(struct super_block *sb,
> +		struct ext4_buddy *e4b, ext4_grpblk_t start,
> +		ext4_grpblk_t max, ext4_grpblk_t minblocks)
> +{
> +	ext4_grpblk_t next, count, free_count;
> +	void *bitmap;
> +	int ret =3D 0;
> +
> +	bitmap =3D e4b->bd_bitmap;
> +	start =3D (e4b->bd_info->bb_first_free > start) ?
> +		e4b->bd_info->bb_first_free : start;
> +	count =3D 0;
> +	free_count =3D 0;
> +
> +	while (start <=3D max) {
> +		start =3D mb_find_next_zero_bit(bitmap, max + 1, start);
> +		if (start > max)
> +			break;
> +		next =3D mb_find_next_bit(bitmap, max + 1, start);
> +
> +		if ((next - start) >=3D minblocks) {
> +			ret =3D ext4_trim_extent(sb, start, next - =
start, e4b);
> +			if (ret && ret !=3D -EOPNOTSUPP)
> +				break;
> +			ret =3D 0;
> +			count +=3D next - start;
> +		}
> +		free_count +=3D next - start;
> +		start =3D next + 1;
> +
> +		if (fatal_signal_pending(current)) {
> +			count =3D -ERESTARTSYS;
> +			break;
> +		}
> +
> +		if (need_resched()) {
> +			ext4_unlock_group(sb, e4b->bd_group);
> +			cond_resched();
> +			ext4_lock_group(sb, e4b->bd_group);
> +		}
> +
> +		if ((e4b->bd_info->bb_free - free_count) < minblocks)
> +			break;
> +	}
> +
> +	return count;
> +}
> +
> /**
>  * ext4_trim_all_free -- function to trim all free space in alloc. =
group
>  * @sb:			super block for file system
> @@ -5708,10 +5756,8 @@ static int ext4_trim_extent(struct super_block =
*sb,
> 		   ext4_grpblk_t start, ext4_grpblk_t max,
> 		   ext4_grpblk_t minblocks)
> {
> -	void *bitmap;
> -	ext4_grpblk_t next, count =3D 0, free_count =3D 0;
> 	struct ext4_buddy e4b;
> -	int ret =3D 0;
> +	int ret;
>=20
> 	trace_ext4_trim_all_free(sb, group, start, max);
>=20
> @@ -5721,57 +5767,23 @@ static int ext4_trim_extent(struct super_block =
*sb,
> 			     ret, group);
> 		return ret;
> 	}
> -	bitmap =3D e4b.bd_bitmap;
>=20
> 	ext4_lock_group(sb, group);
> -	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
> -	    minblocks >=3D =
atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
> -		goto out;
> -
> -	start =3D (e4b.bd_info->bb_first_free > start) ?
> -		e4b.bd_info->bb_first_free : start;
>=20
> -	while (start <=3D max) {
> -		start =3D mb_find_next_zero_bit(bitmap, max + 1, start);
> -		if (start > max)
> -			break;
> -		next =3D mb_find_next_bit(bitmap, max + 1, start);
> -
> -		if ((next - start) >=3D minblocks) {
> -			ret =3D ext4_trim_extent(sb, start, next - =
start, &e4b);
> -			if (ret && ret !=3D -EOPNOTSUPP)
> -				break;
> -			ret =3D 0;
> -			count +=3D next - start;
> -		}
> -		free_count +=3D next - start;
> -		start =3D next + 1;
> -
> -		if (fatal_signal_pending(current)) {
> -			count =3D -ERESTARTSYS;
> -			break;
> -		}
> -
> -		if (need_resched()) {
> -			ext4_unlock_group(sb, group);
> -			cond_resched();
> -			ext4_lock_group(sb, group);
> -		}
> -
> -		if ((e4b.bd_info->bb_free - free_count) < minblocks)
> -			break;
> +	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
> +	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) =
{
> +		ret =3D ext4_try_to_trim_range(sb, &e4b, start, max, =
minblocks);
> +		if (ret >=3D 0)
> +			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> +	} else {
> +		ret =3D 0;
> 	}
>=20
> -	if (!ret) {
> -		ret =3D count;
> -		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
> -	}
> -out:
> 	ext4_unlock_group(sb, group);
> 	ext4_mb_unload_buddy(&e4b);
>=20
> 	ext4_debug("trimmed %d blocks in the group %d\n",
> -		count, group);
> +		ret, group);
>=20
> 	return ret;
> }
> --
> 1.8.3.1


Cheers, Andreas






--Apple-Mail=_92503AC5-DEEF-4307-ADDC-CD91BA817B4A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmCv96gACgkQcqXauRfM
H+BkOA/9EVWci2buDhRIa54UlM5wG0Yio77494TAzPUYOvTvRvE0S5AgecTKOmNx
bnocVv19eOLhu0xhlXRmOynyHjSnlMHPgKJmw+irwYPe8vIF9oAGAWnx2mHzwr8v
bxUVEqYsa+G7ajwXq/GvoewKkbCUWeo6Ihc5oFGvSQDoPaE8mMxjQ16FeQZYpFIj
3nTVGwFGuIjWjXWPwMzSQInV0kFbPCf4s5tGaRzTFjuySSh07byYWKlMwFwUArCM
tQ+uKWbiWDsC6NV4/IdQIiLZISIeQSDY+PdQkFh07cz33MkOxbynyqL+4y66DyDv
5ugmEFBLKI2yyss277gPLE9mkBbo4/0CZO64atMoacNuj3VSWCGyZEX5aecye6ut
ujA9eIWeMQNlWle1hyGcBr6QGnTBcI+Yf9B/IiAtimD9oPOjEs3mT4h8kcQRwPWS
ecBwzOJHmgOgisy30ZYxIm3aeUkFGshMVw/r5UqZ8gZobvqZG/3RB2xEfnMVS7fM
I3/4/Yr5IwLyihbUDDVNoZ/X2AyI4Yh07+2KO+dUb1GVGRj979wlscNxNXwj75x1
KXcaeXuotW5rB8vEOz3mmbmlT94LKBFRUJrHgMsZb58mJ2lOpUvNIa4rl1RAwgCG
GekVVm2IWwLx3SNuNlsF3wWPcmgU/fChXuqOh+lXN4EElcgnsuA=
=mcv/
-----END PGP SIGNATURE-----

--Apple-Mail=_92503AC5-DEEF-4307-ADDC-CD91BA817B4A--
