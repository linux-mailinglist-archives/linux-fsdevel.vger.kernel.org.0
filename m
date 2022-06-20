Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F12E551010
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 08:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiFTGIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 02:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiFTGIA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:08:00 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D011E67;
        Sun, 19 Jun 2022 23:07:54 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4LRK1y29JDz9sQN;
        Mon, 20 Jun 2022 08:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1655705270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V+Wtfp/GOwZ6tKsLCqAhppV3ZUAVNqX3whh/S/h4/lE=;
        b=cRI0pVHO18/0r7jglwocW2FDCFknPyPP2lbEZf3T+rla8UG6FNkRNHDndOiFX/+y4jjxd/
        zloi+HNWdEJ/QbkbkhpDGwJYheWSemks5N5rR9qX3hppwDbGIEkLUUNyxDP8MniFULVjvu
        mb4SNEMMXlxtzPIWaRmV3OSIjTRkWflgZtd98OFyFwl73Qh5Wc861mMg5KpOk1RjXoqE7H
        ndNJgQBB+B43EEuswQeMOJ1UCqWTbRef3lab15fPOdSP3+1UF5Xzfe/XagpsTmMx2DJkhi
        HiMGTu80SmRYbUjzPagBHAgAc4jS1+v8tnyDgmbPQ89H8WQvHwxZAwOYxsn5aQ==
Date:   Mon, 20 Jun 2022 16:07:41 +1000
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
Message-ID: <20220620060741.3clikqadotq2p5ja@senku>
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein>
 <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein>
 <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku>
 <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l7uxdir2c5wi4yiw"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
X-Rspamd-Queue-Id: 4LRK1y29JDz9sQN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--l7uxdir2c5wi4yiw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-18, Amir Goldstein <amir73il@gmail.com> wrote:
> On Sat, Jun 18, 2022 at 6:18 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2022-06-08, Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Wed, Jun 8, 2022 at 3:48 PM Christian Brauner <brauner@kernel.org>=
 wrote:
> > > >
> > > > On Wed, Jun 08, 2022 at 03:28:52PM +0300, Amir Goldstein wrote:
> > > > > On Wed, Jun 8, 2022 at 2:57 PM Christian Brauner <brauner@kernel.=
org> wrote:
> > > > > >
> > > > > > On Tue, Jun 07, 2022 at 05:31:39PM +0200, Christian G=F6ttsche =
wrote:
> > > > > > > From: Miklos Szeredi <mszeredi@redhat.com>
> > > > > > >
> > > > > > > Support file descriptors obtained via O_PATH for extended att=
ribute
> > > > > > > operations.
> > > > > > >
> > > > > > > Extended attributes are for example used by SELinux for the s=
ecurity
> > > > > > > context of file objects. To avoid time-of-check-time-of-use i=
ssues while
> > > > > > > setting those contexts it is advisable to pin the file in que=
stion and
> > > > > > > operate on a file descriptor instead of the path name. This c=
an be
> > > > > > > emulated in userspace via /proc/self/fd/NN [1] but requires a=
 procfs,
