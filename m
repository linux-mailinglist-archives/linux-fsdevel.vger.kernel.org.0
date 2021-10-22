Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051A8436EB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 02:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhJVAMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 20:12:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47926 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhJVAMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:12:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7BCB218CE;
        Fri, 22 Oct 2021 00:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634861394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4rV+MNkF8RcZ6MSJOX/2lQh/XwvC0RkEQ5hX7Lq39w=;
        b=BZGFeIzcjdI2sLgabps0IlJN9KXtf0Gy/NNRiYfbHP6pnAPgBGld9kSk7/ig6/YPPh0gT4
        LWh2HDcyq6wDqx9aDYnxmSHDIJGSN8HAM+xwFasSuzmChd1JaVRxwzQqu0B13yDd0c7Ikw
        zWVfw3h2XRzSos9AliOvE3JQfe0+SZM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634861394;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t4rV+MNkF8RcZ6MSJOX/2lQh/XwvC0RkEQ5hX7Lq39w=;
        b=RalCbPbDj36LWJI0cp/Gng4X+RPBdCR8N6xQ98vS9FAv7YVnh/9NTmMemYmxKq0fA37z3O
        Exg6raq2U5cMOoCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86A251346B;
        Fri, 22 Oct 2021 00:09:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uw2vDEwBcmEmFQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 22 Oct 2021 00:09:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Michal Hocko" <mhocko@suse.com>
Cc:     "Dave Chinner" <david@fromorbit.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>, "Jonathan Corbet" <corbet@lwn.net>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/6] MM: improve documentation for __GFP_NOFAIL
In-reply-to: <YW7PPViS0fEdTaKH@dhcp22.suse.cz>
References: <eba04a07-99da-771a-ab6b-36de41f9f120@suse.cz>,
 <20211006231452.GF54211@dread.disaster.area>,
 <YV7G7gyfZkmw7/Ae@dhcp22.suse.cz>,
 <163364854551.31063.4377741712039731672@noble.neil.brown.name>,
 <YV/31+qXwqEgaxJL@dhcp22.suse.cz>,
 <20211008223649.GJ54211@dread.disaster.area>,
 <YWQmsESyyiea0zle@dhcp22.suse.cz>,
 <163398898675.17149.16715168325131099480@noble.neil.brown.name>,
 <YW1LLlwjbyv8dcmn@dhcp22.suse.cz>,
 <163461794761.17149.1193247176490791274@noble.neil.brown.name>,
 <YW7PPViS0fEdTaKH@dhcp22.suse.cz>
Date:   Fri, 22 Oct 2021 11:09:44 +1100
Message-id: <163486138482.17149.3261315484384960888@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Oct 2021, Michal Hocko wrote:
> On Tue 19-10-21 15:32:27, Neil Brown wrote:

[clip looks of discussion where we are largely in agreement - happy to
 see that!]

> > Presumably there is a real risk of deadlock if we just remove the
> > memory-reserves boosts of __GFP_NOFAIL.  Maybe it would be safe to
> > replace all current users of __GFP_NOFAIL with __GFP_NOFAIL|__GFP_HIGH,
> > and then remove the __GFP_HIGH where analysis suggests there is no risk
> > of deadlocks.
> 
> I would much rather not bind those together and go other way around. If
> somebody can actually hit deadlocks (those are quite easy to spot as
> they do not go away) then we can talk about how to deal with them.
> Memory reserves can help only > < this much.

I recall maybe 10 years ago Linus saying that he preferred simplicity to
mathematical provability for handling memory deadlocks (or something
like that).  I lean towards provability myself, but I do see the other
perspective.
We have mempools and they can provide strong guarantees (though they are
often over-allocated I think).  But they can be a bit clumsy.  I believe
that DaveM is strong against anything like that in the network layer, so
we strongly depend on GFP_MEMALLOC functionality for swap-over-NFS.  I'm
sure it is important elsewhere too.

Of course __GFP_HIGH and __GFP_ATOMIC provide an intermediate priority
level - more likely to fail than __GFP_MEMALLOC.  I suspect they should
not be seen as avoiding deadlock, only as improving service.  So using
them when we cannot wait might make sense, but there are probably other
circumstances.

