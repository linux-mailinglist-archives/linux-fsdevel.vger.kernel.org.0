Return-Path: <linux-fsdevel+bounces-31529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4C59982B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 11:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74383B2382B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6F1BD508;
	Thu, 10 Oct 2024 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfU4Jvf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F210E6;
	Thu, 10 Oct 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553595; cv=none; b=USKx4sYkbaalVaSw+qlvA1Y2zgAQW/IySWnJrK/Ut/EBt6zHJlVS0uzlIwdZlbaWSOXw7gs9ZMGYP1iOeNn6MrHBsZw08Sa334/RXgWzB/8eUF0tjA5pje4VCV49rC2ujZTp1q5bsdLXqI5Z9+x36Wq5yASd3OGoRxEnA6Ota/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553595; c=relaxed/simple;
	bh=XMlHzmAPhp5U50CFj4UxHeaXyAppl8Z1CNEa7V9Vey4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtwKqM8eOS9llqZU8WRWhOXRi9uQX7JfqNFa32V3DBGA3sbI4TMEb+oQVExMRg1Vxmpo3ICESUvBzQzoPdD6ocV20d7iii3Kx+vaT9HEtAogglKSEfijkU5xR84oa65mR6pDYFOug8jYrGQ4lskzkHsGO8ZWqUFOCBkPE6DEirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfU4Jvf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1437C4CEC6;
	Thu, 10 Oct 2024 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553595;
	bh=XMlHzmAPhp5U50CFj4UxHeaXyAppl8Z1CNEa7V9Vey4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IfU4Jvf43EBKfY0utFF2HsCd6xVmhrPx3/nhaiwjtzcqb7qr/jA1MuorKl1DED3Ds
	 ZR53/5aqo9XbbIOOKuThgAVLKqdGD+EE2tW10oo84YidGWlzee/6GOrm8hzX2Jn45X
	 gF4xh373m1VhUAKRz+BmXLsELLUZrA1PeGUeyhyJhMhSJNZYCzwoJaG/KBYU+XEFv+
	 JbLYgCKHK1D0ScszhT1KGh5i3F3eH4xsijvSkK9CHVvLgSPelZMW8SUcAg6gr/bydg
	 iSobToIcDfmBqdZSldGt5b+JJtxJ8t6m8u/hbdNRUH/Zr1a0zMlnAQy510qjSJXMzK
	 KcSzrQOkBE/qQ==
Date: Thu, 10 Oct 2024 11:46:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: luca.boccassi@gmail.com, linux-fsdevel@vger.kernel.org, 
	christian@brauner.io, linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: Re: [PATCH v9] pidfd: add ioctl to retrieve pid info
Message-ID: <20241010-ersuchen-mitlaufen-e836113886c7@brauner>
References: <20241008121930.869054-1-luca.boccassi@gmail.com>
 <20241009.202933-chewy.sheen.spooky.icons-4WcDot1Idx9@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009.202933-chewy.sheen.spooky.icons-4WcDot1Idx9@cyphar.com>

