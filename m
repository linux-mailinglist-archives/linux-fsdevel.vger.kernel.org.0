Return-Path: <linux-fsdevel+bounces-30950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A60198FFBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 11:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CCF283FC6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9CD148301;
	Fri,  4 Oct 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMRWikhe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5799F140E50;
	Fri,  4 Oct 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034178; cv=none; b=i3IFABTHKI7JtFBvOjrHAU1Igy63sY3Hebk9Xcco+15Rmj5HuVIwxQ7MeUfzWe6QYYYgGeyx3xgWhK0v/uhNB3ETFEEoYblhwFSmBVE6PZKeKW9FkHLaqBU/t+T8oU6ayEWu0F3WON/MHQvElhl2Nmm1okTAF12KL2wJmcLvIRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034178; c=relaxed/simple;
	bh=sSOW92oXxy45FOYQ7xw3zpICaVbOfCtTB9z3v7DyWNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAsDJH9oqC0jUxFZR1u88kJnDPmereuhnICX885ERp6WyiQmBWUvZQqqe3hqipvZXsMCkX53VsBgFdZLK+kLibQ9/K+v1z+zwcIrL905ugBkMqPxWvuYCp0eHFBFQ12m2kv6VXAFWsBVcBE/WovBOFF5+bM30BW5ym0MzRI2d1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMRWikhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1035C4CEC6;
	Fri,  4 Oct 2024 09:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728034177;
	bh=sSOW92oXxy45FOYQ7xw3zpICaVbOfCtTB9z3v7DyWNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dMRWikheORRYrq5GBhXnotIEQb0xcI5oTx+2wGmlLhdBbciqzCh+DdZK+NPoL6axQ
	 eqZh5VCmKXIWXdDUS1361EKD75DjXmOhsMfIUjKSp2N8r6mhT7dxnkJQtkqi+N6skf
	 7Ndfx4AT0q5jUlPRp0ykdNUBLOhmzt74M6RiDaMK3Bg9zxOSXqQE3CZCYUG+jEWI77
	 Cq3B/iLnV0GpULQ6LZ0ruWK23BbFHAZ0rgT5uFKf7Uyq2Sfa3RhrDvzgSg4h7YsvwS
	 l14Z0iRXcantPXFEMMed+COMCfbyKUFWj6FA/5jDKZRncYQajzjxzHdE/mBUBwF4gl
	 M5sjaA+3GNssA==
Date: Fri, 4 Oct 2024 11:29:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: luca.boccassi@gmail.com
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, paul@paul-moore.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
Message-ID: <20241004-signal-erfolg-c76d6fdeee1c@brauner>
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002142516.110567-1-luca.boccassi@gmail.com>

On Wed, Oct 02, 2024 at 03:24:33PM GMT, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> A common pattern when using pid fds is having to get information
> about the process, which currently requires /proc being mounted,
> resolving the fd to a pid, and then do manual string parsing of
> /proc/N/status and friends. This needs to be reimplemented over
> and over in all userspace projects (e.g.: I have reimplemented
> resolving in systemd, dbus, dbus-daemon, polkit so far), and
> requires additional care in checking that the fd is still valid
> after having parsed the data, to avoid races.
> 
> Having a programmatic API that can be used directly removes all
> these requirements, including having /proc mounted.

Yes, thanks for working on that.

