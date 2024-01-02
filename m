Return-Path: <linux-fsdevel+bounces-7069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADA821888
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 09:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08502828D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB24C8F;
	Tue,  2 Jan 2024 08:48:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD816AA7;
	Tue,  2 Jan 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ed10316e22so47449257b3.3;
        Tue, 02 Jan 2024 00:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704185284; x=1704790084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fznygzUD7eBbAPtHsNQrcNeZZd6ceLfwc79V8Fm28m4=;
        b=G1wbpQfKaHxJlHybzeWB83/NCY8tAmKqw2RCPGiyePIP/c2ySKvO89MIlgGqloQJ8M
         8WwgQZBGLPYO/GrNz9dUc+ZaGi3LAL1g3RNe3/IIjoMNOw1mIyNYcxcH4sYOYddv/Cmi
         YCahPQZFj2RQHniGPFwcqaiCqcxK155zA37Yugj/cLmoXTOR+1mIL/tzrLURIaGKA0Ev
         Ce9cLUCleelEga5ksm4+ZwWQjfxbPReaHbhi1KXVuKfGOWKR9dVpS7Hldf8kyRUPhoYb
         IifKZLqYg0q2SjVT783WdoAICDCBWZET9oC90kVkkpenJTEEMBuQV5bXNsEpm6OzirQ2
         SGWA==
X-Gm-Message-State: AOJu0YxNF+nRyZ+k2l9ohL41cl39wwMm6P8d/xcje+3zT6wugRRQqC27
	ONE9XKDrABkGKcBCm/HY2XJF13S3HBSzSw==
X-Google-Smtp-Source: AGHT+IEes6m6y0dkBIa+RP4EnHgfQsn76oC0iu4atlmk8tIV8aQVUBmIDSkOVVNNwgDoMjGfRDWLZg==
X-Received: by 2002:a05:6902:1b0d:b0:dbd:55d1:3d63 with SMTP id eh13-20020a0569021b0d00b00dbd55d13d63mr7557109ybb.129.1704185284149;
        Tue, 02 Jan 2024 00:48:04 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00dbdb2966f67sm9991260ybj.24.2024.01.02.00.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 00:48:03 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5e745891a69so74043937b3.2;
        Tue, 02 Jan 2024 00:48:03 -0800 (PST)
X-Received: by 2002:a81:5b46:0:b0:5d8:d93:f02f with SMTP id
 p67-20020a815b46000000b005d80d93f02fmr10057429ywb.87.1704185282827; Tue, 02
 Jan 2024 00:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev> <20231216033300.3553457-10-kent.overstreet@linux.dev>
 <CAMuHMdVRDQQmeO0ggyW-O+de45abyktwYH3ZFF1=mqd2iQXE1Q@mail.gmail.com> <20231220213913.gptbcbpwb4q3prtf@moria.home.lan>
In-Reply-To: <20231220213913.gptbcbpwb4q3prtf@moria.home.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 09:47:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWrwqOEmZ=v3Fou5OgcBxzPrP01hycV6PVN3EP3FHuocQ@mail.gmail.com>
Message-ID: <CAMuHMdWrwqOEmZ=v3Fou5OgcBxzPrP01hycV6PVN3EP3FHuocQ@mail.gmail.com>
Subject: Re: [PATCH 42/50] sem: Split out sem_types.h
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, tglx@linutronix.de, x86@kernel.org, 
	tj@kernel.org, peterz@infradead.org, mathieu.desnoyers@efficios.com, 
	paulmck@kernel.org, keescook@chromium.org, dave.hansen@linux.intel.com, 
	mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Wed, Dec 20, 2023 at 10:39=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Wed, Dec 20, 2023 at 12:53:46PM +0100, Geert Uytterhoeven wrote:
> > On Sat, Dec 16, 2023 at 4:37=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > More sched.h dependency pruning.
> > >
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > Thanks for your patch, which is now commit eb72d60ccaed883a ("sem:
> > Split out sem_types.h") in next-20231220.
> >
> > $ make ARCH=3Dm68k defconfig arch/m68k/kernel/asm-offsets.i
> > *** Default configuration is based on 'multi_defconfig'
> > #
> > # No change to .config
> > #
> >   UPD     include/config/kernel.release
> >   UPD     include/generated/utsrelease.h
> >   CC      arch/m68k/kernel/asm-offsets.s
> > In file included from arch/m68k/kernel/asm-offsets.c:15:
> > ./include/linux/sched.h:551:3: error: conflicting types for
> > =E2=80=98____cacheline_aligned=E2=80=99
> >   551 | } ____cacheline_aligned;
> >       |   ^~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/sched.h:509:3: note: previous declaration of
> > =E2=80=98____cacheline_aligned=E2=80=99 was here
> >   509 | } ____cacheline_aligned;
> >       |   ^~~~~~~~~~~~~~~~~~~~~
> > make[3]: *** [scripts/Makefile.build:116:
> > arch/m68k/kernel/asm-offsets.s] Error 1
> > make[2]: *** [Makefile:1191: prepare0] Error 2
> > make[1]: *** [Makefile:350: __build_one_by_one] Error 2
> > make: *** [Makefile:234: __sub-make] Error 2
>
> Is this a build failure on linux-next, or that specific commit?

On this specific commit.

> It looks like this should be fixed in a later commit that includes
> cache.h in sched.h; I'll move that include back to this patch.

Indeed. The robots reported a build failure, and bisection arrived
at this (different) build failure first.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

