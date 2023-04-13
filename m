Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52B6E1752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 00:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDMW2t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjDMW2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 18:28:48 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B0686AC
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 15:28:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y3-20020a17090322c300b001a06f9b5e31so8839795plg.21
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Apr 2023 15:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681424925; x=1684016925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fUGG18wo5+CyMOYxhXbNuySc8Euq/oCIPQwUhRKEq8M=;
        b=OF7pAz5appreyNnzZ5NOs02kK1hF8myrUAbW/nztRTe0+cinmjfy17RhFHoI2aI2Hh
         kjJP/KlPbb6AyHbxqI5AM74xMy6B5MSNCS5NuJo1Z8BCjNyiParWD2RxQ2XegHierh79
         +tvkf2hKIPuU29O+1Y3bivq7Wv56n0GreGQJwQ3CIxD5fpjJpvdFF8G9mWUObOM+qZgA
         mMp8ADgXUuzSS35mNfP8V68PN1tEPilOW0drYgn3Vk184QibbBfhmtXrdm7UhA/CkzG2
         HgNUW8Nv5NP3FRtij/OgR4c0VzUpv2+2YOSc0mxm8/FNqazZ1sx9f2TVEd7binW+rV+y
         ei0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681424925; x=1684016925;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUGG18wo5+CyMOYxhXbNuySc8Euq/oCIPQwUhRKEq8M=;
        b=KaoGiM4h8hl6ve/aMlwCu/1Pvl7/DeI8xclw8OXfWDirjL7AzeMPJrQ8NPSb9TV60e
         Q7o0MH8aLOWeQWZ1T8t+lv1Xgme0pkBcXcSDEQ5Aj1b7f3EH/ZGHcYqs1Yq3/5RgHUo7
         cWNZR8zGnGGD//hbC2ScubBQ/YfOzQmxjRW5NNvuZSK5QJhut6rkVEWMP/+UryHPPKVL
         akF4lcn68ln6hAnJ1sOKB0eBZeFUxbwA3wN39ldkkSuiED1NEoIpW5DJJFz6i7rEs1tR
         SGMbK0O+gMFzW7vLXOGAZ/FFjFW0FHAWFmEOO84+n65BLupGWQhvR0W83G57Z6sfE/Hi
         ZWnQ==
X-Gm-Message-State: AAQBX9ej/vfVXaDsM3j3ZfO1wVwQqu7oWs/Q1Xxk6REipl7BBhSU5lci
        i9muAAOMUTHX22qGd5sAmT2w6KYjqPQ=
X-Google-Smtp-Source: AKy350akQiiRa+vjFfnw9KfRYVGLBtsoJs0gXVP8L8WmBTSpdkdpTYlsAwVFOJpke4F9z+dOk7WCzEv8WMQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5f81:0:b0:518:547f:8883 with SMTP id
 t123-20020a635f81000000b00518547f8883mr196078pgb.0.1681424925055; Thu, 13 Apr
 2023 15:28:45 -0700 (PDT)
Date:   Thu, 13 Apr 2023 15:28:43 -0700
In-Reply-To: <20230413-anlegen-ergibt-cbefffe0b3de@brauner>
Mime-Version: 1.0
References: <20220818132421.6xmjqduempmxnnu2@box> <diqzlej60z57.fsf@ackerleytng-cloudtop.c.googlers.com>
 <20221202061347.1070246-2-chao.p.peng@linux.intel.com> <20230413-anlegen-ergibt-cbefffe0b3de@brauner>
Message-ID: <ZDiCG/7OgDI0SwMR@google.com>
Subject: Re: [PATCH v7 00/14] KVM: mm: fd-based approach for supporting KVM
 guest private memory
From:   Sean Christopherson <seanjc@google.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>, luto@kernel.org,
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com, aarcange@redhat.com, ddutile@redhat.com,
        dhildenb@redhat.com, Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        linux-arch@vger.kernel.org, arnd@arndb.de, linmiaohe@huawei.com,
        naoya.horiguchi@nec.com, tabba@google.com, wei.w.wang@intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 13, 2023, Christian Brauner wrote:
> On Thu, Aug 18, 2022 at 04:24:21PM +0300, Kirill A . Shutemov wrote:
> > On Wed, Aug 17, 2022 at 10:40:12PM -0700, Hugh Dickins wrote:
> > > Here's what I would prefer, and imagine much easier for you to maintain;
> > > but I'm no system designer, and may be misunderstanding throughout.
> > > 
> > > QEMU gets fd from opening /dev/kvm_something, uses ioctls (or perhaps
> > > the fallocate syscall interface itself) to allocate and free the memory,
> > > ioctl for initializing some of it too.  KVM in control of whether that
> > > fd can be read or written or mmap'ed or whatever, no need to prevent it
> > > in shmem.c, no need for flags, seals, notifications to and fro because
> > > KVM is already in control and knows the history.  If shmem actually has
> > > value, call into it underneath - somewhat like SysV SHM, and /dev/zero
> > > mmap, and i915/gem make use of it underneath.  If shmem has nothing to
> > > add, just allocate and free kernel memory directly, recorded in your
> > > own xarray.
> > 
> > I guess shim layer on top of shmem *can* work. I don't see immediately why
> > it would not. But I'm not sure it is right direction. We risk creating yet
> > another parallel VM with own rules/locking/accounting that opaque to
> > core-mm.
> 
> Sorry for necrobumping this thread but I've been reviewing the

