Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA55139867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 19:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAMSLn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 13:11:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33207 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgAMSLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 13:11:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so9628596wrq.0;
        Mon, 13 Jan 2020 10:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uPVm5hkau2avZJszOC1N8WygJacrNIkqFqGLAd5A9U4=;
        b=jvvGdbKX5ldral0ASnIkZktNNUcq9mFuLem8RNNSob3Z+ldHF3VYqNWcYm51tGapOB
         2u+vYF6q1RuFHX0IIZLulXqdA0cS3Bt9WO8ebg9pslobIJl/6rvRHdwjEoxkBwsEDwvg
         Tvn+zEy32B4S9ZYrYlXquKCyi9iY8nNFZKvTYZQiiIOqs6ztdcYrwHWgWBtv34ZwG0R4
         yMUNvPd+2EUBjyNIWpTc7ivTsQVPOyNfROHlkhatBaTtrctryktLS90fsnKnyaO4gnj0
         9YirHQj3k36xqSwyRfK82I1hHbcoufGLd32+MX9D3tqk6aZrtXhEVx2tbQSLhab1+8Q0
         hsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPVm5hkau2avZJszOC1N8WygJacrNIkqFqGLAd5A9U4=;
        b=M4BJ7jmV41dSh+DBKl/6W6fL6zT3mnrOkA8MbBAowbJqUdKoAtH5V6Kr0OuQy0tXlj
         dV5HMp+NN2Ud4vjWYSPmS3p3idqnzuFkhyCF5yTcpEQmJdb2RfDh0ck1pxw37EYP31Jm
         snsYHMMRBUENYcky3D+s03e66iukVqm2d3/EnPeEO+g5ydXoMWPldcq32gPA653pGgfU
         fyMuoY1HykayDgOFTYkwGIbKoZu9XJ6tOVsQhPKzyO0nweF+L8jJ/4my1I4q/7bpHAgo
         Dy70Ioil2kdsqDBCVpPkPA4R9Z1o7hnJX3uRbVVG2lkVyWkj99xxXA/hMnAzlbAiTUKb
         LqGA==
X-Gm-Message-State: APjAAAWIiBrFIy9hVvEOb26PcOTgcySx14jd3NoCfRXCq2P6lmwjjimi
        Qqwd1x+YDPhDHPoTjTs4aes=
X-Google-Smtp-Source: APXvYqwoFiHz2JVimqUJiS0ZWmsb8K3cDxBCGzjyxYDqT7d/1e0brSlZkxMOkhrfXOjIi2UcyLIUjQ==
X-Received: by 2002:adf:e550:: with SMTP id z16mr20114651wrm.315.1578939100472;
        Mon, 13 Jan 2020 10:11:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id i5sm15086910wml.31.2020.01.13.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 10:11:39 -0800 (PST)
Date:   Mon, 13 Jan 2020 19:11:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [WIP PATCH 2/4] udf: Fix reading numFiles and numDirs from UDF
 2.00+ VAT discs
Message-ID: <20200113181138.iqmo33ml2kpnmsfo@pali>
References: <20200112175933.5259-1-pali.rohar@gmail.com>
 <20200112175933.5259-3-pali.rohar@gmail.com>
 <20200113115822.GE23642@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sg2x6nv6xm67glzb"
Content-Disposition: inline
In-Reply-To: <20200113115822.GE23642@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sg2x6nv6xm67glzb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 13 January 2020 12:58:22 Jan Kara wrote:
> On Sun 12-01-20 18:59:31, Pali Roh=C3=A1r wrote:
> > These two fields are stored in VAT and override previous values stored =
in
> > LVIDIU.
> >=20
> > This change contains only implementation for UDF 2.00+. For UDF 1.50 th=
ere
> > is an optional structure "Logical Volume Extended Information" which is=
 not
> > implemented in this change yet.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>=20
> For this and the following patch, I'd rather have the 'additional data'
> like number of files, dirs, or revisions, stored in the superblock than
> having them hidden in the VAT partition structure. And places that parse
> corresponding on-disk structures would fill in the numbers into the
> superblock.

This is not simple. Kernel first reads and parses VAT and later parses
LVIDIU. VAT is optional UDF feature and in UDF 1.50 are even those data
optional.

Logic for determining minimal write UDF revision is currently in code
which parse LVIDIU. And this is the only place which needs access UDF
revisions stored in VAT and LVIDIU.

UDF revision from LVD is already stored into superblock.

And because VAT is parsed prior to parsing LVIDIU is is also not easy to
store number of files and directories into superblock. LVIDIU needs to
know if data from VAT were loaded to superblock or not and needs to know
if data from LVIDIU should be stored into superblock or not.

Any idea how to do it without complicating whole code?

