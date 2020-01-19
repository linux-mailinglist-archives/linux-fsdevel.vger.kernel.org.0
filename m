Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C24142064
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 23:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgASWPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 17:15:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33297 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgASWPB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:15:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id b6so27673033wrq.0;
        Sun, 19 Jan 2020 14:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=5C/21s2Wwq9PwMAt6lVh+OSHLPZCGgWk0Lbtnnplqkg=;
        b=WvyUuhHqDVBikbR/2FqxYIwIz4YRwUzQvdIs+86DZ8JcGFiLxBTjupbxq782xzrZdm
         o9L6q+l+FGluenfPrhRkvRbpJAZZKrkPKjv4R+91RklR09CiL240UAulZXuB1djcDJGq
         ysK2GD1dzgNhUPDMJUK9Fhu836vn0JrV4ixpLgLbNIh3BFB0tm7zNA5bfwfDGwiSHW4Y
         IcryRVSV/8e+tydxHzUiy94ElnakyXUwlLFdNtW/lM8D1Zy8s5cVy/HNsqI1Bo+pd/So
         cMLEndZ4l2xvDkYI50XL4LPUQWBYBEo2v5h+jZaYMadHSjURkUvY8+JLG6caWNr6RK0T
         3+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5C/21s2Wwq9PwMAt6lVh+OSHLPZCGgWk0Lbtnnplqkg=;
        b=qVOeyTbtzsQWahfK9+/fpWZ+Jo+1wv4uCduyA1LTuwEAUKnAqzaXaNDgG2lQgq6PCJ
         bV18YsXxxUjTlYv3eAdOGC+cegFqEtvcpE22GZszKGO4vqll0SHA3d26F/Sllr8L0FWV
         8tiP5qamcKdJGvZ6dgaFL4RgSbABO0QgaUkhEYyn6kdW+I2Fof23v8p6I3JYsckeDW14
         mhriMVaPz1jSFJS5hwAkqlXjkskdguIu3LXaP4S+mHQtIw/Fk+uHoRNQLUvdypNe/+If
         aTL61ZRLYckGC2xK7hs5yslG8vX2MBkWGJh2RrXACCbMAbkNAssyPZP8OLlQ/uKED9mx
         eR+w==
X-Gm-Message-State: APjAAAUiGGnslueHmryAY+AU11AVKHQaS32qYqXAXVNSTGV7HsXcMSjR
        lfOQkJSWnI9WTLs0QxAQZi7wPouo
X-Google-Smtp-Source: APXvYqw1hseEuiJFY+1lM/3chAQ2f4OjqQtGDuKkAGDs72Np/+jmGngB2qY50stnSRFAxLV3Kyv+fQ==
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr14305143wrx.87.1579472098241;
        Sun, 19 Jan 2020 14:14:58 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id f207sm5156954wme.9.2020.01.19.14.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 14:14:56 -0800 (PST)
Date:   Sun, 19 Jan 2020 23:14:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200119221455.bac7dc55g56q2l4r@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rshbc7x6puqknzpv"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--rshbc7x6puqknzpv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I have looked more deeply at vfat kernel code how is UTF-8 encoding
handled and I found out that case-insensitivity is broken, or rather not
implemented at all.

