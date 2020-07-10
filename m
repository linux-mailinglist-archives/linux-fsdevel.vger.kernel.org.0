Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC521B459
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 13:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGJL6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgGJL6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:58:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9897C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 04:58:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id a32so4153130qtb.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2020 04:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C2QqliIPhj/kPXpb5sXf7nNxj5wTOZ3kbjobAfPb8t0=;
        b=AWk5679b/c2bCqL4rDHd4urTlRxSu2zZLlkNhfVzCS6PwmC2dCmQNbuaCysJPSBN0I
         PVOl9RmVlX0BQbRWhlCtfJJ0S020b776MvxrlkZ+XtcWndQWKiZHma+ciaOO2p5KxbQc
         CZCyn/ztqFcqf7wSrrqglHxoXfztTaLr9lIKFT0+0F80Iv8jf7J1W+iO6gX3v4T+2h3D
         9h/zh4/XUB4WijxNcmQeKiq7a4IGcz1DwW1u4WtfC9DmBFud5M95LmYfUYgr2iT9OxEH
         yry1R3ZDTEcRaH+n884fcCQz+2N7YfB+E3SA3o9F/zvY7zXrWLLGINMixr9vN5eB6Xhg
         W2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C2QqliIPhj/kPXpb5sXf7nNxj5wTOZ3kbjobAfPb8t0=;
        b=H4klcnDJjrA14KN1L1V9TByjTp3+Cg7JQPeSnplvX86U8Jx1rDn01IsCN2C5AbwTZl
         1+mjO5xzi1gIpyEyTZaHXu5eM8Iug6eCTPdP8lRQ4gictbLVRB2H8qMuZ14LIUNLb0pJ
         j4C+ou0iLjlrB6oEKSu9j+mE/HtOMeMxbJd5O3J6OJ+DXiAI6wzLtXGtj7cclbwlwX6u
         wy2rmcO9xJg2EUjcqHSjsjNvISIYvnS3o77e9xvPA0RwbJV+DzM+RMHoU0iyav67JVVk
         NDlGcoGfN636SlmQf1+YfNSULvSfH5odfb9GU++ziUcHMcNC1zCkOFyRcfE8MI0acYg5
         HtfQ==
X-Gm-Message-State: AOAM532DjlXq/UXhWMu2EsjCv2r/p27rs7vyLNZKLhuPpCqftaVbMbPQ
        3PSev66lYlxcsexstCZBi6F0Qw==
X-Google-Smtp-Source: ABdhPJxywtI5S3IG2H6DgbqFlgRTtS888ajPTSp1CyCoFlzWk8vvD2d2Z8zZOrgIGtd/6gCF7EPVmw==
X-Received: by 2002:aed:20e5:: with SMTP id 92mr52457621qtb.388.1594382324013;
        Fri, 10 Jul 2020 04:58:44 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p53sm7925460qtc.85.2020.07.10.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:58:43 -0700 (PDT)
Date:   Fri, 10 Jul 2020 07:58:36 -0400
From:   Qian Cai <cai@lca.pw>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Bumiller <w.bumiller@proxmox.com>,
        Serge Hallyn <serge@hallyn.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] nsfs: add NS_GET_INIT_PID ioctl
