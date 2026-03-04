Return-Path: <linux-fsdevel+bounces-79447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id r0chHzLCqGkIxAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 00:37:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7071208FD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 00:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85EDC30774DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 23:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D607372EDB;
	Wed,  4 Mar 2026 23:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMTr7qNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F6280A5B
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667407; cv=none; b=h/0FewSJjPoFuNpJLJUDuqrmrJcMZz+V58eGGBEq5FdIo/3WZy6ch+LgMGqGsGZjgD6ivgAH4j4T6+jJBknw51Gi/gX2gLT+2cRIZB586xUNwiuWxscUBu9xaVjrWrMs93lWl1jWaip158cYU3dtigW4oZujTkc8ALexc+fcjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667407; c=relaxed/simple;
	bh=ypEQk3RVqRLldhEd8CSZmPhnSpe47dPMerOMn6/YfJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcUTwQAePRy0/2BOsOnZqr27HtdsVz/6xbzkp72zjJVnAyusNYSAigR4U38Yn39AiX1PWIrOnCyF3+4peTcfGw1nNRZD+v9ofmAFlRuowORhiB+C/M3Af6f7hdOgwlU4jjE99ieslr9uTAlcza+DHxjyZP6kpK4lxGMUHEtCC7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMTr7qNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC6C2BC86
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 23:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772667407;
	bh=ypEQk3RVqRLldhEd8CSZmPhnSpe47dPMerOMn6/YfJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMTr7qNzN1KNVffH5IIBJFsV3ewl5+wShHB7Dt81JnEZ+WznMIuA7+SO8yNd6vW0G
	 s+lyYr43OvhDhgb0Zo1/KeIISNIwXJjE0nLc4eJu0K64FXPEaTKDAkxiqCl+qdk/tK
	 +XO8gP0pS+tcF0X+mXkaOyXVVsWa7d4CDuO/18ScV+8e1a+4uju87s+YyG8lv1Gfh2
	 NE6rNkFPL/6eKiHP4at6+em94J9Lin32ibYZCN5jM0XBB7WOWKjPNULszEVPFzNyE7
	 J1bjpDRq4IuGNDHcGfq+eTi+UkKtAhtPbAg9y3gFzLJp1I836+d6fkhgD4RRIGRqib
	 vNL2ImPi3TblA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2A9D6F40069;
	Wed,  4 Mar 2026 18:36:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 04 Mar 2026 18:36:46 -0500
X-ME-Sender: <xms:DsKoaf1VexCTVtghd6A8OBQUZpR5RZRYlx0f2OsKpp8pOuE5CKR7Yg>
    <xme:DsKoaZ-95XXVSsdwGxVkFi5RYgQD6BttmANv_Sh72Gi5uUS_Y-9YwyRyXWywFtYSC
    iGNxzrNTaELi4Iq8dpZEdsb1UYu9CZm1pfttYtdKO79MZZb0khjQA>
X-ME-Received: <xmr:DsKoac6xjRsD7oK6xFFbGE2BeymMPQ4qjG9RivfRD2bvsr5_irC0T6n9rzA2Gu78y71eX1r2tZ3K3udwmUC-iBCzOMyVSZKl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    eifeeuleefudevleevhfehkeffuedttdetjeetgfejtdejfeeltdekhfevleelheenucff
    ohhmrghinhepfigrihhtpghquhgvuhgvpghhvggrugdrshhonecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsoh
    hquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    ohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhhitggvrhihhhhlse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdrtghomhdprhgtphhtth
    hopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgr
    rhihghhuohdrnhgvthdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopegtmhhllhgrmhgrshesghhoohhglhgvrdgtohhm
    pdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:DsKoaZszLVRV6rNP39CSC1IIbNS7s2pNT0IMXtgCRUFI1ILG0lBe0g>
    <xmx:DsKoaW100Tgc-DW79uUvRssyCuVJyy4FKLL78S4Z2F1zScl5P6CLxA>
    <xmx:DsKoaaq98mwppjN8DjfBF2B1dyOlYjkK7Y90nCvN5TmOaYDmCl_9iA>
    <xmx:DsKoaeITBAXEe2ZjS-lsGRBbqNEcSAZiSzo4_bm9F9RVZJOEH00Few>
    <xmx:DsKoaeRU8EeDR3HvqJcLH0pLoOIpDIE6Nr-VAzhevLNv6AkU7h4sqdf4>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 18:36:45 -0500 (EST)
Date: Wed, 4 Mar 2026 15:36:44 -0800
From: Boqun Feng <boqun@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Carlos Llamas <cmllamas@google.com>, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rust: poll: make PollCondVar upgradable
Message-ID: <aajCDJj3dS90JtYd@tardis.local>
References: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
 <20260213-upgrade-poll-v2-1-984a0fb184fb@google.com>
 <aadbyBmaV8zCYiog@tardis.local>
 <aafmf5icyPIFcwf_@google.com>
 <aahd2DIXFJiUKy0S@tardis.local>
 <aaimKbwAbPfBUPG6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaimKbwAbPfBUPG6@google.com>
