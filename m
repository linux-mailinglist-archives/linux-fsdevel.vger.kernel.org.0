Return-Path: <linux-fsdevel+bounces-74619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOm5EzKFcGktYAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:50:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E181F530BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 08:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5D297E4330
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 11:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB73425CD4;
	Tue, 20 Jan 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzCa3A/l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84843BF307
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768909944; cv=none; b=mnNZj/2yMzo453zkNJKdGQubSn7Rqv2K7b8KWyEWjf/IVsnWyfgMyZTKpcNMAT/HCh+C/1oNHpVjmPwhpjuogJJ9b13XC82PXuIjaP1kjHWEe2uvq44yF18/7jrIUFHzVk9XrYXlkhC8wtAd0w9UZ9vGUIwrsCg7pojoFvsE24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768909944; c=relaxed/simple;
	bh=IgWAuNJ6h3E/R0Fu5awjtkTf/OgcqvY3PFwI4AxvJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kxHzR9WPE7JbYdKzJ8AfGC+sbye1t+SchGfyKIjvFNO7ZSAtjP15oOZq6MEmj2Am+vWa6JbTZSWNDeon54Ve9SE3AByD74SA/VRV5NM8IfAXzKiOUsGOnn0gSnOx9y1Fzxp9eDTGx8WckjDVB7pufao9sS0IYZG7PtY3WUMw5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzCa3A/l; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-88ffcb14e11so70078616d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768909939; x=1769514739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=noKL7zQXHKYfYinQlJHUIYY5IKQR6tHuuXlN5E414EI=;
        b=gzCa3A/lBb272Jq1hJmmpYkHojOD7e6a9++PdVPlcn53UAEzy6vZFxAU8i/M91CL2O
         ALLAJI9gy+fgUoUx2Poj1q5kYGJl3ckcTqlEHiQa0fyl9w5lXG41WQKui9exAujhGr7X
         Po3Brufq+Bjfi6sQxIJuZkyLSVM3AQ06oxfyjfj6iHo9HlKDigGaQkEKsSfMrXDzDli7
         z9tX4AFkAGBXMFLloUfgow/OWYawQqsB/zQgec5X7hIPX9W4Sqa9CIwgDQu9duCqXxWk
         xVbVm13wGI9GeouH49YzzBIqwaliZL0da/59A7d6p8pzNpLJJ0VizVNWzCEXjdFtkA5W
         r8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768909939; x=1769514739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noKL7zQXHKYfYinQlJHUIYY5IKQR6tHuuXlN5E414EI=;
        b=sRx4CdH2Uku8iwpM3fKiJtcVkAS6cdynYBjzQ4Mz1+uVxIQCRPYN7JIgQH2F5AW6F8
         BuCx8gIwALDrxSSHNXVwTuqty2znC9emTjhu+z4I5W4e/FAaenbnwO9p+Hr8ZOVXn5q/
         hjL6CZfjQS/yA1iE9w9hqvJf0uQeZIVUy+g3McaSH7RghotyfjlOm9T8Tq5h+iDreDnd
         ua0C/+hmNfCPfOVIhbZ2Mn4cbumGSW6qjCg2T6YMt+F3ceJr/bQsujrG0sstADaxUGL4
         1NGRIrz4yK1a6j3QwK447WK8D1B5AXOG3iWInAKq1Y5oHkKAG6lmg60TCcAH2sceh2Zh
         6vHw==
X-Forwarded-Encrypted: i=1; AJvYcCWl/JrEHlUZYN7/zQ1fT3Aq1AIVMbnf79cNMYdlDGMQXdyt8s2d9pF/ML9JzJwlVXmfq2ScuxHy/iF5zuRa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm8qYC4TxNxRFGBqmQNwqvt49h1Unu1HfwW8S8rAtpi8B6JEgu
	HNcLP2yXNg27793xKr7nmh+jILT48lqN7hn2LKmy76WIPLVnfp8BH0pj
