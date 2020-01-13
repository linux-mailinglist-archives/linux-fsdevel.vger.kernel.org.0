Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35705139905
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgAMShd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 13:37:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36871 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAMShd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:37:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so9713602wru.4;
        Mon, 13 Jan 2020 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D2TL7rpzSqob/sDC/hydPzW24sBM11bScOsq1wytsRE=;
        b=O/9Rvhurjy7LuGV7r2wvXO5hh9AoaGDqwYpaYkScaAxvqhwJ1IVldPqmsZYMHZPxCv
         wJCREQ2qSn+KJ3/IZmNtkNs7i/FEPlTWYcMRj2sRo7nKXOtVzAVl08F8iwcRafw+5rCD
         aGS3wgvE2HZyJgtpoa+w16nTD3ZAm8cLMfsa9zItqaHYWkLGf6mL5veTwZN8nvrL/ZZq
         smV9r/9lXWggLXLGbYihH3TrgYYUwgtal1w62Bw6xxIAJtXg5uR1SX3DxzF87rSwWDOO
         KGH80Y2Pf+tkpz3tILbUcKPJC2bEUbcTOnwqg02KWlJxd2bBDDztN6F9rqep4S9dTinV
         4bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D2TL7rpzSqob/sDC/hydPzW24sBM11bScOsq1wytsRE=;
        b=rnNu6NnC9vpcpdzO6Gqc3tKGZKKOjQPD9+dP7VwDxYw5dQZx5JH2PuymbjdzzyHD0r
         Y3uUk80L9nvJDNSvpOSOb7MZNU0ySVgzmTYIByTRZpVAHzb56+ttauQ5DhbKxdoGA7oq
         PYXmN+ki1HUu/B9HALmksIHDWEwENMk2tV0EGafq1ge03RIe7YG7sVZJ3WFZxZdNILfK
         pghKT/AkbyhFPxfrpnA2h/o4FWALwiVMfutWyEhb/Eeanqrm1RgHlMzP5mSpR3EzUNWG
         B2Bo0JnQNQA4G8wYHBmXgvhCVLkl/gwnsTsTmnKAozW/Hcu34TWvo8+sLZAR6JjNlwX8
         N/8Q==
X-Gm-Message-State: APjAAAUfTIQ1hplpVSbTCYJrzapyH9GQIDiKc+SelCMvEQBzbnXPvPVV
        qOx6Te/GzLapn6XaTLJnSNk=
X-Google-Smtp-Source: APXvYqzu5WP5g1teOGMvZfUH0pk/Wy1ggJv+Q6K1+2rIpfrOsFSHLO7k1XZu+EW+wYFYLZxPOBh4Uw==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr21391701wrv.9.1578940649699;
        Mon, 13 Jan 2020 10:37:29 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id j12sm16149046wrt.55.2020.01.13.10.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:37:28 -0800 (PST)
Date:   Mon, 13 Jan 2020 19:37:28 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 1/4] udf: Do not access LVIDIU revision members when
 they are not filled
Message-ID: <20200113183728.ucuidmverddt4nme@pali>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
 <20200112175933.5259-2-pali.rohar@gmail.com>
 <20200113120049.GF23642@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rgnwop2n5mndo66j"
Content-Disposition: inline
In-Reply-To: <20200113120049.GF23642@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--rgnwop2n5mndo66j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 13 January 2020 13:00:49 Jan Kara wrote:
> On Sun 12-01-20 18:59:30, Pali Roh=C3=A1r wrote:
> > minUDFReadRev, minUDFWriteRev and maxUDFWriteRev members were introduce=
d in
> > UDF 1.02. Previous UDF revisions used that area for implementation spec=
ific
> > data. So in this case do not touch these members.
> >=20
> > To check if LVIDIU contain revisions members, first read UDF revision f=
rom
> > LVD. If revision is at least 1.02 LVIDIU should contain revision member=
s.
> >=20
> > This change should fix mounting UDF 1.01 images in R/W mode. Kernel wou=
ld
> > not touch, read overwrite implementation specific area of LVIDIU.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> Maybe we could store the fs revision in the superblock as well to avoid
> passing the udf_rev parameter?

Unfortunately not. Function udf_verify_domain_identifier() is called
also when parsing FSD. FSD is stored on partition map and e.g. Metadata
partition map depends on UDF revision. So it is not a good idea to
overwrite UDF revision from FSD. This is reason why I decided to use
initial UDF revision number only from LVD.

But whole stuff around UDF revision is a mess. UDF revision is stored on
these locations:

main LVD
reserve LVD
main IUVD
reserve IUVD
FSD

And optionally (when specific UDF feature is used) also on:

sparable partition map 1.50+
virtual partition map 1.50+
all sparing tables 1.50+
VAT 1.50

Plus tuple minimal read, minimal write, maximal write UDF revision is
stored on:

LVIDIU 1.02+
VAT 2.00+

VAT in 2.00+ format overrides information stored on LVIDIU.

> Also this patch contains several lines over 80 columns.

Ok, this is easy to solve.

