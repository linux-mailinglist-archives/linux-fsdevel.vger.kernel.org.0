Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A243C29C9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2019 00:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfI3Wmj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 18:42:39 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:20990 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbfI3Wmj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:42:39 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 83B48A1A1C;
        Tue,  1 Oct 2019 00:42:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id i0Vf_5Qcnyhu; Tue,  1 Oct 2019 00:42:25 +0200 (CEST)
Date:   Tue, 1 Oct 2019 08:41:59 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        sparclinux@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>, Aleksa Sarai <asarai@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linuxppc-dev@lists.ozlabs.org,
        Andy Lutomirski <luto@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Drysdale <drysdale@google.com>,
        Christian Brauner <christian@brauner.io>,
        libc-alpha@sourceware.org, linux-parisc@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-api@vger.kernel.org,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-alpha@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org
Subject: Re: [PATCH v13 7/9] open: openat2(2) syscall
Message-ID: <20190930224159.gp2hqm57qxlm2eat@yavin.dot.cyphar.com>
References: <20190930183316.10190-8-cyphar@cyphar.com>
 <201910010404.WLqR1mUW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t4elbyhlilsmpd4b"
Content-Disposition: inline
In-Reply-To: <201910010404.WLqR1mUW%lkp@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--t4elbyhlilsmpd4b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-01, kbuild test robot <lkp@intel.com> wrote:
> Hi Aleksa,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on linus/master]
> [cannot apply to v5.4-rc1 next-20190930]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help
> improve the system. BTW, we also suggest to use '--base' option to specif=
y the
> base tree in git format-patch, please see https://stackoverflow.com/a/374=
06982]

I forgot to include --base to signify this series depends on the
copy_struct_from_user() one. I'll include it in the next version.

> url:    https://github.com/0day-ci/linux/commits/Aleksa-Sarai/namei-opena=
t2-2-path-resolution-restrictions/20191001-025628
> config: i386-defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
> All errors (new ones prefixed by >>):
>=20
>    fs/open.c: In function '__do_sys_openat2':
> >> fs/open.c:1173:8: error: implicit declaration of function 'copy_struct=
_from_user'; did you mean 'copy_siginfo_from_user'? [-Werror=3Dimplicit-fun=
ction-declaration]
>      err =3D copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
>            ^~~~~~~~~~~~~~~~~~~~~
>            copy_siginfo_from_user
>    cc1: some warnings being treated as errors
>=20
> vim +1173 fs/open.c
>=20
>   1163=09
>   1164	SYSCALL_DEFINE4(openat2, int, dfd, const char __user *, filename,
>   1165			const struct open_how __user *, how, size_t, usize)
>   1166	{
>   1167		int err;
>   1168		struct open_how tmp;
>   1169=09
>   1170		if (unlikely(usize < OPEN_HOW_SIZE_VER0))
>   1171			return -EINVAL;
>   1172=09
> > 1173		err =3D copy_struct_from_user(&tmp, sizeof(tmp), how, usize);
>   1174		if (err)
>   1175			return err;
>   1176=09
>   1177		if (force_o_largefile())
>   1178			tmp.flags |=3D O_LARGEFILE;
>   1179=09
>   1180		return do_sys_open(dfd, filename, &tmp);
>   1181	}
>   1182=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--t4elbyhlilsmpd4b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZKEtAAKCRCdlLljIbnQ
EmxJAQDTSUj176CMMvs56b+zPL9VCZGAIFkQ+0fXCW8y6GyasAD/d8NBlZ2zmc9b
DdtZcltEmeWc0Rd4LR1wAUrHajuvTAU=
=sSPC
-----END PGP SIGNATURE-----

--t4elbyhlilsmpd4b--
