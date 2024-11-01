Return-Path: <linux-fsdevel+bounces-33460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC829B90A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 12:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F53B2831B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 11:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D958719B5B8;
	Fri,  1 Nov 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmAgbgm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B12015820C;
	Fri,  1 Nov 2024 11:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461935; cv=none; b=C04GHCqpNJ+6pErEWehmlTGvTBFn+lxCWPDDkV+wCWasOZZo1GSx2pS8Qks2jRa9WjkNKV8zaqBJ5U/blO/B2e5Lxny2GpJX97ey+lvYlcXfx/uLTyxQxqRNewViKOtEUkA3NYC8efQsBAEmrldAGrlM4GPPvdLdcmhME8c5R0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461935; c=relaxed/simple;
	bh=57TfoCYTbEwQPkJzCSWfPWSdR5l5+Kvm1S5E2+Mg2eE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IecH52Nje4mSDuC0M+cjDS/SnHbUyY/3PmyGongnEXNFHI8OH3k0CpFpZBntllJ1owcM6qt1GXTHaM5sWF8zmtPk+vWmtuah8kB6zn7RLuc1hw2R5MKDvoBb58E9XRQFNXFlhKf54AVxS2599gX6pMJIOXRuA9TO1VCWm8PAVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmAgbgm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B166C4CECD;
	Fri,  1 Nov 2024 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730461934;
	bh=57TfoCYTbEwQPkJzCSWfPWSdR5l5+Kvm1S5E2+Mg2eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KmAgbgm5I89HECc45z6DksI6Df2ImIw57iPYWvFdWioyuIg2lglcTgxjNnjfYfaHi
	 CQJ/wNz0lQyJsmyJoOvW4SkLL6WBjKX9ldFMDxnNCVh5pxlGUK2FlCdBWWX9WifFhK
	 YeYLtXId3O2e4dPfLvyd00mwkZ63RcOUuG9rhbthTm5vYa+SLjBtZAzi6WU5HW6EJo
	 Z7SL1PoIFDrZhyBb7WJzTKFtiiVP4wq0c0YWXwIaAurmX2E0DWKcu2TmuxOYeilZt9
	 j4R7qQGDlrizkruOpwX0zKtjhmMdWZOTbs5Uk29EXDETLovKzc8tW8fpXb4LIAHy0b
	 cBP/zcHBdmZgA==
Date: Fri, 1 Nov 2024 12:51:49 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: mcgrof@kernel.org, kees@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: add pid_max to pid_namespace
Message-ID: <4jlpjuptn5fzgrfgbct2l3dyerb3gnxwd3ujir4dodwkxivmxs@u7mptlgts2wq>
References: <20241030052933.1041408-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030052933.1041408-1-yun.zhou@windriver.com>