> 								Honza
> > ---
> >  fs/udf/super.c  | 25 ++++++++++++++++++++++---
> >  fs/udf/udf_sb.h |  3 +++
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/udf/super.c b/fs/udf/super.c
> > index 8df6e9962..e8661bf01 100644
> > --- a/fs/udf/super.c
> > +++ b/fs/udf/super.c
> > @@ -1202,6 +1202,8 @@ static int udf_load_vat(struct super_block *sb, i=
nt p_index, int type1_index)
> >  		map->s_type_specific.s_virtual.s_start_offset =3D 0;
> >  		map->s_type_specific.s_virtual.s_num_entries =3D
> >  			(sbi->s_vat_inode->i_size - 36) >> 2;
> > +		/* TODO: Add support for reading Logical Volume Extended Information=
 (UDF 1.50 Errata, DCN 5003, 3.3.4.5.1.3) */
> > +		map->s_type_specific.s_virtual.s_has_additional_data =3D false;
> >  	} else if (map->s_partition_type =3D=3D UDF_VIRTUAL_MAP20) {
> >  		vati =3D UDF_I(sbi->s_vat_inode);
> >  		if (vati->i_alloc_type !=3D ICBTAG_FLAG_AD_IN_ICB) {
> > @@ -1215,6 +1217,12 @@ static int udf_load_vat(struct super_block *sb, =
int p_index, int type1_index)
> >  							vati->i_ext.i_data;
> >  		}
> > =20
> > +		map->s_type_specific.s_virtual.s_has_additional_data =3D
> > +			true;
> > +		map->s_type_specific.s_virtual.s_num_files =3D
> > +			le32_to_cpu(vat20->numFiles);
> > +		map->s_type_specific.s_virtual.s_num_dirs =3D
> > +			le32_to_cpu(vat20->numDirs);
> >  		map->s_type_specific.s_virtual.s_start_offset =3D
> >  			le16_to_cpu(vat20->lengthHeader);
> >  		map->s_type_specific.s_virtual.s_num_entries =3D
> > @@ -2417,9 +2425,20 @@ static int udf_statfs(struct dentry *dentry, str=
uct kstatfs *buf)
> >  	buf->f_blocks =3D sbi->s_partmaps[sbi->s_partition].s_partition_len;
> >  	buf->f_bfree =3D udf_count_free(sb);
> >  	buf->f_bavail =3D buf->f_bfree;
> > -	buf->f_files =3D (lvidiu !=3D NULL ? (le32_to_cpu(lvidiu->numFiles) +
> > -					  le32_to_cpu(lvidiu->numDirs)) : 0)
> > -			+ buf->f_bfree;
> > +
> > +	if ((sbi->s_partmaps[sbi->s_partition].s_partition_type =3D=3D UDF_VI=
RTUAL_MAP15 ||
> > +	     sbi->s_partmaps[sbi->s_partition].s_partition_type =3D=3D UDF_VI=
RTUAL_MAP20) &&
> > +	     sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.s_ha=
s_additional_data)
> > +		buf->f_files =3D sbi->s_partmaps[sbi->s_partition].s_type_specific.s=
_virtual.s_num_files +
> > +			       sbi->s_partmaps[sbi->s_partition].s_type_specific.s_virtual.=
s_num_dirs +
> > +			       buf->f_bfree;
> > +	else if (lvidiu !=3D NULL)
> > +		buf->f_files =3D le32_to_cpu(lvidiu->numFiles) +
> > +			       le32_to_cpu(lvidiu->numDirs) +
> > +			       buf->f_bfree;
> > +	else
> > +		buf->f_files =3D buf->f_bfree;
> > +
> >  	buf->f_ffree =3D buf->f_bfree;
> >  	buf->f_namelen =3D UDF_NAME_LEN;
> >  	buf->f_fsid.val[0] =3D (u32)id;
> > diff --git a/fs/udf/udf_sb.h b/fs/udf/udf_sb.h
> > index 6bd0d4430..c74abbc84 100644
> > --- a/fs/udf/udf_sb.h
> > +++ b/fs/udf/udf_sb.h
> > @@ -78,6 +78,9 @@ struct udf_sparing_data {
> >  struct udf_virtual_data {
> >  	__u32	s_num_entries;
> >  	__u16	s_start_offset;
> > +	bool	s_has_additional_data;
> > +	__u32	s_num_files;
> > +	__u32	s_num_dirs;
> >  };
> > =20
> >  struct udf_bitmap {
> > --=20
> > 2.20.1
> >=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--sg2x6nv6xm67glzb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXhyy2AAKCRCL8Mk9A+RD
UgwvAJ9da0YhDoqSW4YYkzMsBuwhv42BqQCfTb6Gm6/D1H8nj3a9spMm1Xrr3YI=
=6a1y
-----END PGP SIGNATURE-----

--sg2x6nv6xm67glzb--