X-Rspamd-Queue-Id: E7071208FD1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,linuxfoundation.org,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-79447-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:37:45PM +0000, Alice Ryhl wrote:
> On Wed, Mar 04, 2026 at 08:29:12AM -0800, Boqun Feng wrote:
> > On Wed, Mar 04, 2026 at 07:59:59AM +0000, Alice Ryhl wrote:
> > [...]
> > > > > +        // If a normal waiter registers in parallel with us, then either:
> > > > > +        // * We took the lock first. In that case, the waiter sees the above cmpxchg.
> > > > > +        // * They took the lock first. In that case, we wake them up below.
> > > > > +        drop(lock.lock());
> > > > > +        self.simple.notify_all();
> > > > 
> > > > Hmm.. what if the waiter gets its `&CondVar` before `upgrade()` and use
> > > > that directly?
> > > > 
> > > > 	<waiter>				<in upgrade()>
> > > > 	let poll_cv: &UpgradePollCondVar = ...;
> > > > 	let cv = poll_cv.deref();
> > > > 						cmpxchg();
> > > > 						drop(lock.lock());
> > > > 						self.simple.notify_all();
> > > > 	let mut guard = lock.lock();
> > > > 	cv.wait(&mut guard);
> > > > 
> > > > we still miss the wake-up, right?
> > > > 
> > > > It's creative, but I particularly hate we use an empty lock critical
> > > > section to synchronize ;-)
> > > 
> > > I guess instead of exposing Deref, I can just implement `wait` directly
> > > on `UpgradePollCondVar`. Then this API misuse is not possible.
> > > 
> > 
> > If we do that,then we can avoid the `drop(lock.lock())` as well, if we
> > do:
> > 
> >     impl UpgradePollCondVar {
> >         pub fn wait(...) {
> > 	    prepare_to_wait_exclusive(); // <- this will take lock in
> >                                          // simple.wait_queue_head. So
> >                                          // either upgrade() comes
> >                                          // first, or they observe the
> >                                          // wait being queued.
> >             let cv_ptr = self.active.load(Relaxed);
> > 	    if !ptr_eq(cv_ptr, &self.simple) { // We have moved from
> > 	                                       // simple, so need to
> >                                                // need to wake up and
> >                                                // redo the wait.
> > 	        finish_wait();
> > 	    } else {
> > 	        guard.do_unlock(|| { schedule_timeout(); });
> > 		finish_wait();
> > 	    }
> > 	}
> >     }
> > 
> > (CondVar::notify*() will take the wait_queue_head lock as well)
> 
> Yeah but then I have to actually re-implement those methods and not just
> call them. Seems not worth it.
> 

We can pass a closure to wait_*() as condition:

    fn wait_internal<T: ?Sized, B: Backend>(
        &self,
        wait_state: c_int,
        guard: &mut Guard<'_, T, B>,
        cond: Some(FnOnce() -> bool),
        timeout_in_jiffies: c_long,
    ) -> c_long {

I'm not just suggesting this because it helps in this case. In a more
general pattern (if you see ___wait_event() macro in
include/linux/wait.h), the condition checking after prepare_to_wait*()
is needed to prevent wake-up misses. So maybe in long-term, we will have
the case that we need to check the condition for `CondVar` as well.

Plus, you don't need to pass a &Lock to poll() if you do this ;-)

> > > > Do you think the complexity of a dynamic upgrading is worthwhile, or we
> > > > should just use the box-allocated PollCondVar unconditionally?
> > > > 
> > > > I think if the current users won't benefit from the dynamic upgrading
> > > > then we can avoid the complexity. We can always add it back later.
> > > > Thoughts?
> > > 
> > > I do actually think it's worthwhile to consider:
> > > 
> > > I started an Android device running this. It created 3961 instances of
> > > `UpgradePollCondVar` during the hour it ran, but only 5 were upgraded.
> > > 
> > 
> > That makes sense, thank you for providing the data! But still I think we
> > should be more informative about the performance difference between
> > dynamic upgrading vs. unconditionally box-allocated PollCondVar, because
> > I would assume when a `UpgradePollCondVar` is created, other allocations
> > also happen as well (e.g. when creating a Arc<binder::Thread>), so the
> > extra cost of the allocation may be unnoticeable.
> 
> Perf-wise it doesn't matter, but I'm concerned about memory usage.
> 

Let's see, we are comparing the memory cost between:

(assuming on a 64-bit system, and LOCKDEP=n)

    struct UpgradePollCondVar {
        simple: CondVar,        // <- 24 bytes (1 spinlock + 2 pointers)
        active: Atomic<*const UpgradePollCondVarInner>, // <- 8 bytes.
                                                        // but +40 extra
                                                        // bytes on the
                                                        // heap in the
                                                        // worst case.
    }

vs

    struct BoxedPollCondVar {
        active: Box<UpgradePollCondVarInner>, // <- 8 bytes, but +40
                                              // extra bytes on the heap
    }

that's extra 16 bytes per binder::Thread, but binder::Thread itself is
more than 100 bytes. Of course it's up to binder whether 16 bytes per
thread is a lot or not, but to me, I would choose the simplicity ;-)

Regards,
Boqun

> Alice

