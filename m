Return-Path: <linux-fsdevel+bounces-35180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76689D2246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712771F23A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405519C54F;
	Tue, 19 Nov 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjYsJbcF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE63A1A705C;
	Tue, 19 Nov 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007747; cv=none; b=WP9+3V+8qIDMmS5okMZTziYzyXSe91JW0lFRgcnB1K2KX2lsE2DzdCBsBJxwxbGHuNDf4QTte1ueXvn6DyTUshuL4IaVewpAMDiLLclYDN+ZqLXuUYgYlVvAzeNew/9ofbsK6st8aWei5skCb0pFCJWk2Pt+QVPFcNWfyrKe/GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007747; c=relaxed/simple;
	bh=oa+5Z+lKKCnT7yMebAYTxw8LIXAWKYOq1hVC+/GN+rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezoagymQ4QTJb+JcER6VkRz4mfSdrn3sJaImwMD/19KFj4e4KN1XJ2B0QMc5gbpcHp2i9pjt5hHcrXChcRNyvWgdgFIgTN5rU+fhoZ3Oe604fToYOfTp8xiW8YfbHt40+Sl6Ur+QvOgcCIAlHzPAA8JkbxequBAZ0s9rBGKbtVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjYsJbcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C0AC4CECF;
	Tue, 19 Nov 2024 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732007747;
	bh=oa+5Z+lKKCnT7yMebAYTxw8LIXAWKYOq1hVC+/GN+rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjYsJbcFQTguOHpzEZCAiBNPjf3fEgjtDg6j8smxmzdxHjodF5phxaLOXf0eCGyNM
	 U+B0NTL3MxcekUE60RiPjXafXWnBzGenN7x5b4swkPuEFsmShCli32v4Z/JFhmfK7U
	 jswuY1Y1LHfa/HKbyvzTjgeQeuoutylE4I7KrBhgmgchkV83M/tluEhqfpi3SpPpQj
	 mv5RRz1fVykGIZ2eKQxYS5KRR0IH74Kp1Na2UHYGUtExK9FR4J96w6Yt7iFAHmLYiQ
	 fwSgG6U15djo9i+032g5TjH7c7cT/8QIwasDvoouuuSmyrY40Doy3PWlN/evVhA7dU
	 PBiJz4xUTpC2A==
Date: Tue, 19 Nov 2024 10:15:28 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: mcgrof@kernel.org, kees@kernel.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: add pid_max to pid_namespace
Message-ID: <izvhvfnq6jwgl7uxccls4sckykw2wjx3utaecijcya5em53h6w@lupiu7ok5mrk>
References: <20241105031024.3866383-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105031024.3866383-1-yun.zhou@windriver.com>

On Tue, Nov 05, 2024 at 11:10:24AM +0800, Yun Zhou wrote:
> It is necessary to have a different pid_max in different containers.
> For example, multiple containers are running on a host, one of which
> is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
> it requires the global pid_max <= 65535. This will cause configuration
> conflicts with other containers and also limit the maximum number of
> tasks for the entire system.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>  - Remove sentinels from ctl_table arrays.
> v1 - https://lore.kernel.org/all/20241030052933.1041408-1-yun.zhou@windriver.com/
> ---
>  include/linux/pid_namespace.h     |  1 +
>  kernel/pid.c                      | 12 +++++------
>  kernel/pid_namespace.c            | 34 ++++++++++++++++++++++++++-----
>  kernel/sysctl.c                   |  9 --------
>  kernel/trace/pid_list.c           |  2 +-
>  kernel/trace/trace.h              |  2 --
>  kernel/trace/trace_sched_switch.c |  2 +-
>  7 files changed, 38 insertions(+), 24 deletions(-)

...

> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index d70ab49d5b4a..a5a8254825d5 100644
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
> @@ -280,19 +281,44 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
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
> +};

I see here that the sysctls are without sentinel.
Reviewed-by: Joel Granados <joel.granados@kernel.org>


-- 

Joel Granados

