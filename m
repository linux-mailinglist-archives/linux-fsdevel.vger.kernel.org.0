Return-Path: <linux-fsdevel+bounces-74620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGOhGKlFcWn2fgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74620-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:31:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0195E144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 22:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45E457EB7A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D816426689;
	Tue, 20 Jan 2026 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZLQHPZa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE5423165
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909949; cv=none; b=VuDNIffx/3kd3AT3L0JgLy4w5GMCQFW+erEKR46oYwe7WtKcfw8fZ1laV8Aw2kTui3iTl68GNzdqAJ1My1vP/UJKkpfyyV9GGP07HX5ZyB1aiZ80MIkFkSBFK7PlbHR7RHz5bkMlNLDX8yv5f+m6FBgBhve4WgCzL67pMeQFdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909949; c=relaxed/simple;
	bh=bvuVfpg7fANpqrGpBEK9Ta/Hkb+dwC9XZqzfpSHeTjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VK64txZgYi0CO4jrVTVtJbTizU0mh8u4wbic+5YBsw/ZF1+3wCAk8HlfbJ/eQHKX1wtsrPaiADGwxz1uVmVWiCbD54tCVNE07RBoQ3PSZDcUVEc2tIB/7B8wrYi2HtimQJ7WT0vVdMFa5ot3RuXVodkReNuKDWsx/f1HiWPxKA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZLQHPZa; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso53231516d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 03:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768909942; x=1769514742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1M3E4UxKfMJ+dI/l+/VVbPQmnjuaMV2kWf95M7jFT9o=;
        b=lZLQHPZayZfdeaVhh8SLENMbqPIm+/SU6AdOOfukMavEYQtV4FMd04lvrhjCSYNVKn
         csbAZyhLzEuyTrHwMWgD2jkOc4ZgveGyR/u9jSAs+51B7Y6PccPucDk7sEILt8hhgpC+
         3QqSDNpnUygvigHDV8l3qm2cizUolEN9lCHIcQpR5vrMTjpSI6OgYRK2NTtEdpMb3NRZ
         KsSaKWgaxpsiSCn7WX677/reAjv4EXT9Q4RkizfEBSpNGkcM5T5nDERltYG/0xnS3rKh
         h1irv8vrr6RQ6kgYDSxXNjxnouaFAC2vndfrzosWr41VqJowz5uMaA+c+Y4yypFB0Q7j
         0EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909942; x=1769514742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1M3E4UxKfMJ+dI/l+/VVbPQmnjuaMV2kWf95M7jFT9o=;
        b=kBrfItr8MvYT4418gTCVbO3DCvl3R8XjncqjXjBiGByNkGFSL4MNm3MH63zkCiivTH
         5teepE3Rdzj/SAeKlt45Yj4Xw01CWXaYBlqIit6HHcyo1xfI338HHkCUUndTG8+NgSk6
         RyNf90UEtiLAWjD1DEy+0ffeHGTd3TRA9cFbl48VqAwkfH6aPWp7qBQB9KuPo1njP5gA
         CTFR+o+sXXKnEU4xpOIn6+rswvGJz9FXqnOt/BVmJQZiyKG8nt/G2rKoSy1bNz23ahwh
         k1WD2ikMXa6Ow6HdfsOANxkNFfFORGwINC7QD0C6LrRLPhfY4qr613cF1fIJhrrdA27n
         PUYg==
X-Forwarded-Encrypted: i=1; AJvYcCXmr7wyPIYiP45z/DoRqYBb003hFuVJc6znNcbBPJ44Z04geTwau9cwatxH94lfdv3QtGNEY3D1Ey5vmORk@vger.kernel.org
X-Gm-Message-State: AOJu0YwQrTD1jY78z7JMZxKXmFS5GTKUYV7x3Ao09VbZzpo4+Gp2aQ34
	7icNYKOVt2n5W+OloqWc8M9CoUzV8/shhqzeuQuL3a99AmdSdPDs2bKL
X-Gm-Gg: AZuq6aK6roD2WWFlE4U3tyDCZFSM9w04yax15JlNzDiP2vnZ+lWV9blzfqRSBnNJibl
	Uc80OoWRZWSXwmUJNaADZ1DELTEfhRBGtLwZoxdfB6cyjw2pfKFHlqb5FIoTV0S1A+ehUQKG5SN
	6LKfMrIgtlaSrbbWQlklML7K5qhgrMgADksL5eJiVUgvdK9Lq4ZEcRJAQswoOSNfG6fstt0TZD3
	GVz0mmkLbYC6s/siFeVnUUC5q4KotQuMEjdNREQpDOOAvZNaA4Cow2MHXWgQLl7E1ifBQ6uMVp5
	eZSQLizWe1qgyR5hP/I1Z9cahSxE7BFoOvDgdfBt7fjcssIPd5dkrutKV5QAX08Gk3ERAuagF9m
	pMgnbG+imz1EYthwGKrNrJXnvh5ih7/sJIZCpZDAEteAbhj2kk04IrQ47cP3gk65lL0qfC7AkOR
	N4FyxgCm8rhjxf/CR8RZqHwYHGSg6yAzkKBtIGmVMmDy8WneYn6UeWONYiIaSx7//7f8amIi8+l
	7TBs/l81v1xtds=
