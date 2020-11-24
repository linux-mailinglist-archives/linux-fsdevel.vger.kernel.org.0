Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA75D2C1D2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 06:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKXE7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 23:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgKXE7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:59:12 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EC2C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:59:11 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id j10so8114096lja.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39gr2tFdgeuXdCwWbn22GRnP3K3VvibhIlGf9k17rGw=;
        b=SwaVIz6ZuT6iXE5tagOrwT7N6KNmmSkcEsDFfOdmzj5yjFEuDkdXhaHbzf22ipogzf
         zWRWhpolqbEMbnZmb7w8SY8YssaOfvRbra2P6MvkDrdQIcceCNS8eCPycSxvqCyBE/Wt
         Aogcb79k9z8ri+jJ6nmyXvkP8hv8F792ZSl3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39gr2tFdgeuXdCwWbn22GRnP3K3VvibhIlGf9k17rGw=;
        b=RI37azlJMgzV6SEBkNAfgltUAbEg38SP4rp73jYzCDJMOMFc84D4Vrh17ZG++lpOKF
         xrO0tH0bF/USfEE0uV1dnTzqRZl2H0q+xk05ONEmy/em6y1riOektwjQTF/6S+y6jabE
         jcM9kHjiRm7LWYjC+tvR+AL+m7SqxqlxwmX3yZn7p/185ZU0x9BxIs0/k9uBynXyEeYQ
         X1OM66AuvkUjaZOHgTtyEFfITEYhp1dzYbCWRh3wqqjKDddmK7Z1iGF2gMNtlUWHRAha
         pSF39tGyPG2Usojaz9QwDcxe0KE+5wwwjEHhnEbEfyVe5TI/FgAXF16FXn9NTlw9UYN4
         cgJg==
X-Gm-Message-State: AOAM5332cPy+X8+C1lEruPf+5tbniel7R4/lAGVkO6udzfQgtC3QEl3T
        +RFzTvCq4EXSJZQsDQmRi1+qlQZ1pYlZCg==
X-Google-Smtp-Source: ABdhPJypaHa1pcaaPPs6Re5z4ht9BWDXu2fkrNP/C5O3xHR1nnDeSU3yuhAUUCmrrTtLFWhz0FOBWw==
X-Received: by 2002:a2e:904b:: with SMTP id n11mr1154112ljg.301.1606193950041;
        Mon, 23 Nov 2020 20:59:10 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id i13sm1655536lfo.240.2020.11.23.20.59.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:59:09 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id b17so20508689ljf.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 20:59:09 -0800 (PST)
X-Received: by 2002:a19:ae06:: with SMTP id f6mr1057406lfc.133.1606193616810;
 Mon, 23 Nov 2020 20:53:36 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 20:53:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
Message-ID: <CAHk-=whYO5v09E8oHoYQDn7qqV0hBu713AjF+zxJ9DCr1+WOtQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 8:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> Then on crashing a second time, realized there's a stronger reason against
> that approach.  If my testing just occasionally crashes on that check,
> when the page is reused for part of a compound page, wouldn't it be much
> more common for the page to get reused as an order-0 page before reaching
> wake_up_page()?  And on rare occasions, might that reused page already be
> marked PageWriteback by its new user, and already be waited upon?  What
> would that look like?
>
> It would look like BUG_ON(PageWriteback) after wait_on_page_writeback()
> in write_cache_pages() (though I have never seen that crash myself).

So looking more at the patch, I started looking at this part:

> +       writeback = TestClearPageWriteback(page);
> +       /* No need for smp_mb__after_atomic() after TestClear */
> +       waiters = PageWaiters(page);
> +       if (waiters) {
> +               /*
> +                * Writeback doesn't hold a page reference on its own, relying
> +                * on truncation to wait for the clearing of PG_writeback.
> +                * We could safely wake_up_page_bit(page, PG_writeback) here,
> +                * while holding i_pages lock: but that would be a poor choice
> +                * if the page is on a long hash chain; so instead choose to
> +                * get_page+put_page - though atomics will add some overhead.
> +                */
> +               get_page(page);
> +       }

and thinking more about this, my first reaction was "but that has the
same race, just a smaller window".

And then reading the comment more, I realize you relied on the i_pages
lock, and that this odd ordering was to avoid the possible latency.

But what about the non-mapping case? I'm not sure how that happens,
but this does seem very fragile.

I'm wondering why you didn't want to just do the get_page()
unconditionally and early. Is avoiding the refcount really such a big
optimization?

            Linus
