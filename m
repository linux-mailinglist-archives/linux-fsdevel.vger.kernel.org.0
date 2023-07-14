Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C53753003
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 05:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbjGNDen (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 23:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjGNDel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:34:41 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EDF26B3
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:34:40 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-57012b2973eso13144317b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689305679; x=1691897679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNSV9sJ7VDoQqUmBWFGfGPjEeP6VzROq+N2D2OG90a8=;
        b=CJSz/v2OvucDaeedtIOHN866WoFPjMXQ+2bWAPU1GJQQtXO1jTRJ4f+6M9WV3vvmaj
         yTY6qSioNI573ldQ1N7L0Ops/chCRMzNDZAc2vzD1Nh3L1BGz30Fu9Rc9AmbKidVSjG/
         S8Hbb2Vf/iUQO4b1AGxo3oS3UaavT3OyNZJX6iZrzzYHAeiB5tCvRihjTxLKwQ1mPuzx
         eyIx9CaEBp0M/db6jiEBDTC+4kMbNE7FHDKikXhVuuldNxrVniAyRdDw6ZlyDzDm9B13
         7DIVHo7fQjE2l/JgXj9itGMiNEFoaXte1w0vDLsdJTBJfBhWT4BI6dMeAwVAdjjOtZER
         eENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689305679; x=1691897679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNSV9sJ7VDoQqUmBWFGfGPjEeP6VzROq+N2D2OG90a8=;
        b=MYenBj8AWulCuuayVmWlHvBpyO2vnj73EDgCSZ6tM+rofXp+1QHQ6D49vMq0+M5L7L
         hWrxoYl2s8LKKmkp2fDBMm6D6sgULQo9kGQc4wdaemCI+z8brN68aBY6WGiRTwgY+rfl
         CIAvj9iwHIvcOC4wLCc8DZXwyWlDAB7hwODlE5rNeoYeZbhvnWVjbwFyWMGOvtmSRGPB
         BGTzg/+Nvoaql+VLvmfDTEEj4V/BtZ864Xkt9b2K0er6Uux9VpKdZi2lq09uDbSWjmv1
         k5Kvm5Uf6rDuVIWNyD3SpcGVRPCYW7MTDk9QkDGfoZOno4DaaVkiprYd0uNZ/bajQWSz
         bVnA==
X-Gm-Message-State: ABy/qLa+wrapJzWwhvYIU/PNYOgDDDOiP0eCojoJdTUNnXm+dr6QaZ9z
        2pwbzDuUvo5DJpEaXyp8joXRF2I4hfgajCVfn2txMg==
X-Google-Smtp-Source: APBJJlH6ggQ1z2uZjbDn69bx0fUBrHLjibeyEHhiaiY4fkLEDN1cMozzO0FizzTrFvOQ3EEd2evamTIwdLnGBkqKoOI=
X-Received: by 2002:a0d:db94:0:b0:573:6e25:4dae with SMTP id
 d142-20020a0ddb94000000b005736e254daemr3520107ywe.4.1689305679003; Thu, 13
 Jul 2023 20:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230711202047.3818697-1-willy@infradead.org> <20230711202047.3818697-9-willy@infradead.org>
In-Reply-To: <20230711202047.3818697-9-willy@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 13 Jul 2023 20:34:28 -0700
Message-ID: <CAJuCfpGPQgiLehu9WNk0Q0vLTE2eCxcg+tjyes4KqbF2iAWz3A@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] mm: Remove CONFIG_PER_VMA_LOCK ifdefs
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:21=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Provide lock_vma_under_rcu() when CONFIG_PER_VMA_LOCK is not defined
> to eliminate ifdefs in the users.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Very nice. Thanks!

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  arch/arm64/mm/fault.c   | 2 --
>  arch/powerpc/mm/fault.c | 4 ----
>  arch/riscv/mm/fault.c   | 4 ----
>  arch/s390/mm/fault.c    | 2 --
>  arch/x86/mm/fault.c     | 4 ----
>  include/linux/mm.h      | 6 ++++++
>  6 files changed, 6 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index b8c80f7b8a5f..2e5d1e238af9 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -587,7 +587,6 @@ static int __kprobes do_page_fault(unsigned long far,=
 unsigned long esr,
>
>         perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
>
> -#ifdef CONFIG_PER_VMA_LOCK
>         if (!(mm_flags & FAULT_FLAG_USER))
>                 goto lock_mmap;
>
> @@ -616,7 +615,6 @@ static int __kprobes do_page_fault(unsigned long far,=
 unsigned long esr,
>                 return 0;
>         }
>  lock_mmap:
> -#endif /* CONFIG_PER_VMA_LOCK */
>
>  retry:
>         vma =3D lock_mm_and_find_vma(mm, addr, regs);
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 82954d0e6906..b1723094d464 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -469,7 +469,6 @@ static int ___do_page_fault(struct pt_regs *regs, uns=
igned long address,
>         if (is_exec)
>                 flags |=3D FAULT_FLAG_INSTRUCTION;
>
> -#ifdef CONFIG_PER_VMA_LOCK
>         if (!(flags & FAULT_FLAG_USER))
>                 goto lock_mmap;
>
> @@ -502,7 +501,6 @@ static int ___do_page_fault(struct pt_regs *regs, uns=
igned long address,
>                 return user_mode(regs) ? 0 : SIGBUS;
>
>  lock_mmap:
> -#endif /* CONFIG_PER_VMA_LOCK */
>
>         /* When running in the kernel we expect faults to occur only to
>          * addresses in user space.  All other faults represent errors in=
 the
> @@ -552,9 +550,7 @@ static int ___do_page_fault(struct pt_regs *regs, uns=
igned long address,
>
>         mmap_read_unlock(current->mm);
>
> -#ifdef CONFIG_PER_VMA_LOCK
>  done:
> -#endif
>         if (unlikely(fault & VM_FAULT_ERROR))
>                 return mm_fault_error(regs, address, fault);
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 6ea2cce4cc17..046732fcb48c 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -283,7 +283,6 @@ void handle_page_fault(struct pt_regs *regs)
>                 flags |=3D FAULT_FLAG_WRITE;
>         else if (cause =3D=3D EXC_INST_PAGE_FAULT)
>                 flags |=3D FAULT_FLAG_INSTRUCTION;
> -#ifdef CONFIG_PER_VMA_LOCK
>         if (!(flags & FAULT_FLAG_USER))
>                 goto lock_mmap;
>
> @@ -311,7 +310,6 @@ void handle_page_fault(struct pt_regs *regs)
>                 return;
>         }
>  lock_mmap:
> -#endif /* CONFIG_PER_VMA_LOCK */
>
>  retry:
>         vma =3D lock_mm_and_find_vma(mm, addr, regs);
> @@ -368,9 +366,7 @@ void handle_page_fault(struct pt_regs *regs)
>
>         mmap_read_unlock(mm);
>
> -#ifdef CONFIG_PER_VMA_LOCK
>  done:
> -#endif
>         if (unlikely(fault & VM_FAULT_ERROR)) {
>                 tsk->thread.bad_cause =3D cause;
>                 mm_fault_error(regs, addr, fault);
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 40a71063949b..ac8351f172bb 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -407,7 +407,6 @@ static inline vm_fault_t do_exception(struct pt_regs =
*regs, int access)
>                 access =3D VM_WRITE;
>         if (access =3D=3D VM_WRITE)
>                 flags |=3D FAULT_FLAG_WRITE;
> -#ifdef CONFIG_PER_VMA_LOCK
>         if (!(flags & FAULT_FLAG_USER))
>                 goto lock_mmap;
>         vma =3D lock_vma_under_rcu(mm, address);
> @@ -431,7 +430,6 @@ static inline vm_fault_t do_exception(struct pt_regs =
*regs, int access)
>                 goto out;
>         }
>  lock_mmap:
> -#endif /* CONFIG_PER_VMA_LOCK */
>         mmap_read_lock(mm);
>
>         gmap =3D NULL;
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index b0f7add07aa5..ab778eac1952 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1350,7 +1350,6 @@ void do_user_addr_fault(struct pt_regs *regs,
>         }
>  #endif
>
> -#ifdef CONFIG_PER_VMA_LOCK
>         if (!(flags & FAULT_FLAG_USER))
>                 goto lock_mmap;
>
> @@ -1381,7 +1380,6 @@ void do_user_addr_fault(struct pt_regs *regs,
>                 return;
>         }
>  lock_mmap:
> -#endif /* CONFIG_PER_VMA_LOCK */
>
>  retry:
>         vma =3D lock_mm_and_find_vma(mm, address, regs);
> @@ -1441,9 +1439,7 @@ void do_user_addr_fault(struct pt_regs *regs,
>         }
>
>         mmap_read_unlock(mm);
> -#ifdef CONFIG_PER_VMA_LOCK
>  done:
> -#endif
>         if (likely(!(fault & VM_FAULT_ERROR)))
>                 return;
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 46c442855df7..3c923a4bf213 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -813,6 +813,12 @@ static inline void assert_fault_locked(struct vm_fau=
lt *vmf)
>         mmap_assert_locked(vmf->vma->vm_mm);
>  }
>
> +static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_struct=
 *mm,
> +               unsigned long address)
> +{
> +       return NULL;
> +}
> +
>  #endif /* CONFIG_PER_VMA_LOCK */
>
>  /*
> --
> 2.39.2
>
