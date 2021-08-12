Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D823EAA1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 20:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237790AbhHLSUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 14:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhHLSUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 14:20:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7C3C061756;
        Thu, 12 Aug 2021 11:19:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w5so13297529ejq.2;
        Thu, 12 Aug 2021 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8nzZyrKMG5TvZzfbf2DLNKR6Jtfcs5c5EesoZusA2AY=;
        b=T9KK0Hg/ncYGvFpuJf1onKvfAmh032mxqNoQxxDccdXc/LZQyFFuQ3vB6xNpz8szEg
         PX23xmhiSis4EHAeZY9QHbnay9hENt9ixpzGFNjMCHRVD8wcJnQAgYtsngVaBlf7ZZ32
         Z90sESGr+S82m+dmANG/y67aKAHecjvzbzutg7COYRcQrouY5yhuSDisolLuuWcycnxz
         JA59o02qWy9dhI6tzvm5ATAYtYLzXPn8x62EzJzOe9zAFQQTc6Pb2CNk0PP/XZgRyaG2
         eOQGWp+Ma6wAQp9ZYddxWtaxM1h35yGBjtDgIZwnAMz7z3pkAwRBO3XmEX4y2zO8bqW2
         t2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8nzZyrKMG5TvZzfbf2DLNKR6Jtfcs5c5EesoZusA2AY=;
        b=C3+V2wPyqKNpCrO53skLwO7RHEVArt4VUlVGNZKeI5lHWIKvyQ+ndKXOFYjGyqlk8R
         c5ar6YUBGW3xF/qEQwmVfH8Y0o1IIS889LM26I23vjpkOiLPjMQH615RKyeeRoYSh2W+
         rbwKgY4RrnV++O7MuHMzfQuySpNe3dT1jB0BV6QXs4hhSFqsr0ukAounKdOLtsK+kqq+
         r+03OqYxIpquvnE9bD1BhPH90VLIDapUhbYaCv9p3J2tjuyD9G8qvxAr4hCqT7TIS4Ot
         Eqpe0QIhJbNPqY/OLdct2Kr1dUrJrn5qO9/66iv937zwf9vydnDVXbpQxo3NcEcaBROg
         8cIg==
X-Gm-Message-State: AOAM5320xq8+jrlVyGpHpuiaHijFEQMGokrMIE0c937fJFQiLYJYMBn/
        eZY+klvJNYPBxAMgR/G1O9ZYzNgOSzFVWqridnk=
X-Google-Smtp-Source: ABdhPJzVb8Ly7AuiUHCY8iVDKVjkusJJzpLqX0GR+dzzhsa0I2l70v548ZkgUFHNHkulXbMmvrnJb/V7KyfLVsjBK1Y=
X-Received: by 2002:a17:906:491a:: with SMTP id b26mr5005149ejq.25.1628792386664;
 Thu, 12 Aug 2021 11:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com>
 <e7374d7e-4773-aba1-763-8fa2c953f917@google.com> <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
 <CAHbLzkqKQ_k_aipojZd=UiHyivaweCpCFJJn7WCWVcxhTijqAQ@mail.gmail.com>
 <749bcf72-efbd-d6c-db30-e9ff98242390@google.com> <CAHbLzkou+6m+htMNzSQrHfd6U0yURWiewK=Pvg30XSdiW=t+-w@mail.gmail.com>
In-Reply-To: <CAHbLzkou+6m+htMNzSQrHfd6U0yURWiewK=Pvg30XSdiW=t+-w@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 12 Aug 2021 11:19:34 -0700
Message-ID: <CAHbLzkpd1r1kLhNP7=Una_Fxpdgx7vE9aeyBgqHRE8M5e9j-qQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 6, 2021 at 10:57 AM Yang Shi <shy828301@gmail.com> wrote:
>
> On Thu, Aug 5, 2021 at 10:43 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > On Thu, 5 Aug 2021, Yang Shi wrote:
> > >
> > > By rereading the code, I think you are correct. Both cases do work
> > > correctly without leaking. And the !CONFIG_NUMA case may carry the
> > > huge page indefinitely.
> > >
> > > I think it is because khugepaged may collapse memory for another NUMA
> > > node in the next loop, so it doesn't make too much sense to carry the
> > > huge page, but it may be an optimization for !CONFIG_NUMA case.
> >
> > Yes, that is its intention.
> >
> > >
> > > However, as I mentioned in earlier email the new pcp implementation
> > > could cache THP now, so we might not need keep this convoluted logic
> > > anymore. Just free the page if collapse is failed then re-allocate
> > > THP. The carried THP might improve the success rate a little bit but I
> > > doubt how noticeable it would be, may be not worth for the extra
> > > complexity at all.
> >
> > It would be great if the new pcp implementation is good enough to
> > get rid of khugepaged's confusing NUMA=y/NUMA=n differences; and all
> > the *hpage stuff too, I hope.  That would be a welcome cleanup.
>
>  The other question is if that optimization is worth it nowadays or
> not. I bet not too many users build NUMA=n kernel nowadays even though
> the kernel is actually running on a non-NUMA machine. Some small
> devices may run NUMA=n kernel, but I don't think they actually use
> THP. So such code complexity could be removed from this point of view
> too.
>
> >
> > > > > Collapse failure is not uncommon and leaking huge pages gets noticed.
> >
> > After writing that, I realized how I'm almost always testing a NUMA=y
> > kernel (though on non-NUMA machines), and seldom try the NUMA=n build.
> > So did so to check no leak, indeed; but was surprised, when comparing
> > vmstats, that the NUMA=n run had done 5 times as much thp_collapse_alloc
> > as the NUMA=y run.  I've merely made a note to look into that one day:
> > maybe it was just a one-off oddity, or maybe the incrementing of stats
> > is wrong down one path or the other.

I came up with a patch to remove !CONFIG_NUMA case, and my test found
the same problem. NUMA=n run had done 5 times as much
thp_collapse_alloc as NUMA=y run with vanilla kernel just exactly as
what you saw.

A quick look shows the huge page allocation timing is different for
the two cases. For NUMA=n, the huge page is allocated by
khugepaged_prealloc_page() before scanning the address space, so it
means huge page may be allocated even though there is no suitable
range for collapsing. Then the page would be just freed if khugepaged
already made enough progress then try to reallocate again. The problem
should be more noticeable if you have a shorter scan interval
(scan_sleep_millisecs). I set it to 100ms for my test.

We could carry the huge page across scan passes for NUMA=n, but this
would make the code more complicated. I don't think it is really
worth, so just removing the special case for NUMA=n sounds more
reasonable to me.

>
> Yeah, probably.
>
> >
> > Hugh
