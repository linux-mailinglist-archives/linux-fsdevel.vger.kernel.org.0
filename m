Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A8D14347E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 00:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgATXfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 18:35:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54855 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgATXfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 18:35:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id b19so1085335wmj.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2020 15:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+Ad7unWlOQu39sqyighNumSVGGhQVwTHsV7yT66ZzC4=;
        b=iIcMMj6B5v9b0RAqgKw79h5LFRWqKsnJ7Hceux0SOqckJe40AvCR3GGESoGSYoFA9P
         MW4T4d0oP4T/SkQBEaAG1yMSGIvQNoS/hBSn7UnkDdl92/FAj9HBJNwfpt20Y+m4Zwu3
         MJggzr+07aYDJlcN/AEHu71Sq3s0Vka6xdkeVCzmehF+bgyIj3Nb99g2WeBrAOsxMQdR
         RaOKVbhUkh7y0qiM+Aqhe5p3oAtiMvkre1BDyNcrHwrN/V+E723oQFuCssx0Ng4AP7wh
         tVkWqNRxitqyWHXjwEjj5UpQ6cesc14k0QwU6YpQ70srYmM/T/EIH07uGzD9+lub//E2
         MWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Ad7unWlOQu39sqyighNumSVGGhQVwTHsV7yT66ZzC4=;
        b=lD3EebRRKYm4FaCe+b88/tAN/iGFiR2xu2vOiMj3CkDDweG/9gs1pKDxwY89CDkrLM
         yeYc1kO2mYdEOaemfQGsXtD5qOW92rKoC4eI+6GF7f11ZDdjBBTX2Qa23c96iBbabHj1
         YV1ate64JDFqWxr1szyv81vTWBPA/L3uJhOsipBadEmsHXyMhdNYDYAX7I7Q+2Wfp7qE
         YkNuE7iijyKYcgAacAylGMSyMpE752QvMPykMBetvh6+bsCL7i7KpLZSBTLxxe/p5pAa
         LT/nX9ElTNKgKEgsjggkRS9DIB6tkcQeSG2KCVc0PyIfOC/62j4GMLrOUBnpMZnhsaHY
         g5Sg==
X-Gm-Message-State: APjAAAWqbEpjCnahMgg7a4D/HTVIH1tDzfSp+e3HNlAEXSwr8tAJcMl0
        S4Tm5QgKQz3Fm0wscL+fKUYvpFwX
X-Google-Smtp-Source: APXvYqw9Z4utoFCuBbq5sAaqrsNEJSko/j1WirssTyywBt5P8JpzN5s6n+w0mtZHefsf6CL9whunBQ==
X-Received: by 2002:a1c:964f:: with SMTP id y76mr1122699wmd.62.1579563345461;
        Mon, 20 Jan 2020 15:35:45 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id n16sm50435949wro.88.2020.01.20.15.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 15:35:44 -0800 (PST)
Date:   Tue, 21 Jan 2020 00:35:43 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: udf: Incorrect handling of timezone
Message-ID: <20200120233543.3xsuwjlpoylq3jwe@pali>
References: <20200119124944.lf4vsqhwwbrxyibk@pali>
 <20200120113116.GC19861@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rd46w3espna2d2vc"
Content-Disposition: inline
In-Reply-To: <20200120113116.GC19861@quack2.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--rd46w3espna2d2vc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 20 January 2020 12:31:16 Jan Kara wrote:
> On Sun 19-01-20 13:49:44, Pali Roh=C3=A1r wrote:
> > Hello! I looked at udf code which converts linux time to UDF time and I
> > found out that conversion of timezone is incorrect.
> >=20
> > Relevant code from udf_time_to_disk_stamp() function:
> >=20
> > 	int16_t offset;
> >=20
> > 	offset =3D -sys_tz.tz_minuteswest;
> >=20
> > 	dest->typeAndTimezone =3D cpu_to_le16(0x1000 | (offset & 0x0FFF));
> >=20
> > UDF 2.60 2.1.4.1 Uint16 TypeAndTimezone; says:
> >=20
> >   For the following descriptions Type refers to the most significant 4 =
bits of this
> >   field, and TimeZone refers to the least significant 12 bits of this f=
ield, which is
> >   interpreted as a signed 12-bit number in two=E2=80=99s complement for=
m.
> >=20
> >   TimeZone ... If this field contains -2047 then the time zone has not =
been specified.
> >=20
> > As offset is of signed 16bit integer, (offset & 0x0FFF) result always
> > clears sign bit and therefore timezone is stored to UDF fs incorrectly.
>=20
> I don't think the code is actually wrong. Two's complement has a nice
> properly that changing type width can be done just by masking - as an
> example -21 in s32 is 0xffffffeb, if you reduce to just 12-bits, you get
> 0xfeb which is still proper two's complement encoding of -21 for 12-bit w=
ide
> numbers.

Ou right, so it is really OK. Thank you for clarification.

> > This needs to be fixed, sign bit from tz_minuteswest needs to be
> > propagated to 12th bit in typeAndTimezone member.
> >=20
> > Also tz_minuteswest is of int type, so conversion to int16_t (or more
> > precisely int12_t) can be truncated. So this needs to be handled too.
>=20
> tz_minuteswest is limited to +-15 hours (i.e., 900 minutes) so we shouldn=
't
> need to handle truncating explicitely.

Fine, then code is correct.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rd46w3espna2d2vc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiY5TQAKCRCL8Mk9A+RD
Uq2BAJ0R/ohIfKhMi/8WD32akFQ4mTZUHACffpZ8t24xCSw5jsHPnFc6RVoI5TI=
=Ixar
-----END PGP SIGNATURE-----

--rd46w3espna2d2vc--
