Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2BF149D88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 00:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgAZXIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jan 2020 18:08:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40931 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgAZXIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jan 2020 18:08:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so8823885wrn.7;
        Sun, 26 Jan 2020 15:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONPHmqBn7jTACElcMz3lQIxMf+h5257Mcx0XJbZ+bH4=;
        b=qBf/2kaSm9xv9uaTVyGCcTc+PmnoQP52+kjJLiyEUhvghyXS/rNV/Bq9GCXokq3VUZ
         CNs+SALIcEyk7OF1xK9y5ZXvFzmT9eWzCwajlZRNMJo1Jh7dMKltIgpeBPCLsxUFBu6f
         t+u/IN4fhzPz4CGj8GlOsmUHGjFGOcS8Nb4JSg5jpOzrw2Jd2ti+cL3Cn3l+RuubHnMt
         qAdevV1R9Z2DS32+YWr6jO5zuFBlIr1H+i9PzhO+tgXOuKgV5oRiCDWW/aedxxBWRY/X
         rqUahBkcwYAemAzFLsrTjfPkCcEv0sVz8D2x9unJKGsQSkjmLrF4XY9k9K8qAzDz3+63
         wcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONPHmqBn7jTACElcMz3lQIxMf+h5257Mcx0XJbZ+bH4=;
        b=mqnQsNzVtkImHOLn+pDZ1/+6VWrwYS/GnFdbe2RUD/UVPZ9+Q6VKevP/8xV8lay32B
         xHs4u3jxMjwzB7DZkw/qaVvV73OQXRu0ra+/SF3b6eOFsQPc6U4rcPXb2hlxa7DvvyrG
         2ZOYGia3MwknQGYG7WtyOCkgZCLTki7BdTUxHnUAydTnqI7sH3qIwozH7TnO+uk0D+ov
         K2F4Veop04un5lChU1jPbcCaOAHcVhoqc5naxKJ2bi/+P9MsuuK5r3KVBV7Ya0fZD87U
         B1f9CTQnCbZyFAC19WM5gCgKrQD/6qCFnvrzVlmnSHUkbRdBy8OpeH42ZD0EQlq7DaAa
         a41g==
X-Gm-Message-State: APjAAAWmL0FoLphXxF62BpEimq6Mp4lJr4Qu0BhXFnZJDuuaAbVooPhM
        Lfc4hTO2wgmIhfQrMsTHyAs=
X-Google-Smtp-Source: APXvYqzgS0HN7GJub+d1AM42NXlTnL/NaqDEF3YHSFQXK0fSkV7fULkNDCZr3AK+vUYhi7ut3PCyCg==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr17032582wrn.270.1580080120790;
        Sun, 26 Jan 2020 15:08:40 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b10sm19452534wrt.90.2020.01.26.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2020 15:08:39 -0800 (PST)
Date:   Mon, 27 Jan 2020 00:08:38 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200126230838.yhdkt4h5pcbftvvr@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120110438.ak7jpyy66clx5v6x@pali>
 <875zh6pc0f.fsf@mail.parknet.co.jp>
 <20200120214046.f6uq7rlih7diqahz@pali>
 <20200120224625.GE8904@ZenIV.linux.org.uk>
 <20200120235745.hzza3fkehlmw5s45@pali>
 <20200121000701.GG8904@ZenIV.linux.org.uk>
 <20200121203405.7g7gisb3q55u2y2f@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="q2zzbxeaz7rnla6e"
Content-Disposition: inline
In-Reply-To: <20200121203405.7g7gisb3q55u2y2f@pali>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--q2zzbxeaz7rnla6e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 21 January 2020 21:34:05 Pali Roh=C3=A1r wrote:
> On Tuesday 21 January 2020 00:07:01 Al Viro wrote:
> > On Tue, Jan 21, 2020 at 12:57:45AM +0100, Pali Roh=C3=A1r wrote:
> > > On Monday 20 January 2020 22:46:25 Al Viro wrote:
> > > > On Mon, Jan 20, 2020 at 10:40:46PM +0100, Pali Roh=C3=A1r wrote:
> > > >=20
> > > > > Ok, I did some research. It took me it longer as I thought as lot=
 of
> > > > > stuff is undocumented and hard to find all relevant information.
> > > > >=20
> > > > > So... fastfat.sys is using ntos function RtlUpcaseUnicodeString()=
 which
> > > > > takes UTF-16 string and returns upper case UTF-16 string. There i=
s no
> > > > > mapping table in fastfat.sys driver itself.
> > > >=20
> > > > Er...  Surely it's OK to just tabulate that function on 65536 values
> > > > and see how could that be packed into something more compact?
> > >=20
> > > It is OK, but too complicated. That function is in nt kernel. So you
> > > need to build a new kernel module and also decide where to put output=
 of
> > > that function. It is a long time since I did some nt kernel hacking a=
nd
> > > nowadays you need to download 10GB+ of Visual Studio code, then addons
> > > for building kernel modules, figure out how to write and compile simp=
le
> > > kernel module via Visual Studio, write ini install file, try to load =
it
> > > and then you even fail as recent Windows kernels refuse to load kernel
> > > modules which are not signed...
> >=20
> > Wait a sec...  From NT userland, on a mounted VFAT:
> > 	for all s in single-codepoint strings
> > 		open s for append
> > 		if failed
> > 			print s on stderr, along with error value
> > 		write s to the opened file, adding to its tail
> > 		close the file
> > the for each equivalence class you'll get a single file, with all
> > members of that class written to it.  In addition you'll get the
> > list of prohibited codepoints.
> >=20
> > Why bother with any kind of kernel modules?  IDGI...
>=20
> This is a great idea to get FAT equivalence classes. Thank you!
>=20
> Now I quickly tried it... and it failed. FAT has restriction for number
> of files in a directory, so I would have to do it in more clever way,
> e.g prepare N directories and then try to create/open file for each
> single-point string in every directory until it success or fail in every
> one.

