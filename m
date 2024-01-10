Return-Path: <linux-fsdevel+bounces-7738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A845682A04C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 19:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22F01C2241F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 18:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0C44D58E;
	Wed, 10 Jan 2024 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag7N1ToG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3824D580;
	Wed, 10 Jan 2024 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbd99c08cd6so3645139276.0;
        Wed, 10 Jan 2024 10:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704911542; x=1705516342; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CzXe4VtXxb8ebiKHKdqJMgNWPOMHrzYBPoyKIRV/O5E=;
        b=ag7N1ToGXgONA75mq9t7OxYLogZ5fYc/lWqvsYVFfag2C1GnDdgI/h98Mgm3zgzHiy
         hS0LfadWBh6tUV9PQVQz2FPVGMvwlmE7AjHtlYt6MAJTy0JGO/yolaf5CIHGqQYWGL3n
         CehW9s3s/CVA9E/Ea6uz+6K5VuvVB0/3dkkAV4wvm4pxf1B3KFQ0X3HDQkevcq+tXNCH
         OIfPfJ62pyMnbXXIHdgg5xorB9tKoPVF/R3rXO7aTqpT9m2SACs02db+myiOw8H6QERY
         FxL2JwbtMtywkK9uyX1MEcZH/qCfAaABLi2Gq8Ad2Ksh2dq4dHufnVPyrdxjQWlStL3I
         7Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911542; x=1705516342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzXe4VtXxb8ebiKHKdqJMgNWPOMHrzYBPoyKIRV/O5E=;
        b=GlUsdPvw4SigQhDoBC4DLHmociSpIJc3lYt/szoaUQKKRz77J1zU9vYkpI1YtViy2F
         5PEV0K8uBfB4Id20i7sHYx/p2EPnFtSrDpqTbF8wpcjxTa2PH5bvOYhYlKW4Ti+4eSSy
         j9ZIjU2y+SLsYaqV5uot471Fv+6zDGNE7HzSvmVQ7l2XPiTICT48iWBdymuqDsuRrYK4
         P4V88aKh3OC0279XzC7E8XvNlxHkGNB7v8dMWIytA+dtn2rf9nm5rmlq2FELWXmUHmXe
         6BIThnZ5ueN4LSrCtRJ53XYxyQPL477RIhFfOPabE+Tb220QWchHv1dcArcZx14EbRSY
         tLJA==
X-Gm-Message-State: AOJu0YxVaH4/WvpAr/kkFWf63ZSHeMnBEqOvuPPbhY3Gx5pNzpMJj0v7
	t5aObX0cmPbAyM//VivKVf4mJdS3+fAw6YMg7I8=
X-Google-Smtp-Source: AGHT+IFlTeGG2WFCgrJ4INlA2dJ+Gew9iar7LHCrAPIxE69ziceCfsu+n57sAJnSC8sUOmvEAzSLKK8GHyi7VoGcqGg=
X-Received: by 2002:a25:5f09:0:b0:dbe:a8e7:a6ea with SMTP id
 t9-20020a255f09000000b00dbea8e7a6eamr36116ybb.22.1704911541912; Wed, 10 Jan
 2024 10:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-2-wedsonaf@gmail.com>
 <ku6rR-zBwLrTfSf1JW07NywKOZFCPMS7nF-mrdBKGJthn7WGBn9lcAQOhoN5V6igk1iGBguGfV5G0PDWQciDQTopf3OYYGt049OJYhsiivk=@proton.me>
In-Reply-To: <ku6rR-zBwLrTfSf1JW07NywKOZFCPMS7nF-mrdBKGJthn7WGBn9lcAQOhoN5V6igk1iGBguGfV5G0PDWQciDQTopf3OYYGt049OJYhsiivk=@proton.me>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Wed, 10 Jan 2024 15:32:11 -0300
Message-ID: <CANeycqqJsy3rhBEVWspEqhUXgsQNj-Wcy=9axkDX9B3SLgupcA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/19] rust: fs: add registration/unregistration of
 file systems
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Kent Overstreet <kent.overstreet@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Oct 2023 at 12:38, Benno Lossin <benno.lossin@proton.me> wrote:
> On 18.10.23 14:25, Wedson Almeida Filho wrote:
> > +/// A registration of a file system.
> > +#[pin_data(PinnedDrop)]
> > +pub struct Registration {
> > +    #[pin]
> > +    fs: Opaque<bindings::file_system_type>,
> > +    #[pin]
> > +    _pin: PhantomPinned,
>
> Note that since commit 0b4e3b6f6b79 ("rust: types: make `Opaque` be
> `!Unpin`") you do not need an extra pinned `PhantomPinned` in your struct
> (if you already have a pinned `Opaque`), since `Opaque` already is
> `!Unpin`.

Will remove in v2.

> > +impl Registration {
> > +    /// Creates the initialiser of a new file system registration.
> > +    pub fn new<T: FileSystem + ?Sized>(module: &'static ThisModule) -> impl PinInit<Self, Error> {
>
> I am a bit curious why you specify `?Sized` here, is it common
> for types that implement `FileSystem` to not be `Sized`?
>
> Or do you want to use `dyn FileSystem`?

No reason beyond `Sized` being a restriction I don't need.

For something I was doing early on in binder, I ended up having to
change a bunch of generic type decls to allow !Sized, so here I'm
doing it preemptively as I don't lose anything.

> > +        try_pin_init!(Self {
> > +            _pin: PhantomPinned,
> > +            fs <- Opaque::try_ffi_init(|fs_ptr: *mut bindings::file_system_type| {
> > +                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write.
> > +                unsafe { fs_ptr.write(bindings::file_system_type::default()) };
> > +
> > +                // SAFETY: `try_ffi_init` guarantees that `fs_ptr` is valid for write, and it has
> > +                // just been initialised above, so it's also valid for read.
> > +                let fs = unsafe { &mut *fs_ptr };
> > +                fs.owner = module.0;
> > +                fs.name = T::NAME.as_char_ptr();
> > +                fs.init_fs_context = Some(Self::init_fs_context_callback);
> > +                fs.kill_sb = Some(Self::kill_sb_callback);
> > +                fs.fs_flags = 0;
> > +
> > +                // SAFETY: Pointers stored in `fs` are static so will live for as long as the
> > +                // registration is active (it is undone in `drop`).
> > +                to_result(unsafe { bindings::register_filesystem(fs_ptr) })
> > +            }),
> > +        })
> > +    }
> > +
> > +    unsafe extern "C" fn init_fs_context_callback(
> > +        _fc_ptr: *mut bindings::fs_context,
> > +    ) -> core::ffi::c_int {
> > +        from_result(|| Err(ENOTSUPP))
> > +    }
> > +
> > +    unsafe extern "C" fn kill_sb_callback(_sb_ptr: *mut bindings::super_block) {}
> > +}
> > +
> > +#[pinned_drop]
> > +impl PinnedDrop for Registration {
> > +    fn drop(self: Pin<&mut Self>) {
> > +        // SAFETY: If an instance of `Self` has been successfully created, a call to
> > +        // `register_filesystem` has necessarily succeeded. So it's ok to call
> > +        // `unregister_filesystem` on the previously registered fs.
>
> I would simply add an invariant on `Registration` that `self.fs` is
> registered, then you do not need such a lengthy explanation here.

Since this is the only place I need this explanation, I prefer to
leave it here because it's exactly where I need it.

Thanks,
-Wedson

