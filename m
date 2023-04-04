Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7CC6D5AC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjDDIZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 04:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbjDDIZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:25:16 -0400
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8CD19B6;
        Tue,  4 Apr 2023 01:25:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1357F582072;
        Tue,  4 Apr 2023 04:25:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 04 Apr 2023 04:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1680596713; x=
        1680603913; bh=ucaJdjXCvIGCze6KDfbsPlFe2n6TgL3UUQGpg9tF7po=; b=I
        DSiBq2VrNCBC6QDxMURGV8kNtJO9gautIsomo38gXtIcakYN8v07Vw2OYXsSxfn/
        aME2qwMeJzDNTlSp3qzI9uRMEP3f+Py0rAVeAXat7UyeKEzqp3FPlm0aIf9IsYjU
        VJMXwkd4SeUH00xSxDFBjlctr/KE/jVpLD7/h5Z7c2HZosqmXl8ah69koYjVKfMT
        EKGrhBzG7kgvGD167S1ZyDIT9zruuzRj0k6xLwq1xP8PbiKquj2w/Trgcl4nMdZn
        pEn9oeVAmcytzq5luBhkXUbiTk4DEACjFw2INXfbGWz9X3yl0QxMdplcJtecGdDv
        w/IPQCjLyN72kjsv7QPJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680596713; x=1680603913; bh=ucaJdjXCvIGCz
        e6KDfbsPlFe2n6TgL3UUQGpg9tF7po=; b=KxjPvdshfxbt2/6hFUHYrRjGmYUQI
        AacryrBkFC92hJLW6LUXwVPG8eoE6c9/ToxcviVUPXwT9n6U9KUtitW12VQTgEPM
        dtWOhdv0rYR6MoluiNosghIZDNR9g+Xn7iMiDrGkNh+VsX9uFKovlLDYM4XsFMtn
        BxmQ+xNwM/IVoJHAXQenfwwYITbs+6mK6YhZpuLJlps+FR2JJDBBaN5137529WCO
        G6WozEo2zY2g0o+poTxy+XKEesh2njzFQJghOtV/BlkD90rQ1c1qkjfLVq8/8Nsj
        cZR1ZPsKHFr0W0XueC5rcVZqlM9mpJNRHSnNgFCxUbirqS4tT4YcQT3vw==
X-ME-Sender: <xms:594rZFsDdlfX3C3UBbehL30vE9YfyLf7XUtU0hKYnmKgT4UOtgLOcQ>
    <xme:594rZOdLHY59ptztN9KpTQEq7XwkbjmkQqY0vzVa_GylWcd_Y6rxwruI_4HTO2_s5
    2qQMdMxhutCwm-0Qlc>
X-ME-Received: <xmr:594rZIwz_xb5yM2dG1h_WtLjuLqY2FJ1LNGUP70yWmzAIeKm4ZHovzbraDlUXc3NCuzxBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:594rZMMm7ERGOuRf6j0KEPnsIaOnJLLIAtNtQtvW9Kw28ObNyP2O4w>
    <xmx:594rZF93Z5UZUB6gYgYG8-jATfACy8p3b0q_hraVNF4DpZz1KDIypw>
    <xmx:594rZMXJx4DaW1I1BdTCKFNDqbrKkl3kR0g6UZ4xsMVfMaN14WwR3w>
    <xmx:6d4rZEDiAVOUK62NR-3AI4m0fzW6ULVpFZqPWyawWzV3iixQHl6osw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 04:25:10 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 5730E10CC3C; Tue,  4 Apr 2023 11:25:07 +0300 (+03)
Date:   Tue, 4 Apr 2023 11:25:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org, aarcange@redhat.com,
        ak@linux.intel.com, akpm@linux-foundation.org, arnd@arndb.de,
        bfields@fieldses.org, bp@alien8.de, chao.p.peng@linux.intel.com,
        corbet@lwn.net, dave.hansen@intel.com, david@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com, hpa@zytor.com,
        hughd@google.com, jlayton@kernel.org, jmattson@google.com,
        joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com
Subject: Re: [RFC PATCH v3 1/2] mm: restrictedmem: Allow userspace to specify
 mount for memfd_restricted
Message-ID: <20230404082507.sbyfahwc4gdupmya@box.shutemov.name>
References: <cover.1680306489.git.ackerleytng@google.com>
 <592ebd9e33a906ba026d56dc68f42d691706f865.1680306489.git.ackerleytng@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592ebd9e33a906ba026d56dc68f42d691706f865.1680306489.git.ackerleytng@google.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:50:39PM +0000, Ackerley Tng wrote:
