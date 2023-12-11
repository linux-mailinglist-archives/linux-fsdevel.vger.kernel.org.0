Return-Path: <linux-fsdevel+bounces-5446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECED80BEA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 02:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B653280C1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 01:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505C7497;
	Mon, 11 Dec 2023 01:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGszbrQZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBA1D0
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 17:01:30 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5d6b9143782so33383057b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 17:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702256490; x=1702861290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WQ5Kl/17KRmeDrnv++dZDxabOnVYumyCPRm9UvxCXU=;
        b=CGszbrQZZo2UCe6PlQD4gAXjJ6qCOyzZzZiOMfcKbnwIVtAtl7+lMEVe1mLEgrxjDQ
         TjuNKqbl/wAOsYI23Km0x16ku0uUFNt4H7UWwUyN3FLNNegggc8cT1rD4kFAvohqDpDL
         e6Os2k9wwDBEUStdcYfvby4H7Bn1WnBuYANZSOM+Wm925d524zoJU/bHc1SqP6yh55mo
         9nollJXpVf4GS0wxNcNZ64AyLmsTB4dhTMJ6g+ECQzHd77yRLmH/EH4qCzCE2ZB/WOoC
         3afxWDajYOi7DbpngLTG+NSV30ABNajhUBT3+HsM0CgRXwbjxKUCbYWhwxHJ9gXDRz4r
         46VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702256490; x=1702861290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WQ5Kl/17KRmeDrnv++dZDxabOnVYumyCPRm9UvxCXU=;
        b=DPSjDIdrTFCYF2Wx5JP0ZkhpFANAmy+Yaora12+rCE2CXDA3+23KCDT3eoWFkR/9e8
         4uETrhkrfnzkVcQcIUDCNNmFKFz6KMO36L+RN8M9tMfOqjZQzQozjKQgGoBiRc5z/2kX
         uP1ILOCvqnGz3nB5iJMgZ5EtTy/LxioCTNnAdwUiG4UqB+SBOodi+WkOBMFuwRHa+nEI
         aDdJujhPmoL4/b4aQHGmJqp6l1k8Pr9r2vT0OjT01S+xGJVhE1EAphtLYWAgMtT1qsqs
         M4E3lcZ7WdkXA1n6iXuGFyPQ3+LXzsTnWH/aGZqTVXsq7fGFnXYSGJKonXNobcdLkcwO
         fw3Q==
X-Gm-Message-State: AOJu0YwmD2l7nfkk41RYr++baF+eTc1WFEVjwSqHrOfWo4ZtVokhl1S/
	h79luWRaT2uTS0jtDwVrW8YWqWm35o8IUjTRAf2geg==
X-Google-Smtp-Source: AGHT+IEM06+RRlE/zePs7rbDQZUekYGXrzSDuMym2bE5wBVkl63IhZGe5nggAE5d9SV6vVL4ZhYg6AITCoRBwCXDwDI=
X-Received: by 2002:a0d:f9c6:0:b0:5d7:1940:7d92 with SMTP id
 j189-20020a0df9c6000000b005d719407d92mr2245546ywf.105.1702256489515; Sun, 10
 Dec 2023 17:01:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
In-Reply-To: <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 10 Dec 2023 17:01:18 -0800
Message-ID: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
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

On Sun, Dec 10, 2023 at 6:26=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Wed, Dec 06, 2023 at 02:36:59AM -0800, Suren Baghdasaryan wrote:
> > Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
> > into destination buffer while checking the contents of both after
> > the move. After the operation the content of the destination buffer
> > should match the original source buffer's content while the source
> > buffer should be zeroed. Separate tests are designed for PMD aligned an=
d
> > unaligned cases because they utilize different code paths in the kernel=
.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  tools/testing/selftests/mm/uffd-common.c     |  24 +++
> >  tools/testing/selftests/mm/uffd-common.h     |   1 +
> >  tools/testing/selftests/mm/uffd-unit-tests.c | 189 +++++++++++++++++++
> >  3 files changed, 214 insertions(+)
>
> This breaks the build in at least some configurations with separate
> output directories like those used by KernelCI:
>
> make KBUILD_BUILD_USER=3DKernelCI FORMAT=3D.xz ARCH=3Darm64 HOSTCC=3Dgcc =
CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COMPILE_COMPAT=3Darm-linux-gnueabi=
hf- CC=3D"ccache aarch64-linux-gnu-gcc" O=3D/tmp/kci/linux/build -C/tmp/kci=
/linux -j10 kselftest-gen_tar
>
> (full logs for both arm64 and x86_64 at):
>
>    https://storage.kernelci.org/next/master/next-20231208/arm64/defconfig=
/gcc-10/logs/kselftest.log
>    https://storage.kernelci.org/next/master/next-20231208/x86_64/x86_64_d=
efconfig/clang-17/logs/kselftest.log
>
> or tuxmake:
>
> make --silent --keep-going --jobs=3D16 O=3D/home/broonie/.cache/tuxmake/b=
uilds/25/build INSTALL_PATH=3D/home/broonie/.cache/tuxmake/builds/25/build/=
kselftest_install ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- CROSS_COM=
PILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install
>
> The specific failure:
>
> aarch64-linux-gnu-gcc -Wall -I /tmp/kci/linux/tools/testing/selftests/../=
../..  -isystem /tmp/kci/linux/build/usr/include     uffd-stress.c vm_util.=
c uffd-common.c -lrt -lpthread -lm -o /tmp/kci/linux/build/kselftest/mm/uff=
d-stress
> uffd-common.c: In function =E2=80=98move_page=E2=80=99:
> uffd-common.c:636:21: error: storage size of =E2=80=98uffdio_move=E2=80=
=99 isn=E2=80=99t known
>   636 |  struct uffdio_move uffdio_move;
>       |                     ^~~~~~~~~~~
> uffd-common.c:643:21: error: =E2=80=98UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES=E2=
=80=99 undeclared (first use in this function)
>   643 |  uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> uffd-common.c:643:21: note: each undeclared identifier is reported only o=
nce for each function it appears in
> uffd-common.c:645:17: error: =E2=80=98UFFDIO_MOVE=E2=80=99 undeclared (fi=
rst use in this function); did you mean =E2=80=98UFFDIO_COPY=E2=80=99?
>   645 |  if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
>       |                 ^~~~~~~~~~~
>       |                 UFFDIO_COPY
> uffd-common.c:636:21: warning: unused variable =E2=80=98uffdio_move=E2=80=
=99 [-Wunused-variable]
>   636 |  struct uffdio_move uffdio_move;
>       |                     ^~~~~~~~~~~

Thanks for reporting! I'll try that later today.
Just to clarify, are you using mm-unstable and if so, has it been
rebased since Friday? There was an update to this patchset in
mm-unstable which Andrew merged on Friday and the failure does look
like something that would happen with the previous version.

