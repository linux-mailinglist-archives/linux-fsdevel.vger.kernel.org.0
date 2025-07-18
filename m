Return-Path: <linux-fsdevel+bounces-55426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F35CB0A3FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 14:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830171899819
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F9C29CB40;
	Fri, 18 Jul 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="XBDUtXGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246517BB6;
	Fri, 18 Jul 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841086; cv=none; b=l1kgxJtRG1NHVhbK4RDeZ3iDtSZ0DJY0+Lsj2qynNc1CpT3Ru7IiIVBILoG8zs9Ij/QGAxLMOV9D7x+PUMRDrD7bz0DWqkTAkRjf7ENtUNcGTj7XSPFWOyH+5n0Bf2B/byAgeW9FCpKBQeZMESfGYFVKH6wD23FapAhDd4w2/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841086; c=relaxed/simple;
	bh=hWOZ5rGhEnOPNj6yZDDj7L2cBQlG1VDSSdDZuRuX/IM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIpER4k9ZlqpzJ5Wl3FaU3Y1U20GXBrjSSRFGD2scsPJg0E9H/fgWFyY9i1NURITgkNPaRrwTqpjI5mQuf1/sUPaDqhs8aZvPu0xawO6L3mY2oKH7mzdUUk/CWy9DKmUt0RrfMtTYRzLa7PFD7Qxo/KR5MnOz3T+cedm+fpB1bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=XBDUtXGG; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c8zOjRoJ+GDoM9sJJsiKdCSL52AgaT4ltSuWMazTsbU=; b=XBDUtXGGSolTZM0c/Qwya9lxwQ
	o7ySFKi8yQuyHvC8H14UAh0SJsG9NrIXV3bjg+XcZ3G8MER2TltGhN925yOhEZk6WwnImQ5O1dQaM
	0VIC7tuoELqcnZq5BsElxOTtsHmH+I2GvNYj+/DExTvvECIX4nk4M9JvU1tThlj3W1MWcf6s0MsuN
	IfnC/6hb+0Uadul0ai7JOmr+EbgqEvvTIFpmw21JXXnQrgkw0UarYo/q+DpreInKL5zj2/AkJN50D
	Rw1OKZcPE8Vvth+OqG4IAdtCruAAF4svkPvpR01zxxonF/Yu4r6NdWTbYBcXk8cBW7Tjok9/h5dRL
	zr+Ratzg==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:18092 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1uck2L-0000000CGBQ-1j2c;
	Fri, 18 Jul 2025 14:18:01 +0200
Date: Fri, 18 Jul 2025 14:17:56 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vasiliy Kulikov <segooon@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
Message-ID: <nbmfwdm45z3com6bdo62hac6c3kz4aerjcargsjjeacr4xrajn@4dkrpr45h34w>
References: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
 <20250718.091233-bored.chainsaw.organic.pose-0SJBoWYaT8s@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718.091233-bored.chainsaw.organic.pose-0SJBoWYaT8s@cyphar.com>
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

Hi Aleksa,

Thanks for your reply !

