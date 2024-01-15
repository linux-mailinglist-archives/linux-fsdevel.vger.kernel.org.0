Return-Path: <linux-fsdevel+bounces-7946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5C82DB27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33FB0281DB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0412C1758E;
	Mon, 15 Jan 2024 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSxial5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D217586
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-558b04cb660so2002332a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705328427; x=1705933227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Yt3DNg2lddipYwuflZs9I1aAMkpODH6re/5qdLVgP4=;
        b=gSxial5o8n6l7acV/moQmRlAOImqGy2kt/mijWN3oGn0n6xnDW7BUN+dnpE192zUfZ
         H72TVVkvzXV/SpZ5IV48JRDAqQKeyMDDvJ1/LquYGp4UkpUsRUBHbrdtPwEToAyT/ZtA
         HkSJyw4OxkR+aglf/x37YTVoBrlI76pT5e/qiwirXdqN2W0vvKTYch7SZekvonyxjh5A
         CUXgsgwT1qm908tIeuLDhlVZCg/zxATMTuXjLqPBxMIB+TpjeoybrSC0Z7TpiA8hw0M7
         Mjh2buUDuP19Lc5T0ebEs9J5+y5L4OSpcDgUilEYwCBi9T6i9HmT+NzfhlTwbMs8nMH0
         Xt9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705328427; x=1705933227;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Yt3DNg2lddipYwuflZs9I1aAMkpODH6re/5qdLVgP4=;
        b=t6YaAxtlV/ROSjJABv2r2ty+sSThChVwrf73QOaxZ+DTCrcceH62Y+e1uhDd1SFrZ+
         79VIFm1PMyJwVeB5q/wb/97TtXexFtd6uNrkHwUaBc4Bq7mrB0NbgFOS1FskR0ys7AAF
         bNMROsC18GzCa8zj7ZDDq2ZgU4mJ8g/JBPbfuVG6l5JWsn+OKGWAJRDzleByifpB3iZz
         hOwQsRCNFSAWfSc4zbioIg/BDKqhiVXTGb/tO70ReuafLqvH96zAWYmF6B6Odo+p0/Sa
         q2iywWl7rdSviLm5BBTd6AArHzJd1ZqYKLpXAtAUducFRrpyGgq2dkuDW06XTauBfSdK
         rLsQ==
X-Gm-Message-State: AOJu0YytYkK2BjY/FaANqYzQI6sx7jZdgEUMK3quSs863ebHErQhk75B
	0m1Z9uYGdoXm5jrXbFiv//KVN3SS+U0PPJJERA==
X-Google-Smtp-Source: AGHT+IE9EOsgbCickhaArGGhgD4E3N98+AXpuD9qQHJT/uPpPfyxaS2IgX1b94t5LbNq4wTJ/VMj2NgYRqs=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3a10:62fd:72bf:27db])
 (user=gnoack job=sendgmr) by 2002:aa7:d413:0:b0:558:cce3:4dde with SMTP id
 z19-20020aa7d413000000b00558cce34ddemr39961edq.7.1705328426769; Mon, 15 Jan
 2024 06:20:26 -0800 (PST)
Date: Mon, 15 Jan 2024 15:20:17 +0100
In-Reply-To: <11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com>
Message-Id: <ZaU_IXCdNqKx7Wcj@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com> <20231208155121.1943775-6-gnoack@google.com>
 <11cdac1e-e96c-405f-63e8-35b0e2926337@arm.com>
Subject: Re: [PATCH v8 5/9] selftests/landlock: Test IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-security-module@vger.kernel.org, 
	"=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Side remark, this other patch on the LSM list seems to about a related bug:
https://lore.kernel.org/linux-security-module/20240112074059.29673-1-hu.yad=
i@h3c.com/T/#u

