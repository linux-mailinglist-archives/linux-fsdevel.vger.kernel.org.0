Return-Path: <linux-fsdevel+bounces-4254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F647FE361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27BF21C20A4B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8605647A52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoIX+xT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F521719
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:27:11 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c99d7d6820so2864541fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Nov 2023 13:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701293229; x=1701898029; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2hTtopqITA1NOU8ufJg3cZ/VO5bRhHdAt7Bf1Unqq0=;
        b=xoIX+xT7Gm4chymSVadHbYhOUWXay9VGJPA4GwtFc051X4ep2msBDXwBvp4l2ST8kn
         5B4MH15YDo2omLs6leVyFWjjKksaq9CJhy+/PsG7KMpLafpJRY+j5nLYZvoaG9RR8umV
         YvHdpm6QgKAYDtyjhwv5lYMhgFPADZiQaHSDpaZ9OEbf6/4LLuBwY09CjblwNcr0C12A
         vwH/dykZAgWvF+QkXBBRK+a5ajcCQLDrgtUtEKCT66q1gp/YaLEobu72h9voTAamcz42
         xx9iKIno2J5YEGx2aLjSUri4hyx8OfNwbFQMda+U95GhsMCFybZi/9apaiPnnNWT//OW
         cPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293229; x=1701898029;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2hTtopqITA1NOU8ufJg3cZ/VO5bRhHdAt7Bf1Unqq0=;
        b=Qw9rwgB5pMogQH2gc7S4m3hTAlx6A1+jxUtpfB5Q5o7mb3i11Pn06fPWR/ZYLLVi8R
         kULM64xjR/iUfBrx7eWc4o9xIGGPuwtF686LrvYdQvzZH0rqYZv24siWD/c0Lwk49dzI
         Prs9iAqYorUe4e9qfPAYuxs7292OroKXbyUmJDXTJDlMYbQRGaSQJnIqUNqktMNgNwf5
         Qv2Qty4ul3bjlR9dTK/tM6gwWSY2nPr+LSPa3THQuCCERfG8IXxmdpH/NW5L32gamuc7
         y1f+I0TY70L5e7SaP/V5Y9ZPKv90Pl8TOgFq5pPOXD3mlUU3tYBnearNHZacrlV4pKtw
         30tA==
X-Gm-Message-State: AOJu0YyYyIxsavOqhccbSfV950GwVvFre+44fgT+5fLv+v4DxQMVaXJk
	NDAFYzsqMiB3ikk9RJJgeUlUdk1jEh6+hOU=
X-Google-Smtp-Source: AGHT+IE+ag2qdrnTq/19Gnj433K0mHPoHYUtUZESceENCYhveDyQiigp1dzSW+SKKfeB0lqgOvXr0+BvOBp+ZxA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:9642:0:b0:2c9:c2af:18c4 with SMTP id
 z2-20020a2e9642000000b002c9c2af18c4mr36689ljh.4.1701293229467; Wed, 29 Nov
 2023 13:27:09 -0800 (PST)
Date: Wed, 29 Nov 2023 21:27:07 +0000
In-Reply-To: <20231129-geleckt-verebben-04ea0c08a53c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129-geleckt-verebben-04ea0c08a53c@brauner>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129212707.3520214-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
From: Alice Ryhl <aliceryhl@google.com>
To: brauner@kernel.org
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com, 
	arve@android.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, cmllamas@google.com, dan.j.williams@intel.com, 
	dxu@dxuuu.xyz, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, keescook@chromium.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org, 
	peterz@infradead.org, rust-for-linux@vger.kernel.org, surenb@google.com, 
	tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk, 
	wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"

Christian Brauner <brauner@kernel.org> writes:
>> This abstraction makes it possible to manipulate the open files for a
>> process. The new `File` struct wraps the C `struct file`. When accessing
>> it using the smart pointer `ARef<File>`, the pointer will own a
>> reference count to the file. When accessing it as `&File`, then the
>> reference does not own a refcount, but the borrow checker will ensure
>> that the reference count does not hit zero while the `&File` is live.
> 
> Could you explain this in more details please? Ideally with some C and
> how that translates to your Rust wrappers, please. Sorry, this is going
> to be a long journey...

Yes of course. This touches on what I think is one of the most important
features that Rust brings to the table, which is the idea of defining
many different pointer types for different ownership semantics.

