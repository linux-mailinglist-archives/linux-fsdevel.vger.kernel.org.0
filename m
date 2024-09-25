Return-Path: <linux-fsdevel+bounces-30029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C34D9985114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 04:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68171C23510
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 02:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D86149C5B;
	Wed, 25 Sep 2024 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lzckW9eu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647FE14831E
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727232498; cv=none; b=mzTxBt5xMppJaeNZvBbhdRTxcTTvH6Dud2QldjuW0AXGQ6baONA/1SXCmBG4OPEnI23m+XQ4iZWjKZx6y4HMKzrFjO3bd4LGRGdTReqquf9iQkGkAzQO8hFeWJCx06pNtMSt4inkOZqCt4dI/jm7LI4ltyvQNHZsquTrD/mE6BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727232498; c=relaxed/simple;
	bh=gugZapi3cZAYta1HiNuZBSd/zAeX7lJQFf0IfUkZ4Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qINQwZL+qSdSwftre7tXahX1WvWfdY235dwG8AYMYi8BU+ua0oiTzvqmNDpk9LdMYDRlKcIcUXmGlrOGoWML5sp0ZTQ5YAgsSUAurCMDoqwbUXfLlpMa8vHFz6j+ZOSNTIfXrzZgmqQaWBWJV7EbncP78xrfIirOkMfFIfhdIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lzckW9eu; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 24 Sep 2024 22:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727232494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yKijGDqskvNDbN8KDSCURpOXQD6HJdnMiOeP2iC+QNg=;
	b=lzckW9euTuzFv0w7nskTFoh97KGubTQCnlUGdB7tfN7bO7KFlQ2He3//6nPauvI7zFlB9s
	N0ohG1new579m0NP6sKob9/gdSUCCauPqygVlWbm42/F0w3atobxVFHnK5uSljMl32xWRf
	A4IKVbBrgV3jUkN0c1y5bG1go9wAbCY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>, Thomas Graf <tgraf@suug.ch>, 
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
Message-ID: <jeyayqez34guxgvzf4unzytbfgjv2thgrha5miul25y4eearp2@33junxiz2o7f>
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area>
 <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
 <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
 <ZvI4N55fzO7kg0W/@dread.disaster.area>
 <CAHk-=wjNPE4Oz2Qn-w-mo1EJSUCQ+XJfeR3oSgQtM0JJid2zzg@mail.gmail.com>
 <ZvNWqhnUgqk5BlS4@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvNWqhnUgqk5BlS4@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

+cc rhashtable folks for bug report

On Wed, Sep 25, 2024 at 10:17:46AM GMT, Dave Chinner wrote:
> On Tue, Sep 24, 2024 at 09:57:13AM -0700, Linus Torvalds wrote:
> > On Mon, 23 Sept 2024 at 20:55, Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > That's effectively what the patch did - it added a spinlock per hash
> > > list.
> > 
> > Yeah, no, I like your patches, they all seem to be doing sane things
> > and improve the code.
> > 
> > The part I don't like is how the basic model that your patches improve
> > seems quite a bit broken.
> > 
> > For example, that whole superblock list lock contention just makes me
> > go "Christ, that's stupid". Not because your patches to fix it with
> > Waiman's fancy list would be wrong or bad, but because the whole pain
> > is self-inflicted garbage.
> 
> I'm not about to disagree with that assessment.
> 
> > And it's all historically very very understandable. It wasn't broken
> > when it was written.
> > 
> > That singly linked list is 100% sane in the historical context of "we
> > really don't want anything fancy for this". The whole list of inodes
> > for a superblock is basically unimportant, and it's main use (only
> > use?) is for the final "check that we don't have busy inodes at umount
> > time, remove any pending stuff".
> > 
> > So using a stupid linked list was absolutely the right thing to do,
> > but now that just the *locking* for that list is a pain, it turns out
> > that we probably shouldn't use a list at all. Not because the list was
> > wrong, but because a flat list is such a pain for locking, since
> > there's no hierarchy to spread the locking out over.
> 
> Right, that's effectively what the dlist infrastructure has taught
> us - we need some kind of heirarchy to spread the locking over. But
> what that heirachy is for a "iterate every object" list looks like
> isn't really clear cut...

