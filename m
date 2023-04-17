Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F346E5569
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 01:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDQXuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 19:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDQXuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 19:50:19 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117DB40DD
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 16:50:16 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m14so10274608ybk.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681775416; x=1684367416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRJVk9iTqF9ZMo+FBIJvmLJ+0S2Q+JphhYoPlNaNuHk=;
        b=cRP1IaZ7CCCnalk2jelsP6PlAwmUUsE2BGcSOLlfrKrF8KlbuRh5J17ssUOUJnlJb2
         9y78mSCGwduh/mM34CTLDKk3VtAO+U6IUByPmlsk92pV5AqS3B7HqazW3e2AZnuBJhWL
         FOP1ZLiOUnhuJNPvWyQWVA9fX044WQDJs1g2jHG/ERFOC20YD1rYu3SZR8vggfVBRwKp
         KaQSuNWduBJYWVX21XShMqTD6SU1TCN7O5lNCyzptpPH2hDmgoX7GHlbCShUrZK+G/JX
         NhbI69NeyhZQ8ZDLPxQbxL/y1+8sK0zqtn86Rdjm2KMcI826zMKpvilMzmfTo4xhxI8A
         pfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681775416; x=1684367416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRJVk9iTqF9ZMo+FBIJvmLJ+0S2Q+JphhYoPlNaNuHk=;
        b=D3TDmfXAe15pYVRweTr3rGFJKda8UVlZd3vPhPwTlesGxLNN58YvQioyV4lt/gUmGG
         +Z1zyME2+bn0iRIKcMja6uA0VIMkAi2mjROJuVdAVuo1peIsaZdNkH1vSO/ChmK998bY
         zqDF9NCKgqJbRbyao2+EseB/XRgGvRDFp3Jyur9vU51Lvj2EmicUQ/vZYSbduoPFtIpQ
         4RGjk5FPCPoQlUPMpJ9WkD+wNPw187THAIcuyXjr4kj/j/0jGdETFoeDBaDPMdnYzdjP
         TNLrOUwMlrd02YQXLOkXDKFV/ccjVb0pe3Q9419C7JcVi1M3sSAvE2EsftgGdEAMtUsa
         dDzw==
X-Gm-Message-State: AAQBX9dtY5i/PxC94VapIPLJWIYQaOf/noEo7Br742mG8/RWWdcW3gAN
        z4NHDUpaWMvdOFnD8kR98XRRzatEjoLQnZMtionq2Q==
X-Google-Smtp-Source: AKy350bH9xayjiSzs5VyslCJKTV1f5j6eXdbbOobtR3saaXoTC6nZ8ojkx/1icFSJ15bt29Rn/08ipRCZm8YDTP/4LY=
X-Received: by 2002:a25:7411:0:b0:b8f:6d23:3c7a with SMTP id
 p17-20020a257411000000b00b8f6d233c7amr8506924ybc.12.1681775415705; Mon, 17
 Apr 2023 16:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230414180043.1839745-1-surenb@google.com> <ZDmetaUdmlEz/W8Q@casper.infradead.org>
 <87sfczuxkc.fsf@nvidia.com> <CAJuCfpEV1OiM423bykYQTxDC1=bQAqhAwd5fiKYifsk=seP6yw@mail.gmail.com>
 <877cuaulrm.fsf@nvidia.com>
In-Reply-To: <877cuaulrm.fsf@nvidia.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 17 Apr 2023 16:50:04 -0700
Message-ID: <CAJuCfpFEwdnpTXGRpKtXaZ+F4RW4+DkxaRRTiBVy4jE9cG=TEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle swap page faults if the faulting page can
 be locked
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Mon, Apr 17, 2023 at 4:33=E2=80=AFPM Alistair Popple <apopple@nvidia.com=
> wrote:
>
>
> Suren Baghdasaryan <surenb@google.com> writes:
>
> > On Sun, Apr 16, 2023 at 6:06=E2=80=AFPM Alistair Popple <apopple@nvidia=
.com> wrote:
> >>
> >>
> >> Matthew Wilcox <willy@infradead.org> writes:
> >>
> >> > On Fri, Apr 14, 2023 at 11:00:43AM -0700, Suren Baghdasaryan wrote:
> >> >> When page fault is handled under VMA lock protection, all swap page
> >> >> faults are retried with mmap_lock because folio_lock_or_retry
> >> >> implementation has to drop and reacquire mmap_lock if folio could
> >> >> not be immediately locked.
> >> >> Instead of retrying all swapped page faults, retry only when folio
> >> >> locking fails.
> >> >
> >> > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> >
> >> > Let's just review what can now be handled under the VMA lock instead=
 of
