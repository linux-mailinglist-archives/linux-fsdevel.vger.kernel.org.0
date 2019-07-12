Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEA67271
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfGLPde (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 11:33:34 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:10600 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbfGLPdd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:33:33 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id A1467511F2;
        Fri, 12 Jul 2019 17:33:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id QDRC6RVdbb1k; Fri, 12 Jul 2019 17:33:19 +0200 (CEST)
Date:   Sat, 13 Jul 2019 01:32:27 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Drysdale <drysdale@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v9 00/10] namei: openat2(2) path resolution restrictions
Message-ID: <20190712153227.owkjmx47lzrggweo@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190712151118.GP17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="whm56wbfs3ehouyz"
Content-Disposition: inline
In-Reply-To: <20190712151118.GP17978@ZenIV.linux.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--whm56wbfs3ehouyz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-12, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Sun, Jul 07, 2019 at 12:57:27AM +1000, Aleksa Sarai wrote:
> > Patch changelog:
> >   v9:
> >     * Replace resolveat(2) with openat2(2). [Linus]
> >     * Output a warning to dmesg if may_open_magiclink() is violated.
> >     * Add an openat2(O_CREAT) testcase.
>=20
> One general note for the future, BTW: for such series it's generally
> a good idea to put it into a public git tree somewhere and mention that
> in the announcement...

Sure, I'll mention it next time. For the record the tree is
  <https://github.com/cyphar/linux/tree/resolveat/master>

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--whm56wbfs3ehouyz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXSioAwAKCRCdlLljIbnQ
EgzkAQChn28FqDC8mwoRBSpKSsYawQ4zVuMzbt7zKNknJNg7nQD/cmJDlKpmnt40
Jbd8FP1RPFVHA8Y7yVeIE+cOpg3nbw4=
=RciL
-----END PGP SIGNATURE-----

--whm56wbfs3ehouyz--