X-Received: by 2002:a05:6214:da6:b0:88a:375b:ed7c with SMTP id 6a1803df08f44-89398273c7cmr206650326d6.35.1768909941648;
        Tue, 20 Jan 2026 03:52:21 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6214c5sm100416876d6.25.2026.01.20.03.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:52:21 -0800 (PST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 45E7EF40068;
	Tue, 20 Jan 2026 06:52:20 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Jan 2026 06:52:20 -0500
X-ME-Sender: <xms:dGxvaeqkIaxe-HgSJlZ-XdYMXejqbWoVC6UThHAb-Rvic93GdQubJA>
    <xme:dGxvaSa8gav2xX32Oy285vSFg7ByFOIkpt2RK0DzHdiMZ8fTzzLqNBx5e_FUfMpdi
    q34jZJ9pgSsoNGFH4kULx4XuYenM8xrxCzOzpnI7_mYQrejR5fx8w>
X-ME-Received: <xmr:dGxvaRSPUthtjWaovyWv9pjjrE3aB0mWKVLe1ItVXOUhdQ5PqESJVUhy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueehgeeg
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgrshgrnhdquggvvhesghhoohhglhgvghhrohhuphhsrdgt
    ohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvg
    htvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghn
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehmrghrkhdrrhhuthhlrghnugesrghrmh
    drtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
X-ME-Proxy: <xmx:dGxvaYfKNo8QDwLYM9CXeiISh2_oldLP9KNgBPMv_C14CM-1i-LTMw>
    <xmx:dGxvaYlvME6F5NCUZJYEaj9oEaPojavelmjuY8g2-7LJ489XKk0xQA>
    <xmx:dGxvaVhMjOriFRdNi62qvTsp8VlSSPfzz_4B3_23vklb-14ShEa8zg>
    <xmx:dGxvaREoz1sQ_A-5H57v0CBmy4qsl47VgFTj2JbsxHXyWG7Ei8Jxwg>
    <xmx:dGxvacx2qewmct1PBt13iNre5_XJTp0BvOBLUs-Wl3WS5g1zXfe541fl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 06:52:19 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com
Cc: Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers over raw pointers
Date: Tue, 20 Jan 2026 19:52:07 +0800
Message-ID: <20260120115207.55318-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260120115207.55318-1-boqun.feng@gmail.com>
References: <20260120115207.55318-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[33];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74620-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,weathered-steel.dev];
	FROM_NEQ_ENVFROM(0.00)[boqunfeng@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: CC0195E144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to synchronize with C or external, atomic operations over raw
pointers, althought previously there is always an `Atomic::from_ptr()`
to provide a `&Atomic<T>`. However it's more convenient to have helpers
that directly perform atomic operations on raw pointers. Hence a few are
added, which are basically a `Atomic::from_ptr().op()` wrapper.

Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
`atomic_store()`, their 32bit C counterparts are `atomic_read()` and
`atomic_set()`, so keep the `atomic_` prefix.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs           | 104 +++++++++++++++++++++++++++
 rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index d49ee45c6eb7..6c46335bdb8c 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -611,3 +611,107 @@ pub fn cmpxchg<Ordering: ordering::Ordering>(
         }
     }
 }
