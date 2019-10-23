Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB525E2192
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfJWRQR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 13:16:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52365 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfJWRQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:16:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so22150347wmh.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=07SMstHl+14rmM/XZWBVvBuxzelk0N79orxKwBrOQSo=;
        b=qROdpzFkEI/Oe2zE5Da14ta0FTxtFoABo7oIL9eiv6xzu4a58/dv2Oiln5MKAsulYU
         en2aS3/+IyRm1Xo/Ytv4Hw80uwBYYeoCsauPDjWXYrBNpN1XCbJwUpcD/lTvIpTgAk3/
         7Z0JeL6Md9NrV4Ft521Q6VWGZ411e4bRc4s9lIUZ5SCBQPRcUmmppm4SdgWUMwYGnF7F
         zQWYmXWSXpTzqJjbcIxCIkofWji6TulhtF/leL3sQNkLz4yJrP6exN/iEMFyThmRdVeG
         98aeO1YdvsbD58hqUlL/T5yV/nuFd7K3z9g5UAsYanqKM8wwaL5cIU21wyuj4JvS88ce
         p8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=07SMstHl+14rmM/XZWBVvBuxzelk0N79orxKwBrOQSo=;
        b=aeHbtfVD9IpLSQ9HazjIFLiQtCRR6ukRmvM+fp8UhkOUyPHv0KQb3KWPaj+GoFGyuG
         RglvLi8ixKp2/8zOBvki+oAW6V+ffnpKEspIY4/TTmjb5RmktArRIv2Qk9vKel4Xxw+f
         pibumYZgTsWcJ4D+/V1qUTQEP14duh7tNfUB39PmamKFhPPdoowH9Vy9b0JlFJM4YLT0
         O+jQEyDPHeFTALpTM9ecYxrGjOJUSHLHfec+EOb0lrQ6aZen/YrDX8fLHPeU8DgMmHzL
         dDq/G4H0dv2oOEOpZuMvBVnaHUt+R6XsFfUQ8uY8pP5bxo5t9l4s3Y2gSAfEtwyVuMLb
         p82Q==
X-Gm-Message-State: APjAAAWRDbeZ1dVK0kQ3NwxTxi77EsWRPs8u7FaGwwn4VjZFEV8OohoL
        t2zH8ovOXT+tx/RY5u1+Lcc=
X-Google-Smtp-Source: APXvYqxg69J/6kmsUd028CYwVVxlrCo98x+iJZAcM7bzpINwPcIA/mfAIOzfd59sihc4Qvqif3O/ig==
X-Received: by 2002:a1c:2cc4:: with SMTP id s187mr925795wms.166.1571850973110;
        Wed, 23 Oct 2019 10:16:13 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id s10sm27067728wrr.5.2019.10.23.10.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 10:16:12 -0700 (PDT)
Date:   Wed, 23 Oct 2019 19:16:11 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: Is rename(2) atomic on FAT?
Message-ID: <20191023171611.qfcwfce2roe3k3qw@pali>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali>
 <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali>
 <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="omvdqztbq2yrrdxr"
Content-Disposition: inline
In-Reply-To: <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--omvdqztbq2yrrdxr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 23 October 2019 16:21:19 Chris Murphy wrote:
> On Wed, Oct 23, 2019 at 1:50 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wr=
ote:
> >
> > Hi!
> >
> > On Wednesday 23 October 2019 02:10:50 Chris Murphy wrote:
> > > a. write bootloader file to a temp location
> > > b. fsync
> > > c. mv temp final
> > > d. fsync
> > >
> > > if the crash happens anywhere from before a. to just after c. the old
> > > configuration file is still present and old kernel+initramfs are used.
> > > No problem. If the crash happens well after c. probably the new one is
> > > in place, for sure after d. it's in place, and the new kernel+
> > > initramfs are used.
> >
> > I do not think that kernel guarantee for any filesystem that rename
> > operation would be atomic on underlying disk storage.
> >
> > But somebody else should confirm it.
>=20
> I don't know either or how to confirm it.

Somebody who is watching linuxfs-devel and has deep knowledge in this
area... could provide more information.

