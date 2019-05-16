Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD21D2077B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 15:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfEPNBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 09:01:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39340 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfEPNBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 09:01:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so5159755edq.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 06:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Op0ZOu3pv2+cSDoiT6vVZUHFiOJRH52sO9/tDHONC4I=;
        b=SIeqP3f6PTE2ZzcuBqs8yMC+kwmSPJ6U9m4sjtz7SRu0asefPmFYQQuxQFWOu8LkmM
         Fsr+SszBCfv2J04tuSGcfZswp4HXPhZCqpo2hzprPISBH+qdPKU/SHrlv05sJ65bnlXn
         p2yewqQd095oea+NvUgRujIVnHBH8y+TdHdU4kGQG5a6ksvvUJqOdDlqPdCJCJQUQ4zH
         +JdNZ8rWeM5iaIy8fiA/DQWUX+/fA1mipZm5JVYILT6nq9uwHtU3udkHQMwBFoEHLk1D
         lY37trhQtZ+UngpuyTA3sdxzAeHG2od2R05PlWUwp7jY0YN11wTzo9p6U9wPh3sYvsNL
         MFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Op0ZOu3pv2+cSDoiT6vVZUHFiOJRH52sO9/tDHONC4I=;
        b=cBVWVhuWNrYDdxfktNmCuI685U2Ex56ra8U9MSjPM4gICfF8bzGWen+ahxKCfGtJRL
         fOLSdNfDWKCyc/zaHp2ZuTUkZ6GcnDqg5L619wyQyOJ0Sd+0cTKh40eAte6k9Calq6Q5
         YIsPcEE43hA06uT3Kan3KrrLO7eM80nTr65sbAleHxpYFqZ9tNFtW2iMBOsOn2mz7aM1
         jUmVhdPZ9r9p9RzfZW8nPVQfH7z2mTJEElC81rU8ZAPVkvwbrnRo9rUSIU/lGjLtakd/
         aA2vX/EuD3XsfgGtta2f+CiMdgxt0I1sNoaIE6cFbWTTANVG66hjeLiYZQTulklLHZIW
         Tq7g==
X-Gm-Message-State: APjAAAU3gdWCElXEMUI6Bp9FBHdVUXawMlOKj1LXo/GxxbI4C3vHq2hl
        LsiaPCtqRYbX7JjDWLwdcQGu2Q==
X-Google-Smtp-Source: APXvYqzyfbJvu4eJXJ8K6+zcs3F/dZ6CR6N5DOG2jmD9xDBlzBrtQ+eluDwrGV5ZrMBWuUk8fQyCTw==
X-Received: by 2002:a17:906:60c9:: with SMTP id f9mr2762887ejk.83.1558011692001;
        Thu, 16 May 2019 06:01:32 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id l5sm1819356edb.50.2019.05.16.06.01.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 06:01:31 -0700 (PDT)
Date:   Thu, 16 May 2019 15:01:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] uapi, x86: Fix the syscall numbering of the mount
 API syscalls [ver #2]
Message-ID: <20190516130130.qc4ljx7lsvym56w6@brauner.io>
References: <155800752418.4037.9567789434648701032.stgit@warthog.procyon.org.uk>
 <155800754738.4037.11950529125416851948.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155800754738.4037.11950529125416851948.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 12:52:27PM +0100, David Howells wrote:
> Fix the syscall numbering of the mount API syscalls so that the numbers
> match between i386 and x86_64 and that they're in the common numbering
> scheme space.
> 
> Fixes: a07b20004793 ("vfs: syscall: Add open_tree(2) to reference or clone a mount")
> Fixes: 2db154b3ea8e ("vfs: syscall: Add move_mount(2) to move mounts around")
> Fixes: 24dcb3d90a1f ("vfs: syscall: Add fsopen() to prepare for superblock creation")
> Fixes: ecdab150fddb ("vfs: syscall: Add fsconfig() for configuring and managing a context")
> Fixes: 93766fbd2696 ("vfs: syscall: Add fsmount() to create a mount for a superblock")
> Fixes: cf3cba4a429b ("vfs: syscall: Add fspick() to select a superblock for reconfiguration")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Christian Brauner <christian@brauner.io>

> ---
> 
>  arch/x86/entry/syscalls/syscall_32.tbl |   12 ++++++------
>  arch/x86/entry/syscalls/syscall_64.tbl |   12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 4cd5f982b1e5..ad968b7bac72 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -398,12 +398,6 @@
>  384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
>  385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pgetevents
>  386	i386	rseq			sys_rseq			__ia32_sys_rseq
> -387	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
> -388	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
> -389	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
> -390	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
> -391	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
> -392	i386	fspick			sys_fspick			__ia32_sys_fspick
>  393	i386	semget			sys_semget    			__ia32_sys_semget
>  394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
>  395	i386	shmget			sys_shmget    			__ia32_sys_shmget
> @@ -438,3 +432,9 @@
>  425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
>  426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
>  427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
> +428	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
> +429	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
> +430	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
> +431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
> +432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
> +433	i386	fspick			sys_fspick			__ia32_sys_fspick
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 64ca0d06259a..b4e6f9e6204a 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -343,18 +343,18 @@
>  332	common	statx			__x64_sys_statx
>  333	common	io_pgetevents		__x64_sys_io_pgetevents
>  334	common	rseq			__x64_sys_rseq
> -335	common	open_tree		__x64_sys_open_tree
> -336	common	move_mount		__x64_sys_move_mount
> -337	common	fsopen			__x64_sys_fsopen
> -338	common	fsconfig		__x64_sys_fsconfig
> -339	common	fsmount			__x64_sys_fsmount
> -340	common	fspick			__x64_sys_fspick
>  # don't use numbers 387 through 423, add new calls after the last
>  # 'common' entry
>  424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
>  425	common	io_uring_setup		__x64_sys_io_uring_setup
>  426	common	io_uring_enter		__x64_sys_io_uring_enter
>  427	common	io_uring_register	__x64_sys_io_uring_register
> +428	common	open_tree		__x64_sys_open_tree
> +429	common	move_mount		__x64_sys_move_mount
> +430	common	fsopen			__x64_sys_fsopen
> +431	common	fsconfig		__x64_sys_fsconfig
> +432	common	fsmount			__x64_sys_fsmount
> +433	common	fspick			__x64_sys_fspick
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> 
