Return-Path: <linux-fsdevel+bounces-79428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOSALvxiqGlauQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:51:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD42049A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 17:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBCBF3176E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 16:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD8E366837;
	Wed,  4 Mar 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7I/aSaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E67A366043
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 16:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641755; cv=none; b=swX9uM7qmwUZ96RmJBA95vepXlupbWl+pZ3aLEN0U7+/Wmps8g+wudYP7rnm0kwW3m+kl/et5rgTgmhel8SP77AZ0u+7ZrqAcfejW6aH4H+JaIvOHAftR3Kzca0bah6IXQhTYTKh4ZCG3dqm4708QK654lzTqsF6wOl3TKn30Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641755; c=relaxed/simple;
	bh=03B2sII/wLyEEQmGcMTzXqixo/P52R1q/pDe72u3uUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPPqUeJ5ppkuLrEp+rgU1s6EFecX3f4JkWIACPFkoC+q6F/1vPqojkg2TscB2E6JF9vXVi8IRveCOXHSl+goUFnEUqgZqaXiwBe4JLE4IwseuTSumhgem2y2SrKhvyUZo/HBpbYHXB6MUOnZHCSR564Huc85wlbD6yTVX70pbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7I/aSaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8106AC2BC87;
	Wed,  4 Mar 2026 16:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772641754;
	bh=03B2sII/wLyEEQmGcMTzXqixo/P52R1q/pDe72u3uUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U7I/aSaZjksmqdFsuoGPl7phg5SnEmDx59qYo9qSqetn0Onnr3hwW2W39/KDSPU6I
	 43PAeMfRQFt1Y4X9g+u2ek0UpY5jSKt2CkjMcnA/IxREETPMaPlGGWO00ttINnxvs3
	 qiky8hF9gm9qhqHB2O7SLbEEkPkM9+TPcWgf65WK2Qr3SXaTfZBLH5B3W3Ht+UOrYT
	 khjHt3r1bwcuSK08FzEeAHrQt7ymoWKNtirfOU26cySiIZYTRqL2dUVkTU1W89rfGp
	 KvhiOrkP6CJJRs5VBTTwUHtcSB+6EAoRFhoCSOcp5uYLYNP3tqMmNTX+f/p+4YjZBH
	 G4IRJKZMN5tfw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A18D3F4006C;
	Wed,  4 Mar 2026 11:29:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Mar 2026 11:29:13 -0500
X-ME-Sender: <xms:2V2oaWFEpzPKQB65tFqiAetm6ASKMt3McZPLgknXwlweO4oQFQs9NA>
    <xme:2V2oaTMW-GOZcVv8eNDYGspbZDvW3IMxLXGulTcnHu9Db4bNKQCyAmPg6Jgmy27T0
    Nb2QagbfqUtDZqj7UBMwnEdowVm8tkrgcoiHeeoYQSW3-VrowL7>
X-ME-Received: <xmr:2V2oadJgYvVOsfZdPooT_eftF64GjX2K6uZQMCEj45nOZKPEeBxYNTzOOnkS4lNFdfZ1lqvxfuXtICBkPVB3VqdKvFI15exL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieefleejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2V2oaU9QqfhExU2v4VDZK1zqcUkXrY2K3umrRDRYlLbegAoJ3Fy36w>
    <xmx:2V2oaRFlY1FUokX_bZko6isqVcLUGMCrs0lF4tmSBjKWAINgMdUD7A>
    <xmx:2V2oaX6LeRCm-VgNJDT2GOrI-_kJ3bcr2FcvoYI6odlDXT1apeqVwg>
    <xmx:2V2oaSYvxlmRE29RUGjlFxnrYyRecOpjq9wjxxoDYGnrERdLbUyrAg>
    <xmx:2V2oadgIxd0Y7VYD80KpRnub66mrcmuNjpWOhu46-zScsnmRXby3Z9vV>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 11:29:13 -0500 (EST)
Date: Wed, 4 Mar 2026 08:29:12 -0800
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
Message-ID: <aahd2DIXFJiUKy0S@tardis.local>
References: <20260213-upgrade-poll-v2-0-984a0fb184fb@google.com>
 <20260213-upgrade-poll-v2-1-984a0fb184fb@google.com>
 <aadbyBmaV8zCYiog@tardis.local>
 <aafmf5icyPIFcwf_@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aafmf5icyPIFcwf_@google.com>
X-Rspamd-Queue-Id: 36CD42049A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,linuxfoundation.org,google.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tardis.local:mid];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-79428-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

On Wed, Mar 04, 2026 at 07:59:59AM +0000, Alice Ryhl wrote:
[...]
> > > +        // If a normal waiter registers in parallel with us, then either:
> > > +        // * We took the lock first. In that case, the waiter sees the above cmpxchg.
> > > +        // * They took the lock first. In that case, we wake them up below.
> > > +        drop(lock.lock());
> > > +        self.simple.notify_all();
> > 
> > Hmm.. what if the waiter gets its `&CondVar` before `upgrade()` and use
> > that directly?
> > 
> > 	<waiter>				<in upgrade()>
> > 	let poll_cv: &UpgradePollCondVar = ...;
> > 	let cv = poll_cv.deref();
> > 						cmpxchg();
> > 						drop(lock.lock());
> > 						self.simple.notify_all();
> > 	let mut guard = lock.lock();
> > 	cv.wait(&mut guard);
> > 
> > we still miss the wake-up, right?
> > 
> > It's creative, but I particularly hate we use an empty lock critical
> > section to synchronize ;-)
> 
> I guess instead of exposing Deref, I can just implement `wait` directly
> on `UpgradePollCondVar`. Then this API misuse is not possible.
> 

If we do that,then we can avoid the `drop(lock.lock())` as well, if we
do:

    impl UpgradePollCondVar {
        pub fn wait(...) {
	    prepare_to_wait_exclusive(); // <- this will take lock in
                                         // simple.wait_queue_head. So
                                         // either upgrade() comes
                                         // first, or they observe the
                                         // wait being queued.
            let cv_ptr = self.active.load(Relaxed);
	    if !ptr_eq(cv_ptr, &self.simple) { // We have moved from
	                                       // simple, so need to
                                               // need to wake up and
                                               // redo the wait.
	        finish_wait();
	    } else {
	        guard.do_unlock(|| { schedule_timeout(); });
		finish_wait();
	    }
	}
    }

(CondVar::notify*() will take the wait_queue_head lock as well)

> > Do you think the complexity of a dynamic upgrading is worthwhile, or we
> > should just use the box-allocated PollCondVar unconditionally?
> > 
> > I think if the current users won't benefit from the dynamic upgrading
> > then we can avoid the complexity. We can always add it back later.
> > Thoughts?
> 
> I do actually think it's worthwhile to consider:
> 
> I started an Android device running this. It created 3961 instances of
> `UpgradePollCondVar` during the hour it ran, but only 5 were upgraded.
> 

That makes sense, thank you for providing the data! But still I think we
should be more informative about the performance difference between
dynamic upgrading vs. unconditionally box-allocated PollCondVar, because
I would assume when a `UpgradePollCondVar` is created, other allocations
also happen as well (e.g. when creating a Arc<binder::Thread>), so the
extra cost of the allocation may be unnoticeable.

Regards,
Boqun


> Alice

