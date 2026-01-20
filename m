Return-Path: <linux-fsdevel+bounces-74646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJt3Ar1wcWkPHAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:35:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C95FF77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46118A9E9C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 13:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484DA426D19;
	Tue, 20 Jan 2026 13:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYdJ0W+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2A3E9F6E
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916788; cv=none; b=LxVb6mbEiqzUhZZVLmaadf6k/NZFilkebPYVWUj4Yf//sRjkIQLrvbyNFkIcZu/ViGyIyC6m6YWIJcxIUktsLkRE+OcF7tFJjXM8w4S1BgUh+hQD66yWWwlzzYgafykSKPenn+ZniWa2sEDQc+9pzYTordPFFoGMH0N4lFUqOSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916788; c=relaxed/simple;
	bh=y2corVxRFZhp6KNK2+4uobUAAg4FYICr7oMYMY/v8wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJWijX0JFsQoW2gD32fGgZFtujpfZa6F99NhVw+InOJCw9Rq/4cibOl3AA0I26l/S2cnL08Q0E1q7URhRY3fZ7QZi9khmqdwEbMOXR/q9AmiUL+YI/FVdiqbSLKQrxFMRefAOGptkTEugEzuSkG1ruRJ7WcmodVzAOtHDObvw+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYdJ0W+2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a37cb5afdso88444926d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 05:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768916786; x=1769521586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spiJEUz7YrJ9p2nUXIqRGXS2HMPY7smmsApThddibpI=;
        b=GYdJ0W+2b9lqFggO/Ra6CK7l6PlYf4iygEKex7UtkTgF0K7hk0pjJ26YphAL6VSn1j
         xjQh9fg+YQIklbsnWtPbZKUD69LZu4NUO31lsTp2O3tUOui277R9BCzAfY+mWuIHsYbb
         1UlwFXc/0ZcSzbW/iTM7JJPrsmClLHusIWwuHgn9lDpIRIbQvp1Z8n5E2jHQ3GFuG+rD
         ilwItLXDZX+qs6u/69chQvk9Z8gCpNH03s4IYLPhouHC7seXnyp93f/6HSIMAjmjL8+J
         vReLLO/2/NIzPEcCpE9R7YpYMFDUhnXV8Is0UOejZnvacnGwr0iZUj7JN0NBijZu8sL9
         +0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916786; x=1769521586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=spiJEUz7YrJ9p2nUXIqRGXS2HMPY7smmsApThddibpI=;
        b=P0MO9gOXw2YkjVlG3lh64NICgbn7AdWDtdMLJYFGqVrtkhV8Sa70gDnQmURSD8KMUX
         FgPkqdmGO4DDa9jbhdrLzrFDT11II878m+8iJhnQt2ofJzRIns8WP1ccfQC16vywy0kF
         2CODkh13H0X0CTyrd4udPVuScH3kkEZcQS+TsdoU+lRIhQ+0UyuL0gE3xwdCiaKo9zgo
         nKcQs+CShahuhVaWzvsVAv1DeDsSN3Lbvm6ft7N6deqLqgIFDui91N5A6uGQzJ6V2kLS
         WafAA1pMQdgJ2eYmPZ11r4nfvrZffMYXf2pll/NqCFSFAbed0J7tW7QHdsn5rkirRITn
         UPpw==
X-Forwarded-Encrypted: i=1; AJvYcCVEBAM0tbWT57XYLDztFv4JLtvMZgXJwOuTAvw93L+yWCZptNqz5SIIxxtGFK9wuozH3efMYExgWj7ACmdl@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsBFec5RZs9qqNjeSORg8Q5a1BnNvipLRtGJUrF2PW8hlxurU
	Pff0wa1gYX689U16uZGX8eXhna1ZRUROrVmYKUht20YlEEdTp0rrKimx
X-Gm-Gg: AZuq6aL7MZZ5ggFqhz8vQT2dzOQ5pH6Z+mKw0RKfbPkhJEha/mXLyDYBMJduaAok2zt
	z1aV3jUOA9MEp8JKqvTDGOMLr2+YQ1XkWbmEDDg1WQ69wMbUS+nv0cZBW+xGcJJ5SWKqPVv3Od9
	nhLibA2DuFFhBVUlOzJ6HoWMqQzUC1C2zWEI7FnHLcSrFhpusD17v14M30qJUD036ZlQN4w16qG
	yL7hcI+pKUxN871QEcluNIINdUUWndmVKIaLrNjexq4RegcGxGWZYCZYVpNkhsCYeHYJEv0q2EQ
	5wXWPdTByzcY1QRoh2nLA0MPgVzrISoYiNSBtnYcCGLxlaz0tqZz8T6p15X49iS4S+jU5+azUrM
	8MENwdws9nlr16xT3eUg21QZslDKS6eJKb0SUv0nGlXAtwLu1MtZyCGyhiEHygAbf+gUB60V410
	A4AItlmme7Zy4ld3Ggo6GoNgoI83Z9S6toVoGzOprEtTd/CBsdrp/s+Lp1Irlg93snqd1OG230S
	W8nFX03r+BIOk0=
