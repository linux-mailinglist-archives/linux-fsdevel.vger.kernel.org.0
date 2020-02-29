Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38251747CB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Feb 2020 16:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgB2Py0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Feb 2020 10:54:26 -0500
Received: from mout-p-103.mailbox.org ([80.241.56.161]:9834 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgB2PyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Feb 2020 10:54:25 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 48V9vL6ZhszKmVM;
        Sat, 29 Feb 2020 16:54:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id pgmRCAv08B0a; Sat, 29 Feb 2020 16:54:19 +0100 (CET)
Date:   Sun, 1 Mar 2020 02:54:11 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        viro@zeniv.linux.org.uk, metze@samba.org,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, fweimer@redhat.com
Subject: Re: Have RESOLVE_* flags superseded AT_* flags for new syscalls?
Message-ID: <20200229155411.3xn7szvqso4uxwuy@yavin>
References: <96563.1582901612@warthog.procyon.org.uk>
 <20200228152427.rv3crd7akwdhta2r@wittgenstein>
 <20200229152656.gwu7wbqd32liwjye@yavin>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="puaedjuyrav2qu65"
Content-Disposition: inline
In-Reply-To: <20200229152656.gwu7wbqd32liwjye@yavin>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--puaedjuyrav2qu65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-01, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2020-02-28, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > So we either end up adding new AT_* flags mirroring the new RESOLVE_*
> > flags or we end up adding new RESOLVE_* flags mirroring parts of AT_*
> > flags. And if that's a possibility I vote for RESOLVE_* flags going
> > forward. The have better naming too imho.
>=20
> I can see the argument for merging AT_ flags into RESOLVE_ flags (fewer
> flag arguments for syscalls is usually a good thing) ... but I don't
> really like it. There are a couple of problems right off the bat:
>=20
>  * The prefix RESOLVE_ implies that the flag is specifically about path
>    resolution. While you could argue that AT_EMPTY_PATH is at least
>    *related* to path resolution, flags like AT_REMOVEDIR and
>    AT_RECURSIVE aren't.
>=20
>  * That point touches on something I see as a more fundamental problem
>    in the AT_ flags -- they were intended to be generic flags for all of
>    the ...at(2) syscalls. But then AT_ grew things like AT_STATX_ and
>    AT_REMOVEDIR (both of which are necessary features to have for their
>    respective syscalls, but now those flag bits are dead for other
>    syscalls -- not to mention the whole AT_SYMLINK_{NO,}FOLLOW thing).
>=20
>  * While the above might be seen as minor quibbles, the really big
>    issue is that even the flags which are "similar" (AT_SYMLINK_NOFOLLOW
>    and RESOLVE_NO_SYMLINKS) have different semantics (by design -- in my
>    view, AT_SYMLINK_{NO,}FOLLOW / O_NOFOLLOW / lstat(2) has always had
>    the wrong semantics if the intention was to be a way to safely avoid
>    resolving symlinks).
>=20
> But maybe I'm just overthinking what a merge of AT_ and RESOLVE_ would
> look like -- would it on.

Eugh, dropped the rest of that sentence:

=2E.. would it only be the few AT_ flags which are strictly related to
path resolution (such as AT_EMPTY_PATH)? If so wouldn't that just mean
we end up with two flag arguments for new syscalls?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--puaedjuyrav2qu65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXlqJIAAKCRCdlLljIbnQ
EsRRAPwMoYtBmLhTjNkZ7AC3d/2Ja7NkrsotEk6myIJwokoCygEAnedimnFrzQ37
VxkzpMA8mSpBBJP7I7YmJa2XRkDeTAk=
=evjZ
-----END PGP SIGNATURE-----

--puaedjuyrav2qu65--
