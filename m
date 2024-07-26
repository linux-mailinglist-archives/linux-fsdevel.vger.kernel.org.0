Return-Path: <linux-fsdevel+bounces-24321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15393D408
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 15:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F04551C23760
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507BE17BB24;
	Fri, 26 Jul 2024 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpYcwupb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F726AC1;
	Fri, 26 Jul 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999911; cv=none; b=ZPRaLWaOmOoJC7vqd2v6ZJkqPKP9voZZTsmcPIyMe0PKV1GWD3+HSk2YRq6g5DTV48J0dxNhOilgD6y2yqmC2Y3CmCkU3hYQcGbiZkj8ON5wJMZxfD7P8xnOkL1hbpAO7B7u/+Crk4CNxk6FD+phBiWSHCdpg/O4noRDhZV2k+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999911; c=relaxed/simple;
	bh=CH33DTiu3ITeY6LPHWvX6+rTn3eLZ9yqooBX7JQ1xQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrZv7XhToR3O4zx9lBWrQR66vObOswmB0mb4lrlba/+cs58uV2ioubK3G20yPp6VctX3jnL/VBFsmItyxRFzg3YfOwMoGeEZ5T1x+HDz03O4Nbb3XAV+psIQRQc5lVCHfvvbSPAilOL3XXWLwvHfSDNs6GT2/8EDgeqlSnDK2HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpYcwupb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D97C32782;
	Fri, 26 Jul 2024 13:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721999911;
	bh=CH33DTiu3ITeY6LPHWvX6+rTn3eLZ9yqooBX7JQ1xQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpYcwupbtWJRXZI65YH+CGoih/jwZXcKrCI/iZPt028IwS7mNrAEhmfQW0avyoqGR
	 XpsLlB3TeZwxJNCGI8JLFHMrmmmPDcydHmf+6Ty6xmXkhkcZTHo69M1JKFSwG+Ivbp
	 8eBdOB8ehCIke4nr3DduH697jH8wFMKciZGB1yI8mWRCBIueq4zoH0qs52cvrzk6NX
	 Clu80S8Fxt/twsDBzbrZ0SDZt9mGGI+M41idJkHwN6j5sxbOlNqkQe62ybdx9KlmFt
	 uesuGMvT1bDGdA2vCatD+zc5U9R/usq53NaI9oyxueouv9rKRiEBrSL3pmnqKSt7N+
	 5SqTZy+RRygTg==
Date: Fri, 26 Jul 2024 15:18:25 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, kpsingh@kernel.org, 
	andrii@kernel.org, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	jolsa@kernel.org, daniel@iogearbox.net, memxor@gmail.com
Subject: Re: [PATCH v3 bpf-next 1/3] bpf: introduce new VFS based BPF kfuncs
Message-ID: <20240726-klippe-umklammern-fe099b09e075@brauner>
References: <20240726085604.2369469-1-mattbobrowski@google.com>
 <20240726085604.2369469-2-mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240726085604.2369469-2-mattbobrowski@google.com>

