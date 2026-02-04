Return-Path: <linux-fsdevel+bounces-76332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBYJNXd6g2nyngMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:57:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F177EAA41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 979083040212
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 16:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E84D33C519;
	Wed,  4 Feb 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9k7tIE3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F28C33C1A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Feb 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223874; cv=none; b=gfnUujEp3pN8eGWMgJFBtkSKzBfh+wZ+dhcSnY5nLr8arCYkgM2ha7xzDLiR/u6JEpP4FSpKX8AmcOT8PZll88/iK9JxGHfVrVgoV7FWf/rZI3c5/9qdUk7LOnrKkIaAkgB2xLPeVRQBD1CyA2DN4rFTGCDZNRX2ZAnOWzHkbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223874; c=relaxed/simple;
	bh=9yju6q+ofsFqcseB6FiksXGpBHaUWDzcaMIwa69Ny8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH0nPX+9B4Xcs8RQGlalVlBjrG26/PuaVQ6rB5HGrWhjqMYmcIrQw/yprvCAEBtiNPHTcEd1groKZiknM0ZHTHcNzpfW050FINL+fCKLrHTrlXQQbz2gGm/9TwAZlFPutYGv/ToHO7V7h6kHWtCo0xXG0ETPE9Y2X9oJ0etSy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9k7tIE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA29C4CEF7;
	Wed,  4 Feb 2026 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223873;
	bh=9yju6q+ofsFqcseB6FiksXGpBHaUWDzcaMIwa69Ny8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9k7tIE3z5/7vyQThvrnSrW2LHaj8/vAIgtcw2ZILjmaEe18P997idkF6gHtMESJJ
	 O8/bFSLpZwFNDaijdqgLyGVpg5ht5VDQjK23EqoYeE4ruisd18NEcLDGMcND4U3ruU
	 nUquxAZXBfRR+8gGOYXuGYHU2hj9yG6LAZ8pfkQAii1U/Qmm1nx933qOF/rxSajRjK
	 eMCLqDOCRRRu12xg3pwVqjrKnFZ50Qyg4QLbm0nU0hIfyNEkpyIhYXWsqFf2Jc/ZSy
	 EErcokVxn7NNUHIKEgOXFN5xIFNl8L1GSlifyv3iyw8KiRrOcL2kErIBvpGS0s8VTR
	 z47zZFkEVWfLg==
Date: Wed, 4 Feb 2026 17:51:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Snaipe <me@snai.pe>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/1] fs,ns: allow copying of shm_mnt mount trees
Message-ID: <20260204-unsicher-bejubeln-7aaeb5a6d40c@brauner>
References: <20260129173515.1649305-1-me@snai.pe>
 <20260129173515.1649305-2-me@snai.pe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129173515.1649305-2-me@snai.pe>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76332-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snai.pe:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F177EAA41
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:35:15PM +0100, Snaipe wrote:
> From: "Franklin \"Snaipe\" Mathieu" <me@snai.pe>
> 
> The main motivation for this change is to be able to bind-mount memfd file
> descriptors. Prior to this change, it was not easy for a process to
> create a private in-memory handle that could then be bind-mounted.
> 
> A process had to have access to a tmpfs, create a file in it, call
> open_tree on the resulting file descriptor, close the original file
> descriptor, unlink the file, and then check that no other process raced
> the process to open the new file. Doable, but not great for mounting
> sensitive content like secrets.
> 
> With this change, it is now possible for a process to prepare a memfd,
> and call open_tree on it:
> 
>     int tmpfd = memfd_create("secret", 0);
>     fchmod(tmpfd, 0600);
>     write(tmpfd, "SecretKey", 9);
> 
>     int treefd = open_tree(tmpfd, "", OPEN_TREE_CLONE|AT_EMPTY_PATH|AT_RECURSIVE);
>     move_mount(treefd, "", -1, "/secret.txt", MOVE_MOUNT_F_EMPTY_PATH);
> 
> Signed-off-by: Franklin "Snaipe" Mathieu <me@snai.pe>
> ---
>  fs/namespace.c | 8 ++++++++
>  mm/internal.h  | 2 ++
>  mm/shmem.c     | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..f51ad2013662 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -38,6 +38,9 @@
>  #include "pnode.h"
>  #include "internal.h"
>  
> +/* For checking memfd bind-mounts via shm_mnt */
> +#include "../mm/internal.h"
> +
>  /* Maximum number of mounts in a mount namespace */
>  static unsigned int sysctl_mount_max __read_mostly = 100000;
>  
> @@ -2901,6 +2904,8 @@ static int do_change_type(const struct path *path, int ms_flags)
>   * (3) The caller tries to copy a pidfs mount referring to a pidfd.
>   * (4) The caller is trying to copy a mount tree that belongs to an
>   *     anonymous mount namespace.
> + * (5) The caller is trying to copy a mount tree belonging to shm_mnt
> + *     (e.g. bind-mounting a file descriptor obtained from memfd_create)
>   *
>   *     For that to be safe, this helper enforces that the origin mount
>   *     namespace the anonymous mount namespace was created from is the
> @@ -2943,6 +2948,9 @@ static inline bool may_copy_tree(const struct path *path)
>  	if (d_op == &pidfs_dentry_operations)
>  		return true;
>  
> +	if (path->mnt == shm_mnt)
> +		return true;

