Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D149846D76
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2019 03:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfFOBP2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 21:15:28 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:38432 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfFOBP2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 21:15:28 -0400
Received: by mail-lf1-f46.google.com with SMTP id b11so2887339lfa.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2019 18:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0sAjPXXfslJFeHisHU1yrczsKCc0N+yl4i1W3iXGv0=;
        b=RaOwSCtNqtqtil2BG0A89cO+YIcb7ccAuT10ZjRkB+BM/5iXa5e7ccARHhlDEdfwDb
         UNWwmuNiXnI+FDpavul6sS3iDMhBtpB7ngwnNuMNvZlWEDtMgPp9OYEojdQ5XLD6tTG6
         emJyLc9yswuypGzecLiYQUAz3ylLy9F1cagCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0sAjPXXfslJFeHisHU1yrczsKCc0N+yl4i1W3iXGv0=;
        b=APQ788QJJXh7ny1MKboyb365ed83zWFlIT0Cdz7kx/FxXcA8jM2o/lH/SbcFkuOEgj
         emFbL6P3ipF4AiXcug5zTCAScNCB7A9ZviIqzJdgMylRDxv00/RQ3nZiD4/IxmS+nr4B
         RcRfeGBRB6mQU66BksbfdKIerE/iTQvf7fLV9d0o4cL8ZZ3pTpsmV3PbW+1lXz7dldk3
         OKmcXqKmCckKXbPVHyMXhhjDJkbj3L1jZB60Oy2eSRVOuNNL416tT2MjHHrB9uNT3H5s
         Ni0V41lkU/SzAhrl8UsadT2G/ziaa5JfUWXOFjOxA7qxaQdg5R2F/yJh9+l09ch/amEB
         teFg==
X-Gm-Message-State: APjAAAXL7qJFv0s6u9jy/Y4janSCbugwOgZS2cydQ5iMkQvlIhJ9o2TO
        DVwsM43+vm5+U4t56n6pnk9hZCY3cnY=
X-Google-Smtp-Source: APXvYqw39cwHTeywmnarT8bRvPx6SQjE/tOK5XfpKpUjuEgUI5QjdBARYl3QhYyffmqypg/AQLzb9w==
X-Received: by 2002:a19:521a:: with SMTP id m26mr24107387lfb.134.1560561324115;
        Fri, 14 Jun 2019 18:15:24 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id t21sm849546ljg.60.2019.06.14.18.15.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 18:15:22 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id b11so2887287lfa.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jun 2019 18:15:22 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr48522334lfn.52.1560561321789;
 Fri, 14 Jun 2019 18:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel> <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel> <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel> <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com> <20190614073053.GQ14363@dread.disaster.area>
In-Reply-To: <20190614073053.GQ14363@dread.disaster.area>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Jun 2019 15:15:05 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgoXo-irWbU1SbKvHuYyAz2nwOkrw2L=+HackVWsXFhpQ@mail.gmail.com>
Message-ID: <CAHk-=wgoXo-irWbU1SbKvHuYyAz2nwOkrw2L=+HackVWsXFhpQ@mail.gmail.com>
Subject: Re: pagecache locking (was: bcachefs status update) merged)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 9:31 PM Dave Chinner <david@fromorbit.com> wrote:
>
> Yes, they do, I see plenty of cases where the page cache works just
> fine because it is still faster than most storage. But that's _not
> what I said_.

I only quoted one small part of your email, because I wanted to point
out how you again dismissed caches.

And yes, that literally _is_ what you said. In other parts of that
same email you said

   "..it's getting to the point where the only reason for having
    a page cache is to support mmap() and cheap systems with spinning
    rust storage"

and

  "That's my beef with relying on the page cache - the page cache is
   rapidly becoming a legacy structure that only serves to slow modern
   IO subsystems down"

and your whole email was basically a rant against the page cache.

So I only quoted the bare minimum, and pointed out that caching is
still damn important.

Because most loads cache well.