X-Gm-Gg: AZuq6aLq6T4r9B7EIfRozOQ2lplLLBi0ztp4vnHi8ceNQjge53Z+v9K8ptwLiT27+Vs
	8ffYTnGMxBES6h26EOx/he9ggJ3RWS7I72Q1diDYH+zL4U3JyPcL35TzP4WZjAyTUhWX+BVSNr0
	KOk5yfHDum66e3LnMWp+QLHbGytcXdorOgstaA+fE1FM8phCzAUXbH5VS02ymytidpsHzrkk3eD
	3ed20Dzu0UiP+ZLenlf4NmmirfgRUKmVkxlwwKjr8c8IVmV0sAVtGIYHGfGt7JoF6X1lVdnKwE4
	riPM+s3XT7owvEGlCWKFSl3apQdc5NE9XFEgsxsd/MdcTRi/opnjhSVow/NEjIWzqVzHopRFcqV
	TkmEPN8uLETYbFVby5Vnk57WhXKIiaP8FDc0s+cqyy5vU4kid+rUUeUBeE/RYtDOIkVJoFDF4fe
	XoAJpxtwliplQIy+ubbRj8rfhtItD21Ky5dzKG8ahaAMGAjujbjYwP+zcOgXk9PDLg29DcXPgb3
	oENRIo/KzSop+YMFjR8eIu+EQ==
X-Received: by 2002:a0c:f6d0:0:b0:894:4793:efb5 with SMTP id 6a1803df08f44-89463837a6cmr13834676d6.4.1768909938912;
        Tue, 20 Jan 2026 03:52:18 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c9a9dsm107071836d6.43.2026.01.20.03.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 03:52:18 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8EB16F40068;
	Tue, 20 Jan 2026 06:52:17 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 06:52:17 -0500
X-ME-Sender: <xms:cWxvae6kc1TFcI9TJPWN-r0Pi54xEVHRlnTp-vtGY1_5kR1y9bNnsw>
    <xme:cWxvaczkpMf4NjmQMHZz9DaKkERaCs-ewKaWwY6SKRG7FlYpzDD6ttDVLp4-B8Ptq
    9TGgF5MDOIAZaMxRxBpNVj8MMU1t4okSniNUn08IIj-wX5gr_DJig>
X-ME-Received: <xmr:cWxvaWD7IC7dfygFMVaTHzAYsQAUPgjYrvLCDOAmhrvV765T-eUhM4XQ>
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
X-ME-Proxy: <xmx:cWxvacaWZh4sjTdNnxvo-RY08pCAGMHU6oz3GtYY83TahsLzo3zhPA>
    <xmx:cWxvaVH9v9jIsSv3xBvewOIYhqwrvpqIM-4f5SBsPuYuerGbhySryA>
    <xmx:cWxvaYuLdN-3g2qZTwjnkdP5nvAjWgUAp8FbfGHHKKMntdAi0DlrmQ>
    <xmx:cWxvaTIFjoNqnVJsZBRniY4Unvx_7-2ldrTR_nrHxhWNyETxhfMZ7Q>
    <xmx:cWxvaeO4loKUB_fs2fsM5G6nADvOiAYKujq3cBHqFJYbyNu4pFPDyWDl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 06:52:16 -0500 (EST)
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
Subject: [PATCH 1/2] rust: sync: atomic: Remove bound `T: Sync` for `Atomci::from_ptr()`
Date: Tue, 20 Jan 2026 19:52:06 +0800
Message-ID: <20260120115207.55318-2-boqun.feng@gmail.com>
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
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74619-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,gmail.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,weathered-steel.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[boqunfeng@gmail.com,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E181F530BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Originally, `Atomic::from_ptr()` requires `T` being a `Sync` because I
thought having the ability to do `from_ptr()` meant multiplle
`&Atomic<T>`s shared by different threads, which was identical (or
similar) to multiple `&T`s shared by different threads. Hence `T` was
required to be `Sync`. However this is not true, since `&Atomic<T>` is
not the same at `&T`. Moreover, having this bound makes `Atomic::<*mut
T>::from_ptr()` impossible, which is definitely not intended. Therefore
remove the `T: Sync` bound.

Fixes: 29c32c405e53 ("rust: sync: atomic: Add generic atomics")
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/kernel/sync/atomic.rs | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
index 224bd57da1ab..d49ee45c6eb7 100644
--- a/rust/kernel/sync/atomic.rs
+++ b/rust/kernel/sync/atomic.rs
@@ -215,10 +215,7 @@ pub const fn new(v: T) -> Self {
     /// // no data race.
     /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
     /// ```
-    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
-    where
-        T: Sync,
-    {
+    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self {
         // CAST: `T` and `Atomic<T>` have the same size, alignment and bit validity.
         // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
         // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
-- 
2.51.0