In the case of `struct file`, there are two pointer types that are
relevant:

 * `&File`. This is an "immutable reference" or "shared reference"
   (both names are used). This pointer type is used when you don't have
   any ownership over the target at all. All you have is _some_ sort of
   guarantee that target stays alive while the reference is live. In
   many cases, the borrow checker helps validate this at compile-time,
   but you can also use a backdoor (in this case from_ptr) to just
   unsafely say "I know this value is valid, so shut up compiler".
   Shared references have no destructor.

 * `ARef<File>`. The `ARef` type is a custom pointer type defined in the
   kernel in `rust/kernel/types.rs`. It represents a pointer that owns a
   ref-count to the inner value. ARef can only be used with types that
   have an `unsafe impl AlwaysRefCounted for T` block. Whenever you
   clone an `ARef`, it calls into the `inc_ref` method that you defined
   for the type, and whenever it goes out of scope and the destructor
   runs, it calls the `dec_ref` method that you defined for the type.

Potentially we might want a third in the future. The third pointer type
could be another custom pointer type just for `struct file` that uses
`fdget` instead of `fget`. However, I haven't added this since I don't
need it (dead code and so on).

To give an example of this, consider this really simple C function:

	bool is_nonblocking(struct file *file) {
		return !!(filp->f_flags & O_NONBLOCK);
	}

What are the ownership semantics of `file`? Well, we don't really care.
The caller needs to somehow ensure that the `file` is valid, but we
don't care if they're doing that with `fdget` or `fget` or whatever.
This corresponds to &File, so the Rust equivalent would be:

	fn is_nonblocking(file: &File) -> bool {
		(file.flags() & O_NONBLOCK) != 0
	}

Another example:

	void set_nonblocking_and_fput(struct file *file) {
		// Let's just ignore the lock for this example.
		file->f_flags |= O_NONBLOCK;

		fput(file);
	}

This method takes a file, sets it to non-blocking, and then destroys the
ref-count. What are the ownership semantics? Well, the caller should own
an `fget` ref-count, and we consume that ref-count. The equivalent Rust
code would be to take an `ARef<File>`:

	fn set_nonblocking_and_fput(file: ARef<File>) {
		file.set_flag(O_NONBLOCK);

		// When `file` goes out of scope here, the destructor
		// runs and calls `fput`. (Since that's what we defined
		// `ARef` to do on drop in `fn dec_ref`.)
	}

You can also explicitly call the destructor with `drop(file)`:

	fn set_nonblocking_and_fput(file: ARef<File>) {
		file.set_flag(O_NONBLOCK);
		drop(file);

		// When `file` goes out of scope, the destructor does
		// *not* run. This is because `drop(file)` is a move
		// (due to the signature of drop), and if you perform a
		// move, then the destructor no longer runs at the end
		// of the scope.
	}

And note that this would not compile, because we give up ownership of
the `ARef` by passing it to `drop`:

	fn set_nonblocking_and_fput(file: ARef<File>) {
		drop(file);
		file.set_flag(O_NONBLOCK);
	}

A third example:

	struct holds_a_file {
		struct file *inner;
	};

	struct file *get_the_file(struct holds_a_file *holder) {
		return holder->inner;
	}

What are the ownership semantics? Well, let's say that `holds_a_file`
owns a refcount to the file. Then, the pointer returned by get_the_file
is valid as long as `holder` is, but it doesn't have any ownership
over the file. You must stop using the returned file pointer before the
holder is destroyed.

The Rust equivalent is:

	struct HoldsAFile {
		inner: ARef<File>,
	}

	fn get_the_file(holder: &HoldsAFile) -> &File {
		&holder.inner
	}

The method signature is short-hand for (see [1]):

	fn get_the_file<'a>(holder: &'a HoldsAFile) -> &'a File {
		&holder.inner
	}

Here, 'a is a lifetime, and it ties together `holder` and the returned
reference in the way I described above. So e.g., this compiles:

	let holder = ...;
	let file = get_the_file(&holder);
	use_the_file(file);

But this doesn't:

	let holder = ...;
	let file = get_the_file(&holder);
	drop(holder);
	use_the_file(file); // Oops, destroying holder calls fput.

Notice also how the compiler accepted `&holder.inner` as the type
`&File` even though `inner` has type `ARef<File>`. This is because
`ARef` is defined to use something called deref coercion, which makes it
act like a real pointer type. This means that if you have an
`ARef<File>`, but you want to call a method that accepts `&File`, then
it will just work. (Deref coercion only exists for conversions into
reference types, so you can't pass a `&File` to something that takes an
`ARef<File>` without explicitly upgrading it to an `ARef<File>` by
taking a ref-count.)

[1]: https://doc.rust-lang.org/reference/lifetime-elision.html

