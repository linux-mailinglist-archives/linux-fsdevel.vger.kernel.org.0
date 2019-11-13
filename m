Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A0F9F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 01:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKMArM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 19:47:12 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:17516 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfKMArM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:47:12 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 47CQtM1PgvzKm9q;
        Wed, 13 Nov 2019 01:47:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id rfbcH-n--HBG; Wed, 13 Nov 2019 01:47:00 +0100 (CET)
Date:   Wed, 13 Nov 2019 11:46:34 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v15 0/9] open: introduce openat2(2) syscall
Message-ID: <20191113004634.tz7geloshltkafwj@yavin.dot.cyphar.com>
References: <20191105090553.6350-1-cyphar@cyphar.com>
 <20191111132404.y523iqicbn6fivx5@yavin.dot.cyphar.com>
 <201911121457.7D02692@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ndczamgwxls6q65"
Content-Disposition: inline
In-Reply-To: <201911121457.7D02692@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--7ndczamgwxls6q65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-12, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Nov 12, 2019 at 12:24:04AM +1100, Aleksa Sarai wrote:
> > On 2019-11-05, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > This patchset is being developed here:
> > >   <https://github.com/cyphar/linux/tree/openat2/master>
> > >=20
> > > Patch changelog:
> > >  v15:
> > >   * Fix code style for LOOKUP_IN_ROOT handling in path_init(). [Linus=
 Torvalds]
> > >   * Split out patches for each individual LOOKUP flag.
> > >   * Reword commit messages to give more background information about =
the
> > >     series, as well as mention the semantics of each flag in more det=
ail.
> > > [...]
> >=20
> > Ping -- this patch hasn't been touched for a week. Thanks.
>=20
> If I've been following correctly, everyone is happy with this series.
> (i.e. Linus's comment appear to have been addressed.)
>=20
> Perhaps the next question is should this go via a pull request by you to
> Linus directly during the v5.5 merge window, via akpm, via akpm, via
> Christian, or some other path? Besides Linus, it's not been clear who
> should "claim" this series. :)

Given the namei changes, I wanted to avoid stepping on Al's toes. Though
he did review the series a few versions ago, the discussion didn't focus
on the openat2(2) semantics (which have also changed since then). I'm
not sure whether to interpret the silence to mean he's satisfied with
things as they are, or if he hasn't had more time to look at the series.

As for which tree it should be routed to, I don't mind -- Christian is
the most straight-forward choice (but if Al wants to route it, that's
fine with me too).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--7ndczamgwxls6q65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXctSZgAKCRCdlLljIbnQ
Ej+PAP0UBMczq8p/OLMeyIryF0EfQ+noWktKHkfgvrRf7bKN7AEAiW1OItA5gtV4
HiJnADyDHQw1h7livSSrD2X7HKS2BAA=
=yOzJ
-----END PGP SIGNATURE-----

--7ndczamgwxls6q65--
