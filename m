Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8084214150E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 01:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgARALM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 19:11:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53391 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbgARALM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 19:11:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id m24so9013649wmc.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2020 16:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AWhjhzqaJbKW3/DjFTb/WDnEC7cts3JDSGXlYko4X4c=;
        b=blecLoH8s9gjhQwCYmL9vaCoi8iVitLjI/TkerC/2WmCg7u+wwFK0NcYBD96kWWZnQ
         qr7zdA5jV3xUYD3xOK9LVV8wV8BHy1WmrHA/93TCb4bBaM1pRLTNIL858HZ0sAmHZwhQ
         ZTv4ofhERETHS/1HKU+MkIK8lHgdi8Jb9/tkHwpY8RSS1HM6wFxTcDsuI0bT/VbpnCkO
         d/wrXn0A6gk1D1yzG3xErJPFLBPef50ml+OxbUG31oSTmlROP7jDDYdMMNTXAo9K+Ris
         qgDpZfy+bL2wseAvEXNk9tlWo2AQSXSs4jzyfP+EZRL1+Wvkl6Y2zMBZ8fKNb53UyExf
         Olhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AWhjhzqaJbKW3/DjFTb/WDnEC7cts3JDSGXlYko4X4c=;
        b=HjRYyYxUgzm7d2Ifg1KgDYGShYLapXhwJ9iR7gtg3vsWpsQcSJVDBtpM2WB/CkV3p9
         VOmRe2p8Yhst0Cz7F4bQAY20IsUny/VYKmJomiPUEcgR1cIIvKI7FZ8qyxhegmBwb+ZP
         Ydacowgt1RbpNW6Biq7hCLMF7wpbSSpcbnTY85q91JwzQa1VyYfIc+0c/eaRUia0byMR
         FURePU0ZcM5ZSSApN8cPS4nX9bID+l15vlqu5RVx4FoPRWbPkVNXMiQaor/WPpsRz5MT
         CB5HMg+SAySkgi3mhq3b23MLvU/G28v/xAlyTgJV3k+tCOL1OKd2+pRRDkAKS+WChxEX
         83VA==
X-Gm-Message-State: APjAAAWJjX482y0+2qwRbEQuawdHOeQqqf+0JwYBXohd9eBZ/agCI98Q
        gDuzkFWVJbXDduwCjVCX1i5o8tJm
X-Google-Smtp-Source: APXvYqzBWpFS8xxuxwO1o5E3guCVfChDSeDShoZe8ecXz9Z8nN0srleQt8sBV4Ss8M9wtvIw1eKLog==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr7207019wmb.150.1579306269479;
        Fri, 17 Jan 2020 16:11:09 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u1sm6376802wmc.5.2020.01.17.16.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 16:11:08 -0800 (PST)
Date:   Sat, 18 Jan 2020 01:11:07 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: udf: Suspicious values in udf_statfs()
Message-ID: <20200118001107.aove7ohhuosdsvgx@pali>
References: <20200112162311.khkvcu2u6y4gbbr7@pali>
 <20200113120851.GG23642@quack2.suse.cz>
 <20200117120511.GI17141@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hsstcargjvjn5qbh"
Content-Disposition: inline
In-Reply-To: <20200117120511.GI17141@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hsstcargjvjn5qbh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 17 January 2020 13:05:11 Jan Kara wrote:
> On Mon 13-01-20 13:08:51, Jan Kara wrote:
> > Hello,
> >=20
> > On Sun 12-01-20 17:23:11, Pali Roh=C3=A1r wrote:
> > > I looked at udf_statfs() implementation and I see there two things wh=
ich
> > > are probably incorrect:
> > >=20
> > > First one:
> > >=20
> > > 	buf->f_blocks =3D sbi->s_partmaps[sbi->s_partition].s_partition_len;
> > >=20
> > > If sbi->s_partition points to Metadata partition then reported number
> > > of blocks seems to be incorrect. Similar like in udf_count_free().
> >=20
> > Oh, right. This needs similar treatment like udf_count_free(). I'll fix=
 it.
> > Thanks for spotting.
>=20
> Patch for this is attached.

I was wrong. After reading UDF specification and kernel implementation
again I realized that there is a complete mess what "partition" means.

Sometimes it is Partition Map, sometimes it is Partition Descriptor,
sometimes it is index of Partition Map, sometimes index of Partition
Descriptor, sometimes it refers to data referenced by Partition
Descriptor and sometimes it refers to data referenced by Partition Map.

And "length" means length of any of above structure (either of map
structure, either of data pointed by map structure, either of descriptor
or either of data pointed by descriptor).

So to make it clear, member "s_partition_len" refers to length of data
pointed by Partition Descriptor, therefore length of physical partition.

As kernel probably does not support UDF fs with more then one Partition
Descriptor, whatever Partition Map we choose (s_partmaps[i] member) we
would always get same value in "s_partition_len" as it does not refer to
data of Partition Map, but rather to data of Partition Descriptor.

As both Metadata Partition Map and Type 1 Partition Map (or Sparable
Partition Map) shares same Partition Descriptor, this patch does not
change value of "f_blocks" member and therefore is not needed at all.
So current code should be correct.

But please, double check that I'm correct as "partition" naming in
probably every one variable is misleading.

Just to note, free space is calculated from Partition Map index
(not from Partition Descriptor index), therefore previous patch for
udf_count_free() is really needed and should be correct.

> From 2e831a1fb4fa4a6843e154edb1d9e80a1c610803 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Fri, 17 Jan 2020 12:41:39 +0100
> Subject: [PATCH] udf: Handle metadata partition better for statfs(2)
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> When the filesystem uses Metadata partition, we need to look at the
> underlying partition to get real total number of blocks in the
> filesystem. Do the necessary remapping in udf_statfs().
>=20
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/udf/super.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index f747bf72edbe..3bb9793db3aa 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2395,11 +2395,17 @@ static int udf_statfs(struct dentry *dentry, stru=
ct kstatfs *buf)
>  	struct udf_sb_info *sbi =3D UDF_SB(sb);
>  	struct logicalVolIntegrityDescImpUse *lvidiu;
>  	u64 id =3D huge_encode_dev(sb->s_bdev->bd_dev);
> +	unsigned int part =3D sbi->s_partition;
> +	int ptype =3D sbi->s_partmaps[part].s_partition_type;
> =20
> +	if (ptype =3D=3D UDF_METADATA_MAP25) {
> +		part =3D sbi->s_partmaps[part].s_type_specific.s_metadata.
> +							s_phys_partition_ref;
> +	}
>  	lvidiu =3D udf_sb_lvidiu(sb);
>  	buf->f_type =3D UDF_SUPER_MAGIC;
>  	buf->f_bsize =3D sb->s_blocksize;
> -	buf->f_blocks =3D sbi->s_partmaps[sbi->s_partition].s_partition_len;
> +	buf->f_blocks =3D sbi->s_partmaps[part].s_partition_len;
>  	buf->f_bfree =3D udf_count_free(sb);
>  	buf->f_bavail =3D buf->f_bfree;
>  	/*

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--hsstcargjvjn5qbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiJNGQAKCRCL8Mk9A+RD
UjWaAJsEzAVGdDzuQWm0GL4DbnfKLlIwiwCgpZnbVaDbz/TWDtheQjrABSDOU0E=
=Sz3M
-----END PGP SIGNATURE-----

--hsstcargjvjn5qbh--
