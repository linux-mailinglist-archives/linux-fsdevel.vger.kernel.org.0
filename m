Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610674236CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 06:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhJFEC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 00:02:27 -0400
Received: from out0.migadu.com ([94.23.1.103]:33825 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230358AbhJFECZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 00:02:25 -0400
Date:   Wed, 6 Oct 2021 13:00:15 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1633492826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j4OHhLztgaT2DVmS+ewtyxjius1Brkr/mlfv76zVtN4=;
        b=iWRB+sjLt42EFg/TfR10HXvMvWAmSvLHHydjIBK8hIHMExaZjoVZDB1dvRUiqebhLQ1jJO
        /FfCX7CdurW2Gt4CzPZQuXAhCFXIpCtcdwy31S64cxy7QRnfSarXs52dVwI1MrStFibusU
        uugiI+MicVeX3tHZ+jYxj0vXfbDcCSg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 1/5] mm: hwpoison: remove the unnecessary THP check
Message-ID: <20211006040015.GA1626563@u2004>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-2-shy828301@gmail.com>
 <CAHbLzkpyxnvm3w0M_CEU7cYRCYr0coNCoiY1DvtnBzqb1R1nsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkpyxnvm3w0M_CEU7cYRCYr0coNCoiY1DvtnBzqb1R1nsw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Any comment on this patch and patch #3? I'd prefer to fix more
> comments for a new version.

No. Both 1/5 and 3/5 look fine to me. So ...

> On Thu, Sep 30, 2021 at 2:53 PM Yang Shi <shy828301@gmail.com> wrote:
> >
> > When handling THP hwpoison checked if the THP is in allocation or free
> > stage since hwpoison may mistreat it as hugetlb page.  After
> > commit 415c64c1453a ("mm/memory-failure: split thp earlier in memory error
> > handling") the problem has been fixed, so this check is no longer
> > needed.  Remove it.  The side effect of the removal is hwpoison may
> > report unsplit THP instead of unknown error for shmem THP.  It seems not
> > like a big deal.
> >
> > The following patch depends on this, which fixes shmem THP with
> > hwpoisoned subpage(s) are mapped PMD wrongly.  So this patch needs to be
> > backported to -stable as well.
> >
> > Cc: <stable@vger.kernel.org>
> > Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Patch 3/5 already has my Signed-off-by, so I think it can be considered
as acked by me.

Thanks,
Naoya Horiguchi
