Return-Path: <linux-fsdevel+bounces-74848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LfhIgzFcGkNZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:22:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F001D56AFE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 13:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CA9D9C22E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 12:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C800477E59;
	Wed, 21 Jan 2026 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrBGeQ6k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206345BD51
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997677; cv=pass; b=fw+C0ZjHEcaYJJdw9fQIfrhYaF42eqy+Zld7dcMMs/M56dMS3LUSvpV9GnryLtZ0KzQn4O2DY77q611nF6Rvz6rmfgRYnPlkDfvhEiUM3Dr6/iybcOD6UXRx8r3SrU3uH3G75IelxefdoNLulMkxCe4PyKuL1OWrt4Fvt/QYAoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997677; c=relaxed/simple;
	bh=QT5JLW9eYEpsOmAOwnp2GUulzcXGfwSdxy/nr0y3+KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHIncHRT44z6wCQJS3LsLS1mPyR37vqK+eTeYMeQbptdaILAAjNu4hulPd2moW5DSmUaLrd6xicVUGHjUryb8bgvoHzsD+hopXlzuCnnRRWF3Sbc5nbiJhkEH4HDNmT3nP2P8H9nk1dQzTp/KEbsLcClsTv8EZtRwY5NKpEarOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZrBGeQ6k; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b71515d8adso517711eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 04:14:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768997675; cv=none;
        d=google.com; s=arc-20240605;
        b=LMyTvDc1UOutRByCWfWK1FVFPpx7O7dyOcXdlod2NC2xsGe6h6sFsmhsmq1IJNTVwI
         SnuXjhiCroYxY/nuVUsSRTvbj+4TuXiwmBZMPmHlJwalwjK6PeKE6UjHNWmTPRZZq+CG
         YYRmXMSEd6zro6rPIKstOQjXtahcuEYc26QBvNalACujNhbTVDU955bF4Rlq4kDP9u5t
         78gip+3mX+3K9znIzIsArJ7Fu/eJR+OcfqmIfv/1WmncuQyTAuN0OKaKZ+pc/W8pE8Cf
         BG4Bs9zdqgNY88raxRxXaL/Za9fcnCKz5v798iv2tGwovVFf5WZO5ymK/MbkaZLANhmz
         QZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QT5JLW9eYEpsOmAOwnp2GUulzcXGfwSdxy/nr0y3+KI=;
        fh=uV2K6iHHZPXulDHMfAB+0oFxAYGK3tdSbkJ/LZeDzKo=;
        b=jLinoCCnREDEqVTF59YHX3R0qEd5vP7F3w7RlxjIrUQ2MlsPppRdzIgAfsTgt3ebir
         FiUAQ3C3Wv+PZ74kJt5CQGwMeTV2GJqLvvRyLw9hVacKRQx5VXoxQokjkxRwFz2QGMJJ
         unPDJvLolsdQCHzYGJ+BQMbGWfIawbnWcIe/oNwel1ZfjmNjPUa7O/x9An5qHDaebFAg
         e5Ej7BF4PWchcCX/dTrYqw25MWHjlq8mf8eQcHGaZpgNajwUA9RdjhHWW6v6Qt2l2oBM
         GtK3feRUVwUdY5s7BfHuWsiFUQB8zBHZ4GHJQOadZrXOMqFItwlkRQhziehT8Pgp0Ash
         BO0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768997675; x=1769602475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QT5JLW9eYEpsOmAOwnp2GUulzcXGfwSdxy/nr0y3+KI=;
        b=ZrBGeQ6kfNdJzYQRP1LEJdHfCT1HaMbsgAs5E6G4uDSHU1EFFbGzENXeGpfvg5S/c6
         X2UONltsCXS6bNIRmway17Xxt5hLBWyM369c2Nbg4c1dIXNrd9F206xpy/zYOqWBGOXm
         /GW2J+1iZ4hTgTpBt7biueYVAKzJyNmg2JMqOG7aLNkMaeOLiFb1UIyFYcMLlw1ujH1O
         gQPCeDwGrqFt73DiUAArW6/I1+ep6+PYgQKLVcKM6Xxw6VEJ3FAC//U+JMmJ2sDhZU3o
         DEjQlxUuY5xbdAB3emK1yVeXHDyV173uL5+ys9/n3q34Qgxbr/0VwhxVnNCvRoQDhim1
         b6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768997675; x=1769602475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT5JLW9eYEpsOmAOwnp2GUulzcXGfwSdxy/nr0y3+KI=;
        b=GKyoiuWqLe3Efj/FYB/f25iHbsEZCKfwh0n/DyI+5KGx0v+ZFTYUuNoCemfIObMp5m
         8n+lN51TBoEvC5S2QE3H7LTDqr3rBz3PnlypPLOIDUabJQMwYtm1vVnF+zpYpFXNbAsS
         lK+Wa8wG4ixSvt1IIyXn8D8Paw3p9za1JniS3xM/LU6dSk0jQC3HWOt4ZTwmfaW3Cb7y
         Ve5P+FSoqgSR5PZh0OKI+LwTbI8KOs0yjS23vr+C5G4hEjN3K1zqS4qdxSaTMdqeHWdU
         qezHeYLhsM2M0Ju+mUGqjqxhcKSLvUBoF+TRH79Zuy2ng8ipbc0OnBTC+U8KCebqrZUR
         aRmA==
