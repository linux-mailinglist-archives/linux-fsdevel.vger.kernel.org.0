Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2B4308088
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 22:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbhA1V1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 16:27:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42480 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhA1V1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:27:52 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D556B1C0B77; Thu, 28 Jan 2021 22:26:55 +0100 (CET)
Date:   Thu, 28 Jan 2021 22:26:55 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Amy Parker <enbyamy@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Getting a new fs in the kernel
Message-ID: <20210128212655.GB6722@duo.ucw.cz>
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
 <20210126191716.GN308988@casper.infradead.org>
 <CAE1WUT61OwLSSRCvEe3FLjAASre42iOe=UfPX4uDbDrQ11PAYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <CAE1WUT61OwLSSRCvEe3FLjAASre42iOe=UfPX4uDbDrQ11PAYg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Writing a new filesystem is fun!  Everyone should do it.
> >
> > Releasing a filesystem is gut-churning.  You're committing to a filesys=
tem
> > format that has to be supported for ~ever.
>=20
> I'm bored and need something to dedicate myself to as a long-term commitm=
ent.

You may want to look at "nvfs: a filesystem for persistent memory"...

Best regards,
									Pavel
								=09
--=20
http://www.livejournal.com/~pavelmachek

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYBMsHwAKCRAw5/Bqldv6
8qy+AJ99XZ4AmmapeaWeBzw/eUuZ+qMmAgCeMAYPVvv0KtfX+/GAaY050swoB1M=
=Jyen
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
