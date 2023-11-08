Return-Path: <linux-fsdevel+bounces-2346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F757E4EFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 03:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E29FB20E28
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 02:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941111110;
	Wed,  8 Nov 2023 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cnml8PuO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BBEEBC;
	Wed,  8 Nov 2023 02:39:39 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9561C181;
	Tue,  7 Nov 2023 18:39:38 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso6568606276.2;
        Tue, 07 Nov 2023 18:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699411178; x=1700015978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zam5LNnEV857LUWLqGrqklt4GUW0PfYKXLG770na9KM=;
        b=Cnml8PuOBOELLCthK6HCLAORV3ChAE7iDGpJy8xhRC9tdkzKNGdFC9Zutk5aQVPuAY
         NReNSWb3badYen82Q9JplBCc2Fq27A3G3YIrGNVlBesSBfbf8zPOXzDb3mb8qwm3TLq3
         DMkWeyds1m2AixdAQSmkNmJQB0raQZDzU+sfzhlDzAzTC93sQur7rygy6jOBBAbUotN8
         uM9NLWZ2IvAY+noTTPoiM5WwKBLZLnbhX4AkPLmxa27023ee338Y3sAwxaRWIHGMOnV/
         Pc+8J+SRQwmT3dT4fZI5sUaD4d3AdcbqQpKsFV3NBb3K0+IGdui/JE6y0e2N2HjpDo0Z
         KSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411178; x=1700015978;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zam5LNnEV857LUWLqGrqklt4GUW0PfYKXLG770na9KM=;
        b=JlcZli7XslhTz6UFia6f85yVTRTQx1qADp/4k3uR201i70OwZqrfXvPPVPRzYDfy+P
         +yUygs1WA5JW5dHLgLmwXRpIP1cksC/zOCv5NJvFTCOp9V/LW7XRRfash4optVeZV+MM
         k3YewhmCQZpRPj4jMZNIcqhGOkKsHwWLLP94pJLeXGjwmGGG9sPqzTDZLIbewpVc66k5
         4/kLCqfAaNl1AqyKU9asEnf8flyT3wdEDRc1JRnOc67GNcwOv2dSo7IKfGwSJSTLZPvD
         X5j4H7V6S3l1Qk8AdZttQG86eNW09ezm/dIlMKQn0JyB/RWaER7/2Qyse0Fs9+y8s1ay
         DKKA==
X-Gm-Message-State: AOJu0YwdGLG4XRC82kPRs7u9MCV0mY1cnjnRTcQ/zHicp6j9ZOhZLi4y
	otQM70jv4oRiDaAR6R16yCQW7Dg5bLCzTtQ5YKk=
X-Google-Smtp-Source: AGHT+IEw/svfGtRXcgkyuhP+QK2BNFwUA9j5RBRKp8s+kkahkaq5cDFNW+IcETSfVzMZJiNVZzLNctrrPf524MRWq4c=
X-Received: by 2002:a25:db81:0:b0:d9c:c79:ca1c with SMTP id
 g123-20020a25db81000000b00d9c0c79ca1cmr642083ybf.55.1699411177668; Tue, 07
 Nov 2023 18:39:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018122518.128049-1-wedsonaf@gmail.com> <20231018122518.128049-11-wedsonaf@gmail.com>
 <ZUq3nZgedcA5CF0V@casper.infradead.org> <20231107222257.GV1957730@ZenIV>
 <CANeycqo9dpt6kB=5wizKXAF0bZLMTBr_p5QR+NB53_NDVe=agw@mail.gmail.com> <20231108005628.GW1957730@ZenIV>
In-Reply-To: <20231108005628.GW1957730@ZenIV>
From: Wedson Almeida Filho <wedsonaf@gmail.com>
Date: Tue, 7 Nov 2023 23:39:26 -0300
Message-ID: <CANeycqpwV+uzSp2skuO8TQP5Py-J2qe_=X3j_XL74QwevRXr9w@mail.gmail.com>
Subject: Re: [RFC PATCH 10/19] rust: fs: introduce `FileSystem::read_folio`
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Matthew Wilcox <willy@infradead.org>, Christian Brauner <brauner@kernel.org>, 
	Kent Overstreet <kent.overstreet@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Nov 2023 at 21:56, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Nov 07, 2023 at 09:35:44PM -0300, Wedson Almeida Filho wrote:
>
> > > While we are at it, lookup is also very much not a per-filesystem operation.
> > > Take a look at e.g. procfs, for an obvious example...
> >
> > The C api offers the greatest freedom: one could write a file system
> > where each file has its own set of mapping_ops, inode_ops and
> > file_ops; and while we could choose to replicate this freedom in Rust
> > but we haven't.
>
> Too bad.
>
> > Mostly because we don't need it, and we've been repeatedly told (by
> > Greg KH and others) not to introduce abstractions/bindings for
> > anything for which there isn't a user. Besides being a longstanding
> > rule in the kernel, they also say that they can't reasonably decide if
> > the interfaces are good if they can't see the users.
>
> The interfaces are *already* there.  If it's going to be a separate
> set of operations for Rust and for the rest of the filesystems, we
> have a major problem right there.

