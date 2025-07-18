Return-Path: <linux-fsdevel+bounces-55413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C51B09E84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146D71C40A54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482E294A03;
	Fri, 18 Jul 2025 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="DYdK6WHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC45A10A1E;
	Fri, 18 Jul 2025 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752829183; cv=none; b=DtSEQM3RMMozxta8YNuiTcFx+RUHWHNPw3+4G0orRu7TqbcEti2xo5pUu+2xbRigxcUJr3jwbVfzgs34cBSF5kaXZoUkdy9Mot+uDXEb7h5qWMKxg9YhsnygKbebwL3fFyAXKVlnxjXH4wZ0I6jzgQJLchTCYhf7/OZxgrHn0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752829183; c=relaxed/simple;
	bh=HYpaiqIEyB8Kv9VQ8/iWq0NmXUMdjmUOhDyBc9IIF5g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VVYie/Y47vmAdDgPyrqo+Iumx9e0ubCYL6LYqauDYwD8d9KxlUPGt4lz/iRo7v4x1vwR/9yvdbvW083MXemY+2h7vGoDPEc3lscd/z0f1iQXKMAmHHcdsnHyeXIrjxv4e7EKB/wXLUx1mGpHNZVU1dMF4AE6vLJ03LCpK6NXN1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=DYdK6WHU; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MmcKwWzvN1r4z9wBLfrzobSduXZfq61jhEwbVlKe2Yw=; b=DYdK6WHUVpAgdw6+L68P3SOXjS
	Ho084KKmuCd3+awwKVLHKxLCAMmhR3fKrjPaJqHSWhxqU3sAzunYwv+E9SpIbLTl58WRMvsQwrCFh
	F9qh2VyN4W1ISVzr3maU0SWC+tBN7VwEbEgjauYC+Ah2bT0EqulQYFrtG76PQMteCzu50IsL3919P
	AOCWaGodMv1Aaj3Mm0tN9ltSAPDcAoXag4QjaVprWtHT4tYV8ZFqMoXbuutK0PXkM47AoIsiHedpR
	29r/pbQO586LYkHzmtX1Tp55KgCG5VweQxuQNDaBhb8hkHYmNG0zECfRPRj/bmsNxegfQNPoWQdnZ
	h3OH8YNw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:58054 helo=[10.224.8.110])
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ucgwN-0000000A5PQ-3bMd;
	Fri, 18 Jul 2025 10:59:40 +0200
Message-ID: <11c531fb-7c51-423f-bf75-ffa13b2039f1@oss.cyber.gouv.fr>
Date: Fri, 18 Jul 2025 10:59:39 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>,
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
References: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
Content-Language: en-US
In-Reply-To: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Note that a yama patch has also been sent [1].

[1]: 
https://lore.kernel.org/all/20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr/

Best regards,

Nicolas

On 7/18/25 10:47, nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>
> The hidepid mount option documentation defines the following modes:
>
> - "noaccess": user may not access any `/proc/<pid>/ directories but
>    their own.
> - "invisible": all `/proc/<pid>/` will be fully invisible to other users.
> - "ptraceable": means that procfs should only contain `/proc/<pid>/`
>    directories that the caller can ptrace.
>
> We thus expect that with "noaccess" and "invisible" users would be able to
> see their own processes in `/proc/<pid>/`.
>
> The implementation of hidepid however control accesses using the
> `ptrace_may_access()` function in any cases. Thus, if a process set
> itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
> SUID_DUMP_DISABLE)` it becomes invisible to the user.
>
> This patch fixes the `has_pid_permissions()` function in order to make
> its behavior to match the documentation.
>
> Note that since `ptrace_may_access()` is not called anymore with
> "noaccess" and "invisible", the `security_ptrace_access_check()` will no
> longer be called either.
>
> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> ---
>   fs/proc/base.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index c667702dc69b8ca2531e88e12ed7a18533f294dd..fb128cb5f95fe65016fce96c75aee18c762a30f2 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -746,9 +746,12 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
>   				 struct task_struct *task,
>   				 enum proc_hidepid hide_pid_min)
>   {
> +	const struct cred *cred = current_cred(), *tcred;
> +	kuid_t caller_uid;
> +	kgid_t caller_gid;
>   	/*
> -	 * If 'hidpid' mount option is set force a ptrace check,
> -	 * we indicate that we are using a filesystem syscall
> +	 * If 'hidepid=ptraceable' mount option is set, force a ptrace check.
> +	 * We indicate that we are using a filesystem syscall
>   	 * by passing PTRACE_MODE_READ_FSCREDS
>   	 */
>   	if (fs_info->hide_pid == HIDEPID_NOT_PTRACEABLE)
> @@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
>   		return true;
>   	if (in_group_p(fs_info->pid_gid))
>   		return true;
> -	return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> +
> +	task_lock(task);
> +	rcu_read_lock();
> +	caller_uid = cred->fsuid;
> +	caller_gid = cred->fsgid;
> +	tcred = __task_cred(task);
> +	if (uid_eq(caller_uid, tcred->euid) &&
> +	    uid_eq(caller_uid, tcred->suid) &&
> +	    uid_eq(caller_uid, tcred->uid)  &&
> +	    gid_eq(caller_gid, tcred->egid) &&
> +	    gid_eq(caller_gid, tcred->sgid) &&
> +	    gid_eq(caller_gid, tcred->gid)) {
> +		rcu_read_unlock();
> +		task_unlock(task);
> +		return true;
> +	}
> +	rcu_read_unlock();
> +	task_unlock(task);
> +	return false;
>   }
>   
>   
>
> ---
> base-commit: 884a80cc9208ce75831b2376f2b0464018d7f2c4
> change-id: 20250718-hidepid_fix-d0743d0540e7
>
> Best regards,

