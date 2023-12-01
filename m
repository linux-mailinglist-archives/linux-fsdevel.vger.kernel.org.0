Return-Path: <linux-fsdevel+bounces-4593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33040801031
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 17:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1EAB20BB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CBD4D126
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR0Mv9ym"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F34BCF
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 08:27:06 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso745022276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 08:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701448025; x=1702052825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdQY2rO8kp3VX8kHp5yrzZMNN707JWDTWQPo3xyvnp8=;
        b=RR0Mv9ymrym2ni/1mvWkg9VapYsH/92smUvcMiwz8B1ekokVYGtVC36HRbwV6m3eEH
         fSALy95idxbo/3jpAr/HlIHtNCOwZmu4OhzJM9p5mPIrOQmi7bwduFAxAzZvPocvXqvd
         BDVrpZhgTerv6XGO0CCL9WzwxPI8gh1r18ylAlWvg9XQ2wcymSk5fMaV8eMatXiHx3K8
         hg3pss+Qm2MRgdyEZbrCPa1ssvaMPmizbIqMcgxWvWIHuyYyctDAV3T/AV/1b+WqIMLP
         M2XTC8cq9ZYwXQNh11yP/tLPKjBh5WNauAjf4QJlcW1jfhHEAUkqW+bOTDWVhAwS0w0Y
         wKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448025; x=1702052825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdQY2rO8kp3VX8kHp5yrzZMNN707JWDTWQPo3xyvnp8=;
        b=eSdwC1At/5IsjOPDWHomN7BHqbcp2bol+RndpfRdsCxR4e+Lul2LzNq9ZC3P/poACG
         o0/zBrZHEk4RY5N+SHv+CaYIN9FdnGzI43NckivENA5Ods+tiVyLE/VFltkFTmLHyMHK
         ewNR7MCR1k+BF7kYT4TwiXNn5h2N3lZDsc42Mu6dSHPBejkR1mq/euwrQ5lhZYqVdrz+
         rlqQDq4Ko/yJnn90v/XQ7oGbPBuu6hN1Hf4EcNwa+9D2+cUyXMlClF0wcjIyAdLBhqIC
         Xy6081biJOr5sukJ4K1LOjBlPE5WaZeLvvpIEuT41gcosyn/NC3k9v/t1NOi9HMqCNqs
         gXkg==
X-Gm-Message-State: AOJu0YxYuoUs1+1W4myOfvxsfLJcPbdToPPVPGOGNjIzvGhB4BCpsobn
	NNmsUSGWBLQPg26gQoqUn2nCqZhLZP3Vfi6l31I9+A==
X-Google-Smtp-Source: AGHT+IEom/S4gZpVn1oYHJmGvaqqrg1rL1XCWGsO98iZ+FbjMDZpHCZVbMQBZZO7cGiucq3ZSmPfizY6/7p5S2bZcqQ=
X-Received: by 2002:a25:244d:0:b0:da0:c49a:5fdf with SMTP id
 k74-20020a25244d000000b00da0c49a5fdfmr22604397ybk.7.1701448024871; Fri, 01
 Dec 2023 08:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121171643.3719880-1-surenb@google.com> <20231121171643.3719880-6-surenb@google.com>
 <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
In-Reply-To: <b3c882d2-0135-430c-8179-784f78be0902@arm.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 1 Dec 2023 08:26:51 -0800
Message-ID: <CAJuCfpH8-jsxBRiLeLGWOFYnFE2iuSPfsveZkRf=MYZ6d=G7QA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	shuah@kernel.org, aarcange@redhat.com, lokeshgidra@google.com, 
	peterx@redhat.com, david@redhat.com, hughd@google.com, mhocko@suse.com, 
	axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org, 
	Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com, 
	bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com, 
	jdduke@google.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 1:29=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 21/11/2023 17:16, Suren Baghdasaryan wrote:
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
> >
> > diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/s=
elftests/mm/uffd-common.c
> > index fb3bbc77fd00..b0ac0ec2356d 100644
> > --- a/tools/testing/selftests/mm/uffd-common.c
> > +++ b/tools/testing/selftests/mm/uffd-common.c
> > @@ -631,6 +631,30 @@ int copy_page(int ufd, unsigned long offset, bool =
wp)
> >       return __copy_page(ufd, offset, false, wp);
> >  }
> >
> > +int move_page(int ufd, unsigned long offset, unsigned long len)
> > +{
> > +     struct uffdio_move uffdio_move;
> > +
> > +     if (offset + len > nr_pages * page_size)
> > +             err("unexpected offset %lu and length %lu\n", offset, len=
);
> > +     uffdio_move.dst =3D (unsigned long) area_dst + offset;
> > +     uffdio_move.src =3D (unsigned long) area_src + offset;
> > +     uffdio_move.len =3D len;
> > +     uffdio_move.mode =3D UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
> > +     uffdio_move.move =3D 0;
> > +     if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
> > +             /* real retval in uffdio_move.move */
> > +             if (uffdio_move.move !=3D -EEXIST)
> > +                     err("UFFDIO_MOVE error: %"PRId64,
> > +                         (int64_t)uffdio_move.move);
>
> Hi Suren,
>
> FYI this error is triggering in mm-unstable (715b67adf4c8):
>
> Testing move-pmd on anon... ERROR: UFFDIO_MOVE error: -16 (errno=3D16,
> @uffd-common.c:648)
>
> I'm running in a VM on Apple M2 (arm64). I haven't debugged any further, =
but
> happy to go deeper if you can direct.

Hi Ryan,
Thanks for reporting! Could you please share your kernel config file?

There are several places UFFDIO_MOVE returns EBUSY: 4 places in
move_pages_huge_pmd(), 2 places in move_present_pte(), 2 places in
move_pages_pte() and once in move_swap_pte(). While I'm trying to
reproduce, it would be useful if you could check which place is
triggering the error.
Thanks,
Suren.

>
> Thanks,
> Ryan
>
>
> > +             wake_range(ufd, uffdio_move.dst, len);
> > +     } else if (uffdio_move.move !=3D len) {
> > +             err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.mo=
ve);
> > +     } else
> > +             return 1;
> > +     return 0;
> > +}
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

