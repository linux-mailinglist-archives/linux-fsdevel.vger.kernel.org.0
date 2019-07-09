Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A7E63D0E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 23:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfGIVFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 17:05:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44016 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:05:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so228578wru.10;
        Tue, 09 Jul 2019 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xKGjUaZXiEOk+aREqEXrfuKl/+MRJ/yLv74T5LUSGwk=;
        b=WKx4e+dgwDiXTmKNYZ/XaND9PfzpjZMe53+JgNQYXDgcLFEciGszzDEXlKM/z3rSAq
         EwUyQ5hdaa71QVWZBtvXxFOt8fu81WVvfleV89I4ECplFT4LfqPxUJ3GaN20LQifFunT
         dGZldh4k6A7mG2wqFHrV2ABjZiBJaS8R3t9qbhvCE/E2EXBS/AZ4kLY8oVX1ZQfs2fXS
         mJ7sChWGEcGYx5b1wcQNqVnWjxH7NPxtbdULbbw2DrXuQfg90t306zPzNygznVZQmpLY
         aQHNzJ98zY2t725mrF9idbCVVOIq3l37cxsjw5H1WUC1mUmdxQMBScHQwEyAsJmq4AGM
         yq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKGjUaZXiEOk+aREqEXrfuKl/+MRJ/yLv74T5LUSGwk=;
        b=njFjpnPksdQxopir60M5CAElYXycBjOs9BDIEV0mgCCcTRPgu0rqR1A/y1CGH5TFls
         TqbgOK15Z7HFLyLEAOa5oSA3wjFh56VOCK3I83brGY6Hvxmb8eiTa/rDlSj+G1QeE01L
         PHd018kJmjRLjcGfctBdSnkt5ej21k6Q2moF+6nA3WiL12Muo+imo2dFRmTWTDhJ87Vn
         8Ae0CbzZI3FT6vziIC/UxgNmh+xSv9gIriTsRWmguMInDx60BRQI4B6zOUHvRWDGZOuL
         rYsmW//jdfeFPKaUzjKnN3BPF0h5fBpBR3Okynb6PGI5FTEP5syAIuFKIbhP8ire9LVu
         Ql5A==
X-Gm-Message-State: APjAAAVYg4epVPN0/PeTxvc1zELP4Nus1xtQW8c5SmDta9WIvejEGMDk
        fQgoaJLUpA7im8Cpb/snt0I=
X-Google-Smtp-Source: APXvYqxgOpyg7cosaUgdl5NdE14ai9cmwCQHJ/7cwJUNGwjBSr42j2nBvWR6hlSGx/ljQVgrCBJJwQ==
X-Received: by 2002:adf:efd2:: with SMTP id i18mr24344760wrp.145.1562706299258;
        Tue, 09 Jul 2019 14:04:59 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id v204sm122660wma.20.2019.07.09.14.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jul 2019 14:04:58 -0700 (PDT)
Date:   Tue, 9 Jul 2019 23:04:57 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.cz>,
        =?utf-8?Q?Vojt=C4=9Bch?= Vladyka <vojtech.vladyka@foxyco.cz>,
        linux-fsdevel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] udf: 2.01 interoperability issues with Windows 10
Message-ID: <20190709210457.kzjnigu6fwgxxq27@pali>
References: <96e1ea00-ac12-015d-5c54-80a83f08b898@digidescorp.com>
 <20190709185638.pcgdbdqoqgur6id3@pali>
 <958ea915-3568-8f5a-581c-e5f0a673d30f@digidescorp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cqoxn3n4yqhx2s6s"
Content-Disposition: inline
In-Reply-To: <958ea915-3568-8f5a-581c-e5f0a673d30f@digidescorp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cqoxn3n4yqhx2s6s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 09 July 2019 15:14:38 Steve Magnani wrote:
>=20
> On 7/9/19 1:56 PM, Pali Roh=C3=A1r wrote:
> > Steve, can you describe what you mean by Advanced Format 4K sector size?
> >=20
> > It is hard disk with 512 bytes logical sector size and 4096 bytes
> > physical sector size? Or do you mean hard disk which has both logical
> > and physical sector size equal to 4096 bytes?
>=20
> Sorry, forgot that the term Advanced Format introduces ambiguity.
> As far as the OSes are concerned the drive is 4Kn.

