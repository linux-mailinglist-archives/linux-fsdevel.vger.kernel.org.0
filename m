Return-Path: <linux-fsdevel+bounces-6582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7551819E8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 13:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41EEE1F27909
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Dec 2023 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5FF21A1B;
	Wed, 20 Dec 2023 12:00:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56C219F0;
	Wed, 20 Dec 2023 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5e7d306ee27so13612007b3.3;
        Wed, 20 Dec 2023 04:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073600; x=1703678400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNnwzy6tQcqeaUcHOAS+iDzjbl/FPbSmBUr6dHQRpC8=;
        b=piJ96NXzYfXTmimWx1GYq9dhBhWpkyQ7NEFLNj4Xxcvv0h3aMO3+C9bKuP/pAFJYeq
         TJJUFnqlOSdA5FR70bFBNZvW+VdCgvggIKQh2grK0FdsoPVhVPbIaPPYxW29myuJZ+YR
         ox4Hb34VV+m35jRTpya/w3ovIV36s492Cx9O3n/twHKLgJVZY707b47TpWYwyCJk4Enp
         f6GjA4sI2gMDGNUdRck06OopaMIq+xQcT1RGoYxt3TUuEDtnYe2IDUxHLwX7Kpk3tdCv
         MidPvxJt7cEdT8UnBUoJ6bAIrGpgNtCTFV12f4CGrQGh4/8Cn3AD/MVVK7BP268p0RdH
         JThA==
X-Gm-Message-State: AOJu0YxNfwaxu/4Y5Wl2K8Kt9/ppHQdRoY0Mc9T+ze6gDXVjT6is9gGr
	77AXvGk7kwqfkolXJtuMReCssj5AQrwHHw==
X-Google-Smtp-Source: AGHT+IGolHcYMOl7VlA/5CSLMdFvbzyToLQ9pw09LrGFhBv0V4smZJ5B8dP2L84dWfkCaRw1FVA9Wg==
X-Received: by 2002:a81:df0b:0:b0:5d7:545e:3bd3 with SMTP id c11-20020a81df0b000000b005d7545e3bd3mr14364772ywn.25.1703073600256;
        Wed, 20 Dec 2023 04:00:00 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id q130-20020a815c88000000b00582b239674esm10576002ywb.129.2023.12.20.03.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:59:59 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5e7d306ee27so13611867b3.3;
        Wed, 20 Dec 2023 03:59:59 -0800 (PST)
X-Received: by 2002:a0d:d845:0:b0:5e7:f47d:7f94 with SMTP id
 a66-20020a0dd845000000b005e7f47d7f94mr1778813ywe.9.1703073598971; Wed, 20 Dec
 2023 03:59:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev> <20231216033552.3553579-7-kent.overstreet@linux.dev>
In-Reply-To: <20231216033552.3553579-7-kent.overstreet@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Dec 2023 12:59:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW29dAQh+j3s4Af1kMAFKSr2yz7M2L-fWd1uZfL7mEY1Q@mail.gmail.com>
Message-ID: <CAMuHMdW29dAQh+j3s4Af1kMAFKSr2yz7M2L-fWd1uZfL7mEY1Q@mail.gmail.com>
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

On Sat, Dec 16, 2023 at 4:39=E2=80=AFAM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> by moving cond_resched_rcu() to rcupdate.h, we can kill another big
> sched.h dependency.
>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>

Thanks for your patch, which is now commit dc00f26faea81dc0 ("Kill
sched.h dependency on rcupdate.h") in next-20231220.

Reported-by: noreply@ellerman.id.au

$ make ARCH=3Dm68k defconfig arch/m68k/kernel/asm-offsets.i
*** Default configuration is based on 'multi_defconfig'
#
# No change to .config
#
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CC      arch/m68k/kernel/asm-offsets.s
In file included from ./include/asm-generic/bug.h:7,
                 from ./arch/m68k/include/asm/bug.h:32,
                 from ./include/linux/bug.h:5,
                 from ./include/linux/thread_info.h:13,
                 from ./arch/m68k/include/asm/processor.h:11,
                 from ./include/linux/sched.h:13,
                 from arch/m68k/kernel/asm-offsets.c:15:
./arch/m68k/include/asm/processor.h: In function =E2=80=98set_fc=E2=80=99:
./arch/m68k/include/asm/processor.h:91:15: error: implicit declaration
of function =E2=80=98in_interrupt=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
   91 |  WARN_ON_ONCE(in_interrupt());
      |               ^~~~~~~~~~~~
./include/linux/once_lite.h:28:27: note: in definition of macro
=E2=80=98DO_ONCE_LITE_IF=E2=80=99
   28 |   bool __ret_do_once =3D !!(condition);   \
      |                           ^~~~~~~~~
./arch/m68k/include/asm/processor.h:91:2: note: in expansion of macro
=E2=80=98WARN_ON_ONCE=E2=80=99
   91 |  WARN_ON_ONCE(in_interrupt());
      |  ^~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:116:
arch/m68k/kernel/asm-offsets.s] Error 1
make[2]: *** [Makefile:1191: prepare0] Error 2
make[1]: *** [Makefile:350: __build_one_by_one] Error 2
make: *** [Makefile:234: __sub-make] Error 2

> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -1058,4 +1058,15 @@ extern int rcu_normal;
>
>  DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
>
> +#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
> +#define cond_resched_rcu()             \
> +do {                                   \
> +       rcu_read_unlock();              \
> +       cond_resched();                 \
> +       rcu_read_lock();                \
> +} while (0)
> +#else
> +#define cond_resched_rcu()
> +#endif
> +
>  #endif /* __LINUX_RCUPDATE_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index d528057c99e4..b781ac7e0a02 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -10,8 +10,11 @@
>  #include <uapi/linux/sched.h>
>
>  #include <asm/current.h>
> +#include <linux/thread_info.h>
> +#include <linux/preempt.h>
>
>  #include <linux/irqflags_types.h>
> +#include <linux/smp_types.h>
>  #include <linux/pid_types.h>
>  #include <linux/sem_types.h>
>  #include <linux/shm.h>
> @@ -22,7 +25,6 @@
>  #include <linux/timer_types.h>
>  #include <linux/seccomp_types.h>
>  #include <linux/nodemask_types.h>
> -#include <linux/rcupdate.h>
>  #include <linux/refcount_types.h>
>  #include <linux/resource.h>
>  #include <linux/latencytop.h>
> @@ -2058,15 +2060,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *l=
ock);
>         __cond_resched_rwlock_write(lock);                               =
       \
>  })
>
> -static inline void cond_resched_rcu(void)
> -{
> -#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
> -       rcu_read_unlock();
> -       cond_resched();
> -       rcu_read_lock();
> -#endif
> -}
> -
>  #ifdef CONFIG_PREEMPT_DYNAMIC
>
>  extern bool preempt_model_none(void);

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

