Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5B72CAFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFLQHx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjFLQHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:07:52 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B00B184
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 09:07:51 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so8039437276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686586070; x=1689178070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQi6jtfU5Lynaf+sn5nkLvTDsBxdvtzSQejpmjCr2Yk=;
        b=ldreut73mQ7n/9Rvm35cqn0sTfKZnyPz57sJzkjPKlUTacxjPpUB5qkwnYpLz04nWi
         etFQJKZhaKM8I3MOmegKu7fthVQ/JMQuXCm6jC38J9kuoI/EMC3pMvYK+vY9AR2Ql5Xa
         2dlFgBYdbZf7n2dEgfiM9BGZ2Tpj4YP/zi0kGVstPMQMpehVlj50D1EdTzepJ62GTwup
         FW7M5iNYbJHM0V6JmYakSx4GA32k7dqw2SItmTaCXruIDP1rVcX9geye6IGVemMdhv2O
         6NNRFtmxfN2FO6ThSPmu98Sg0XT9rAhG+dD5vcE3CDKtgx9wopSLfGr6RrhBAUJAG4uw
         wXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586070; x=1689178070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WQi6jtfU5Lynaf+sn5nkLvTDsBxdvtzSQejpmjCr2Yk=;
        b=dfTo4cZ8lApk2blIRtEGXt8Kkk33chgeoJOpW4ww5eC2WKH+LstuLTd3UEYryYzjp/
         JRLYnfEJx2369abx96C03I9JmHMzG9XaQsL1wqec6y6SzfnI4ojHW4Dyj33CBHI9ttZk
         uIzMi9mSTHqTCkKlBDaZ1ynxWEbnF+ggYDzB/PPLjA/cW20b8e0ItLPN00qujgoflnee
         qhqQsDcyFJTC6i4Iul9EvVpXRhiEk4aVRm3JWvpn7PTPbOJ7wkiiOf79028Vdd6pHl/Z
         SRNesmoY4ELizHApI9uwpBr0HVfppyqSZ7gK6y1t3xs5plQPk+7zge6149Dky/aBheC2
         eZmA==
X-Gm-Message-State: AC+VfDynREBgSCXzchHYepZDp8o4a8X7BuPfDEfbLjw7Uw3fHkNbKktU
        krm3SngWH81IuVFzBt9J39UAuxxndQG+0YnipHHxnw==
X-Google-Smtp-Source: ACHHUZ474Hgkm1DqxTKXCEkmV8DS7fOJrZgwzR9YLV3SLZ9qbXmX0kgeF+jqhDiNpwtfbLybFp7wetScHd2KnZPaMEw=
X-Received: by 2002:a5b:a06:0:b0:bb1:76ca:d1f9 with SMTP id
 k6-20020a5b0a06000000b00bb176cad1f9mr11770295ybq.20.1686586070336; Mon, 12
 Jun 2023 09:07:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n> <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
 <CAJuCfpG3PrbGxpDAEkyGQXW88+otb=FsbrhPJ4ePN7Xhn0a+_A@mail.gmail.com> <ZIcfYQ1c5teMSHAX@x1n>
In-Reply-To: <ZIcfYQ1c5teMSHAX@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jun 2023 09:07:38 -0700
Message-ID: <CAJuCfpGZvhBUdfNHojXwqZbspuhy0bstjT+-JMfwgmnqTnkoHA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: drop VMA lock before waiting for migration
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 6:36=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jun 09, 2023 at 06:29:43PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > On Fri, Jun 9, 2023 at 1:42=E2=80=AFPM Peter Xu <peterx@redhat.com> w=
rote:
> > > >
> > > > On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> > > > > migration_entry_wait does not need VMA lock, therefore it can be =
dropped
> > > > > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that =
VMA
> > > > > lock was dropped while in handle_mm_fault().
> > > > > Note that once VMA lock is dropped, the VMA reference can't be us=
ed as
> > > > > there are no guarantees it was not freed.
> > > >
> > > > Then vma lock behaves differently from mmap read lock, am I right? =
 Can we
> > > > still make them match on behaviors, or there's reason not to do so?
> > >
> > > I think we could match their behavior by also dropping mmap_lock here
> > > when fault is handled under mmap_lock (!(fault->flags &
> > > FAULT_FLAG_VMA_LOCK)).
> > > I missed the fact that VM_FAULT_COMPLETED can be used to skip droppin=
g
> > > mmap_lock in do_page_fault(), so indeed, I might be able to use
> > > VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as wel=
l
> > > instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your ide=
a
> > > of reusing existing flags?
> > Sorry, I meant VM_FAULT_VMA_UNLOCKED, not FAULT_FLAG_VMA_LOCK in the
> > above reply.
> >
> > I took a closer look into using VM_FAULT_COMPLETED instead of
> > VM_FAULT_VMA_UNLOCKED but when we fall back from per-vma lock to
> > mmap_lock we need to retry with an indication that the per-vma lock
> > was dropped. Returning (VM_FAULT_RETRY | VM_FAULT_COMPLETE) to
> > indicate such state seems strange to me ("retry" and "complete" seem
>
> Not relevant to this migration patch, but for the whole idea I was thinki=
ng
> whether it should just work if we simply:
>
>         fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VMA_LO=
CK, regs);
> -       vma_end_read(vma);
> +       if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> +               vma_end_read(vma);
>
> ?

Today when we can't handle a page fault under per-vma locks we return
VM_FAULT_RETRY, in which case per-vma lock is dropped and the fault is
retried under mmap_lock. The condition you suggest above would not
drop per-vma lock for VM_FAULT_RETRY case and would break the current
fallback mechanism.
However your suggestion gave me an idea. I could indicate that per-vma
lock got dropped using vmf structure (like Matthew suggested before)
and once handle_pte_fault(vmf) returns I could check if it returned
VM_FAULT_RETRY but per-vma lock is still held. If that happens I can
call vma_end_read() before returning from __handle_mm_fault(). That
way any time handle_mm_fault() returns VM_FAULT_RETRY per-vma lock
will be already released, so your condition in do_page_fault() will
work correctly. That would eliminate the need for a new
VM_FAULT_VMA_UNLOCKED flag. WDYT?

>
> GUP may need more caution on NOWAIT, but vma lock is only in fault paths =
so
> IIUC it's fine?
>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
