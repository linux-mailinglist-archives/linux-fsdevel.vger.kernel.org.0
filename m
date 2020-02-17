Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 185D4161379
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgBQNbN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:31:13 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51442 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgBQNbN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:31:13 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 250051C0460; Mon, 17 Feb 2020 14:31:11 +0100 (CET)
Date:   Mon, 17 Feb 2020 14:31:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200217133110.GA32298@duo.ucw.cz>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Testing this will be a challenge, but the issue was real - a 7GB
> > highmem machine isn't crazy and I expect the inode has become larger
> > since those days.
>=20
> Hmm. I would say that in the intening years a 7GB highmem machine has
> indeed become crazy.
>=20
> It used to be something we kind of supported.
>=20
> But we really should consider HIGHMEM to be something that is on the
> deprecation list. In this day and age, there is no excuse for running
> a 32-bit kernel with lots of physical memory.
>=20
> And if you really want to do that, and have some legacy hardware with
> a legacy use case, maybe you should be using a legacy kernel.
>=20
> I'd personally be perfectly happy to start removing HIGHMEM support again.

7GB HIGHMEM machine may be unusual, but AFAICT HIGHMEM is need for
configurations like 1GB x86 machine, and definitely for 3GB x86
machine.

32-bit machines with 1.5 to 4GB of RAM are still pretty common (I have
two of those), and dropping HIGHMEM support will limit them to 0.8GB
RAM and probably make them unusable even for simple web browsing. I
have two such machines here, please don't break them :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXkqVngAKCRAw5/Bqldv6
8s1bAJ4l1OVhoYxPYT4cwIGRz9Wh3dzOFgCfeQFT5Ca/em5+hdG43KO+4VJGEeM=
=BKsR
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
