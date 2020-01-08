Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B96134F6E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgAHWcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 17:32:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37549 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgAHWcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:32:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id f129so655028wmf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jan 2020 14:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eq/fDUOgrwbTI7WsMiD/6p94cvdOOCHXTPt6ntZVsoo=;
        b=uavVqvxNb3Oc5XTWwpmXJiCXuR9N6/YKLK5c0DQOpFSfZZmDCYm+zCBLWLQ6yue7/U
         cSocHWrLTVArucPUToCS1l9W3WTrGuS9wi57yfBjwsdtR+HygahrwY2xcw6hjbbATbGJ
         Vl0meXIjoN+8Jtvwxx/sW4WyVJgP58X4e/ykpp1NBdNAV+0N/0ZAt5VQDwWhmZX7bTM5
         e2Kdg5BUiiHyyXdRj8vt2G+GEuDhcWFe4dBBAgw3UzzcpzJt8ZSn41vfg+WrCKCAe/UT
         X2LTGY1ndcrD1ar7XI6HjN7Nccqr3/6Iv6U+Jvm8dHsT0aljzDJ4VNxKmg08pgRUWFQy
         XPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eq/fDUOgrwbTI7WsMiD/6p94cvdOOCHXTPt6ntZVsoo=;
        b=ocERaakvCjRcQHoZzrd3gg53Y3Nccvg1CPlN9tvjYJEOb/XOMKiX1Sp3mZeryaDa5m
         1q7GeLDfInufOdQBTVp6uV+d1O8enQjGq/0IcVf9/S0PIAK4gxF2QU1xrsaJdmPD7Vlg
         psAoR07MHTgddckmBWzJ5WuO4bpFYVvqTPsPuHwAYpZFbNdhi9rBCObl/ZNOcu/jTZXS
         x/RWp8KUcjy5JBtktppK9mluJJBq8yzSBc3PpN+ywq8t3r/5s9/oZhOHelUn1u8CWvGG
         qPBgRRWmUiGp/t+J1aUy5GyyeklLOlfc0XhOJijCSd5aiJxftcx9/jFbJa2wdnx2D9HW
         j3/g==
X-Gm-Message-State: APjAAAUGWJJNW1769dQVRys7TEOKh5LEfwX055u1iqTrMLEWYKT7DN9N
        T3jPlCPcBQoJIxu1PFZoQvPCGeaN
X-Google-Smtp-Source: APXvYqwqe0x5dEPKYL/Pg4Df5AJoibIsaw1ilFdDohN1moww3ubHGCmdbFbdLl2KV+pP1HSRzZ/Z3w==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr846767wmb.41.1578522762896;
        Wed, 08 Jan 2020 14:32:42 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q14sm627387wmj.14.2020.01.08.14.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 14:32:41 -0800 (PST)
Date:   Wed, 8 Jan 2020 23:32:40 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] udf: Fix free space reporting for metadata and virtual
 partitions
Message-ID: <20200108223240.gi5g2jza3rxuzk6z@pali>
References: <20200108121919.12343-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="updgu7gymrzcenyp"
Content-Disposition: inline
In-Reply-To: <20200108121919.12343-1-jack@suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--updgu7gymrzcenyp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 January 2020 13:19:19 Jan Kara wrote:
> Free space on filesystems with metadata or virtual partition maps
> currently gets misreported. This is because these partitions are just
> remapped onto underlying real partitions from which keep track of free
> blocks. Take this remapping into account when counting free blocks as
> well.
>=20
> Reported-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/udf/super.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> I plan to take this patch to my tree.
>=20
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 8c28e93e9b73..b89e420a4b85 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -2492,17 +2492,26 @@ static unsigned int udf_count_free_table(struct s=
uper_block *sb,
>  static unsigned int udf_count_free(struct super_block *sb)
>  {
>  	unsigned int accum =3D 0;
> -	struct udf_sb_info *sbi;
> +	struct udf_sb_info *sbi =3D UDF_SB(sb);
>  	struct udf_part_map *map;
> +	unsigned int part =3D sbi->s_partition;
> +	int ptype =3D sbi->s_partmaps[part].s_partition_type;
> +
> +	if (ptype =3D=3D UDF_METADATA_MAP25) {
> +		part =3D sbi->s_partmaps[part].s_type_specific.s_metadata.
> +							s_phys_partition_ref;
> +	} else if (ptype =3D=3D UDF_VIRTUAL_MAP15 || ptype =3D=3D UDF_VIRTUAL_M=
AP20) {
> +		part =3D UDF_I(sbi->s_vat_inode)->i_location.
> +							partitionReferenceNum;

Hello! I do not think that it make sense to report "free blocks" for
discs with Virtual partition. By definition of VAT, all blocks prior to
VAT are already "read-only" and therefore these blocks cannot be use for
writing new data by any implementation. And because VAT is stored on the
last block, in our model all blocks are "occupied".

> +	}
> =20
> -	sbi =3D UDF_SB(sb);
>  	if (sbi->s_lvid_bh) {
>  		struct logicalVolIntegrityDesc *lvid =3D
>  			(struct logicalVolIntegrityDesc *)
>  			sbi->s_lvid_bh->b_data;
> -		if (le32_to_cpu(lvid->numOfPartitions) > sbi->s_partition) {
> +		if (le32_to_cpu(lvid->numOfPartitions) > part) {
>  			accum =3D le32_to_cpu(
> -					lvid->freeSpaceTable[sbi->s_partition]);
> +					lvid->freeSpaceTable[part]);

And in any case freeSpaceTable should not be used for discs with VAT.
And we should ignore its value for discs with VAT.

UDF 2.60 2.2.6.2: Free Space Table values be maintained ... except ...
for a virtual partition ...

And same applies for "partition with Access Type pseudo-overwritable".

>  			if (accum =3D=3D 0xFFFFFFFF)
>  				accum =3D 0;
>  		}
> @@ -2511,7 +2520,7 @@ static unsigned int udf_count_free(struct super_blo=
ck *sb)
>  	if (accum)
>  		return accum;
> =20
> -	map =3D &sbi->s_partmaps[sbi->s_partition];
> +	map =3D &sbi->s_partmaps[part];
>  	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
>  		accum +=3D udf_count_free_bitmap(sb,
>  					       map->s_uspace.s_bitmap);

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--updgu7gymrzcenyp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhZYhgAKCRCL8Mk9A+RD
UmgnAJ9u+wue2OvYOr9gG/RtL3dKqoyJ1wCgw/nYu0os3rPDskmR31Oyaw5oTRM=
=5YZa
-----END PGP SIGNATURE-----

--updgu7gymrzcenyp--
