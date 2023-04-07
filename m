Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73B36DB6A0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Apr 2023 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjDGWlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 18:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDGWli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 18:41:38 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40E2E07B
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 15:41:12 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id i6so50292717ybu.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680907270; x=1683499270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymBhYtC7z9ypgBt5ldvEEZjcUfyBTAIyJMw7aG6sy7M=;
        b=bGGoxqFFQbRUS7GxiTztJ5wEKjUi2K/Pqyh5e41hyw0iSLKeNxU+tiuTVqes0/wgKy
         VggOgPNnT0/MvQKuQI7H3/nC2AFY+CQp1M1DVXtokamNaKfwmwQe5KM9PxrVMEcmJrXp
         Jp9d8gNPFKFaBzgNgixWqeNJsxh700MV5lad5NcLZLPGJDYzA6ugk4Rb+VMFlIIiQ180
         qj31GYZnq74+1iT8d3FhGDurwrRTtPDr+gjDTrNn+N0lmxBYn2fX8k9imx6ZRNJuyfTM
         zQ756WNP3qm+p1sNIn9B4Z+wAYH3Na1dFtZClZDJmj5a8xB/6R4qRK1c4JnUxdE/1dS2
         pzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680907270; x=1683499270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymBhYtC7z9ypgBt5ldvEEZjcUfyBTAIyJMw7aG6sy7M=;
        b=xVygZpXux9A8kFGgllkYLdrHCPmvms80w6hodjGhG0PUQG9XYYq4Cao7h0okZ9/6XJ
         to/uCccKgTZtjeMYzSgYW084/pc/KpFFhTpxMKwhMzAgpK17roMN+G7GA5zVcz/oePHA
         S0L3mJlrhknmE5A1TgFCNe5Ecg+V7Cfw++Zoz/HLe38pE8desNndDXVow4vfP1wom0qo
         YhofKIHYkBFwX7+0lu0o4TdUjndkmTS5YlNDPmOyXVI5BibeY8nhOAvlE9+R4Kuc8dmj
         1+cJUsZ9lu7nT8iNpkrZGMJtnrMe9WuElHSsR9uF0aPUCkFOm6jMjHNk+XlfhccHE8W5
         GTjA==
X-Gm-Message-State: AAQBX9eObnM0R9oVFYbyPISOaSDr35Q+uMOUAUKM0mXq8f3+02MRcIwI
        RMDBEdZwq7JhVxV3sVlFcgnZg2uWzZGFS+12Tueb7g==
X-Google-Smtp-Source: AKy350aTYlRzklvNu+FcXRnIY2yPIabbk15C/PoQAsy4KuWRicgN97axaEqbH1nM8iV5ut2pRiajDUns3y0soTiuGRA=
X-Received: by 2002:a25:76c6:0:b0:b8b:ee74:c9d4 with SMTP id
 r189-20020a2576c6000000b00b8bee74c9d4mr2700149ybc.12.1680907270211; Fri, 07
 Apr 2023 15:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230404135850.3673404-1-willy@infradead.org> <20230404135850.3673404-2-willy@infradead.org>
 <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com>
 <ZDB5OsBc3R7o489l@casper.infradead.org> <CAJuCfpGMsSRQU1Oob2HNn8PFxTx2REtiUOZfB87hYokLCBU=Bw@mail.gmail.com>
 <ZDCM8hGnqgsHyP0a@casper.infradead.org>
In-Reply-To: <ZDCM8hGnqgsHyP0a@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Apr 2023 15:40:59 -0700
Message-ID: <CAJuCfpEs=OhX4jxzVTjRr+xsK9=OyGeTudKc7y-bQQ0PKhpozA@mail.gmail.com>
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

On Fri, Apr 7, 2023 at 2:36=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Apr 07, 2023 at 01:26:08PM -0700, Suren Baghdasaryan wrote:
> > True. do_swap_page() has the same issue. Can we move these
> > count_vm_event() calls to the end of handle_mm_fault():
>
> I was going to suggest something similar, so count that as an
> Acked-by.  This will change the accounting for the current retry
> situation, where we drop the mmap_lock in filemap_fault(), initiate I/O
> and return RETRY.  I think that's probably a good change though; I don't
> see why applications should have their fault counters incremented twice
> for that situation.
>
> >        mm_account_fault(regs, address, flags, ret);
> > +out:
> > +       if (ret !=3D VM_FAULT_RETRY) {
> > +              count_vm_event(PGFAULT);
> > +              count_memcg_event_mm(vma->vm_mm, PGFAULT);
> > +       }
>
> Nit: this is a bitmask, so we should probably have:
>
>         if (!(ret & VM_FAULT_RETRY)) {
>
> in case somebody's ORed it with VM_FAULT_MAJOR or something.
>
> Hm, I wonder if we're handling that correctly; if we need to start I/O,
> do we preserve VM_FAULT_MAJOR returned from the first attempt?  Not
> in a position where I can look at the code right now.

Interesting question. IIUC mm_account_fault() is the place where
VM_FAULT_MAJOR is used to perform minor/major fault accounting.
However it has an early exit:

        /*
         * We don't do accounting for some specific faults:
         *
         * - Unsuccessful faults (e.g. when the address wasn't valid).  Tha=
t
         *   includes arch_vma_access_permitted() failing before reaching h=
ere.
         *   So this is not a "this many hardware page faults" counter.  We
         *   should use the hw profiling for that.
         *
         * - Incomplete faults (VM_FAULT_RETRY).  They will only be counted
         *   once they're completed.
         */
        if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
                return;

So, VM_FAULT_RETRY is ignored in the accounting path.
For the current do_swap_page (the only user returning VM_FAULT_RETRY
this late) it's fine because we did not really do anything. However
with your series and with my current attempts to drop the vma lock, do
swapin_readahead() and return VM_FAULT_RETRY the situation changes. We
need to register such (VM_FAULT_MAJOR | VM_FAULT_RETRY) case as a
major fault, otherwise after retry it will be accounted as only a
minor fault. Accounting the retry as a minor fault after the original
major fault is technically also double-counting but probably not as
big of a problem as missing the major fault accounting.
