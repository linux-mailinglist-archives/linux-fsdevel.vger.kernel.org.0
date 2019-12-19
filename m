Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2361263C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 14:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfLSNlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 08:41:42 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:18948 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfLSNlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:41:42 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 47dtMS0SdVzKmgD;
        Thu, 19 Dec 2019 14:41:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id GKp5hAsVzbm6; Thu, 19 Dec 2019 14:41:33 +0100 (CET)
Date:   Fri, 20 Dec 2019 00:41:17 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        David Laight <david.laight@aculab.com>, dev@opencontainers.org,
        containers@lists.linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] openat2: minor uapi cleanups
Message-ID: <20191219134117.cd2vlgudkzke2koa@yavin.dot.cyphar.com>
References: <20191219105533.12508-1-cyphar@cyphar.com>
 <20191219111949.auriw6biphxxvdng@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mutewvojgxffecmv"
Content-Disposition: inline
In-Reply-To: <20191219111949.auriw6biphxxvdng@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mutewvojgxffecmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-19, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Thu, Dec 19, 2019 at 09:55:28PM +1100, Aleksa Sarai wrote:
> > While openat2(2) is still not yet in Linus's tree, we can take this
> > opportunity to iron out some small warts that weren't noticed earlier:
> >=20
> >   * A fix was suggested by Florian Weimer, to separate the openat2
> >     definitions so glibc can use the header directly. I've put the
> >     maintainership under VFS but let me know if you'd prefer it belong
> >     ot the fcntl folks.
> >=20
> >   * Having heterogenous field sizes in an extensible struct results in
> >     "padding hole" problems when adding new fields (in addition the
> >     correct error to use for non-zero padding isn't entirely clear ).
> >     The simplest solution is to just copy clone(3)'s model -- always use
> >     u64s. It will waste a little more space in the struct, but it
> >     removes a possible future headache.
>=20
> Am I imagining things or did I get the same patch series twice?

Not unless it's a coincidence -- I accidentally ran

  % git send-email *.patch [some flags] *.patch

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--mutewvojgxffecmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXft9+QAKCRCdlLljIbnQ
EtyNAQCti3thklGHsV++rCfcqbFMf3f1fnX3p/5obp2AXE01PwD9HwJsBnRPdbWJ
duHYCyjYbDaPG5aWWq59zoWJ9d+MxQ8=
=NFwv
-----END PGP SIGNATURE-----

--mutewvojgxffecmv--
