Return-Path: <linux-fsdevel+bounces-21859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A2B90C36C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 08:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AE8B21F2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 06:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD046EB56;
	Tue, 18 Jun 2024 06:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RTD0AG+O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FawJl5ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F1E1C2A8;
	Tue, 18 Jun 2024 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718691534; cv=none; b=N1GEP1KQ/l4RhYeKWGrk4iOssEnvpcqUG6oPbfjHX4fpFrbuYLRJocxARgpf1OmiaHoc2fd08WudAyg+i1VpPAgzFcFXZvDJMRTzJX8HkQj6dgqcSg10TTpuYZeEv/uUwekbBTndobtXVmz3pj9kYqThUTe5JGNPXUF1pCJ1wMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718691534; c=relaxed/simple;
	bh=ETyn2nN6XmZALTD5W7mdr78evwePHMPeyvT7PAa66D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOR7h1mC8LE2kOxqnbbK6IMawz6pswLOX8JwtVF7Y1P7wAv78vzPL4oD5Vvw1vkqdBAibhaqH31aOThxSIO9OYOOTLflw7/DCBZDlaGhLVTjQcbGTUJIPgfbMgbkI0i9OwBdNbmhWD6/YbpTAL6RY1XJybKjuGzDZXZz6a6viQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RTD0AG+O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FawJl5ap; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 08:18:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718691530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uZd8acKm7Z+ZaAEXOc65fAMwyRFqDxRZ/2KGwKmnsM=;
	b=RTD0AG+Ok5Eb2viXr8w7bx9N2gwxeBKLNaQOGxLA6CbKWH9GD6UnZtFMHj0BhAcDj67S36
	EEt5extIBWG2b4bKOWlqVT3JS2VkSXuFQIpnuk9fR1/TxegW3gDTQQRF8FSxHuQNcu8U2q
	1A5xUwKBXi2iCsBfY/YQnfLRKRsyetNk4ECcC1dNqEUtQa1lOVZQaZICkOx86oI9qpUAw3
	SElw9AmzxH6qFCEua+A1b9c6UuoOypC4EWKfiEzkrT/QgdDx7FH7725bp8qvtGmj+Gm5kT
	1Yti8fJmpG1tCeS0xOSo38xHqy52F5JnT0eqj5jJrsXu7xrhQlV8DTeAZk+IXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718691530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8uZd8acKm7Z+ZaAEXOc65fAMwyRFqDxRZ/2KGwKmnsM=;
	b=FawJl5apYzTR6B6HQARpqQ+uMcxg+ICgyHev2sHnDEIoJ0A5MR3kIr3nIXwUqt+RPTsdoE
	zXoXPLFWrMEDzKDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
	brauner@kernel.org, ebiederm@xmission.com, jack@suse.cz,
	keescook@chromium.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nagvijay@microsoft.com, oleg@redhat.com, tandersen@netflix.com,
	vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
	apais@microsoft.com, ssengar@microsoft.com, sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: Re: [PATCH 1/1] binfmt_elf, coredump: Log the reason of the failed
 core dumps
Message-ID: <20240618061849.Vh9N3ds2@linutronix.de>
References: <20240617234133.1167523-1-romank@linux.microsoft.com>
 <20240617234133.1167523-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617234133.1167523-2-romank@linux.microsoft.com>

On 2024-06-17 16:41:30 [-0700], Roman Kisel wrote:
> Missing, failed, or corrupted core dumps might impede crash
> investigations. To improve reliability of that process and consequently
> the programs themselves, one needs to trace the path from producing
> a core dumpfile to analyzing it. That path starts from the core dump file
> written to the disk by the kernel or to the standard input of a user
> mode helper program to which the kernel streams the coredump contents.
> There are cases where the kernel will interrupt writing the core out or
> produce a truncated/not-well-formed core dump.

How much of this happened and how much of this is just "let me handle
everything that could go wrong".
The cases where it was interrupted without a hint probably deserve a
note rather then leaving a half of coredump back.

> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index a57a06b80f57..a7200c9024c6 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -777,9 +807,18 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		}
>  		file_end_write(cprm.file);
>  		free_vma_snapshot(&cprm);
> +	} else {
> +		pr_err("Core dump to |%s has been interrupted\n", cn.corename);
> +		retval = -EAGAIN;
> +		goto fail;
>  	}
> +	pr_info("Core dump to |%s: vma_count %d, vma_data_size %lu, written %lld bytes, pos %lld\n",
> +		cn.corename, cprm.vma_count, cprm.vma_data_size, cprm.written, cprm.pos);

Probably too noisy in the default case. The offsets probably don't
matter unless you debug.

>  	if (ispipe && core_pipe_limit)
>  		wait_for_dump_helpers(cprm.file);
> +
> +	retval = 0;
> +
>  close_fail:
>  	if (cprm.file)
>  		filp_close(cprm.file, NULL);
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index 0904ba010341..8b29be758a87 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -42,9 +42,9 @@ extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
>  extern int dump_align(struct coredump_params *cprm, int align);
>  int dump_user_range(struct coredump_params *cprm, unsigned long start,
>  		    unsigned long len);
> -extern void do_coredump(const kernel_siginfo_t *siginfo);
> +extern int do_coredump(const kernel_siginfo_t *siginfo);
>  #else
> -static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
> +static inline int do_coredump(const kernel_siginfo_t *siginfo) {}

This probably does not compile.

>  #endif
>  
>  #if defined(CONFIG_COREDUMP) && defined(CONFIG_SYSCTL)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 1f9dd41c04be..f2ecf29a994d 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2675,6 +2675,7 @@ bool get_signal(struct ksignal *ksig)
>  	struct sighand_struct *sighand = current->sighand;
>  	struct signal_struct *signal = current->signal;
>  	int signr;
> +	int ret;
>  
>  	clear_notify_signal();
>  	if (unlikely(task_work_pending(current)))
> @@ -2891,7 +2892,9 @@ bool get_signal(struct ksignal *ksig)
>  			 * first and our do_group_exit call below will use
>  			 * that value and ignore the one we pass it.
>  			 */
> -			do_coredump(&ksig->info);
> +			ret = do_coredump(&ksig->info);
> +			if (ret)
> +				pr_err("coredump has not been created, error %d\n", ret);

So you preserve the error code just for one additional note.

>  		}
>  
>  		/*

Sebastian

