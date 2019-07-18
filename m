Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 766B36D197
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2019 18:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfGRQMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jul 2019 12:12:53 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:62070 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfGRQMw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:12:52 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id DB1F950921;
        Thu, 18 Jul 2019 18:12:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
        with ESMTP id ZQRmoVgJSQdC; Thu, 18 Jul 2019 18:12:38 +0200 (CEST)
Date:   Fri, 19 Jul 2019 02:12:31 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v9 08/10] open: openat2(2) syscall
Message-ID: <20190718161231.xcno272nvqpln3wj@yavin>
References: <20190706145737.5299-1-cyphar@cyphar.com>
 <20190706145737.5299-9-cyphar@cyphar.com>
 <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cqnjaasdwru53b2s"
Content-Disposition: inline
In-Reply-To: <CAK8P3a33rGhPDFfRBAQyLTMG_WoEgX_toDgWR2O7rSwxKsZG+w@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--cqnjaasdwru53b2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-07-18, Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Jul 6, 2019 at 5:00 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> > diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel=
/syscalls/syscall.tbl
> > index 9e7704e44f6d..1703d048c141 100644
> > --- a/arch/alpha/kernel/syscalls/syscall.tbl
> > +++ b/arch/alpha/kernel/syscalls/syscall.tbl
> > @@ -461,6 +461,7 @@
> >  530    common  getegid                         sys_getegid
> >  531    common  geteuid                         sys_geteuid
> >  532    common  getppid                         sys_getppid
> > +533    common  openat2                         sys_openat2
> >  # all other architectures have common numbers for new syscall, alpha
> >  # is the exception.
> >  534    common  pidfd_send_signal               sys_pidfd_send_signal
>=20
> My plan here was to add new syscalls in the same order as everwhere else,
> just with the number 110 higher. In the long run, I hope we can automate
> this.

Alright, I will adjust this.

> > diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
> > index aaf479a9e92d..4ad262698396 100644
> > --- a/arch/arm/tools/syscall.tbl
> > +++ b/arch/arm/tools/syscall.tbl
> > @@ -447,3 +447,4 @@
> >  431    common  fsconfig                        sys_fsconfig
> >  432    common  fsmount                         sys_fsmount
> >  433    common  fspick                          sys_fspick
> > +434    common  openat2                         sys_openat2
>=20
> 434 is already used in linux-next, I suggest you use 437 (Palmer
> just submitted fchmodat4, which could become 436).

437 sounds good to me.

> > +/**
> > + * Arguments for how openat2(2) should open the target path. If @extra=
 is zero,
> > + * then openat2(2) is identical to openat(2).
> > + *
> > + * @flags: O_* flags (unknown flags ignored).
> > + * @mode: O_CREAT file mode (ignored otherwise).
> > + * @upgrade_mask: restrict how the O_PATH may be re-opened (ignored ot=
herwise).
> > + * @resolve: RESOLVE_* flags (-EINVAL on unknown flags).
> > + * @reserved: reserved for future extensions, must be zeroed.
> > + */
> > +struct open_how {
> > +       __u32 flags;
> > +       union {
> > +               __u16 mode;
> > +               __u16 upgrade_mask;
> > +       };
> > +       __u16 resolve;
> > +       __u64 reserved[7]; /* must be zeroed */
> > +};
>=20
> We can have system calls with up to six arguments on all architectures, so
> this could still be done more conventionally without the indirection: like
>=20
> long openat2(int dfd, const char __user * filename, int flags, mode_t
> mode_mask, __u16 resolve);
>=20
> In fact, that seems similar enough to the existing openat() that I think
> you could also just add the fifth argument to the existing call when
> a newly defined flag is set, similarly to how we only use the 'mode'
> argument when O_CREAT or O_TMPFILE are set.

I considered doing this (and even had a preliminary version of it), but
I discovered that I was not in favour of this idea -- once I started to
write tests using it -- for a few reasons:

  1. It doesn't really allow for clean extension for a future 6th
	 argument (because you are using up O_* flags to signify "use the
	 next argument", and O_* flags don't give -EINVAL if they're
	 unknown). Now, yes you can do the on-start runtime check that
	 everyone does -- but I've never really liked having to do it.

	 Having reserved padding for later extensions (that is actually
	 checked and gives -EINVAL) matches more modern syscall designs.

  2. I really was hoping that the variadic openat(2) could be done away
     using this union setup (Linus said he didn't like it, and suggested
	 using something like 'struct stat' as an argument for openat(2) --
	 though personally I am not sure I would personally like to use an
	 interface like that).

  3. In order to avoid wasting a syscall argument for mode/mask you need
	 to either have something like your suggested mode_mask (which makes
	 the syscall arguments less consistent) or have some sort of
	 mode-like argument that is treated specially (which is really awful
	 on multiple levels -- this one I also tried and even wrote my
	 original tests using). And in both cases, the shims for
	 open{,at}(2) are somewhat less clean.

All of that being said, I'd be happy to switch to whatever you think
makes the most sense. As long as it's possible to get an O_PATH with
RESOLVE_IN_ROOT set, I'm happy.

> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
>=20
> This file seems to lack a declaration for the system call, which means it
> will cause a build failure on some architectures, e.g. arch/arc/kernel/sy=
s.c:
>=20
> #define __SYSCALL(nr, call) [nr] =3D (call),
> void *sys_call_table[NR_syscalls] =3D {
>         [0 ... NR_syscalls-1] =3D sys_ni_syscall,
> #include <asm/unistd.h>
> };

Thanks, I will fix this.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cqnjaasdwru53b2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXTCaawAKCRCdlLljIbnQ
EiYSAQDEc7/A6jyOk/lCwRhggyIcxNKsYaVUpK2GNk3BWcMP1gD9HsURgy5VJcXW
ndP9aKEsYi+1zcPS6NupxsV7j2xWBwo=
=lnH6
-----END PGP SIGNATURE-----

--cqnjaasdwru53b2s--
