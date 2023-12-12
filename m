Return-Path: <linux-fsdevel+bounces-5636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4281480E7CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B3CFB21066
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8FA58AB8;
	Tue, 12 Dec 2023 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGpe/89b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BAC10C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:35:14 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7cac4a9faccso851616241.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702373713; x=1702978513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5kVfTnLQevZugTrV3NDGK0H9bL6l1+gNDaTPF8RWEk=;
        b=lGpe/89boaD9ZI+ncOndT2n8LSizTaIe9u89A78S/DqBKZHwSBlpomKUESVyiIAP6L
         i2vMJrOM927kkb6WO5MlFVkkVeBis7MNi5Ry6Rk0L5noQUevZRwCwlxE5izYlJWGC+Y5
         /KihhGQCFD5LoxGwLlakMkFCatGOMHVxfb+2w9xvtnrB1ZH+c06L3Uw3pT42/oQ11/N7
         j55CNIezuoQYP6/pTRCNwznJYY0x1jKipHB6SPEnv3Qk0+ctbhcgbbA30Lk7xZ2oy2WE
         K+Fp6Lt2PKNcuaanmfIZx3c7AUky7qoeDAVdhUo+Y1Vt+uf6z7vZtmw3wpYHxo6PIDGF
         UN+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702373713; x=1702978513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5kVfTnLQevZugTrV3NDGK0H9bL6l1+gNDaTPF8RWEk=;
        b=D3vzbbk0bbxFnZ0cfUftJWxUJ0arzE8VjPmDSWTbAPWEasEG+wPZOXdyi2j5Cn/Fcd
         ibiVSRDgy+/nVKKPvmoXSj6/Fwdl2tLiodNcRwK7pVbR+zSEFrHN9amxDVPF8W1JgdjV
         PJKjk/RkH5YvcjdhSpJpJh96n0goC94Phsno+SlYBtTRINmKoUnka63uJKoMUoeVMeQf
         bueon9FndWqmZRwG5D81T2gNcNarm7G4oOFnGT8vpb9D+paPAJuNEyaIzlq8qmbP2eVy
         xwCigy67N3Y+0+2uf+Y2USpVArGvtjMGXbBGI1uI+4fUda8voGFFQ2Lhy6G7t2p6f2S3
         XuCQ==
X-Gm-Message-State: AOJu0Ywzb+63eOvoE4IgMvKhvNixQfGml05icB2AlFBqzKVeuiE71Orl
	z/RbmicE7yHuT+32zpmJnlKr1IlH3KeVSWiAqWuf9w==
X-Google-Smtp-Source: AGHT+IE5sQlEw46z54SEjhhoFiMRPmZ9k7QZFiQP6/ZdtnfcYlyXGn0eEnZSJ1mWK95kKsG47pa75GO2fjTwFAtdrv4=
X-Received: by 2002:a05:6102:32c5:b0:464:7b6d:2efc with SMTP id
 o5-20020a05610232c500b004647b6d2efcmr4630110vss.34.1702373713422; Tue, 12 Dec
 2023 01:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MjDmZBGV04fVI1qzhceEjQgcmoBuo3YoVuiQdANKj9F1Ux5JFKud8hQpfeyLXI0O5HG6qicKFaYYzM7JAgR_kVQfMCeVdN6t7PjbPaz0D0U=@proton.me>
 <20231211153440.4162899-1-aliceryhl@google.com> <DNn_nN0MKmn9OoY7Gjn4fCUcwKD6ijDZyDXVHvouEa2w0o2yiXeRox3EUfAcbfoWqx0I24-8HqqzONjuTQIVxu2cfAoNQpUFJygPtQNXPM4=@proton.me>
In-Reply-To: <DNn_nN0MKmn9OoY7Gjn4fCUcwKD6ijDZyDXVHvouEa2w0o2yiXeRox3EUfAcbfoWqx0I24-8HqqzONjuTQIVxu2cfAoNQpUFJygPtQNXPM4=@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 12 Dec 2023 10:35:02 +0100
Message-ID: <CAH5fLggB_33jR1eyXSFhN=DN34wD7E6-ckSU8ABmQ50H-L3P-w@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] rust: file: add `DeferredFdCloser`
To: Benno Lossin <benno.lossin@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org, 
	cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz, 
	gary@garyguo.net, gregkh@linuxfoundation.org, joel@joelfernandes.org, 
	keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 6:23=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> >>> +        unsafe { bindings::init_task_work(callback_head, Some(Self::=
do_close_fd)) };
> >>> +        // SAFETY: The `callback_head` pointer points at a valid and=
 fully initialized task work
