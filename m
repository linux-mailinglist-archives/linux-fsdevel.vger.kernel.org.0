Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A7F1420F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 00:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgASXdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 18:33:52 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39971 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgASXdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 18:33:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so27715179wrn.7;
        Sun, 19 Jan 2020 15:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z5DCatifX2BVNPC1+0wyDH7ruQayHqsz0MhpA+ub/OM=;
        b=EcSvkV8LsiYMFdL2XCwVqf6v/aQYq82C7ZJX4zfeyIvZxDEP6BjZvD+hMxJ/K1uE7G
         PIe40H8BWsSyR8y/TJiE1RHj2XO+ig/1ens37p62plwS3teO6pawbK/BYllJmbq1tIXi
         0gfai2BufhgVfrMHgzA4SKDwHNnCLBzw6TCusgeKk/sX2NktpOQC3TRy6bC5GTCxuwvZ
         d/UMfoDRpYP0xFFuF2T7C4IczItGE9YsCwaRcuLjdtnayABrr4yr61N4dMGoJol8dc6N
         6AMvPGmesphf8xq/8fQhiTBSrXo0bbdLo6j9wi/ooNpnmX1rLL38RAWsPgwITRGPdtFh
         JjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z5DCatifX2BVNPC1+0wyDH7ruQayHqsz0MhpA+ub/OM=;
        b=DMhxIExsaJuwgU02pqRjpfiiRXi9VCSKF+MmRkE3MBu2v67P1HJ+ujbL0GxJcA73/n
         My+IrHh0Z8LTm6iFN1Gks6vCTMt2yFh32BN5kPqcEREZIYjalju9XR7XJwDRtRqiyOPJ
         MDISvG3cSBh+/wh/eH+/mHJm1nP9372QG1AvzejI1E14qpDqJqlDFu4zMg4NxcYJFqFN
         b6o8jYkMO8iRfGsCatuNVSf62stnJYRJVHZMWDmjoBqCoYn3F1ZRIwnIIJtV7wIBWcHL
         pt8qDzzRtWADhuxybfjkKsLlRZadk5iJ6dt2XZuIJD/hymwOVF2sL/O12cKy+RyTpq9S
         C6pQ==
X-Gm-Message-State: APjAAAXVAlBDewk18oQi0tyoq1RiTuz4q1QO2aDhfkTqkV0zizcqENC+
        OeuAbwRnfmj0ErEbgEkVINM=
X-Google-Smtp-Source: APXvYqwlh1dMpJaYswZBjI8wQ5Z6NU1yhwVpK2GvZe/fmQoAogzXtIAXSFFOpI4mxMMF+ElN8BV9kg==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr15241995wrs.106.1579476830223;
        Sun, 19 Jan 2020 15:33:50 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t12sm44916041wrs.96.2020.01.19.15.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 15:33:49 -0800 (PST)
Date:   Mon, 20 Jan 2020 00:33:48 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200119233348.es5m63kapdvyesal@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <20200119230809.GW8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lp2jkxbsd2wdqylt"
Content-Disposition: inline
In-Reply-To: <20200119230809.GW8904@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lp2jkxbsd2wdqylt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sunday 19 January 2020 23:08:09 Al Viro wrote:
> On Sun, Jan 19, 2020 at 11:14:55PM +0100, Pali Roh=C3=A1r wrote:
>=20
> > So when UTF-8 on VFS for VFAT is enabled, then for VFS <--> VFAT
> > conversion are used utf16s_to_utf8s() and utf8s_to_utf16s() functions.
> > But in fat_name_match(), vfat_hashi() and vfat_cmpi() functions is used
> > NLS table (default iso8859-1) with nls_strnicmp() and nls_tolower().
> >=20
> > Which means that fat_name_match(), vfat_hashi() and vfat_cmpi() are
> > broken for vfat in UTF-8 mode.
> >=20
> > I was thinking how to fix it, and the only possible way is to write a
> > uni_tolower() function which takes one Unicode code point and returns
> > lowercase of input's Unicode code point. We cannot do any Unicode
> > normalization as VFAT specification does not say anything about it and
> > MS reference fastfat.sys implementation does not do it neither.
>=20
> Then how can that possibly be broken?  If it matches the native behaviour,
> that's it.

VFAT is case insensitive.

> > As you can see lowercase 'd' and uppercase 'D' are same, but lowercase
> > '=C4=8D' and uppercase '=C4=8C' are not same. This is because '=C4=8D' =
is two bytes
> > 0xc4 0x8d sequence and comparing is done by Latin1 table. 0xc4 is in
> > Latin '=C3=84' which is already in uppercase. 0x8d is control char so i=
s not
> > changed by tolower/toupper function.
>=20
> Again, who the hell cares?

All users who use also non-Linux fat implementations.

> Does the behaviour match how Windows handles that thing?

Linux behavior does not match Windows behavior.

On Windows is FAT32 (fastfat.sys) case insensitive and file names "=C4=8D"
and "=C4=8C" are treated as same file. Windows does not allow you to create
both files. It says that file already exists.

> "Case" is not something well-defined; the only definition
> is "whatever weird crap does the native implementation choose to do".

You are right that case sensitiveness is not well-defined, but in
Unicode we have also language-independent and basically well-defined
conversion.

And because VFAT is Unicode fs (internally UTF-16) it make sense that
well-defined Unicode folding should be used.

> That's the only reason to support that garbage at all...

What do you mean by garbage? Where? All filenames which I specified are
valid UTF-8 sequences, valid Unicode code points and therefore have
valid UTF-16 representation stored in VFAT fs.

Sorry, but I did not understand your comment.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--lp2jkxbsd2wdqylt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiTnWgAKCRCL8Mk9A+RD
UnD3AKC/BUng/hJ5a6c7TzJLVXLIgm70lwCghBL7vuR3nHniaBYhpuYQuQ32okg=
=eo4j
-----END PGP SIGNATURE-----

--lp2jkxbsd2wdqylt--