On Thu, Oct 10, 2024 at 07:50:36AM +1100, Aleksa Sarai wrote:
> On 2024-10-08, luca.boccassi@gmail.com <luca.boccassi@gmail.com> wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> > 
> > A common pattern when using pid fds is having to get information
> > about the process, which currently requires /proc being mounted,
> > resolving the fd to a pid, and then do manual string parsing of
> > /proc/N/status and friends. This needs to be reimplemented over
> > and over in all userspace projects (e.g.: I have reimplemented
> > resolving in systemd, dbus, dbus-daemon, polkit so far), and
> > requires additional care in checking that the fd is still valid
> > after having parsed the data, to avoid races.
> > 
> > Having a programmatic API that can be used directly removes all
> > these requirements, including having /proc mounted.
> > 
> > As discussed at LPC24, add an ioctl with an extensible struct
> > so that more parameters can be added later if needed. Start with
> > returning pid/tgid/ppid and creds unconditionally, and cgroupid
> > optionally.
> > 
> > Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> > ---
> > v9: drop result_mask and reuse request_mask instead
> > v8: use RAII guard for rcu, call put_cred()
> > v7: fix RCU issue and style issue introduced by v6 found by reviewer
> > v6: use rcu_read_lock() when fetching cgroupid, use task_ppid_nr_ns() to
> >     get the ppid, return ESCHR if any of pid/tgid/ppid are 0 at the end
> >     of the call to avoid providing incomplete data, document what the
> >     callers should expect
> > v5: check again that the task hasn't exited immediately before copying
> >     the result out to userspace, to ensure we are not returning stale data
> >     add an ifdef around the cgroup structs usage to fix build errors when
> >     the feature is disabled
> > v4: fix arg check in pidfd_ioctl() by moving it after the new call
> > v3: switch from pid_vnr() to task_pid_vnr()
> > v2: Apply comments from Christian, apart from the one about pid namespaces
> >     as I need additional hints on how to implement it.
> >     Drop the security_context string as it is not the appropriate
> >     metadata to give userspace these days.
> > 
> >  fs/pidfs.c                                    | 88 ++++++++++++++++++-
> >  include/uapi/linux/pidfd.h                    | 30 +++++++
> >  .../testing/selftests/pidfd/pidfd_open_test.c | 80 ++++++++++++++++-
> >  3 files changed, 194 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/pidfs.c b/fs/pidfs.c
> > index 80675b6bf884..15cdc7fe4968 100644
> > --- a/fs/pidfs.c
> > +++ b/fs/pidfs.c
> > @@ -2,6 +2,7 @@
> >  #include <linux/anon_inodes.h>
> >  #include <linux/file.h>
> >  #include <linux/fs.h>
> > +#include <linux/cgroup.h>
> >  #include <linux/magic.h>
> >  #include <linux/mount.h>
> >  #include <linux/pid.h>
> > @@ -114,6 +115,83 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
> >  	return poll_flags;
> >  }
> >  
> > +static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
> > +	size_t usize = _IOC_SIZE(cmd);
> > +	struct pidfd_info kinfo = {};
> > +	struct user_namespace *user_ns;
> > +	const struct cred *c;
> > +	__u64 request_mask;
> > +
> > +	if (!uinfo)
> > +		return -EINVAL;
> > +	if (usize < sizeof(struct pidfd_info))
> > +		return -EINVAL; /* First version, no smaller struct possible */
> > +
> > +	if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> > +		return -EFAULT;
> > +
> > +	c = get_task_cred(task);
> > +	if (!c)
> > +		return -ESRCH;
> > +
> > +	/* Unconditionally return identifiers and credentials, the rest only on request */
> > +
> > +	user_ns = current_user_ns();
> > +	kinfo.ruid = from_kuid_munged(user_ns, c->uid);
> > +	kinfo.rgid = from_kgid_munged(user_ns, c->gid);
> > +	kinfo.euid = from_kuid_munged(user_ns, c->euid);
> > +	kinfo.egid = from_kgid_munged(user_ns, c->egid);
> > +	kinfo.suid = from_kuid_munged(user_ns, c->suid);
> > +	kinfo.sgid = from_kgid_munged(user_ns, c->sgid);
> > +	kinfo.fsuid = from_kuid_munged(user_ns, c->fsuid);
> > +	kinfo.fsgid = from_kgid_munged(user_ns, c->fsgid);
> > +	put_cred(c);
> > +
> > +#ifdef CONFIG_CGROUPS
> > +	if (request_mask & PIDFD_INFO_CGROUPID) {
> > +		struct cgroup *cgrp;
> > +
> > +		guard(rcu)();
> > +		cgrp = task_cgroup(task, pids_cgrp_id);
> > +		if (!cgrp)
> > +			return -ENODEV;
> > +		kinfo.cgroupid = cgroup_id(cgrp);
> > +
> > +		kinfo.request_mask |= PIDFD_INFO_CGROUPID;
> > +	}
> > +#endif
> > +
> > +	/*
> > +	 * Copy pid/tgid last, to reduce the chances the information might be
> > +	 * stale. Note that it is not possible to ensure it will be valid as the
> > +	 * task might return as soon as the copy_to_user finishes, but that's ok
> > +	 * and userspace expects that might happen and can act accordingly, so
> > +	 * this is just best-effort. What we can do however is checking that all
> > +	 * the fields are set correctly, or return ESRCH to avoid providing
> > +	 * incomplete information. */
> > +
> > +	kinfo.ppid = task_ppid_nr_ns(task, NULL);
> > +	kinfo.tgid = task_tgid_vnr(task);
> > +	kinfo.pid = task_pid_vnr(task);
> > +
> > +	if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
> > +		return -ESRCH;
> > +
> > +	/*
> > +	 * If userspace and the kernel have the same struct size it can just
> > +	 * be copied. If userspace provides an older struct, only the bits that
> > +	 * userspace knows about will be copied. If userspace provides a new
> > +	 * struct, only the bits that the kernel knows about will be copied and
> > +	 * the size value will be set to the size the kernel knows about.
> > +	 */
> > +	if (copy_to_user(uinfo, &kinfo, min(usize, sizeof(kinfo))))
> > +		return -EFAULT;
> 
> If usize > ksize, we also want to clear_user() the trailing bytes to
> avoid userspace thinking that any garbage bytes they had are valid.
> 
> Also, you mention "the size value" but there is no size in pidfd_info. I
> don't think it's actually necessary to include such a field (especially
> when you have a statx-like request_mask), but it means you really should
> clear the trailing bytes to avoid userspace bugs.
> 
> I implemented all of these semantics as copy_struct_to_user() in the
> CHECK_FIELDS patch I sent a few weeks ago (I just sent v3[1]). Maybe you
> can cherry-pick this patch and use it? The semantics when we extend this
> pidfd_info to accept new request_mask values with larger structures is
> going to get a little ugly and copy_struct_to_user() makes this a little
> easier to deal with.
> 
> [1]: https://lore.kernel.org/all/20241010-extensible-structs-check_fields-v3-1-d2833dfe6edd@cyphar.com/

