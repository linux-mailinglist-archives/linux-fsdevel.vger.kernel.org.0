Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB24174192
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 22:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1Vmd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 16:42:33 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:52476 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgB1Vmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:42:32 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7nOw-0006Od-0k; Fri, 28 Feb 2020 14:42:30 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7nOv-0007er-2R; Fri, 28 Feb 2020 14:42:29 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
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
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <871rqk2brn.fsf_-_@x220.int.ebiederm.org>
        <878skmsbyy.fsf_-_@x220.int.ebiederm.org>
        <87r1yeqxbp.fsf_-_@x220.int.ebiederm.org>
        <20200228203915.jelui3l5xue5utpx@wittgenstein>
Date:   Fri, 28 Feb 2020 15:40:22 -0600
In-Reply-To: <20200228203915.jelui3l5xue5utpx@wittgenstein> (Christian
        Brauner's message of "Fri, 28 Feb 2020 21:39:15 +0100")
Message-ID: <87eeuepf09.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7nOv-0007er-2R;;;mid=<87eeuepf09.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184U6bpgZxu3cpckFBHsoBN66MbMH8BfSI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4681]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 512 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.6 (0.5%), b_tie_ro: 1.80 (0.4%), parse: 1.24
        (0.2%), extract_message_metadata: 16 (3.2%), get_uri_detail_list: 3.4
        (0.7%), tests_pri_-1000: 17 (3.3%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 46 (9.0%), check_bayes: 44
        (8.6%), b_tokenize: 16 (3.1%), b_tok_get_all: 14 (2.7%), b_comp_prob:
        3.6 (0.7%), b_tok_touch_all: 7 (1.3%), b_finish: 1.94 (0.4%),
        tests_pri_0: 415 (81.1%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 8 (1.6%), poll_dns_idle: 0.24 (0.0%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] proc: Remove the now unnecessary internal mount of proc
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Fri, Feb 28, 2020 at 02:19:22PM -0600, Eric W. Biederman wrote:
>> 
>> There remains no more code in the kernel using pids_ns->proc_mnt,
>> therefore remove it from the kernel.
>> 
>> The big benefit of this change is that one of the most error prone and
>> tricky parts of the pid namespace implementation, maintaining kernel
>> mounts of proc is removed.
>> 
>> In addition removing the unnecessary complexity of the kernel mount
>> fixes a regression that caused the proc mount options to be ignored.
>> Now that the initial mount of proc comes from userspace, those mount
>> options are again honored.  This fixes Android's usage of the proc
>> hidepid option.
>> 
>> Reported-by: Alistair Strachan <astrachan@google.com>
>> Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns.")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  fs/proc/root.c                | 36 -----------------------------------
>
> What about proc_flush_task()? Or is this on top of your other series?

On top of the other series.  Which is why it is a reply to it.
That I have pushed into linux-next earlier today.

No one seems worried enough about that patchset to comment on v2 so I am
just going with it.

>>  include/linux/pid_namespace.h |  2 --
>>  include/linux/proc_ns.h       |  5 -----
>>  kernel/pid.c                  |  8 --------
>>  kernel/pid_namespace.c        |  7 -------
>>  5 files changed, 58 deletions(-)
>> 
>> diff --git a/fs/proc/root.c b/fs/proc/root.c
>> index 608233dfd29c..2633f10446c3 100644
>> --- a/fs/proc/root.c
>> +++ b/fs/proc/root.c
>> @@ -292,39 +292,3 @@ struct proc_dir_entry proc_root = {
>>  	.subdir		= RB_ROOT,
>>  	.name		= "/proc",
>>  };
>> -
>> -int pid_ns_prepare_proc(struct pid_namespace *ns)
>> -{
>> -	struct proc_fs_context *ctx;
>> -	struct fs_context *fc;
>> -	struct vfsmount *mnt;
>> -
>> -	fc = fs_context_for_mount(&proc_fs_type, SB_KERNMOUNT);
>> -	if (IS_ERR(fc))
>> -		return PTR_ERR(fc);
>> -
>> -	if (fc->user_ns != ns->user_ns) {
>> -		put_user_ns(fc->user_ns);
>> -		fc->user_ns = get_user_ns(ns->user_ns);
>> -	}
>> -
>> -	ctx = fc->fs_private;
>> -	if (ctx->pid_ns != ns) {
>> -		put_pid_ns(ctx->pid_ns);
>> -		get_pid_ns(ns);
>> -		ctx->pid_ns = ns;
>> -	}
>> -
>> -	mnt = fc_mount(fc);
>> -	put_fs_context(fc);
>> -	if (IS_ERR(mnt))
>> -		return PTR_ERR(mnt);
>> -
>> -	ns->proc_mnt = mnt;
>> -	return 0;
>> -}
>> -
>> -void pid_ns_release_proc(struct pid_namespace *ns)
>> -{
>> -	kern_unmount(ns->proc_mnt);
>> -}
>> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
>> index 2ed6af88794b..4956e362e55e 100644
>> --- a/include/linux/pid_namespace.h
>> +++ b/include/linux/pid_namespace.h
>> @@ -33,7 +33,6 @@ struct pid_namespace {
>>  	unsigned int level;
>>  	struct pid_namespace *parent;
>>  #ifdef CONFIG_PROC_FS
>> -	struct vfsmount *proc_mnt;
>>  	struct dentry *proc_self;
>>  	struct dentry *proc_thread_self;
>>  #endif
>> @@ -42,7 +41,6 @@ struct pid_namespace {
>>  #endif
>>  	struct user_namespace *user_ns;
>>  	struct ucounts *ucounts;
>> -	struct work_struct proc_work;
>>  	kgid_t pid_gid;
>>  	int hide_pid;
>>  	int reboot;	/* group exit code if this pidns was rebooted */
>> diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
>> index 4626b1ac3b6c..e1106a077c1a 100644
>> --- a/include/linux/proc_ns.h
>> +++ b/include/linux/proc_ns.h
>> @@ -50,16 +50,11 @@ enum {
>>  
>>  #ifdef CONFIG_PROC_FS
>>  
>> -extern int pid_ns_prepare_proc(struct pid_namespace *ns);
>> -extern void pid_ns_release_proc(struct pid_namespace *ns);
>>  extern int proc_alloc_inum(unsigned int *pino);
>>  extern void proc_free_inum(unsigned int inum);
>>  
>>  #else /* CONFIG_PROC_FS */
>>  
>> -static inline int pid_ns_prepare_proc(struct pid_namespace *ns) { return 0; }
>> -static inline void pid_ns_release_proc(struct pid_namespace *ns) {}
>> -
>>  static inline int proc_alloc_inum(unsigned int *inum)
>>  {
>>  	*inum = 1;
>> diff --git a/kernel/pid.c b/kernel/pid.c
>> index ca08d6a3aa77..60820e72634c 100644
>> --- a/kernel/pid.c
>> +++ b/kernel/pid.c
>> @@ -144,9 +144,6 @@ void free_pid(struct pid *pid)
>>  			/* Handle a fork failure of the first process */
>>  			WARN_ON(ns->child_reaper);
>>  			ns->pid_allocated = 0;
>> -			/* fall through */
>> -		case 0:
>> -			schedule_work(&ns->proc_work);
>>  			break;
>>  		}
>>  
>> @@ -247,11 +244,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
>>  		tmp = tmp->parent;
>>  	}
>>  
>> -	if (unlikely(is_child_reaper(pid))) {
>> -		if (pid_ns_prepare_proc(ns))
>> -			goto out_free;
>> -	}
>> -
>>  	get_pid_ns(ns);
>>  	refcount_set(&pid->count, 1);
>>  	for (type = 0; type < PIDTYPE_MAX; ++type)
>> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
>> index d40017e79ebe..318fcc6ba301 100644
>> --- a/kernel/pid_namespace.c
>> +++ b/kernel/pid_namespace.c
>> @@ -57,12 +57,6 @@ static struct kmem_cache *create_pid_cachep(unsigned int level)
>>  	return READ_ONCE(*pkc);
>>  }
>>  
>> -static void proc_cleanup_work(struct work_struct *work)
>
> There's a comment in kernel/pid_namespace.c that references
> proc_cleanup_work(). Can you please remove that as well?

Good catch.  It isn't immediately obvious to me how that sentence
needs to be updated but it should be done.

Eric


>> -{
>> -	struct pid_namespace *ns = container_of(work, struct pid_namespace, proc_work);
>> -	pid_ns_release_proc(ns);
>> -}
>> -
>>  static struct ucounts *inc_pid_namespaces(struct user_namespace *ns)
>>  {
>>  	return inc_ucount(ns, current_euid(), UCOUNT_PID_NAMESPACES);
>> @@ -114,7 +108,6 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
>>  	ns->user_ns = get_user_ns(user_ns);
>>  	ns->ucounts = ucounts;
>>  	ns->pid_allocated = PIDNS_ADDING;
>> -	INIT_WORK(&ns->proc_work, proc_cleanup_work);
>>  
>>  	return ns;
>>  
>> -- 
>> 2.25.0
>> 
