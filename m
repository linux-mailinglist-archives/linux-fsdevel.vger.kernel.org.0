Return-Path: <linux-fsdevel+bounces-74981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APUJEGfCcWmdLwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:23:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0081E623B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 07:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0FF974C6C2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 06:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9A130EF80;
	Thu, 22 Jan 2026 06:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PHWsK/cV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919047DD7C;
	Thu, 22 Jan 2026 06:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769063002; cv=none; b=q2Pu/VPAuszn8OSQorv7N9D5BXPmj4zre5xrrV5KZtu8nRUBKw71JJ3GcRBCaQs3lFp/PMZQ8IJ7W5tpz+K8p0CsTeG1+AxiW3Bx6c9jviERtlSzNIfnoadNgcZeUcAMor7j80VUKDVZF4sb6Ut6EJLLvjsGBXfCummU5/v4X64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769063002; c=relaxed/simple;
	bh=OcQhZTX+aGOePXebaqBvOi0aOCI81xsm8N/tmlH+IaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXZUKaXUg+E3Bm2gbJhAxQAVmv7BIzcOHsfZ6mD1+TvKa8YScpDVCSDnNRoI6nTzcOjeQLLi/cKRw213lwT4ziaUvh6D6fXxMMUhKswaIsL5Z0FnaUmUM8bQ8dWafJwHYy4SgMC7diS0StCyhAK+QT85q6oLupQQHGovQQDvEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PHWsK/cV; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YmbACIStS/DUJQ4c1zuLR6yFwGfpLhnIlfpJY2SkgKg=; b=PHWsK/cVz1pt9+aOqd6BEmVyT4
	JqIhj5bDyvspsr+sKsD9CLlIeuXKJlBBkd84owqc0NDvGZqziPOddiT84jWio+yg1fy220NcF0l52
	Iirt+Ey6z36r3D28xWN5aPiLWrqTYDqxPUUiDOKzbG6Bl+mSc8NwKYkfzyEp31D1g1CvvCcEFCX/z
	TyG5J5nE65Ssf8KwtKTIhIzTmGtKB9uRMQwZDJUGQ/+7tCbJFjB9YtVChr9ohXFcaCx+PD7O73SHv
	zFYBPE2yN/kYvty1xgnz2Y9R4fOeNmJHaaXEpu6vF7OuGNmDbBiU0tBIBJKnStlMSGRzeAH0m5IRK
	vQpxNTXw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vio7m-0000000Dyq6-0UPp;
	Thu, 22 Jan 2026 06:24:58 +0000