No worries, I'm just stoked someone who actually knows what they're doing is
chiming in :-)

> memfd_restricted() extension that Ackerley is currently working on. I
> was pointed to this thread as this is what the extension is building
> on but I'll reply to both threads here.
> 
> From a glance at v10, memfd_restricted() is currently implemented as an
> in-kernel stacking filesystem. A call to memfd_restricted() creates a
> new restricted memfd file and a new unlinked tmpfs file and stashes the
> tmpfs file into the memfd file's private data member. It then uses the
> tmpfs file's f_ops and i_ops to perform the relevant file and inode
> operations. So it has the same callstack as a general stacking
> filesystem like overlayfs in some cases:
> 
>         memfd_restricted->getattr()
>         -> tmpfs->getattr()

...

> Since you're effectively acting like a stacking filesystem you should
> really use the device number of your memfd restricted filesystem. IOW,
> sm like:
> 
>         stat->dev = memfd_restricted_dentry->d_sb->s_dev;
> 
> But then you run into trouble if you want to go forward with Ackerley's
> extension that allows to explicitly pass in tmpfs fds to
> memfd_restricted(). Afaict, two tmpfs instances might allocate the same
> inode number. So now the inode and device number pair isn't unique
> anymore.
> 
> So you might best be served by allocating and reporting your own inode
> numbers as well.
> 
> But if you want to preserve the inode number and device number of the
> relevant tmpfs instance but still report memfd restricted as your
> filesystem type

Unless I missed something along the way, reporting memfd_restricted as a distinct
filesystem is very much a non-goal.  AFAIK it's purely a side effect of the
proposed implementation.

> then I think it's reasonable to ask whether a stacking implementation really
> makes sense here.
> 
> If you extend memfd_restricted() or even consider extending it in the
> future to take tmpfs file descriptors as arguments to identify the tmpfs
> instance in which to allocate the underlying tmpfs file for the new
> restricted memfd file you should really consider a tmpfs based
> implementation.
> 
> Because at that point it just feels like a pointless wrapper to get
> custom f_ops and i_ops. Plus it's wasteful because you allocate dentries
> and inodes that you don't really care about at all.
> 
> Just off the top of my hat you might be better served:
> * by a new ioctl() on tmpfs instances that
>   yield regular tmpfs file descriptors with restricted f_ops and i_ops.
>   That's not that different from btrfs subvolumes which effectively are
>   directories but are created through an ioctl().

I think this is more or less what we want to do, except via a dedicated syscall
instead of an ioctl() so that the primary interface isn't strictly tied to tmpfs,
e.g. so that it can be extended to other backing types in the future.

> * by a mount option to tmpfs that makes it act
>   in this restricted manner then you don't need an ioctl() and can get
>   away with regular open calls. Such a tmpfs instance would only create
>   regular, restricted memfds.

I'd prefer to not go this route, becuase IIUC, it would require relatively invasive
changes to shmem code, and IIUC would require similar changes to other support
backings in the future, e.g. hugetlbfs?  And as above, I don't think any of the
potential use cases need restrictedmem to be a uniquely identifiable mount.

One of the goals (hopefully not a pipe dream) is to design restrictmem in such a
way that extending it to support other backing types isn't terribly difficult.
In case it's not obvious, most of us working on this stuff aren't filesystems
experts, and many of us aren't mm experts either.  The more we (KVM folks for the
most part) can leverage existing code to do the heavy lifting, the better.

After giving myself a bit of a crash course in file systems, would something like
the below have any chance of (a) working, (b) getting merged, and (c) being
maintainable?

The idea is similar to a stacking filesystem, but instead of stacking, restrictedmem
hijacks a f_ops and a_ops to create a lightweight shim around tmpfs.  There are
undoubtedly issues and edge cases, I'm just looking for a quick "yes, this might
be doable" or a "no, that's absolutely bonkers, don't try it".

Thanks!


struct restrictedmem {
	struct rw_semaphore lock;
	struct file *file;
	const struct file_operations *backing_f_ops;
	const struct address_space_operations *backing_a_ops;
	struct xarray bindings;
	bool exclusive;
};

static int restrictedmem_release(struct inode *inode, struct file *file)
{
	struct restrictedmem *rm = inode->i_mapping->private_data;

	xa_destroy(&rm->bindings);
	kfree(rm);

	WARN_ON_ONCE(rm->backing_f_ops->release);
	return 0;
}