On Fri, Jul 18, 2025 at 07:36:37PM +1000, Aleksa Sarai wrote:
> On 2025-07-18, nicolas.bouchinet@oss.cyber.gouv.fr <nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
> > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > The hidepid mount option documentation defines the following modes:
> > 
> > - "noaccess": user may not access any `/proc/<pid>/ directories but
> >   their own.
> > - "invisible": all `/proc/<pid>/` will be fully invisible to other users.
> > - "ptraceable": means that procfs should only contain `/proc/<pid>/`
> >   directories that the caller can ptrace.
> > 
> > We thus expect that with "noaccess" and "invisible" users would be able to
> > see their own processes in `/proc/<pid>/`.
> > 
> > The implementation of hidepid however control accesses using the
> > `ptrace_may_access()` function in any cases. Thus, if a process set
> > itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
> > SUID_DUMP_DISABLE)` it becomes invisible to the user.
> 
> In my view, the documentation is wrong here. This behaviour has remained
> effectively unchanged since it was introduced in 0499680a4214 ("procfs:
> add hidepid= and gid= mount options"), and the documentation was written
> by the same author (added to Cc, though they appear to be inactive since
> 2013). hidepid=ptraceable was added many years later, and so the current
> documentation seeming somewhat contradictory is probably more a result
> of a new feature being documented without rewriting the old
> documentation, rather than an incorrect implementation.

I'll change the documentation to match what it really does.
> 
> A process marking itself with SUID_DUMP_DISABLE is a *very* strong
> signal that other processes (even processes owned by the same user) must
> have very restricted access to it. Given how many times they have been
> instrumental for protecting against attacks, I am quite hesitant about
> making changes to loosen these restrictions.
> 
> For instance, container runtimes need to set SUID_DUMP_DISABLE to avoid
> all sorts of breakout attacks (CVE-2016-9962 and CVE-2019-5736 being the
> most famous examples, but there are plenty of others). If a container
> has been configured with a restrictive hidepid, I would expect the
> kernel to block most attempts to interact with such a process to
> non-privileged users. But this patch would loosen said restrictions.
> 
> Now, many of the bits in /proc/self/* are additionally gated behind
> ptrace_may_access() checks, so this kind of change might be less
> catastrophic than at first glance, but the original concerns that
> motivated hidepid= were about /proc/self/cmdline and the uid/euid of
> processes being discoverable, and AFAICS this patch still undoes those
> protections for the cases we care about with SUID_DUMP_DISABLE.
> 
> What motivated you to want to change this behaviour?
> 

Well, the change is motivated by two things, the first one is the fact
that the only difference between ("noaccess", "invisible") and
"ptraceable" is the verification of the "gid" hidepid parameter. Thus,
in anyway it means that only ptraceable process can be seen. 

The second motivation is that the "ptraceable" mode didn't worked with
the yama LSM, which doesn't care about `PTRACE_MODE_READ_FSCREDS` trace
mode. Thus, using hidepid "ptraceable" mode with yama "restricted",
"admin-only" or "no attach" modes doesn't do much.

I have submited a fix to yama [1] in order to make it take into account
`PTRACE_MODE_READ_FSCREDS` traces. With this yama patch, any hidepid
modes would have been affected by yama decision even though the hidepid
documentation claim that processes belonging to users are visible.

The combination of the two patches thus makes the "ptraceable" hidepid
mode work with yama without locking "noaccess" and "invisible" modes.

With hidepid "ptraceable" mode, `SUID_DUMP_DISABLE` process would be
invisible to the user.

[1]: https://lore.kernel.org/all/cf43bc15-e42d-4fde-a2b7-4fe832e177a8@oss.cyber.gouv.fr/

> > This patch fixes the `has_pid_permissions()` function in order to make
> > its behavior to match the documentation.
> > 
> > Note that since `ptrace_may_access()` is not called anymore with
> > "noaccess" and "invisible", the `security_ptrace_access_check()` will no
> > longer be called either.
> > 
> > Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > ---
> >  fs/proc/base.c | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/proc/base.c b/fs/proc/base.c
> > index c667702dc69b8ca2531e88e12ed7a18533f294dd..fb128cb5f95fe65016fce96c75aee18c762a30f2 100644
> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -746,9 +746,12 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
> >  				 struct task_struct *task,
> >  				 enum proc_hidepid hide_pid_min)
> >  {
> > +	const struct cred *cred = current_cred(), *tcred;
> > +	kuid_t caller_uid;
> > +	kgid_t caller_gid;
> >  	/*
> > -	 * If 'hidpid' mount option is set force a ptrace check,
> > -	 * we indicate that we are using a filesystem syscall
> > +	 * If 'hidepid=ptraceable' mount option is set, force a ptrace check.
> > +	 * We indicate that we are using a filesystem syscall
> >  	 * by passing PTRACE_MODE_READ_FSCREDS
> >  	 */
> >  	if (fs_info->hide_pid == HIDEPID_NOT_PTRACEABLE)
> > @@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
> >  		return true;
> >  	if (in_group_p(fs_info->pid_gid))
> >  		return true;
> > -	return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> > +
> > +	task_lock(task);
> > +	rcu_read_lock();
> > +	caller_uid = cred->fsuid;
> > +	caller_gid = cred->fsgid;
> > +	tcred = __task_cred(task);
> > +	if (uid_eq(caller_uid, tcred->euid) &&
> > +	    uid_eq(caller_uid, tcred->suid) &&
> > +	    uid_eq(caller_uid, tcred->uid)  &&
> > +	    gid_eq(caller_gid, tcred->egid) &&
> > +	    gid_eq(caller_gid, tcred->sgid) &&
> > +	    gid_eq(caller_gid, tcred->gid)) {
> > +		rcu_read_unlock();
> > +		task_unlock(task);
> > +		return true;
> > +	}
> > +	rcu_read_unlock();
> > +	task_unlock(task);
> > +	return false;
> 
> At the very least, this check needs to be gated based on
> ns_capable(get_task_mm(task)->user_ns, CAP_SYS_PTRACE), to avoid
> containers from being able to introspect SUID_DUMP_DISABLE processes
> (such as container runtimes) in the process of joining a user namespaced
> container.
> 

IIUC, you want to hide non-dumpable processes joining other user
namespaces to avoid the data exposition of the non-dumpable process in
`/proc/<pid>/*` ?

Like whats is done in `__ptrace_may_access()` :

```C
mm = task->mm;
if (mm &&
    ((get_dumpable(mm) != SUID_DUMP_USER) &&
     !ptrace_has_cap(mm->user_ns, mode)))
```

> >  }
> >  
> >  
> > 
> > ---
> > base-commit: 884a80cc9208ce75831b2376f2b0464018d7f2c4
> > change-id: 20250718-hidepid_fix-d0743d0540e7
> > 
> > Best regards,
> > -- 
> > Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > 
> > 
> 
> -- 
> Aleksa Sarai
> Senior Software Engineer (Containers)
> SUSE Linux GmbH
> https://www.cyphar.com/



