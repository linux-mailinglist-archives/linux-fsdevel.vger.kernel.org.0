Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34626E2F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIQRwp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgIQRwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:52:05 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7732AC06178A
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 10:52:04 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so3120088lfq.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 10:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6bZmvn6AnFCToftcYmbjrMBsBaTLLKSGSnwvFmZF6n0=;
        b=KiLftkuCxl6NE0Z5GnOQXhoKfwhjNUBSCQAWnYyfLQ+LiSz8M2D9BnQlavUlJcqpj5
         r2WBVfPMgec7ErXB7d/k7N1dWn9frQt9YfcR85U4NaYZ6A7c+n0cdKT+RFL174Krzqk2
         lmXuheqYv1PgK+D/UjzvSTurKgMQjEi4xIS48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6bZmvn6AnFCToftcYmbjrMBsBaTLLKSGSnwvFmZF6n0=;
        b=txvjgxP1jKvVidO7mEcGoDpAeDkSH3bgTyYaWaqoO53vJUFiQHWdQ8fMHMLMgGtZhC
         RKCyur8iJVGaaEgHREfkMz5l5cFvwDecudnf5el4CduPPpPRHttj/JXnXCWtj+bmZwjf
         rOJOg4iu1gaVKWe+9mk+cZJ1xqgNjl5exe9DmQ/tPUiqpcana8sKHTV7gZer39VmUoQP
         +VfL0pcu8Sej0KvHUyzPyHzDmwUdxvxyOA8lwdZt77DORfZlzuLmMRTi9KaEcBcpGU0z
         C9z/pfF0M1o/oofDRYB0aEqqClAECBgc8NdN1BzMGaEIyQQfqXI9mhYyKksUq19WYP8j
         W+ag==
X-Gm-Message-State: AOAM530nI2jvkEEgWd+PziXxns6TPqvR6fwVkBHC+GUyKO/q4GA3LMRO
        1MISysB8e7fvH8PAUzeFmCl/doOC8AXy1Q==
X-Google-Smtp-Source: ABdhPJzuB2HYC+JFItahdOA6V1ssIe6DpBBYdw8x2d0w96QiUjl35f7vkAu9UR9TIJk0tK+ljE/Z2w==
X-Received: by 2002:ac2:4a73:: with SMTP id q19mr10826426lfp.569.1600365120136;
        Thu, 17 Sep 2020 10:52:00 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w17sm55991ljd.2.2020.09.17.10.51.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 10:51:58 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z17so3117446lfi.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2020 10:51:58 -0700 (PDT)
X-Received: by 2002:a19:8907:: with SMTP id l7mr9413968lfd.105.1600365117964;
 Thu, 17 Sep 2020 10:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
In-Reply-To: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 10:51:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
Message-ID: <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> (Note that it's a commit and has a SHA1, but it's from my "throw-away
> tree for testing", so it doesn't have my sign-off or any real commit
> message yet: I'll do that once it gets actual testing and comments).

Just to keep the list and people who were on this thread informed:
Michal ended up doing more benchmarking, and everything seems to line
up and yes, that patch continues to work fine with a 'unfairness'
value of 5.

So I've committed it to my git tree (not pushed out yet, I have other
pull requests etc I'm handling too), and we'll see if anybody can come
up with a better model for how to avoid the page locking being such a
pain. Or if somebody can figure out why fair locking causes problems
for that packetdrill load that Matthieu reported.

It does strike me that if the main source of contention comes from
that "we need to check that the mapping is still valid as we insert
the page into the page tables", then the page lock really isn't the
obvious lock to use.

It would be much more natural to use the mapping->i_mmap_rwsem, I feel.

Willy? Your "just check for uptodate without any lock" patch itself
feels wrong. That's what we do for plain reads, but the difference is
that a read is a one-time event and a race is fine: we get valid data,
it's just that it's only valid *concurrently* with the truncate or
hole-punching event (ie either all zeroes or old data is fine).

The reason faulting a page in is different from a read is that if you
then map in a stale page, it might have had the correct contents at
the time of the fault, but it will not have the correct contents going
forward.

So a page-in requires fundamentally stronger locking than a read()
does, because of how the page-in causes that "future lifetime" of the
page, in ways a read() event does not.

But truncation that does page cache removal already requires that
i_mmap_rwsem, and in fact the VM already very much uses that (ie when
walking the page mapping).

The other alternative might be just the mapping->private_lock. It's
not a reader-writer lock, but if we don't need to sleep (and I don't
think the final "check ->mapping" can sleep anyway since it has to be
done together with the page table lock), a spinlock would be fine.

                   Linus