Date: Thu, 22 Jan 2026 06:24:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/21] __dentry_kill(): new locking scheme
Message-ID: <20260122062458.GA3330204@ZenIV>
References: <20250707204918.GK1880847@ZenIV>
 <CAKPOu+9qpqSSr300ZDduXRbj6dwQo8Cp2bskdS=gfehcVx-=ug@mail.gmail.com>
 <20250707205952.GL1880847@ZenIV>
 <CAKPOu+8zjtLkjYzCCVyyC80YgekMws4vGOvnPLjvUiQ6zWaqaA@mail.gmail.com>
 <20250707213214.GM1880847@ZenIV>
 <CAKPOu+-JxtBnjxiLDXWFNQrD=4dR_KtJbvEdNEzJA33ZqKGuAw@mail.gmail.com>
 <20250707221917.GO1880847@ZenIV>
 <20250707223753.GQ1880847@ZenIV>
 <CAKPOu+9=AV-NxJYXjwiUL4iXPH=oUSF25+6t25M8ujfj2OvHVQ@mail.gmail.com>
 <20260121215550.GD3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121215550.GD3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74981-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[zeniv.linux.org.uk,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 0081E623B0
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 09:55:50PM +0000, Al Viro wrote:

> It's not so much an intention as having nothing good to wait on.
> 
> Theoretically, there's a way to deal with that - dentry in the middle
> of stuck iput() from dentry_unlink_inode() from __dentry_kill() is
> guaranteed to be
> 	* negative
> 	* unhashed
> 	* not in-lookup
> 
> What we could do is adding an hlist_head aliased with ->d_alias, ->d_rcu
> and ->d_in_lookup_hash.  Then select_collect2() running into a dentry
> with negative refcount would set _that_ as victim and bugger off, same
> as we do for ones on shrink lists.

No need to bother with hlist - all we need is a single-linked list that
does not need to be generic.  Variant below seems to survive the local
beating...

From 4d1f759a6338703f07a27a4d8e5814604968fb5b Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed, 21 Jan 2026 18:17:12 -0500
Subject: [PATCH] get rid of busy-waiting in shrink_dcache_parent()

There's a case in which shrink_dcache_parent() ends up busy-waiting:
if some dentry in the subtree in question is found to be in process
of being evicted by another thread.  We need to wait for that to
finish so that parent would no longer be pinned; otherwise we'd end
up with ridiculous situation - nothing in a subtree is busy, and call
of shrink_dcache_parent() fails to evict some directory only because
memory pressure initiated eviction of some of its children before we
got to those.

The reason why we busy-wait is the lack of anything convenient we could
wait on.  That can be fixed, though, and without growing struct dentry.

Dentries in question are
	* already marked dead (negative ->d_count)
	* already negative
	* already unhashed
	* already not in in-lookup hash
	* yet to get removed from ->d_sib and get DCACHE_DENTRY_KILLED in
flags.

Neither ->d_alias nor the fields overlapping it (->d_rcu and ->d_in_lookup_hash)
are going to be accessed for these dentries until after dentry_unlist().  What's
more, ->d_alias.next is guaranteed to be NULL.

So we can embed struct completion into struct select_data and (ab)use
->d_alias.next for linked list of struct select_data instances.

If dentry_unlist() finds ->d_alias.next non-NULL, it carefully goes over
the list and calls complete() for each of those.

That way select_collect2() can treat negative ->d_count the same way it
deals with dentries on other thread's shrink list - grab rcu_read_lock(),
stash dentry into data.victim and tell d_walk() to stop.

Should shrink_dcache_parent() run into that case, it would attach its
select_data to victim dentry, drop whatever normal eviction candidates
it has gathered and wait for completion.  Voila...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 84 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index cf865c12cdf9..283c8ab767e1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -605,6 +605,54 @@ void d_drop(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_drop);
 
+struct select_data {
+	struct dentry *start;
+	union {
+		long found;
+		struct {
+			struct dentry *victim;
+			struct select_data *next;
+			struct completion completion;
+		};
+	};
+	struct list_head dispose;
+};
+
+/*
+ *  shrink_dcache_parent() needs to be notified when dentry in process of
+ *  being evicted finally gets unlisted.  Such dentries are
+ *	already with negative ->d_count
+ *	already negative
+ *	already not in in-lookup hash
+ *	reachable only via ->d_sib.
+ *
+ *  Neither ->d_alias, nor ->d_rcu, nor ->d_in_lookup_hash are going to be
+ *  accessed for those, so we can (ab)use ->d_alias.next for list of
+ *  select_data of waiters.  Initially it's going to be NULL and as long
+ *  as dentry_unlist() returns it to that state we are fine.
+ */
+static inline void d_add_waiter(struct dentry *dentry, struct select_data *p)
+{
+	struct select_data *v = (void *)dentry->d_u.d_alias.next;
+	init_completion(&p->completion);
+	p->next = v;
+	dentry->d_u.d_alias.next = (void *)p;
+}
+
+static inline void d_complete_waiters(struct dentry *dentry)
+{
+	struct select_data *v = (void *)dentry->d_u.d_alias.next;
+	if (unlikely(v)) {
+		/* some shrink_dcache_tree() instances are waiting */
+		dentry->d_u.d_alias.next = NULL;
+		while (v) {
+			struct completion *r = &v->completion;
+			v = v->next;
+			complete(r);
+		}
+	}
+}
+
 static inline void dentry_unlist(struct dentry *dentry)
 {
 	struct dentry *next;
@@ -613,6 +661,7 @@ static inline void dentry_unlist(struct dentry *dentry)
 	 * attached to the dentry tree
 	 */
 	dentry->d_flags |= DCACHE_DENTRY_KILLED;
+	d_complete_waiters(dentry);
 	if (unlikely(hlist_unhashed(&dentry->d_sib)))
 		return;
 	__hlist_del(&dentry->d_sib);
@@ -1499,15 +1548,6 @@ int d_set_mounted(struct dentry *dentry)
  * constraints.
  */
 
-struct select_data {
-	struct dentry *start;
-	union {
-		long found;
-		struct dentry *victim;
-	};
-	struct list_head dispose;
-};
-
 static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 {
 	struct select_data *data = _data;
@@ -1559,6 +1599,10 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 			return D_WALK_QUIT;
 		}
 		to_shrink_list(dentry, &data->dispose);
+	} else if (dentry->d_lockref.count < 0) {
+		rcu_read_lock();
+		data->victim = dentry;
+		return D_WALK_QUIT;
 	}
 	/*
 	 * We can return to the caller if we have found some (this
@@ -1598,12 +1642,26 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 		data.victim = NULL;
 		d_walk(parent, &data, select_collect2);
 		if (data.victim) {
-			spin_lock(&data.victim->d_lock);
-			if (!lock_for_kill(data.victim)) {
-				spin_unlock(&data.victim->d_lock);
+			struct dentry *v = data.victim;
+
+			spin_lock(&v->d_lock);
+			if (v->d_lockref.count < 0 &&
+			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
+				// It's busy dying; have it notify us once
+				// it becomes invisible to d_walk().
+				d_add_waiter(v, &data);
+				spin_unlock(&v->d_lock);
+				rcu_read_unlock();
+				if (!list_empty(&data.dispose))
+					shrink_dentry_list(&data.dispose);
+				wait_for_completion(&data.completion);
+				continue;
+			}
+			if (!lock_for_kill(v)) {
+				spin_unlock(&v->d_lock);
 				rcu_read_unlock();
 			} else {
-				shrink_kill(data.victim);
+				shrink_kill(v);
 			}
 		}
 		if (!list_empty(&data.dispose))
-- 
2.47.3


