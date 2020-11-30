Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AEB2C8F65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 21:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgK3Urj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 15:47:39 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:46036 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgK3Uri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:47:38 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjq4N-0052tf-VB; Mon, 30 Nov 2020 13:46:48 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjq4N-0004JZ-0W; Mon, 30 Nov 2020 13:46:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20201130200619.84819-1-stephen.s.brennan@oracle.com>
Date:   Mon, 30 Nov 2020 14:46:17 -0600
In-Reply-To: <20201130200619.84819-1-stephen.s.brennan@oracle.com> (Stephen
        Brennan's message of "Mon, 30 Nov 2020 12:06:19 -0800")
Message-ID: <87zh2yh8ti.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kjq4N-0004JZ-0W;;;mid=<87zh2yh8ti.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sqwsfU7CTM4UeGEPdxQccntK8E2+ga5U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Stephen Brennan <stephen.s.brennan@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 529 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.7%), b_tie_ro: 2.7 (0.5%), parse: 0.80
        (0.2%), extract_message_metadata: 4.0 (0.8%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-1000: 2.9 (0.5%), tests_pri_-950: 0.94 (0.2%),
        tests_pri_-900: 0.77 (0.1%), tests_pri_-90: 87 (16.5%), check_bayes:
        86 (16.2%), b_tokenize: 10 (1.9%), b_tok_get_all: 10 (1.9%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 61 (11.5%), b_finish: 0.78
        (0.1%), tests_pri_0: 415 (78.6%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.0 (0.4%), poll_dns_idle: 0.68 (0.1%), tests_pri_10:
        1.65 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc: Allow pid_revalidate() during LOOKUP_RCU
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> The pid_revalidate() function requires dropping from RCU into REF lookup
> mode. When many threads are resolving paths within /proc in parallel,
> this can result in heavy spinlock contention as each thread tries to
> grab a reference to the /proc dentry (and drop it shortly thereafter).
>
> Allow the pid_revalidate() function to execute under LOOKUP_RCU. When
> updates must be made to the inode due to the owning task performing
> setuid(), drop out of RCU and into REF mode.

So rather than get_task_rcu_user.  I think what we want is a function
that verifies task->rcu_users > 0.

Which frankly is just "pid_task(proc_pid(inode), PIDTYPE_PID)".

Which is something that we can do unconditionally in pid_revalidate.

Skipping the update of the inode is probably the only thing that needs
to be skipped.

It looks like the code can safely rely on the the security_task_to_inode
in proc_pid_make_inode and remove the security_task_to_inode in
pid_update_inode.


> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>
> I'd like to use this patch as an RFC on this approach for reducing spinlock
> contention during many parallel path lookups in the /proc filesystem. The
> contention can be triggered by, for example, running ~100 parallel instances of
> "TZ=/etc/localtime ps -fe >/dev/null" on a 100CPU machine. The %sys utilization
> in such a case reaches around 90%, and profiles show two code paths with high
> utilization:

Do you have a real world work-load that is behaves something like this
micro benchmark?  I am just curious how severe the problem you are
trying to solve is.

>
>     walk_component
>       lookup_fast
>         unlazy_child
>           legitimize_root
>             __legitimize_path
>               lockref_get_not_dead
>
>     terminate_walk
>       dput
>         dput
>
> By applying this patch, %sys utilization falls to around 60% under the same
> workload.
>
> One item I'd like to highlight about this patch is that the
> security_task_to_inode() hook is called less frequently as a result. I don't
> know whether this is a major concern, which is why I've included security
> reviewers as well.
>
>  fs/proc/base.c      | 50 ++++++++++++++++++++++++++++++++-------------
>  fs/proc/internal.h  |  5 +++++
>  include/linux/pid.h |  2 ++
>  kernel/pid.c        | 12 +++++++++++
>  4 files changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..038056f94ed0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1813,12 +1813,29 @@ int pid_getattr(const struct path *path, struct kstat *stat,
>  /*
>   * Set <pid>/... inode ownership (can change due to setuid(), etc.)
>   */
> -void pid_update_inode(struct task_struct *task, struct inode *inode)
> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
> +							   unsigned int flags)
>  {
> -	task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
> +	kuid_t uid;
> +	kgid_t gid;
> +
> +	task_dump_owner(task, inode->i_mode, &uid, &gid);
> +	if (uid_eq(uid, inode->i_uid) && gid_eq(gid, inode->i_gid) &&
> +			!(inode->i_mode & (S_ISUID | S_ISGID)))
> +		return 1;
> +	if (flags & LOOKUP_RCU)
> +		return -ECHILD;
>  
> +	inode->i_uid = uid;
> +	inode->i_gid = gid;
>  	inode->i_mode &= ~(S_ISUID | S_ISGID);
>  	security_task_to_inode(task, inode);
> +	return 1;
> +}
> +
> +void pid_update_inode(struct task_struct *task, struct inode *inode)
> +{
> +	do_pid_update_inode(task, inode, 0);
>  }
>  
>  /*
> @@ -1830,19 +1847,24 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	struct task_struct *task;
> -
> -	if (flags & LOOKUP_RCU)
> -		return -ECHILD;
> -
> -	inode = d_inode(dentry);
> -	task = get_proc_task(inode);
> -
> -	if (task) {
> -		pid_update_inode(task, inode);
> -		put_task_struct(task);
> -		return 1;
> +	int rv = 0;
> +
> +	if (flags & LOOKUP_RCU) {
> +		inode = d_inode_rcu(dentry);
> +		task = get_proc_task_rcu(inode);
> +		if (task) {
> +			rv = do_pid_update_inode(task, inode, flags);
> +			put_task_struct_rcu_user(task);
> +		}
> +	} else {
> +		inode = d_inode(dentry);
> +		task = get_proc_task(inode);
> +		if (task) {
> +			rv = do_pid_update_inode(task, inode, flags);
> +			put_task_struct(task);
> +		}
>  	}
> -	return 0;
> +	return rv;
>  }
>  
>  static inline bool proc_inode_is_dead(struct inode *inode)
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index cd0c8d5ce9a1..aa6df65ad3eb 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -121,6 +121,11 @@ static inline struct task_struct *get_proc_task(const struct inode *inode)
>  	return get_pid_task(proc_pid(inode), PIDTYPE_PID);
>  }
>  
> +static inline struct task_struct *get_proc_task_rcu(const struct inode *inode)
> +{
> +	return get_pid_task_rcu_user(proc_pid(inode), PIDTYPE_PID);
> +}
> +
>  void task_dump_owner(struct task_struct *task, umode_t mode,
>  		     kuid_t *ruid, kgid_t *rgid);
>  
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 9645b1194c98..0b2c54f85e6d 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -86,6 +86,8 @@ static inline struct pid *get_pid(struct pid *pid)
>  extern void put_pid(struct pid *pid);
>  extern struct task_struct *pid_task(struct pid *pid, enum pid_type);
>  extern struct task_struct *get_pid_task(struct pid *pid, enum pid_type);
> +extern struct task_struct *get_pid_task_rcu_user(struct pid *pid,
> +						 enum pid_type type);
>  
>  extern struct pid *get_task_pid(struct task_struct *task, enum pid_type type);
>  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 0a9f2e437217..05acbd15cfa6 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -390,6 +390,18 @@ struct task_struct *get_pid_task(struct pid *pid, enum pid_type type)
>  }
>  EXPORT_SYMBOL_GPL(get_pid_task);
>  
> +struct task_struct *get_pid_task_rcu_user(struct pid *pid, enum pid_type type)
> +{
> +	struct task_struct *task;
> +
> +	task = pid_task(pid, type);
> +	if (task && refcount_inc_not_zero(&task->rcu_users))
> +		return task;
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(get_pid_task_rcu_user);
> +
>  struct pid *find_get_pid(pid_t nr)
>  {
>  	struct pid *pid;