+
+/// Atomic load over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().load(..)`, and can be used to work
+/// with C side on synchronizations:
+///
+/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when using for inter-thread communication.
+/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent store from kernel (C or Rust), it has to be atomic.
+#[doc(alias("READ_ONCE", "smp_load_acquire"))]
+#[inline(always)]
+pub unsafe fn atomic_load<T: AtomicType, Ordering: ordering::AcquireOrRelaxed>(
+    ptr: *mut T,
+    o: Ordering,
+) -> T
+where
+    T::Repr: AtomicBasicOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and aligned to
+    // `align_of::<T>()`, and all concurrent stores from kernel are atomic, hence no data race per
+    // LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.load(o)
+}
+
+/// Atomic store over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().load(..)`, and can be used to work
+/// with C side on synchronizations:
+///
+/// - `atomic_store(.., Relaxed)` maps to `WRITE_ONCE()` when using for inter-thread communication.
+/// - `atomic_load(.., Release)` maps to `smp_store_release()`.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent access from kernel (C or Rust), it has to be atomic.
+#[doc(alias("WRITE_ONCE", "smp_store_release"))]
+#[inline(always)]
+pub unsafe fn atomic_store<T: AtomicType, Ordering: ordering::ReleaseOrRelaxed>(
+    ptr: *mut T,
+    v: T,
+    o: Ordering,
+) where
+    T::Repr: AtomicBasicOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and aligned to
+    // `align_of::<T>()`, and all concurrent accesses from kernel are atomic, hence no data race
+    // per LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.store(v, o);
+}
+
+/// Atomic exchange over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().xchg(..)`, and can be used to work
+/// with C side on synchronizations.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent access from kernel (C or Rust), it has to be atomic.
+#[inline(always)]
+pub unsafe fn xchg<T: AtomicType, Ordering: ordering::Ordering>(
+    ptr: *mut T,
+    new: T,
+    o: Ordering,
+) -> T
+where
+    T::Repr: AtomicExchangeOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and aligned to
+    // `align_of::<T>()`, and all concurrent accesses from kernel are atomic, hence no data race
+    // per LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.xchg(new, o)
+}
+
+/// Atomic compare and exchange over raw pointers.
+///
+/// This function provides a short-cut of `Atomic::from_ptr().cmpxchg(..)`, and can be used to work
+/// with C side on synchronizations.
+///
+/// # Safety
+///
+/// - `ptr` is a valid pointer to `T` and aligned to `align_of::<T>()`.
+/// - If there is a concurrent access from kernel (C or Rust), it has to be atomic.
+#[doc(alias("try_cmpxchg"))]
+#[inline(always)]
+pub unsafe fn cmpxchg<T: AtomicType, Ordering: ordering::Ordering>(
+    ptr: *mut T,
+    old: T,
+    new: T,
+    o: Ordering,
+) -> Result<T, T>
+where
+    T::Repr: AtomicExchangeOps,
+{
+    // SAFETY: Per the function safety requirement, `ptr` is valid and aligned to
+    // `align_of::<T>()`, and all concurrent accesses from kernel are atomic, hence no data race
+    // per LKMM.
+    unsafe { Atomic::from_ptr(ptr) }.cmpxchg(old, new, o)
+}
diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index 5faa2fe2f4b6..11bc67ab70a3 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -235,6 +235,14 @@ fn atomic_basic_tests() {
 
             assert_eq!(v, x.load(Relaxed));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+            let x = Atomic::new(v);
+            let ptr = x.as_ptr();
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(v, unsafe { atomic_load(ptr, Relaxed) });
+        });
     }
 
     #[test]
@@ -245,6 +253,17 @@ fn atomic_acquire_release_tests() {
             x.store(v, Release);
             assert_eq!(v, x.load(Acquire));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+            let x = Atomic::new(0);
+            let ptr = x.as_ptr();
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            unsafe { atomic_store(ptr, v, Release) };
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(v, unsafe { atomic_load(ptr, Acquire) });
+        });
     }
 
     #[test]
@@ -258,6 +277,18 @@ fn atomic_xchg_tests() {
             assert_eq!(old, x.xchg(new, Full));
             assert_eq!(new, x.load(Relaxed));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+            let x = Atomic::new(v);
+            let ptr = x.as_ptr();
+
+            let old = v;
+            let new = v + 1;
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(old, unsafe { xchg(ptr, new, Full) });
+            assert_eq!(new, x.load(Relaxed));
+        });
     }
 
     #[test]
@@ -273,6 +304,21 @@ fn atomic_cmpxchg_tests() {
             assert_eq!(Ok(old), x.cmpxchg(old, new, Relaxed));
             assert_eq!(new, x.load(Relaxed));
         });
+
+        for_each_type!(42 in [i8, i16, i32, i64, u32, u64, isize, usize] |v| {
+            let x = Atomic::new(v);
+            let ptr = x.as_ptr();
+
+            let old = v;
+            let new = v + 1;
+
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(Err(old), unsafe { cmpxchg(ptr, new, new, Full) });
+            assert_eq!(old, x.load(Relaxed));
+            // SAFETY: `ptr` is a valid pointer and no concurrent access.
+            assert_eq!(Ok(old), unsafe { cmpxchg(ptr, old, new, Relaxed) });
+            assert_eq!(new, x.load(Relaxed));
+        });
     }
 
     #[test]
-- 
2.51.0


