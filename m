Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69D4E12782E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 10:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfLTJci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 04:32:38 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:42762 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727184AbfLTJci (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 04:32:38 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 47fNnc1bxbzKmVq;
        Fri, 20 Dec 2019 10:32:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id MnOUozeEKW5C; Fri, 20 Dec 2019 10:32:29 +0100 (CET)
Date:   Fri, 20 Dec 2019 20:31:53 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "dev@opencontainers.org" <dev@opencontainers.org>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] uapi: split openat2(2) definitions from fcntl.h
Message-ID: <20191220093153.v7jpzvch3lohabll@yavin.dot.cyphar.com>
References: <20191219105533.12508-1-cyphar@cyphar.com>
 <20191219105533.12508-2-cyphar@cyphar.com>
 <87a77oy3oe.fsf@oldenburg2.str.redhat.com>
 <20191219134525.mgzmjbsp4wo5b2bw@yavin.dot.cyphar.com>
 <845fc9e8b55e4868bb4d20655e674b50@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="givk24x5xczrcujw"
Content-Disposition: inline
In-Reply-To: <845fc9e8b55e4868bb4d20655e674b50@AcuMS.aculab.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--givk24x5xczrcujw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-19, David Laight <David.Laight@ACULAB.COM> wrote:
> From: Aleksa Sarai
> > Sent: 19 December 2019 13:45
> > On 2019-12-19, Florian Weimer <fweimer@redhat.com> wrote:
> > > * Aleksa Sarai:
> > >
> > > > diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/open=
at2.h
> > > > new file mode 100644
> > > > index 000000000000..19ef775e8e5e
> > > > --- /dev/null
> > > > +++ b/include/uapi/linux/openat2.h
> > > > @@ -0,0 +1,41 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > +#ifndef _UAPI_LINUX_OPENAT2_H
> > > > +#define _UAPI_LINUX_OPENAT2_H
> > >
> > > I think you should include the relevant header for __align_u64
> > > etc. here.
> >=20
> > Right -- no idea why I forgot to include them.
>=20
> I'm guessing that is just 64bit aligned on 32bit archs like x86?

Yeah,

#define __aligned_u64 __u64 __attribute__((aligned(8)))

> No need to enforce it provided the structure will have no padding on
> archs where the 64bit fields are 64bit aligned. A plain __u64 should
> be fine.

Will this cause problems for x86-on-x86_64 emulation? Requiring an
8-byte alignment for 'struct open_how' really isn't that undue of a
burden IMHO. Then again, clone3 is a bit of an outlier since both
perf_event_open and sched_setattr just use __u64s.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--givk24x5xczrcujw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXfyVBQAKCRCdlLljIbnQ
EgcoAP43nxgO07GF0RSIdFKrxwO6NwWnJQyl99/kNS5RfDZ1gAD/Z+JrHyahv8Zk
oTZiuCZTYW9Ii4yfmIqL3r6lnU6qHgM=
=NPkQ
-----END PGP SIGNATURE-----

--givk24x5xczrcujw--