Ok, so from your blkid output it can be seen that hard disk has both
logical and physical sector size equal to 4096 bytes.

Problem with those keywords like Advanced or Native is that some vendors
use them also for 512/4096 disks, so better to to say logical sector
size explicitly and not using those marketing keywords.

> On Tuesday 09 July 2019 13:27:58 Steve Magnani wrote:
>=20
> > > Hi,
> > >=20
> > > Recently I have been exploring Advanced Format (4K sector size)
> > > and high capacity aspects of UDF 2.01 support in Linux and
> > > Windows 10. I thought it might be helpful to summarize my findings.
> > >=20
> > > The good news is that I did not see any bugs in the Linux
> > > ecosystem (kernel driver + mkudffs).
> > >=20
> > > The not-so-good news is that Windows has some issues that affect
> > > interoperability. One of my goals in posting this is to open a
> > > discussion on whether changes should be made in the Linux UDF
> > > ecosystem to accommodate these quirks.
> > >=20
> > > My test setup includes the following software components:
> > >=20
> > > * mkudffs 1.3 and 2.0
> > Can you do tests also with last version of mkudffs 2.1?
>=20
> A very quick smoke test of a 16-ish TiB 4Kn partition seemed OK.
>=20
> > > * kernel 4.15.0-43 and 4.15.0-52
> > > * Windows 10 1803 17134.829
> > > * chkdsk 10.0.17134.1
> > > * udfs.sys 10.0.17134.648
> > >=20
> > >=20
> > > ISSUE 1: Inability of the Linux UDF driver to mount 4K-sector
> > >           media formatted by Windows.
> > Can you check if udfinfo (from udftools) can recognize such disk?
>=20
> It cannot:
>=20
>   $ ./udfinfo /dev/sdb1
>   udfinfo: Error: UDF Volume Recognition Sequence found but not Anchor Vo=
lume Descriptor Pointer, maybe wrong --blocksize?
>   udfinfo: Error: Cannot process device '/dev/sdb1' as UDF disk
>=20
>   $ ./udfinfo --blocksize=3D4096 /dev/sdb1
>   udfinfo: Error: UDF Volume Recognition Sequence not found
>   udfinfo: Error: Cannot process device '/dev/sdb1' as UDF disk
>=20
>   $ ./udfinfo
>   udfinfo from udftools 2.1

Ok. This means that also udflabel is unable to show or change UDF label
on such disks.

So not only Linux kernel driver needs to be workarounded, but also
udftools.

> > And can blkid (from util-linux) recognize such disk as UDF with reading
> > all properties?
>=20
> Seemingly:
>=20
>   $ blkid --info /dev/sdb1
>   /dev/sdb1: MINIMUM_IO_SIZE=3D"4096"
>              PHYSICAL_SECTOR_SIZE=3D"4096"
>              LOGICAL_SECTOR_SIZE=3D"4096"
>=20
>   $ blkid --probe /dev/sdb1
>   /dev/sdb1: VOLUME_ID=3D"UDF Volume"
>              UUID=3D"0e131b3b20554446"
>              VOLUME_SET_ID=3D"0E131B3B UDF Volume Set"
>              LABEL=3D"WIN10_FORMATTED"
>              LOGICAL_VOLUME_ID=3D"WIN10_FORMATTED"
>              VERSION=3D"2.01"
>              TYPE=3D"udf"
>              USAGE=3D"filesystem"
>=20
>   $ blkid --version
>   blkid from util-linux 2.31.1  (libblkid 2.31.1, 19-Dec-2017)

So it is working. Working blkid is required as its library libblkid is
used for parsing/mounting /etc/fstab file and also that GUI partition
tools use it for identifying block devices.

> > Can grub2 recognize such disks?
>=20
> I'm not sure what you're asking here. The physical interface to this driv=
e is USB,

