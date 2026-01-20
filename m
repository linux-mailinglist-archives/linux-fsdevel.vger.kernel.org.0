Return-Path: <linux-fsdevel+bounces-74625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEunOLI1cGl9XAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:10:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1944F8DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFF888B301
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 12:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1DD42882B;
	Tue, 20 Jan 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2umk9AWi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1D9421A0D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768912731; cv=none; b=o1HCqo/xDLGeIJrf52iBZ9gDxxNcBdMyiho365VrR8+KddtT3VJw0JqNiNWSiV2wuNeqmStbyD/styY68aEHjRtWYkNY4fl4OU1oIxRxhBoohi/IfvmZpBwcCYy5vFWPUEj/J75kwosP4oXKOgNVQUKhVNZSjnGnZGOnkpy4cuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768912731; c=relaxed/simple;
	bh=PwApb91RxQIKd1rzfJ2xAleSXJcHnAXezOdyfHCU/8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jw5L+5OiEQrznt2ShRBxcOlRh0Ip56dUarhB6w5SwqbxStdnWizHi0hVHNIRtXdiB31amtnrOOINBtv8x2t7Q3fp7QiEXcs7ST6OYnBcWLYgXA3IkMpMXWaHkhGpJE1EJdsE2Le7+L5U5cr3rPCcaNObzhEheZxkx/aXCam6IIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2umk9AWi; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-430fb8d41acso3082547f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 04:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768912728; x=1769517528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5uBS89EprhTXTMtWy33Byzr1DNzGriqxZMXGCf0cIw=;
        b=2umk9AWiz9orTQh9fEnzb0/lEKqJ1LAOeotkj6jpFrnlJBuYCX/3SstEFf5fY+njwX
         iaYtfRFkhx0r/9VonYrK08tW5yfXMSDaEs/BWm7Yg5irVgrc/TzszgVQCdID/DxRu79b
         n/swbGsrAA142gRzDZXbjPopqRC1j81ry8PRixoFL5kM+vEIPambFVj4T4wpyH9iEoAn
         +mnh/TuW3Duo3UVER0vn4CCj8x/Qg0NoB+TtYw0ebfCiaOhsih8krX6P18R7IL0fAfnZ
         7lMHoBION3CvFBFdMnC1biBllH0SaCi8cvn7mTqEV2Ax3s8+li0W/ioQutbY5jCT/tKR
         ZxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768912728; x=1769517528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5uBS89EprhTXTMtWy33Byzr1DNzGriqxZMXGCf0cIw=;
        b=CA6uWqqtK6OnKqM9dT5rhJHjkig7mOnXIz+78ALz8N1ZXHQ7U2yAtAYQjTwzFOwOCg
         z7Quu+5u5QkCb0NoQIXZZFg+n08OTrQxuFDlUTFYvASKdd2bzGaiUtdH7MUMQXJilf8c
         2C7zch3G4x2+0d5PAd3GeuwAc1uRq1F+C61e3n+ngCJH5OGk7vc9k7RGhx5O1NzFfD9G
         +MR74XN0N4G3tBXYI1BEUGZbKlwfyI41XjS//NniA9EPPO+9nIlm7TMUOAwKfOKM0rnf
         iw4IzevIEvid5FLzbRpynp4N4FwJIpsIKjQ3h2Kaf6Jc26wLY43Vp4+Uw81YYaA9QMEN
         SUCw==
X-Forwarded-Encrypted: i=1; AJvYcCVDak5opqvpYV4bUR0TWLLHMhrkZmmZa9EKhdGOa3IOJ9v4to2KkssDjHsZlmXVzc9K5E7uQVYBj3fxPPPS@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPXNpMFdfbd9mLWF8FM8mH3UfDgPD08nfJA5s2GdQNXsUObaD
	LJ8XGs5hrfdcQt8LPGcsho/2O3K0Y5hg4XbbyAyvQurfaSMOsHhdf1nb6pozncPzS9KNZBZXQwl
	onwVedgvkfs2N3r6iHw==
X-Received: from wrp4.prod.google.com ([2002:a05:6000:41e4:b0:435:948f:2ec0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2885:b0:430:fd84:317a with SMTP id ffacd0b85a97d-4356a051d68mr21671610f8f.38.1768912728086;
 Tue, 20 Jan 2026 04:38:48 -0800 (PST)
Date: Tue, 20 Jan 2026 12:38:47 +0000
In-Reply-To: <20260120115207.55318-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-2-boqun.feng@gmail.com>
Message-ID: <aW93VwfgkHpJfjVs@google.com>
Subject: Re: [PATCH 1/2] rust: sync: atomic: Remove bound `T: Sync` for `Atomci::from_ptr()`
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kasan-dev@googlegroups.com, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Marco Elver <elver@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74625-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,garyguo.net,protonmail.com,umich.edu,weathered-steel.dev,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7A1944F8DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 07:52:06PM +0800, Boqun Feng wrote:
> Originally, `Atomic::from_ptr()` requires `T` being a `Sync` because I
> thought having the ability to do `from_ptr()` meant multiplle
> `&Atomic<T>`s shared by different threads, which was identical (or
> similar) to multiple `&T`s shared by different threads. Hence `T` was
> required to be `Sync`. However this is not true, since `&Atomic<T>` is
> not the same at `&T`. Moreover, having this bound makes `Atomic::<*mut
> T>::from_ptr()` impossible, which is definitely not intended. Therefore
> remove the `T: Sync` bound.
> 
> Fixes: 29c32c405e53 ("rust: sync: atomic: Add generic atomics")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

