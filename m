Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380E223579C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Aug 2020 16:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHBObr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Aug 2020 10:31:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:60476 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHBObr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:31:47 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 127351C0BD4; Sun,  2 Aug 2020 16:31:44 +0200 (CEST)
Date:   Sun, 2 Aug 2020 16:31:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Deven Bowers <deven.desai@linux.microsoft.com>, agk@redhat.com,
        axboe@kernel.dk, snitzer@redhat.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, eparis@redhat.com, jannh@google.com,
        dm-devel@redhat.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-audit@redhat.com, tyhicks@linux.microsoft.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        jaskarankhurana@linux.microsoft.com, mdsakib@microsoft.com,
        nramas@linux.microsoft.com, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v5 00/11] Integrity Policy Enforcement LSM (IPE)
Message-ID: <20200802143143.GB20261@amd>
References: <20200728213614.586312-1-deven.desai@linux.microsoft.com>
 <20200802115545.GA1162@bug>
 <20200802140300.GA2975990@sasha-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <20200802140300.GA2975990@sasha-vm>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2020-08-02 10:03:00, Sasha Levin wrote:
> On Sun, Aug 02, 2020 at 01:55:45PM +0200, Pavel Machek wrote:
> >Hi!
> >
> >>IPE is a Linux Security Module which allows for a configurable
> >>policy to enforce integrity requirements on the whole system. It
> >>attempts to solve the issue of Code Integrity: that any code being
> >>executed (or files being read), are identical to the version that
> >>was built by a trusted source.
> >
> >How is that different from security/integrity/ima?
>=20
> Maybe if you would have read the cover letter all the way down to the
> 5th paragraph which explains how IPE is different from IMA we could
> avoided this mail exchange...

"
IPE differs from other LSMs which provide integrity checking (for
instance,
IMA), as it has no dependency on the filesystem metadata itself. The
attributes that IPE checks are deterministic properties that exist
solely
in the kernel. Additionally, IPE provides no additional mechanisms of
verifying these files (e.g. IMA Signatures) - all of the attributes of
verifying files are existing features within the kernel, such as
dm-verity
or fsverity.
"

That is not really helpful.
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8mzk8ACgkQMOfwapXb+vLIbgCaA3csU541jz7eEPNddFWHs7h3
kiUAn0UO6AiyKqQwqSNgE+2r+SZ3D4bn
=xwpV
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
