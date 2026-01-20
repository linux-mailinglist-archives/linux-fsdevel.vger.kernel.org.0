Return-Path: <linux-fsdevel+bounces-74701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EX1MrfVb2mgMQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:21:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4C4A311
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 369528618BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7988D350A0E;
	Tue, 20 Jan 2026 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAduhc4W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60EF34FF46
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768929082; cv=pass; b=eDX+mIVMSMYktfHLdJSXsjsDSUryY0e7K7VZ13qJ3WC5sZZ5dFTqWkebCaloKq7EW+1wB4lPqh/Dz6Lkoq0MRo//kKeK6UTgPyplZmS2nCaSjXlMrVrRJo/uj+ydDPACmeJN/kNgr9T7OctjJrnsiBT/YzGzuZ6W1w69uXC+8UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768929082; c=relaxed/simple;
	bh=wBc9P3Wa/E5HztaOHrKq0qUCfPSUiP/k0OBPrspdgyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFDZn9aXIsvdYh0xeEGLfcOVb8gFHVA8UBj4TjmkAf8gbqTrK7fuC4Mov9AWdfWgVO/rJRNSjo+ryV256k2P3TuJvzG7nNSJSRTCdNXH5Af4ulrfnN+Cif3k5iAaSMrQPA26qBzWTwSD0nRS1mh3TihrYmMX0HWJ9ZKB5IwHfIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAduhc4W; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-121a0bcd364so7123887c88.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 09:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768929078; cv=none;
        d=google.com; s=arc-20240605;
        b=dKlJoS7PtAdMJCeoKchgStuRxsQ8uj/Gds3UdN+2HrMuIesSQOzE8zs3ivNv9QrJ2g
         Mb3OBlJBRzf6oOJQZKKkpsck/hvW/6nUhPSlH1ZeqjECrr5y79zTUkySEYXZ+i8fuWSM
         1qCsutgOBT/8JaYNMe3OdIeJqHV/sKQ8AFkSfm4IhG+bZObFTG9MVJduRNfoncqsgd+r
         009lnLOsG2Z+yL6OwR1cGNTOeukDO9SQWkI9fqpfdaYz1ozU6bx6Jnd+H82pDLlNakHV
         Hx+dKTlznkDAeoSIoeR5JZpayuoAPR3tuKmsDdL0UzIwV4rwO828qJiPYxW09X9XTIUr
         Vhgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g4kM6F8fKl+Qeywz6sdK1X/LSmekcFRs5fj3WsFdO/s=;
        fh=p981IPAoCBO5tRGAhyfjWYkiszcYZ4XQtYvfnQYzrjo=;
        b=gC6fADtYUCUbshrmUcpMBg4c0P3ay9PMf6MxA+qfZRHXG97Yvi0f4pfAUiVYh0Auos
         y1kgL3bJZS1vW/+s7xFqflyxIFRTsk9kc1gjHpNuZNKp5PqnW/m3LOgWnHFUDyVI9AX4
         JxGKzkhYV28Q46inqWLMFEi/h8RdN4jZEmGxDoiClaxk8cgrHOMUcjMyFxF6jYtkaZYf
         CklK4r7LOvWT1cSJOn/byh0n5IJfSPJWUQ2Xs8RhJY7nfECSIG8A5xcBDaYCuIOHSYBu
         /uBSPJzcMl+ACua5yN0CRuwxnhtAcR4SMQqljlpqxFZK9EdKzAjvEYHMtEpO9Rp5/YmK
         6rXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768929078; x=1769533878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g4kM6F8fKl+Qeywz6sdK1X/LSmekcFRs5fj3WsFdO/s=;
        b=cAduhc4WWHaT3rj3l8WO/Wij2nq43B6VQfDT837HyhucGymmHq86KuiVewbM1qEzDY
         K/+cKikLqQF/69g9eprbakxGzlhejFZvNIUHgfpJc5qqptFZOZh1JVKAt2diIqXcdaWK
         /SH0KjZKg+TazDuHLWBjRVSqgTD9T/YVJN3McUpo6dnHcbLxBtWFWaC4J4fex7Swf7QK
         Moq2mRMkN/2O8lhPmrJkJH7QwTMpH/yA8H27b5k03kVlahtmO9+7+Bbmb1Nt3I50lNPg
         gzGz+JW1ysvHHCviJSMU5pzd2hL1Ej6t8ZHbaRtn0gmlQBa4pEw8K3QPd8O8nBoMUDAy
         grww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768929078; x=1769533878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g4kM6F8fKl+Qeywz6sdK1X/LSmekcFRs5fj3WsFdO/s=;
        b=ffRQFmuuTDR0PXCUFbkEddiOz3h4Q/Up8FGYjkHPdMBA1xLPQaYK7K3VoSD59Q7++l
         NMMWj5pGfss3SmkdO8M1Dx7bsaVCk/h6dhhC3Dg/LNnXU4108wUGQtGaCs+F4JETVlw4
         UK6JSXfoy56+W9m//7KFst0+DrPcKnfhUd2xAJCCzu1xPuNbfa0xYThWuAdz232zBn6V
         NEx5SRMHoLeZHYmReFEjWdCYL4tw/DyrWmJ7YrfK1N7kn+7HDZaIY3CU0POj6rdFOrJl
         /llcSku0StcPf36rjVAR1fxns+EnAj7JYOhCXuX5UbcmQDy7KlIIRKscduRj99ZCYNcX
         Tzag==
