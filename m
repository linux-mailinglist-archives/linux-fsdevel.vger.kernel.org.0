Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D103024204A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgHKTaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:30:21 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:55228 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKTaU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:30:20 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B4DE61C0BDD; Tue, 11 Aug 2020 21:30:16 +0200 (CEST)
Date:   Tue, 11 Aug 2020 21:30:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Chuck Lever <chucklever@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Sasha Levin <sashal@kernel.org>, snitzer@redhat.com,
        dm-devel@redhat.com, tyhicks@linux.microsoft.com, agk@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Jonathan Corbet <corbet@lwn.net>, nramas@linux.microsoft.com,
        serge@hallyn.com, pasha.tatashin@soleen.com,
        Jann Horn <jannh@google.com>, linux-block@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, mdsakib@microsoft.com,
        open list <linux-kernel@vger.kernel.org>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        jaskarankhurana@linux.microsoft.com
Subject: Re: [dm-devel] [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM
 (IPE)
Message-ID: <20200811193016.bdwh5kq7ci3yeme4@duo.ucw.cz>
References: <1596639689.3457.17.camel@HansenPartnership.com>
 <alpine.LRH.2.21.2008050934060.28225@namei.org>
 <b08ae82102f35936427bf138085484f75532cff1.camel@linux.ibm.com>
 <329E8DBA-049E-4959-AFD4-9D118DEB176E@gmail.com>
 <da6f54d0438ee3d3903b2c75fcfbeb0afdf92dc2.camel@linux.ibm.com>
 <1597073737.3966.12.camel@HansenPartnership.com>
 <6E907A22-02CC-42DD-B3CD-11D304F3A1A8@gmail.com>
 <1597124623.30793.14.camel@HansenPartnership.com>
 <16C3BF97-A7D3-488A-9D26-7C9B18AD2084@gmail.com>
 <1597159969.4325.21.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x335q3ph5liujtc7"
Content-Disposition: inline
In-Reply-To: <1597159969.4325.21.camel@HansenPartnership.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--x335q3ph5liujtc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > (eg, a specification) will be critical for remote filesystems.
> > > >=20
> > > > If any of this is to be supported by a remote filesystem, then we
> > > > need an unencumbered description of the new metadata format
> > > > rather than code. GPL-encumbered formats cannot be contributed to
> > > > the NFS standard, and are probably difficult for other
> > > > filesystems that are not Linux-native, like SMB, as well.
> > >=20
> > > I don't understand what you mean by GPL encumbered formats.  The
> > > GPL is a code licence not a data or document licence.
> >=20
> > IETF contributions occur under a BSD-style license incompatible
> > with the GPL.
> >=20
> > https://trustee.ietf.org/trust-legal-provisions.html
> >=20
> > Non-Linux implementers (of OEM storage devices) rely on such
> > standards processes to indemnify them against licensing claims.
>=20
> Well, that simply means we won't be contributing the Linux
> implementation, right? However, IETF doesn't require BSD for all
> implementations, so that's OK.
>=20
> > Today, there is no specification for existing IMA metadata formats,
> > there is only code. My lawyer tells me that because the code that
> > implements these formats is under GPL, the formats themselves cannot
> > be contributed to, say, the IETF without express permission from the
> > authors of that code. There are a lot of authors of the Linux IMA
> > code, so this is proving to be an impediment to contribution. That
> > blocks the ability to provide a fully-specified NFS protocol
> > extension to support IMA metadata formats.
>=20
> Well, let me put the counterpoint: I can write a book about how
> linux

You should probably talk to your lawyer.

> device drivers work (which includes describing the data formats), for
> instance, without having to get permission from all the authors ... or
> is your lawyer taking the view we should be suing Jonathan Corbet,
> Alessandro Rubini, and Greg Kroah-Hartman for licence infringement?  In
> fact do they think we now have a huge class action possibility against
> O'Reilly  and a host of other publishers ...

Because yes, you can reverse engineer for compatibility reasons --
doing clean room re-implementation (BIOS binary -> BIOS documentation
-> BIOS sources under different license), but that was only tested in
the US, is expensive, and I understand people might be uncomfortable
doing that.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x335q3ph5liujtc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXzLxyAAKCRAw5/Bqldv6
8vgbAKCHpxkUI3bT9Vn41Tp5GJNZ+nv/SQCfRg4xUwALTQzmhch9Ig1sF0gdvc0=
=c2f+
-----END PGP SIGNATURE-----

--x335q3ph5liujtc7--
