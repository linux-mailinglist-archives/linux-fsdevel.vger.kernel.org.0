Return-Path: <linux-fsdevel+bounces-75343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E4PKFOxLdGmT4QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 05:34:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D678C7C7D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 05:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36DD93009F02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 04:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA052F28FB;
	Sat, 24 Jan 2026 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uRlkJlA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3343913AD05
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769229285; cv=none; b=Q7J2DMCQtPDMsXcU2NOifqljcVNE6fOx7qElky0O5GtK+6lH1A648YwOhumC4IB0vN0dFo+LlPwIwG7aZ8mMcGC9uUf5i5UmDoP/hfVlN9fqFt4oXGV3Rq49BntMusuVHD5pq0+BfawihsRTSLvrxV4lQGNYCBDRTxpyD6Jjj3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769229285; c=relaxed/simple;
	bh=HQU9RkWG+vm+z/BaD6LwUP9sfhblOHjuVjB2MrhdIsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrEN5PR5D6uSZEy89ey5+4xq9QolN0NzHPpnWPTkEss/KvS8imuN6uYq7Plb9Hv2JTcWORU2Ha5FfpAJsM/d2KcU/D9SXFTvGGrqWXGCe6SLsccwuGjUQb4jGwEqa+E+PFkIQVW/aNRiSCqlBc2Ls6rMXjeLWBKpHz11Gc6I2d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uRlkJlA/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cBzYqeKLMOB03tbdbxvRvIWAI+SL7cLOtXoR1TIMhIY=; b=uRlkJlA/fPcgb2bZh9yKxvMeDO
	oT7BifUMauNbtoERotMbXXrlMLwu8LtGK+Ig29gfEZB7Ht9uKEz5vUtwaigyhY9HEVh+m/tX7p+jw
	ROqlU1WsdV//l5pihqhZHwPJsWfY6vMD4scWw2gGfwmgRWIZ1ySN3NBNe++hY8zr1fnndv3/QAe3i
	V3Zo8E76tnM8SP+eTISrQNfaWyRU18GnGoX6uWI9Lax9ow4GgE95AvA5jzCegnNO7mPiYUFyDjeb5
	KqImkJJG6e+OMiBgeXFaIDshe9Z/wLdUctZNDD4D/f43TDLJabyCCsxXK+Dg+T8UAXJ3VyRMgcdMr
	BgecobbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vjVNn-00000002SDQ-3wV2;
	Sat, 24 Jan 2026 04:36:24 +0000
Date: Sat, 24 Jan 2026 04:36:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
Message-ID: <20260124043623.GK3183987@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
 <20260123003651.GH3183987@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123003651.GH3183987@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75343-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,linux.org.uk:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D678C7C7D6
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:36:51AM +0000, Al Viro wrote:
> On Thu, Jan 22, 2026 at 04:19:56PM -0800, Linus Torvalds wrote:
> > On Thu, 22 Jan 2026 at 12:18, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > +static inline void d_add_waiter(struct dentry *dentry, struct select_data *p)
> > > +{
> > > +       struct select_data *v = (void *)dentry->d_u.d_alias.next;
> > > +       init_completion(&p->completion);
> > > +       p->next = v;
> > > +       dentry->d_u.d_alias.next = (void *)p;
> > > +}
> > 
> > I tend to not love it when I see new users of completions - I've seen
> > too many mis-uses - but this does seem to be a good use-case for them.
> > 
> > That said, I absolutely abhor your cast. Christ - that 'd_u' is
> > *already* a union, exactly because that thing gets used for different
> > things - just add a new union member, instead of mis-using an existing
> > union member that then requires you to cast the data to a different
> > form.
> > 
> > Yes, you had an explanation for why you used d_alias.next, but please
> > make that explanation be in the union itself, not in the commit
> > message of something that mis-uses the union. Please?
> > 
> > That way there's no need for a cast, and you can name that new union
> > member something that also clarifies things on a source level
> > ("eviction_completion" or whatever).
> > 
> > Or am I missing something?
> 
> In practice it doesn't really matter, but we don't want to initialize
> that field to NULL - no good place for doing that.  Sure, the entire
> d_alias has been subject to hlist_del_init() or INIT_HLIST_NODE(), so
> any pointer field unioned with it will end up being NULL without
> any assignments to it, but...  ugh.  "We have a union of two-pointer
> struct, a pointer and some other stuff; we'd set both members of that
> struct member to NULL and count upon the pointer member of union
> having been zeroed by that" leaves a bad taste.

FWIW, there's another reason, but it's not one I'm fond of.  There are few
places where we use hlist_unhashed(&dentry->d_u.d_alias) as a debugging
check.  I _think_ that none of those are reachable for dentries in that state,
but then all of them are of "it should evaluate true unless we have a kernel
bug" kind.

I'm not saying it's a good reason.  As the matter of fact, the tests are
misspelled checks for dentry being negative.  _If_ we kill those, we
could declare the state of ->d_u.d_alias undefined for negative dentries
and have transitions to that state explicitly clear the new field instead.
IOW, hlist_del_init() in dentry_unlink_inode() becomes
	__hlist_del(&dentry->d_u.d_alias);	// !hlist_unhashed() guaranteed
	dentry->d_u.shrink_waiters = NULL;
INIT_HLIST_NODE(&dentry->d_u.d_alias) in __d_alloc() and __d_lookup_unhash() simply
	dentry->d_u.shrink_waiters = NULL;
Then we are out of the nasal demon country.

Debugging tests are interesting, though.  We have them in
	dentry_free() - WARN_ON if on alias list; what we want is rather "have
DENTRY_KILLED in flags", and I would probably add "no PERSISTENT" as well as
"no LRU_LIST" there.
	d_instantiate(), d_instantiate_new(), d_make_persistent(), d_mark_tmpfile() -
a mix of WARN_ON() and BUG_ON(); in all cases it should be "it must be negative
here", and in all cases it's done before ->d_lock is taken.  Not wanting an oops
while holding ->d_lock (or ->i_lock, for that matter) on anything is understandable,
and stability is actually provided by the callers, but... it's still confusing
for readers, especially since the real proof of stability is nowhere near trivial.
I'd probably go for d_really_is_negative() in all of those; it might make sense to
unify some of that boilerplate, but that's for the next cycle...