> > Why is __GFP_NOFAIL better?
> 
> Because the allocator can do something if it knows that the allocation
> cannot fail. E.g. give such an allocation a higher priority over those
> that are allowed to fail. This is not limited to memory reserves,
> although this is the only measure that is implemented currently IIRC.
> On the other hand if there is something interesting the caller can do
> directly - e.g. do internal object management like mempool does - then
> it is better to retry at that level.

It *can* do something, but I don't think it *should* do something - not
if that could have a negative impact on other threads.  Just because I
cannot fail, that doesn't mean someone else should fail to help me.
Maybe I should just wait longer.

> 
> > >  * Using this flag for costly allocations is _highly_ discouraged.
> > 
> > This is unhelpful.  Saying something is "discouraged" carries an implied
> > threat.  This is open source and threats need to be open.
> > Why is it discouraged? IF it is not forbidden, then it is clearly
> > permitted.  Maybe there are costs  - so a clear statement of those costs
> > would be appropriate.
> > Also, what is a suitable alternative?
> > 
> > Current code will trigger a WARN_ON, so it is effectively forbidden.
> > Maybe we should document that __GFP_NOFAIL is forbidden for orders above
> > 1, and that vmalloc() should be used instead (thanks for proposing that
> > patch!).
> 
> I think we want to recommend kvmalloc as an alternative once vmalloc is
> NOFAIL aware.
> 
> I will skip over some of the specific regarding SLAB and NOFS usage if
> you do not mind and focus on points that have direct documentation
> consequences. Also I do not feel qualified commenting on neither SLAB
> nor FS internals.
> 
> [...]
> > There is a lot of stuff there.... the bits that are important to me are:
> > 
> >  - why is __GFP_NOFAIL preferred? It is a valuable convenience, but I
> >    don't see that it is necessary
> 
> I think it is preferred for one and a half reasons. It tells allocator
> that this allocation cannot really fail and the caller doesn't have a
> very good/clever retry policy (e.g. like mempools mentioned above). The
> half reason would be for tracking purposes (git grep __GFP_NOFAIL) is
> easier than trying to catch all sorts of while loops over allocation
> which do not do anything really interesting.

I think the one reason is misguided, as described above.
I think the half reason is good, and that we should introduce
   memalloc_retry_wait()
and encourage developers to use that for any memalloc retry loop.
__GFP_NOFAIL would then be a convenience flag which causes the allocator
(slab or alloc_page or whatever) to call memalloc_retry_wait() and do
the loop internally.
What exactly memalloc_retry_wait() does (if anything) can be decided
separately and changed as needed.

> >  - is it reasonable to use __GFP_HIGH when looping if there is a risk of
> >    deadlock?
> 
> As I've said above. Memory reserves are a finite resource and as such
> they cannot fundamentally solve deadlocks. They can help prioritize
> though.

To be fair, they can solve 1 level of deadlock.  i.e. if you only need
to make one allocation to guarantee progress, then allocating from
reserves can help.  If you might need to make a second allocation
without freeing the first - then a single reserve pool can provide
guarantees (which is why we use mempool is layered block devices - md
over dm over loop of scsi).

> 
> >  - Will __GFP_DIRECT_RECLAIM always result in a delay before failure? In
> >    that case it should be safe to loop around allocations using
> >    __GFP_DIRECT_RECLAIM without needing congestion_wait() (so it can
> >    just be removed.
> 
> This is a good question and I do not think we have that documented
> anywhere. We do cond_resched() for sure. I do not think we guarantee a
> sleeping point in general. Maybe we should, I am not really sure.

If we add memalloc_retry_wait(), it wouldn't matter.  We would only need
to ensure that memalloc_retry_wait() waited if page_alloc didn't.


I think we should:
 - introduce memalloc_retry_wait() and use it for all malloc retry loops
   including __GFP_NOFAIL
 - drop all the priority boosts added for __GFP_NOFAIL
 - drop __GFP_ATOMIC and change all the code that tests for __GFP_ATOMIC
   to instead test for __GFP_HIGH.  __GFP_ATOMIC is NEVER used without
   __GFP_HIGH.  This give a slight boost to several sites that use
   __GFP_HIGH explicitly.
 - choose a consistent order threshold for disallowing __GFP_NOFAIL
   (rmqueue uses "order > 1", __alloc_pages_slowpath uses
    "order > PAGE_ALLOC_COSTLY_ORDER"), test it once - early - and
   document kvmalloc as an alternative.  Code can also loop if there
   is an alternative strategy for freeing up memory.

Thanks,
NeilBrown


Thanks,
NeilBrown