> >> > the mmap_lock, in case somebody knows better than me that it's not s=
afe.
> >> >
> >> >  - We can call migration_entry_wait().  This will wait for PG_locked=
 to
> >> >    become clear (in migration_entry_wait_on_locked()).  As previousl=
y
> >> >    discussed offline, I think this is safe to do while holding the V=
MA
> >> >    locked.
> >>
> >> Do we even need to be holding the VMA locked while in
> >> migration_entry_wait()? My understanding is we're just waiting for
> >> PG_locked to be cleared so we can return with a reasonable chance the
> >> migration entry is gone. If for example it has been unmapped or
> >> protections downgraded we will simply refault.
> >
> > If we drop VMA lock before migration_entry_wait() then we would need
> > to lock_vma_under_rcu again after the wait. In which case it might be
> > simpler to retry the fault with some special return code to indicate
> > that VMA lock is not held anymore and we want to retry without taking
> > mmap_lock. I think it's similar to the last options Matthew suggested
> > earlier. In which case we can reuse the same retry mechanism for both
> > cases, here and in __folio_lock_or_retry.
>
> Good point. Agree there is no reason to re-take the VMA lock after the
> wait, although in this case we shouldn't need to retry the fault
> (ie. return VM_FAULT_RETRY). Just skip calling vma_end_read() on the way
> out to userspace.

Actually, __collapse_huge_page_swapin() which calls do_swap_page() can
use VMA reference again inside its loop unless we return
VM_FAULT_RETRY or VM_FAULT_ERROR. That is not safe since we dropped
the VMA lock and stability of the VMA is not guaranteed at that point.
So, we do need to return VM_FAULT_RETRY maybe with another bit
indicating that retry does not need to fallback to mmap_lock. Smth
like "return VM_FAULT_RETRY | VM_FAULT_USE_VMA_LOCK".

>
> >>
> >> >  - We can call remove_device_exclusive_entry().  That calls
> >> >    folio_lock_or_retry(), which will fail if it can't get the VMA lo=
ck.
> >>
> >> Looks ok to me.
> >>
> >> >  - We can call pgmap->ops->migrate_to_ram().  Perhaps somebody famil=
iar
> >> >    with Nouveau and amdkfd could comment on how safe this is?
> >>
> >> Currently this won't work because drives assume mmap_lock is held duri=
ng
> >> pgmap->ops->migrate_to_ram(). Primarily this is because
> >> migrate_vma_setup()/migrate_vma_pages() is used to handle the fault an=
d
> >> that asserts mmap_lock is taken in walk_page_range() and also
> >> migrate_vma_insert_page().
> >>
> >> So I don't think we can call that case without mmap_lock.
> >>
> >> At a glance it seems it should be relatively easy to move to using
> >> lock_vma_under_rcu(). Drivers will need updating as well though becaus=
e
> >> migrate_vma_setup() is called outside of fault handling paths so drive=
rs
> >> will currently take mmap_lock rather than vma lock when looking up the
> >> vma. See for example nouveau_svmm_bind().
> >
> > Thanks for the pointers, Alistair! It does look like we need to be
> > more careful with the migrate_to_ram() path. For now I can fallback to
> > retrying with mmap_lock for this case, like with do with all cases
> > today. Afterwards this path can be made ready for working under VMA
> > lock and we can remove that retry. Does that sound good?
>
> Sounds good to me. Fixing that shouldn't be too difficult but will need
> changes to at least Nouveau and amdkfd (and hmm-tests obviously). Happy
> to look at doing that if/when this change makes it in. Thanks.
>
> >>
> >> >  - I believe we can't call handle_pte_marker() because we exclude UF=
FD
> >> >    VMAs earlier.
> >> >  - We can call swap_readpage() if we allocate a new folio.  I haven'=
t
> >> >    traced through all this code to tell if it's OK.
> >> >
> >> > So ... I believe this is all OK, but we're definitely now willing to
> >> > wait for I/O from the swap device while holding the VMA lock when we
> >> > weren't before.  And maybe we should make a bigger deal of it in the
> >> > changelog.
> >> >
> >> > And maybe we shouldn't just be failing the folio_lock_or_retry(),
> >> > maybe we should be waiting for the folio lock with the VMA locked.
> >>
>
