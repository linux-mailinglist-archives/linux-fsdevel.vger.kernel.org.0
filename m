Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554A372CA75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238270AbjFLPlv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbjFLPlu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:41:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD9C10D3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 08:41:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-bc4ed01b5d4so1303363276.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686584508; x=1689176508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbcWWy6lgJlv49u77NIuToLcJ7w9+T3qZB5UWslqyxQ=;
        b=A41ks5sFHka57K4fqfE86JUZi8sVGCoTPYI5ynNaLuhHWaVD5wnyI5E/THeG9ezv9h
         hFUN9NeXdSmdLTfV6cU6RhW6ixeXdJmtNq2y0OhafeE0g900sSc3BM37utl2iCvyu3pS
         xxfgQmQbYso5DjWghSSS8E/l89+tAaOV68U9KiGP2g9j1jE4hB6T8R6++UPP4RumZMV8
         LAmAF8KoJr8GavbZrW2RE1zZc3QKRPJhjcCzs5R0EgwiMcU56m0L3HM4XYn+eViUJpyI
         8vqYxeegj//ny6HzAJhC8KTZYUOxcFLk2OUJoaoVW3wydskZ3x20ve8D1Xwk+AB12dwu
         q0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584508; x=1689176508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbcWWy6lgJlv49u77NIuToLcJ7w9+T3qZB5UWslqyxQ=;
        b=P57u+rzBWIx4jucQCPou/GEhFt0VvCbVAadnH0Cdi/jGoK+DIdMI35WCaQaNyQ0/ES
         cm3R7l7/j5gsDNE+cs7cnCz8P/D5BRP3UftZr1hw5k0MY9hqJ/Zn0MMkdfePHXrH1VKI
         /vR6jVyMY0Q0w3yZtcx8OwIcZ8h1sFR9KvzVzbD6eXL5HuHAWKrHR1D9tAJ4oUUSA14k
         Rmoungy7YZLF/TO6MwEF49+j0LZEXg+fzNDvFfYxVG6GRBrbqXKfo7if5gQJkMpwWcQA
         SSskt+45t9C3TK16A9MR5bF7z7V/tdaihmRomGn85wIEIO+rb2fecNG28d0wZ3oyy7F7
         GtJA==
X-Gm-Message-State: AC+VfDw4LtYaWTgQYocCOX2iGvXlbvqMz4FhhsS/lFQUoUDMC2V/qQPY
        CfCxtwGbWp5GmuCW1BxwwdScOLKo4h3uDf5IVqpmGA==
X-Google-Smtp-Source: ACHHUZ6i33Zt6lBAsGFhBQjcAHgEqwffZrn+lh/Sa7XfqbavLy9BGOHe+OV0wQUJlUl+nF7rG6XcZNDeJbNZHnhEQ4U=
X-Received: by 2002:a25:c744:0:b0:bc4:3e4e:12 with SMTP id w65-20020a25c744000000b00bc43e4e0012mr4781374ybe.36.1686584508078;
 Mon, 12 Jun 2023 08:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230609005158.2421285-1-surenb@google.com> <20230609005158.2421285-5-surenb@google.com>
 <ZIOOmC26qh4EXUEX@x1n> <CAJuCfpHKUjAwgWbxvJQDyEnneRD03p2M6247Q6=3-oOq_FL7zA@mail.gmail.com>
 <ZIcddoWjYlDXNKJA@x1n>
In-Reply-To: <ZIcddoWjYlDXNKJA@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 12 Jun 2023 08:41:37 -0700
Message-ID: <CAJuCfpE_1S9bXPDxz-4i2oCNwrsrP8V8q5=H4rxPtZ0kZk3cjw@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 6:28=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Jun 09, 2023 at 03:30:10PM -0700, Suren Baghdasaryan wrote:
> > On Fri, Jun 9, 2023 at 1:42=E2=80=AFPM Peter Xu <peterx@redhat.com> wro=
te:
> > >
> > > On Thu, Jun 08, 2023 at 05:51:56PM -0700, Suren Baghdasaryan wrote:
> > > > migration_entry_wait does not need VMA lock, therefore it can be dr=
opped
> > > > before waiting. Introduce VM_FAULT_VMA_UNLOCKED to indicate that VM=
A
> > > > lock was dropped while in handle_mm_fault().
> > > > Note that once VMA lock is dropped, the VMA reference can't be used=
 as
> > > > there are no guarantees it was not freed.
> > >
> > > Then vma lock behaves differently from mmap read lock, am I right?  C=
an we
> > > still make them match on behaviors, or there's reason not to do so?
> >
> > I think we could match their behavior by also dropping mmap_lock here
> > when fault is handled under mmap_lock (!(fault->flags &
> > FAULT_FLAG_VMA_LOCK)).
> > I missed the fact that VM_FAULT_COMPLETED can be used to skip dropping
> > mmap_lock in do_page_fault(), so indeed, I might be able to use
> > VM_FAULT_COMPLETED to skip vma_end_read(vma) for per-vma locks as well
> > instead of introducing FAULT_FLAG_VMA_LOCK. I think that was your idea
> > of reusing existing flags?
>
> Yes.
>
> I'd suggest we move this patch out of the series as it's not really part =
of
> it on enabling swap + uffd.  It can be a separate patch and hopefully it'=
ll
> always change both vma+mmap lock cases, and with proper reasonings.

Ok, I can move it out with mmap_lock support only and then add per-vma
lock support in my patchset (because this path is still part of
do_swap_page and my patchset enables swap support for per-vma locks).

>
> Thanks,
>
> --
> Peter Xu
>