> >>> +        // that is ready to be scheduled.
> >>> +        //
> >>> +        // If the task work gets scheduled as-is, then it will be a =
no-op. However, we will update
> >>> +        // the file pointer below to tell it which file to fput.
> >>> +        let res =3D unsafe { bindings::task_work_add(current, callba=
ck_head, TWA_RESUME) };
> >>> +
> >>> +        if res !=3D 0 {
> >>> +            // SAFETY: Scheduling the task work failed, so we still =
have ownership of the box, so
> >>> +            // we may destroy it.
> >>> +            unsafe { drop(Box::from_raw(inner)) };
> >>> +
> >>> +            return Err(DeferredFdCloseError::TaskWorkUnavailable);
> >>
> >> Just curious, what could make the `task_work_add` call fail? I imagine
> >> an OOM situation, but is that all?
> >
> > Actually, no, this doesn't fail in OOM situations since we pass it an
> > allocation for its linked list. It fails only when the current task is
> > exiting and wont run task work again.
>
> Interesting, is there some way to check for this aside from calling
> `task_work_add`?

I don't think so. We would need to access the `work_exited` constant
in `kernel/task_work.c` to do that, but it is not exported.

> >> Also, you do not call it when `file` is null, which I imagine to be
> >> fine, but I do not know that since the C comment does not cover that
> >> case.
> >
> > Null pointer means that the fd doesn't exist, and it's correct to do
> > nothing in that case.
>
> I would also mention that in a comment (or the SAFETY comment).

Okay.

> >>> +        let file =3D unsafe { bindings::close_fd_get_file(fd) };
> >>> +        if file.is_null() {
> >>> +            // We don't clean up the task work since that might be e=
xpensive if the task work queue
> >>> +            // is long. Just let it execute and let it clean up for =
itself.
> >>> +            return Err(DeferredFdCloseError::BadFd);
> >>> +        }
> >>> +
> >>> +        // SAFETY: The `file` pointer points at a valid file.
> >>> +        unsafe { bindings::get_file(file) };
> >>> +
> >>> +        // SAFETY: Due to the above `get_file`, even if the current =
task holds an `fdget` to
> >>> +        // this file right now, the refcount will not drop to zero u=
ntil after it is released
> >>> +        // with `fdput`. This is because when using `fdget`, you mus=
t always use `fdput` before
> >>
> >> Shouldn't this be "the refcount will not drop to zero until after it i=
s
> >> released with `fput`."?
> >>
> >> Why is this the SAFETY comment for `filp_close`? I am not understandin=
g
> >> the requirement on that function that needs this. This seems more a
> >> justification for accessing `file` inside `do_close_fd`. In which case=
 I
> >> think it would be better to make it a type invariant of
> >> `DeferredFdCloserInner`.
> >
> > It's because `filp_close` decreases the refcount for the file, and doin=
g
> > that is not always safe even if you have a refcount to the file. To dro=
p
> > the refcount, at least one of the two following must be the case:
> >
> > * If the refcount decreases to a non-zero value, then it is okay.
> > * If there are no users of `fdget` on the file, then it is okay.
>
> I see, that makes sense. Is this written down somewhere? Or how does one
> know about this?

I don't think there's a single place to read about this. The comments
on __fget_light allude to something similar, but it makes the blanket
statement that you can't call filp_close while an fdget reference
exists, even though the reality is a bit more nuanced.

> >>> +        // We update the file pointer that the task work is supposed=
 to fput.
> >>> +        //
> >>> +        // SAFETY: Task works are executed on the current thread onc=
e we return to userspace, so
> >>> +        // this write is guaranteed to happen before `do_close_fd` i=
s called, which means that a
> >>> +        // race is not possible here.
> >>> +        //
> >>> +        // It's okay to pass this pointer to the task work, since we=
 just acquired a refcount with
> >>> +        // the previous call to `get_file`. Furthermore, the refcoun=
t will not drop to zero during
> >>> +        // an `fdget` call, since we defer the `fput` until after re=
turning to userspace.
> >>> +        unsafe { *file_field =3D file };
> >>
> >> A synchronization question: who guarantees that this write is actually
> >> available to the cpu that executes `do_close_fd`? Is there some
> >> synchronization run when returning to userspace?
> >
> > It's on the same thread, so it's just a sequenced-before relation.
> >
> > It's not like an interrupt. It runs after the syscall invocation has
> > exited, but before it does the actual return-to-userspace stuff.
>
> Reasonable, can you also put this in a comment?

What do you want me to add? I already say that it will be executed on
the same thread.

> >>> +/// Represents a failure to close an fd in a deferred manner.
> >>> +#[derive(Copy, Clone, Eq, PartialEq)]
> >>> +pub enum DeferredFdCloseError {
> >>> +    /// Closing the fd failed because we were unable to schedule a t=
ask work.
> >>> +    TaskWorkUnavailable,
> >>> +    /// Closing the fd failed because the fd does not exist.
> >>> +    BadFd,
> >>> +}
> >>> +
> >>> +impl From<DeferredFdCloseError> for Error {
> >>> +    fn from(err: DeferredFdCloseError) -> Error {
> >>> +        match err {
> >>> +            DeferredFdCloseError::TaskWorkUnavailable =3D> ESRCH,
> >>
> >> This error reads "No such process", I am not sure if that is the best
> >> way to express the problem in that situation. I took a quick look at t=
he
> >> other error codes, but could not find a better fit. Do you have any
> >> better ideas? Or is this the error that C binder uses?
> >
> > This is the error code that task_work_add returns. (It can't happen in
> > Binder.)
> >
> > And I do think that it is a reasonable choice, because the error only
> > happens if you're calling the method from a context that has no
> > userspace process associated with it.
>
> I see.
>
> What do you think of making the Rust error more descriptive? So instead
> of implementing `Debug` like you currently do, you print
>
>     $error ($variant)
>
> where $error =3D Error::from(*self) and $variant is the name of the
> variant?
>
> This is more of a general suggestion, I don't think that this error type
> in particular warrants this. But in general with Rust we do have the
> option to have good error messages for every error while maintaining
> efficient error values.

I can #[derive(Debug)] instead, I guess?

Alice

