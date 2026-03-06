Return-Path: <linux-fsdevel+bounces-79656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDN9MnUsq2n6aQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 20:35:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29624227159
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 20:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AB973023531
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D7371D09;
	Fri,  6 Mar 2026 19:35:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B22361645;
	Fri,  6 Mar 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825711; cv=none; b=lKLU/nSV1A1kqhoIgXZ0foD1cQs7a5v8FaoV1vDRKeSMfXZIA61dyyXqEYBukWJlsk//JIr1vq3iMq6j3D2Sx1FDD5ZzhgnDUr6VSWuduf6NMIC8t30t7vyZ1iCCQnG3q85P1bFhMdBzhcBGfFumm/4RhFB873384JuhzN7zdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825711; c=relaxed/simple;
	bh=em+r8m4f+3Sy5ULn1/QeoqXkIZf/n01lCAwTN8Rcyxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ulup03qtC/MFN3snxS8/QxuM482wEo754kPpObE2r03rkF9tSHmfetG67x8Npn0eKeiQreQjaxnWaJEYSzpNepu0QNMqdb8YL4OEFWnz+lub1VlpYzPyw2KzJmRRMZbWjw6r53YONUxHxLGuxQPp4koKLAStByGUR6imS/YvgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3658D497;
	Fri,  6 Mar 2026 11:35:01 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F9B83F836;
	Fri,  6 Mar 2026 11:35:04 -0800 (PST)
Date: Fri, 6 Mar 2026 19:35:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry.yoo@oracle.com>, Qing Wang <wangqing7171@gmail.com>,
	syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com,
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org,
	jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, pfalcato@suse.de,
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
	vbabka@suse.cz, Hao Li <hao.li@linux.dev>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Message-ID: <aassZV5PjgFx8dSI@arm.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
 <20260302034102.3145719-1-wangqing7171@gmail.com>
 <20df8dd1-a32c-489d-8345-085d424a2f12@kernel.org>
 <aaeLT8mnMMj_kPJc@hyeyoo>
 <925a916a-6dfb-48c0-985c-0bdfb96ebd26@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925a916a-6dfb-48c0-985c-0bdfb96ebd26@kernel.org>
X-Rspamd-Queue-Id: 29624227159
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oracle.com,gmail.com,syzkaller.appspotmail.com,linux-foundation.org,kernel.org,google.com,lists.sourceforge.net,vger.kernel.org,kvack.org,suse.de,samsung.com,googlegroups.com,suse.cz,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79656-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.919];
	TAGGED_RCPT(0.00)[linux-fsdevel,cae7809e9dc1459e4e63];
	MID_RHS_MATCH_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:39:47PM +0100, Vlastimil Babka (SUSE) wrote:
> On 3/4/26 2:30 AM, Harry Yoo wrote:
> > [+Cc adding Catalin for kmemleak bits]
> > On Mon, Mar 02, 2026 at 09:39:48AM +0100, Vlastimil Babka (SUSE) wrote:
> >> On 3/2/26 04:41, Qing Wang wrote:
> >>> #syz test
> >>>
> >>> diff --git a/mm/slub.c b/mm/slub.c
> >>> index cdc1e652ec52..387979b89120 100644
> >>> --- a/mm/slub.c
> >>> +++ b/mm/slub.c
> >>> @@ -6307,15 +6307,21 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
> >>>  			goto fail;
> >>>  
> >>>  		if (!local_trylock(&s->cpu_sheaves->lock)) {
> >>> -			barn_put_empty_sheaf(barn, empty);
> >>> +			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
> >>> +				barn_put_empty_sheaf(barn, empty);
> >>> +			else
> >>> +				free_empty_sheaf(s, empty);
> >>>  			goto fail;
> >>>  		}
> >>>  
> >>>  		pcs = this_cpu_ptr(s->cpu_sheaves);
> >>>  
> >>> -		if (unlikely(pcs->rcu_free))
> >>> -			barn_put_empty_sheaf(barn, empty);
> >>> -		else
> >>> +		if (unlikely(pcs->rcu_free)) {
> >>> +			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
> >>> +				barn_put_empty_sheaf(barn, empty);
> >>> +			else
> >>> +				free_empty_sheaf(s, empty);
> >>> +		} else
> >>>  			pcs->rcu_free = empty;
> >>>  	}
> >>
> >> I don't think this would fix any leak, and syzbot agrees. It would limit the
> >> empty sheaves in barn more strictly, but they are not leaked.
> >> Hm I don't see any leak in __kfree_rcu_sheaf() or rcu_free_sheaf(). Wonder
> >> if kmemleak lacks visibility into barns or pcs's as roots for searching what
> >> objects are considered referenced, or something?
> > 
> > Objects that are allocated from slab and percpu allocator should be
> > properly tracked by kmemleak. But those allocated with
> > gfpflags_allow_spinning() == false are not tracked by kmemleak.
> > 
> > When barns and sheaves are allocated early (!gfpflags_allow_spinning()
> > due to gfp_allowed_mask) and it skips kmemleak_alloc_recursive(), 
> > it could produce false positives because from kmemleak's point of view,
> > the objects are not reachable from the root set (data section, stack,
> > etc.).
> 
> Good point.
> 
> > To me it seems kmemleak should gain allow_spin == false support
> > sooner or later.
> 
> Or we figure out how to deal with the false allow_spin == false during
> boot. Here I'm a bit confused how exactly it happens because AFAICS in
> slub we apply gfp_allowed_mask only when allocating a new slab, and in
> slab_post_alloc_hook() we apply it to init_mask. That is indeed passed
> to kmemleak_alloc_recursive() but not used for the
> gfpflags_allow_spinning() decision. kmemleak_alloc_recursive() should
> succeed because nobody should be holding any locks that would require
> spinning.

I don't fully understand what goes on. If kmemleak_alloc_recursive()
failed to allocate for some reason (other than SLAB_NOLEAKTRACE), it
would loudly disable kmemleak altogether and stop reporting leaks. Also
kmemleak doesn't care about allow_spin, it's only the slub code which
avoids calling kmemleak if spinning not allowed (as it takes some locks,
may call back into the slab allocator).

I wonder whether some early kmem_cache_node allocations like the ones in
early_kmem_cache_node_alloc() are not tracked and then kmemleak cannot
find n->barn. I got lost in the slub code, but something like this:

-----------8<-----------------------------------
diff --git a/mm/slub.c b/mm/slub.c
index 0c906fefc31b..401557ff5487 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7513,6 +7513,7 @@ static void early_kmem_cache_node_alloc(int node)
 	slab->freelist = get_freepointer(kmem_cache_node, n);
 	slab->inuse = 1;
 	kmem_cache_node->node[node] = n;
+	kmemleak_alloc(n, sizeof(*n), 1, GFP_NOWAIT);
 	init_kmem_cache_node(n, NULL);
 	inc_slabs_node(kmem_cache_node, node, slab->objects);
 
-------------8<----------------------------------------

Another thing I noticed, not sure it's related but we should probably
ignore an object once it has been passed to kvfree_call_rcu(), similar
to what we do on the main path in this function. Also see commit
5f98fd034ca6 ("rcu: kmemleak: Ignore kmemleak false positives when
RCU-freeing objects") when we added this kmemleak_ignore().

---------8<-----------------------------------
diff --git a/mm/slab_common.c b/mm/slab_common.c
index d5a70a831a2a..73f4668d870d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1954,8 +1954,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr)) {
+		/*
+		 * The object is now queued for deferred freeing via an RCU
+		 * sheaf. Tell kmemleak to ignore it.
+		 */
+		kmemleak_ignore(ptr);
 		return;
+	}
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
----------------8<-----------------------------------

-- 
Catalin

