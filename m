Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F192A35FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 22:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKBVan (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 16:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKBVan (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:30:43 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84653C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 13:30:41 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so11901216pgk.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 13:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=MsKQQPn9/bOlbrSCxRiLPowvBKKGrm4sue6sAlm82b4=;
        b=RxJ43B/6YENbQhR9sx/FHME4LNXiACO/M7NO7DW3OWCjCC7EfMkuTunuBoHFPXDpHQ
         OuURyukx5EA9wj7D9ptmY1XdlGG7cMeEU60BGImWgeJi+AyplLbHYr9yxog10L3k53wg
         Gjqp9XDtoEqO6UN0JaNpC/oI5DWQ03cpIDRAM/djx204Ata6z/6cDzggvmUCrkovVpxF
         K7EE5IYYERZrRwfRuRsK+Q5eDcoCJX/bInpPMt5MRs9kPHsQd9ik0j3p/5FeUAc9pSoE
         ek6ZZtLZfSP6OiL2uMWnfPBzKpHNf575LVnbsApcoT7btRhtqGWyIGjMqiWnK1OC7M9X
         +YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=MsKQQPn9/bOlbrSCxRiLPowvBKKGrm4sue6sAlm82b4=;
        b=VLzjFyud1duUhDtCQXXUenPnd3TE0CXGD5nu54FPme2Qfk/HSE9xiymEqyNsleL8A+
         8+Bmh8pt91qYwWs7Gadak+UccCdefnGrCiYJBzsl/Knd5Kj7lJ5oW9/IKj8lqJNIJP//
         UktCl3xSN5Ukb6i8FWM5y24RvbzBUwCYIZGFvfvLrX7Lp70xjmbqRO19G8UAz42F1HNy
         NrxSPJNdvHzDgq91N7o7AklpdGczIhvaEVnucxueHUdPZvBHvQ7Y6mCSMIZ50SGHqbQQ
         shUkMKZ9kRTBOmXeCyTyrtNs9VKT812y/v/UTGqdGxkj5YG+b/QwM+I5106UtiwnWj52
         64TQ==
X-Gm-Message-State: AOAM532cJfnZs/GW5Le1nEPqzJhrWDsoCyH4F4KsScYR6kpnvFX7xCoy
        xDA2hSsbkOMike+unOJYKNjESQ==
X-Google-Smtp-Source: ABdhPJxbvJytHNCaJRKTcdciFfqLSK+NxDWDkk+oiZeQMIiCU+tYDeEsHV0aVRFJHy3Sng9jWhaeBg==
X-Received: by 2002:a63:c20f:: with SMTP id b15mr7740297pgd.230.1604352641047;
        Mon, 02 Nov 2020 13:30:41 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z11sm5057854pfk.52.2020.11.02.13.30.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 13:30:40 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <30045F3F-B103-48DC-A14B-C16D08B32F9D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DA02AF43-4AF3-4664-B69C-7B9CE4835799";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] quota: Don't overflow quota file offsets
Date:   Mon, 2 Nov 2020 14:30:37 -0700
In-Reply-To: <20201102172733.23444-2-jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20201102172733.23444-1-jack@suse.cz>
 <20201102172733.23444-2-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_DA02AF43-4AF3-4664-B69C-7B9CE4835799
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 2, 2020, at 10:27 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> The on-disk quota format supports quota files with upto 2^32 blocks. =
Be
> careful when computing quota file offsets in the quota files from =
block
> numbers as they can overflow 32-bit types. Since quota files larger =
than
> 4GB would require ~26 millions of quota users, this is mostly a
> theoretical concern now but better be careful, fuzzers would find the
> problem sooner or later anyway...
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Out of curiosity, is this 26 million *quota entries*, or is it just a =
UID
larger than 26M?  At one point the quota files were sparse and indexed =
by
the UID, but I guess very file name "quota tree" means this is not =
correct.
Is there some document/comment that describes the on-disk quota file =
format?

In any case, the change makes sense regardless, since ->quota_read() =
takes
loff_t for the offset.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/quota/quota_tree.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
> index a6f856f341dc..c5562c871c8b 100644
> --- a/fs/quota/quota_tree.c
> +++ b/fs/quota/quota_tree.c
> @@ -62,7 +62,7 @@ static ssize_t read_blk(struct qtree_mem_dqinfo =
*info, uint blk, char *buf)
>=20
> 	memset(buf, 0, info->dqi_usable_bs);
> 	return sb->s_op->quota_read(sb, info->dqi_type, buf,
> -	       info->dqi_usable_bs, blk << info->dqi_blocksize_bits);
> +	       info->dqi_usable_bs, (loff_t)blk << =
info->dqi_blocksize_bits);
> }
>=20
> static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char =
*buf)
> @@ -71,7 +71,7 @@ static ssize_t write_blk(struct qtree_mem_dqinfo =
*info, uint blk, char *buf)
> 	ssize_t ret;
>=20
> 	ret =3D sb->s_op->quota_write(sb, info->dqi_type, buf,
> -	       info->dqi_usable_bs, blk << info->dqi_blocksize_bits);
> +	       info->dqi_usable_bs, (loff_t)blk << =
info->dqi_blocksize_bits);
> 	if (ret !=3D info->dqi_usable_bs) {
> 		quota_error(sb, "dquota write failed");
> 		if (ret >=3D 0)
> @@ -284,7 +284,7 @@ static uint find_free_dqentry(struct =
qtree_mem_dqinfo *info,
> 			    blk);
> 		goto out_buf;
> 	}
> -	dquot->dq_off =3D (blk << info->dqi_blocksize_bits) +
> +	dquot->dq_off =3D ((loff_t)blk << info->dqi_blocksize_bits) +
> 			sizeof(struct qt_disk_dqdbheader) +
> 			i * info->dqi_entry_size;
> 	kfree(buf);
> @@ -559,7 +559,7 @@ static loff_t find_block_dqentry(struct =
qtree_mem_dqinfo *info,
> 		ret =3D -EIO;
> 		goto out_buf;
> 	} else {
> -		ret =3D (blk << info->dqi_blocksize_bits) + =
sizeof(struct
> +		ret =3D ((loff_t)blk << info->dqi_blocksize_bits) + =
sizeof(struct
> 		  qt_disk_dqdbheader) + i * info->dqi_entry_size;
> 	}
> out_buf:
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_DA02AF43-4AF3-4664-B69C-7B9CE4835799
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+gen0ACgkQcqXauRfM
H+C+0Q/9GBf+R8tqpKn1lSs8OKjTUStOeinx0GfPl+DWFYamnCm9ERkXhuxGtCZd
cDkrmGeteIXzzTjrJ0yZP9XNGq7IZqN7gaF8GDURjSU9fkZguLL6TBWvmQZV/0SA
g/YHbey7joSCIiMfAHqINdw9IKIxYBr4qr+rtX8IjCZtHrmWZXuPDUWhLfzMS9hL
4WH6stugptpSNxgEGkGjvrOJLPAUyvIu81nqB+GnzlFntLwxdNC4l4X5L/2OCrua
UFfDLagwVaOoEeF9d1zt8Kc/PZUmxeNc6YIfojnD/S+dwYgGRzv/24Sy06pS2qKP
AQNUAraRkyuy9ZrMA2WhS/VEgoMxOfb7/NUNFwDqNBcgj0KIS2VZl6n2OlJazrJV
b+Gcc1fL62pYWXKED2LYdJDD6aLi2eHHqa3NJWzdvnnYAANpYAtkUadm76ID/UZO
xA31XrGMynnrIvushg+E25f0QDaSXhGctf0t1WSbMer5piTWvq1bSyQcrBN8swAP
X6FpjUIwh5JbD3PKFXzOHkzuUkQ+Jna2k+3Swqepxyyern50WGcsufBH4Gpzqvsz
JQdZ+r1CZd2vdtcn2IUjTBufXuAFh31T/0wCzpM3zJ4zj94T+CNJO+hh4AfftE00
mZ8Jk8SejHMknmCRBQbqDfWF319Nm9uD1dFO3yfCByRw2b2dXyQ=
=x45e
-----END PGP SIGNATURE-----

--Apple-Mail=_DA02AF43-4AF3-4664-B69C-7B9CE4835799--
