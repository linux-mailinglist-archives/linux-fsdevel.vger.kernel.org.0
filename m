Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571E72D8DF9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 15:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbgLMOcH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 09:32:07 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:51716 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbgLMOcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 09:32:07 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1koSPE-00Bszy-RQ; Sun, 13 Dec 2020 07:31:24 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1koSPD-004PaC-M5; Sun, 13 Dec 2020 07:31:24 -0700
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
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
Date:   Sun, 13 Dec 2020 08:30:40 -0600
In-Reply-To: <20201204000212.773032-1-stephen.s.brennan@oracle.com> (Stephen
        Brennan's message of "Thu, 3 Dec 2020 16:02:12 -0800")
Message-ID: <87tusplqwf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1koSPD-004PaC-M5;;;mid=<87tusplqwf.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/hhLWeR0iNmzKi0FoZCOw50QiC44pJLLw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4827]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stephen Brennan <stephen.s.brennan@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 570 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.6%), b_tie_ro: 2.6 (0.4%), parse: 0.69
        (0.1%), extract_message_metadata: 2.4 (0.4%), get_uri_detail_list:
        0.91 (0.2%), tests_pri_-1000: 3.0 (0.5%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.84 (0.1%), tests_pri_-90: 59 (10.3%), check_bayes:
        57 (10.1%), b_tokenize: 6 (1.0%), b_tok_get_all: 11 (1.9%),
        b_comp_prob: 1.54 (0.3%), b_tok_touch_all: 37 (6.4%), b_finish: 0.76
        (0.1%), tests_pri_0: 486 (85.2%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 283 (49.6%), poll_dns_idle: 280 (49.1%),
        tests_pri_10: 1.85 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Stephen Brennan <stephen.s.brennan@oracle.com> writes:

> The pid_revalidate() function requires dropping from RCU into REF lookup
> mode. When many threads are resolving paths within /proc in parallel,
> this can result in heavy spinlock contention as each thread tries to
> grab a reference to the /proc dentry lock (and drop it shortly
> thereafter).

I am feeling dense at the moment.  Which lock specifically are you
referring to?  The only locks I can thinking of are sleeping locks,
not spinlocks.

> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index ebea9501afb8..833d55a59e20 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1830,19 +1846,22 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  {
>  	struct inode *inode;
>  	struct task_struct *task;
> +	int rv = 0;
>  
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
> +	if (flags & LOOKUP_RCU) {

Why do we need to test flags here at all?
Why can't the code simply take an rcu_read_lock unconditionally and just
pass flags into do_pid_update_inode?


> +		inode = d_inode_rcu(dentry);
> +		task = pid_task(proc_pid(inode), PIDTYPE_PID);
> +		if (task)
> +			rv = do_pid_update_inode(task, inode, flags);
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

Eric
