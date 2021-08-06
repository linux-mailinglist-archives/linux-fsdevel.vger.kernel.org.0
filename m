Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4593E2F0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242235AbhHFR6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 13:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhHFR6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:58:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC24C0613CF;
        Fri,  6 Aug 2021 10:57:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h9so16377528ejs.4;
        Fri, 06 Aug 2021 10:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e6yu4POMRnVahz+1Lp2VPniantg+hltxCjShVbMiYBI=;
        b=kyHm0266NGCpJDUk2RCfS7EhmsuhBQ+aqLDWr6WH9ZzEgbMeskSMWsZRpU1yrngFm4
         Mn/PdT+ZXHpQBdPACrXLec0Lf5Fx2kNY0s7jxuzExL6XlKnn8no6fPNzTA/Vz7S4Ujhv
         +MGARosjoV21ijQ+UjFgPWYgZ3RltCw+sy6ZVTIZnepC6ntCFfopOgJtZVFS6XD1KrbL
         sqMve6VzxDyRiwKWsCpWeXhc+m44v6wUeI/91Dk5U2qvIPizBhaa8ukQzZ/8Kd/zfUF+
         6syAT1xdat+UZqj++lu9a/yFQyznf9YcYTwRpxOaWheL2mq5FBfd3s0WKXpNOVA7mzKF
         gDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6yu4POMRnVahz+1Lp2VPniantg+hltxCjShVbMiYBI=;
        b=FLcCwujB/23k0mm0bYNahyBR0rWjagApw8hjq6TfcaNr7UenMdnO0e/Udnf2fIedXD
         BrG1TkdBCbtuqsKRjjI3wBKWdGGH4DMu7MYKfdTTdFT9tpEDuB3278Yfe9KAmm1P8EHS
         A/pVR3T+gU2ZyLAo62HYLC2rfjEQ2lQKX5BMKKDxKy+/avk0a//usjHiQDg9Adx6MsP3
         TkNDVnpH1bJoG8fX+CmAO/pi1eOPn1Gfx6gFw+7hXdeBrePE/KqDEjJTdDXmjxIPorwA
         49Wgoku1aXt58Q3hcB5XbPH5JGjWsMirYR2m2m3fLDeOBz3v45CQHsq/hQRHiQuaVDgp
         lhjg==
X-Gm-Message-State: AOAM532i1lcnSW9KcwPeHatlXbhXJjcW5wsD72t0pDK/GNlJvrANZA9f
        dX8vsmtJx/te201/F2c1u+OlnwFvdZw+YTUmGWI=
X-Google-Smtp-Source: ABdhPJznXWLKfoZB6ywf3PHaxFFTF+rjYHPnGDtCk5ZfySRuvDf7YmVSwQE9PAQHdyreWuzcuCGAI6DwPTcHO0mVlwU=
X-Received: by 2002:a17:906:1919:: with SMTP id a25mr10825003eje.161.1628272664305;
 Fri, 06 Aug 2021 10:57:44 -0700 (PDT)
MIME-Version: 1.0
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com>
 <e7374d7e-4773-aba1-763-8fa2c953f917@google.com> <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com>
 <CAHbLzkqKQ_k_aipojZd=UiHyivaweCpCFJJn7WCWVcxhTijqAQ@mail.gmail.com> <749bcf72-efbd-d6c-db30-e9ff98242390@google.com>
In-Reply-To: <749bcf72-efbd-d6c-db30-e9ff98242390@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Aug 2021 10:57:32 -0700
Message-ID: <CAHbLzkou+6m+htMNzSQrHfd6U0yURWiewK=Pvg30XSdiW=t+-w@mail.gmail.com>
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

On Thu, Aug 5, 2021 at 10:43 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Thu, 5 Aug 2021, Yang Shi wrote:
> >
> > By rereading the code, I think you are correct. Both cases do work
> > correctly without leaking. And the !CONFIG_NUMA case may carry the
> > huge page indefinitely.
> >
> > I think it is because khugepaged may collapse memory for another NUMA
> > node in the next loop, so it doesn't make too much sense to carry the
> > huge page, but it may be an optimization for !CONFIG_NUMA case.
>
> Yes, that is its intention.
>
> >
> > However, as I mentioned in earlier email the new pcp implementation
> > could cache THP now, so we might not need keep this convoluted logic
> > anymore. Just free the page if collapse is failed then re-allocate
> > THP. The carried THP might improve the success rate a little bit but I
> > doubt how noticeable it would be, may be not worth for the extra
> > complexity at all.
>
> It would be great if the new pcp implementation is good enough to
> get rid of khugepaged's confusing NUMA=y/NUMA=n differences; and all
> the *hpage stuff too, I hope.  That would be a welcome cleanup.

 The other question is if that optimization is worth it nowadays or
not. I bet not too many users build NUMA=n kernel nowadays even though
the kernel is actually running on a non-NUMA machine. Some small
devices may run NUMA=n kernel, but I don't think they actually use
THP. So such code complexity could be removed from this point of view
too.

>
> > > > Collapse failure is not uncommon and leaking huge pages gets noticed.
>
> After writing that, I realized how I'm almost always testing a NUMA=y
> kernel (though on non-NUMA machines), and seldom try the NUMA=n build.
> So did so to check no leak, indeed; but was surprised, when comparing
> vmstats, that the NUMA=n run had done 5 times as much thp_collapse_alloc
> as the NUMA=y run.  I've merely made a note to look into that one day:
> maybe it was just a one-off oddity, or maybe the incrementing of stats
> is wrong down one path or the other.

Yeah, probably.

>
> Hugh
