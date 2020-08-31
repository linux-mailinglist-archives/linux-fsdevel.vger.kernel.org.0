Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41412582A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 22:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgHaUgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHaUgd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 16:36:33 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB1C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 13:36:33 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id k63so1803083oob.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 13:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ALZ0cI088e7LavEE1zCuQl43dEIuq04xSG5XkBRnPb4=;
        b=cXMgYuoMdUne52TPYEQ+RFvNI7fYFdPFXmQNr2cTfKwhpwzXvn0C1UEkM2V288lmdo
         Bm09UkGWR+j1NnjJtpdsgh4pu7bbkdCOYa4W6LaTudcHbvcA1MeAlIMLvCJZGeFuwJSd
         SvC9QFsb45+heQ0E4L08PQpV0mZ/S1U6t2LLcDOgdATl+i0OpteWp66eF+2mglWO+iNz
         Un2AVZq41XE8zU42eC/gUHnwuKWSRdtpSqKVwu6OTepuiEVN/pA74/aDMO4b5HYmNr/s
         tVHEKv2wvuGJw9bi7Jl8VE6G61KmRs9aF6dPYuIbzLMXOzjKoUJmYltdWsB2lQYUceaK
         J7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ALZ0cI088e7LavEE1zCuQl43dEIuq04xSG5XkBRnPb4=;
        b=fMkgZwZ1l3ht9Seh8kOLVOv/6Ad379i85fs8ov12c+uQ0/MWZIcq7wALLlQrUjIY8A
         wHZP04DB3Oofmg6mDPgNBoIXgEvfvv+ttnmAC1ehGDW+hXqxC0XLXH8hRwPgMuz2X6VM
         c+vjggoIHg4oMbZEwvMv3wa+17aIDa//cznodb2LH1pvCm0AR1TH415M7WVW4yDeFhiK
         HcLvwwDsk5o/9NwVY8JGx20JdjekWq+RW1IUssbyiEHsMbPZzfA0Nqtq4df8Ogy13PXA
         VR8B3OBbbEoF4Zs3Hi6OUBZGWnZSbMpNeE1TulkxTnFiBp8SzfsbYBpHgh1n8rAtjr9Y
         XPaQ==
X-Gm-Message-State: AOAM532ejGAngkG+DI37VqWSi3IzCWgnvEorzWa1+wMaqzBAnx1kw7qq
        HAEQOEZnAR4w5tH70LCLcZB49g==
X-Google-Smtp-Source: ABdhPJxlYmDe1he0nb+ZttHTJoAT3S1OZGqNC/UYyfdM76yoUFWtJWVAxMeAPXce/Tx266vERYW5SA==
X-Received: by 2002:a4a:d157:: with SMTP id o23mr1078948oor.2.1598906192708;
        Mon, 31 Aug 2020 13:36:32 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l22sm2035015oot.22.2020.08.31.13.36.30
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2020 13:36:31 -0700 (PDT)
Date:   Mon, 31 Aug 2020 13:36:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Jann Horn <jannh@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 7/7] mm: Remove the now-unnecessary mmget_still_valid()
 hack
In-Reply-To: <CAG48ez15Zxbkjv0WRChZZZ6F78pFVXPTu_Bn1Pqaxx=7Gk1gUg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2008311326540.3602@eggly.anvils>
References: <20200827114932.3572699-1-jannh@google.com> <20200827114932.3572699-8-jannh@google.com> <alpine.LSU.2.11.2008302225510.1934@eggly.anvils> <CAG48ez15Zxbkjv0WRChZZZ6F78pFVXPTu_Bn1Pqaxx=7Gk1gUg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 31 Aug 2020, Jann Horn wrote:
> On Mon, Aug 31, 2020 at 8:07 AM Hugh Dickins <hughd@google.com> wrote:
> > On Thu, 27 Aug 2020, Jann Horn wrote:
> >
> > > The preceding patches have ensured that core dumping properly takes the
> > > mmap_lock. Thanks to that, we can now remove mmget_still_valid() and all
> > > its users.
> >
> > Hi Jann, while the only tears to be shed over losing mmget_still_valid()
> > will be tears of joy, I think you need to explain why you believe it's
> > safe to remove the instance in mm/khugepaged.c: which you'll have found
> > I moved just recently, to cover an extra case (sorry for not Cc'ing you).
> >
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -431,7 +431,7 @@ static void insert_to_mm_slots_hash(struct mm_struct *mm,
> > >
> > >  static inline int khugepaged_test_exit(struct mm_struct *mm)
> > >  {
> > > -     return atomic_read(&mm->mm_users) == 0 || !mmget_still_valid(mm);
> > > +     return atomic_read(&mm->mm_users) == 0;
> > >  }
> > >
> > >  static bool hugepage_vma_check(struct vm_area_struct *vma,
> >
> > The movement (which you have correctly followed) was in
> > bbe98f9cadff ("khugepaged: khugepaged_test_exit() check mmget_still_valid()")
> > but the "pmd .. physical page 0" issue is explained better in its parent
> > 18e77600f7a1 ("khugepaged: retract_page_tables() remember to test exit")
> >
> > I think your core dumping is still reading the page tables without
> > holding mmap_lock
> 
> Where? get_dump_page() takes mmap_lock now:
> <https://lore.kernel.org/lkml/20200827114932.3572699-7-jannh@google.com/>

Right, sorry for the noise, that's precisely what 6/7 is all about,
and properly declares itself there in its Subject - I plead that I
got distracted by the vma snapshot part of the series, and paid too
little attention before bleating.

Looks good to me - thanks.

> 
> I don't think there should be any paths into __get_user_pages() left
> that don't hold the mmap_lock. Actually, we should probably try
> sticking mmap_assert_locked() in there now as a follow-up?

Maybe: I haven't given it thought, to be honest.

Hugh
