Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68C550260
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 05:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiFRDS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 23:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383685AbiFRDS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 23:18:26 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3708447046;
        Fri, 17 Jun 2022 20:18:24 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4LQ1MC3fKTz9sTF;
        Sat, 18 Jun 2022 05:18:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1655522295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ti92GavK4B+AVOSiOc7sl0Nh3i4kHTF9NVY/77Be+cs=;
        b=iqfJvTkOopcCPhN1geyQohtJR9+Z6ikYbBKj0dm+I0jEOjYObbq3MSBUzLXSmiJ9KLBYHu
        PdzA2Q9gELs01xqfFGy6Rw5P50Gi73tRbTZyiaXUuUAkbGU9bPE1eUdmc0lAzrzCq+ydf8
        v8l3xQFM1ly5vhc7wVNhfDWr01MnZpJ3QA9KuihibEGahd9hF9eSgPZHZ03b1s5AE6ZeBF
        xnFlw6VophiXCKevd1YR6nuQ0vAwQj6ynUtGfU608c4mdTD66Eq5H/vefYJAhqa+YTF8fg
        hd3rfacAiX/s5AZd5i8ZYTkl1gbjftrEkVT0tEycyBPEP++XMoC3konoCAkdvA==
Date:   Sat, 18 Jun 2022 13:18:05 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
Message-ID: <20220618031805.nmgiuapuqeblm3ba@senku>
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein>
 <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein>
 <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lozwk7eau5q3sps2"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
X-Rspamd-Queue-Id: 4LQ1MC3fKTz9sTF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--lozwk7eau5q3sps2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-08, Amir Goldstein <amir73il@gmail.com> wrote:
> On Wed, Jun 8, 2022 at 3:48 PM Christian Brauner <brauner@kernel.org> wro=
te:
> >
> > On Wed, Jun 08, 2022 at 03:28:52PM +0300, Amir Goldstein wrote:
> > > On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kernel.org>=
 wrote:
> > > >
> > > > On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian G=F6ttsche wrot=
e:
> > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > >
> > > > > Support file descriptors obtained via O_PATH for extended attribu=
te
> > > > > operations.
> > > > >
> > > > > Extended attributes are for example used by SELinux for the secur=
ity
> > > > > context of file objects. To avoid time-of-check-time-of-use issue=
s while
> > > > > setting those contexts it is advisable to pin the file in questio=
n and
> > > > > operate on a file descriptor instead of the path name. This can be
> > > > > emulated in userspace via /proc/self/fd/NN [1] but requires a pro=
cfs,
> > > > > which might not be mounted e.g. inside of chroots, see[2].
> > > > >
> > > > > [1]: https://github.com/SELinuxProject/selinux/commit/7e979b56fd2=
cee28f647376a7233d2ac2d12ca50
> > > > > [2]: https://github.com/SELinuxProject/selinux/commit/de285252a18=
01397306032e070793889c9466845
> > > > >
> > > > > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > > > > https://patchwork.kernel.org/project/linux-fsdevel/patch/20200505=
095915.11275-6-mszeredi@redhat.com/
> > > > >
> > > > > > While this carries a minute risk of someone relying on the prop=
erty of
> > > > > > xattr syscalls rejecting O_PATH descriptors, it saves the troub=
le of
> > > > > > introducing another set of syscalls.
> > > > > >
> > > > > > Only file->f_path and file->f_inode are accessed in these funct=
ions.
> > > > > >
> > > > > > Current versions return EBADF, hence easy to detect the presens=
e of
> > > > > > this feature and fall back in case it's missing.
> > > > >
> > > > > CC: linux-api@vger.kernel.org
> > > > > CC: linux-man@vger.kernel.org
> > > > > Signed-off-by: Christian G=F6ttsche <cgzones@googlemail.com>
> > > > > ---
> > > >
> > > > I'd be somewhat fine with getxattr and listxattr but I'm worried th=
at
> > > > setxattr/removexattr waters down O_PATH semantics even more. I don't
> > > > want O_PATH fds to be useable for operations which are semantically
> > > > equivalent to a write.
> > >
> > > It is not really semantically equivalent to a write if it works on a
> > > O_RDONLY fd already.
> >
> > The fact that it works on a O_RDONLY fd has always been weird. And is
> > probably a bug. If you look at xattr_permission() you can see that it
>=20
> Bug or no bug, this is the UAPI. It is not fixable anymore.
>=20
> > checks for MAY_WRITE for set operations... setxattr() writes to disk for
> > real filesystems. I don't know how much closer to a write this can get.
> >
> > In general, one semantic aberration doesn't justify piling another one
> > on top.
> >
> > (And one thing that speaks for O_RDONLY is at least that it actually
> > opens the file wheres O_PATH doesn't.)
>=20
> Ok. I care mostly about consistent UAPI, so if you want to set the
> rule that modify f*() operations are not allowed to use O_PATH fd,
> I can live with that, although fcntl(2) may be breaking that rule, but
> fine by me.
> It's good to have consistent rules and it's good to add a new UAPI for
> new behavior.
>=20
> However...
>=20
> >
> > >
> > > >
> > > > In sensitive environments such as service management/container runt=
imes
> > > > we often send O_PATH fds around precisely because it is restricted =
what
> > > > they can be used for. I'd prefer to not to plug at this string.
> > >
> > > But unless I am mistaken, path_setxattr() and syscall_fsetxattr()
> > > are almost identical w.r.t permission checks and everything else.
> > >
> > > So this change introduces nothing new that a user in said environment
> > > cannot already accomplish with setxattr().
> > >
> > > Besides, as the commit message said, doing setxattr() on an O_PATH
> > > fd is already possible with setxattr("/proc/self/$fd"), so whatever s=
ecurity
> > > hole you are trying to prevent is already wide open.
> >
> > That is very much a something that we're trying to restrict for this
> > exact reason and is one of the main motivator for upgrade mask in
> > openat2(). If I want to send a O_PATH around I want it to not be
> > upgradable. Aleksa is working on upgrade masks with openat2() (see [1]
> > and part of the original patchset in [2]. O_PATH semantics don't need to
> > become weird.
> >
> > [1]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@senku
> > [2]: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/2019072801=
0207.9781-8-cyphar@cyphar.com
>=20
> ... thinking forward, if this patch is going to be rejected, the patch th=
at
> will follow is *xattrat() syscalls.
>=20
> What will you be able to argue then?
>=20
> There are several *at() syscalls that modify metadata.
> fchownat(.., AT_EMPTY_PATH) is intentionally designed for this.
>=20
> Do you intend to try and block setxattrat()?
> Just try and block setxattrat(.., AT_EMPTY_PATH)?
> those *at() syscalls have real use cases to avoid TOCTOU races.
> Do you propose that applications will have to use fsetxattr() on an open
> file to avert races?
>=20
> I completely understand the idea behind upgrade masks
> for limiting f_mode, but I don't know if trying to retroactively
> change semantics of setxattr() in the move to setxattrat()
> is going to be a good idea.

The goal would be that the semantics of fooat(<fd>, AT_EMPTY_PATH) and
foo(/proc/self/fd/<fd>) should always be identical, and the current
semantics of /proc/self/fd/<fd> are too leaky so we shouldn't always
assume that keeping them makes sense (the most obvious example is being
able to do tricks to open /proc/$pid/exe as O_RDWR).

I suspect that the long-term solution would be to have more upgrade
masks so that userspace can opt-in to not allowing any kind of
(metadata) write access through a particular file descriptor. You're
quite right that we have several metadata write AT_EMPTY_PATH APIs, and
so we can't retroactively block /everything/ but we should try to come
up with less leaky rules by default if it won't break userspace.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--lozwk7eau5q3sps2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYq1D7QAKCRCdlLljIbnQ
EisDAQDlTybzv0tXJJs7WeKQLAHpCjjTaNTZABGWLVdCDTPWmwD/TTjQ9wMwI+b0
0NiySyPqfspZ5q8lElvMQSojZ1u9Vww=
=8W1/
-----END PGP SIGNATURE-----

--lozwk7eau5q3sps2--
