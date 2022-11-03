Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9524618641
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 18:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiKCRfW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 13:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiKCRfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:35:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FA4BCB3
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Nov 2022 10:35:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d6so4017357lfs.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Nov 2022 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nbc5sLo4GtFM3+CrjPxJa3FUz65TVuj3idceDshPhx4=;
        b=Gn5IZG7BOHVOBTuMOBcjNXxPjeolIRNHRVpauV2nqG9N5UUKknJaArW6gDsufzjd0L
         gVL0m43iclxR+zBnj9MMlyKToMT+/mimOdJyztrBuRcSy7sxCwBS9lS0wATTWIORIjGW
         XvaDl8tm8xEdFZca6VSXMudYB/kz0siWXxNy/UEuwYTCqEPaDk/wKBFVr3oNcQPoSIqh
         0rmI0KUq0E4QXyAhmYIde2LLM4evQ2C2oAnx/26L4RNDXvrSZ/8WJ6gTAPXrZbe1ay9T
         Bmt5oEvcukzbI4Rezy4U5PTu3bubW4clu2rHJRwG8oCYCNzwn5SBHTyFCzchnMHyaCdU
         Q73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbc5sLo4GtFM3+CrjPxJa3FUz65TVuj3idceDshPhx4=;
        b=oBAW/C6IYUP4Yu4qcg7/HsEBItbqJEYF0A11WWdkFI3VRRat+/4bz4VQRA8o2BTFTs
         /uq0KhOo1VOH55hHYay31XYsl6yc+paG2ZSibGOAo3yCnap3W1bbPN0C+9UZVyrn+z9D
         bAIq35vjBrQI4AqBpLgqwxazI33NX5FrrUFYoNrmXqBnsEhBL73WeSweQ8bK1UT38GS1
         3BqcWs2e8AgwUeHbLqJh3aCWEBiJvH2NVr7L9vao8iZGnnI7mA940bfXG6EGtmXNxZCi
         c/8pp5aLB8bSsSMzbx28N95tRmB8dtNHn7HobHXG+R7zPJW5c63A5q7Ni+3HNWZzkdMl
         Z/cg==
X-Gm-Message-State: ACrzQf1BGHxYCA2qC8OAijKeXIcAMZwrDFszft3YqAsvYoM2FxDOZof1
        ib++rwpir8P1/rnOK72Ib15FLTNuufTOF2bmg4NJ+w==
X-Google-Smtp-Source: AMsMyM7EJNOVEGyOCeEHgo74cDzxE4T1yFulU/v18cx9x7m6GcDlFRNGIcw4cn8WGmS4u1u9Xxkff71gyckQBcqL+L4=
X-Received: by 2002:a05:6512:110f:b0:4a2:697f:c39a with SMTP id
 l15-20020a056512110f00b004a2697fc39amr11456204lfg.685.1667496916076; Thu, 03
 Nov 2022 10:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221101175326.13265-1-vishal.moola@gmail.com>
 <20221101175326.13265-4-vishal.moola@gmail.com> <Y2Fl/pZyLSw/ddZY@casper.infradead.org>
 <Y2K+y7wnhC4vbnP2@x1n> <Y2LDL8zjgxDPCzH9@casper.infradead.org> <Y2LWonzCdWkDwyyr@x1n>
In-Reply-To: <Y2LWonzCdWkDwyyr@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 3 Nov 2022 10:34:38 -0700
Message-ID: <CAJHvVcj-j6EWm5vQ74Uv1YWHbmg6-BP0hOEO2L9jRADJPEwb1A@mail.gmail.com>
Subject: Re: [PATCH 3/5] userfualtfd: Replace lru_cache functions with
 folio_add functions
To:     Peter Xu <peterx@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 2, 2022 at 1:44 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Nov 02, 2022 at 07:21:19PM +0000, Matthew Wilcox wrote:
> > On Wed, Nov 02, 2022 at 03:02:35PM -0400, Peter Xu wrote:
> > > Does the patch attached look reasonable to you?
> >
> > Mmm, no.  If the page is in the swap cache, this will be "true".
>
> It will not happen in practise, right?
>
> I mean, shmem_get_folio() should have done the swap-in, and we should have
> the page lock held at the meantime.
>
> For anon, mcopy_atomic_pte() is the only user and it's passing in a newly
> allocated page here.
>
> >
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 3d0fef3980b3..650ab6cfd5f4 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -64,7 +64,7 @@ int mfill_atomic_install_pte(struct mm_struct *dst_mm, pmd_t *dst_pmd,
> > >     pte_t _dst_pte, *dst_pte;
> > >     bool writable = dst_vma->vm_flags & VM_WRITE;
> > >     bool vm_shared = dst_vma->vm_flags & VM_SHARED;
> > > -   bool page_in_cache = page->mapping;
> > > +   bool page_in_cache = page_mapping(page);
> >
> > We could do:
> >
> >       struct page *head = compound_head(page);
> >       bool page_in_cache = head->mapping && !PageMappingFlags(head);
>
> Sounds good to me, but it just gets a bit complicated.
>
> If page_mapping() doesn't sound good, how about we just pass that over from
> callers?  We only have three, so quite doable too.

For what it's worth, I think I like Matthew's version better than the
original patch. This is because, although page_mapping() looks simpler
here, looking into the definition of page_mapping() I feel it's
handling several cases, not all of which are relevant here (or, as
Matthew points out, would actually be wrong if it were possible to
reach those cases here).

It's not clear to me what is meant by "pass that over from callers"?
Do you mean, have callers pass in true/false for page_in_cache
directly?

That could work, but I still think I prefer Matthew's version slightly
better, if only because this function already takes a lot of
arguments.

>
> --
> Peter Xu
>
