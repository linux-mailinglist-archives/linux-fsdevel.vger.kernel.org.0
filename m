Return-Path: <linux-fsdevel+bounces-4892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E0805D72
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 19:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0E11F21579
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 18:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6334C6A013
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 18:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4jU46IEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA1F90
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Dec 2023 10:16:40 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d7cc7cabcso7372135ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Dec 2023 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701800199; x=1702404999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvDZn7sftBIir4+u2Hr7XA8t0/oswoazuSS+rk054aU=;
        b=4jU46IEwm58jeuZBmdGpCc7GnkqmjRNtToApSmtmvVBXGvmrRsIXPJHzid/NRkBED2
         PjtYHX+F/QMG0hmvo93Y7DEvnvsEhwPju3HF7JyJNvkg8b3Ytz5L8yvg/g3ZYnIFCKbx
         1v3WBBeQdysTnFF8nju/MoRHCfiVZeGH7Rnl6v3gdqb5T4uyQyxknpSQS3aBdUlka/OU
         ZxQdjs7vgTWO3xRhgMzHnPtnkqCo7Durp2wjpVlE8whxi2hZfnJqIqdvjlVV5imn+E7f
         6uRfFcUukota4SBxQXaQd6gibwzeEL0lBkl7U8l0mVfZgcDCymY6j2mTxUvBRHrAtIOy
         sWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800199; x=1702404999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvDZn7sftBIir4+u2Hr7XA8t0/oswoazuSS+rk054aU=;
        b=nT6mF/0Gg0wLVJC8hCqaXpsLCJCuU/RO6g3BT1GAH8E/XJMANXGkNWYZ6O+w7GO3iA
         qUXqGYXwsHqsfFYDJr0561U37FGUHGUbjmErJVwC082RUOL3PhvM347p3pnL2yQCeiOY
         nAMSguv6XyB9dcxwOPhQBh6b9Kf3tCg4UHAOghp7JyNPzeCOechtXMYJtQDmnaKhQMhk
         t0QmV1pG8so8K9a87vaVcQwgz1j15O2trbjWwZF5SvxWHJ1wViKLRGbjVlPaEAgOYqIu
         g+y+2S2TwjSEi1aN/wZ6w7ZTYihAzMkVEDx41ytI/CLjvTMk1/1xCaCoiFAkF5fzEeEA
         rQZA==
X-Gm-Message-State: AOJu0Yx/hPJHVrd4lN40dKfib1IEBrEQo6E97NgRoMbLPpt94vAR2dyM
	tJMyJ1sfkpM29uyXtiHpNbDRQwwh3C+7GK4P+jFczw==
X-Google-Smtp-Source: AGHT+IEa4EYgTTnLdOrl0nl6mQB3fbLx+1/3UykRuzI0tX+uoBZQQfbPf5J+lEfqYnGJLMqZyqY2Y8NN5ztw4bjxDu4=
X-Received: by 2002:a92:ddce:0:b0:35d:59a2:2bc with SMTP id
 d14-20020a92ddce000000b0035d59a202bcmr6710657ilr.92.1701800199414; Tue, 05
 Dec 2023 10:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bUU6jGtJ7KdkuVp8UPORb0cmDoU6sRjc1iVRMfgO34u5ySo44Z5MXrnYgE6pfQDFu4-V5CBAuhS8uZDoEA6CsIiLUiWJedNZ2CTf9cRATfQ=@proton.me>
 <20231205144345.308820-1-aliceryhl@google.com>
In-Reply-To: <20231205144345.308820-1-aliceryhl@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 5 Dec 2023 19:16:27 +0100
Message-ID: <CAH5fLggz5ArqX076OgBaqFF57-f9h1E_hGOeiXfhcfe-neW_jQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] rust: file: add `DeferredFdCloser`
To: benno.lossin@proton.me, brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, cmllamas@google.com, 
	dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net, 
	gregkh@linuxfoundation.org, joel@joelfernandes.org, keescook@chromium.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, maco@android.com, 
	ojeda@kernel.org, peterz@infradead.org, rust-for-linux@vger.kernel.org, 
	surenb@google.com, tglx@linutronix.de, tkjos@android.com, 
	viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:43=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Benno Lossin <benno.lossin@proton.me> writes:
> > On 12/1/23 12:35, Alice Ryhl wrote:
> >> Benno Lossin <benno.lossin@proton.me> writes:
> >>>> +        // SAFETY: The `inner` pointer points at a valid and fully =
initialized task work that is
> >>>> +        // ready to be scheduled.
> >>>> +        unsafe { bindings::task_work_add(current, inner, TWA_RESUME=
) };
> >>>
> >>> I am a bit confused, when does `do_close_fd` actually run? Does
> >>> `TWA_RESUME` mean that `inner` is scheduled to run after the current
> >>> task has been completed?
> >>
> >> When the current syscall returns to userspace.
> >
> > What happens when I use `DeferredFdCloser` outside of a syscall? Will
> > it never run? Maybe add some documentation about that?
>
> Christian Brauner, I think I need your help here.
>
> I spent a bunch of time today trying to understand the correct way of
> closing an fd held with fdget, and I'm unsure what the best way is.
>
> So, first, `task_work_add` only really works when we're called from a
> syscall. For one, it's fallible, and for another, you shouldn't even
> attempt to use it from a kthread. (See e.g., the implementation of
> `fput` in `fs/file_table.c`.)
>
> To handle the above, we could fall back to the workqueue and schedule
> the `fput` there when we are on a kthread or `task_work_add` fails. And
> since I don't really care about the performance of this utility, let's
> say we just unconditionally use the workqueue to simplify the
> implementation.
>
> However, it's not clear to me that this is okay. Consider this
> execution: (please compare to `binder_deferred_fd_close`)
>
>     Thread A                Thread B (workqueue)
>     fdget()
>     close_fd_get_file()
>     get_file()
>     filp_close()
>     schedule_work(do_close_fd)
>     // we are preempted
>                             fput()
>     fdput()
>
> And now, since the workqueue can run before thread A returns to
> userspace, we are in trouble again, right? Unless I missed an upgrade
> to shared file descriptor somewhere that somehow makes this okay? I
> looked around the C code and couldn't find one and I guess such an
> upgrade has to happen before the call to `fdget` anyway?
>
> In Binder, the above is perfectly fine since it closes the fd from a
> context where `task_work_add` will always work, and a task work
> definitely runs after the `fdput`. But I added this as a utility in the
> shared kernel crate, and I want to avoid the situation where someone
> comes along later and uses it from a kthread, gets the fallback to
> workqueue, and then has an UAF due to the previously mentioned
> execution...
>
> What do you advise that I do?
>
> Maybe the answer is just that, if you're in a context where it makes
> sense to talk about an fd of the current task, then task_work_add will
> also definitely work? So if `task_work_add` won't work, then
> `close_fd_get_file` will return a null pointer and we never reach the
> `task_work_add`. This seems fragile though.
>
> Alice

Ah! I realized that there's another option: Report an error if we
can't schedule the task work.

I didn't suggest this originally because I didn't want to leak the
file in the error path, and I couldn't think of anything else sane to
do.

But! We can schedule the task work *first*, then attempt to close the
file. This way, the file doesn't get closed in the error path. And
there's no race condition since the task work is guaranteed to get
scheduled later on the same thread, so there's no way for it to get
executed in between us scheduling it and closing the file.

Thoughts?

Alice