It is USB mass storage device? If yes, then grub2 should be able to
normally use. Read its content, etc... You can use "ls" grub command to
list content of disk with supported filesystem.

> and it's not designed for general-purpose storage (or booting). That said=
, if you
> have some grub2 commands you want me to run against this drive/partition =
let me know.

There is also some way for using grub's fs implementation to read disk
images. It is primary used by grub's automated tests. I do not know
right now how to use, I need to look grub documentation. But I have
already used it during implementation of UDF UUID in grub.

> > Also can you check if libparted from git master branch can recognize
> > such disk? In following commit I added support for recognizing UDF
> > filesystem in libparted, it is only in git master branch, not released:
> >=20
> > http://git.savannah.gnu.org/cgit/parted.git/commit/?id=3D8740cfcff3ea83=
9dd6dc8650dec0a466e9870625
>=20
> Build failed:
>   In file included from pt-tools.c:114:0:
>   pt-tools.c: In function 'pt_limit_lookup':
>   pt-limit.gperf:78:1: error: function might be candidate for attribute '=
pure' [-Werror=3Dsuggest-attribute=3Dpure]
>=20
> If you send me some other SHA to try I can attempt a rebuild.

Try to use top of master branch. That mentioned commit is already in git
master.

And if it still produce that error, compile without -Werror flag (or add
-Wno-error).

> > ISSUE 2: Inability of Windows chkdsk to analyze 4K-sector media
> >           formatted by mkudffs.
> > This is really bad :-(
> >=20
> > > It would be possible to work around this by tweaking mkudffs to
> > > insert dummy BOOT2 components in between the BEA/NSR/TEA:
> > >=20
> > >    0000: 00 42 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .BEA01.....=
=2E....
> > >    0800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2.....=
=2E....
> > >    1000: 00 4e 53 52 30 33 01 00 00 00 00 00 00 00 00 00  .NSR03.....=
=2E....
> > >    1800: 00 42 4f 4f 54 32 01 00 00 00 00 00 00 00 00 00  .BOOT2.....=
=2E....
> > >    2000: 00 54 45 41 30 31 01 00 00 00 00 00 00 00 00 00  .TEA01.....=
=2E....
> > >=20
> > > That would introduce a slight ECMA-167 nonconformity, but Linux
> > > does not object and Windows actually performs better. I would
> > > have to tweak udffsck though since I believe this could confuse
> > > its automatic detection of medium block size.
> > I would like to avoid this hack. If chkdsk is unable to detect such
> > filesystem, it is really a good idea to let it do try doing filesystem
> > checks and recovery? You are saying that udfs.sys can recognize such
> > disk and mount it. I think this should be enough.
>=20
> Fair enough, but it's also reasonable to assume the bugginess is
> limited to the VRS corner case. AFAIK that's the only place in ECMA-167
> where there is a difference in layout specific to 4K sectors.
> With the BOOT2 band-aid chkdsk is able to analyze filesystems on 4Kn medi=
a.

Main problem with this hack is that it breaks detection of valid UDF
filesystems which use VRS for block size detection. I do not know which
implementation may use VRS for block size detection, but I do not see
anything wrong in this approach.

> I use chkdsk frequently to double-check UDF generation firmware

Vojt=C4=9Bch wrote in his thesis that MS's chkdsk sometimes put UDF
filesystem into more broken state as before.

> I am writing, and also udffsck work-in-progress.

Have you used some Vojt=C4=9Bch's parts? Or are you writing it from scratch?

> ------------------------------------------------------------------------
>  Steven J. Magnani               "I claim this network for MARS!
>  www.digidescorp.com              Earthling, return my space modulator!"
>=20
>  #include <standard.disclaimer>
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--cqoxn3n4yqhx2s6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXSUBdwAKCRCL8Mk9A+RD
UnYqAJ4t3PYIlCKHZAZdf9GleIUflGZPhACdEr+MF3ajpf8do68nf+xCxW8xWLc=
=D4pC
-----END PGP SIGNATURE-----

--cqoxn3n4yqhx2s6s--
