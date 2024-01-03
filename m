Return-Path: <linux-fsdevel+bounces-7225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EBF822FEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 15:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FD01F245F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57101B27F;
	Wed,  3 Jan 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="WPHT2YfT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42CC1A71A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jan 2024 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d88f9e602so23435795e9.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jan 2024 06:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1704293830; x=1704898630; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=icDvawPu4N9KUKSqR130iYUVn/OUgGr8Bq/oQWex9vY=;
        b=WPHT2YfTQga4HY+FF2lul62M8wQ1iG5feTnJj8fRgs9z1FIBofjYwu9WWS6ZGfSHZ/
         kdkQtWc+nZDiOXyJcmNIgUzt06iXQ+F6PYwaQMN/EiDG18brJ3UhmzIBXa5KvYkQsHT6
         JeIZIZsEgzwVY9RaGsbxiaGciK8F5DKZPsvTZpdVmHuex6mkJYApIXxOQKdetZIUslW7
         Xd1l1GqE7fThR01qKjHYxsH7oNuXPcPssiYmjA1DP6ZX4JtKzoUyVfQdOkIEJv3BlU5/
         xwptPS0lEI+gYRCg8YluWSBQ2LiGqIKJj5loYRrI9bveKFlmA+DjeFoVjNIWPLBkAscF
         /xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293830; x=1704898630;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icDvawPu4N9KUKSqR130iYUVn/OUgGr8Bq/oQWex9vY=;
        b=E1fDNlN73yRVndLdlX+AuAG25w0jlDciWb8z5y1l1Nt8MwDcKU1Lumy0Px2QeStRAR
         pvj0ng1RBaFUuHGtds3+gRTxFF1MyAoja4MEcXYd72wrJdLFGSCsQ+r/bW7v9DEnSmSJ
         uzqawkBLpub2XnHNppb55gHL2H0WZL0sgTCUVs+JDebwI8cjPE7WeX/xwjMYbtnx3tuG
         nVfbWxbOrng7ZUFZCSPJBgvaItZrfrAlAvwn6DTvOk0TtiD0C/T2iUy/ym09INgCxaPf
         0womPp/s3TbW7Z9glSWR8usAU8y2CwTXvKgt/j5fzvs5vOJbeCTXoO7l8cbLa40tcX1m
         blqQ==
X-Gm-Message-State: AOJu0Yyi5niG0uVNspseSO6ZHaTBnD66jxRIsittgzPSRjG9I11AbjNC
	2y0j4ylgRTVr02KWTxvL5mTLOMOTdhbkiA==
X-Google-Smtp-Source: AGHT+IHU0m0nUfxWCt85QfZ1Hyy8wofZbT1X7PkXXQoJDjZBXbv7f60AE23tsmVwd9s2vZw6rebqdw==
X-Received: by 2002:a05:600c:4384:b0:40d:3b3f:6040 with SMTP id e4-20020a05600c438400b0040d3b3f6040mr10213519wmn.45.1704293830143;
        Wed, 03 Jan 2024 06:57:10 -0800 (PST)
Received: from localhost ([165.225.194.221])
        by smtp.gmail.com with ESMTPSA id d2-20020a05600c34c200b0040d61b1cecasm2561201wmq.33.2024.01.03.06.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:57:09 -0800 (PST)
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-7-wedsonaf@gmail.com>
User-agent: mu4e 1.10.8; emacs 28.2.50
From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
 <brauner@kernel.org>, Matthew Wilcox <willy@infradead.org>, Kent
 Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Wedson Almeida Filho
 <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 06/19] rust: fs: introduce `FileSystem::init_root`
Date: Wed, 03 Jan 2024 14:29:33 +0100
In-reply-to: <20231018122518.128049-7-wedsonaf@gmail.com>
Message-ID: <87o7e25v2z.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Wedson Almeida Filho <wedsonaf@gmail.com> writes:

[...]

