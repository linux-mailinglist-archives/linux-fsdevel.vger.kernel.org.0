Return-Path: <linux-fsdevel+bounces-5840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D4810F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 12:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BF7B20CF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E022EE2;
	Wed, 13 Dec 2023 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0kvirctx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB57BD
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:04:41 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d9f4eed60eso4062525a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702465480; x=1703070280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OfkgN2PJIbw2ezV94FT4cZwlilOoY4SLjkbyeO7luc=;
        b=0kvirctxEF3tP+NgcVpfQIhGDmo6bskitzhpp8N1uL3X9AcI7Wbh7pzyPUs4EN5MjR
         eCmxJQXY7nam1daeWfv+/DtTur0zyAeYhqIacVAQnxR0QqzdIG4GwAUbnrF7KvFDaUaB
         epe+Ikn40RB9mBkUxFgWaE2wrGBew67Go3IL+/kDS80cAdKrFh+DmBEKnph8xrtLxNi9
         13VDI8bpioKJvfZoyhygom5dtqFJFrYQ32n9Md/Ga0PdvF8l+GgvcYpVTfMkcn4yNhJ+
         OwkUCyDCsXZ0ApFQ5br/xzcS3BDp/JGv/O1ZbhQdD5DKXTqiHw76kuDPcHtGsiGQ61kC
         QZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702465480; x=1703070280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OfkgN2PJIbw2ezV94FT4cZwlilOoY4SLjkbyeO7luc=;
        b=D1i7xNJHhOHWeKq5Nw9osIGkWvpkw3b6rRPuYNQULvwopdAJU3jvSZ66T2K9X/zcel
         HZdLPLtwGY/mwucC9Xk9HLzaMtTYAZJfOQR8gK5kZFfhvmZYrGOuzZihj8hUUp7uNoEt
         0oR8Y07RuWbaLFMteYytB0g6VX5+Y9Uxl330kSzRrm8qXFCVljLEqQA3IynJC2izqn0d
         D/wH+ZVA7nNgjhBxHvpbVm5iz1DGKSK1Zi8Ivdw+96SY5pyWed7CUnpbBMf8mcAU5Jvp
         Ny1wJ1zKeqLLs3M0V0FTOJDB37R3QPs6R2lRf7AG7KC43F2YaoF9TXh+tprAU8HoQ9gs
         rnVQ==
X-Gm-Message-State: AOJu0Yxh1lQT6YJR6sFkvRzCyhHD1FMsBMDM6I/jWc9FmbocRfuyiz8U
	8D9dB2kmdA3dhYblYcfb10ASeyzqR1h9yvysof3sHw==
X-Google-Smtp-Source: AGHT+IEM6BN7v5f3zSptK13rp4Iti293Tj3jpfPMFy+2qx3uN3e2Hkdo1HScrQhzZSsl9fR6iHqgEWv1vuVRiinjMLE=
X-Received: by 2002:a9d:6185:0:b0:6d9:e28c:28ef with SMTP id
 g5-20020a9d6185000000b006d9e28c28efmr7004936otk.55.1702465480518; Wed, 13 Dec
 2023 03:04:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
 <20231211153440.4162899-1-aliceryhl@google.com> <ZXdJyGFeQEbZU3Eh@boqun-archlinux>
 <ZXe2fpN4zRlkLLJC@boqun-archlinux> <ZXjJLP5NdbxEzKpC@boqun-archlinux>
In-Reply-To: <ZXjJLP5NdbxEzKpC@boqun-archlinux>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Dec 2023 12:04:29 +0100
Message-ID: <CAH5fLgjT48X-zYtidv31mox3C4_Ogoo_2cBOCmX0Ang3tAgGHA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
To: Boqun Feng <boqun.feng@gmail.com>
Cc: benno.lossin@proton.me, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	arve@android.com, bjorn3_gh@protonmail.com, brauner@kernel.org, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 9:57=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Dec 11, 2023 at 05:25:18PM -0800, Boqun Feng wrote:
> > On Mon, Dec 11, 2023 at 09:41:28AM -0800, Boqun Feng wrote:
> > > On Mon, Dec 11, 2023 at 03:34:40PM +0000, Alice Ryhl wrote:
> > > > Benno Lossin <benno.lossin@proton.me> writes:
> > > > > On 12/6/23 12:59, Alice Ryhl wrote:
> > > > > > +    /// Schedule a task work that closes the file descriptor w=
hen this task returns to userspace.
> > > > > > +    ///
> > > > > > +    /// Fails if this is called from a context where we cannot=
 run work when returning to
> > > > > > +    /// userspace. (E.g., from a kthread.)
> > > > > > +    pub fn close_fd(self, fd: u32) -> Result<(), DeferredFdClo=
seError> {
> > > > > > +        use bindings::task_work_notify_mode_TWA_RESUME as TWA_=
RESUME;
> > > > > > +
> > > > > > +        // In this method, we schedule the task work before cl=
osing the file. This is because
> > > > > > +        // scheduling a task work is fallible, and we need to =
know whether it will fail before we
> > > > > > +        // attempt to close the file.
> > > > > > +
> > > > > > +        // SAFETY: Getting a pointer to current is always safe=
.
> > > > > > +        let current =3D unsafe { bindings::get_current() };
> > > > > > +
> > > > > > +        // SAFETY: Accessing the `flags` field of `current` is=
 always safe.
> > > > > > +        let is_kthread =3D (unsafe { (*current).flags } & bind=
ings::PF_KTHREAD) !=3D 0;
> > > > >
> > > > > Since Boqun brought to my attention that we already have a wrappe=
r for
> > > > > `get_current()`, how about you use it here as well?
> > > >
> > > > I can use the wrapper, but it seems simpler to not go through a
> > > > reference when we just need a raw pointer.
> > > >
> > > > Perhaps we should have a safe `Task::current_raw` function that jus=
t
> > > > returns a raw pointer? It can still be safe.
> > > >
> > >
> > > I think we can have a `as_ptr` function for `Task`?
> > >
> > >     impl Task {
> > >         pub fn as_ptr(&self) -> *mut bindings::task_struct {
> > >             self.0.get()
> > >         }
> > >     }
> >
> > Forgot mention, yes a ptr->ref->ptr trip may not be ideal, but I think
> > eventually we will have a task work wrapper, in that case maybe
> > Task::as_ptr() is still needed somehow.
> >
>
> After some more thoughts, I agree `Task::current_raw` may be better for
> the current usage, since we can also use it to wrap a
> `current_is_kthread` method like:
>
>     impl Task {
>         pub fn current_is_kthread() -> bool {
>             let current =3D Self::current_raw();
>
>             unsafe { (*current).flags & bindings::PF_KTHREAD !=3D 0 }
>         }
>     }

I'll introduce a current_raw, then.

Alice

