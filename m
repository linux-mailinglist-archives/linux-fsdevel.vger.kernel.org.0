Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2FC72CEAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 20:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjFLSpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 14:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjFLSot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:44:49 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AB410F5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:44:45 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-55a35e2a430so2689339eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686595485; x=1689187485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLSvKncaUgXX5sMVjgHiwvAyzgL2miMkV5TwRmL7eWs=;
        b=5Y4Vy2iismoAzZRhbru/V2dPtaEpSrjSWGAfWTaV/GCVgdTzE3uEYmWLtkAw83XnbU
         +w8KNafozBU6IE2VJ2xTusRtqZEYg5sPtWP9cRbzBxArC7cGXYVRD6XYTGQ6s5sEBHCw
         +sUusni7pX503tgT/34wEX1EtJtAGRxpI/m2DnVA/nXxgYJNaUWbmM0eDG2An8aq70td
         Kz6eDZ2DGLuBVm5y0DeUHhHJHAUU5Z8J1gZByNQ3zDilNMNn1asZLjd4UWbON/IxayMv
         z8BH/H+TXzGcm95HEHXW5Bs7LmwIOUCJRvd64FNrbT3Snso8giytf+Fs0svKVrb7Iq7+
         GSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686595485; x=1689187485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gLSvKncaUgXX5sMVjgHiwvAyzgL2miMkV5TwRmL7eWs=;
        b=SJDF00G8TQMNvxTyyIzWapujxbTfRU32UrM4x+PYta1mPQQBtzV2DKy/TLLdKnM0dM
         /mXL5K/alNLQPi0js6np7et5waALNtwffySGaAVtTlGw41h2dPigcWP4TPn01U3NP1zc
         9Le1P5YgAVlLndGZGOhliwf0PP/26uyky6CmRvLcYhTD9iNNgkohCfOhsZ1Xlx3ojK/j
         5u417I0hCb1iKCHGSfIOmBqhAKLSNIJF19wc2LEjKUBc9kJw1dwU57T2MCTVJoVfor0+
         hc4nWBRNyLMlb93r7WH9RrLl0yklLXUva3IoESzPp9PwZyz1prCPonv4Ti4jtoOZlXwe
         PS2w==
X-Gm-Message-State: AC+VfDz/Wlm7hM6Zs1U1yTbBBBbmrTkRJ2YywpvzYcvnJKewPOpBAgd/
        7mxXGKkgvG4vLoxuPegN+/spto1rjzti947sgSDEXA==
X-Google-Smtp-Source: ACHHUZ7GdKM3fdCF0BbRZ7LDjfdKukE+hxCwPT2UJ9z/E0fZdGEJitZ6xGzwak0ybXCSfMcrn6FPBI3A9bGC7wYAIZc=
X-Received: by 2002:a05:6358:c603:b0:12b:e390:2b5f with SMTP id
 fd3-20020a056358c60300b0012be3902b5fmr1677492rwb.6.1686595484442; Mon, 12 Jun
 2023 11:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n> <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
 <CAJuCfpG3PrbGxpDAEkyGQXW88+otb=FsbrhPJ4ePN7Xhn0a+_A@mail.gmail.com>
 <ZIcfYQ1c5teMSHAX@x1n> <CAJuCfpGZvhBUdfNHojXwqZbspuhy0bstjT+-JMfwgmnqTnkoHA@mail.gmail.com>
 <ZIdlNj+X2HDwfCeN@x1n>
In-Reply-To: <ZIdlNj+X2HDwfCeN@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jun 2023 11:44:33 -0700
Message-ID: <CAJuCfpH6tO8yo8YkUWWiLnkDUR0csdYyqVnuyGC+A-g3N_rKug@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:34=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote=
:
>
> On Mon, Jun 12, 2023 at 09:07:38AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Jun 12, 2023 at 6:36=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > On Fri, Jun 09, 2023 at 06:29:43PM -0700, Suren Baghdasaryan wrote:
> > > > On Fri, Jun 9, 2023 at 3:30=E2=80=AFPM Suren Baghdasaryan <surenb@g=
oogle.com> wrote:
> > > > >
> > > > > On Fri, Jun 9, 2023 at 1:42=E2=80=AFPM Peter Xu <peterx@redhat.co=
m> wrote:
> > > > > >
> > > > > > On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wr=
ote:
> > > > > > > migration_entry_wait does not need VMA lock, therefore it can=
 be dropped
> > > > > > > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate t=
hat VMA
> > > > > > > lock was dropped while in handle_mm_fault().
> > > > > > > Note that once VMA lock is dropped, the VMA reference can't b=
e used as
> > > > > > > there are no guarantees it was not freed.
> > > > > >
> > > > > > Then vma lock behaves differently from mmap read lock, am I rig=
ht?  Can we
> > > > > > still make them match on behaviors, or there's reason not to do=
 so?
> > > > >
> > > > > I think we could match their behavior by also dropping mmap_lock =
here
> > > > > when fault is handled under mmap_lock (!(fault->flags &
> > > > > FAULT_FLAG_VMA_LOCK)).
> > > > > I missed the fact that VM_FAULT_COMPLETED can be used to skip dro=
pping
> > > > > mmap_lock in do_page_fault(), so indeed, I might be able to use
> > > > > VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as=
 well
> > > > > instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your=
 idea
> > > > > of reusing existing flags?
> > > > Sorry, I meant VM_FAULT_VMA_UNLOCKED, not FAULT_FLAG_VMA_LOCK in th=
e
> > > > above reply.
> > > >
> > > > I took a closer look into using VM_FAULT_COMPLETED instead of
> > > > VM_FAULT_VMA_UNLOCKED but when we fall back from per-vma lock to
> > > > mmap_lock we need to retry with an indication that the per-vma lock
> > > > was dropped. Returning (VM_FAULT_RETRY | VM_FAULT_COMPLETE) to
> > > > indicate such state seems strange to me ("retry" and "complete" see=
m
> > >
> > > Not relevant to this migration patch, but for the whole idea I was th=
inking
> > > whether it should just work if we simply:
> > >
> > >         fault =3D handle_mm_fault(vma, address, flags | FAULT_FLAG_VM=
A_LOCK, regs);
> > > -       vma_end_read(vma);
> > > +       if (!(fault & (VM_FAULT_RETRY | VM_FAULT_COMPLETED)))
> > > +               vma_end_read(vma);
> > >
> > > ?
> >
> > Today when we can't handle a page fault under per-vma locks we return
> > VM_FAULT_RETRY, in which case per-vma lock is dropped and the fault is
>
> Oh I see what I missed.  I think it may not be a good idea to reuse
> VM_FAULT_RETRY just for that, because it makes VM_FAULT_RETRY even more
> complicated - now it adds one more case where the lock is not released,
> that's when PER_VMA even if !NOWAIT.
>
> > retried under mmap_lock. The condition you suggest above would not
> > drop per-vma lock for VM_FAULT_RETRY case and would break the current
> > fallback mechanism.
> > However your suggestion gave me an idea. I could indicate that per-vma
> > lock got dropped using vmf structure (like Matthew suggested before)
> > and once handle_pte_fault(vmf) returns I could check if it returned
> > VM_FAULT_RETRY but per-vma lock is still held.
> > If that happens I can
> > call vma_end_read() before returning from __handle_mm_fault(). That
> > way any time handle_mm_fault() returns VM_FAULT_RETRY per-vma lock
> > will be already released, so your condition in do_page_fault() will
> > work correctly. That would eliminate the need for a new
> > VM_FAULT_VMA_UNLOCKED flag. WDYT?
>
> Sounds good.
>
> So probably that's the major pain for now with the legacy fallback (I'll
> have commented if I noticed it with the initial vma lock support..).  I
> assume that'll go away as long as we recover the VM_FAULT_RETRY semantics
> to before.

I think so. With that change getting VM_FAULT_RETRY in do_page_fault()
will guarantee that per-vma lock was dropped. Is that what you mean?

>
> --
> Peter Xu
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