The problem with this approach is that it allows to bind-mount anything
that uses the internal tmpfs mount and that while it allows to
bind-mount tmpfs it exludes memfd_create() calls that are hugetlb
backed. So this would allow:

arch/x86/kernel/cpu/sgx/ioctl.c:        backing = shmem_file_setup("SGX backing", encl_size + (encl_size >> 5),
drivers/gpu/drm/drm_gem.c:              filp = shmem_file_setup("drm mm object", size, VM_NORESERVE);
drivers/gpu/drm/i915/gem/i915_gem_shmem.c:              filp = shmem_file_setup("i915", size, flags);
drivers/gpu/drm/i915/gem/i915_gem_ttm.c:                filp = shmem_file_setup("i915-shmem-tt", size, VM_NORESERVE);
drivers/gpu/drm/i915/gt/shmem_utils.c:  file = shmem_file_setup(name, PAGE_ALIGN(len), VM_NORESERVE);
drivers/gpu/drm/ttm/tests/ttm_tt_test.c:        shmem = shmem_file_setup("ttm swap", BO_SIZE, 0);
drivers/gpu/drm/ttm/ttm_backup.c:       return shmem_file_setup("ttm shmem backup", size, 0);
drivers/gpu/drm/ttm/ttm_tt.c:   swap_storage = shmem_file_setup("ttm swap", size, 0);
include/linux/shmem_fs.h:extern struct file *shmem_file_setup(const char *name,
mm/memfd.c:             file = shmem_file_setup(name, 0, VM_NORESERVE);
mm/memfd_luo.c: file = shmem_file_setup("", 0, VM_NORESERVE);
mm/shmem.c:static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
mm/shmem.c:     return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
mm/shmem.c:struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
mm/shmem.c:     return __shmem_file_setup(shm_mnt, name, size, flags, 0);
mm/shmem.c:     return __shmem_file_setup(mnt, name, size, flags, 0);
fs/xfs/scrub/xfile.c:   xf->file = shmem_kernel_file_setup(description, isize, VM_NORESERVE);
fs/xfs/xfs_buf_mem.c:   file = shmem_kernel_file_setup(descr, 0, 0);
include/linux/shmem_fs.h:extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
ipc/shm.c:              file = shmem_kernel_file_setup(name, size, acctflag);
mm/shmem.c: * shmem_kernel_file_setup - get an unlinked file living in tmpfs which must be
mm/shmem.c:struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
mm/shmem.c:EXPORT_SYMBOL_GPL(shmem_kernel_file_setup);
mm/shmem.c:      * bypass file security, in the same way as shmem_kernel_file_setup().
mm/shmem.c:     return shmem_kernel_file_setup("dev/zero", size, vm_flags);
security/keys/big_key.c:                file = shmem_kernel_file_setup("", enclen, 0);

which is a no-no. If we want to support that we might need to come up
with something more granular.

One way to work around this is something like the DRAFT, UNTESTED, BREAKS,
DOESN'T COMPILE thing below [1]. It copies the shm_mnt for memfds. If
you have multiple things that want to bind-mount and that rely on the
internal tmpfs mount this code should instead create an internal
shm_mnt_clonable mount that can be reused by the respective subsystems.

The problem is hugetlbfs which creates a couple of mounts but it's max 5
so it's probably ok to do that as well. But ugly as sin.

The other option is to fsck around with the file operations - also ugly
as sin. The third option is [3] via an inode flag. It's also not
completely clean but it's preferable to the other ones. Then you can
check for an inode flag. pidfs and nsfs could also be switched over to
this unless I'm missing something.

So what will it be: Pest or Cholera?

[3]:

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 78699d2ec0bb..f806ee130b37 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2122,6 +2122,7 @@ extern loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 #define S_VERITY       (1 << 16) /* Verity file (using fs/verity/) */
 #define S_KERNEL_FILE  (1 << 17) /* File is in use by the kernel (eg. fs/cachefiles) */
 #define S_ANON_INODE   (1 << 19) /* Inode is an anonymous inode */
+#define S_KERN_MOUNTABLE (1 << 20) /* Inode is kernel internal but mountable. */

diff --git a/mm/shmem.c b/mm/shmem.c
index 88ef1fd5cd38..93e443e580b2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5880,6 +5880,11 @@ struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup);

+struct file *shmem_file_mountable(const char *name, loff_t size, unsigned long flags)
+{
+       return __shmem_file_setup(shm_mnt, name, size, flags, S_KERN_MOUNTABLE);
+}
+
 /**
  * shmem_file_setup_with_mnt - get an unlinked file living in tmpfs
  * @mnt: the tmpfs mount where the file will be created

diff --git a/mm/memfd.c b/mm/memfd.c
index ab5312aff14b..75fd0f5b7b27 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -464,12 +464,13 @@ static struct file *alloc_file(const char *name, unsigned int flags)
        int err = 0;

        if (flags & MFD_HUGETLB) {
+               /* Do the same for hugetblfs. */
                file = hugetlb_file_setup(name, 0, VM_NORESERVE,
                                        HUGETLB_ANONHUGE_INODE,
                                        (flags >> MFD_HUGE_SHIFT) &
                                        MFD_HUGE_MASK);
        } else {
-               file = shmem_file_setup(name, 0, VM_NORESERVE);
+               file = shmem_file_mountable(name, 0, VM_NORESERVE);
        }
        if (IS_ERR(file))
                return file;


