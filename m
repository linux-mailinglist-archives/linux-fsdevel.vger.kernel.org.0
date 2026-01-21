Return-Path: <linux-fsdevel+bounces-74849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OVZEMTFcGkNZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:25:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A110356B7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B6EC99AC830
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82C03D649E;
	Wed, 21 Jan 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ngn+bRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44949342C80
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997950; cv=none; b=NgUYvokQQRXSkJB4lObdno0PhL7bakLevod0Dc6+38tSyBKfcZwu0ec7fCdRJG3eaS6BQRr7hE05SXLQIvQZ4rNajzx2cP10groYJaLhOC99Q08+v/tQjMRHcxAp+9dE7t71LaNs2qCFMtQAWPXQe1azTSWoHlqNuXoo0V76mgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997950; c=relaxed/simple;
	bh=6Dcu8/bULslvO91L7SspBkSyK9LD8GT4ussbXNPXvLQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aHEB6oA2i3Cl1qVBAUSSZRUKjHcDEJnYLTWlIpp5rQtUOkIdeiL6p/ZAI1XALwf8zcPfOs6zQ88av3Ddla13FKF4fmyZNwdqONBgoJcyRpoKoBgMdhxyZQ88Qsj68Nyxb1YotMBvyg4NFI7coXqRzQaMPcyTDDYG4Inxr4gBcOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ngn+bRU; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430fd96b2f5so6199969f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768997946; x=1769602746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tW692zqK7I63nrKQN1683F1Ixt/sQ4szIigR0l7y37E=;
        b=2ngn+bRUwxeDJmnW1ui4ycBm90U0fIRaM+5H0HhP/1KnryGObeXIOVGynEAonVpMcx
         NzUhynvPno6XOFx21Jy+yibP1glYYw0U0zvVF2f7pDVC7fGcCjHMVyEiSnjHNnMeKXVW
         cqaFMB1l6IAvAglNMM5SWbzVzVsB9FlUuzt3t5chdkXz2pIsuelMbx9wa6rAagaXxof9
         iAncmp1EgIn3prq28td38N3lp7ZAlsho2Qlt1Ipf027zOkEdA11JualYvrmo2du/sHVf
         Ml4VCHlfEkSWBYdbj74y+bhHx029V9YnPOsSkEOL2/Hi6fT+8mY0FyKQq6silo57RGxY
         Q3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768997946; x=1769602746;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tW692zqK7I63nrKQN1683F1Ixt/sQ4szIigR0l7y37E=;
        b=diX1Df1UpmsmRVIy3MjJAxuk7Gm2Dy2K0vQcZXe81zmHq50+2kL46PzMUoXMJHjYB1
         xZqnuNhB0FBySrke7gikFLxvwIUqeeAI/ixw/k5qUj1NYnPNuKG0+DERyxQJFDGfCK7c
         RLiKSnIOV9QiT/+ZcdD4p7hFUNPXQyiqFyNhE14WFdo/F4qGfs5W0UZljPY4lIXKrgs3
         XJqCm/Bm0coZzfL+N9DkPnzgrWc35LzCJg4HqkcPH6BZjjXNgbp54XFh0i47C8s/kZ2T
         7F68f5KMlaU3zK3KiFMolJtw5AbkCsEpEgGdaJlU2w3AEv7FJtVi5mWrUpGbircfOa4P
         YdPw==
X-Forwarded-Encrypted: i=1; AJvYcCXpUKJHGtAJcNwq3WbGYUdgXlMNaOafIq3MQLikb7cKufOKlMcwLOCEDjyjUc/OCWW/DWN+yYYp772KCFZs@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4lDBMkDb9OZUpSHjywDzD4fNUeOD4N4MhGnGYHtHFZzODqOf
	7VyUbTOKkRvgrXM3pLL6ikeYvbsTAsFQ4OzlUhEv4bKNcXkbSmnty9aKh7SUwJ4+UNJ18URG/4E
	Xchse7mKzoX4n1VZ+yg==