X-Forwarded-Encrypted: i=1; AJvYcCWbbvw1j51MX/geZkxV2/lFKktSA7X4Hwxzmb7ypopd5o4BmuGgzjgHGpFt3cfPxXwEqm6bivXlyM3AthuO@vger.kernel.org
X-Gm-Message-State: AOJu0YwyaQOaJCZZLVkiwOEysJCFmOu4DEfff9+ISd+CBF0+EDF8dlvq
	sUT7MmeG8fCQ40iZutkVST/5U+klk5rBijReJ9Y+74ofzTkpeoPqTAq1Rr+LuiyQdr0QU65kOLg
	ulikMDJFkkz4dkFjyP5w+ZCbELEb7XM3nbpZQ+rVj
X-Gm-Gg: AY/fxX4MUvlO/anzxPUC4LT17uUdBBzlcHHBmZRVZ5hh/gRMjuu4xsmc1YMvzAh5gvp
	kH/d6rq0Zqy1E7zpBtba6jMf5c66gTF5eDQwB6Q346hI7RkOjyVHeCoR668FFkB1BRjli0EKvml
	p9i8Is+m0uZLFUg5VsvKZfZ/AfM0urACJcBRigaemMYelWsCodOOitgwdNRZCR2b9IytQtZ+nXP
	TOK5TWQtvC9uhnlZppXb44Dai1aAayZEFugpmK0qFCh7iKj+Sx0GGTyBPDjfoQRbYxT7k7q9Gwj
	ZIaQFr5/WOpDaI8N2pwrhLYfm3E=
X-Received: by 2002:a05:7022:628d:b0:11b:a8e3:8468 with SMTP id
 a92af1059eb24-1244a779a72mr13184278c88.33.1768929077367; Tue, 20 Jan 2026
 09:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120115207.55318-1-boqun.feng@gmail.com> <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com> <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
In-Reply-To: <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
From: Marco Elver <elver@google.com>
Date: Tue, 20 Jan 2026 18:10:40 +0100
X-Gm-Features: AZwV_Qj8_3cuVM1FyOzfrOkRiYXrFtw2NSR95u4VFEpxArqad_WPWywp-t-FlH0
Message-ID: <CANpmjNN=ug+TqKdeJu1qY-_-PUEeEGKW28VEMNSpChVLi8o--A@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers over
 raw pointers
To: Gary Guo <gary@garyguo.net>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-74701-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,protonmail.com,google.com,umich.edu,weathered-steel.dev];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lpc.events:url,garyguo.net:email]
X-Rspamd-Queue-Id: 69E4C4A311
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 at 17:47, Gary Guo <gary@garyguo.net> wrote:
>
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

Alright, I missed this.
Is this actually enforced, or like the C side's use of "volatile",
relies on luck?

> > It is known to be brittle [1]. So the recommendation
> > above is unsound; well, it's as unsound as implementing READ_ONCE with a
> > volatile load.
>
> Sorry, which part of this is unsound? You mean that the dependency ordering is
> actually lost when it's not supposed to be? Even so, it'll be only a problem on
> specific users that uses `Relaxed` to carry ordering?

Correct.

> Users that use `Relaxed` for things that don't require any ordering would still
> be fine?

Yes.

> > While Alice's series tried to expose READ_ONCE as-is to the Rust side
> > (via volatile), so that Rust inherits the exact same semantics (including
> > its implementation flaw), the recommendation above is doubling down on
> > the unsoundness by proposing Relaxed to map to READ_ONCE.
> >
> > [1] https://lpc.events/event/16/contributions/1174/attachments/1108/2121/Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20Kernel.pdf
> >
>
> I think this is a longstanding debate on whether we should actually depend on
> dependency ordering or just upgrade everything needs it to acquire. But this
> isn't really specific to Rust, and whatever is decided is global to the full
> LKMM.

Indeed, but the implementation on the C vs. Rust side differ
substantially, so assuming it'll work on the Rust side just because
"volatile" works more or less on the C side is a leap I wouldn't want
to take in my codebase.

> > Furthermore, LTO arm64 promotes READ_ONCE to an acquire (see
> > arch/arm64/include/asm/rwonce.h):
> >
> >         /*
> >          * When building with LTO, there is an increased risk of the compiler
> >          * converting an address dependency headed by a READ_ONCE() invocation
> >          * into a control dependency and consequently allowing for harmful
> >          * reordering by the CPU.
> >          *
> >          * Ensure that such transformations are harmless by overriding the generic
> >          * READ_ONCE() definition with one that provides RCpc acquire semantics
> >          * when building with LTO.
> >          */
> >
> > So for all intents and purposes, the only sound mapping when pairing
> > READ_ONCE() with an atomic load on the Rust side is to use Acquire
> > ordering.
>
> LLVM handles address dependency much saner than GCC does. It for example won't
> turn address comparing equal into meaning that the pointer can be interchanged
> (as provenance won't match). Currently only address comparision to NULL or
> static can have effect on pointer provenance.
>
> Although, last time I asked if we can rely on this for address dependency, I
> didn't get an affirmitive answer -- but I think in practice it won't be lost (as
> currently implemented).

There is no guarantee here, and this can change with every new
release. In most cases where it matters it works today, but the
compiler (specifically LLVM) does break dependencies even if rarely
[1].

> Furthermore, Rust code currently does not participate in LTO.

LTO is not the problem, aggressive compiler optimizations (as
discussed in [1]) are. And Rust, by virtue of its strong type system,
appears to give the compiler a lot more leeway how it optimizes code.
So I think the Rust side is in greater danger here than the C with LTO
side. But I'm speculating (pun intended) ...

However, given "Relaxed" for the Rust side is already defined to
"carry dependencies" then in isolation my original comment is moot and
does not apply to this particular patch. At face value the promised
semantics are ok, but the implementation (just like "volatile" for C)
probably are not. But that appears to be beyond this patch, so feel
free to ignore.