On Fri, Jul 26, 2024 at 08:56:02AM GMT, Matt Bobrowski wrote:
> Add a new variant of bpf_d_path() named bpf_path_d_path() which takes
> the form of a BPF kfunc and enforces KF_TRUSTED_ARGS semantics onto
> its arguments.
> 
> This new d_path() based BPF kfunc variant is intended to address the
> legacy bpf_d_path() BPF helper's susceptibility to memory corruption
> issues [0, 1, 2] by ensuring to only operate on supplied arguments
> which are deemed trusted by the BPF verifier. Typically, this means
> that only pointers to a struct path which have been referenced counted
> may be supplied.
> 
> In addition to the new bpf_path_d_path() BPF kfunc, we also add a
> KF_ACQUIRE based BPF kfunc bpf_get_task_exe_file() and KF_RELEASE
> counterpart BPF kfunc bpf_put_file(). This is so that the new
> bpf_path_d_path() BPF kfunc can be used more flexibility from within
> the context of a BPF LSM program. It's rather common to ascertain the
> backing executable file for the calling process by performing the
> following walk current->mm->exe_file while instrumenting a given
> operation from the context of the BPF LSM program. However, walking
> current->mm->exe_file directly is never deemed to be OK, and doing so
> from both inside and outside of BPF LSM program context should be
> considered as a bug. Using bpf_get_task_exe_file() and in turn
> bpf_put_file() will allow BPF LSM programs to reliably get and put
> references to current->mm->exe_file.
> 
> As of now, all the newly introduced BPF kfuncs within this patch are
> limited to sleepable BPF LSM program types. Therefore, they may only
> be called when a BPF LSM program is attached to one of the listed
> attachment points defined within the sleepable_lsm_hooks BTF ID set.
> 
> [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
> [1] https://lore.kernel.org/bpf/20230606181714.532998-1-jolsa@kernel.org/
> [2] https://lore.kernel.org/bpf/20220219113744.1852259-1-memxor@gmail.com/
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  fs/Makefile        |   1 +
>  fs/bpf_fs_kfuncs.c | 133 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 134 insertions(+)
>  create mode 100644 fs/bpf_fs_kfuncs.c
> 
> diff --git a/fs/Makefile b/fs/Makefile
> index 6ecc9b0a53f2..61679fd587b7 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -129,3 +129,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>  obj-$(CONFIG_EROFS_FS)		+= erofs/
>  obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
>  obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> +obj-$(CONFIG_BPF_LSM)		+= bpf_fs_kfuncs.o
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> new file mode 100644
> index 000000000000..3813e2a83313
> --- /dev/null
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/btf_ids.h>
> +#include <linux/dcache.h>
> +#include <linux/err.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/path.h>
> +#include <linux/sched.h>
> +
> +__bpf_kfunc_start_defs();
> +/**
> + * bpf_get_task_exe_file - get a reference on the exe_file struct file member of
> + *                         the mm_struct that is nested within the supplied
> + *                         task_struct
> + * @task: task_struct of which the nested mm_struct exe_file member to get a
> + * reference on
> + *
> + * Get a reference on the exe_file struct file member field of the mm_struct
> + * nested within the supplied *task*. The referenced file pointer acquired by
> + * this BPF kfunc must be released using bpf_put_file(). Failing to call
> + * bpf_put_file() on the returned referenced struct file pointer that has been
> + * acquired by this BPF kfunc will result in the BPF program being rejected by
> + * the BPF verifier.
> + *
> + * This BPF kfunc may only be called from sleepable BPF LSM programs.
> + *
> + * Internally, this BPF kfunc leans on get_task_exe_file(), such that calling
> + * bpf_get_task_exe_file() would be analogous to calling get_task_exe_file()
> + * directly in kernel context.
> + *
> + * Return: A referenced struct file pointer to the exe_file member of the
> + * mm_struct that is nested within the supplied *task*. On error, NULL is
> + * returned.
> + */
> +__bpf_kfunc struct file *bpf_get_task_exe_file(struct task_struct *task)
> +{
> +	return get_task_exe_file(task);
> +}
> +
> +/**
> + * bpf_put_file - put a reference on the supplied file
> + * @file: file to put a reference on
> + *
> + * Put a reference on the supplied *file*. Only referenced file pointers may be
> + * passed to this BPF kfunc. Attempting to pass an unreferenced file pointer, or
> + * any other arbitrary pointer for that matter, will result in the BPF program
> + * being rejected by the BPF verifier.
> + *
> + * This BPF kfunc may only be called from sleepable BPF LSM programs. Though
> + * fput() can be called from IRQ context, we're enforcing sleepability here.
> + */
> +__bpf_kfunc void bpf_put_file(struct file *file)
> +{
> +	fput(file);
> +}
> +
> +/**
> + * bpf_path_d_path - resolve the pathname for the supplied path
> + * @path: path to resolve the pathname for
> + * @buf: buffer to return the resolved pathname in
> + * @buf__sz: length of the supplied buffer
> + *
> + * Resolve the pathname for the supplied *path* and store it in *buf*. This BPF
> + * kfunc is the safer variant of the legacy bpf_d_path() helper and should be
> + * used in place of bpf_d_path() whenever possible. It enforces KF_TRUSTED_ARGS
> + * semantics, meaning that the supplied *path* must itself hold a valid
> + * reference, or else the BPF program will be outright rejected by the BPF
> + * verifier.
> + *
> + * This BPF kfunc may only be called from sleepable BPF LSM programs.
> + *
> + * Return: A positive integer corresponding to the length of the resolved
> + * pathname in *buf*, including the NUL termination character. On error, a
> + * negative integer is returned.
> + */
> +__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
> +{
> +	int len;
> +	char *ret;
> +
> +	if (buf__sz <= 0)
> +		return -EINVAL;

size_t is unsigned so this should just be !buf__sz I can fix that
though. The __sz thing has meaning to the verifier afaict so I guess
that's fine as name then.

