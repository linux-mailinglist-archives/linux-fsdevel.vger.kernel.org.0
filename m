Return-Path: <linux-fsdevel+bounces-6581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28545819E80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 12:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6DC1C228E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2395721A1F;
	Wed, 20 Dec 2023 11:54:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DB219FE;
	Wed, 20 Dec 2023 11:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dbcfd61bd0fso545200276.1;
        Wed, 20 Dec 2023 03:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073242; x=1703678042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRd6E3ZRamqxe4Uwdjw8iwxCl/2bY0Td/Eb0RJLZ5RU=;
        b=HO9h1PpDLxTB4LrPk2ilTebp21Ql2KgzooTMK4rYKC5vDIWuMYvrPzZGE0CrKRWseG
         1BhVPPhHLA2708CxLLyKn3HnOVSIh4k2gw5zPavMQAF7FnoTMm8Z2yWqHxz5Y/Dn8+gD
         Ugx7Xeq7NDV9KMG4+mqsogT7k3wxV0iLfGK/Z8X1fys7HJOnG0Ue1E2f6KwuF9CxeLMJ
         Ki9o5Q92+0mx8rsNiPoJkZR5FwfG/eacg/phHMgKczWEk59RBhSvsS/d8qCeTY9ZSxkF
         awT4i1NXnQh15F9SIc8oLZIhw6aCAOlBlLpNSyM0pXMgr0dm3D9DUGv8LAOzbYBQksT7
         sS+g==
X-Gm-Message-State: AOJu0YzO1Kzb2/FzW698/5mZTcIAeuXcmRTUYIfuqEW9zvMVT2b265V/
	PMfc542zUqBpPyqicD3/T545iue0L1E9qg==
X-Google-Smtp-Source: AGHT+IG2+9HSKbcU0LyUVrTpo/CqSc5Xzz0L8a2fA+DxybBjzES8oEXYXrEslRObw0Kci8U4k2iuYg==
X-Received: by 2002:a25:4183:0:b0:dbd:5bb6:ff49 with SMTP id o125-20020a254183000000b00dbd5bb6ff49mr1431371yba.61.1703073242128;
        Wed, 20 Dec 2023 03:54:02 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id g196-20020a25dbcd000000b00dbd0d4cca6bsm3589684ybf.58.2023.12.20.03.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:54:01 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5e7415df4d6so5415677b3.0;
        Wed, 20 Dec 2023 03:54:01 -0800 (PST)
X-Received: by 2002:a0d:e747:0:b0:5d8:212:8483 with SMTP id
 q68-20020a0de747000000b005d802128483mr2237190ywe.20.1703073241008; Wed, 20
 Dec 2023 03:54:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033300.3553457-1-kent.overstreet@linux.dev> <20231216033300.3553457-10-kent.overstreet@linux.dev>
In-Reply-To: <20231216033300.3553457-10-kent.overstreet@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Dec 2023 12:53:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVRDQQmeO0ggyW-O+de45abyktwYH3ZFF1=mqd2iQXE1Q@mail.gmail.com>
Message-ID: <CAMuHMdVRDQQmeO0ggyW-O+de45abyktwYH3ZFF1=mqd2iQXE1Q@mail.gmail.com>
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

On Sat, Dec 16, 2023 at 4:37=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> More sched.h dependency pruning.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Thanks for your patch, which is now commit eb72d60ccaed883a ("sem:
Split out sem_types.h") in next-20231220.

$ make ARCH=3Dm68k defconfig arch/m68k/kernel/asm-offsets.i
*** Default configuration is based on 'multi_defconfig'
#
# No change to .config
#
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CC      arch/m68k/kernel/asm-offsets.s
In file included from arch/m68k/kernel/asm-offsets.c:15:
./include/linux/sched.h:551:3: error: conflicting types for
=E2=80=98____cacheline_aligned=E2=80=99
  551 | } ____cacheline_aligned;
      |   ^~~~~~~~~~~~~~~~~~~~~
./include/linux/sched.h:509:3: note: previous declaration of
=E2=80=98____cacheline_aligned=E2=80=99 was here
  509 | } ____cacheline_aligned;
      |   ^~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:116:
arch/m68k/kernel/asm-offsets.s] Error 1
make[2]: *** [Makefile:1191: prepare0] Error 2
make[1]: *** [Makefile:350: __build_one_by_one] Error 2
make: *** [Makefile:234: __sub-make] Error 2

> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -400,6 +400,7 @@ static inline void audit_ptrace(struct task_struct *t=
)
>  }
>
>                                 /* Private API (for audit.c only) */
> +struct kern_ipc_perm;
>  extern void __audit_ipc_obj(struct kern_ipc_perm *ipcp);
>  extern void __audit_ipc_set_perm(unsigned long qbytes, uid_t uid, gid_t =
gid, umode_t mode);
>  extern void __audit_bprm(struct linux_binprm *bprm);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 157e7af36bb7..98885e3a81e8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -13,12 +13,13 @@
>
>  #include <linux/irqflags_types.h>
>  #include <linux/pid_types.h>
> -#include <linux/sem.h>
> +#include <linux/sem_types.h>
>  #include <linux/shm.h>
>  #include <linux/kmsan_types.h>
>  #include <linux/mutex_types.h>
>  #include <linux/plist_types.h>
>  #include <linux/hrtimer_types.h>
> +#include <linux/timer_types.h>
>  #include <linux/seccomp_types.h>
>  #include <linux/nodemask_types.h>
>  #include <linux/rcupdate.h>
> diff --git a/include/linux/sem.h b/include/linux/sem.h
> index 5608a500c43e..c4deefe42aeb 100644
> --- a/include/linux/sem.h
> +++ b/include/linux/sem.h
> @@ -3,25 +3,17 @@
>  #define _LINUX_SEM_H
>
>  #include <uapi/linux/sem.h>
> +#include <linux/sem_types.h>
>
>  struct task_struct;
> -struct sem_undo_list;
>
>  #ifdef CONFIG_SYSVIPC
>
> -struct sysv_sem {
> -       struct sem_undo_list *undo_list;
> -};
> -
>  extern int copy_semundo(unsigned long clone_flags, struct task_struct *t=
sk);
>  extern void exit_sem(struct task_struct *tsk);
>
>  #else
>
> -struct sysv_sem {
> -       /* empty */
> -};
> -
>  static inline int copy_semundo(unsigned long clone_flags, struct task_st=
ruct *tsk)
>  {
>         return 0;
> diff --git a/include/linux/sem_types.h b/include/linux/sem_types.h
> new file mode 100644
> index 000000000000..73df1971a7ae
> --- /dev/null
> +++ b/include/linux/sem_types.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SEM_TYPES_H
> +#define _LINUX_SEM_TYPES_H
> +
> +struct sem_undo_list;
> +
> +struct sysv_sem {
> +#ifdef CONFIG_SYSVIPC
> +       struct sem_undo_list *undo_list;
> +#endif
> +};
> +
> +#endif /* _LINUX_SEM_TYPES_H */
>
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