>  
> +/// An inode that is locked and hasn't been initialised yet.
> +#[repr(transparent)]
> +pub struct NewINode<T: FileSystem + ?Sized>(ARef<INode<T>>);
> +
> +impl<T: FileSystem + ?Sized> NewINode<T> {
> +    /// Initialises the new inode with the given parameters.
> +    pub fn init(self, params: INodeParams) -> Result<ARef<INode<T>>> {
> +        // SAFETY: This is a new inode, so it's safe to manipulate it mutably.
> +        let inode = unsafe { &mut *self.0 .0.get() };

Perhaps it would make sense with a `UniqueARef` that guarantees
uniqueness, in line with `alloc::UniqueRc`?

[...]

>  
> +impl<T: FileSystem + ?Sized> SuperBlock<T> {
> +    /// Tries to get an existing inode or create a new one if it doesn't exist yet.
> +    pub fn get_or_create_inode(&self, ino: Ino) -> Result<Either<ARef<INode<T>>, NewINode<T>>> {
> +        // SAFETY: The only initialisation missing from the superblock is the root, and this
> +        // function is needed to create the root, so it's safe to call it.
> +        let inode =
> +            ptr::NonNull::new(unsafe { bindings::iget_locked(self.0.get(), ino) }).ok_or(ENOMEM)?;

I can't parse this safety comment properly.

> +
> +        // SAFETY: `inode` is valid for read, but there could be concurrent writers (e.g., if it's
> +        // an already-initialised inode), so we use `read_volatile` to read its current state.
> +        let state = unsafe { ptr::read_volatile(ptr::addr_of!((*inode.as_ptr()).i_state)) };
> +        if state & u64::from(bindings::I_NEW) == 0 {
> +            // The inode is cached. Just return it.
> +            //
> +            // SAFETY: `inode` had its refcount incremented by `iget_locked`; this increment is now
> +            // owned by `ARef`.
> +            Ok(Either::Left(unsafe { ARef::from_raw(inode.cast()) }))
> +        } else {
> +            // SAFETY: The new inode is valid but not fully initialised yet, so it's ok to create a
> +            // `NewINode`.
> +            Ok(Either::Right(NewINode(unsafe {
> +                ARef::from_raw(inode.cast())

I would suggest making the destination type explicit for the cast.

> +            })))
> +        }
> +    }
> +}
> +
>  /// Required superblock parameters.
>  ///
>  /// This is returned by implementations of [`FileSystem::super_params`].
> @@ -215,41 +345,28 @@ impl<T: FileSystem + ?Sized> Tables<T> {
>              sb.0.s_blocksize = 1 << sb.0.s_blocksize_bits;
>              sb.0.s_flags |= bindings::SB_RDONLY;
>  
> -            // The following is scaffolding code that will be removed in a subsequent patch. It is
> -            // needed to build a root dentry, otherwise core code will BUG().
> -            // SAFETY: `sb` is the superblock being initialised, it is valid for read and write.
> -            let inode = unsafe { bindings::new_inode(&mut sb.0) };
> -            if inode.is_null() {
> -                return Err(ENOMEM);
> -            }
> -
> -            // SAFETY: `inode` is valid for write.
> -            unsafe { bindings::set_nlink(inode, 2) };
> -
> -            {
> -                // SAFETY: This is a newly-created inode. No other references to it exist, so it is
> -                // safe to mutably dereference it.
> -                let inode = unsafe { &mut *inode };
> -                inode.i_ino = 1;
> -                inode.i_mode = (bindings::S_IFDIR | 0o755) as _;
> -
> -                // SAFETY: `simple_dir_operations` never changes, it's safe to reference it.
> -                inode.__bindgen_anon_3.i_fop = unsafe { &bindings::simple_dir_operations };
> +            // SAFETY: The callback contract guarantees that `sb_ptr` is a unique pointer to a
> +            // newly-created (and initialised above) superblock.
> +            let sb = unsafe { &mut *sb_ptr.cast() };

Again, I would suggest an explicit destination type for the cast.

> +            let root = T::init_root(sb)?;
>  
> -                // SAFETY: `simple_dir_inode_operations` never changes, it's safe to reference it.
> -                inode.i_op = unsafe { &bindings::simple_dir_inode_operations };
> +            // Reject root inode if it belongs to a different superblock.

I am curious how this would happen?

BR Andreas

