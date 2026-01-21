Return-Path: <linux-fsdevel+bounces-74851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEjPFYPKcGkNZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:45:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1734B57015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4C0C5E19F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5451048BD27;
	Wed, 21 Jan 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0bmCmN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25B1481FC2
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999005; cv=pass; b=nIm1xMAZ9oSW2ynZfCTlk8H2++tfw2DTbNpXhblLfZ+xnpy02RemGvd4FNUoexOjC0z5pdKyVo1Z2SXPnNvmdtBPxO8+sKdMVvNIM6obpq/KG9o7nP/e0nayYNZywPCXtaSb2qo29nVoZ7d0x1tw9NK2KdEfTsFQuz0Rakj+pKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999005; c=relaxed/simple;
	bh=TPCkepkHyhe5x/FmTr/qCdwm6U/nlhtllm6pFz3H7dQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0gn7F9YF7YnbSMzR/ltc4BL9oPPSZ26D+tSASjevcX8AVwyBJbQvwYw/5gubuI8ZVDq76hSLPFbtZrXc9ByUBfEqRgrQ8uxQuLoTK31CXBYFca6A9FaGlnSGjgvNRTGXliHENR5Q+MJ3CNX/DyvR1Vae8qMFJ2h4qw4x9dbxBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0bmCmN5; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1220154725fso831487c88.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 04:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768999003; cv=none;
        d=google.com; s=arc-20240605;
        b=VVgDnXqVnSg3C9mfhNY7gBnQC4CT3oGPEdL5DfojjEQy6JBbZNRA8R7fGpdSC6kzvC
         fe/nLywFNnl4kJB10VSPQZt58SZOHyK5PdtkSy0m7JjvVjTCY2dRF94Z851EPKYRKR1N
         MPu3NE53GR+JQwOHaqfy+b/EWOGyrv9nkZjuTkaZtcmwsU2D2bPrTZWyCmxoJWg87jk4
         V1sDzq64Rr1Ab+YGHut57USdKHH3szPISpymOqlfNjXnemZUp5Hq7o/8hQu6+X6gmh+I
         t1HQr+sxGtzzu3pGo54a1MdWuMkwRJI+BE2oCQ4tS1GYsCA10VDvdRGA9tY8UTmr91Jn
         lLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PEaTN9s2p8Sn9ZSd/CWHeV/MqX0nPOxMFs3ofH5u/yQ=;
        fh=EKXuyz9lAfmAjIuAoETtRzx4KEpDtFU1Wj282mC/UQk=;
        b=Ltgl8HyNiZytYGNi8wD2Kr/JNszHepsazvqhJtVS2CQgijLwjXcL1vLSi7C1VJrmUq
         u6TdH6Up+0xjmJh4GKL56Xgc+CDyytIdmxb2alSG3mOpJQefsci7SOvnstK8LxXpVs/g
         Tsgja+MKiTpVarsGkZGoi09wRJcpFNOOqA9GdzsFs2NQ5gojl4Sl7th6XTwP6kdgPn7B
         Gu+ZAFSAPyb629x16rDpl9thmgcrRueqXbm3Sl+QEhZltCEQKNny/6+Ra48SxcfEvYAy
         Cq3UGfOs8gtIP5GFNNk7EL993PoAAe7HefrE2daol00nZPRDGkP1jQwdgABnwgP4Y5eo
         aseQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768999003; x=1769603803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PEaTN9s2p8Sn9ZSd/CWHeV/MqX0nPOxMFs3ofH5u/yQ=;
        b=Z0bmCmN5gxDTiJFXnLP/wLBtqE/KyBCjI4vaCATOrRRCN32YtfFYockmBA6ErZeg+g
         JaFoP+FGvxjbssaM4w7sC7cLR6DOBONfrSuH8poJ41KwAVy8a6wafvTJNtuCijO7lTHN
         dBG4K8ExWApPnb147NEwFGBNCEzX3gj4FM+kCcCGU0Nzcjq1EqwtriC5uklM2dlL0kW6
         LJQ/G5Qk/ZevhoVgNOoq0OoabBmQlF0QQSIgZ57tJgrpkmPX1dE48pU/buVNzNo8aAB8
         vbzZdrUwcO96KoOysqcushFBejy8YtnbltIF013s9qNIrTfEdCiQ7H+WkWeqadmpwwhM
         M6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999003; x=1769603803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEaTN9s2p8Sn9ZSd/CWHeV/MqX0nPOxMFs3ofH5u/yQ=;
        b=GDpfV08o7f1+y+dwgc+yRiE6WIeiiT6md7LBQtP5DRrREel3KvfvRdsL7+DRvf69IZ
         EHgAGvUnyrhs+O5REFZcTAOuMiGFaslVh4xIQ8ogUl8vRSsVMfoMlYypZpViTO6Al61J
         zgtbX/r7zUhZyu02LZR6x1ckrisCKFFn6cxIt+KAogeuYUlXdE3VoccQ4P52xzY0i0TK
         ige/2VO8pK0hIFaZ4wL5SCaW7Nn2NLMS9GMnzuPMyYfnj+DVHA+/lld27yoJv2O62FWH
         Ju2o9fmZJOBrJAcuSp6XZUyo+yphWUjcMCYKC7fHB6WVYl9XWZe9BGkTtsjT4FWp8bAq
         w77w==
