Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF86728BA4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 01:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjFHXSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 19:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjFHXSB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:18:01 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A30230C5
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 16:17:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2567b589d3bso186364a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 16:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686266278; x=1688858278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1cBU8CvnLRhFfPk7oGDbturpNUeqfy4EAK1i9I4mZY=;
        b=HeNLRTif69FEJZsrAxRthdhHPA2H8RoQIKQMj7Ba3IQpRy05P7Vm05z6w6fb1Pu2L+
         mL5w9Iw8NjaexLH+zhRhPa7/iES4KAOEJVBHhQX7NlfIVKaKgmYej52dsXEoP//Yh5hq
         NIJoKf7GX+aDqdg3UMAfra2+uc4Rjf5hhHKq7IjfJ9cEb4sevkU+B+sMo8OPYwudQdzB
         96Nz3dcmwxwgoV5Kdbaagxhc3D5CPTeh9sA43AgUFns2iwxGs+lkEP9kBv6GTT3FWt7s
         RRhMqLcqxY4/k6hqJH5ANzOST7+QD7U3BnHGi1d1F6ungTQmWIUSfoXX9JLKBqWhkKvR
         l6bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266278; x=1688858278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1cBU8CvnLRhFfPk7oGDbturpNUeqfy4EAK1i9I4mZY=;
        b=WOmaoCN/y3pVPUDPzyb3rw7lLr8GCzqeM6S0LxfrSE5PvfWLvR9E6m3Iq7rfFZ74No
         CIJUf/voNWFQDI1t4K3UB1BVnt20Eqlh/Vb1K/hSBXaLVk10KHeYR1B79QdAiJ9Zdon6
         pku163chtO5Ny0aR3Tk0KqItCQIh+JfnYuTqiUvRQF0t0+w2Xe1nZEPHnJzqoiKJL8hW
         oRTgdWU85iCEY5o0folGE64KpIiGz1mBdBOdJ5eQBGmRvPgClCWanvQdrgL+jvg/hbZv
         45gDzpXX3LhLbszojOsvZRmArunVrWpObCQIPZUF/OPhJqCoj1ry/IOG9fbHBnHkscDz
         uYNg==
X-Gm-Message-State: AC+VfDwK0A3thhprG5JI12SwpTvjdcZ35TEvqsUQ/rl2uluK03RVRCgX
        hXLXrCEqWI9gE1b2QHDw3/9+LQ==
X-Google-Smtp-Source: ACHHUZ5Dw0QrQ8tgaZzHeyvYZfD1gsaQnW0ALhslQjfpgFVcXSPbguCIKDSdF8GAohY1XxhkEcjQTw==
X-Received: by 2002:a17:90a:2ce5:b0:258:817a:814e with SMTP id n92-20020a17090a2ce500b00258817a814emr4896491pjd.28.1686266277912;
        Thu, 08 Jun 2023 16:17:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-79-151.pa.nsw.optusnet.com.au. [49.179.79.151])
        by smtp.gmail.com with ESMTPSA id oe1-20020a17090b394100b0023d386e4806sm1724156pjb.57.2023.06.08.16.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:17:57 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q7Ot8-009T5r-1z;
        Fri, 09 Jun 2023 09:17:54 +1000
Date:   Fri, 9 Jun 2023 09:17:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2 3/3] fs: Use delayed shrinker unregistration
Message-ID: <ZIJhou1d55d4H1s0@dread.disaster.area>
References: <168599103578.70911.9402374667983518835.stgit@pro.pro>
 <168599180526.70911.14606767590861123431.stgit@pro.pro>
 <ZH6AA72wOd4HKTKE@P9FQF9L96D>
 <ZH6K0McWBeCjaf16@dread.disaster.area>
 <20230608163622.GA1435580@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608163622.GA1435580@mit.edu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 08, 2023 at 12:36:22PM -0400, Theodore Ts'o wrote:
> On Tue, Jun 06, 2023 at 11:24:32AM +1000, Dave Chinner wrote:
> > On Mon, Jun 05, 2023 at 05:38:27PM -0700, Roman Gushchin wrote:
> > > Hm, it makes the API more complex and easier to mess with. Like what will happen
> > > if the second part is never called? Or it's called without the first part being
> > > called first?
> > 
> > Bad things.
> > 
> > Also, it doesn't fix the three other unregister_shrinker() calls in
> > the XFS unmount path, nor the three in the ext4/mbcache/jbd2 unmount
> > path.
> > 
> > Those are just some of the unregister_shrinker() calls that have
> > dynamic contexts that would also need this same fix; I haven't
> > audited the 3 dozen other unregister_shrinker() calls around the
> > kernel to determine if any of them need similar treatment, too.
> > 
> > IOWs, this patchset is purely a band-aid to fix the reported
> > regression, not an actual fix for the underlying problems caused by
> > moving the shrinker infrastructure to SRCU protection.  This is why
> > I really want the SRCU changeover reverted.
> 
> There's been so much traffic on linux-fsdevel so I missed this thread
> until Darrick pointed it out to me today.  (Thanks, Darrick!)
> 
> From his description, and my quick read-through of this thread....
> I'm worried.
> 
> Given that we're at -rc5 now, and the file system folks didn't get
> consulted until fairly late in the progress, and the fact that this
> may cause use-after-free problems that could lead to security issues,
> perhaps we shoould consider reverting the SRCU changeover now, and try
> again for the next merge window?

