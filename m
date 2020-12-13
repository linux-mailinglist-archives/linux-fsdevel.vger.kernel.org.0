Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D732D8DEC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Dec 2020 15:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgLMOYU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Dec 2020 09:24:20 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:45992 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLMOYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Dec 2020 09:24:06 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1koSHQ-0088st-9C; Sun, 13 Dec 2020 07:23:20 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1koSHL-00089n-7m; Sun, 13 Dec 2020 07:23:20 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201204000212.773032-1-stephen.s.brennan@oracle.com>
        <20201212205522.GF2443@casper.infradead.org>
Date:   Sun, 13 Dec 2020 08:22:32 -0600
In-Reply-To: <20201212205522.GF2443@casper.infradead.org> (Matthew Wilcox's
        message of "Sat, 12 Dec 2020 20:55:22 +0000")
Message-ID: <877dpln5uf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1koSHL-00089n-7m;;;mid=<877dpln5uf.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18GcGxMolQ2R37qJNnK7xeJF6oKU8YDCBs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Matthew Wilcox <willy@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4670 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 9 (0.2%), b_tie_ro: 8 (0.2%), parse: 0.94 (0.0%),
        extract_message_metadata: 12 (0.3%), get_uri_detail_list: 1.49 (0.0%),
        tests_pri_-1000: 5 (0.1%), tests_pri_-950: 1.25 (0.0%),
        tests_pri_-900: 1.03 (0.0%), tests_pri_-90: 235 (5.0%), check_bayes:
        233 (5.0%), b_tokenize: 8 (0.2%), b_tok_get_all: 8 (0.2%),
        b_comp_prob: 2.5 (0.1%), b_tok_touch_all: 86 (1.8%), b_finish: 0.74
        (0.0%), tests_pri_0: 252 (5.4%), check_dkim_signature: 0.60 (0.0%),
        check_dkim_adsp: 2.6 (0.1%), poll_dns_idle: 4138 (88.6%),
        tests_pri_10: 1.81 (0.0%), tests_pri_500: 4148 (88.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v2] proc: Allow pid_revalidate() during LOOKUP_RCU
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> On Thu, Dec 03, 2020 at 04:02:12PM -0800, Stephen Brennan wrote:
>> -void pid_update_inode(struct task_struct *task, struct inode *inode)
>> +static int do_pid_update_inode(struct task_struct *task, struct inode *inode,
>> +			       unsigned int flags)
>
> I'm really nitpicking here, but this function only _updates_ the inode
> if flags says it should.  So I was thinking something like this
> (compile tested only).
>
> I'd really appreocate feedback from someone like Casey or Stephen on
> what they need for their security modules.

Just so we don't have security module questions confusing things
can we please make this a 2 patch series?  With the first
patch removing security_task_to_inode?

The justification for the removal is that all security_task_to_inode
appears to care about is the file type bits in inode->i_mode.  Something
that never changes.  Having this in a separate patch would make that
logical change easier to verify.

Eric

>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index b362523a9829..771f330bfce7 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1968,6 +1968,25 @@ void pid_update_inode(struct task_struct *task, struct inode *inode)
>  	security_task_to_inode(task, inode);
>  }
>  
> +/* See if we can avoid the above call.  Assumes RCU lock held */
> +static bool inode_needs_pid_update(struct task_struct *task,
> +		const struct inode *inode)
> +{
> +	kuid_t uid;
> +	kgid_t gid;
> +
> +	if (inode->i_mode & (S_ISUID | S_ISGID))
> +		return true;
> +	task_dump_owner(task, inode->i_mode, &uid, &gid);
> +	if (!uid_eq(uid, inode->i_uid) || !gid_eq(gid, inode->i_gid))
> +		return true;
> +	/*
> +	 * XXX: Do we need to call the security system here to see if
> +	 * there's a pending update?
> +	 */
> +	return false;
> +}
> +
>  /*
>   * Rewrite the inode's ownerships here because the owning task may have
>   * performed a setuid(), etc.
> @@ -1978,8 +1997,15 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
>  	struct inode *inode;
>  	struct task_struct *task;
>  
> -	if (flags & LOOKUP_RCU)
> +	if (flags & LOOKUP_RCU) {
> +		inode = d_inode_rcu(dentry);
> +		task = pid_task(proc_pid(inode), PIDTYPE_PID);
> +		if (!task)
> +			return 0;
> +		if (!inode_needs_pid_update(task, inode))
> +			return 1;
>  		return -ECHILD;
> +	}
>  
>  	inode = d_inode(dentry);
>  	task = get_proc_task(inode);