X-Forwarded-Encrypted: i=1; AJvYcCXK5MH7VP5v8qTpb2U6VUYenKNx4/sMNLDyLt32U7rFChHI10kW0vf6J9V+zeb1TJvZNTeLrTIJTcBNmCGA@vger.kernel.org
X-Gm-Message-State: AOJu0YwlpiJ/wGC2JxI6CCh9kYeugCKJ7RvgmMieOiqbRrB2MoZsC12D
	gyMIxWycPITa6BayoKAkabTBIbl5IVYc7Dtl8KgQMm1mhar0RV9qzrS5eEfYEGKdMdxtfA38OS3
	S+S55WkGDCZN1akmW/8AYishpqxr6POCZkYi7wj8CQFyLHjgYYh2yan7o1U8=
X-Gm-Gg: AZuq6aK45m+Pu6PjTqwqsBrLD1BE9zZ7fW42s1yLwuAYrUOJEy+EyZyEgqUbVOkbRB2
	3668gfIUJUnMHu+gA7gwPjvZLPkrwXwtQpwA6s5h0X4b4n63PzyyBgXIeMadl+NjlssKG6SrxyM
	FfJ2uZCwzjUpbGU6bwaYYy4W2p1tHcWlRAeFK1JKy3nRdxdlHjz4MqWf0c+xpEQmrKgWA/GYHjZ
	tsKl6XKAUrQ7V+nbmZn2wnAmx91B/s8wIBZD8O1CtofA4eP4uyaAOSnf6SW5u2QBMG9F9UnHABI
	VdXI5MpYViu5GbQzFGUH4B78LjZkCi7xJNtx
X-Received: by 2002:a05:7022:6b99:b0:11b:ca88:c4f1 with SMTP id
 a92af1059eb24-1244ae9ee20mr14221247c88.20.1768999002171; Wed, 21 Jan 2026
 04:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com> <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net> <aXDEOeqGkDNc-rlT@google.com>
In-Reply-To: <aXDEOeqGkDNc-rlT@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 21 Jan 2026 13:36:04 +0100
X-Gm-Features: AZwV_QgBBL7kVX6shPY_rD_ZSqxEg43eFMwlNHC3kU2drrTme4vk8R8dbzHINHg
Message-ID: <CANpmjNMq_oqvOmO9F2f-v3FTr6p0EwENo70ppvKLXDjgPbR22g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers over
 raw pointers
To: Alice Ryhl <aliceryhl@google.com>
Cc: Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Elle Rhumsaa <elle@weathered-steel.dev>, "Paul E. McKenney" <paulmck@kernel.org>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74851-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[garyguo.net,gmail.com,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,umich.edu,weathered-steel.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1734B57015
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 at 13:19, Alice Ryhl <aliceryhl@google.com> wrote:
[...]
> > On the Rust-side documentation we mentioned that `Relaxed` always preserve
> > dependency ordering, so yes, it is closer to `consume` in the C11 model.
>
> Like in the other thread, I still think this is a mistake. Let's be
> explicit about intent and call things that they are.
> https://lore.kernel.org/all/aXDCTvyneWOeok2L@google.com/
>
> > If the idea is to add an explicit `Consume` ordering on the Rust side to
> > document the intent clearly, then I am actually somewhat in favour.

That'd be a mistake, too, as the semantics is not equivalent to "C++
consume" either, but arguably closer to it than "C++ relaxed" (I
clearly got confused by the Linux Rust Relaxed != Normal Rust
Relaxed).
It's also known that consume or any variant of it, has been deemed
unimplementable, since the compiler would have to be able to reason
about whole-program dependency chains.

> > This way, we can for example, map it to a `READ_ONCE` in most cases, but we can
> > also provide an option to upgrade such calls to `smp_load_acquire` in certain
> > cases when needed, e.g. LTO arm64.
>
> It always maps to READ_ONCE(), no? It's just that on LTO arm64 the
> READ_ONCE() macro is implemented like smp_load_acquire().
>
> > However this will mean that Rust code will have one more ordering than the C
> > API, so I am keen on knowing how Boqun, Paul, Peter and others think about this.
>
> On that point, my suggestion would be to use the standard LKMM naming
> such as rcu_dereference() or READ_ONCE().
>
> I'm told that READ_ONCE() apparently has stronger guarantees than an
> atomic consume load, but I'm not clear on what they are.

It's also meant to enforce ordering through control-dependencies, such as:

   if (READ_ONCE(x)) WRITE_ONCE(y, 1);

