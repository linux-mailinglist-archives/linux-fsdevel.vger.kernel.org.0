Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF0B42CD02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 23:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhJMVpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhJMVo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 17:44:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D3C061570;
        Wed, 13 Oct 2021 14:42:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t16so15912819eds.9;
        Wed, 13 Oct 2021 14:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+74ZuFQnhra1mA1yYzIx/vvNdxWlZMlZrX1c1bZpxQM=;
        b=mZC4pT++UMEOauA4S5g8YTkpiJT3CPeW6UBji2zCvAvlZmBYIsXB3UU+bQPMBvM1Sr
         aw24uTe6odebY5TY6caJLOAxOYisGTqjcpNffBqf6VrFB2cuiMq5tIH2+ZbmB39eR3ka
         SE4rX/119ghNd45eGNppFMcMsFC+D9cB74ShLm+W1q3ROL0HDkvJjKAGXqVnPl9kVnlD
         SVUkE4nDALNivePSINq5hG2KpEUM0gtTNkl0MO+GBggjUZkn+sW2bnv1kXqKl/WLB1PC
         OMJ3NcPwajOfk1Q2q9umNygvEEizenOB2Aa5f0L/NpzyUPTB7X+3f26XRkxlyaqph0mc
         m+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+74ZuFQnhra1mA1yYzIx/vvNdxWlZMlZrX1c1bZpxQM=;
        b=vr/+/+Kc30J+MZ0XrmqJxWHGsULFqzogOc+P/33TPUdXtYoMJ5AwRIB4i70036IGdU
         vk+AZ7HbNW5Nnf9YibJjnuOcnDFUlCDUZ0nkrwlvnYYCk59+LM4uOF4bmxcOYOd9JGZT
         O3GXGSD/Qson5g+inxPCMaaVLXET8yDy/0XHRpQOnVU9cJd4GhhA1U7CdW215iasdqvX
         Y+iPOghvl0/3YKCJ3jOz9oVK7Slc6+AcN0CWt6oeqVbD7BAyz2jD7KRg8VbsAOxkqJsw
         0JKsJaa6CWtJ4U+7jg43iX4TiPk4w+x+t4HB/X0av1gBDDxlhnJvw4j6UoUPwkouSD6e
         tUkA==
X-Gm-Message-State: AOAM532UAk+xUl5N5IPMJl4a9uQwgFbjfecZZ3UjR6cX4m8Ns5OAX4L9
        CfH6nvVpi65kejEgVoVwJ5+YW4gMhcqMdycKc5Q=
X-Google-Smtp-Source: ABdhPJx9tJwAHOBTrDWPCFv16dqCid3PHadT6+J/KPMUKiY7D2dPw3VxGvjydNx4DFMQCrjVpO4jdVubBe1D8lZwVGY=
X-Received: by 2002:a17:906:a94b:: with SMTP id hh11mr2073351ejb.85.1634161374135;
 Wed, 13 Oct 2021 14:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <YV4Dz3y4NXhtqd6V@t490s> <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s> <YWTobPkBc3TDtMGd@t490s> <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
 <YWYHukJIo8Ol2sHN@t490s> <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
 <YWZMDTwCCZWX5/sQ@t490s> <CAHbLzkp8QkORXK_y8hnrg=2kTRFyoZpJcXbkyj6eyCdcYSbZTw@mail.gmail.com>
 <YWZVdDSS/4rnFbqK@t490s>
In-Reply-To: <YWZVdDSS/4rnFbqK@t490s>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 13 Oct 2021 14:42:42 -0700
Message-ID: <CAHbLzkrcOpG5AHk934hDJb2d+FocYjUc6nhBRofhTbTxLVWtYA@mail.gmail.com>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
To:     Peter Xu <peterx@redhat.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 12, 2021 at 8:41 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 08:27:06PM -0700, Yang Shi wrote:
> > > But this also reminded me that shouldn't we be with the page lock already
> > > during the process of "setting hwpoison-subpage bit, split thp, clear
> > > hwpoison-subpage bit"?  If it's only the small window that needs protection,
> > > while when looking up the shmem pagecache we always need to take the page lock
> > > too, then it seems already safe even without the extra bit?  Hmm?
> >
> > I don't quite get your point. Do you mean memory_failure()? If so the
> > answer is no, outside the page lock. And the window may be indefinite
> > since file THP doesn't get split before this series and the split may
> > fail even after this series.
>
> What I meant is that we could extend the page_lock in try_to_split_thp_page()
> to cover setting hwpoison-subpage too (and it of course covers the clearing if
> thp split succeeded, as that's part of the split process).  But yeah it's a
> good point that the split may fail, so the extra bit seems still necessary.
>
> Maybe that'll be something worth mentioning in the commit message too?  The
> commit message described very well on the overhead of looping over 512 pages,
> however the reader can easily overlook the real reason for needing this bit -
> IMHO it's really for the thp split failure case, as we could also mention that
> if thp split won't fail, page lock should be suffice (imho).  We could also

Not only for THP split failure case. Before this series, shmem THP
does't get split at all. And this commit is supposed to be backported
to the older versions, so saying "page lock is sufficient" is not
precise and confusing.

> mention about why soft offline does not need that extra bit, which seems not
> obvious as well, so imho good material for commit messages.

It would be nice to mention soft offline case.

>
> Sorry to have asked for a lot of commit message changes; I hope they make sense.

Thanks a lot for all the great suggestions.

>
> Thanks,
>
> --
> Peter Xu
>
