Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9D77843B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 01:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjHJXns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Aug 2023 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHJXnr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Aug 2023 19:43:47 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F280B2D44
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:43:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d6041e9e7d6so1351364276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Aug 2023 16:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691711026; x=1692315826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYoapfuK8pTLw99rw+xUNA3IK3TTjwCw9dIgQquZKAI=;
        b=OIgxJtfyPEIH7oNdCoQxuLJTp/JBss0AIVartoZwXBTBuEtNSTdFeRqLh0xujW4gxp
         nyczwlYZ9aC50jQ7e7cZN1AUwHCGAIyzsVOFUjbghPB8GWDSE6i4G9Zm1jj2aO3OboMt
         wtJYUpWa3gqgE5l3aoAeGqYTHhlsE3OnE6q5xpmEKvjTy+ZG0jatiXZQCdWluOGeQG82
         +pxA9foN+PYBHqOsT49tcJxaVaIWfJnyqEu2uZW+1SbddyKS/ELHB+PE4Hv1pod2No1w
         jiIyRDRVtzF/+6CmFq6v2PrTKH20q7AaGkvplQLpiT8P1+fZQfnr2Ob6ZLhCWPaKBLHn
         BDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691711026; x=1692315826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYoapfuK8pTLw99rw+xUNA3IK3TTjwCw9dIgQquZKAI=;
        b=kTcEkt9QL1QrBNvL/Oa6RT6VBnkANRVW3lg0fTGldW5OwSXp8l3gDZc1CI3Eta/ugJ
         YFHOqbUoneiGWwM8sHAbnKrkyyDV9Ip98jdVzl+8+G6XtAhfNLZho8ypGrbkfFb59CPj
         MDdwEJztW17VOBRUeCfNoBIYORCl0HIiKDkIdxYu43A9UgtSz33BZMIvrOedYWmn1WAA
         uhP47/pQDLjGRqoVkaDZPsuEkM5A26S/7HRaofxuRnNszSx3CML94HWlWjJKSrq9ZcT+
         MrhlVOVt2DtOpoge8y40iv+OQfTkoD1WAHTZF5OIu4kF53EJ+sKJ0+6tvhwu4P7TYhV6
         JUyA==
X-Gm-Message-State: AOJu0Yw8PdmmRvKTFHObqBJdgPhahxugZGCv/XIWTfznQVfwW+ndDOza
        I0ME5dOMVnrZCfttD/IC3YxAhE6gAHa6ScUjKoM/Hg==
X-Google-Smtp-Source: AGHT+IGI9kmESaA5shX7oi+Nu/HbsTjC2DWXvisUoNfFsAfxAHrrI4pScsS36PK8dIPgPsPtQcEKL6zJrg/ucyi5y8E=
X-Received: by 2002:a25:abab:0:b0:d3f:a6cd:f2d2 with SMTP id
 v40-20020a25abab000000b00d3fa6cdf2d2mr184241ybi.50.1691711025922; Thu, 10 Aug
 2023 16:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com> <a34a418a-9a6c-9d9a-b7a3-bde8013bf86c@redhat.com>
 <CAJuCfpGCWekMdno=L=4m7ujWTYMr0Wv77oYzXWT5RXnx+fWe0w@mail.gmail.com>
 <CAJuCfpGMvYxu-g9kVH40UDGnpF2kxctH7AazhvmwhWWq1Rn1sA@mail.gmail.com>
 <CAJuCfpHA78vxOBcaB3m7S7=CoBLMXTzRWego+jZM7JvUm3rEaQ@mail.gmail.com>
 <0ab6524a-6917-efe2-de69-f07fb5cdd9d2@redhat.com> <CAJuCfpEs2k8mHM+9uq05vmcOYCfkNnOb4s3xPSoWheizPkcwLA@mail.gmail.com>
 <CAJuCfpERuCx6QvfejUkS-ysMxbzp3mFfhCbH=rDtt2UGzbwtyg@mail.gmail.com>
 <CAJuCfpH-drRnwqUqynTnvgqSjs=_Fwc0H_7h6nzsdztRef0oKw@mail.gmail.com>
 <CAJuCfpH8ucOkCFYrVZafUAppi5+mVhy=uD+BK6-oYX=ysQv5qQ@mail.gmail.com>
 <ZNVhpeejqGkEqqSr@casper.infradead.org> <CAJuCfpG2Sc8Og+9EfeWsZ-xX+bUuEokUJe8Bvg5+dAqHtC-DfQ@mail.gmail.com>
In-Reply-To: <CAJuCfpG2Sc8Og+9EfeWsZ-xX+bUuEokUJe8Bvg5+dAqHtC-DfQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 10 Aug 2023 16:43:34 -0700
Message-ID: <CAJuCfpEdO9HLZtPx_Z-DqT65t4RQ-vzWw3Y35aWeb=vEXsijcA@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] Per-VMA lock support for swap and userfaults
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, mhocko@suse.com, josef@toxicpanda.com,
        jack@suse.cz, ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com, hdanton@sina.com,
        apopple@nvidia.com, peterx@redhat.com, ying.huang@intel.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 10, 2023 at 4:29=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Aug 10, 2023 at 3:16=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Thu, Aug 10, 2023 at 06:24:15AM +0000, Suren Baghdasaryan wrote:
> > > Ok, I think I found the issue.  wp_page_shared() ->
> > > fault_dirty_shared_page() can drop mmap_lock (see the comment saying
> > > "Drop the mmap_lock before waiting on IO, if we can...", therefore we
> > > have to ensure we are not doing this under per-VMA lock.
> >
> > ... or we could change maybe_unlock_mmap_for_io() the same way
> > that we changed folio_lock_or_retry():
> >
> > +++ b/mm/internal.h
> > @@ -706,7 +706,7 @@ static inline struct file *maybe_unlock_mmap_for_io=
(struct vm_fault *vmf,
> >         if (fault_flag_allow_retry_first(flags) &&
> >             !(flags & FAULT_FLAG_RETRY_NOWAIT)) {
> >                 fpin =3D get_file(vmf->vma->vm_file);
> > -               mmap_read_unlock(vmf->vma->vm_mm);
> > +               release_fault_lock(vmf);
> >         }
> >         return fpin;
> >  }
> >
> > What do you think?
>
> This is very tempting... Let me try that and see if anything explodes,
> but yes, this would be ideal.

Ok, so far looks good, the problem is not reproducible. I'll run some
more exhaustive testing today.

>
>
> >
> > > I think what happens is that this path is racing with another page
> > > fault which took mmap_lock for read. fault_dirty_shared_page()
> > > releases this lock which was taken by another page faulting thread an=
d
> > > that thread generates an assertion when it finds out the lock it just
> > > took got released from under it.
> >
> > I'm confused that our debugging didn't catch this earlier.  lockdep
> > should always catch this.
>
> Maybe this condition is rare enough?