>> +    /// Constructs a new `struct file` wrapper from a file descriptor.
>> +    ///
>> +    /// The file descriptor belongs to the current process.
>> +    pub fn from_fd(fd: u32) -> Result<ARef<Self>, BadFdError> {
>> +        // SAFETY: FFI call, there are no requirements on `fd`.
>> +        let ptr = ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_or(BadFdError)?;
>> +
>> +        // INVARIANT: `fget` increments the refcount before returning.
>> +        Ok(unsafe { ARef::from_raw(ptr.cast()) })
>> +    }
> 
> I think this is really misnamed.
> 
> File reference counting has two modes. For simplicity let's ignore
> fdget_pos() for now:
> 
> (1) fdget()
>     Return file either with or without an increased reference count.
>     If the fdtable was shared increment reference count, if not don't
>     increment refernce count.
> (2) fget()
>     Always increase refcount.
> 
> Your File implementation currently only deals with (2). And this
> terminology is terribly important as far as I'm concerned. This wants to
> be fget() and not from_fd(). The latter tells me nothing. I feel we
> really need to try and mirror the current naming closely. Not
> religiously ofc but core stuff such as this really benefits from having
> an almost 1:1 mapping between C names and Rust names, I think.
> Especially in the beginning.

Sure, I'll rename these methods in the next version.

>> +    /// Creates a reference to a [`File`] from a valid pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `ptr` points at a valid file and that its refcount does not
>> +    /// reach zero during the lifetime 'a.
>> +    pub unsafe fn from_ptr<'a>(ptr: *const bindings::file) -> &'a File {
>> +        // INVARIANT: The safety requirements guarantee that the refcount does not hit zero during
>> +        // 'a. The cast is okay because `File` is `repr(transparent)`.
>> +        unsafe { &*ptr.cast() }
>> +    }
> 
> How does that work and what is this used for? It's required that a
> caller has called from_fd()/fget() first before from_ptr() can be used?
> 
> Can you show how this would be used in an example, please? Unless you
> hold file_lock it is now invalid to access fields in struct file just
> with rcu lock held for example. Which is why returning a pointer without
> holding a reference seems dodgy. I'm probably just missing context.

This is the backdoor. You use it when *you* know that the file is okay
to access, but Rust doesn't. It's unsafe because it's not checked by
Rust.

For example you could do this:

	let ptr = unsafe { bindings::fdget(fd) };

	// SAFETY: We just called `fdget`.
	let file = unsafe { File::from_ptr(ptr) };
	use_file(file);

	// SAFETY: We're not using `file` after this call.
	unsafe { bindings::fdput(ptr) };

It's used in Binder here:
https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/rust_binder.rs#L331-L332

Basically, I use it to say "C code has called fdget for us so it's okay
to access the file", whenever userspace uses a syscall to call into the
driver.

>> +// SAFETY: The type invariants guarantee that `File` is always ref-counted.
>> +unsafe impl AlwaysRefCounted for File {
>> +    fn inc_ref(&self) {
>> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
>> +        unsafe { bindings::get_file(self.0.get()) };
>> +    }
> 
> Why inc_ref() and not just get_file()?

Whenever you see an impl block that uses the keyword "for", then the
code is implementing a trait. In this case, the trait being implemented
is AlwaysRefCounted, which allows File to work with ARef.

It has to be `inc_ref` because that's what AlwaysRefCounted calls this
method.

>> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
>> +        unsafe { bindings::fput(obj.cast().as_ptr()) }
>> +    }
> 
> Ok, so this makes me think that from_ptr() requires you to have called
> from_fd()/fget() first which would be good.

Actually, `from_ptr` has nothing to do with this. The above code only
applies to code that uses the `ARef` pointer type, but `from_ptr` uses
the `&File` pointer type instead.

>> +    /// Returns the flags associated with the file.
>> +    ///
>> +    /// The flags are a combination of the constants in [`flags`].
>> +    pub fn flags(&self) -> u32 {
>> +        // This `read_volatile` is intended to correspond to a READ_ONCE call.
>> +        //
>> +        // SAFETY: The file is valid because the shared reference guarantees a nonzero refcount.
> 
> I really need to understand what you mean by shared reference. At least
> in the current C implementation you can't share a reference without
> another task as the other task might fput() behind you and then you're
> hosed. That's why we have the fdget() logic.

By "shared reference" I just mean an `&File`. They're called shared
because there could be other pointers to the same object elsewhere in
the program, and not because we have explicitly shared it ourselves.

Rust's other type of reference `&mut T` is called a "mutable reference"
or "exclusive reference". Like with `&T`, both names are used.

> > +// SAFETY: It's OK to access `File` through shared references from other threads because we're
> > +// either accessing properties that don't change or that are properly synchronised by C code.
> 
> Uhm, what guarantees are you talking about specifically, please?
> Examples would help.
> 
> > +unsafe impl Sync for File {}

The Sync trait defines whether a value may be accessed from several
threads in parallel (using shared/immutable references). In our case,
every method on `File` that accepts a `&File` is okay to be called in
parallel from several threads, so it's okay for `File` to implement
`Sync`.

I'm actually making a statement about the rest of the Rust code in this
file here. If I added a method that took `&File`, but couldn't be called
in parallel, then `File` could no longer be `Sync`.



I hope that helps, and let me know if you have any other questions.

Alice