> > > > > > > which might not be mounted e.g. inside of chroots, see[2].
> > > > > > >
> > > > > > > [1]: https://github.com/SELinuxProject/selinux/commit/7e979b5=
6fd2cee28f647376a7233d2ac2d12ca50
> > > > > > > [2]: https://github.com/SELinuxProject/selinux/commit/de28525=
2a1801397306032e070793889c9466845
> > > > > > >
> > > > > > > Original patch by Miklos Szeredi <mszeredi@redhat.com>
> > > > > > > https://patchwork.kernel.org/project/linux-fsdevel/patch/2020=
0505095915.11275-6-mszeredi@redhat.com/
> > > > > > >
> > > > > > > > While this carries a minute risk of someone relying on the =
property of
> > > > > > > > xattr syscalls rejecting O_PATH descriptors, it saves the t=
rouble of
> > > > > > > > introducing another set of syscalls.
> > > > > > > >
> > > > > > > > Only file->f_path and file->f_inode are accessed in these f=
unctions.
> > > > > > > >
> > > > > > > > Current versions return EBADF, hence easy to detect the pre=
sense of
> > > > > > > > this feature and fall back in case it's missing.
> > > > > > >
> > > > > > > CC: linux-api@vger.kernel.org
> > > > > > > CC: linux-man@vger.kernel.org
> > > > > > > Signed-off-by: Christian G=F6ttsche <cgzones@googlemail.com>
> > > > > > > ---
> > > > > >
> > > > > > I'd be somewhat fine with getxattr and listxattr but I'm worrie=
d that
> > > > > > setxattr/removexattr waters down O_PATH semantics even more. I =
don't
> > > > > > want O_PATH fds to be useable for operations which are semantic=
ally
> > > > > > equivalent to a write.
> > > > >
> > > > > It is not really semantically equivalent to a write if it works o=
n a
> > > > > O_RDONLY fd already.
> > > >
> > > > The fact that it works on a O_RDONLY fd has always been weird. And =
is
> > > > probably a bug. If you look at xattr_permission() you can see that =
it
> > >
> > > Bug or no bug, this is the UAPI. It is not fixable anymore.
> > >
> > > > checks for MAY_WRITE for set operations... setxattr() writes to dis=
k for
> > > > real filesystems. I don't know how much closer to a write this can =
get.
> > > >
> > > > In general, one semantic aberration doesn't justify piling another =
one
> > > > on top.
> > > >
> > > > (And one thing that speaks for O_RDONLY is at least that it actually
> > > > opens the file wheres O_PATH doesn't.)
> > >
> > > Ok. I care mostly about consistent UAPI, so if you want to set the
> > > rule that modify f*() operations are not allowed to use O_PATH fd,
> > > I can live with that, although fcntl(2) may be breaking that rule, but
> > > fine by me.
> > > It's good to have consistent rules and it's good to add a new UAPI for
> > > new behavior.
> > >
> > > However...
> > >
> > > >
> > > > >
> > > > > >
> > > > > > In sensitive environments such as service management/container =
runtimes
> > > > > > we often send O_PATH fds around precisely because it is restric=
ted what
> > > > > > they can be used for. I'd prefer to not to plug at this string.
> > > > >
> > > > > But unless I am mistaken, path_setxattr() and syscall_fsetxattr()
> > > > > are almost identical w.r.t permission checks and everything else.
> > > > >
> > > > > So this change introduces nothing new that a user in said environ=
ment
> > > > > cannot already accomplish with setxattr().
> > > > >
> > > > > Besides, as the commit message said, doing setxattr() on an O_PATH
> > > > > fd is already possible with setxattr("/proc/self/$fd"), so whatev=
er security
> > > > > hole you are trying to prevent is already wide open.
> > > >
> > > > That is very much a something that we're trying to restrict for this
> > > > exact reason and is one of the main motivator for upgrade mask in
> > > > openat2(). If I want to send a O_PATH around I want it to not be
> > > > upgradable. Aleksa is working on upgrade masks with openat2() (see =
[1]
> > > > and part of the original patchset in [2]. O_PATH semantics don't ne=
ed to
> > > > become weird.
> > > >
> > > > [1]: https://lore.kernel.org/all/20220526130355.fo6gzbst455fxywy@se=
nku
> > > > [2]: https://patchwork.ozlabs.org/project/linuxppc-dev/patch/201907=
28010207.9781-8-cyphar@cyphar.com
> > >
> > > ... thinking forward, if this patch is going to be rejected, the patc=
h that
> > > will follow is *xattrat() syscalls.
> > >
> > > What will you be able to argue then?
> > >
> > > There are several *at() syscalls that modify metadata.
> > > fchownat(.., AT_EMPTY_PATH) is intentionally designed for this.
> > >
> > > Do you intend to try and block setxattrat()?
> > > Just try and block setxattrat(.., AT_EMPTY_PATH)?
> > > those *at() syscalls have real use cases to avoid TOCTOU races.
> > > Do you propose that applications will have to use fsetxattr() on an o=
pen
> > > file to avert races?
> > >
> > > I completely understand the idea behind upgrade masks
> > > for limiting f_mode, but I don't know if trying to retroactively
> > > change semantics of setxattr() in the move to setxattrat()
> > > is going to be a good idea.
> >
> > The goal would be that the semantics of fooat(<fd>, AT_EMPTY_PATH) and
> > foo(/proc/self/fd/<fd>) should always be identical, and the current
> > semantics of /proc/self/fd/<fd> are too leaky so we shouldn't always
> > assume that keeping them makes sense (the most obvious example is being
> > able to do tricks to open /proc/$pid/exe as O_RDWR).
>=20
> Please make a note that I have applications relying on current magic syml=
ink
> semantics w.r.t setxattr() and other metadata operations, and the libseli=
nux
> commit linked from the patch commit message proves that magic symlink
> semantics are used in the wild, so it is not likely that those semantics =
could
> be changed, unless userspace breakage could be justified by fixing a seri=
ous
> security issue (i.e. open /proc/$pid/exe as O_RDWR).

Agreed. We also use magiclinks for similar TOCTOU-protection purposes in
runc (as does lxc) as well as in libpathrs so I'm aware we need to be
careful about changing existing behaviours. I would prefer to have the
default be as restrictive as possible, but naturally back-compat is
more important.

> > I suspect that the long-term solution would be to have more upgrade
> > masks so that userspace can opt-in to not allowing any kind of
> > (metadata) write access through a particular file descriptor. You're
> > quite right that we have several metadata write AT_EMPTY_PATH APIs, and
> > so we can't retroactively block /everything/ but we should try to come
> > up with less leaky rules by default if it won't break userspace.
>=20
> Ok, let me try to say this in my own words using an example to see that
> we are all on the same page:
>=20
> - lsetxattr(PATH_TO_FILE,..) has inherent TOCTOU races
> - fsetxattr(fd,...) is not applicable for symbolic links

While I agree with Christian's concerns about making O_PATH descriptors
more leaky, if userspace already relies on this through /proc/self/fd/$x
then there's not much we can do about it other than having an opt-out
available in openat2(2). Having the option to disable this stuff to
avoid making O_PATH descriptors less safe as a mechanism for passing
around "capability-less" file handles should make most people happy
(with the note that ideally we would not be *adding* capabilities to
O_PATH we don't need to).

> - setxattr("/proc/self/fd/<fd>",...) is the current API to avoid TOCTOU r=
aces
>   when setting xattr on symbolic links
> - setxattrat(o_path_fd, "", ..., AT_EMPTY_PATH) is proposed as a the
>   "new API" for setting xattr on symlinks (and special files)

If this is a usecase we need to support then we may as well just re-use
fsetxattr() since it's basically an *at(2) syscall already (and I don't
see why we'd want to split up the capabilities between two similar
*at(2)-like syscalls). Though this does come with the above caveats that
we need to have the opt-outs available if we're going to enshrine this
as intentional part of the ABI.

> - The new API is going to be more strict than the old magic symlink API
> - *If* it turns out to not break user applications, old API can also beco=
me
>   more strict to align with new API (unlikely the case for setxattr())
> - This will allow sandboxed containers to opt-out of the "old API", by
>   restricting access to /proc/self/fd and to implement more fine grained
>   control over which metadata operations are allowed on an O_PATH fd
>=20
> Did I understand the plan correctly?

Yup, except I don't think we need setxattrat(2).

> Do you agree with me that the plan to keep AT_EMPTY_PATH and magic
> symlink semantics may not be realistic?

To clarify -- my view is that if any current /proc/self/fd/$n semantic
needs to be maintained then I would prefer that the proc-less method of
doing it (such as through AT_EMPTY_PATH et al) would have the same
capability and semantics. There are some cases where the current
/proc/self/fd/$n semantics need to be fixed (such as the /proc/$pid/exe
example) and in that case the proc-less semantics also need to be made
safe.

While I would like us to restrict O_PATH as much as possible, if
userspace already depends on certain behaviour then we may not be able
to do much about it. Having an opt-out would be very important since
enshrining these leaky behaviours (which seem to have been overlooked)
means we need to consider how userspace can opt out of them.

Unfortunately, it should be noted that due to the "magical" nature of
nd_jump_link(), I'm not sure how happy Al Viro will be with the kinds of
restrictions necessary. Even my current (quite limited) upgrade-mask
patchset has to do a fair bit of work to unify the semantics of
magic-links and openat(O_EMPTYPATH) -- expanding this to all *at(2)
syscalls might be quite painful. (There are also several handfuls of
semantic questions which need to be answered about magic-link modes and
whether for other *at(2) operations we may need even more complicated
rules or even a re-thinking of my current approach.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--l7uxdir2c5wi4yiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYrAOrQAKCRCdlLljIbnQ
ErdxAP9OSoprisX2ieyqb6KwHypoythe6kDpkQVFMaw62QB7AwD+LEUmJgy+8vQc
RgRYhgt0G7GREq0HL80cnLX2U0WGgwQ=
=HLVt
-----END PGP SIGNATURE-----

--l7uxdir2c5wi4yiw--