> 									Honza
>=20
> > ---
> >  fs/udf/super.c  | 37 ++++++++++++++++++++++++++-----------
> >  fs/udf/udf_sb.h |  3 +++
> >  2 files changed, 29 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > index 2d0b90800..8df6e9962 100644
> > --- a/fs/udf/super.c
> > +++ b/fs/udf/super.c
> > @@ -765,7 +765,7 @@ static int udf_check_vsd(struct super_block *sb)
> >  }
> > =20
> >  static int udf_verify_domain_identifier(struct super_block *sb,
> > -					struct regid *ident, char *dname)
> > +					struct regid *ident, char *dname, u16 *udf_rev)
> >  {
> >  	struct domainIdentSuffix *suffix;
> > =20
> > @@ -779,6 +779,8 @@ static int udf_verify_domain_identifier(struct supe=
r_block *sb,
> >  		goto force_ro;
> >  	}
> >  	suffix =3D (struct domainIdentSuffix *)ident->identSuffix;
> > +	if (udf_rev)
> > +		*udf_rev =3D le16_to_cpu(suffix->UDFRevision);
> >  	if ((suffix->domainFlags & DOMAIN_FLAGS_HARD_WRITE_PROTECT) ||
> >  	    (suffix->domainFlags & DOMAIN_FLAGS_SOFT_WRITE_PROTECT)) {
> >  		if (!sb_rdonly(sb)) {
> > @@ -801,7 +803,7 @@ static int udf_load_fileset(struct super_block *sb,=
 struct fileSetDesc *fset,
> >  {
> >  	int ret;
> > =20
> > -	ret =3D udf_verify_domain_identifier(sb, &fset->domainIdent, "file se=
t");
> > +	ret =3D udf_verify_domain_identifier(sb, &fset->domainIdent, "file se=
t", NULL);
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > @@ -1404,7 +1406,7 @@ static int udf_load_logicalvol(struct super_block=
 *sb, sector_t block,
> >  	}
> > =20
> >  	ret =3D udf_verify_domain_identifier(sb, &lvd->domainIdent,
> > -					   "logical volume");
> > +					   "logical volume", &sbi->s_lvd_udfrev);
> >  	if (ret)
> >  		goto out_bh;
> >  	ret =3D udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartition=
Maps));
> > @@ -2055,12 +2057,19 @@ static void udf_close_lvid(struct super_block *=
sb)
> >  	mutex_lock(&sbi->s_alloc_mutex);
> >  	lvidiu->impIdent.identSuffix[0] =3D UDF_OS_CLASS_UNIX;
> >  	lvidiu->impIdent.identSuffix[1] =3D UDF_OS_ID_LINUX;
> > -	if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
> > -		lvidiu->maxUDFWriteRev =3D cpu_to_le16(UDF_MAX_WRITE_VERSION);
> > -	if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFReadRev))
> > -		lvidiu->minUDFReadRev =3D cpu_to_le16(sbi->s_udfrev);
> > -	if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFWriteRev))
> > -		lvidiu->minUDFWriteRev =3D cpu_to_le16(sbi->s_udfrev);
> > +
> > +	/* minUDFReadRev, minUDFWriteRev and maxUDFWriteRev members were
> > +	 * introduced in UDF 1.02. Previous UDF revisions used that area for
> > +	 * implementation specific data. So in this case do not touch it. */
> > +	if (sbi->s_lvd_udfrev >=3D 0x0102) {
> > +		if (UDF_MAX_WRITE_VERSION > le16_to_cpu(lvidiu->maxUDFWriteRev))
> > +			lvidiu->maxUDFWriteRev =3D cpu_to_le16(UDF_MAX_WRITE_VERSION);
> > +		if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFReadRev))
> > +			lvidiu->minUDFReadRev =3D cpu_to_le16(sbi->s_udfrev);
> > +		if (sbi->s_udfrev > le16_to_cpu(lvidiu->minUDFWriteRev))
> > +			lvidiu->minUDFWriteRev =3D cpu_to_le16(sbi->s_udfrev);
> > +	}
> > +
> >  	if (!UDF_QUERY_FLAG(sb, UDF_FLAG_INCONSISTENT))
> >  		lvid->integrityType =3D cpu_to_le32(LVID_INTEGRITY_TYPE_CLOSE);
> > =20
> > @@ -2220,8 +2229,14 @@ static int udf_fill_super(struct super_block *sb=
, void *options, int silent)
> >  			ret =3D -EINVAL;
> >  			goto error_out;
> >  		}
> > -		minUDFReadRev =3D le16_to_cpu(lvidiu->minUDFReadRev);
> > -		minUDFWriteRev =3D le16_to_cpu(lvidiu->minUDFWriteRev);
> > +
> > +		if (sbi->s_lvd_udfrev >=3D 0x0102) { /* minUDFReadRev and minUDFWrit=
eRev were introduced in UDF 1.02 */
> > +			minUDFReadRev =3D le16_to_cpu(lvidiu->minUDFReadRev);
> > +			minUDFWriteRev =3D le16_to_cpu(lvidiu->minUDFWriteRev);
> > +		} else {
> > +			minUDFReadRev =3D minUDFWriteRev =3D sbi->s_lvd_udfrev;
> > +		}
> > +
> >  		if (minUDFReadRev > UDF_MAX_READ_VERSION) {
> >  			udf_err(sb, "minUDFReadRev=3D%x (max is %x)\n",
> >  				minUDFReadRev,
> > diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> > index 3d83be54c..6bd0d4430 100644
> > --- a/fs/udf/udf_sb.h
> > +++ b/fs/udf/udf_sb.h
> > @@ -137,6 +137,9 @@ struct udf_sb_info {
> >  	/* Fileset Info */
> >  	__u16			s_serial_number;
> > =20
> > +	/* LVD UDF revision filled to media at format time */
> > +	__u16			s_lvd_udfrev;
> > +
> >  	/* highest UDF revision we have recorded to this media */
> >  	__u16			s_udfrev;
> > =20
> > --=20
> > 2.20.1
> >=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rgnwop2n5mndo66j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhy45gAKCRCL8Mk9A+RD
Us7PAKCcEL6CRbQnX8GRhNYYLlTO/WA+UACeJ7Qx4eDYpAfnfZKtE3P0zHFw+0Q=
=5tBU
-----END PGP SIGNATURE-----

--rgnwop2n5mndo66j--
