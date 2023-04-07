Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632DF6DB6A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Apr 2023 00:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDGWtU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 18:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjDGWtT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:49:19 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B197DCC00
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 15:49:18 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f188so31806726ybb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 15:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680907758; x=1683499758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdPuZQQ4H3AzErlDmV+BBGZINR5bPZXZctqmaAJukmg=;
        b=UntVN3Imy23WVr/DeHLuvS1RvTiULvHJoClMPgjmJspsC490yt4QCUMFuQYzgwnsqf
         NP1v04TiIbIhASwMC3aPSow/bEgzpSGWCzuA8byMlbqTyWkF7RFeCmszshTEldkL7pVM
         Rh+6T9GUg4eYpt0o0xQkKwQqVrC+e1oIw13hNuT35l3TqdJqFP5LZ0jwaYWdQLgJAZe7
         qlq4Yjx43ojQXbjy5g2WrFOWqWlM9FiaN1ErmCp+YhhHYvXHukiBmuMChiGxjmlytR28
         e5i+7NUCMYfWaHMNqJEzz1HT7oZjVsAkZCju7EkAemlINWVhuVWDNVmlU9FZ2LffRey8
         igtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680907758; x=1683499758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdPuZQQ4H3AzErlDmV+BBGZINR5bPZXZctqmaAJukmg=;
        b=SwrYrujF0hN7mIH5oJbWe0/weKRMIDOsh1sxIgNX+em668Bkq2wNzN8IZ/rF1a/0fI
         R3BpqTtXvTb8AFpMl7QSfx81ZJjtQ4yKgUMzxZ7ZOC0fQsINHqOki7xjXre6UybNgQX/
         e6wUQg7nvCTqxjdd59k0b+vzh0rGQ+c2Xi2d/WOP6zRMDpaha0eDnGKEu8MZI528LkKA
         a9DTFZvey+6DZJJ2a3yNQVQlPLtW42UP4xyX+OdHuDH8yew1osmmV0xpVf/rDbr+Jxpw
         kpZQOCN5I0x10oGC/FFYkKVp1rSMx8p9o9mkfKa9D2YqcMB9DEu11pAE8wIkCsk32fQM
         +ydg==
X-Gm-Message-State: AAQBX9dxnXEZqEJonHi97arl9CD0SPHnY7zbLWUsCnr27PB01UT/X7X0
        hJo9z5x22E0cpfklj/eJ5IcNxyjBNvQaTVC/ZucE2Q==
X-Google-Smtp-Source: AKy350bY08FFfaBmlYAUiiXfjX/5mTvyEHBbBr8QXElQLfK2h9swHJ7f44H7GEGjK52xXjoHZ7jtEmeXIM1Xtw22OlM=
X-Received: by 2002:a25:d711:0:b0:b7c:1144:a708 with SMTP id
 o17-20020a25d711000000b00b7c1144a708mr2606619ybg.12.1680907757737; Fri, 07
 Apr 2023 15:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230404135850.3673404-1-willy@infradead.org> <20230404135850.3673404-2-willy@infradead.org>
 <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com>
 <ZDB5OsBc3R7o489l@casper.infradead.org> <CAJuCfpGMsSRQU1Oob2HNn8PFxTx2REtiUOZfB87hYokLCBU=Bw@mail.gmail.com>
 <ZDCM8hGnqgsHyP0a@casper.infradead.org> <CAJuCfpEs=OhX4jxzVTjRr+xsK9=OyGeTudKc7y-bQQ0PKhpozA@mail.gmail.com>
In-Reply-To: <CAJuCfpEs=OhX4jxzVTjRr+xsK9=OyGeTudKc7y-bQQ0PKhpozA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Apr 2023 15:49:06 -0700
Message-ID: <CAJuCfpFXkrdkn0qcExJ3z3NZj51DSo9gyFgqrY65Mz7RhDNDSw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: Allow per-VMA locks on file-backed VMAs
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Punit Agrawal <punit.agrawal@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 7, 2023 at 3:40=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Fri, Apr 7, 2023 at 2:36=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
> >
> > On Fri, Apr 07, 2023 at 01:26:08PM -0700, Suren Baghdasaryan wrote:
> > > True. do_swap_page() has the same issue. Can we move these
> > > count_vm_event() calls to the end of handle_mm_fault():
> >
> > I was going to suggest something similar, so count that as an
> > Acked-by.  This will change the accounting for the current retry
> > situation, where we drop the mmap_lock in filemap_fault(), initiate I/O
> > and return RETRY.  I think that's probably a good change though; I don'=
t
> > see why applications should have their fault counters incremented twice
> > for that situation.
> >
> > >        mm_account_fault(regs, address, flags, ret);
> > > +out:
> > > +       if (ret !=3D VM_FAULT_RETRY) {
> > > +              count_vm_event(PGFAULT);
> > > +              count_memcg_event_mm(vma->vm_mm, PGFAULT);
> > > +       }
> >
> > Nit: this is a bitmask, so we should probably have:
> >
> >         if (!(ret & VM_FAULT_RETRY)) {
> >
> > in case somebody's ORed it with VM_FAULT_MAJOR or something.
> >
> > Hm, I wonder if we're handling that correctly; if we need to start I/O,
> > do we preserve VM_FAULT_MAJOR returned from the first attempt?  Not
> > in a position where I can look at the code right now.
>
> Interesting question. IIUC mm_account_fault() is the place where
> VM_FAULT_MAJOR is used to perform minor/major fault accounting.
> However it has an early exit:
>
>         /*
>          * We don't do accounting for some specific faults:
>          *
>          * - Unsuccessful faults (e.g. when the address wasn't valid).  T=
hat
>          *   includes arch_vma_access_permitted() failing before reaching=
 here.
>          *   So this is not a "this many hardware page faults" counter.  =
We
>          *   should use the hw profiling for that.
>          *
>          * - Incomplete faults (VM_FAULT_RETRY).  They will only be count=
ed
>          *   once they're completed.
>          */
>         if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
>                 return;
>
> So, VM_FAULT_RETRY is ignored in the accounting path.
> For the current do_swap_page (the only user returning VM_FAULT_RETRY
> this late) it's fine because we did not really do anything. However
> with your series and with my current attempts to drop the vma lock, do
> swapin_readahead() and return VM_FAULT_RETRY the situation changes. We
> need to register such (VM_FAULT_MAJOR | VM_FAULT_RETRY) case as a
> major fault, otherwise after retry it will be accounted as only a
> minor fault. Accounting the retry as a minor fault after the original
> major fault is technically also double-counting but probably not as
> big of a problem as missing the major fault accounting.

Actually, looks like in most cases where VM_FAULT_MAJOR is returned we
also do count_vm_event(PGMAJFAULT) and
count_memcg_event_mm(vma->vm_mm, PGMAJFAULT). mm_account_fault()
modifies only current->{maj|min}_flt and perf_sw_event().
