Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785805540AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 04:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356120AbiFVC5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jun 2022 22:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVC5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:57:34 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C927731340;
        Tue, 21 Jun 2022 19:57:32 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4LSSjK3s6tz9sSl;
        Wed, 22 Jun 2022 04:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1655866645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gN8TCIVEGUrtLmOK4r2NY1SONlCas7fWKHtUkH7eQEo=;
        b=AO2ygye5tn7a1ew/el2eVI94NEpUVIew/Jln7IoLM8Aj6gmzpe7jdMCD+JhobMU2NoARxo
        vOghCDAPNFinOsf4X4OdOj248pjwWoCPxigaIqg32VVfy816J5onRYWuzaNs/3Qt8jRfHU
        Fm+ujbgnxYvBvatExgqFzb4XK3NEzY3sF/YHwcC3/IZaIXcZNth5dquVC3T5MnQU6gbncR
        k5OUNN+xt06fE0j/9mf/yEQFnJZiAF4DIGMD1jK+F3mopkggcuIQ+gn2ys5PsZ9nTE3XBc
        CIkReBzYEEwPqB2RMetxkImAqy2ZFBH6BjtUAqGQcWbrS9PU/4oGLU8ZuzYo4g==
Date:   Wed, 22 Jun 2022 12:57:15 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christian =?utf-8?B?R8O2dHRzY2hl?= <cgzones@googlemail.com>,
        SElinux list <selinux@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
Message-ID: <20220622025715.upflevvao3ttaekj@senku>
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein>
 <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein>
 <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku>
 <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
 <20220620060741.3clikqadotq2p5ja@senku>
 <CAOQ4uxhq8HVoM=6O_H-uowv65m6tLAPUj2a_r3-CWpiX-48MoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3qxnax3ppvxdjkcd"
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhq8HVoM=6O_H-uowv65m6tLAPUj2a_r3-CWpiX-48MoQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--3qxnax3ppvxdjkcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-06-20, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > The goal would be that the semantics of fooat(<fd>, AT_EMPTY_PATH) =
and
> > > > foo(/proc/self/fd/<fd>) should always be identical, and the current
> > > > semantics of /proc/self/fd/<fd> are too leaky so we shouldn't always
> > > > assume that keeping them makes sense (the most obvious example is b=
eing
> > > > able to do tricks to open /proc/$pid/exe as O_RDWR).
> > >
> > > Please make a note that I have applications relying on current magic =
symlink
> > > semantics w.r.t setxattr() and other metadata operations, and the lib=
selinux
> > > commit linked from the patch commit message proves that magic symlink
> > > semantics are used in the wild, so it is not likely that those semant=
ics could
> > > be changed, unless userspace breakage could be justified by fixing a =
serious
> > > security issue (i.e. open /proc/$pid/exe as O_RDWR).
> >
> > Agreed. We also use magiclinks for similar TOCTOU-protection purposes in
> > runc (as does lxc) as well as in libpathrs so I'm aware we need to be
> > careful about changing existing behaviours. I would prefer to have the
> > default be as restrictive as possible, but naturally back-compat is
> > more important.
> >
> > > > I suspect that the long-term solution would be to have more upgrade
> > > > masks so that userspace can opt-in to not allowing any kind of
> > > > (metadata) write access through a particular file descriptor. You're
> > > > quite right that we have several metadata write AT_EMPTY_PATH APIs,=
 and
> > > > so we can't retroactively block /everything/ but we should try to c=
ome
> > > > up with less leaky rules by default if it won't break userspace.
> > >
> > > Ok, let me try to say this in my own words using an example to see th=
at
> > > we are all on the same page:
> > >
> > > - lsetxattr(PATH_TO_FILE,..) has inherent TOCTOU races
> > > - fsetxattr(fd,...) is not applicable for symbolic links
> >
> > While I agree with Christian's concerns about making O_PATH descriptors
> > more leaky, if userspace already relies on this through /proc/self/fd/$x
> > then there's not much we can do about it other than having an opt-out
> > available in openat2(2). Having the option to disable this stuff to
> > avoid making O_PATH descriptors less safe as a mechanism for passing
> > around "capability-less" file handles should make most people happy
> > (with the note that ideally we would not be *adding* capabilities to
> > O_PATH we don't need to).
> >
> > > - setxattr("/proc/self/fd/<fd>",...) is the current API to avoid TOCT=
OU races
> > >   when setting xattr on symbolic links
> > > - setxattrat(o_path_fd, "", ..., AT_EMPTY_PATH) is proposed as a the
> > >   "new API" for setting xattr on symlinks (and special files)
> >
> > If this is a usecase we need to support then we may as well just re-use
> > fsetxattr() since it's basically an *at(2) syscall already (and I don't
> > see why we'd want to split up the capabilities between two similar
> > *at(2)-like syscalls). Though this does come with the above caveats that
> > we need to have the opt-outs available if we're going to enshrine this
> > as intentional part of the ABI.
>=20
>=20
> Christian preferred that new functionality be added with a new API
> and I agree that this is nicer and more explicit.