> By default, the backing shmem file for a restrictedmem fd is created
> on shmem's kernel space mount.
> 
> With this patch, an optional tmpfs mount can be specified via an fd,
> which will be used as the mountpoint for backing the shmem file
> associated with a restrictedmem fd.
> 
> This will help restrictedmem fds inherit the properties of the
> provided tmpfs mounts, for example, hugepage allocation hints, NUMA
> binding hints, etc.
> 
> Permissions for the fd passed to memfd_restricted() is modeled after
> the openat() syscall, since both of these allow creation of a file
> upon a mount/directory.
> 
> Permission to reference the mount the fd represents is checked upon fd
> creation by other syscalls (e.g. fsmount(), open(), or open_tree(),
> etc) and any process that can present memfd_restricted() with a valid
> fd is expected to have obtained permission to use the mount
> represented by the fd. This behavior is intended to parallel that of
> the openat() syscall.
> 
> memfd_restricted() will check that the tmpfs superblock is
> writable, and that the mount is also writable, before attempting to
> create a restrictedmem file on the mount.
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  include/linux/syscalls.h           |  2 +-
>  include/uapi/linux/restrictedmem.h |  8 ++++
>  mm/restrictedmem.c                 | 74 +++++++++++++++++++++++++++---
>  3 files changed, 77 insertions(+), 7 deletions(-)
>  create mode 100644 include/uapi/linux/restrictedmem.h
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index f9e9e0c820c5..a23c4c385cd3 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1056,7 +1056,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> -asmlinkage long sys_memfd_restricted(unsigned int flags);
> +asmlinkage long sys_memfd_restricted(unsigned int flags, int mount_fd);
> 
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
> new file mode 100644
> index 000000000000..22d6f2285f6d
> --- /dev/null
> +++ b/include/uapi/linux/restrictedmem.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_RESTRICTEDMEM_H
> +#define _UAPI_LINUX_RESTRICTEDMEM_H
> +
> +/* flags for memfd_restricted */
> +#define RMFD_USERMNT		0x0001U
> +
> +#endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
> diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
> index c5d869d8c2d8..f7b62364a31a 100644
> --- a/mm/restrictedmem.c
> +++ b/mm/restrictedmem.c
> @@ -1,11 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "linux/sbitmap.h"
> +#include <linux/namei.h>
>  #include <linux/pagemap.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/syscalls.h>
>  #include <uapi/linux/falloc.h>
>  #include <uapi/linux/magic.h>
> +#include <uapi/linux/restrictedmem.h>
>  #include <linux/restrictedmem.h>
> 
>  struct restrictedmem {
> @@ -189,19 +190,20 @@ static struct file *restrictedmem_file_create(struct file *memfd)
>  	return file;
>  }
> 
> -SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
> +static int restrictedmem_create(struct vfsmount *mount)
>  {
>  	struct file *file, *restricted_file;
>  	int fd, err;
> 
> -	if (flags)
> -		return -EINVAL;
> -
>  	fd = get_unused_fd_flags(0);
>  	if (fd < 0)
>  		return fd;
> 
> -	file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> +	if (mount)
> +		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
> +	else
> +		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
> +
>  	if (IS_ERR(file)) {
>  		err = PTR_ERR(file);
>  		goto err_fd;
> @@ -223,6 +225,66 @@ SYSCALL_DEFINE1(memfd_restricted, unsigned int, flags)
>  	return err;
>  }
> 
> +static bool is_shmem_mount(struct vfsmount *mnt)
> +{
> +	return mnt && mnt->mnt_sb && mnt->mnt_sb->s_magic == TMPFS_MAGIC;
> +}
> +
> +static bool is_mount_root(struct file *file)
> +{
> +	return file->f_path.dentry == file->f_path.mnt->mnt_root;
> +}
> +
> +static int restrictedmem_create_on_user_mount(int mount_fd)
> +{
> +	int ret;
> +	struct fd f;
> +	struct vfsmount *mnt;
> +
> +	f = fdget_raw(mount_fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	ret = -EINVAL;
> +	if (!is_mount_root(f.file))
> +		goto out;
> +
> +	mnt = f.file->f_path.mnt;
> +	if (!is_shmem_mount(mnt))
> +		goto out;
> +
> +	ret = file_permission(f.file, MAY_WRITE | MAY_EXEC);

Why MAY_EXEC?

> +	if (ret)
> +		goto out;
> +
> +	ret = mnt_want_write(mnt);
> +	if (unlikely(ret))
> +		goto out;
> +
> +	ret = restrictedmem_create(mnt);
> +
> +	mnt_drop_write(mnt);
> +out:
> +	fdput(f);
> +
> +	return ret;
> +}

We need review from fs folks. Look mostly sensible, but I have no
experience in fs.

> +
> +SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, int, mount_fd)
> +{
> +	if (flags & ~RMFD_USERMNT)
> +		return -EINVAL;
> +
> +	if (flags == RMFD_USERMNT) {
> +		if (mount_fd < 0)
> +			return -EINVAL;
> +
> +		return restrictedmem_create_on_user_mount(mount_fd);
> +	} else {
> +		return restrictedmem_create(NULL);
> +	}

Maybe restructure with single restrictedmem_create() call?

	struct vfsmount *mnt = NULL;

	if (flags == RMFD_USERMNT) {
		...
		mnt = ...();
	}

	return restrictedmem_create(mnt);
> +}
> +
>  int restrictedmem_bind(struct file *file, pgoff_t start, pgoff_t end,
>  		       struct restrictedmem_notifier *notifier, bool exclusive)
>  {
> --
> 2.40.0.348.gf938b09366-goog

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