If you think of dlist as just "faster lru list", I think that's a
completely viable approach.

So one thing I've been mulling over is a data structure for efficiently
tracking async op structs - "some async op went out to lunch" is
something that we still have crap debug tooling for, and those bugs take
forever to get fixed. There seems to be an outstanding bug in compaction
or migration that I've seen multiple reports for, and I doubt it's
bcachefs (we're quite standard there) - and it's some async op that
should've released a folio lock but isn't.

And all we need for that is, roughly, an idr with a percpu buffer for
allocating/freeing slots in front. Which would be perfect for shrinker
lists, too: walking the list is a lockless radix tree walk, and
adding/removing entries mostly just hits the percpu buffers.

So now we have another use case for that data structure, so I'll try to
get that done in the near future and see how it does.

> > (We used to have that kind of "flat lock" for the dcache too, but
> > "dcache_lock" went away many moons ago, and good riddance - but the
> > only reason it could go away is that the dcache has a hierarchy, so
> > that you can always lock just the local dentry (or the parent dentry)
> > if you are just careful).
> 
> > 
> > > [ filesystems doing their own optimized thing ]
> > >
> > > IOWs, it's not clear to me that this is a caching model we really
> > > want to persue in general because of a) the code duplication and b)
> > > the issues such an inode life-cycle model has interacting with the
> > > VFS life-cycle expectations...
> > 
> > No, I'm sure you are right, and I'm just frustrated with this code
> > that probably _should_ look a lot more like the dcache code, but
> > doesn't.
> > 
> > I get the very strong feeling that we should have a per-superblock
> > hash table that we could also traverse the entries of. That way the
> > superblock inode list would get some structure (the hash buckets) that
> > would allow the locking to be distributed (and we'd only need one lock
> > and just share it between the "hash inode" and "add it to the
> > superblock list").
> 
> The only problem with this is the size of the per-sb hash tables
> needed for scalability - we can't allocate system sized hash tables
> for every superblock just in case a superblock might be asked to
> cache 100 million inodes. That's why Kent used rhashtables for the
> bcachefs implementation - they resize according to how many objects
> are being indexed, and hence scale both up and down.

I've been noticing rhashtable resize is surprisingly heavy (the default
parameters don't ever shrink the table, which is why it's not seen as
much).

And, when I was torture testing that code I tripped over what appeared
to be an infinite loop in rht_bucket() when a rehsah is in progress,
which I worked around in

  a592cdf5164d bcachefs: don't use rht_bucket() in btree_key_cache_scan()

(because it makes more sense to just not run while rehashing and avoid
the function call overhead of rht_bucket()). If rhashtable folks are
interested in looking at that I have a test that reproduces it.

> So: should we be looking towards gutting the inode cache and so the
> in-memory VFS inode lifecycle tracks actively referenced inodes? If
> so, then the management of the VFS inodes becomes a lot simpler as
> the LRU lock, maintenance and shrinker-based reclaim goes away
> entirely. Lots of code gets simpler if we trim down the VFS inode
> life cycle to remove the caching of unreferenced inodes...

Sounds completely legit to me - except for the weird filesystems. I just
started cscoping and afs at least seems to do iget() without ever
attaching it to a dentry, I didn't look further.

So...

If fs/inode.c is grotty, perhaps it makes sense to start a
fs/inode_rhashtable.c with all the new semantics and convert filesystems
one by one, like we've been doing with the dio code and iomap.

I finally have my head sufficiently around all the weird inode lifetime
rules that I could do it, although it'll be a bit before I'm not
swamped.

