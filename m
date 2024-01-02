Return-Path: <linux-fsdevel+bounces-7084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC89821B1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 12:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D886F1F2165B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E5FBFC;
	Tue,  2 Jan 2024 11:39:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B8BFBEC;
	Tue,  2 Jan 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5f254d1a6daso9553087b3.2;
        Tue, 02 Jan 2024 03:39:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704195576; x=1704800376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFi8eMSPsfOFqOHCg4hwloMdrYmzNBUBfM1xQ0dKIbA=;
        b=PwoKqi6lndOXSnMN02Wi4fOxWcxCNJjQ/tjc/HDCcpJepMUf1FdEAZvL2Z/tX2sMjK
         z5rLDYH9MwbMUPLmOwctgzyiPdBL/4YDa3vlYYQ5o+W3EBiUvN7bF5rD9zaroNTfpSL1
         GgtVnMIAqcc9pavEmH84MhIL8TtGpoBLbIvy7kUi7qjb81v/qXlTO/ofcsCkgF3GZ+7i
         owV7srOaHO8c+cKkPsvSlKiJ+m2ChMr7R+hnOZO+hFstxrM7t4xBE7uUqzv/jT1fYN9E
         HnuwTGZOabFiTuKkrUmEoS4Dbxs9IwSD9J+bQpfff+ZYmZ0BDeasycWzfMgNB+CdiysF
         FBlw==
X-Gm-Message-State: AOJu0YyJfMuQcc0pSe3pDq/hJouxW8y7dXlXWFzrRiJz3svGGyKbChr6
	GzWUV8VthhqsoMjqw5H5DMRisjxNx1bwxw==
X-Google-Smtp-Source: AGHT+IGXq1AARTnEfk2PH5xz+CvZUSKTjqgCiCyt+CEGGi4Gik9hnPXj5+RYuZc1mkpEjUxkoFtTBw==
X-Received: by 2002:a81:5784:0:b0:5ee:7d0f:4458 with SMTP id l126-20020a815784000000b005ee7d0f4458mr4336249ywb.56.1704195576581;
        Tue, 02 Jan 2024 03:39:36 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id k28-20020a81ac1c000000b005ee999d3941sm5957031ywh.26.2024.01.02.03.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 03:39:35 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbdacafe012so5830521276.1;
        Tue, 02 Jan 2024 03:39:35 -0800 (PST)
X-Received: by 2002:a05:6902:e08:b0:da0:5370:fdce with SMTP id
 df8-20020a0569020e0800b00da05370fdcemr9471148ybb.19.1704195574941; Tue, 02
 Jan 2024 03:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev> <20231216033552.3553579-7-kent.overstreet@linux.dev>
 <CAMuHMdW29dAQh+j3s4Af1kMAFKSr2yz7M2L-fWd1uZfL7mEY1Q@mail.gmail.com> <20231220213957.zbslehrx4zkkbabq@moria.home.lan>
In-Reply-To: <20231220213957.zbslehrx4zkkbabq@moria.home.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 12:39:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXsxh23cv-m3G+_9GxXy9wN5vJDp8C0x43KMLEQXy5SDg@mail.gmail.com>
Message-ID: <CAMuHMdXsxh23cv-m3G+_9GxXy9wN5vJDp8C0x43KMLEQXy5SDg@mail.gmail.com>
Subject: Re: [PATCH 50/50] Kill sched.h dependency on rcupdate.h
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

On Wed, Dec 20, 2023 at 10:40=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Wed, Dec 20, 2023 at 12:59:44PM +0100, Geert Uytterhoeven wrote:
> > On Sat, Dec 16, 2023 at 4:39=E2=80=AFAM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > by moving cond_resched_rcu() to rcupdate.h, we can kill another big
> > > sched.h dependency.
> > >
> > > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> >
> > Thanks for your patch, which is now commit dc00f26faea81dc0 ("Kill
> > sched.h dependency on rcupdate.h") in next-20231220.
> >
> > Reported-by: noreply@ellerman.id.au
> >
> > $ make ARCH=3Dm68k defconfig arch/m68k/kernel/asm-offsets.i
> > *** Default configuration is based on 'multi_defconfig'
> > #
> > # No change to .config
> > #
> >   UPD     include/config/kernel.release
> >   UPD     include/generated/utsrelease.h
> >   CC      arch/m68k/kernel/asm-offsets.s
> > In file included from ./include/asm-generic/bug.h:7,
> >                  from ./arch/m68k/include/asm/bug.h:32,
> >                  from ./include/linux/bug.h:5,
> >                  from ./include/linux/thread_info.h:13,
> >                  from ./arch/m68k/include/asm/processor.h:11,
> >                  from ./include/linux/sched.h:13,
> >                  from arch/m68k/kernel/asm-offsets.c:15:
> > ./arch/m68k/include/asm/processor.h: In function =E2=80=98set_fc=E2=80=
=99:
> > ./arch/m68k/include/asm/processor.h:91:15: error: implicit declaration
> > of function =E2=80=98in_interrupt=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> >    91 |  WARN_ON_ONCE(in_interrupt());
> >       |               ^~~~~~~~~~~~
> > ./include/linux/once_lite.h:28:27: note: in definition of macro
> > =E2=80=98DO_ONCE_LITE_IF=E2=80=99
> >    28 |   bool __ret_do_once =3D !!(condition);   \
> >       |                           ^~~~~~~~~
> > ./arch/m68k/include/asm/processor.h:91:2: note: in expansion of macro
> > =E2=80=98WARN_ON_ONCE=E2=80=99
> >    91 |  WARN_ON_ONCE(in_interrupt());
> >       |  ^~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> > make[3]: *** [scripts/Makefile.build:116:
> > arch/m68k/kernel/asm-offsets.s] Error 1
> > make[2]: *** [Makefile:1191: prepare0] Error 2
> > make[1]: *** [Makefile:350: __build_one_by_one] Error 2
> > make: *** [Makefile:234: __sub-make] Error 2
>
> Applying this fix:
>
> commit 0d7bdfe9726b275c7e9398047763a144c790b575
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Wed Dec 20 16:39:21 2023 -0500
>
>     m68k: Fix missing include
>
>     Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

LGTM.
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