On Fri, Dec 15, 2023 at 12:52:19PM +0000, Aishwarya TCV wrote:
>=20
>=20
> On 08/12/2023 15:51, G=C3=BCnther Noack wrote:
> > Exercises Landlock's IOCTL feature in different combinations of
> > handling and permitting the rights LANDLOCK_ACCESS_FS_IOCTL,
> > LANDLOCK_ACCESS_FS_READ_FILE, LANDLOCK_ACCESS_FS_WRITE_FILE and
> > LANDLOCK_ACCESS_FS_READ_DIR, and in different combinations of using
> > files and directories.
> >=20
> > Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
> > ---
> >  tools/testing/selftests/landlock/fs_test.c | 431 ++++++++++++++++++++-
>=20
> Hi G=C3=BCnther,
>=20
> When building kselftest against next-master the below build error is
> observed. A bisect (full log
> below) identified this patch as introducing the failure.
>=20
> Full log from a failure:
> https://storage.kernelci.org/next/master/next-20231215/arm64/defconfig+ks=
elftest/gcc-10/logs/kselftest.log
>=20
> -----
> make[4]: Entering directory
> '/tmp/kci/linux/tools/testing/selftests/landlock'
> aarch64-linux-gnu-gcc -Wall -O2 -isystem
> /tmp/kci/linux/build/usr/include     base_test.c -lcap -o
> /tmp/kci/linux/build/kselftest/landlock/base_test
> aarch64-linux-gnu-gcc -Wall -O2 -isystem
> /tmp/kci/linux/build/usr/include     fs_test.c -lcap -o
> /tmp/kci/linux/build/kselftest/landlock/fs_test
> In file included from /tmp/kci/linux/build/usr/include/linux/fs.h:19,
>                  from fs_test.c:12:
> /usr/include/aarch64-linux-gnu/sys/mount.h:35:3: error: expected
> identifier before numeric constant
>    35 |   MS_RDONLY =3D 1,  /* Mount read-only.  */
>       |   ^~~~~~~~~
> In file included from common.h:19,
>                  from fs_test.c:27:
> fs_test.c: In function =E2=80=98prepare_layout_opt=E2=80=99:
> fs_test.c:281:42: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclared (first u=
se in this
> function)
>   281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |                                          ^~~~~~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:281:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>   281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |  ^~~~~~~~~
> fs_test.c:281:42: note: each undeclared identifier is reported only once
> for each function it appears in
>   281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |                                          ^~~~~~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:281:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>   281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |  ^~~~~~~~~
> fs_test.c:281:55: error: =E2=80=98MS_REC=E2=80=99 undeclared (first use i=
n this function)
>   281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |                                                       ^~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:281:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>   281 |  ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |  ^~~~~~~~~
> fs_test.c: In function =E2=80=98layout1_mount_and_pivot_child=E2=80=99:
> fs_test.c:1653:44: error: =E2=80=98MS_RDONLY=E2=80=99 undeclared (first u=
se in this
> function)
>  1653 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
>       |                                            ^~~~~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:1653:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>  1653 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
>       |  ^~~~~~~~~
> fs_test.c: In function =E2=80=98layout1_topology_changes_with_net_only_ch=
ild=E2=80=99:
> fs_test.c:1712:43: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclared (first =
use in this
> function)
>  1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |                                           ^~~~~~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:1712:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>  1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |  ^~~~~~~~~
> fs_test.c:1712:56: error: =E2=80=98MS_REC=E2=80=99 undeclared (first use =
in this function)
>  1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |                                                        ^~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:1712:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>  1712 |  ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |  ^~~~~~~~~
> fs_test.c: In function =E2=80=98layout1_topology_changes_with_net_and_fs_=
child=E2=80=99:
> fs_test.c:1741:44: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclared (first =
use in this
> function)
>  1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |                                            ^~~~~~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:1741:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>  1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |  ^~~~~~~~~
> fs_test.c:1741:57: error: =E2=80=98MS_REC=E2=80=99 undeclared (first use =
in this function)
>  1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |                                                         ^~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:1741:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>  1741 |  ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC,
> NULL));
>       |  ^~~~~~~~~
> fs_test.c: In function =E2=80=98layout1_bind_setup=E2=80=99:
> fs_test.c:4340:47: error: =E2=80=98MS_BIND=E2=80=99 undeclared (first use=
 in this function)