diff --git a/fs/namespace.c b/fs/namespace.c
index 080659ea7e62..1c6be54b2f08 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2399,6 +2399,23 @@ struct vfsmount *clone_private_mount(const struct path *path)
 }
 EXPORT_SYMBOL_GPL(clone_private_mount);

+struct vfsmount *vfs_clone_kern_mount(const struct vfsmount *mnt)
+{
+       struct mount *new_mnt;
+
+       guard(namespace_shared)();
+
+       if (WARN_ON_ONCE(mnt->mnt_ns != MNT_NS_INTERNAL))
+               return ERR_PTR(-EINVAL);
+
+       new_mnt = clone_mnt(mnt, mnt->mnt_root, CL_PRIVATE);
+       if (IS_ERR(new_mnt))
+               return ERR_PTR(-EINVAL);
+
+       new_mnt->mnt_ns = MNT_NS_INTERNAL;
+       return &new_mnt->mnt;
+}
+
 static void lock_mnt_tree(struct mount *mnt)
 {
        struct mount *p;
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..8faa864d8f05 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -80,6 +80,7 @@ extern bool __mnt_is_readonly(const struct vfsmount *mnt);
 extern bool mnt_may_suid(struct vfsmount *mnt);

 extern struct vfsmount *clone_private_mount(const struct path *path);
+struct vfsmount *vfs_clone_kern_mount(const struct vfsmount *mnt);
 int mnt_get_write_access(struct vfsmount *mnt);
 void mnt_put_write_access(struct vfsmount *mnt);

diff --git a/mm/memfd.c b/mm/memfd.c
index ab5312aff14b..bffb5281e082 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -22,6 +22,9 @@
 #include <uapi/linux/memfd.h>
 #include "swap.h"

+static struct vfsmount *memfd_shm_mnt __ro_after_init;
+static struct vfsmount *__memfd_internal_mnt __ro_after_init;
+
 /*
  * We need a tag: a new tag would expand every xa_node by 8 bytes,
  * so reuse a tag which we firmly believe is never set or cleared on tmpfs
@@ -464,12 +467,13 @@ static struct file *alloc_file(const char *name, unsigned int flags)
        int err = 0;

        if (flags & MFD_HUGETLB) {
+               /* Do the same for hugetblfs. */
                file = hugetlb_file_setup(name, 0, VM_NORESERVE,
                                        HUGETLB_ANONHUGE_INODE,
                                        (flags >> MFD_HUGE_SHIFT) &
                                        MFD_HUGE_MASK);
        } else {
-               file = shmem_file_setup(name, 0, VM_NORESERVE);
+               file = shmem_file_setup_with_mnt(__memfd_internal_mnt, name, 0, VM_NORESERVE);
        }
        if (IS_ERR(file))
                return file;
@@ -522,3 +526,12 @@ SYSCALL_DEFINE2(memfd_create,
        fd_flags = (flags & MFD_CLOEXEC) ? O_CLOEXEC : 0;
        return FD_ADD(fd_flags, alloc_file(name, flags));
 }
+
+void __init memfd_secret_init(const struct vfsmount *mnt)
+{
+       memfd_shm_mnt = vfs_clone_kern_mount(mnt);
+       if (ERR_PTR(memfd_shm_mnt)) /* leave memfd_shm_mnt as an error pointer so comparison against another mount always fails. */
+               __memfd_internal_mnt = mnt;
+       else
+               __memfd_internal_mnt = memfd_shm_mnt;
+}

