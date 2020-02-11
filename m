Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7951587FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBKBiI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:38:08 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36974 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgBKBiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:38:08 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j1KV1-0006Vx-Kj; Mon, 10 Feb 2020 18:38:03 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j1KV0-0008DW-MA; Mon, 10 Feb 2020 18:38:03 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
        <20200210150519.538333-8-gladkov.alexey@gmail.com>
Date:   Mon, 10 Feb 2020 19:36:08 -0600
In-Reply-To: <20200210150519.538333-8-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Mon, 10 Feb 2020 16:05:15 +0100")
Message-ID: <87v9odlxbr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j1KV0-0008DW-MA;;;mid=<87v9odlxbr.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19U7B4KhHh4/SgwTHfxXMZZMQO4jwEBNUA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 528 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.7 (0.5%), b_tie_ro: 1.81 (0.3%), parse: 1.54
        (0.3%), extract_message_metadata: 22 (4.1%), get_uri_detail_list: 4.7
        (0.9%), tests_pri_-1000: 8 (1.6%), tests_pri_-950: 1.23 (0.2%),
        tests_pri_-900: 1.29 (0.2%), tests_pri_-90: 41 (7.8%), check_bayes: 40
        (7.5%), b_tokenize: 17 (3.2%), b_tok_get_all: 12 (2.2%), b_comp_prob:
        3.2 (0.6%), b_tok_touch_all: 5 (1.0%), b_finish: 0.63 (0.1%),
        tests_pri_0: 438 (83.0%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 21 (4.0%), poll_dns_idle: 0.33 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> This allows to flush dcache entries of a task on multiple procfs mounts
> per pid namespace.
>
> The RCU lock is used because the number of reads at the task exit time
> is much larger than the number of procfs mounts.

A couple of quick comments.

> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  fs/proc/base.c                | 20 +++++++++++++++-----
>  fs/proc/root.c                | 27 ++++++++++++++++++++++++++-
>  include/linux/pid_namespace.h |  2 ++
>  include/linux/proc_fs.h       |  2 ++
>  4 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 4ccb280a3e79..24b7c620ded3 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3133,7 +3133,7 @@ static const struct inode_operations proc_tgid_base_inode_operations = {
>  	.permission	= proc_pid_permission,
>  };
>  
> -static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
> +static void proc_flush_task_mnt_root(struct dentry *mnt_root, pid_t pid, pid_t tgid)
Perhaps just rename things like:
> +static void proc_flush_task_root(struct dentry *root, pid_t pid, pid_t tgid)
>  {

I don't think the mnt_ prefix conveys any information, and it certainly
makes everything longer and more cumbersome.

>  	struct dentry *dentry, *leader, *dir;
>  	char buf[10 + 1];
> @@ -3142,7 +3142,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
>  	name.name = buf;
>  	name.len = snprintf(buf, sizeof(buf), "%u", pid);
>  	/* no ->d_hash() rejects on procfs */
> -	dentry = d_hash_and_lookup(mnt->mnt_root, &name);
> +	dentry = d_hash_and_lookup(mnt_root, &name);
>  	if (dentry) {
>  		d_invalidate(dentry);
>  		dput(dentry);
> @@ -3153,7 +3153,7 @@ static void proc_flush_task_mnt(struct vfsmount *mnt, pid_t pid, pid_t tgid)
>  
>  	name.name = buf;
>  	name.len = snprintf(buf, sizeof(buf), "%u", tgid);
> -	leader = d_hash_and_lookup(mnt->mnt_root, &name);
> +	leader = d_hash_and_lookup(mnt_root, &name);
>  	if (!leader)
>  		goto out;
>  
> @@ -3208,14 +3208,24 @@ void proc_flush_task(struct task_struct *task)
>  	int i;
>  	struct pid *pid, *tgid;
>  	struct upid *upid;
> +	struct dentry *mnt_root;
> +	struct proc_fs_info *fs_info;
>  
>  	pid = task_pid(task);
>  	tgid = task_tgid(task);
>  
>  	for (i = 0; i <= pid->level; i++) {
>  		upid = &pid->numbers[i];
> -		proc_flush_task_mnt(upid->ns->proc_mnt, upid->nr,
> -					tgid->numbers[i].nr);
> +
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(fs_info, &upid->ns->proc_mounts, pidns_entry) {
> +			mnt_root = fs_info->m_super->s_root;
> +			proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);
> +		}
> +		rcu_read_unlock();
> +
> +		mnt_root = upid->ns->proc_mnt->mnt_root;
> +		proc_flush_task_mnt_root(mnt_root, upid->nr, tgid->numbers[i].nr);

I don't think this following of proc_mnt is needed.  It certainly
shouldn't be.  The loop through all of the super blocks should be
enough.

Once this change goes through.  UML can be given it's own dedicated
proc_mnt for the initial pid namespace, and proc_mnt can be removed
entirely.

Unless something has changed recently UML is the only other user of
pid_ns->proc_mnt.  That proc_mnt really only exists to make the loop in
proc_flush_task easy to write.

It also probably makes sense to take the rcu_read_lock() over
that entire for loop.


>  	}
>  }
>  
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 5d5cba4c899b..e2bb015da1a8 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -149,7 +149,22 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
>  	if (ret) {
>  		return ret;
>  	}
> -	return proc_setup_thread_self(s);
> +
> +	ret = proc_setup_thread_self(s);
> +	if (ret) {
> +		return ret;
> +	}
> +
> +	/*
> +	 * back reference to flush dcache entries at process exit time.
> +	 */
> +	ctx->fs_info->m_super = s;
> +
> +	spin_lock(&pid_ns->proc_mounts_lock);
> +	list_add_tail_rcu(&ctx->fs_info->pidns_entry, &pid_ns->proc_mounts);
> +	spin_unlock(&pid_ns->proc_mounts_lock);
> +
> +	return 0;
>  }
>  
>  static int proc_reconfigure(struct fs_context *fc)
> @@ -211,10 +226,17 @@ static void proc_kill_sb(struct super_block *sb)
>  {
>  	struct proc_fs_info *fs_info = proc_sb_info(sb);
>  
> +	spin_lock(&fs_info->pid_ns->proc_mounts_lock);
> +	list_del_rcu(&fs_info->pidns_entry);
> +	spin_unlock(&fs_info->pid_ns->proc_mounts_lock);
> +
> +	synchronize_rcu();
> +

Rather than a heavyweight synchronize_rcu here,
it probably makes sense to instead to change

	kfree(fs_info)
to
	kfree_rcu(fs_info, some_rcu_head_in_fs_info)

Or possibly doing a full call_rcu.

The problem is that synchronize_rcu takes about 10ms when HZ=100.
Which makes synchronize_rcu incredibly expensive on any path where
anything can wait for it.

>  	if (fs_info->proc_self)
>  		dput(fs_info->proc_self);
>  	if (fs_info->proc_thread_self)
>  		dput(fs_info->proc_thread_self);
> +
>  	kill_anon_super(sb);
>  	put_pid_ns(fs_info->pid_ns);
>  	kfree(fs_info);
> @@ -336,6 +358,9 @@ int pid_ns_prepare_proc(struct pid_namespace *ns)
>  		ctx->fs_info->pid_ns = ns;
>  	}
>  
> +	spin_lock_init(&ns->proc_mounts_lock);
> +	INIT_LIST_HEAD_RCU(&ns->proc_mounts);
> +
>  	mnt = fc_mount(fc);
>  	put_fs_context(fc);
>  	if (IS_ERR(mnt))
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 66f47f1afe0d..c36af1dfd862 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -26,6 +26,8 @@ struct pid_namespace {
>  	struct pid_namespace *parent;
>  #ifdef CONFIG_PROC_FS
>  	struct vfsmount *proc_mnt; /* Internal proc mounted during each new pidns */
> +	spinlock_t proc_mounts_lock;
> +	struct list_head proc_mounts; /* list of separated procfs mounts */
>  #endif
>  #ifdef CONFIG_BSD_PROCESS_ACCT
>  	struct fs_pin *bacct;
> diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> index 5f0b1b7e4271..f307940f8311 100644
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -20,6 +20,8 @@ enum {
>  };
>  
>  struct proc_fs_info {
> +	struct list_head pidns_entry;    /* Node in procfs_mounts of a pidns */
> +	struct super_block *m_super;
>  	struct pid_namespace *pid_ns;
>  	struct dentry *proc_self;        /* For /proc/self */
>  	struct dentry *proc_thread_self; /* For /proc/thread-self */


Eric