On Wed, Oct 30, 2024 at 01:29:33PM +0800, Yun Zhou wrote:
> It is necessary to have a different pid_max in different containers.
> For example, multiple containers are running on a host, one of which
> is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
> it requires the global pid_max <= 65535. This will cause configuration
> conflicts with other containers and also limit the maximum number of
> tasks for the entire system.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  include/linux/pid_namespace.h     |  1 +
>  kernel/pid.c                      | 12 +++++------
>  kernel/pid_namespace.c            | 35 ++++++++++++++++++++++++++-----
>  kernel/sysctl.c                   |  9 --------
>  kernel/trace/pid_list.c           |  2 +-
>  kernel/trace/trace.h              |  2 --
>  kernel/trace/trace_sched_switch.c |  2 +-
>  7 files changed, 39 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index f9f9931e02d6..064cfe2542fc 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -38,6 +38,7 @@ struct pid_namespace {
>  	struct ucounts *ucounts;
>  	int reboot;	/* group exit code if this pidns was rebooted */
>  	struct ns_common ns;
> +	int pid_max;
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	int memfd_noexec_scope;
>  #endif
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2715afb77eab..f8026a61436b 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -60,8 +60,6 @@ struct pid init_struct_pid = {
>  	}, }
>  };
>  
> -int pid_max = PID_MAX_DEFAULT;
> -
>  int pid_max_min = RESERVED_PIDS + 1;
>  int pid_max_max = PID_MAX_LIMIT;
>  /*
> @@ -78,6 +76,7 @@ static u64 pidfs_ino = RESERVED_PIDS;
>   */
>  struct pid_namespace init_pid_ns = {
>  	.ns.count = REFCOUNT_INIT(2),
> +	.pid_max = PID_MAX_DEFAULT,
>  	.idr = IDR_INIT(init_pid_ns.idr),
>  	.pid_allocated = PIDNS_ADDING,
>  	.level = 0,
> @@ -198,7 +197,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			tid = set_tid[ns->level - i];
>  
>  			retval = -EINVAL;
> -			if (tid < 1 || tid >= pid_max)
> +			if (tid < 1 || tid >= tmp->pid_max)
>  				goto out_free;
>  			/*
>  			 * Also fail if a PID != 1 is requested and
> @@ -238,7 +237,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>  			 * a partially initialized PID (see below).
>  			 */
>  			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
> -					      pid_max, GFP_ATOMIC);
> +					      tmp->pid_max, GFP_ATOMIC);
>  		}
>  		spin_unlock_irq(&pidmap_lock);
>  		idr_preload_end();
> @@ -653,11 +652,12 @@ void __init pid_idr_init(void)
>  	BUILD_BUG_ON(PID_MAX_LIMIT >= PIDNS_ADDING);
>  
>  	/* bump default and minimum pid_max based on number of cpus */
> -	pid_max = min(pid_max_max, max_t(int, pid_max,
> +	init_pid_ns.pid_max = min(pid_max_max, max_t(int, init_pid_ns.pid_max,
>  				PIDS_PER_CPU_DEFAULT * num_possible_cpus()));
>  	pid_max_min = max_t(int, pid_max_min,
>  				PIDS_PER_CPU_MIN * num_possible_cpus());
> -	pr_info("pid_max: default: %u minimum: %u\n", pid_max, pid_max_min);
> +	pr_info("pid_max: default: %u minimum: %u\n", init_pid_ns.pid_max,
> +			pid_max_min);
>  
>  	idr_init(&init_pid_ns.idr);
>  
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index d70ab49d5b4a..d8ddc0c56599 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -111,6 +111,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>  	ns->user_ns = get_user_ns(user_ns);
>  	ns->ucounts = ucounts;
>  	ns->pid_allocated = PIDNS_ADDING;
> +	ns->pid_max = parent_pid_ns->pid_max;
>  #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
>  	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
>  #endif
> @@ -280,19 +281,45 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
>  
>  	return ret;
>  }
> +#endif	/* CONFIG_CHECKPOINT_RESTORE */
> +
> +static int pid_max_ns_ctl_handler(const struct ctl_table *table, int write,
> +		void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct pid_namespace *pid_ns = task_active_pid_ns(current);
> +	struct ctl_table tmp = *table;
> +
> +	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
> +		return -EPERM;
> +
> +	tmp.data = &pid_ns->pid_max;
> +	if (pid_ns->parent)
> +		tmp.extra2 = &pid_ns->parent->pid_max;
> +
> +	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
> +}
>  
> -extern int pid_max;
>  static struct ctl_table pid_ns_ctl_table[] = {
> +#ifdef CONFIG_CHECKPOINT_RESTORE
>  	{
>  		.procname = "ns_last_pid",
>  		.maxlen = sizeof(int),
>  		.mode = 0666, /* permissions are checked in the handler */
>  		.proc_handler = pid_ns_ctl_handler,
>  		.extra1 = SYSCTL_ZERO,
> -		.extra2 = &pid_max,
> +		.extra2 = &init_pid_ns.pid_max,
>  	},
> -};
>  #endif	/* CONFIG_CHECKPOINT_RESTORE */
> +	{
> +		.procname = "pid_max",
> +		.maxlen = sizeof(int),
> +		.mode = 0644,
> +		.proc_handler = pid_max_ns_ctl_handler,
> +		.extra1 = &pid_max_min,
> +		.extra2 = &pid_max_max,
> +	},
> +	{ }
There is no longer any need for sentinels in ctl_table arrays. Please
remove this one for your next version.

Best

-- 

Joel Granados