How you are back-tracking a bit from your statements, but don't go
saying was misreading you. How else would the above be read? You
really were saying that caching was "legacy". I called you out on it.
Now you're trying to back-track.

Yes, you have loads that don't cache well. But that does not mean that
caching has somehow become irrelevant in the big picture or a "legacy"
thing at all.

The thing is, I don't even hate DIO. But we always end up clashing
because you seem to have this mindset where nothing else matters
(which really came through in that email I replied to).

Do you really wonder why I point out that caching is important?
Because you seem to actively claim caching doesn't matter. Are you
happier now that I quoted more of your emails back to you?

>         IOWs, you've taken _one
> single statement_ I made from a huge email about complexities in
> dealing with IO concurency, the page cache and architectural flaws n
> the existing code, quoted it out of context, fabricated a completely
> new context and started ranting about how I know nothing about how
> caches or the page cache work.

See above. I cut things down a lot, but it wasn't a single statement
at all. I just boiled it down to the basics.

> Linus, nobody can talk about direct IO without you screaming and
> tossing all your toys out of the crib.

Dave, look in the mirror some day. You might be surprised.

> So, in the interests of further _civil_ discussion, let me clarify
> my statement for you: for a highly concurrent application that is
> crunching through bulk data on large files on high throughput
> storage, the page cache is still far, far slower than direct IO.

.. and Christ, Dave, we even _agree_ on this.

But when DIO becomes an issue is when you try to claim it makes the
page cache irrelevant, or a problem.

I also take issue with you then making statements that seem to be
explicitly designed to be misleading. For DIO, you talk about how XFS
has no serialization and gets great performance. Then in the very next
email, you talk about how you think buffered IO has to be excessively
serialized, and how XFS is the only one who does it properly, and how
that is a problem for performance. But as far as I can tell, the
serialization rule you quote is simply not true. But for you it is,
and only for buffered IO.

It's really as if you were actively trying to make the non-DIO case
look bad by picking and choosing your rules.

And the thing is, I suspect that the overlap between DIO and cached IO
shouldn't even need to be there. We've generally tried to just not
have them interact at all, by just having DIO invalidate the caches
(which is really really cheap if they don't exist - which should be
the common case by far!). People almost never mix the two at all, and
we might be better off aiming to separate them out even more than we
do now.

That's actually the part I like best about the page cache add lock - I
may not be a great fan of yet another ad-hoc lock - but I do like how
it adds minimal overhead to the cached case (because by definition,
the good cached case is when you don't need to add new pages), while
hopefully working well together with the whole "invalidate existing
caches" case for DIO.

I know you don't like the cache flush and invalidation stuff for some
reason, but I don't even understand why you care. Again, if you're
actually just doing all DIO, the caches will be empty and not be in
your way. So normally all that should be really really cheap. Flushing
and invalidating caches that don't exists isn't really complicated, is
it?

And if cached state *does* exist, and if it can't be invalidated (for
example, existing busy mmap or whatever), maybe the solution there is
"always fall back to buffered/cached IO".

For the cases you care about, that should never happen, after all.

IOW, if anything, I think we should strive for a situation where the
whole DIO vs cached becomes even _more_ independent. If there are busy
caches, just fall back to cached IO. It will have lower IO throughput,
but that's one of the _points_ of caches - they should decrease the
need for IO, and less IO is what it's all about.

So I don't understand why you hate the page cache so much. For the
cases you care about, the page cache should be a total non-issue. And
if the page cache does exist, then it almost by definition means that
it's not a case you care about.

And yes, yes, maybe some day people won't have SSD's at all, and it's
all nvdimm's and all filesystem data accesses are DAX, and caching is
all done by hardware and the page cache will never exist at all. At
that point a page cache will be legacy.

But honestly, that day is not today. It's decades away, and might
never happen at all.

So in the meantime, don't pooh-pooh the page cache. It works very well
indeed, and I say that as somebody who has refused to touch spinning
media (or indeed bad SSD's) for a decade.

              Linus
