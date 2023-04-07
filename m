Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092D16DB531
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 22:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjDGU0X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjDGU0W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:26:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01439741
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Apr 2023 13:26:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id m16so29702912ybk.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Apr 2023 13:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680899180; x=1683491180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2NqYlcKqgDnAnT0HPL/Dc2jZTE5h8otlUAIYBQqrsY=;
        b=LyUFqBdHt3HstpmCxJDLHznbXkUKMQCBVOcDrhcSWGPV2clUI7KGrXj+BDzWGwX8VJ
         T1qSwzrSjwMcATdMr9urS7O90fpnG7OQt4+pt5eheWtynm6YfQznt+nwfVmVQq5ZooxI
         Y0cpernEQYYIy9/FVxuKwnoO1DCk+m+ySxhrz8ZrdDNjH7K0Vuna1hn4/BkNroieMUbU
         Bzc3z+ofVnWcsJ3E/oayf2mlS4quXK7A3Ojh6ti0Dm220Zc2a0qr8FHhdkXne/7sgFD7
         IStlkz6Ge/0zdePxZaNL0W+QPsC7W7KvSJQOn8Pot7El96JZog1IZriaCmELrexhd5s/
         LZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680899180; x=1683491180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2NqYlcKqgDnAnT0HPL/Dc2jZTE5h8otlUAIYBQqrsY=;
        b=stz2S9CKz3baVfJGE5LkR398DJeQ1Zvnqs7Rcu6O+7dUOK6KIx85VHnsPNhHXQVNwg
         VWcJodkEy7q/zb2fsenBl6OuMmXjHImsGuzxIrc63R72an3zvkjzOroTw3JmL6DKQ9Gb
         5b0ge4WQkTe+aeN5u7ECO6j5c1gkFK1HPqu0yO+5Oj4wzDdTDzRcSHvavmwwj6dksDYt
         /ppQVlkYXXTDuM0A28oqQq6OUeocAoVQ5lQCmF5ZUmNZoWkpu/Sofp/AasV0j5H0kV+E
         gsovDdyUsKE95uv9YEJi1H2cN+YqlgdV5HWm/ouNr0woyFxVxCJG06iYZ5OFgif/OViD
         MFMA==
X-Gm-Message-State: AAQBX9fblRtS2VzmHZaS2S4XTbO1es/gAEDuSQ1Zx1PUrlHhAs20lF0X
        5rqY2OOr1d1hMtJu3O1b7p/5VxCh7mrCKRb+HssmCP9jC+hPnc+eRn3dAw==
X-Google-Smtp-Source: AKy350bNRvmBvqysEH9bkgyjNJ9/qzq8pKeMuUwAjJWaQLfb2Rq1z0Gwcm8eBbXO0ndmuvmOfgiOu8GJ/Uz4cJ+Gxgs=
X-Received: by 2002:a25:d995:0:b0:b8b:f2cc:7043 with SMTP id
 q143-20020a25d995000000b00b8bf2cc7043mr132939ybg.12.1680899179760; Fri, 07
 Apr 2023 13:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230404135850.3673404-1-willy@infradead.org> <20230404135850.3673404-2-willy@infradead.org>
 <CAJuCfpGPYNerqu6EjRNX2ov4uaFOawmXf1bS_xYPX5b6BAnaWg@mail.gmail.com> <ZDB5OsBc3R7o489l@casper.infradead.org>
In-Reply-To: <ZDB5OsBc3R7o489l@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 7 Apr 2023 13:26:08 -0700
Message-ID: <CAJuCfpGMsSRQU1Oob2HNn8PFxTx2REtiUOZfB87hYokLCBU=Bw@mail.gmail.com>
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

On Fri, Apr 7, 2023 at 1:12=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Apr 07, 2023 at 10:54:00AM -0700, Suren Baghdasaryan wrote:
> > On Tue, Apr 4, 2023 at 6:59=E2=80=AFAM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > The fault path will immediately fail in handle_mm_fault(), so this
> > > is the minimal step which allows the per-VMA lock to be taken on
> > > file-backed VMAs.  There may be a small performance reduction as a
> > > little unnecessary work will be done on each page fault.  See later
> > > patches for the improvement.
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  mm/memory.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index fdaec7772fff..f726f85f0081 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5223,6 +5223,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struc=
t *vma, unsigned long address,
> > >                                             flags & FAULT_FLAG_REMOTE=
))
> > >                 return VM_FAULT_SIGSEGV;
> > >
> > > +       if ((flags & FAULT_FLAG_VMA_LOCK) && !vma_is_anonymous(vma))
> > > +               return VM_FAULT_RETRY;
> > > +
> >
> > There are count_vm_event(PGFAULT) and count_memcg_event_mm(vma->vm_mm,
> > PGFAULT) earlier in this function. Returning here and retrying I think
> > will double-count this page fault. Returning before this accounting
> > should fix this issue.
>
> You're right, but this will be an issue with later patches in the series
> anyway as we move the check further and further down the call-chain.
> For that matter, it's an issue in do_swap_page() right now, isn't it?
> I suppose we don't care too much because it's the rare case where we go
> into do_swap_page() and so the stats are "correct enough".

True. do_swap_page() has the same issue. Can we move these
count_vm_event() calls to the end of handle_mm_fault():

vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long addres=
s,
   unsigned int flags, struct pt_regs *regs)
{
       vm_fault_t ret;

       __set_current_state(TASK_RUNNING);

-       count_vm_event(PGFAULT);
-       count_memcg_event_mm(vma->vm_mm, PGFAULT);

       ret =3D sanitize_fault_flags(vma, &flags);
       if (ret)
-              return ret;
-              goto out;
       ...
       mm_account_fault(regs, address, flags, ret);
+out:
+       if (ret !=3D VM_FAULT_RETRY) {
+              count_vm_event(PGFAULT);
+              count_memcg_event_mm(vma->vm_mm, PGFAULT);
+       }

       return ret;
}

?