X-Forwarded-Encrypted: i=1; AJvYcCVHTlp3mIsC2ieX6K2cRGkzBFNSu6vmF9UEcOorDRpe9z2nlaX/5u5qwL01vMkX7FP5pMpCvAjleFJwkNSj@vger.kernel.org
X-Gm-Message-State: AOJu0YyShsA4XbRJGQ+c0v154iFUeRbp0NnysfWV8nB0LE0AmDGP6UHc
	AWN9onYK4k68sNl8yaGjacBMnUhwhxV/aZXp8TnTIiZTyHNmIwp4SCUxL5ohZ9p6IxQXUWpmfqg
	O+uVz7gNtc+4oQeoDnp0ZF3IU5ZgRt7Rkr/Jy4egn
X-Gm-Gg: AZuq6aLZ2hO+qJjOzKcMwhKnyQZNtBuL+Qo8kEbRMp4u9M0n+CYnL+EukcXXAAqtspy
	q2N3i0brDMfh35CgZYb2JoWdlTylNHUW7SkmZm0pd3h9NcJ+Eu6U5KC+Ol43TRQjOgbLzJy2NFp
	4boDsP50OhY34qKKWZj8x+8lOCIhdPEI+v8jv1ebrmf+G/ZQ40Xrud0L0LsqqBoEps4kEtUgQsj
	F7RG7uyTfU1m6JCErqnmYVQ1WD78LyXt56uk2CFjYYk7r0a+o93DZZhNR6jRgFd4pNDJJ/JOk+O
	/tpi3YLjZgxtpNopq4W2HsVDaQ==
X-Received: by 2002:a05:7300:ad06:b0:2ab:ca55:89b1 with SMTP id
 5a478bee46e88-2b6fd7bdf89mr2710322eec.40.1768997674493; Wed, 21 Jan 2026
 04:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com> <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
 <CANpmjNN=ug+TqKdeJu1qY-_-PUEeEGKW28VEMNSpChVLi8o--A@mail.gmail.com> <aW_rHVoiMm4ev0e8@tardis-2.local>
In-Reply-To: <aW_rHVoiMm4ev0e8@tardis-2.local>
From: Marco Elver <elver@google.com>
Date: Wed, 21 Jan 2026 13:13:57 +0100
X-Gm-Features: AZwV_QiNdZftFkEU8_aSSpgL9dCXraNCslVH2OipOEvIiJlDSmBop19Ul7_z1dM
Message-ID: <CANpmjNNpb7FE8usAhyZXxrVSTL8J00M4QyPUhKLmPNKfzqg=Ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers over
 raw pointers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	"Paul E. McKenney" <paulmck@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74848-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[garyguo.net,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,google.com,umich.edu,weathered-steel.dev,gmail.com];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F001D56AFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 at 23:29, Boqun Feng <boqun.feng@gmail.com> wrote:
[..]
> > > > READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
> > > > like memory_order_consume than it is memory_order_relaxed. This has, to
> > > > the best of my knowledge, not changed; otherwise lots of kernel code
> > > > would be broken.
>
> Our C's atomic_long_read() is the same, that is it's like
> memory_order_consume instead memory_order_relaxed.

I see; so it's Rust's Atomic::load(Relaxed) -> atomic_read() ->
READ_ONCE (for most architectures).

> > > On the Rust-side documentation we mentioned that `Relaxed` always preserve
> > > dependency ordering, so yes, it is closer to `consume` in the C11 model.
> >
> > Alright, I missed this.
> > Is this actually enforced, or like the C side's use of "volatile",
> > relies on luck?
> >
>
> I wouldn't call it luck ;-) but we rely on the same thing that C has:
> implementing by using READ_ONCE().

It's the age-old problem of wanting dependently-ordered atomics, but
no compiler actually providing that. Implementing that via "volatile"
is unsound, and always has been. But that's nothing new.

[...]
> > > I think this is a longstanding debate on whether we should actually depend on
> > > dependency ordering or just upgrade everything needs it to acquire. But this
> > > isn't really specific to Rust, and whatever is decided is global to the full
> > > LKMM.
> >
> > Indeed, but the implementation on the C vs. Rust side differ
> > substantially, so assuming it'll work on the Rust side just because
> > "volatile" works more or less on the C side is a leap I wouldn't want
> > to take in my codebase.
> >
>
> Which part of the implementation is different between C and Rust? We
> implement all Relaxed atomics in Rust the same way as C: using C's
> READ_ONCE() and WRITE_ONCE().

I should clarify: Even if the source of the load is "volatile"
(through atomic_read() FFI) and carries through to Rust code, the
compilers, despite sharing LLVM as the code generator, are different
enough that making the assumption just because it works on the C side,
it'll also work on the Rust side, appears to be a stretch for me. Gary
claimed that Rust is more conservative -- in the absence of any
guarantees, being able to quantify the problem would be nice though.

[..]
> > However, given "Relaxed" for the Rust side is already defined to
> > "carry dependencies" then in isolation my original comment is moot and
> > does not apply to this particular patch. At face value the promised
> > semantics are ok, but the implementation (just like "volatile" for C)
> > probably are not. But that appears to be beyond this patch, so feel
>
> Implementation-wise, READ_ONCE() is used the same as C for
> atomic_read(), so Rust and C are on the same boat.

That's fair enough.

Longer term, I understand the need for claiming "it's all fine", but
IMHO none of this is fine until compilers (both for C and Rust)
promise the semantics that the LKMM wants. Nothing new per-se, the
only new thing here that makes me anxious is that we do not understand
the real impact of this lack of guarantee on Linux Rust code (the C
side remains unclear, too, but has a lot more flight miles). Perhaps
the work originally investigating broken dependency ordering in Clang,
could be used to do a study on Rust in the kernel, too.

