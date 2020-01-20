Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39860143127
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 18:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgATR4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 12:56:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41564 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgATR4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:56:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so383770wrw.8;
        Mon, 20 Jan 2020 09:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JZuOSWBnA5M2qMtmVK+1I+tzik8MyYOaO08HOlJh3Ew=;
        b=tXZwt1LEH3Q94LY/sB+pxef+HRu68BjSvnst/3CAiwLNPDta2/fEuSV4erkM+G9VGm
         u8KOks9thyHHnYzQ9Y4mvZ5EVgED+paN61iKuCI/s5VMh8SoKODMVpk2UTVN/jTf6/aT
         X8oISrIhB0prnTbP4mr25DJ/KGrsv26OmBdsm+o8DfWeQqmflUSsi5asKyK5Fwk7yUOB
         GgoXG3/XqZN1PF+/q0gWDxyLFAduIlcWS76VSEzRZwsVgd5qtbAOWYmkoq8BURH656XN
         PAmtnhwZ1KaCtFRwgLqtH9TDxja6lDDUvRTf8DrsupCib0JF2vvXdoUc13f9ePhy9NdS
         PC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZuOSWBnA5M2qMtmVK+1I+tzik8MyYOaO08HOlJh3Ew=;
        b=BGEoYKGkGj3v+WMbVynshhOiIszG0vY5mKLZk8hdlvW1YP5SmMWqRd1SYXgVvK/tF4
         lYgil+2jXZQfOsuB8L4H3z3qiixQ3PhiXHpvqJDzGdcptg6XWkKVhwKzEham0G7aoJiQ
         xzPE/DTFEOy+MpGVi9UN7YUJ2bMTYx84H4tJGdM4uKdw0l8ZHGcPDsO1rEuRsFHU+4A1
         2EsKpTe7Do0cPpzuTcHH8XzXUwqVTHritDTTiPh5aUMhxSK6mnSrmQqTRv31nRj3hW3V
         UZGFegNtw5Ijc72TbGkPOeUu0p2u8oKGVTjkegm2LOq2ElTysmcHONa7GI4OzRhxu9t8
         zDgQ==
X-Gm-Message-State: APjAAAVJiPQjz9QOVn4ild9oiId3JTaIjWzy1ETra7UDNk/qr75p1R+k
        kJEXJuMUzh0cXPxEpcJG3EY=
X-Google-Smtp-Source: APXvYqxhMh7xbHlTCx0oQZEnyNc8xSNCcl9u99IPEqQ4g8i+5CAiiVelDXXx5d2mJjUUjFZ8zDWNjQ==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr704622wrp.71.1579542972530;
        Mon, 20 Jan 2020 09:56:12 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p17sm168402wmk.30.2020.01.20.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 09:56:11 -0800 (PST)
Date:   Mon, 20 Jan 2020 18:56:10 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120175610.md2nu7f7qe2ekgly@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp>
 <20200120173215.GF15860@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eru6fx4r6gjf4yzc"
Content-Disposition: inline
In-Reply-To: <20200120173215.GF15860@mit.edu>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--eru6fx4r6gjf4yzc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday 20 January 2020 12:32:15 Theodore Y. Ts'o wrote:
> On Mon, Jan 20, 2020 at 01:04:42PM +0900, OGAWA Hirofumi wrote:
> >=20
> > To be perfect, the table would have to emulate what Windows use. It can
> > be unicode standard, or something other. And other fs can use different
> > what Windows use.
>=20
> The big question is *which* version of Windows.  vfat has been in use
> for over two decades, and vfat predates Window starting to use Unicode
> in 2001.  Before that, vfat would have been using whatever code page
> its local Windows installation was set to sue; and I'm not sure if
> there was space in the FAT headers to indicate the codepage in use.

VFAT is extension to FAT which stores file names in UTF-16. In original
FAT without VFAT extension (in all variants, FAT12, FAT16 and FAT32) is
file name stored "according to current 8bit OEM code page". VFAT-aware
FAT implementation would know if particular filename is really VFAT
(UTF-16) or without VFAT (8bit OEM code page). There are flags in FAT
which indicates if entry is VFAT (UTF-16).

And no, there are no bits in FAT header which specify OEM code page.
So if you use "mode con" or "chcp" (or what was those MS-DOS commands
for changing OEM codepage), all non-VFAT filenames would change after
next reading of FAT directory.

But because every OEM code page is full 8bit, you always get valid data.
Just you would see that your file name is different :D

> It would be entertaining for someone with ancient versions of Windows
> 9x to create some floppy images using codepage 437 and 450, and then
> see what a modern Windows system does with those VFAT images --- would

Hehe :-) I did it as part of my investigation, how is stored FAT volume
label and how different tools read it. FAT label is *not* stored as
UTF-16 but only in that OEM code page like old filenames on MS-DOS
https://www.spinics.net/lists/kernel/msg2640891.html

And what recent Windows do? They decode such filenames (and therefore
also volume label) via OEM codepage which belongs to current system
Language settings. You cannot change OEM codepage on recent Windows. You
can only change Regional Language (which then change OEM codepage which
belongs to it).

Mapping table between Windows Regional Language and OEM codepage is in
(still unreleased) fatlabel(8) manpage, section DOS CODEPAGES, here:
https://github.com/dosfstools/dosfstools/blob/master/manpages/fatlabel.8.in

> it break horibbly when it tries to interpret them as UTF-16?  Or would

As Windows knows that filename is stored as 8bit and not UTF-16, nothing
is broken. Just for characters with upper bit set you probably does not
see filenames as you saw in MS-DOS.

But if you remember which OEM code page you used on MS-DOS, you can
change Windows Language to one which uses your OEM code page and then
you can read that old FAT fs without any broken file names.

> it figure it out?  And if so, how?  Inquiring minds want to know....
>=20
> Bonus points if the lack of forwards compatibility causes older
> versions of Windows to Blue Screen.  :-)

I have not got any Blue Screens during reading of these older FAT fs
created and used by MS-DOS.

On Linux it is easier, just specify -o codepage=3D mount option and
vfat.ko translate it correctly.

>=20
>       	     	   	  		   	- Ted
>=20
> P.S.  And of course, then there's the question of how does older
> versions of Windows handle versions of Unicode which postdate the
> release date of that particular version of Windows?  After all,

This is not a problem. Windows allows you to store into filename
arbitrary sequence of uint16[] (except disallowed MS-DOS chars like
:?<>...). And when doing read directory operation you need to expect
that it will returns arbitrary sequence of uint16[].

Windows does not care about valid/invalid/assigned/unassigned code
points. It even do not care about halves of surrogate pairs. So it can
store also one half of (unpaired) surrogate pair (one uint16).

> Unicode adds new code points with potential revisions to the case
> folding table every 6-12 months.  (The most recent version of Unicode
> was released in in April 2019 to accomodate the new Japanese kanji
> character "Rei" for the current era name with the elevation of the new
> current reigning emperor of Japan.)

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--eru6fx4r6gjf4yzc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXiXpuAAKCRCL8Mk9A+RD
Uh9XAJ9dnuAyOYThvpPpYpCMKd/RsqZiKQCfQsQK3Gk01hwU4Oh0V1IeJvChANw=
=5MLo
-----END PGP SIGNATURE-----

--eru6fx4r6gjf4yzc--