> But, being ignorant about a
> great many things, my instinct is literal fsync (flush buffer to disk)
> should go away at the application level, and fsync should only be used
> to indicate write order and what is part of a "commit" that is to be
> atomic (completely succeeds or fails). And of course that can only be
> guaranteed as far as the kernel is concerned, it doesn't guarantee
> anything about how the hardware block device actually behaves (warts
> bugs and all).
>=20
> Anyway it made me think of this:
> https://lwn.net/Articles/789600/
>=20
>=20
> > So if kernel crashes in the middle of c or between c and d you need to
> > repair filesystem externally prior trying to boot from such disk.
>=20
> Nice in theory, but in practice the user simply reboots, and screams
> WTF outloud if the system face plants. And people wonder why things
> are still broken 20 years later with all the same kinds of problems
> and prescriptions to boot off some rescue media instead of it being
> fail safe by design. It's definitely not fail safe to have a kernel
> update that could possibly result in an unbootable system. I can't
> think of any ordinary server, cloud, desktop, mobile user who wants to
> have to boot from rescue media to do a simple repair. Of course they
> all just want to reboot and have the right thing always happen no
> matter what, otherwise they get so nervous about doing updates that
> they postpone them longer than they should.

Still, in any time when you improperly unmount filesystem you should
check for error, if you do not want to loose your data.

And critical area should have some "recovery" mechanism to repair broken
bootloader / kernel image.

Anyway, chance that kernel crashes at step when replacing old kernel
disk image by new one is low. So it should not be such big issue to need
to do external recovery.

> > > I'm not sure how to test the following: write kernel and initramfs to
> > > final locations. And bootloader configuration is written to a temp
> > > path. Then at the decision moment, rename it so that it goes from temp
> > > path to final path doing at most 1 sector change. 1 512 byte sector
> > > is a reasonable number to assume can be completely atomic for a
> > > system. I have no idea if FAT can do such a 'mv' event with only one
> > > sector change
> >
> > Theoretically it could be possible to implement it for FAT (with more
> > restrictions), but I doubt that general purpose implementation of any
> > filesystem in kernel can do such thing. So no practically.
>=20
> Now I'm wondering what the UEFI spec says about this, and whether this
> problem was anticipated, and how surprised I should be if it wasn't
> anticipated.

I know that UEFI spec has reference for FAT filesystems to MS
specification (fagen103.doc). I do not know if it says anything about
filesystem details, but I guess it specify requirements, that
implementations must be compatible with FAT12, FAT16 and FAT32 according
to specification.

> > > GRUB has an option to blindly overwrite the 1024 byte contents of
> > > grubenv (no file system modification), that's pretty close to atomic.
> > > Most devices have physical sector bigger than 512 bytes. This write is
> > > done in the pre-boot environment for saving state like boot counts.
> >
> > This depends on grub's FAT implementation. As said I would be very
> > careful about such "atomic" writes. There are also some caches, include
> > hardware on-disk, etc...
>=20
> GRUB doesn't use any file system driver for writes, ever. It uses a
> file system driver only to find out what two LBAs the "grubenv"
> occupies, and then blindly overwrites those two sectors to save state.
> There is no file system metadata update at all.

Yes, you are right. Looking at the code and grub's filesystem drivers
are read-only. No write support.

> >
> > > And add to the mix that I guess some UEFI firmware allow writing to
> > > FAT in the pre-boot environment?
> >
> > Yes, UEFI API allows you to write to disk devices. And UEFI fileystem
> > implementation can also supports writing to FAT fs.
> >
> > > I don't know if that's universally true. How do firmware handle a dir=
ty bit being set?
> >
> > Bad implementation would ignore it. This is something which you should
> > expect.
>=20
> Maybe a project for someone is to bake xfstests into an EFI program so
> we can start testing these firmware FAT drivers and see what we learn
> about how bad they are?

That is possible.

Also UEFI allows you to write our own UEFI filesystem drivers which
other UEFI programs and bootloaders can use.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--omvdqztbq2yrrdxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXbCK2QAKCRCL8Mk9A+RD
UgL4AJ9yMg9Zpv6PQGxm4Ia4FAN5McTg6gCeJPSbGHFnQybehTU9U4V2ACzDCcM=
=I9xU
-----END PGP SIGNATURE-----

--omvdqztbq2yrrdxr--
