Return-Path: <linux-fsdevel+bounces-74854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFyTMbnScGkOaAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:20:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8DE57744
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 14:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3522A6A1F85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810848A2A5;
	Wed, 21 Jan 2026 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MON6q3Ja"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B94044D03E
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000859; cv=none; b=gPa/7lEWbzwGYIcZewO14jaC6n1vusvEJKSXjhnyKA+9AGxDZF6OpIK6RTVwyOqQnDZPmAk3aLnwwnoC0AZEibmGGiCO2jn8AMv1YD9m2DAKfYAINFUZ1zmhuSPlFDrjpL/DMMnL6hUTy7noU6kyvM7SWLtlAy/CC0JicTfOwEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000859; c=relaxed/simple;
	bh=S14KYUopdXTDgC4Cu7mWpisYmEYWvH2eisKCBbQPYjg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ak47xCqYI9zX/nYdN/neKzi3gMtaHInMBLpnJBGytNRf4PyuC5nzyk0wBaCpPPjIOm9pS1FTC3jxd7sL0+fac7U5hcjMY0LsSiv68fDjZai0aRhla118SC9BzhSuNj+duvrK03hNnAYCFq755lNqZDU23T4y1G8gFVq+E1Ma/qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MON6q3Ja; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so76144315e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 05:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769000856; x=1769605656; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQtXgItu1Zy/WBkyH0gCN+HFn5zyM6SkcEvV7kJAMKk=;
        b=MON6q3JacbbvMaxHiLYYufLn9CIOzdNHOUj1NcphbLFh3JcxSVah3QooDTbXX4YedN
         WSdNrlSftfuUsKPzvuZGhI+ib+oVdHNdla27NB++pe6gVpFmfO+C4/tFJCrW+gPuCTHx
         JWlnvuAa2BdE3ORxClN2hSGpGlB5FFMOWp28Ap4VIFwn9S+Ha0Xg2um3yx9OxW4MF0ML
         XglTrG6ZgU/0hWw+Ormf+3S7qggY2ZY45BB7j6m8VpWVPuEfh2C1v4MbeyOwl/NFeg9G
         ThPAHbuiYwSxEHaZNAW7FvZTgzc9TCC0+79X/hq/aQyy6EY6DKcEOer2O9gUyvCYtFV/
         WGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769000856; x=1769605656;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQtXgItu1Zy/WBkyH0gCN+HFn5zyM6SkcEvV7kJAMKk=;
        b=rG/nPBY4MCW2/brFUgWf6cAtjfrYUgjsUjoYO7RpONA7+ieL0VXfUGhFVOQ4T35hT6
         U6XE3tDYTF2rpM/R3stP+XLu4xMB/KsVygauuVqV/GpdlVXOj02ZGijd5zirgwg2LXBM
         HEJyAIYQsvg1EO3Zx4xvMq5WA0+mNDyn4+ls7jK4VCVkMFfj8GpOUM2QfhBFh4KUMr/d
         gufT2NIDmagMR5ytl4BzpSZUX9gJcevvsqFnpajcTKYIOGcvIb793Iszja+wLbHQ03Q9
         ESZUpFUaAVulSrkHi5Kux9jDSPM5nb6r7XHS/myTkbYsMJ0Wgk0jRZD+HSysVaXo3ubk
         RMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXJZnMttMdBRBBHI+ddZhRDjBT8L6wWvJBCEWGgs1Uu+OrXGUXQgDXASDsEIHWWT9CF8zl/rwXZoORfl7+@vger.kernel.org
X-Gm-Message-State: AOJu0YwsC1UY2H+nsZGn16nVtC/RYU+uP+705xhZQrDPJilOFMf/bEw7
	bm4AjN9O8tSTLE9CeKLiu+BYemx3QsTDNph5m40LDWX9rtZN/7VUS+sUnAqxafp/lApNwgobhAW
	mUj1PmS3soxUSveNe9g==
X-Received: from wmbd16.prod.google.com ([2002:a05:600c:58d0:b0:477:54e1:e29e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b82:b0:480:1b65:b744 with SMTP id 5b1f17b1804b1-4801eb0e10emr234136695e9.28.1769000855966;
 Wed, 21 Jan 2026 05:07:35 -0800 (PST)
Date: Wed, 21 Jan 2026 13:07:34 +0000
In-Reply-To: <aXDL5NUOH_qr390Q@tardis-2.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com> <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
 <aXDEOeqGkDNc-rlT@google.com> <CANpmjNMq_oqvOmO9F2f-v3FTr6p0EwENo70ppvKLXDjgPbR22g@mail.gmail.com>
 <aXDL5NUOH_qr390Q@tardis-2.local>
Message-ID: <aXDPliPQs8jU_wfz@google.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers over
 raw pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Marco Elver <elver@google.com>, Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org, 
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74854-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,garyguo.net,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,umich.edu,weathered-steel.dev,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 7B8DE57744
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:51:48PM +0800, Boqun Feng wrote:
> On Wed, Jan 21, 2026 at 01:36:04PM +0100, Marco Elver wrote:
> [..]
> > >
> > > > However this will mean that Rust code will have one more ordering than the C
> > > > API, so I am keen on knowing how Boqun, Paul, Peter and others think about this.
> > >
> > > On that point, my suggestion would be to use the standard LKMM naming
> > > such as rcu_dereference() or READ_ONCE().
> 
> I don't think we should confuse Rust users that `READ_ONCE()` has
> dependency orderings but `atomc_load()` doesn't. They are the same on
> the aspect. One of the reasons that I don't want to introduce
> rcu_dereference() and READ_ONCE() on Rust side is exactly this, they are
> the same at LKMM level, so should not be treated differently.

That's okay with me - I just don't think "relaxed" is a good name for
atomic_load() if that's the case.

> > > I'm told that READ_ONCE() apparently has stronger guarantees than an
> > > atomic consume load, but I'm not clear on what they are.
> > 
> > It's also meant to enforce ordering through control-dependencies, such as:
> > 
> >    if (READ_ONCE(x)) WRITE_ONCE(y, 1);
> 
> Note that it also applies to atomic_read() and atomic_set() as well.

Just to be completely clear ... am I to understand this that READ_ONCE()
and the LKMM's atomic_load() *are* the exact same thing? Because if so,
then this was really confusing:

> my argument was not about naming, it's
> about READ_ONCE() being more powerful than atomic load (no, not because
> of address dependency, they are the same on that, it's because of the
> behaviors of them regarding a current access on the same memory
> location)
> https://lore.kernel.org/all/aWuV858wU3MeYeaX@tardis-2.local/

Are they the *exact* same thing or not? Do you mean that they are the
same under LKMM, but different under some other context?

Alice