Message-ID: <20200710115836.GA1027@lca.pw>
References: <20200618084543.326605-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618084543.326605-1-christian.brauner@ubuntu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:45:43AM +0200, Christian Brauner wrote:
> Add an ioctl() to return the PID of the init process/child reaper of a pid
> namespace as seen in the caller's pid namespace.
> 
> LXCFS is a tiny fuse filesystem used to virtualize various aspects of
> procfs. It is used actively by a large number of users including ChromeOS
> and cloud providers. LXCFS is run on the host. The files and directories it
> creates can be bind-mounted by e.g. a container at startup and mounted over
> the various procfs files the container wishes to have virtualized. When
> e.g. a read request for uptime is received, LXCFS will receive the pid of
> the reader. In order to virtualize the corresponding read, LXCFS needs to
> know the pid of the init process of the reader's pid namespace. In order to
> do this, LXCFS first needs to fork() two helper processes. The first helper
> process setns() to the readers pid namespace. The second helper process is
> needed to create a process that is a proper member of the pid namespace.
> The second helper process then creates a ucred message with ucred.pid set
> to 1 and sends it back to LXCFS. The kernel will translate the ucred.pid
> field to the corresponding pid number in LXCFS's pid namespace. This way
> LXCFS can learn the init pid number of the reader's pid namespace and can
> go on to virtualize. Since these two forks() are costly LXCFS maintains an
> init pid cache that caches a given pid for a fixed amount of time. The
> cache is pruned during new read requests. However, even with the cache the
> hit of the two forks() is singificant when a very large number of
> containers are running. With this simple patch we add an ns ioctl that
> let's a caller retrieve the init pid nr of a pid namespace through its
> pid namespace fd. This _significantly_ improves our performance with a very
> simple change. A caller should do something like:
> - pid_t init_pid = ioctl(pid_ns_fd, NS_GET_INIT_PID);
> - verify init_pid is still valid (not necessarily both but recommended):
>   - opening a pidfd to get a stable reference
>   - opening /proc/<init_pid>/ns/pid and verifying that <pid_ns_fd>
>     and the pid namespace fd of <init_pid> refer to the same pid namespace
> 
> Note, it is possible for the init process of the pid namespace (identified
> via the child_reaper member in the relevant pid namespace) to die and get
> reaped right after the ioctl returned. If that happens there are two cases
> to consider:
> - if the init process was single threaded, all other processes in the pid
>   namespace will be zapped and any new process creation in there will fail;
>   A caller can detect this case since either the init pid is still around
>   but it is a zombie, or it already has exited and not been recycled, or it
>   has exited, been reaped, and also been recycled. The last case is the
>   most interesting one but a caller would then be able to detect that the
>   recycled process lives in a different pid namespace.
> - if the init process was multi-threaded, then the kernel will try to make
>   one of the threads in the same thread-group - if any are still alive -
>   the new child_reaper. In this case the caller can detect that the thread
>   which exited and used to be the child_reaper is no longer alive. If it's
>   tid has been recycled in the same pid namespace a caller can detect this
>   by parsing through /proc/<tid>/stat, looking at the Nspid: field and if
>   there's a entry with pid nr 1 in the respective pid namespace it can be
>   sure that it hasn't been recycled.
> Both options can be combined with pidfd_open() to make sure that a stable
> reference is maintained.
> 
> Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

fs/nsfs.c: In function ‘ns_ioctl’:
fs/nsfs.c:195:14: warning: unused variable ‘pid_struct’ [-Wunused-variable]
  struct pid *pid_struct;
              ^~~~~~~~~~
fs/nsfs.c:194:22: warning: unused variable ‘child_reaper’ [-Wunused-variable]
  struct task_struct *child_reaper;
                      ^~~~~~~~~~~~

> ---
>  fs/nsfs.c                 | 29 +++++++++++++++++++++++++++++
>  include/uapi/linux/nsfs.h |  2 ++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 800c1d0eb0d0..5a7de1ee6df0 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -8,6 +8,7 @@
>  #include <linux/magic.h>
>  #include <linux/ktime.h>
>  #include <linux/seq_file.h>
> +#include <linux/pid_namespace.h>
>  #include <linux/user_namespace.h>
>  #include <linux/nsfs.h>
>  #include <linux/uaccess.h>
> @@ -189,6 +190,10 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  			unsigned long arg)
>  {
>  	struct user_namespace *user_ns;
> +	struct pid_namespace *pid_ns;
> +	struct task_struct *child_reaper;
> +	struct pid *pid_struct;
> +	pid_t pid;
>  	struct ns_common *ns = get_proc_ns(file_inode(filp));
>  	uid_t __user *argp;
>  	uid_t uid;
> @@ -209,6 +214,30 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>  		argp = (uid_t __user *) arg;
>  		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
>  		return put_user(uid, argp);
> +	case NS_GET_INIT_PID:
> +		if (ns->ops->type != CLONE_NEWPID)
> +			return -EINVAL;
> +
> +		pid_ns = container_of(ns, struct pid_namespace, ns);
> +
> +		/*
> +		 * If we're asking for the init pid of our own pid namespace
> +		 * that's of course silly but no need to fail this since we can
> +		 * both infer or find out our own pid namespaces's init pid
> +		 * trivially. In all other cases, we require the same
> +		 * privileges as for setns().
> +		 */
> +		if (task_active_pid_ns(current) != pid_ns &&
> +		    !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		pid = -ESRCH;
> +		read_lock(&tasklist_lock);
> +		if (likely(pid_ns->child_reaper))
> +			pid = task_pid_vnr(pid_ns->child_reaper);
> +		read_unlock(&tasklist_lock);
> +
> +		return pid;
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
> index a0c8552b64ee..29c775f42bbe 100644
> --- a/include/uapi/linux/nsfs.h
> +++ b/include/uapi/linux/nsfs.h
> @@ -15,5 +15,7 @@
>  #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
>  /* Get owner UID (in the caller's user namespace) for a user namespace */
>  #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
> +/* Get init PID (in the caller's pid namespace) of a pid namespace */
> +#define NS_GET_INIT_PID		_IO(NSIO, 0x5)
>  
>  #endif /* __LINUX_NSFS_H */
> 
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> -- 
> 2.27.0
> 
