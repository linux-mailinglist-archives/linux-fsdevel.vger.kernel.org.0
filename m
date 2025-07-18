Return-Path: <linux-fsdevel+bounces-55440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140EEB0A7E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675DF163359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3CE2E54C7;
	Fri, 18 Jul 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="C3hQSdMd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21B12E543F;
	Fri, 18 Jul 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853649; cv=none; b=rqi3eG7jbgTGQF3/YYeluotqbRzaUE7j6amItRSG9x5yKkPp45SN12SJSK13xQKVTXCfVMTatSzGyMod1DUbYboNfQuyNYf7UIKxT/BJgrJscC4Ez8OF824GdPVrIAzA2WekWu5TeppenB3dfQ0tBQ/3nlTJTbpXQY3RT+SIxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853649; c=relaxed/simple;
	bh=ZL2UL1jpJNZV6mimL9AkHVVjb0VMAL22MvVUtj3RRM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEqKsjZI3sn0y8uZyBTO0NhGI4uFZ+mXSDaFrf5a/1UFQgTfX9e0L4Oc10CdpxkY0HL7DEBLNGDpjp8wOtYhwoQ8QiEWxWAnQGgQod4IgWSmPfZ2AD4qTP/7AXvlKb7LRpRWVzMJNI8A8QaqBhXx/ocfvdcg4MrBcMlWzgNMidU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=C3hQSdMd; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6uCduAFQy2A/XaBNHyMlv/xYIuNGF4Gt9KFVrYEhslU=; b=C3hQSdMdBTG/4toEf34YAhJ1Sn
	xeVDGrJNfh0StRa5kYK9I9bolqXosoCaXiRVOKKHw6pOKePolxlj/Lzg7EgtTMMMqqM7e8lcriWfU
	a7i2/AANNZkiSjsJYfTPrT0RMvVFiV8TkzWwkWSacQKlPEaPDMA1KWya9+Zzj0p1NuXqecuSqRVoS
	sA+AOvXQOZcW/j+9oUiPlvoRixFlglQYCMua+JtV86WixoFTP5HG7CcfEDDJ+Seoxw7s1uJvdoNQ+
	XcpmcNW6cV9s38fs/j5gzOxlRfMy+HUS+woKC6/NrzJF8oEQN2tHiQVUA+BMF6lThoHj1ruzvMXAf
	QS/44UbA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:28224 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ucnIs-0000000EIkY-3muy;
	Fri, 18 Jul 2025 17:47:19 +0200
Date: Fri, 18 Jul 2025 17:47:14 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Jann Horn <jannh@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Subject: Re: [PATCH] fs: hidepid: Fixes hidepid non dumpable behavior
Message-ID: <s7no7daeq6nmkwrf5w63srpmxzzqk5uor2kxdvrvrskoahh7un@h6kubn7qxli2>
References: <20250718-hidepid_fix-v1-1-3fd5566980bc@ssi.gouv.fr>
 <CAG48ez3u09TK=Ju3xdEKzKuM_-sO_y9150NBx3Drs8T1G-V9AQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3u09TK=Ju3xdEKzKuM_-sO_y9150NBx3Drs8T1G-V9AQ@mail.gmail.com>
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

Hi Jann, thanks for your review !

On Fri, Jul 18, 2025 at 04:45:15PM +0200, Jann Horn wrote:
> On Fri, Jul 18, 2025 at 10:47 AM <nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
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
> 
> "their own" is very fuzzy and could be interpreted many ways.
> 
> > The implementation of hidepid however control accesses using the
> > `ptrace_may_access()` function in any cases. Thus, if a process set
> > itself as non-dumpable using the `prctl(PR_SET_DUMPABLE,
> > SUID_DUMP_DISABLE)` it becomes invisible to the user.
> 
> As Aleksa said, a non-dumpable processes is essentially like a setuid
> process (even if its UIDs match yours, it may have some remaining
> special privileges you don't have), so it's not really "your own".
> 

Also replying to  :

> What's the background here - do you have a specific usecase that
> motivated this patch?

The case I encountered is using the zathura-sandbox pdf viewer which
sandboxes itself with Landlock and set itself as non-dumpable.
If my PDF viewer freezes and I want to kill it as an unprivileged user,
I'm not able to get its PID from `/proc` since its fully invisible to my
user.

> > This patch fixes the `has_pid_permissions()` function in order to make
> > its behavior to match the documentation.
> 
> I don't think "it doesn't match the documentation" is good enough
> reason to change how the kernel works.
> 
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
> >                                  struct task_struct *task,
> >                                  enum proc_hidepid hide_pid_min)
> >  {
> > +       const struct cred *cred = current_cred(), *tcred;
> > +       kuid_t caller_uid;
> > +       kgid_t caller_gid;
> >         /*
> > -        * If 'hidpid' mount option is set force a ptrace check,
> > -        * we indicate that we are using a filesystem syscall
> > +        * If 'hidepid=ptraceable' mount option is set, force a ptrace check.
> > +        * We indicate that we are using a filesystem syscall
> >          * by passing PTRACE_MODE_READ_FSCREDS
> >          */
> >         if (fs_info->hide_pid == HIDEPID_NOT_PTRACEABLE)
> > @@ -758,7 +761,25 @@ static bool has_pid_permissions(struct proc_fs_info *fs_info,
> >                 return true;
> >         if (in_group_p(fs_info->pid_gid))
> >                 return true;
> > -       return ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
> > +
> > +       task_lock(task);
> > +       rcu_read_lock();
> > +       caller_uid = cred->fsuid;
> > +       caller_gid = cred->fsgid;
> > +       tcred = __task_cred(task);
> > +       if (uid_eq(caller_uid, tcred->euid) &&
> > +           uid_eq(caller_uid, tcred->suid) &&
> > +           uid_eq(caller_uid, tcred->uid)  &&
> > +           gid_eq(caller_gid, tcred->egid) &&
> > +           gid_eq(caller_gid, tcred->sgid) &&
> > +           gid_eq(caller_gid, tcred->gid)) {
> > +               rcu_read_unlock();
> > +               task_unlock(task);
> > +               return true;
> > +       }
> > +       rcu_read_unlock();
> > +       task_unlock(task);
> > +       return false;
> >  }
> 
> I think this is a bad idea for several reasons:
> 
> 1. It duplicates existing logic.
I open to work on that.

> 2. I think it prevents a process with euid!=ruid from introspecting
> itself through procfs.
Great question, I'll test that and write some hidepid tests to check that.

> 3. I think it prevents root from viewing all processes through procfs.
Yes only if combined with yama="no attach", and IMHO, that would make sense.

> 4. It allows processes to view metadata about each other when that was
> previously blocked by the combination of hidepid and an LSM such as
> Landlock or SELinux.
Arf, you're absolutely right about this, my bad.

> 5. It ignores capabilities held by the introspected process but not
> the process doing the introspection (which is currently checked by
> cap_ptrace_access_check()).
As suggested by Aleksa, I can add some capabilities checks here.

> 
> What's the background here - do you have a specific usecase that
> motivated this patch?

The second motivation is that the "ptraceable" mode didn't worked with
the yama LSM, which doesn't care about `PTRACE_MODE_READ_FSCREDS` trace
mode. Thus, using hidepid "ptraceable" mode with yama "restricted",
"admin-only" or "no attach" modes doesn't do much.

As you have seen, I also have submited a fix to yama in order to make it
take into account `PTRACE_MODE_READ_FSCREDS` traces.

I have to admit I'm not really found of the fact that those two patch
are so tightly linked.

Thanks again for your review,

Nicolas