static long restrictedmem_punch_hole(struct restrictedmem *rm, int mode,
				     loff_t offset, loff_t len)
{
	struct restrictedmem_notifier *notifier;
	unsigned long index;
	pgoff_t start, end;
	int ret;

	if (!PAGE_ALIGNED(offset) || !PAGE_ALIGNED(len))
		return -EINVAL;

	start = offset >> PAGE_SHIFT;
	end = (offset + len) >> PAGE_SHIFT;

	/*
	 * Bindings must be stable across invalidation to ensure the start+end
	 * are balanced.
	 */
	down_read(&rm->lock);

	xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
		notifier->ops->invalidate_start(notifier, start, end);

	ret = rm->backing_f_ops->fallocate(rm->file, mode, offset, len);

	xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
		notifier->ops->invalidate_end(notifier, start, end);

	up_read(&rm->lock);

	return ret;
}

static long restrictedmem_fallocate(struct file *file, int mode,
				    loff_t offset, loff_t len)
{
	struct restrictedmem *rm = file->f_mapping->private_data;

	if (mode & FALLOC_FL_PUNCH_HOLE)
		return restrictedmem_punch_hole(rm, mode, offset, len);

	return rm->backing_f_ops->fallocate(file, mode, offset, len);
}

static int restrictedmem_migrate_folio(struct address_space *mapping,
				       struct folio *dst, struct folio *src,
				       enum migrate_mode)
{
	WARN_ON_ONCE(1);
	return -EINVAL;
}

static int restrictedmem_error_page(struct address_space *mapping,
				    struct page *page)
{
	struct restrictedmem *rm = mapping->private_data;
	struct restrictedmem_notifier *notifier;
	unsigned long index;
	pgoff_t start, end;

	start = page->index;
	end = start + thp_nr_pages(page);

	down_read(&rm->lock);

	xa_for_each_range(&rm->bindings, index, notifier, start, end - 1)
		notifier->ops->error(notifier, start, end);

	up_read(&rm->lock);

	return rm->backing_a_ops->error_remove_page(mapping, page);
}

static const struct file_operations restrictedmem_fops = {
	.release = restrictedmem_release,
	.fallocate = restrictedmem_fallocate,
};

static const struct address_space_operations restrictedmem_aops = {
	.dirty_folio = noop_dirty_folio,
#ifdef CONFIG_MIGRATION
	.migrate_folio	= restrictedmem_migrate_folio,
#endif
	.error_remove_page = restrictedmem_error_page,
};

static int restrictedmem_file_create(struct file *file)
{
	struct address_space *mapping = file->f_mapping;
	struct restrictedmem *rm;

	rm = kzalloc(sizeof(*rm), GFP_KERNEL);
	if (!rm)
		return -ENOMEM;

	rm->backing_f_ops = file->f_op;
	rm->backing_a_ops = mapping->a_ops;
	rm->file = file;
	init_rwsem(&rm->lock);
	xa_init(&rm->bindings);

	file->f_flags |= O_LARGEFILE;

	file->f_op = &restrictedmem_fops;
	mapping->a_ops = &restrictedmem_aops;

	mapping_set_unevictable(mapping);
	mapping_set_unmovable(mapping);
	mapping_set_gfp_mask(mapping,
			     mapping_gfp_mask(mapping) & ~__GFP_MOVABLE);
	return 0;
}


static int restrictedmem_create(struct vfsmount *mount)
{
	struct file *file;
	int fd, err;

	fd = get_unused_fd_flags(0);
	if (fd < 0)
		return fd;

	file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
	if (IS_ERR(file)) {
		err = PTR_ERR(file);
		goto err_fd;
	}
	if (WARN_ON_ONCE(file->private_data)) {
		err = -EEXIST;
		goto err_fd;
	}

	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
	file->f_flags |= O_LARGEFILE;

	err = restrictedmem_file_create(file);
	if (err) {
		fput(file);
		goto err_fd;
	}

	fd_install(fd, file);
	return fd;
err_fd:
	put_unused_fd(fd);
	return err;
}

SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
{
	struct vfsmount *mnt;
	struct path *path;
	struct fd f;
	int ret;

	if (flags)
		return -EINVAL;

	f = fdget_raw(mount_fd);
	if (!f.file)
		return -EBADF;

	ret = -EINVAL;

	path = &f.file->f_path;
	if (path->dentry != path->mnt->mnt_root)
		goto out;


	/* Disallow bind-mounts that aren't bind-mounts of the whole filesystem. */
	mnt = path->mnt;
	if (mnt->mnt_root != mnt->mnt_sb->s_root)
		goto out;

	/*
	 * The filesystem must be mounted no-execute, executing from guest
	 * private memory in the host is nonsensical and unsafe.
	 */
	if (!(mnt->mnt_sb->s_iflags & SB_I_NOEXEC))
		goto out;

	/* Currently only TMPFS is supported as underlying storage. */
	if (mnt->mnt_sb->s_magic != TMPFS_MAGIC)
		goto out;

	ret = mnt_want_write(mnt);
	if (ret)
		goto out;

	ret = restrictedmem_create(mnt);

	if (mnt)
		mnt_drop_write(mnt);
out:
	if (f.file)
		fdput(f);

	return ret;
}

