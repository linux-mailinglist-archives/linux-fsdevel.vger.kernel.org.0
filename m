Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C9B462423
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhK2WQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhK2WQk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:16:40 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3801C0FE6D2
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 13:53:21 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y13so77893356edd.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 13:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slW4IJtLPUe+dCTHZwT8J5Hyfi+JKfCkiz5Jx8MZKyY=;
        b=OIIkDWpAmMxBagMHTq19qfJ/pA9QYr/FKz8j6+SnJ2OrelhnpGAnnKmCIO3mUxo8Q6
         3kiR81AGz32H1FqBqW5zns775gFrUt+SLbtgMVdaHVpW1sxT7KmTN6wWstYt3DlOV4Dj
         +J3pR3O4PkRhYpRorn4h4+cgIw+4SIqeCwE5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slW4IJtLPUe+dCTHZwT8J5Hyfi+JKfCkiz5Jx8MZKyY=;
        b=mi5R/SqXk11gfkuwP3XZNIFQNxbJpmfglSrW4YDLSMUIGx57yOgWuTKHc48mQFlZSU
         aAPUWJXNol0B8dc0hclW7EaZO5WScmM4YXnhN3R9w4GaPGFG18QbqyILInsXTnquGHre
         oagfieEYzhSIe7xxvLUe8ppIYkT/rLFSuwv+MYSa2pjnOTpUgCzgZvhRguoPBS9U58nH
         sAcCH2T52Lw/R5oGg0jXnNZkzJb3WBcV1cweOPbmx6Pe56S1wP318q3vaMV6QkhDotZy
         I/aFeL9cNWmvCFQSWkCvGfJOQd0a00TyM7GDjZJMk8D6VYX2VhRMA4UCr+c6u26mB+t0
         NGug==
X-Gm-Message-State: AOAM530SKmZB95QRVBr2r3h+lp1QUse3nwoBUqx45fY6nEBLosXU+lX5
        9MOsF8jXjmID5gkxmCeXknxmPxEwxWpPwEzliaI=
X-Google-Smtp-Source: ABdhPJwjnYywoJGZs1qC0MPT/YIITCHBkx3Gf1jJRcmv1K4QxPcQw9NOkYxi2WhFJc4yq5a+qP3Vuw==
X-Received: by 2002:a17:907:9801:: with SMTP id ji1mr63639634ejc.170.1638222799902;
        Mon, 29 Nov 2021 13:53:19 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id o8sm10856070edc.25.2021.11.29.13.53.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 13:53:19 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id u1so39829086wru.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Nov 2021 13:53:18 -0800 (PST)
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr37419983wrn.318.1638222798596;
 Mon, 29 Nov 2021 13:53:18 -0800 (PST)
MIME-Version: 1.0
References: <YZ6arlsi2L3LVbFO@casper.infradead.org> <YZ6idVy3zqQC4atv@arm.com>
 <CAHc6FU4-P9sVexcNt5CDQxROtMAo=kH8hEu==AAhZ_+Zv53=Ag@mail.gmail.com>
 <20211127123958.588350-1-agruenba@redhat.com> <YaJM4n31gDeVzUGA@arm.com>
 <CAHc6FU7BSL58GVkOh=nsNQczRKG3P+Ty044zs7PjKPik4vzz=Q@mail.gmail.com>
 <YaTEkAahkCwuQdPN@arm.com> <CAHc6FU6zVi9A2D3V3T5zE71YAdkBiJTs0ao1Q6ysSuEp=bz8fQ@mail.gmail.com>
 <YaTziROgnFwB6Ddj@arm.com> <CAHk-=wiZgAgcynfLsop+D1xBUAZ-Z+NUBxe9mb-AedecFRNm+w@mail.gmail.com>
 <YaU+aDG5pCAba57r@arm.com>
In-Reply-To: <YaU+aDG5pCAba57r@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Nov 2021 13:53:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjZ6zME2SzohM1P_-B0BNi2JJgvz22ypF-EuAQiVKipRg@mail.gmail.com>
Message-ID: <CAHk-=wjZ6zME2SzohM1P_-B0BNi2JJgvz22ypF-EuAQiVKipRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: Avoid live-lock in search_ioctl() on hardware
 with sub-page faults
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:56 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> For arm64 at least __put_user() does the access_ok() check. I thought
> only unsafe_put_user() should skip the checks. If __put_user() can write
> arbitrary memory, we may have a bigger problem.

That's literally be the historical difference between __put_user() and
put_user() - the access check.

> I think that would be useful, though it doesn't solve the potential
> livelock with sub-page faults.

I was assuming we'd just do the sub-page faults.

In fact, I was assuming we'd basically just replace all the PAGE_ALIGN
and PAGE_SIZE with SUBPAGE_{ALIGN,SIZE}, together with something like

        if (size > PAGE_SIZE)
                size = PAGE_SIZE;

to limit that size thing (or possibly make that "min size" be a
parameter, so that people who have things like that "I need at least
this initial structure to be copied" issue can document their minimum
size needs).

            Linus
