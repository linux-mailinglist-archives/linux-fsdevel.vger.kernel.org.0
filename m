Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3421E89F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 08:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGNGvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 02:51:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56354 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgGNGvO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:51:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DC2511C0BE2; Tue, 14 Jul 2020 08:51:10 +0200 (CEST)
Date:   Tue, 14 Jul 2020 08:51:10 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200714065110.GA8047@amd>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705115021.GA1227929@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20200705115021.GA1227929@kroah.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > At first, I thought that the proposed system call is capable of
> > reading *multiple* small files using a single system call - which
> > would help increase HDD/SSD queue utilization and increase IOPS (I/O
> > operations per second) - but that isn't the case and the proposed
> > system call can read just a single file.
>=20
> If you want to do this for multple files, use io_ring, that's what it
> was designed for.  I think Jens was going to be adding support for the
> open/read/close pattern to it as well, after some other more pressing
> features/fixes were finished.

What about... just using io_uring for single file, too? I'm pretty
sure it can be wrapped in a library that is simple to use, avoiding
need for new syscall.
							Pavel
						=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8NVd4ACgkQMOfwapXb+vL5bQCgufDkd33qQk4uXDkH3RR5GPmL
zNYAn03OZe2uS3B1ptb/sq4bdkcbtv1l
=CLsu
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
