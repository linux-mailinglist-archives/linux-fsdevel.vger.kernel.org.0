Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B543A2CC9E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 23:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgLBWsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 17:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgLBWsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:48:23 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46EC0617A7
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 14:47:37 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id v1so2768pjr.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 14:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vORerP6L/9bHX6qRWOpedpBg2yoOaAJwQR4f5QrHgzY=;
        b=1el56WgEpgq3xnPh001U6Fkgb2fbjprgnUOqeilkzqGyUXAAkaBxUaXWePyY00Hqyq
         +vy6sTBDn0OzfoamQRLnUbFgHe055OMX4yn2qFsp6NPgPnQKmKNWtD6WZs8jsFSZzIkK
         8mg9ctITY6lQ+wDsiNuVAN2U1TJ5PResPI0QfWtQpV+osGga2mqiz34swVj6m6ONAMJc
         ReobA3tSRwTfKDV/JP8JI3mz4yjPru78Jeu9oKx8sOQovRSndHq/GBdLnPDj2gZNdVPI
         KUY51AAG380tdNGDQoGmnFT2dYayb8PMnrwH+191OsAxr4Jahk1Wvb5ShUp2CpGY05md
         vSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vORerP6L/9bHX6qRWOpedpBg2yoOaAJwQR4f5QrHgzY=;
        b=Q+8tQbf4UR8ggKG1MN0qBlPFt75o8ldm80xE9CnMHL90cWONEHCxg4V/V5gbzIVbNG
         0lPOYaYBr/yo622mJnbG7Ay7Ui+CYpoCwWdZhgdsVJgYQLFKOpBBhTCSb7+ECeWeqU65
         d7ln0n4ZfKYbsdOGdEz2bcq6KPBYR6JqsvYtX2gbwYeHgRtxRt3r116Mb7vcmk+T2DXO
         +pqMHJ/dwlbtVP71pvBAKKMpan6vylYsXRgFS/KoVOhyt2Y8gmfQpJp5j1FhHi7uZIpA
         BnPBd2W3cOufe6/XMK56VAMKVJUaF8bII2eAyBScOQcilr9ghTwAEAFQbr9ivmBHfd2L
         Jcuw==
X-Gm-Message-State: AOAM5338ZfvZAjP8Ejlk3FwEk3vWpvYmmQK9VNVYbYqWCJflSMbrE3HY
        GNK7fwpk66MRWmtQcuyGs+2WcmoOrynPM55f
X-Google-Smtp-Source: ABdhPJzvtcEpSpJOY7N/htLhQegQLezTxksVZDb1dI8FPDBzUhlQkPa2qBrzVfdvz/AYe95rpcpgJA==
X-Received: by 2002:a17:902:8c8a:b029:d6:d1e7:e78e with SMTP id t10-20020a1709028c8ab02900d6d1e7e78emr247976plo.39.1606949257113;
        Wed, 02 Dec 2020 14:47:37 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s17sm91991pge.37.2020.12.02.14.47.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 14:47:36 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D73BD1C1-90F2-4B80-9B1D-0FA1560BB4AC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_01B6A6AB-07E6-44B3-840B-68217F3B3E58";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/9] ext4: remove ext4_dir_open()
Date:   Wed, 2 Dec 2020 15:47:34 -0700
In-Reply-To: <20201125002336.274045-2-ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20201125002336.274045-1-ebiggers@kernel.org>
 <20201125002336.274045-2-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_01B6A6AB-07E6-44B3-840B-68217F3B3E58
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 24, 2020, at 5:23 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> Since encrypted directories can be opened without their encryption key
> being available, and each readdir tries to set up the key, trying to =
set
> up the key in ->open() too isn't really useful.
>=20
> Just remove it so that directories don't need an ->open() method
> anymore, and so that we eliminate a use of =
fscrypt_get_encryption_info()
> (which I'd like to stop exporting to filesystems).
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/dir.c | 8 --------
> 1 file changed, 8 deletions(-)
>=20
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index ca50c90adc4c..16bfbdd5007c 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -616,13 +616,6 @@ static int ext4_dx_readdir(struct file *file, =
struct dir_context *ctx)
> 	return 0;
> }
>=20
> -static int ext4_dir_open(struct inode * inode, struct file * filp)
> -{
> -	if (IS_ENCRYPTED(inode))
> -		return fscrypt_get_encryption_info(inode) ? -EACCES : 0;
> -	return 0;
> -}
> -
> static int ext4_release_dir(struct inode *inode, struct file *filp)
> {
> 	if (filp->private_data)
> @@ -664,7 +657,6 @@ const struct file_operations ext4_dir_operations =3D=
 {
> 	.compat_ioctl	=3D ext4_compat_ioctl,
> #endif
> 	.fsync		=3D ext4_sync_file,
> -	.open		=3D ext4_dir_open,
> 	.release	=3D ext4_release_dir,
> };
>=20
> --
> 2.29.2
>=20


Cheers, Andreas






--Apple-Mail=_01B6A6AB-07E6-44B3-840B-68217F3B3E58
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/IGYYACgkQcqXauRfM
H+C5uA//dj+kl3QNfH3INI0cUezlI1fsFhtgaBhqU0VNBLme8P4JBKO0H5eEo2U1
Y4jxLrMogg0cHNDBOnktxcbRxez2fM3PkmtOYDE3CiGbtI1EcEzv8iyVI3U+doBC
C+YFk5u651LYq82qy8ABQTSglxqQZp0cUJct1WWyBRmtia5jPrlcK8lBnsO0wVyA
Q5PbLHcRntIRbx6f+OlTbScOQQXkzgJ2qsx55OOooCGfAOydg4NnfaRwcarr7xNN
RDD1McW6dmuSv4zDDnN5HecGb+C8T31+4HxsJz9yh8e2LRFyn9QcVGJljdBb+GJZ
FKEpeC1bgsgC955LuijiS7KtKHZCrzh/rfOeZDjD8Im7tpX/k5PP4i1TDEpDtZ2y
rQ13XvtIXfLVg/lscoIfP0IhiI+bhrM2CVff4av9WsK5LfoSLO+oQLXQ7Y++a1ZG
QveizaFGtrocBZAqf/WulCKgbm2WF9aOOw+Y8k2MItZzx0nfVSlnftGCuJ7/MAyl
zn/MikLGNo1I+5pCtvxMAucowDtVHQi3d2q6Eu/PGSrlqsrnIj3w5D9WbPKz4lEA
MIKk3h4RKPerTakBdwx/CWqqSX0OCFc/KIZSgPMOy+8S+ukORniUIHyVWXemRrA1
2X63GGsYOdJJPGjYJJ6BeuHAqCBO4qVg0zK6HayeeiRSu9Xb2Bc=
=Osx2
-----END PGP SIGNATURE-----

--Apple-Mail=_01B6A6AB-07E6-44B3-840B-68217F3B3E58--