The interfaces will be different but compatible -- they boil down to
calls to/from C and follow all rules and requirements imposed by C.

We just use Rust's type system to encode more of the rules into the
interfaces so that the compiler will catch more bugs for us at compile
time (and avoid memory safety issues if developers stay away from
unsafe blocks). For example, if you want to attach non-zero-sized data
to inodes of a given filesystem, in Rust we have a generic type:

struct INodeWithData<T> {
    data: MaybeUninit<T>,
    inode: bindings::inode,
}

And we automatically implement alloc_inode() and destroy_inode() in
super_operations. And all inodes in callbacks are typed so that
developers never need to call container_of directly themselves. The
compiler will catch, at compile time, any type mismatches without
runtime cost.

Another example: instead of implementing functions then declaring
structs containing pointers to these functions (and potentially other
fields), in Rust we expose "traits" that developers need to implement.
Then we can control which functions are required/optional and allow
developers to logically group them, as well as declare constants and
related types (e.g., the additional struct, if any, to be allocated
along with an inode in INodeWithData above). But in the end, these get
translated (at compile time for const ops) into
file_operations/address_space_operations/inode_operations.

> > The existing Rust users (tarfs and puzzlefs) only need a single
> > lookup. And a quick grep (git grep \\\.lookup\\\> -- fs/) appears to
> > show that the vast majority of C filesystems only have a single lookup
> > as well. So we choose simplicity, knowing well that we may have to
> > revisit it in the future if the needs change.
> >
> > > Wait a minute... what in name of everything unholy is that thing doing tied
> > > to inodes in the first place?
> >
> > For the same reason as above, we don't need it in our current
> > filesystems. A bunch of C ones (e.g., xfs, ext2, romfs, erofs) only
> > use the dentry to get the name and later call d_splice_alias(), so we
> > hide the name extraction and call to d_splice_alias() in the
> > "trampoline" function.
>
> What controls the lifecycle of that stuff from the Rust point of view?

The same rules as C. inodes, for example, are ref-counted so while a
callback that has an inode as argument is inflight, we know it (the
inode) is referenced and we can just use it. If/when Rust code wants
to hold on to a pointer to it beyond a callback, it needs to increment
the refcount and release it when it's done. Here the type system also
helps us: it guarantees that pointers to ref-counted objects are never
dangling, if we ever try to hold on to a pointer without incrementing
the refcount, we get a compile-time error (no additional runtime
cost).

We also have a common interface for _all_ C ref-counted objects, so
instead of having to memorise that I should call ihold/iget for
inodes, folio_get/folio_put for folios,
get_task_struct/put_task_struct for tasks, etc., in Rust they're
simply ARef<INode>, ARef<Folio>, ARef<Task> with automatic increment
via clone() and decrement on destruction.

There are a couple of issues that I alluded to in the cover letter but
never actually wrote down, so I will describe them here to get your
thoughts:

First issue:
VFS conflates filesystem unregistration with module unload. The
description of unregister_filesystem() states:

 * Once this function has returned the &struct file_system_type structure
 * may be freed or reused.

When a filesystem is mounted, VFS calls get_filesystem() to presumably
prevent the filesystem from unregistering, and it calls
put_filesystem() when deactivating a super-block.

But get/put_filesystem() are implemented as module_get/put(). So this
works well if unregister_filesystem is only ever called when modules
are unloaded. It doesn't seem to help if it's called anywhere else
(e.g., on failure paths of module load).

Here's an example: init_f2fs_fs() calls init_inodecache() to allocate
an inode cache, then eventually calls register_filesystem(). Let's
suppose at this point, another CPU actually mounts an instance of an
f2fs fs. After register_filesystem() in init_f2fs_fs(), there is a
bunch of extra failure paths; let's suppose
f2fs_init_compress_mempool() fails. The exit path will call
unregister_filesystem() (which prevents new superblocks from being
created, but the existing superblocks continue to exist), then
eventually destroy_inodecache(), which frees the cache from which all
inodes of the existing superblock have been allocated and we have a
bunch of potential user-after-frees.

Granted that the module will not be unloaded immediately (it will wait
for all references, including the ones by get_filesystem() to go
away), so we won't have an issue with the callbacks being called to
unloaded memory. But if we recycle f2fs_fs_type, which
unregister_filesystem claims to be safe, we'll also have
user-after-frees there.

(Note that the example above doesn't require unload at all.)

I think we could fix this by having a different implementation of
get/put_filesystem() that keeps track of a count for filesystem usage
(in addition to avoiding module unload), and only completing
unregister_filesystem when it goes to zero. Would you be interested in
a patch for this?

Second issue:

Leaked inodes: if a filesystem leaks inodes, then after unregistration
most implementations will just free the kmemcache from which they
came, so future attempts to use these leaked inodes (it's possible
they've been stored in some list somewhere) will lead to
user-after-frees. Is there anything we can do improve this? Should we
prevent unregister_filesystem() from completing in such cases?

Thanks,
-Wedson

