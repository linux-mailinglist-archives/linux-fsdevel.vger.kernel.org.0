Return-Path: <linux-fsdevel+bounces-5536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875A80D33E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 18:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D09B20F12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 17:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ABB4D111;
	Mon, 11 Dec 2023 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kFBL2cI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBE7B4;
	Mon, 11 Dec 2023 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1702314298; x=1702573498;
	bh=hICd6xX0pWZMvUHgptvk6MN17tBFZ5wEr7xIBYhapgI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kFBL2cI8A2VVbApnMZefxfQoAV7krDo06fwBB/INYVg5h9I3xWVIaJ5Y/CXW2iTOW
	 zkmccE2guKKCcWtfH4NxOQBFph3bZqlEgoJFMJZ/NY/VfT8AKUNiQYG6R4/tqCh6L9
	 jTzEde1/2L9p2f2TezIofPRLny+FZ6QvrMFEQpnwcMSqQZZcqWYDadPKNPlw4cpAlj
	 DoeBj9SQ8YCFD0aF9ESEMCIIEKdXPHzRe/1gu26JX0+0rW7casmRDN6NyVxyIpPdxB
	 xhMdkcSS6sPqOF/6IMIsZRzGVhpn8hylty3nWCt/GS7BGGoxlf8nAqxC6FHoqxj2GA
	 6RYYKOgp1jh1A==
Date: Mon, 11 Dec 2023 17:04:52 +0000
To: Kent Overstreet <kent.overstreet@linux.dev>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, Kees Cook <keescook@chromium.org>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] rust: file: add `Kuid` wrapper
Message-ID: <rPOj4p2TGoIYUzMbmRCjmzHuCktN1rc0EVJ-skynzRblrqQLRU2GQaAPOb9RHhUBn_XhGfqcUii4EJBr_AWjoWHnTE8v_wQCMVmkgl2shg0=@proton.me>
In-Reply-To: <20231211155836.4qb4pfcfaguhuzo7@moria.home.lan>
References: <20231206-alice-file-v2-0-af617c0d9d94@google.com> <20231206-alice-file-v2-5-af617c0d9d94@google.com> <jtCKrRw-FNajNJOXOuI1sweeDxI8T_uYnJ7DxMuqnJc9sgWjS0zouT_XIS-KmPferL7lU51BwD6nu73jZtzzB0T17pDeQP0-sFGRQxdjnaA=@proton.me> <ZXNHp5BoR2LJuv7D@Boquns-Mac-mini.home> <20231211155836.4qb4pfcfaguhuzo7@moria.home.lan>
Feedback-ID: 71780778:user:proton
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/11/23 16:58, Kent Overstreet wrote:
> On Fri, Dec 08, 2023 at 08:43:19AM -0800, Boqun Feng wrote:
>> On Fri, Dec 08, 2023 at 04:40:09PM +0000, Benno Lossin wrote:
>>> On 12/6/23 12:59, Alice Ryhl wrote:
>>>> +    /// Returns the given task's pid in the current pid namespace.
>>>> +    pub fn pid_in_current_ns(&self) -> Pid {
>>>> +        // SAFETY: Calling `task_active_pid_ns` with the current task=
 is always safe.
>>>> +        let namespace =3D unsafe { bindings::task_active_pid_ns(bindi=
ngs::get_current()) };
>>>
>>> Why not create a safe wrapper for `bindings::get_current()`?
>>> This patch series has three occurrences of `get_current`, so I think it
>>> should be ok to add a wrapper.
>>> I would also prefer to move the call to `bindings::get_current()` out o=
f
>>> the `unsafe` block.
>>
>> FWIW, we have a current!() macro, we should use it here.
>=20
> Why does it need to be a macro?

This is a very interesting question. A `Task` is `AlwaysRefCounted`, so
if you have a `&'a Task`, someone above you owns a refcount on that
task. But the `current` task will never go away as long as you stay in
the same task. So you actually do not need to own a refcount as long as
there are no context switches.

We use this to our advantage and the `current!()` macro returns
something that acts like `&'a Task` but additionally is `!Send` (so it
cannot be sent over to a different task). This means that we do not need
to take a refcount on the current task to get a reference to it.

But just having a function that returns a `&'a Task` like thing that is
`!Send` is not enough, since there are no constraints on 'a. This is
because the function `Task::current` would take no arguments and there
is nothing the lifetime could even bind to.
Since there are no constraints, you could just choose 'a =3D 'static which
is obviously wrong, since there are tasks that end. For this reason the
`Task::current` function is `unsafe` and the macro `current!` ensures
that the lifetime 'a ends early enough. It is implemented like this:

    macro_rules! current {
        () =3D> {
            // SAFETY: Deref + addr-of below create a temporary `TaskRef` t=
hat cannot outlive the
            // caller.
            unsafe { &*$crate::task::Task::current() }
        };
    }

Note the `&*`. This ensures that the thing returned by `Task::current`
is temporary and cannot outlive the current function thus preventing the
creation of static references to it.

If you want to read more, see here for Gary's original discovery of the
issue:
https://lore.kernel.org/rust-for-linux/20230331034701.0657d5f2.gary@garyguo=
.net/

--=20
Cheers,
Benno