I agree. @Luca, you can either send the two patches together or I can
just port the patch to it. I don't mind.

> 
> > +
> > +	return 0;
> > +}
> > +
> >  static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  {
> >  	struct task_struct *task __free(put_task) = NULL;
> > @@ -122,13 +200,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> >  	struct ns_common *ns_common = NULL;
> >  	struct pid_namespace *pid_ns;
> >  
> > -	if (arg)
> > -		return -EINVAL;
> > -
> >  	task = get_pid_task(pid, PIDTYPE_PID);
> >  	if (!task)
> >  		return -ESRCH;
> >  
> > +	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
> > +	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
> > +		return pidfd_info(task, cmd, arg);
> > +
> > +	if (arg)
> > +		return -EINVAL;
> > +
> >  	scoped_guard(task_lock, task) {
> >  		nsp = task->nsproxy;
> >  		if (nsp)
> > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > index 565fc0629fff..d685eeeedc51 100644
> > --- a/include/uapi/linux/pidfd.h
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -16,6 +16,35 @@
> >  #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
> >  #define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
> >  
> > +/* Flags for pidfd_info. */
> > +#define PIDFD_INFO_CGROUPID		(1UL << 0)
> 
> While it isn't strictly necessary, maybe we should provide some
> always-set bits like statx does? While they would always be set, it

Yes, good idea.

> might incentivise programs to write code that checks if the request_mask
> bits are set after the ioctl(2) returns from the outset. Then again,
> PIDFD_INFO_CGROUPID is probably enough to justify writing code correctly
> from the outset.
> 
> > +
> > +struct pidfd_info {
> > +	/* Let userspace request expensive stuff explictly, and let the kernel
> > +	 * indicate whether it knows about it. */
> 
> I would prefer a slightly more informative comment (which mentions that
> this will also be used for extensibility), something like:
> 
> 
> /*
>  * This mask is similar to the request_mask in statx(2).
>  *
>  * Userspace indicates what extensions or expensive-to-calculate fields
>  * they want by setting the corresponding bits in request_mask.
>  *
>  * When filling the structure, the kernel will only set bits
>  * corresponding to the fields that were actually filled by the kernel.
>  * This also includes any future extensions that might be automatically
>  * filled. If the structure size is too small to contain a field
>  * (requested or not), to avoid confusion the request_mask will not
>  * contain a bit for that field.
>  *
>  * As such, userspace MUST verify that request_mask contains the
>  * corresponding flags after the ioctl(2) returns to ensure that it is
>  * using valid data.
>  */

I agree. This is a good comment.