> 
> As discussed at LPC24, add an ioctl with an extensible struct
> so that more parameters can be added later if needed. Start with
> exposing: pid, uid, gid, groupid, security label (the latter was
> requested by the LSM maintainer).
> 
> Signed-off-by: Luca Boccassi <bluca@debian.org>
> ---
>  fs/pidfs.c                                    | 61 ++++++++++++++++++-
>  include/uapi/linux/pidfd.h                    | 17 ++++++
>  .../testing/selftests/pidfd/pidfd_open_test.c | 50 ++++++++++++++-
>  3 files changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 7ffdc88dfb52..dd386d37309c 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -114,6 +114,62 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
>  	return poll_flags;
>  }
>  
> +static long pidfd_info(struct task_struct *task, struct pid *pid, unsigned long arg)
> +{
> +	struct pidfd_info uinfo = {}, info = {};
> +
> +	if (copy_from_user(&uinfo, (struct pidfd_info *)arg, sizeof(struct pidfd_info)))
> +		return -EFAULT;
> +	if (uinfo.size > sizeof(struct pidfd_info))
> +		return -E2BIG;

We want to allow for the struct passed down to be bigger than what the
kernel knows so older kernels can handle newer structs just fine. So
this check needs to go.

> +	if (uinfo.size < sizeof(struct pidfd_info))
> +		return -EINVAL; /* First version, no smaller struct possible */
> +
> +	if (uinfo.request_mask & ~(PIDFD_INFO_PID | PIDFD_INFO_CREDS | PIDFD_INFO_CGROUPID | PIDFD_INFO_SECURITY_CONTEXT))
> +		return -EINVAL;

This means you'll fail hard when requesting information that older
kernels don't provide. For a request mask based interface the correct
protocol is to answer in a result_mask what information the kernel was
actually able to provide. This way you get seamless forward and backward
compatibility without having the caller to guess what extension the
kernel doesn't support.

> +
> +	memcpy(&info, &uinfo, uinfo.size);
> +
> +	if (uinfo.request_mask & PIDFD_INFO_PID)

You should drop this and return basic pid information unconditionally.

> +		info.pid = pid_nr_ns(pid, task_active_pid_ns(task));

I think this is wrong what this should return is the pid of the process
as seen from the caller's pid namespace. Otherwise you'll report
meaningless pid numbers to the caller when the caller's pid namespace is
outside of the pid namespace hierarchy of the process that pidfd refers
to. This can easily happen when you receive pidfds via SCM_RIGHTS.

The other question is what you want to return here. What you did above
is equivalent to what pid_vnr() does. IIRC, then this will yield the
thread-group id in pidfd_info->pid if the pidfd is a thread-group leader
pidfd and the thread-id if the pidfd is a PIDFD_THREAD. While the caller
should be able to infer that from the type of pidfd I think we should
just have a unique meaning for the pid field.

It would probably even make sense to have:

(1) thread_id
(2) thread_group_id
(3) parent_id

> +	if (uinfo.request_mask & PIDFD_INFO_CREDS) {

You should drop this and return basic uid/gid information unconditionally.

Also the uid and gid field maybe should be named ruid and rgid because
sooner or later someone will want euid/egid and suid/sgid and
fsuid/fsgid.

In fact, we might want to probably return ruid/rgid, euid/egid,
suid/sgid, fsuid/fsgid unconditionally.

I suspect that stuff like supplementary groups should rather be reported
through an extra ioctl instead of having a variable sized array in the
struct.

> +		const struct cred *c = get_task_cred(task);
> +		if (!c)
> +			return -ESRCH;
> +
> +		info.uid = from_kuid_munged(current_user_ns(), c->uid);
> +		info.gid = from_kgid_munged(current_user_ns(), c->gid);
> +	}
> +
> +	if (uinfo.request_mask & PIDFD_INFO_CGROUPID) {
> +		struct cgroup *cgrp = task_css_check(task, pids_cgrp_id, 1)->cgroup;
> +		if (!cgrp)
> +			return -ENODEV;
> +
> +		info.cgroupid = cgroup_id(cgrp);
> +	}
> +
> +	if (uinfo.request_mask & PIDFD_INFO_SECURITY_CONTEXT) {

It would make sense for security information to get a separate ioctl so
that struct pidfd_info just return simple and fast information and the
security stuff can include things such as seccomp, caps etc pp.

> +		char *secctx;
> +		u32 secid, secctx_len;
> +		const struct cred *c = get_task_cred(task);
> +		if (!c)
> +			return -ESRCH;
> +
> +		security_cred_getsecid(c, &secid);
> +		if (security_secid_to_secctx(secid, &secctx, &secctx_len))
> +			return -EFAULT;
> +
> +		memcpy(info.security_context, secctx, min_t(u32, secctx_len, NAME_MAX-1));
> +	}
> +
> +	if (copy_to_user((void __user *)arg, &info, uinfo.size))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct task_struct *task __free(put_task) = NULL;
> @@ -121,13 +177,16 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  	struct pid *pid = pidfd_pid(file);
>  	struct ns_common *ns_common = NULL;
>  
> -	if (arg)
> +	if (!!arg != (cmd == PIDFD_GET_INFO))
>  		return -EINVAL;
>  
>  	task = get_pid_task(pid, PIDTYPE_PID);
>  	if (!task)
>  		return -ESRCH;
>  
> +	if (cmd == PIDFD_GET_INFO)
> +		return pidfd_info(task, pid, arg);

So, please take a look at nsfs or look at seccomp. The gist is that in
order to keep this extensible we don't match on the ioctl command
directly because it encodes the size of the argument instead we do:

        /* extensible ioctls */
        switch (_IOC_NR(cmd)) {
        case _IOC_NR(PIDFD_GET_INFO): {
                struct pidfd_info kinfo = {};
                struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
                size_t usize = _IOC_SIZE(cmd);
 
                if (!uinfo)
                        return -EINVAL;
 
                if (usize < PIDFD_INFO_SIZE_VER0)
                        return -EINVAL;
 
        /* fill in kinfo information */
        kinfo->ruid ...
        kinfo->cgroup_id ...
        kinfo->result_mask ...
 
        /*
         * If userspace and the kernel have the same struct size it can just
         * be copied. If userspace provides an older struct, only the bits that
         * userspace knows about will be copied. If userspace provides a new
         * struct, only the bits that the kernel knows about will be copied and
         * the size value will be set to the size the kernel knows about.
         */
        if (copy_to_user(uinfo, kinfo, min(usize, sizeof(*kinfo))))
                return -EFAULT;

> +
>  	scoped_guard(task_lock, task) {
>  		nsp = task->nsproxy;
>  		if (nsp)
> diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> index 565fc0629fff..bfd0965e01f3 100644
> --- a/include/uapi/linux/pidfd.h
> +++ b/include/uapi/linux/pidfd.h
> @@ -16,6 +16,22 @@
>  #define PIDFD_SIGNAL_THREAD_GROUP	(1UL << 1)
>  #define PIDFD_SIGNAL_PROCESS_GROUP	(1UL << 2)
>  
> +/* Flags for pidfd_info. */
> +#define PIDFD_INFO_PID	    	        (1UL << 0)
> +#define PIDFD_INFO_CREDS	            (1UL << 1)
> +#define PIDFD_INFO_CGROUPID	            (1UL << 2)
> +#define PIDFD_INFO_SECURITY_CONTEXT	    (1UL << 3)
> +
> +struct pidfd_info {
> +        __u64 request_mask;
> +        __u32 size;
> +        uint pid;

The size is unnecessary because it is directly encoded into the ioctl
command.

> +        uint uid;
> +        uint gid;
> +        __u64 cgroupid;
> +        char security_context[NAME_MAX];
> +} __packed;

The packed attribute should be unnecessary. The structure should simply
be correctly padded and should use explicitly sized types:

struct pidfd_info {
	/* Let userspace request expensive stuff explictly. */
	__u64 request_mask;
	/* And let the kernel indicate whether it knows about it. */
	__u64 result_mask;
	__u32 pid;
	__u32 uid;
	__u32 gid;
	__u64 cgroup_id;
	__u32 spare0[1];
};

I'm not sure what LSM info to be put in there and we can just do it as
an extension.

> +
>  #define PIDFS_IOCTL_MAGIC 0xFF
>  
>  #define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
> @@ -28,5 +44,6 @@
>  #define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
>  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
>  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> +#define PIDFD_GET_INFO                        _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
>  
>  #endif /* _UAPI_LINUX_PIDFD_H */
> diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
> index c62564c264b1..929588c7e0f0 100644
> --- a/tools/testing/selftests/pidfd/pidfd_open_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
> @@ -13,6 +13,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> +#include <sys/ioctl.h>
>  #include <sys/mount.h>
>  #include <sys/prctl.h>
>  #include <sys/wait.h>
> @@ -21,6 +22,28 @@
>  #include "pidfd.h"
>  #include "../kselftest.h"
>  
> +#ifndef PIDFS_IOCTL_MAGIC
> +#define PIDFS_IOCTL_MAGIC 0xFF
> +#endif
> +
> +#ifndef PIDFD_GET_INFO
> +#define PIDFD_GET_INFO _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
> +#define PIDFD_INFO_PID                  (1UL << 0)
> +#define PIDFD_INFO_CREDS                (1UL << 1)
> +#define PIDFD_INFO_CGROUPID	            (1UL << 2)
> +#define PIDFD_INFO_SECURITY_CONTEXT	    (1UL << 3)
> +
> +struct pidfd_info {
> +        __u64 request_mask;
> +        __u32 size;
> +        uint pid;
> +        uint uid;
> +        uint gid;
> +        __u64 cgroupid;
> +        char security_context[NAME_MAX];
> +} __attribute__((__packed__));
> +#endif
> +
>  static int safe_int(const char *numstr, int *converted)
>  {
>  	char *err = NULL;
> @@ -120,10 +143,14 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
>  
>  int main(int argc, char **argv)
>  {
> +	struct pidfd_info info = {
> +		.size = sizeof(struct pidfd_info),
> +		.request_mask = PIDFD_INFO_PID | PIDFD_INFO_CREDS | PIDFD_INFO_CGROUPID,
> +	};
>  	int pidfd = -1, ret = 1;
>  	pid_t pid;
>  
> -	ksft_set_plan(3);
> +	ksft_set_plan(4);
>  
>  	pidfd = sys_pidfd_open(-1, 0);
>  	if (pidfd >= 0) {
> @@ -153,6 +180,27 @@ int main(int argc, char **argv)
>  	pid = get_pid_from_fdinfo_file(pidfd, "Pid:", sizeof("Pid:") - 1);
>  	ksft_print_msg("pidfd %d refers to process with pid %d\n", pidfd, pid);
>  
> +	if (ioctl(pidfd, PIDFD_GET_INFO, &info) < 0) {
> +		ksft_print_msg("%s - failed to get info from pidfd\n", strerror(errno));
> +		goto on_error;
> +	}
> +	if (info.pid != pid) {
> +		ksft_print_msg("pid from fdinfo file %d does not match pid from ioctl %d\n",
> +			       pid, info.pid);
> +		goto on_error;
> +	}
> +	if (info.uid != getuid()) {
> +		ksft_print_msg("uid %d does not match uid from info %d\n",
> +			       getuid(), info.uid);
> +		goto on_error;
> +	}
> +	if (info.gid != getgid()) {
> +		ksft_print_msg("gid %d does not match gid from info %d\n",
> +			       getgid(), info.gid);
> +		goto on_error;
> +	}
> +	ksft_test_result_pass("get info from pidfd test: passed\n");
> +
>  	ret = 0;
>  
>  on_error:
> -- 
> 2.45.2
> 