Yes, please, because I think we can fix this in a much better way
and make things a whole lot simpler at the same time.

The root cause of the SRCU usage is that mm/memcg developers still
haven't unified the non-memcg and the memcg based shrinker
implementations. shrink_slab_memcg() doesn't require SRCU
protection as it does not iterate the shrinker list at all; it
requires *shrinker instance* lifetime protection. The problem is
shrink_slab() doing the root memcg/global shrinker work - it
iterates the shrinker list directly, and this is the list walk that
SRCU is necessary for to "make shrinkers lockless"

Going back to shrink_slab_memcg(), it does a lookup of the shrinker
instance by idr_find(); idr_find() is a wrapper around
radix_tree_lookup(), which means we can use RCU protection and
reference counting to both validate the shrinker instance *and*
guarantee that it isn't free from under us as we execute the
shrinker.

This requires, as I mentioned elsewhere in this thread, that the
shrinker instance to be dynamically allocated, not embedded in other
structures. Dynamically allocated shrinker instances and reference
counting them means we can do this in shrink_slab_memcg() to ensure
shrinker instance validity and lifetime rules are followed:


	rcu_read_lock()
	shrinker = idr_find(&shrinker_idr, i);
	if (!shrinker ||
	    !refcount_inc_not_zero(&shrinker->refcount)) {
		/* shrinker is being torn down */
		clear_bit(i, info->map);
		rcu_read_unlock();
		continue;
	}
	rcu_read_unlock();

	/* do shrinker stuff */

	if (refcount_dec_and_test(&shrinker->refcount)) {
		/* shrinker is being torn down, waiting for us */
		wakeup(&shrinker->completion_wait);
	}
	/* unsafe to reference shrinker now */

And we enable the shrinker to run simply by:

shrinker_register()
{
	.....
	/* allow the shrinker to run now */
	refcount_set(shrinker->refcount, 1);
	return 0;
}

We then shut down the shrinker so we can tear it down like so:

shrinker_unregister()
{
	DECLARE_WAITQUEUE(wait, current);

	add_wait_queue_exclusive(shrinker->completion_wait, &wait);
	if (!refcount_dec_and_test(&shrinker->refcount))) {
		/* Wait for running instances to exit */
		__set_current_state(TASK_UNINTERRUPTIBLE);
		schedule();
	}
	remove_wait_queue(wq, &wait);

	/* We own the entire shrinker instance now, start tearing it down */

	.....

	/* Free the shrinker itself after a RCU grace period expires */
	kfree_rcu(shrinker, shrinker->rcu_head);
}

So, essentially we don't need SCRU at all to do lockless shrinker
lookup for the memcg shrinker side of the fence, nor do we need
synchronise_srcu() to wait for shrinker instances to finish running
before we can tear stuff down. There is no global state in this at
all; everything is per-shrinker instance.

But SRCU is needed to protect the global shrinker list walk because
it hasn't been converted to always use the root memcg and be
iterated as if it is just another memcg.  IOWs, using SRCU to
protect the global shrinker list walk is effectively slapping a
bandaid over a more fundamental problem that we've known about for
a long time.

So the first thing that has to be done here is unify the shrinker
infrastructure under the memcg implementation. The global shrinker
state should be tracked in the root memcg, just like any other memcg
shrinker is tracked. If memcg's are not enabled, then we should be
creating a dummy global memcg that a get_root_memcg() helper returns
when memcgs are disabled to tracks all the global shrinker state.
then shrink_slab just doesn't care about what memcg is passed to it,
it just does the same thing.

IOWs, shrink_slab gets entirely replaced by shrink_slab_memcg(), and
the need for SRCU goes away entirely because shrinker instance
lookups are all RCU+refcount protected.

Yes, this requires we change how shrinker instances are instantiated
by subsystems, but this is mostly simple transformation of existing
code. But it doesn't require changing shrinker implementations, it
doesn't require a new teardown API, and it doesn't change the
context under which shrinkers might run.

All the existing RCU protected stuff in the shrinker maps and memcgs
can remain that way.  We can also keep the shrinker rwsem/mutex for
all the little internal bits of setup/teardown/non-rcu coordination
that are needed; once the list iteration is lockless, there will be
almost no contention on that lock at all...

This isn't all that hard - it's just replicating a well known design
pattern (i.e. refcount+RCU) we use all over the kernel combined with
taking advantage of IDR being backed by RCU-safe infrastructure.

If I had been cc'd on the original SRCU patches, this is exactly
what I would have suggested as a better solution to the problem. We
end up with cleaner, more robust and better performing
infrastructure. This is far better than layering more complexity on
top of what is really a poor foundation....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
