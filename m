Return-Path: <linux-fsdevel+bounces-5449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690BF80BF94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 04:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954CA1C2094F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 03:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530515AF9;
	Mon, 11 Dec 2023 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sj17zv4O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118E3DA
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 19:04:34 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5b383b4184fso33883727b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 19:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702263873; x=1702868673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxxLMmWK1LiLOsWFgqTLtp1uTrFHrBT/LtJeHcQxLS8=;
        b=Sj17zv4OFz3HOu/8BGtbJj370E+0f2zIEXcI0c5WaroUOIC46S/2YUpPu8nA5vqTCG
         u2Ca3QTDbt6Dbo3qbNuBKUyQ9I1TbAbH2jeq55i9xxbEnQks93s6PMDo0EBHdbNtOpbh
         4C4wtNf15mCAa9QjYxPGbN/0VHo/5ekT/DNxsOPvphq2sjsjAUaf2ePt4N/ecCcoXpj9
         VLyFogRWYRhd09ORlEIeEaHNjxRyQXsMSvDJG3M1m9zH4NF4CSOqDda3Rd5roam9Wb2E
         tBxUXkaHUlt7h8B+6wGinEDTwr8ehQfL9JP1KLx5af6bWsyGNTYoFz4ABOB7VyUQf/Nw
         Bacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702263873; x=1702868673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxxLMmWK1LiLOsWFgqTLtp1uTrFHrBT/LtJeHcQxLS8=;
        b=Ab+28VH4zWn9ccc6KjTH3yeUceqGZnteunR+cpqJrH4nCSVtBafYBAxY7mp4OAaaxh
         j/WrA8OdFW0I9nRRXFAKw2OYPg6PvFWjGnkuGuoQpLT32A0RcNDXuj/S5O+84XJ0BCno
         Mvr8/0jlxhQI+AQEsUxRGz98DRHqoJwwQYxqEhmNDVXBgGOKQ2Ix78X+P5V0v1w98IST
         mRPCBOAp1d50MA0kFR5qfaw1vr9DxLyPb4ydc8yeNtSxAWW0/TNXD08wI2pQjJoWvKnc
         W1TBUdOHwnjexjqKN1F64a81MHHOIDkhIXrZJtjLac3sgvvIUjaFaZAXcYlZH/QffRFO
         7CJg==
X-Gm-Message-State: AOJu0Yw3O9HnCT7GtfjoF8qKa7dXjAno/36gURFM5HoekXT6KGqzvkgb
	4oKgZWsiqMY5mjEicIKljqXMNBeB3PiszHKwW8wLwQ==
X-Google-Smtp-Source: AGHT+IFYd78Flda0nOK6MI1StSsFNgSiHz2GcFOxgdV2m2VwWCqzp0Iq7qepAZwjxnIR+mZxitrP0h478p/zMj61ejY=
X-Received: by 2002:a0d:f486:0:b0:5d7:1940:7d85 with SMTP id
 d128-20020a0df486000000b005d719407d85mr2722534ywf.92.1702263873009; Sun, 10
 Dec 2023 19:04:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk> <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
In-Reply-To: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 10 Dec 2023 19:04:19 -0800
Message-ID: <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Mark Brown <broonie@kernel.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	peterx@redhat.com, david@redhat.com, ryan.roberts@arm.com, hughd@google.com, 
	mhocko@suse.com, axelrasmussen@google.com, rppt@kernel.org, 
	willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com, 
	zhangpeng362@huawei.com, bgeffon@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, jdduke@google.com, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 5:01=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Sun, Dec 10, 2023 at 6:26=E2=80=AFAM Mark Brown <broonie@kernel.org> w=
rote:
> >
> > On Wed, Dec 06, 2023 at 02:36:59AM -0800, Suren Baghdasaryan wrote:
> > > Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> > > into destination buffer while checking the contents of both after
> > > the move. After the operation the content of the destination buffer
> > > should match the original source buffer's content while the source
> > > buffer should be zeroed. Separate tests are designed for PMD aligned =
and
> > > unaligned cases because they utilize different code paths in the kern=
el.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  tools/testing/selftests/mm/uffd-common.c     |  24 +++
> > >  tools/testing/selftests/mm/uffd-common.h     |   1 +
> > >  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++=
++
> > >  3 files changed, 214 insertions(+)
> >
> > This breaks the build in at least some configurations with separate
> > output directories like those used by KernelCI:
> >
> > make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgc=
c CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnuea=
bihf- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/k=
ci/linux -j10 kselftest-gen_tar
> >
> > (full logs for both arm64 and x86_64 at):
> >
> >    https://storage.kernelci.org/next/master/next-20231208/arm64/defconf=
ig/gcc-10/logs/kselftest.log
> >    https://storage.kernelci.org/next/master/next-20231208/x86_64/x86_64=
_defconfig/clang-17/logs/kselftest.log
> >
> > or tuxmake:
> >
> > make --silent --keep-going --jobs=3D16 O=3D/home/broonie/.cache/tuxmake=
/builds/25/build INSTALL_PATH=3D/home/broonie/.cache/tuxmake/builds/25/buil=
d/kselftest_install ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_C=
OMPILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install
> >
> > The specific failure:
> >
> > aarch64-linux-gnu-gcc -Wall -I /tmp/kci/linux/tools/testing/selftests/.=
./../..  -isystem /tmp/kci/linux/build/usr/include     uffd-stress.c vm_uti=
l.c uffd-common.c -lrt -lpthread -lm -o /tmp/kci/linux/build/kselftest/mm/u=
ffd-stress
> > uffd-common.c: In function =E2=80=98move_page=E2=80=99:
> > uffd-common.c:636:21: error: storage size of =E2=80=98uffdio_move=E2=80=
=99 isn=E2=80=99t known
> >   636 |  struct uffdio_move uffdio_move;
> >       |                     ^~~~~~~~~~~
> > uffd-common.c:643:21: error: =E2=80=98UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES=
=E2=80=99 undeclared (first use in this function)
> >   643 |  uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> >       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > uffd-common.c:643:21: note: each undeclared identifier is reported only=
 once for each function it appears in
> > uffd-common.c:645:17: error: =E2=80=98UFFDIO_MOVE=E2=80=99 undeclared (=
first use in this function); did you mean =E2=80=98UFFDIO_COPY=E2=80=99?
> >   645 |  if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> >       |                 ^~~~~~~~~~~
> >       |                 UFFDIO_COPY
> > uffd-common.c:636:21: warning: unused variable =E2=80=98uffdio_move=E2=
=80=99 [-Wunused-variable]
> >   636 |  struct uffdio_move uffdio_move;
> >       |                     ^~~~~~~~~~~
>
> Thanks for reporting! I'll try that later today.
> Just to clarify, are you using mm-unstable and if so, has it been
> rebased since Friday? There was an update to this patchset in
> mm-unstable which Andrew merged on Friday and the failure does look
> like something that would happen with the previous version.

I tried reproducing the issue but so far unsuccessfully. Could you
please confirm that on the latest mm-unstable branch it's still
reproducible and if so, please provide detailed instructions on how
you reproduce it.
Thanks,
Suren.