>  4340 |  ASSERT_EQ(0, mount(dir_s1d2, dir_s2d2, NULL, MS_BIND, NULL));
>       |                                               ^~~~~~~
> ../kselftest_harness.h:707:13: note: in definition of macro =E2=80=98__EX=
PECT=E2=80=99
>   707 |  __typeof__(_seen) __seen =3D (_seen); \
>       |             ^~~~~
> fs_test.c:4340:2: note: in expansion of macro =E2=80=98ASSERT_EQ=E2=80=99
>  4340 |  ASSERT_EQ(0, mount(dir_s1d2, dir_s2d2, NULL, MS_BIND, NULL));
>       |  ^~~~~~~~~
> In file included from fs_test.c:19:
> fs_test.c: At top level:
> fs_test.c:5155:12: error: =E2=80=98MS_BIND=E2=80=99 undeclared here (not =
in a function)
>  5155 |   .flags =3D MS_BIND,
>       |            ^~~~~~~
> make[4]: *** [../lib.mk:147:
> /tmp/kci/linux/build/kselftest/landlock/fs_test] Error 1
> make[4]: Leaving directory '/tmp/kci/linux/tools/testing/selftests/landlo=
ck'
> -----
>=20
>=20
> Bisect log:
>=20
> -----
> git bisect start
> # good: [a39b6ac3781d46ba18193c9dbb2110f31e9bffe9] Linux 6.7-rc5
> git bisect good a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> # bad: [11651f8cb2e88372d4ed523d909514dc9a613ea3] Add linux-next
> specific files for 20231214
> git bisect bad 11651f8cb2e88372d4ed523d909514dc9a613ea3
> # good: [436cc0377e881784e5d12a863db037ad7d56b700] Merge branch 'main'
> of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> git bisect good 436cc0377e881784e5d12a863db037ad7d56b700
> # good: [4acaf686fcfee1d2ce0770a1d7505cd0e66400f0] Merge branch 'next'
> of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
> git bisect good 4acaf686fcfee1d2ce0770a1d7505cd0e66400f0
> # good: [81d6c0949c93b9fb46ddd53819bc1dd69b161fb5] Merge branch
> 'tty-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.gi=
t
> git bisect good 81d6c0949c93b9fb46ddd53819bc1dd69b161fb5
> # good: [21298ae90dfc30823d4b3e8c28b536b94816a625] Merge branch
> 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
> git bisect good 21298ae90dfc30823d4b3e8c28b536b94816a625
> # good: [f2cd1cb9acacb72cab0f90d2d648659fda209f75] Merge branch 'kunit'
> of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.gi=
t
> git bisect good f2cd1cb9acacb72cab0f90d2d648659fda209f75
> # good: [a3cd576f9a3d15f7697764a9439b91fd1acb603c] Merge branch
> 'slab/for-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git
> git bisect good a3cd576f9a3d15f7697764a9439b91fd1acb603c
> # bad: [79b6e5e0cf1a746e40d87053db55dce76d1fd718] Merge branch
> 'for-next/kspp' of
> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
> git bisect bad 79b6e5e0cf1a746e40d87053db55dce76d1fd718
> # bad: [7098a5baeb1014c676b9e86025afd274807900a7] Merge branch
> 'sysctl-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
> git bisect bad 7098a5baeb1014c676b9e86025afd274807900a7
> # bad: [9b4e8cb962dfcc7d5919b0ca383ff3df7f88f7cb] Merge branch 'next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
> git bisect bad 9b4e8cb962dfcc7d5919b0ca383ff3df7f88f7cb
> # good: [2d2016fefb8edd11a87053caab3a9044dbd7093e] landlock: Add IOCTL
> access right
> git bisect good 2d2016fefb8edd11a87053caab3a9044dbd7093e
> # bad: [86d25e41081ec6359c75e2e873b085de03f3cd34] selftests/landlock:
> Test ioctl(2) and ftruncate(2) with open(O_PATH)
> git bisect bad 86d25e41081ec6359c75e2e873b085de03f3cd34
> # bad: [a725134eca88b930bc2c5947297ccf72238a8149] selftests/landlock:
> Test IOCTL with memfds
> git bisect bad a725134eca88b930bc2c5947297ccf72238a8149
> # bad: [e0bf2e60f9c35ab3fa13ff33fb3e0088fe2248c2] selftests/landlock:
> Test IOCTL support
> git bisect bad e0bf2e60f9c35ab3fa13ff33fb3e0088fe2248c2
> # first bad commit: [e0bf2e60f9c35ab3fa13ff33fb3e0088fe2248c2]
> selftests/landlock: Test IOCTL support
> -----
>=20
> Thanks,
> Aishwarya