Fair enough -- I misread the man page, setxattrat(2) makes more sense.

> The bigger question IMO is, whether fsomething() should stay identical
> to somethingat(,,,AT_EMPTY_PATH). I don't think that it should.
>=20
> To me, open(path,O_PATH)+somethingat(,,,AT_EMPTY_PATH) is identical
> to something(path) - it just breaks the path resolution and operation to =
two
> distinguished steps.
>=20
> fsomething() was traditionally used for "really" open fds, so if we don't=
 need
> to, we better not relax it further by allowing O_PATH, but that's just one
> opinion.

Yeah, you're right -- it would be better to not muddle the two (even
though they are conceptually very similar).

> > > - The new API is going to be more strict than the old magic symlink A=
PI
> > > - *If* it turns out to not break user applications, old API can also =
become
> > >   more strict to align with new API (unlikely the case for setxattr())
> > > - This will allow sandboxed containers to opt-out of the "old API", by
> > >   restricting access to /proc/self/fd and to implement more fine grai=
ned
> > >   control over which metadata operations are allowed on an O_PATH fd
> > >
> > > Did I understand the plan correctly?
> >
> > Yup, except I don't think we need setxattrat(2).
> >
> > > Do you agree with me that the plan to keep AT_EMPTY_PATH and magic
> > > symlink semantics may not be realistic?
> >
> > To clarify -- my view is that if any current /proc/self/fd/$n semantic
> > needs to be maintained then I would prefer that the proc-less method of
> > doing it (such as through AT_EMPTY_PATH et al) would have the same
> > capability and semantics. There are some cases where the current
> > /proc/self/fd/$n semantics need to be fixed (such as the /proc/$pid/exe
> > example) and in that case the proc-less semantics also need to be made
> > safe.
> >
> > While I would like us to restrict O_PATH as much as possible, if
> > userspace already depends on certain behaviour then we may not be able
> > to do much about it. Having an opt-out would be very important since
> > enshrining these leaky behaviours (which seem to have been overlooked)
> > means we need to consider how userspace can opt out of them.
> >
> > Unfortunately, it should be noted that due to the "magical" nature of
> > nd_jump_link(), I'm not sure how happy Al Viro will be with the kinds of
> > restrictions necessary. Even my current (quite limited) upgrade-mask
> > patchset has to do a fair bit of work to unify the semantics of
> > magic-links and openat(O_EMPTYPATH) -- expanding this to all *at(2)
> > syscalls might be quite painful. (There are also several handfuls of
> > semantic questions which need to be answered about magic-link modes and
> > whether for other *at(2) operations we may need even more complicated
> > rules or even a re-thinking of my current approach.)
>=20
> The question remains, regarding the $SUBJECT patch,
> is it fair to block it and deprive libselinux of a non buggy API
> until such time that all the details around masking O_PATH fds
> will be made clear and the new API implemented?
>=20
> There is no guarantee this will ever happen, so it does not seem
> reasonable to me.
>=20
> To be a reasonable reaction to the currently broken API is
> to either accept the patch as is or request that setxattrat()
> will be added to provide the new functionality.

Since the current functionality cannot be retroactively disabled as it
is being used already through /proc/self/fd/$n, adding
*xattrat(AT_EMPTY_PATH) doesn't really change what is currently possible
by userspace.

I would say we should add *xattrat(2) and then we can add an upgrade
mask blocking it (and other operations) later.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--3qxnax3ppvxdjkcd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYrKFCwAKCRCdlLljIbnQ
EkHDAQDcWDPHXJjqAjGAzNYq6SVS0yjL41QqWacGXvPb66FPFAEAusaYO6iZOP4M
oEYAPDOwguXO7T12FYXSzG8yX6V54QE=
=QX0d
-----END PGP SIGNATURE-----

--3qxnax3ppvxdjkcd--