X-Received: from wmcu4.prod.google.com ([2002:a7b:c044:0:b0:47e:db03:6850])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45d1:b0:471:14b1:da13 with SMTP id 5b1f17b1804b1-4803e7a2c17mr77774955e9.14.1768997946591;
 Wed, 21 Jan 2026 04:19:06 -0800 (PST)
Date: Wed, 21 Jan 2026 12:19:05 +0000
In-Reply-To: <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com> <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
Message-ID: <aXDEOeqGkDNc-rlT@google.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers over
 raw pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Marco Elver <elver@google.com>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-74849-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,umich.edu,weathered-steel.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A110356B7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 04:47:00PM +0000, Gary Guo wrote:
> On Tue Jan 20, 2026 at 4:23 PM GMT, Marco Elver wrote:
> > On Tue, Jan 20, 2026 at 07:52PM +0800, Boqun Feng wrote:
> >> In order to synchronize with C or external, atomic operations over raw
> >> pointers, althought previously there is always an `Atomic::from_ptr()`
> >> to provide a `&Atomic<T>`. However it's more convenient to have helpers
> >> that directly perform atomic operations on raw pointers. Hence a few are
> >> added, which are basically a `Atomic::from_ptr().op()` wrapper.
> >> 
> >> Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
> >> conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
> >> named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
> >> `atomic_store()`, their 32bit C counterparts are `atomic_read()` and
> >> `atomic_set()`, so keep the `atomic_` prefix.
> >> 
> >> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >> ---
> >>  rust/kernel/sync/atomic.rs           | 104 +++++++++++++++++++++++++++
> >>  rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++
> >>  2 files changed, 150 insertions(+)
> >> 
> >> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> >> index d49ee45c6eb7..6c46335bdb8c 100644
> >> --- a/rust/kernel/sync/atomic.rs
> >> +++ b/rust/kernel/sync/atomic.rs
> >> @@ -611,3 +611,107 @@ pub fn cmpxchg<Ordering: ordering::Ordering>(
> >>          }
> >>      }
> >>  }
> >> +
> >> +/// Atomic load over raw pointers.
> >> +///
> >> +/// This function provides a short-cut of `Atomic::from_ptr().load(..)`, and can be used to work
> >> +/// with C side on synchronizations:
> >> +///
> >> +/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when using for inter-thread communication.
> >> +/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.
> >
> > I'm late to the party and may have missed some discussion, but it might
> > want restating in the documentation and/or commit log:
> >
> > READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
> > like memory_order_consume than it is memory_order_relaxed. This has, to
> > the best of my knowledge, not changed; otherwise lots of kernel code
> > would be broken.
> 
> On the Rust-side documentation we mentioned that `Relaxed` always preserve
> dependency ordering, so yes, it is closer to `consume` in the C11 model.

Like in the other thread, I still think this is a mistake. Let's be
explicit about intent and call things that they are.
https://lore.kernel.org/all/aXDCTvyneWOeok2L@google.com/

> If the idea is to add an explicit `Consume` ordering on the Rust side to
> document the intent clearly, then I am actually somewhat in favour.
> 
> This way, we can for example, map it to a `READ_ONCE` in most cases, but we can
> also provide an option to upgrade such calls to `smp_load_acquire` in certain
> cases when needed, e.g. LTO arm64.

It always maps to READ_ONCE(), no? It's just that on LTO arm64 the
READ_ONCE() macro is implemented like smp_load_acquire().

> However this will mean that Rust code will have one more ordering than the C
> API, so I am keen on knowing how Boqun, Paul, Peter and others think about this.

On that point, my suggestion would be to use the standard LKMM naming
such as rcu_dereference() or READ_ONCE().

I'm told that READ_ONCE() apparently has stronger guarantees than an
atomic consume load, but I'm not clear on what they are.

Alice

