Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8953E29F08C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 16:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgJ2PwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 11:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728491AbgJ2PwX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:52:23 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462A0C0613CF;
        Thu, 29 Oct 2020 08:52:23 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4CMVLs2MljzQl31;
        Thu, 29 Oct 2020 16:52:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id pzROom4hCQJX; Thu, 29 Oct 2020 16:52:14 +0100 (CET)
Date:   Fri, 30 Oct 2020 02:51:48 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Mrunal Patel <mpatel@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Lutomirski <luto@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Theodore Tso <tytso@mit.edu>, Alban Crequy <alban@kinvolk.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jann Horn <jannh@google.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Lennart Poettering <lennart@poettering.net>,
        smbarber@chromium.org, Phil Estes <estesp@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Todd Kjos <tkjos@google.com>, Jonathan Corbet <corbet@lwn.net>,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-audit@redhat.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org
Subject: Re: [PATCH 00/34] fs: idmapped mounts
Message-ID: <20201029155148.5odu4j2kt62ahcxq@yavin.dot.cyphar.com>
References: <20201029003252.2128653-1-christian.brauner@ubuntu.com>
 <87pn51ghju.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kgfxsa7rlwd3wkqj"
Content-Disposition: inline
In-Reply-To: <87pn51ghju.fsf@x220.int.ebiederm.org>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.91 / 15.00 / 15.00
X-Rspamd-Queue-Id: 6627F1700
X-Rspamd-UID: 698b92
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--kgfxsa7rlwd3wkqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-10-29, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Christian Brauner <christian.brauner@ubuntu.com> writes:
>=20
> > Hey everyone,
> >
> > I vanished for a little while to focus on this work here so sorry for
> > not being available by mail for a while.
> >
> > Since quite a long time we have issues with sharing mounts between
> > multiple unprivileged containers with different id mappings, sharing a
> > rootfs between multiple containers with different id mappings, and also
> > sharing regular directories and filesystems between users with different
> > uids and gids. The latter use-cases have become even more important with
> > the availability and adoption of systemd-homed (cf. [1]) to implement
> > portable home directories.
>=20
> Can you walk us through the motivating use case?
>=20
> As of this year's LPC I had the distinct impression that the primary use
> case for such a feature was due to the RLIMIT_NPROC problem where two
> containers with the same users still wanted different uid mappings to
> the disk because the users were conflicting with each other because of
> the per user rlimits.
>=20
> Fixing rlimits is straight forward to implement, and easier to manage
> for implementations and administrators.

This is separate to the question of "isolated user namespaces" and
managing different mappings between containers. This patchset is solving
the same problem that shiftfs solved -- sharing a single directory tree
between containers that have different ID mappings. rlimits (nor any of
the other proposals we discussed at LPC) will help with this problem.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--kgfxsa7rlwd3wkqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX5rlEgAKCRCdlLljIbnQ
EjiPAP9KREQ/2yXGdsYwcSMUpeqUj/wV1rG+UIzAlmjRSy5b2gEA+A5+ZdrAKLCh
v+4J3Z/kM0lgTkLGg8Ib1D4QT/HGDQY=
=Bh7P
-----END PGP SIGNATURE-----

--kgfxsa7rlwd3wkqj--