In fat_fill_super() function is already FIXME comment about this problem

	/* FIXME: utf8 is using iocharset for upper/lower conversion */
	if (sbi->options.isvfat) {
		sbi->nls_io =3D load_nls(sbi->options.iocharset);

Basically vfat always loads NLS table which is used for strnicmp and
tolower functions. When no is specified, then default (iso8859-1) is
used. And this applies also when utf8=3D1 mount option is specified. Also
note that kernel's utf8 NLS table does not implement toupper/tolower
functions (kernel's NLS API does not support tolower/toupper for
non-fixed-8bit encodings, like UTF-8).

So when UTF-8 on VFS for VFAT is enabled, then for VFS <--> VFAT
conversion are used utf16s_to_utf8s() and utf8s_to_utf16s() functions.
But in fat_name_match(), vfat_hashi() and vfat_cmpi() functions is used
NLS table (default iso8859-1) with nls_strnicmp() and nls_tolower().

Which means that fat_name_match(), vfat_hashi() and vfat_cmpi() are
broken for vfat in UTF-8 mode.

I was thinking how to fix it, and the only possible way is to write a
uni_tolower() function which takes one Unicode code point and returns
lowercase of input's Unicode code point. We cannot do any Unicode
normalization as VFAT specification does not say anything about it and
MS reference fastfat.sys implementation does not do it neither.

So, what would be the best option for implementing that function?

  unicode_t uni_tolower(unicode_t u);

Could a new fs/unicode code help with it? Or it is too tied with NFD
normalization and therefore cannot be easily used or extended?

New exfat code which is under review and hopefully would be merged,
contains own unicode upcase table (as defined by exfat specification) so
as exfat is similar to FAT32, maybe reusing it would be a better option?


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Proof that vfat in UTF-8 mode is broken and must be fixed:

$ mount | grep /mnt/fat
/tmp/fat2 on /mnt/fat type vfat
(rw,relatime,uid=3D1000,gid=3D1000,fmask=3D0022,dmask=3D0022,codepage=3D437=
,iocharset=3Diso8859-1,shortname=3Dmixed,utf8,errors=3Dremount-ro)
$ ll /mnt/fat/
total 1
drwxr-xr-x 2 pali pali 512 Jan 19 22:50 ./
drwxrwxrwt 4 root root  80 Jan 19 22:45 ../
$ touch /mnt/fat/=C4=8D
$ ll /mnt/fat/
total 1
drwxr-xr-x 2 pali pali 512 Jan 19 22:50 ./
drwxrwxrwt 4 root root  80 Jan 19 22:45 ../
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 =C4=8D*
$ touch /mnt/fat/=C4=8C
$ ll /mnt/fat/
total 1
drwxr-xr-x 2 pali pali 512 Jan 19 22:50 ./
drwxrwxrwt 4 root root  80 Jan 19 22:45 ../
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 =C4=8C*
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 =C4=8D*
$ touch /mnt/fat/d
$ ll /mnt/fat/
total 1
drwxr-xr-x 2 pali pali 512 Jan 19 22:50 ./
drwxrwxrwt 4 root root  80 Jan 19 22:45 ../
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 d*
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 =C4=8C*
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 =C4=8D*
$ touch /mnt/fat/D
$ ll /mnt/fat/
total 1
drwxr-xr-x 2 pali pali 512 Jan 19 22:50 ./
drwxrwxrwt 4 root root  80 Jan 19 22:45 ../
-rwxr-xr-x 1 pali pali   0 Jan 19 22:51 d*
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 =C4=8C*
-rwxr-xr-x 1 pali pali   0 Jan 19 22:50 =C4=8D*

As you can see lowercase 'd' and uppercase 'D' are same, but lowercase
'=C4=8D' and uppercase '=C4=8C' are not same. This is because '=C4=8D' is t=
wo bytes
0xc4 0x8d sequence and comparing is done by Latin1 table. 0xc4 is in
Latin '=C3=84' which is already in uppercase. 0x8d is control char so is not
changed by tolower/toupper function.

Bigger problem can be with U+C9FF code point. In UTF-8 it is encoded as
bytes 0xe3 0xa7 0xbf (in Latin1 =C3=A3=C2=A7=C2=BF). If you convert it by L=
atin1 upper
case table you get =C3=83=C2=A7=C2=BF (bytes 0xc3 0xa7 0xbf). First two byt=
es is valid
UTF-8 sequence for character =C3=A7 =3D U+00E7.

Therefore U+C9FF and U+00E7 may be treated in some cases as same
character (when comparing just prefixes), difference only in upper case,
which is fully wrong.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rshbc7x6puqknzpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiTU2gAKCRCL8Mk9A+RD
UkpNAKDHTBYhg1duhysmq6LcBjBJyePAswCgjzSXIcmolga7LEiyn37Rz4gOcew=
=h6yF
-----END PGP SIGNATURE-----

--rshbc7x6puqknzpv--
