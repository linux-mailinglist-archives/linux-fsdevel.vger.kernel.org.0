Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19C561A6E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 07:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfGHFsH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 01:48:07 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:41686 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbfGHFsG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 01:48:06 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id D5ED350844;
        Mon,  8 Jul 2019 07:47:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id 6HYUzmgqQjbZ; Mon,  8 Jul 2019 07:47:45 +0200 (CEST)
Date:   Mon, 8 Jul 2019 15:47:35 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 10/10] selftests: add openat2(2) selftests
Message-ID: <20190708054735.3fepxxtolqaqwmrp@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-11-cyphar@cyphar.com>
 <878st9iax4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fv76k6im74ofqhz7"
Content-Disposition: inline
In-Reply-To: <878st9iax4.fsf@concordia.ellerman.id.au>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--fv76k6im74ofqhz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-08, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Aleksa Sarai <cyphar@cyphar.com> writes:
> > diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/s=
elftests/openat2/Makefile
> > new file mode 100644
> > index 000000000000..8235a49928f6
> > --- /dev/null
> > +++ b/tools/testing/selftests/openat2/Makefile
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +CFLAGS +=3D -Wall -O2 -g
> > +TEST_GEN_PROGS :=3D linkmode_test resolve_test rename_attack_test
> > +
> > +include ../lib.mk
> > +
> > +$(OUTPUT)/linkmode_test: linkmode_test.c helpers.o
> > +$(OUTPUT)/rename_attack_test: rename_attack_test.c helpers.o
> > +$(OUTPUT)/resolve_test: resolve_test.c helpers.o
>=20
> You don't need to tell make that foo depends on foo.c.
>=20
> Also if you make the dependency be on helpers.c then you won't get an
> intermediate helpers.o, and then you don't need to clean it.
>=20
> So the above three lines could just be:
>=20
> $(TEST_GEN_PROGS): helpers.c

I had some trouble getting this to work (hence why I went with the
version in the patch), but it looks like this works. I'll include it in
the next set.

> > +EXTRA_CLEAN =3D helpers.o $(wildcard /tmp/ksft-openat2-*)
>=20
> If you follow my advice above you don't need helpers.o in there.
>=20
> Deleting things from /tmp is also a bit fishy on shared machines, ie. it
> will error if those files happen to be owned by another user.

Good point. I'll drop that hunk in the next set.

Thanks!

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--fv76k6im74ofqhz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXSLY8wAKCRCdlLljIbnQ
Enn2AQC9g0o7YHWuxFtQCLt+aHIE39RQMQDzB5QWrvZA8DdIUQEA69BwekXhnh8X
m2czJJrJISBz5Nz1y3qJzwUUGBvxEgY=
=RdsA
-----END PGP SIGNATURE-----

--fv76k6im74ofqhz7--
