Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87D274565C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfFNHb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 03:31:57 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:54640 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbfFNHb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 03:31:56 -0400
Received: from dread.disaster.area (pa49-195-189-25.pa.nsw.optusnet.com.au [49.195.189.25])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 4FFEC1AD6C8;
        Fri, 14 Jun 2019 17:31:51 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hbgfl-0007DD-JD; Fri, 14 Jun 2019 17:30:53 +1000
Date:   Fri, 14 Jun 2019 17:30:53 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: pagecache locking (was: bcachefs status update) merged)
Message-ID: <20190614073053.GQ14363@dread.disaster.area>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj3SQjfHHvE_CNrQAYS2p7bsC=OXEc156cHA_ujyaG0NA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0 cx=a_idp_d
        a=K5LJ/TdJMXINHCwnwvH1bQ==:117 a=K5LJ/TdJMXINHCwnwvH1bQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=dq6fvYVFJ5YA:10
        a=7-415B0cAAAA:8 a=N7bZJnSf5Z-prqCgXwgA:9 a=CjuIK1q_8ugA:10
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 13, 2019 at 04:30:36PM -1000, Linus Torvalds wrote:
> On Thu, Jun 13, 2019 at 1:56 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > That said, the page cache is still far, far slower than direct IO,
> 
> Bullshit, Dave.
> 
> You've made that claim before, and it's been complete bullshit before
> too, and I've called you out on it then too.

Yes, your last run of insulting rants on this topic resulted in me
pointing out your CoC violations because you were unable to listen
or discuss the subject matter in a civil manner. And you've started
right where you left off last time....

> Why do you continue to make this obviously garbage argument?
> 
> The key word in the "page cache" name is "cache".
> 
> Caches work, Dave.

Yes, they do, I see plenty of cases where the page cache works just
fine because it is still faster than most storage. But that's _not
what I said_.

Indeed, you haven't even bothered to ask me to clarify what I was
refering to in the statement you quoted. IOWs, you've taken _one
single statement_ I made from a huge email about complexities in
dealing with IO concurency, the page cache and architectural flaws n
the existing code, quoted it out of context, fabricated a completely
new context and started ranting about how I know nothing about how
caches or the page cache work.

Not very professional but, unfortunately, an entirely predictable
and _expected_ response.

Linus, nobody can talk about direct IO without you screaming and
tossing all your toys out of the crib. If you can't be civil or you
find yourself writing a some condescending "caching 101" explanation
to someone who has spent the last 15+ years working with filesystems
and caches, then you're far better off not saying anything.

---

So, in the interests of further _civil_ discussion, let me clarify
my statement for you: for a highly concurrent application that is
crunching through bulk data on large files on high throughput
storage, the page cache is still far, far slower than direct IO.

Which comes back to this statement you made:

> Is direct IO faster when you *know* it's not cached, and shouldn't
> be cached? Sure. But that/s actually quite rare. 

This is where I think you get the wrong end of the stick, Linus.

The world I work in has a significant proportion of applications
where the data set is too large to be cached effectively or is
better cached by the application than the kernel. IOWs, data being
cached efficiently by the page cache is the exception rather than
the rule. Hence, they use direct IO because it is faster than the
page cache. This is common in applications like major enterprise
databases, HPC apps, data mining/analysis applications, etc. and
there's an awful lot of the world that runs on these apps....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