Now I have done test with more directories and finally it passed. I run
it on WinXP with different configurations And results are interesting...

First important thing: DOS OEM codepage is implicitly configured by
option "Language for non-Unicode programs" found in "Regional and
Language Options" at "Advanced" tab (run: intl.cpl). It is *not*
affected by "Standards and formats" language and also *not* by
"Location" language. Description for "Language for non-Unicode programs"
says: "It does not affect Unicode programs" which is clearly non-truth
as it affects all Unicode programs which stores data to FAT fs.

Second thing: Equivalence classes depends on OEM codepage. And are
different. Note that some languages shares one codepage.

CP850 (languages: English UK, Afrikaans, ...) has 614 non-trivial (*)
equivalence classes, CP852 (Slavic languages) has 619 and CP437 (English
USA) has only 586.

The biggest equivalence class is for 'U' and has following elements:

CP437:
0x0055 0x0075 0x00d9 0x00da 0x00db 0x00f9 0x00fa 0x00fb 0x0168 0x0169
0x016a 0x016b 0x016c 0x016d 0x016e 0x016f 0x0170 0x0171 0x0172 0x0173
0x01af 0x01b0 0x01d3 0x01d4 0x01d5 0x01d6 0x01d7 0x01d8 0x01d9 0x01da
0x01db 0x01dc 0xff35 0xff55

CP852:
0x0055 0x0075 0x00b5 0x00d9 0x00db 0x00f9 0x00fb 0x0168 0x0169 0x016a
0x016b 0x016c 0x016d 0x0172 0x0173 0x01af 0x01b0 0x01d3 0x01d4 0x01d5
0x01d6 0x01d7 0x01d8 0x01d9 0x01da 0x01db 0x01dc 0x03bc 0xff35 0xff55

CP850:
0x0055 0x0075 0x0168 0x0169 0x016a 0x016b 0x016c 0x016d 0x016e 0x016f
0x0170 0x0171 0x0172 0x0173 0x01af 0x01b0 0x01d3 0x01d4 0x01d5 0x01d6
0x01d7 0x01d8 0x01d9 0x01da 0x01db 0x01dc 0xff35 0xff55

Just to note that elements are Unicode code points.

It is interesting that for English USA (CP437) are "U" and "=C3=99" in same
equivalence class, but for English UK (CP850) are "U" and "=C3=99" in
different classes. CP850 has "U" in two-member class: 0x00d9 0x00f9

Are there any cultural, regional or linguistic reasons why English USA
and English UK languages/regions should treat "=C3=99" differently?

So third thing? How should be handle this complicated situation for our
VFAT implementation in Linux kernel when using UTF-8 encoding for
userspace?

For fixing case-insensitivity for UTF-8 I see there following options:

Option 1) Create intersect of equivalence classes from all codepages and
use this for Linux VFAT uppercase function. This would ensure that
whatever codepage/language windows uses, Linux VFAT does not create
inaccessible files for Windows (see PPS).

Option 2) As equivalence classes depends on codepage and VFAT already
needs to know codepage when mounting/accessing shortnames, we can
calculate "common" uppercase table (which would same for all codepages,
ideally from option 1)) and then differences from "common" uppercase
table to equivalence classes. Kernel already has uppercase tables for
NLS codepages and so we can store these "differences" to them. In this
case VFAT would know to uppercase function for specified codepage (which
is already passed as mount param).

Option 3) Ignores this MS shit nonsense (see PPS how it is broken) and
define uppercase table from Unicode standard. This would be the most
expected behavior for userspace, but incompatible with MS FAT32
implementation.

Option 4) Use uppercase table from Unicode standard (as in option 3),
but adds also definitions from option 1). This would ensure that all
files created by VFAT would be accessible on any Windows systems (see
PPS), plus there would be uppercase definitions from Unicode standard
(but only those which do not break definitions from 1) with respect to
PPS).

Option 5) Create API for kernel <---> userspace which would allow
userspace to define mapping table (or equivalence classes) and throw
away this problem from kernel to userspace. But as we already discussed
this is hard, plus without proper configuration from userspace, kernel's
VFAT driver could modify FS in way that MS would not be able to use it.

Or do you have a better idea how to handle this problem?



(*) - with more then one element

PS: If somebody is interested I can share my whole results and source
code of testing application.

PPS: If you create two files "U" and "=C3=99" on English UK (you can do that
as these codepoints are in different equivalence classes) and then
connect this FAT32 fs on English USA, you would not be able to access
"=C3=99" file. Windows English USA list both files "U" and "=C3=99", but wh=
ichever
you open, Windows get you always content of file "U". "=C3=99" is therefore
inaccessible until you change language to English UK.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--q2zzbxeaz7rnla6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXi4b8wAKCRCL8Mk9A+RD
UpdYAKCjudvfOYMaVBM0FCusjItj85h9mACcCc3hi1HwwseaJS8OGS85XJ1vXWg=
=VfdN
-----END PGP SIGNATURE-----

--q2zzbxeaz7rnla6e--
