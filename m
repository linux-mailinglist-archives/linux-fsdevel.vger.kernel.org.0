Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 020533C0DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 03:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbfFKBRm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 21:17:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41212 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388845AbfFKBRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 21:17:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id 33so4461232qtr.8;
        Mon, 10 Jun 2019 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IulWEaCWAQM3Cjwx89zXNg6z6p75qc/OA1Nxr0QmTOo=;
        b=NH8BTFMunaTHtT1SKVQ6VMTAtj5z1w7MXjGz7uzUjkM85xBkzloO5tzhXdPigVU8oK
         byjVctvHsZtAFY0vreBGmr5y3lj/sUsZUNMAbB0eWQaJlEaHFuzkacomu6LVj45wi3H6
         FwesPhemL9XfAwxzdcpSTb6Nic9VHbSPBAoGRdBa+oZ46ox+vjJqp0V8wXSBBI6nG3zv
         ITVvLFXbfsMmT/Qh9wTBS5TgT+SzOobETmhtnQRLOk9PTykhok/BUxncj/FTB4SvYum5
         m9D8RF/SU5jDbBTCxLha3Zd1YOCLUM7izvwwzII2339OBxWj7iFGi150Y161Anqocvn6
         x6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IulWEaCWAQM3Cjwx89zXNg6z6p75qc/OA1Nxr0QmTOo=;
        b=pvcpFLz2/CVLWswkkKWKvpbTdTrKJkCxhwUu4Zzmif8kEak/sJnFpSJv5jCAACAJcL
         lwxtXvtq2C4KvdekjOBtnp2tLOT4qpql8dHEjTBLg5Or1o+8e0ktimJGjlCdO1PlS2yH
         IyndUeIO14VGcSmbA0WywqOuyUspUBliUGzWbfme57nHAQlslNvnLEg5CX1qfjBlJtQw
         xgozl4NFLvkLzmyp2+cCdlO+hYTRrHYdJ3Iv1SYcrx2AeRGLvKJxnN6CefdlEA+PfTDo
         JpmiCGXzH8NPZ4vlfBu7ZLk4dcjSBKLDy4GsTPGVDkie5WwhujwJROTBf1kgL1eqL845
         ZdVg==
X-Gm-Message-State: APjAAAUIcqnu6bNLc/HVNVN9nWBTk1VCZdsDZ/464M21O/s8bJthAmXK
        f+NVB3080/ujc/9Kk1EqTQ==
X-Google-Smtp-Source: APXvYqzmPMG7S1PfKfkheAjAKiUao8BKijZwElki5K0T2BfvZR+gVv7w2Vhd7gBITayGS3aQFQDJQA==
X-Received: by 2002:aed:2a85:: with SMTP id t5mr41081868qtd.26.1560215860587;
        Mon, 10 Jun 2019 18:17:40 -0700 (PDT)
