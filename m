Return-Path: <linux-fsdevel+bounces-4565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23B8800B0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 13:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820FEB20BD9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E923A25549
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RSyiSAtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E358319F
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 03:35:42 -0800 (PST)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2c9c5db77b8so14299511fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 03:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701430541; x=1702035341; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qEkAP1I3qkXnBXX51BCMUCkxCSmzCgvaSA2DFugwU0k=;
        b=RSyiSAttj6AD0qcDKZRtFj4CyqlYT8YxZ7cw64/dQXoKu9MmAKHyBRsLnrcKqd6g3j
         Vx1XIZdXNzihq2Y6fQmgNey96WlGv9CO0vqY2U1c2e+lyledj1LNHnUPIEXIzyzMhPW0
         tx/MLqRbsI0Vlwdcqz/One6ot1LRfUG6ymJtm7WkFHgqi5aJCZjF3MGA4iuwWyizXgO4
         w7l9FULQE6l0e7DCJLFNzp0k6gGATb8jUuZ9wJEsujmiHbE1XfVbrazkrAwwu0X/eaHj
         b1gg4/OucszMKoRTHKxFdHV3VU9MZpoPq3mBSXx+L5eHO42cNlr+8kc5L5oYfKVE/mML
         C6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701430541; x=1702035341;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEkAP1I3qkXnBXX51BCMUCkxCSmzCgvaSA2DFugwU0k=;
        b=i0jR5DmFfLoXoif26BR7TPfQllGs/lPzbKrW+VSRgOHVQZCy5ghoxE4Q7suX2/fAld
         070LpjCDKUFXfUcWnE7QNx3ODezLDX00LZ7iEb2O86Z8tLBN8lHcpVe3g2pY4rWPc+f7
         zgleXa0WFeiZwL1pWlb7dO1R41i1zK0JiKOQlRP7udrl/q/M4VqN0YS1I9Tf10f2yyhF
         ePAb4xnrm18GZ65AyqfTVT1yIqDp1rwSK7D9u8w3ZlXz3SKHmL2NHpXqvHQuZGS7CDvf
         1SnHlGt5UnQd8q/as/BZnaDeH+7arqX5OP9j/5w1KeKdyaeD6j1VOTJZs7jNAYlNNzvi
         joig==
X-Gm-Message-State: AOJu0Yy1+pJqCrlSoTzrOGyIlc3/T+bquaMlSXPMhl5cXHhKYX8lvFqu
	cyWvhb4RqRdjTTJnx68+Qh1WTdFrNm2ZfS4=
X-Google-Smtp-Source: AGHT+IFeTcBN1rZeBuZXq6yiD1BS3gZazpYc5NDt39EiWjUlJlgLZM3L2VCrcBV0qyu1cAqEZnjYwmFr2+yoba0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:86cd:0:b0:2c9:aecd:306 with SMTP id
 n13-20020a2e86cd000000b002c9aecd0306mr53095ljj.0.1701430541098; Fri, 01 Dec
 2023 03:35:41 -0800 (PST)
Date: Fri,  1 Dec 2023 11:35:38 +0000
In-Reply-To: <LNSA8EeuwLGDBzY1W8GaP1L6gucAPE_34myHWuyg3ziYuheiFLk3WfVBPppzwDZwoGVTCqL8EBjAaxsNshTY6AQq_sNtK9hmea7FeaNJuCo=@proton.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <LNSA8EeuwLGDBzY1W8GaP1L6gucAPE_34myHWuyg3ziYuheiFLk3WfVBPppzwDZwoGVTCqL8EBjAaxsNshTY6AQq_sNtK9hmea7FeaNJuCo=@proton.me>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201113538.2202170-1-aliceryhl@google.com>
Subject: Re: [PATCH 6/7] rust: file: add `DeferredFdCloser`
From: Alice Ryhl <aliceryhl@google.com>
To: benno.lossin@proton.me
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	brauner@kernel.org, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Benno Lossin <benno.lossin@proton.me> writes:
>> +        // SAFETY: The `inner` pointer points at a valid and fully initialized task work that is
>> +        // ready to be scheduled.
>> +        unsafe { bindings::task_work_add(current, inner, TWA_RESUME) };
> 
> I am a bit confused, when does `do_close_fd` actually run? Does
> `TWA_RESUME` mean that `inner` is scheduled to run after the current
> task has been completed?

When the current syscall returns to userspace.

>> +    // SAFETY: This function is an implementation detail of `close_fd`, so its safety comments
>> +    // should be read in extension of that method.
>> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_head) {
>> +        // SAFETY: In `close_fd` we use this method together with a pointer that originates from a
>> +        // `Box<DeferredFdCloserInner>`, and we have just been given ownership of that allocation.
>> +        let inner = unsafe { Box::from_raw(inner as *mut DeferredFdCloserInner) };
> 
> In order for this call to be sound, `inner` must be an exclusive
> pointer (including any possible references into the `callback_head`).
> Is this the case?

Yes, when this is called, it's been removed from the linked list of task
work. That's why we can kfree it.

>> +        // SAFETY: Since `DeferredFdCloserInner` is `#[repr(C)]`, casting the pointers gives a
>> +        // pointer to the `twork` field.
>> +        let inner = Box::into_raw(self.inner) as *mut bindings::callback_head;
> 
> Here you can just use `.cast::<...>()`.

Will do.

Alice

