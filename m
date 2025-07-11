Return-Path: <linux-fsdevel+bounces-54615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B57B019DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 12:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF5B16C245
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319AA28688F;
	Fri, 11 Jul 2025 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v7730XHH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8OEp1y+H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8971E27A927;
	Fri, 11 Jul 2025 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752230165; cv=none; b=MfpvjY+nUAvMcVEAcPnioLfpwWQi7a0DHKabWal3ShUXSFBLTJumaGMBS55PjRH0bmTR1X/tKr+Y52fj03yJTuSm2W5wdfSELII9ru2lwlK//uVb6iHItU80mD4qURozZcbxxCE/GaPPjJodVCdZAT6bKw5OHVCP+uYMu2slq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752230165; c=relaxed/simple;
	bh=p54A3JKyN8EIFrBPkClGFfrlhYCSrX+6X/Am1+7kpU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeFv+KSst3pwUxVKKOo2uaNlLcwrz5mHwa0KNLYHEFV82kK/qxshm0jtu0plp+ofYUoLYtePxMPFKiYkk3MqDLDMR4+uB7d6FRZ0DWRjZGSvwCuv9epi1DLSUBl0qGhk+7efKOkv/RP6jJHH/5DG1rsmATUlm2pxvbJWYKWW4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v7730XHH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8OEp1y+H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 12:35:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752230161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6Re+znlFWFKIuewW27SgxsH0E2fzm5oXpRQWBOP5J8=;
	b=v7730XHHRGASv5D6RRpeIPQ4cWgk+MIZmHXBguF0Vl1t9v/NNqpm7qCp5nz/TvlNoxRcJ3
	4mcEuLQjHUOu6+IK0G2C1c9Rbv/fHO6O6lMyf3NKkUuiFoVUnI/1mi2F12ay5RZ7asljSY
	5040kOeoe4djDkcE709DAA9XfI2h4bwMUcONepsUsVzfebC9UrWwvvKmSLjsCNe2Tz8qaL
	FkiTGpSp9SAAfNp9gYTXJhkm2PnI7mdSNYx5yOHkFDkHxEt/petgkMbR38Xad2TmLf7fVA
	2txyX9MaItZQJWsqjmEYtd9u5rgf5GW48zEmM7rh08M1ZhRbujN/uZNer/qSpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752230161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6Re+znlFWFKIuewW27SgxsH0E2fzm5oXpRQWBOP5J8=;
	b=8OEp1y+HSks3ZRmCw01UTTXmczBO9aCAbcAivWhq4aTZ4DkcEb0M9k3Qzeqq/2aUULV+Nc
	yx0+XKoduPxA1NDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de>
 <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250626-kunit-kselftests-v4-6-48760534fef5@linutronix.de>

Hi Kees, Al, Christian and Honza,

On Thu, Jun 26, 2025 at 08:10:14AM +0200, Thomas Weiﬂschuh wrote:
> The KUnit UAPI infrastructure starts userspace processes.
> As it should be able to be built as a module, export the necessary symbols.

could you take a look at these new symbol exports?

Thanks,
Thomas

> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> 
> ---
> To: Kees Cook <kees@kernel.org>
> To: Alexander Viro <viro@zeniv.linux.org.uk>
> To: Christian Brauner <brauner@kernel.org>
> To: Jan Kara <jack@suse.cz>
> Cc: linux-mm@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> 
> ./get_maintainer.pl would have also Cc-ed all of the memory management and
> scheduler maintainers. I trimmed the list to only BINFMT/EXEC and VFS.
> ---
>  fs/exec.c        | 2 ++
>  fs/file.c        | 1 +
>  fs/filesystems.c | 2 ++
>  fs/fs_struct.c   | 1 +
>  fs/pipe.c        | 2 ++
>  kernel/exit.c    | 3 +++
>  kernel/fork.c    | 2 ++
>  7 files changed, 13 insertions(+)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 1f5fdd2e096e392b342f122d35aba4cf035441c7..13f7f27641942eddcb179bdd93d99b799d155813 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -68,6 +68,7 @@
>  #include <linux/user_events.h>
>  #include <linux/rseq.h>
>  #include <linux/ksm.h>
> +#include <linux/export.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -1919,6 +1920,7 @@ int kernel_execve(const char *kernel_filename,
>  	putname(filename);
>  	return retval;
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(kernel_execve, "kunit-uapi");
>  
>  static int do_execve(struct filename *filename,
>  	const char __user *const __user *__argv,
> diff --git a/fs/file.c b/fs/file.c
> index 3a3146664cf37115624e12f7f06826d48827e9d7..89d07feb9c328337451ce40cb0f368b6cb986c2c 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1317,6 +1317,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
>  	spin_unlock(&files->file_lock);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(replace_fd, "kunit-uapi");
>  
>  /**
>   * receive_fd() - Install received file into file descriptor table
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 95e5256821a53494d88f496193305a2e50e04444..a3a588f387bbd8268246d1026389deaadf265d0b 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/fs_parser.h>
> +#include <linux/export.h>
>  
>  /*
>   * Handling of filesystem drivers list.
> @@ -45,6 +46,7 @@ void put_filesystem(struct file_system_type *fs)
>  {
>  	module_put(fs->owner);
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(put_filesystem, "kunit-uapi");
>  
>  static struct file_system_type **find_filesystem(const char *name, unsigned len)
>  {
> diff --git a/fs/fs_struct.c b/fs/fs_struct.c
> index 64c2d0814ed6889cc12603410e6e9dc44089586f..26340d225deba3f2ec30252293fdf417235a6a4a 100644
> --- a/fs/fs_struct.c
> +++ b/fs/fs_struct.c
> @@ -46,6 +46,7 @@ void set_fs_pwd(struct fs_struct *fs, const struct path *path)
>  	if (old_pwd.dentry)
>  		path_put(&old_pwd);
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(set_fs_pwd, "kunit-uapi");
>  
>  static inline int replace_path(struct path *p, const struct path *old, const struct path *new)
>  {
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 45077c37bad154ef146b047834d35d489fcc4d8d..d6cb743d2cfc041f08b498a5a764e9a96dc34069 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -27,6 +27,7 @@
>  #include <linux/watch_queue.h>
>  #include <linux/sysctl.h>
>  #include <linux/sort.h>
> +#include <linux/export.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/ioctls.h>
> @@ -971,6 +972,7 @@ int create_pipe_files(struct file **res, int flags)
>  	file_set_fsnotify_mode(res[1], FMODE_NONOTIFY_PERM);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(create_pipe_files, "kunit-uapi");
>  
>  static int __do_pipe_flags(int *fd, struct file **files, int flags)
>  {
> diff --git a/kernel/exit.c b/kernel/exit.c
> index bd743900354ca5fc6c550f80e30393a632eb9a4e..610dffb1276ac60b475708587ca053f315fea9c3 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -70,6 +70,7 @@
>  #include <linux/user_events.h>
>  #include <linux/uaccess.h>
>  #include <linux/pidfs.h>
> +#include <linux/export.h>
>  
>  #include <uapi/linux/wait.h>
>  
> @@ -1005,6 +1006,7 @@ void __noreturn do_exit(long code)
>  	lockdep_free_task(tsk);
>  	do_task_dead();
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(do_exit, "kunit-uapi");
>  
>  void __noreturn make_task_dead(int signr)
>  {
> @@ -1887,6 +1889,7 @@ int kernel_wait(pid_t pid, int *stat)
>  	put_pid(wo.wo_pid);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(kernel_wait, "kunit-uapi");
>  
>  SYSCALL_DEFINE4(wait4, pid_t, upid, int __user *, stat_addr,
>  		int, options, struct rusage __user *, ru)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1ee8eb11f38bae1d2eb6de9494aea94b7a19e6c3..5de7a9bc005ade6dcfbdfe1a63cadbef8782658c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -105,6 +105,7 @@
>  #include <uapi/linux/pidfd.h>
>  #include <linux/pidfs.h>
>  #include <linux/tick.h>
> +#include <linux/export.h>
>  
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -2676,6 +2677,7 @@ pid_t user_mode_thread(int (*fn)(void *), void *arg, unsigned long flags)
>  
>  	return kernel_clone(&args);
>  }
> +EXPORT_SYMBOL_GPL_FOR_MODULES(user_mode_thread, "kunit-uapi");
>  
>  #ifdef __ARCH_WANT_SYS_FORK
>  SYSCALL_DEFINE0(fork)
> 
> -- 
> 2.50.0
> 