Received: from kmo-pixel (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id m5sm7210292qke.25.2019.06.10.18.17.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 18:17:39 -0700 (PDT)
Date:   Mon, 10 Jun 2019 21:17:37 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: bcachefs status update (it's done cooking; let's get this sucker
 merged)
Message-ID: <20190611011737.GA28701@kmo-pixel>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:46:35AM -1000, Linus Torvalds wrote:
> On Mon, Jun 10, 2019 at 9:14 AM Kent Overstreet
> <kent.overstreet@gmail.com> wrote:
> >
> > So. Here's my bcachefs-for-review branch - this has the minimal set of patches
> > outside of fs/bcachefs/. My master branch has some performance optimizations for
> > the core buffered IO paths, but those are fairly tricky and invasive so I want
> > to hold off on those for now - this branch is intended to be more or less
> > suitable for merging as is.
> 
> Honestly, it really isn't.

Heh, I suppose that's what review is for :)

> There are obvious things wrong with it - like the fact that you've
> rebased it so that the original history is gone, yet you've not
> actually *fixed* the history, so you find things like reverts of
> commits that should simply have been removed, and fixes for things
> that should just have been fixed in the original commit the fix is
> for.

Yeah, I suppose I have dropped the ball on that lately. 
 
> But note that the cleanup should go further than just fix those kinds
> of technical issues. If you rebase, and you have fixes in your tree
> for things you rebase, just fix things as you rewrite history anyway
> (there are cases where the fix may be informative in itself and it's
> worth leaving around, but that's rare).

Yeah that has historically been my practice, I've just been moving away from
that kind of history editing as bcachefs has been getting more users. Hence the
in-between, worst of both workflows state of the current tree.

But, I can certainly go through and clean things up like that one last time and
make everything bisectable again - I'll go through and write proper commit
messages too. Unless you'd be ok with just squashing most of the history down to
one commit - which would you prefer?

> Anyway, aside from that, I only looked at the non-bcachefs parts. Some
> of those are not acceptable either, like
> 
>     struct pagecache_lock add_lock
>         ____cacheline_aligned_in_smp; /* protects adding new pages */
> 
> in 'struct address_space', which is completely bogus, since that
> forces not only a potentially huge amount of padding, it also requires
> alignment that that struct simply fundamentally does not have, and
> _will_ not have.

Oh, good point.

> You can only use ____cacheline_aligned_in_smp for top-level objects,
> and honestly, it's almost never a win. That lock shouldn't be so hot.
> 
> That lock is somewhat questionable in the first place, and no, we
> don't do those hacky recursive things anyway. A recursive lock is
> almost always a buggy and mis-designed one.

You're preaching to the choir there, I still feel dirty about that code and I'd
love nothing more than for someone else to come along and point out how stupid
I've been with a much better way of doing it. 

> Why does the regular page lock (at a finer granularity) not suffice?

Because the lock needs to prevent pages from being _added_ to the page cache -
to do it with a page granularity lock it'd have to be part of the radix tree, 

> And no, nobody has ever cared. The dio people just don't care about
> page cache anyway. They have their own thing going.

It's not just dio, it's even worse with the various fallocate operations. And
the xfs people care, but IIRC even they don't have locking for pages being
faulted in. This is an issue I've talked to other filesystem people quite a bit
about - especially Dave Chinner, maybe we can get him to weigh in here.

And this inconsistency does result in _real_ bugs. It goes something like this:
 - dio write shoots down the range of the page cache for the file it's writing
   to, using invalidate_inode_pages_range2
 - After the page cache shoot down, but before the write actually happens,
   another process pulls those pages back in to the page cache
 - Now the write happens: if that write was e.g. an allocating write, you're
   going to have page cache state (buffer heads) that say that page doesn't have
   anything on disk backing it, but it actually does because of the dio write.

xfs has additional locking (that the vfs does _not_ do) around both the buffered
and dio IO paths to prevent this happening because of a buffered read pulling
the pages back in, but no one has a solution for pages getting _faulted_ back in
- either because of mmap or gup().

And there are some filesystem people who do know about this race, because at
some point the dio code has been changed to shoot down the page cache _again_
after the write completes. But that doesn't eliminate the race, it just makes it
harder to trigger.

And dio writes actually aren't the worst of it, it's even worse with fallocate
FALLOC_FL_INSERT_RANGE/COLLAPSE_RANGE. Last time I looked at the ext4 fallocate
code, it looked _completely_ broken to me - the code seemed to think it was
using the same mechanism truncate uses for shooting down the page cache and
keeping pages from being readded - but that only works for truncate because it's
changing i_size and shooting down pages above i_size. Fallocate needs to shoot
down pages that are still within i_size, so... yeah...

The recursiveness is needed because otherwise, if you mmap a file, then do a dio
write where you pass the address you mmapped to pwrite(), gup() from the dio
write path will be trying to fault in the exact pages it's blocking from being
added.

A better solution would be for gup() to detect that and return an error, so we
can just fall back to buffered writes. Or just return an error to userspace
because fuck anyone who would actually do that.

But I fear plumbing that through gup() is going to be a hell of a lot uglier
than this patch.

I would really like Dave to weigh in here.

> Similarly, no, we're not starting to do vmalloc in non-process context. Stop it.

I don't want to do vmalloc in non process context - but I do need to call
vmalloc when reading in btree nodes, from the filesystem IO path.

But I just learned today about this new memalloc_nofs_save() thing, so if that
works I'm more than happy to drop that patch.

> And the commit comments are very sparse. And not always signed off.

Yeah, I'll fix that.

> I also get the feeling that the "intent" part of the six-locks could
> just be done as a slight extension of the rwsem, where an "intent" is
> the same as a write-lock, but without waiting for existing readers,
> and then the write-lock part is just the "wait for readers to be
> done".
> 
> Have you talked to Waiman Long about that?

No, I haven't, but I'm adding him to the list.

I really hate the idea of adding these sorts of special case features to the
core locking primitives though - I mean, look what's happened to the mutex code,
and the intent state isn't the only special feature they have. As is, they're
small and clean and they do their job well, I'd really prefer to have them just
remain their own thing instead of trying to cram it all into the the hyper
optimized rw semaphore code.

Also, six locks used to be in fs/bcachefs/, but last time I was mailing stuff
out for review Peter Zijlstra was dead set against exporting the osq lock stuff
- moving six locks to kernel/locking/ was actually his idea. 

I can say more about six locks tomorrow when I'm less sleep deprived, if you're
still not convinced.

Cheers.
