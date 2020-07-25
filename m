Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05D5122D8D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jul 2020 19:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGYRCO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jul 2020 13:02:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54064 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYRCO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:02:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AF60D1C0BDD; Sat, 25 Jul 2020 19:02:11 +0200 (CEST)
Date:   Sat, 25 Jul 2020 19:02:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.36
Message-ID: <20200725170211.GA2807@amd>
References: <20200723100828.262ftx3qhie2sc32@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200723100828.262ftx3qhie2sc32@ws.net.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The commands fdisk(8), sfdisk(8), cfdisk(8), mkswap(8) and wipefs(8) now
> support block devices locking by flock(2) to better behave with udevd or =
other
> tools. Ffor more details see https://systemd.io/BLOCK_DEVICE_LOCKING/.  T=
his

There's typo "ffor", but I guess it is too late to fix that?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8cZZMACgkQMOfwapXb+vL9XwCbBSLZEvCjGt5yMfUaG1pII7Rn
AP0AnRQMyE9vGu1xvXbuGuUg3CODmyPW
=qUWC
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
