Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C48175DD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 16:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgCBPFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 10:05:16 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:30410 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgCBPFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:05:16 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 48WNjj5B4XzKmgy;
        Mon,  2 Mar 2020 16:05:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id JQEoqVqSuZg2; Mon,  2 Mar 2020 16:05:10 +0100 (CET)
Date:   Tue, 3 Mar 2020 02:04:59 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-api@vger.kernel.org, viro@zeniv.linux.org.uk,
        metze@samba.org, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200302150459.zu3eo5so66vrji4w@yavin>
References: <87h7z7ngd4.fsf@oldenburg2.str.redhat.com>
 <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <859019.1583159423@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="srr2nycvnmhscg5l"
Content-Disposition: inline
In-Reply-To: <859019.1583159423@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--srr2nycvnmhscg5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-02, David Howells <dhowells@redhat.com> wrote:
> Florian Weimer <fweimer@redhat.com> wrote:
>=20
> > Regarding open flags, I think the key point for future APIs is to avoid
> > using the set of flags for both control of the operation itself
> > (O_NOFOLLOW/AT_SYMLINK_NOFOLLOW, O_NOCTTY) and properaties of the
> > resulting descriptor (O_RDWR, O_SYNC).  I expect that doing that would
> > help code that has to re-create an equivalent descriptor.  The operation
> > flags are largely irrelevant to that if you can get the descriptor by
> > other means.
>=20
> It would also be nice to sort out the problem with O_CLOEXEC.  That can h=
ave a
> different value, depending on the arch - so it excludes at least three bi=
ts
> from the O_* flag set.

Not to mention there are (at least?) three or four different values for
_CLOEXEC for different syscalls...

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--srr2nycvnmhscg5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXl0gmQAKCRCdlLljIbnQ
Eo7SAP9PealEn3lKj+b8hZYp6P0KfxGubwWRVoi9l1VdUvarNgD/QAMhskbDrH+M
rphWjsN4FWzH+8qNavLDTyruNZ8+nQk=
=0CCy
-----END PGP SIGNATURE-----

--srr2nycvnmhscg5l--