X-Received: by 2002:a05:6214:212b:b0:888:6fde:7b72 with SMTP id 6a1803df08f44-8942d7e0460mr207178096d6.32.1768916785693;
        Tue, 20 Jan 2026 05:46:25 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502a1dc88afsm92873801cf.15.2026.01.20.05.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:46:25 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 21AB8F40068;
	Tue, 20 Jan 2026 08:46:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 20 Jan 2026 08:46:24 -0500
X-ME-Sender: <xms:MIdvaQkDpiNERS6ZDD4RFZudbe96RkXEG5Wn29PLm557bOa1XWPz7Q>
    <xme:MIdvaUs4h2u9Z_7MEcSZmC9VEDBsHBBSVfuke7zpWKDLeq2-kmXOu_jvLDXnYNngJ
    ZVx5Xi0f2bxZMXo13vO7uoQOQSRGweEao2rUSvdf8-MekJKAqvVUQ>
X-ME-Received: <xmr:MIdvaXOilmeqLVnK2rp1aK1365CAufvcBz90iScfNGoXpVwIf8AbSLKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdq
    fhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrshgrnhdquggvvhesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpthhtohepfi
    hilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrggu
    vggrugdrohhrghdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomh
    dprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MIdvad3LHcnIdXmOV485ryfI6aeyEO2Pzol-W2-6wgJ_YlykIMl9qQ>
    <xmx:MIdvaRxCqAWXdtgPRWYk4pYYoJos9kf-wSqMqFhp-sScDFFni8Dcgg>
    <xmx:MIdvafo3TCGCaN943c9JFJ-cMLXIAQBZwRgtqq8vV5VKtE0TJOTmNg>
    <xmx:MIdvaXUqoonHROVQUjoZfnTP7G7HI-oq0KcLQwRzB9By4gcaXHI1Gg>
    <xmx:MIdvaWrIaKYHWyMx29-tty7pCsEXlwWAsFfCNpiW_4uCGvfWyHKHnzgJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 08:46:23 -0500 (EST)
Date: Tue, 20 Jan 2026 21:46:21 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
Message-ID: <aW-HLUWC3C9HZIGX@tardis-2.local>
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <DFTG8D7VQNUR.2VK3OZ0R92MEV@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DFTG8D7VQNUR.2VK3OZ0R92MEV@garyguo.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[34];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-74646-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,google.com,umich.edu,weathered-steel.dev,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,tardis-2.local:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqunfeng@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 587C95FF77
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 01:25:58PM +0000, Gary Guo wrote:
> On Tue Jan 20, 2026 at 11:52 AM GMT, Boqun Feng wrote:
> > In order to synchronize with C or external, atomic operations over raw
> 
> The sentence feels incomplete. Maybe "external memory"? Also "atomic operations
> over raw pointers" isn't a full setence.
> 

Ah, my bad, should be "atomic operations over raw pointers are needed",

> > pointers, althought previously there is always an `Atomic::from_ptr()`
> 
> You mean "already an"?
> 

To me, it's kinda similar, but let's use "already"

> > to provide a `&Atomic<T>`. However it's more convenient to have helpers
> > that directly perform atomic operations on raw pointers. Hence a few are
> > added, which are basically a `Atomic::from_ptr().op()` wrapper.
> >
> > Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
> > conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
> > named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
> > `atomic_store()`, their 32bit C counterparts are `atomic_read()` and
> > `atomic_set()`, so keep the `atomic_` prefix.
> 
> I still have reservation on if this is actually needed. Directly reading from C
> should be rare enough that `Atomic::from_ptr().op()` isn't a big issue. To me,
> `Atomic::from_ptr` has the meaning of "we know this is a field that needs atomic
> access, but bindgen can't directly generate a `Atomic<T>`", and it will
> encourage one to check if this is actually true, while `atomic_op` doesn't feel
> the same.
> 

These are valid points, but personally I feel it's hard to prevent
people to add these themselves ;)

> That said, if it's decided that this is indeed needed, then
> 
> Reviewed-by: Gary Guo <gary@garyguo.net>
> 

Thank you.

> with the grammar in the commit message fixed.
> 

The new commit log now:

In order to synchronize with C or external memory, atomic operations
over raw pointers are need. Although there is already an
`Atomic::from_ptr()` to provide a `&Atomic<T>`, it's more convenient to
have helpers that directly perform atomic operations on raw pointers.
Hence a few are added, which are basically an `Atomic::from_ptr().op()`
wrapper.

Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` have a
conflict naming to 32bit C atomic xchg/cmpxchg, hence the helpers are
just named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
`atomic_store()`, their 32bit C counterparts are `atomic_read()` and
`atomic_set()`, so keep the `atomic_` prefix.


Regards,
Boqun

