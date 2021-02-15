Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB3B31C10E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 18:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhBOR5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 12:57:46 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:36746 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhBOR5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 12:57:41 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lBi7G-00Ewhl-6H; Mon, 15 Feb 2021 10:56:58 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lBi7F-0007sy-8Z; Mon, 15 Feb 2021 10:56:57 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk
References: <20201214191323.173773-1-axboe@kernel.dk>
        <m1lfbrwrgq.fsf@fess.ebiederm.org>
        <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk>
Date:   Mon, 15 Feb 2021 11:56:16 -0600
In-Reply-To: <94731b5a-a83e-91b5-bc6c-6fd4aaacb704@kernel.dk> (Jens Axboe's
        message of "Sun, 14 Feb 2021 09:38:01 -0700")
Message-ID: <m1wnv9use7.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lBi7F-0007sy-8Z;;;mid=<m1wnv9use7.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1967J4c9TL3f1UdqqpMRd1Hs7BR9oOrmT0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4221]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 543 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.1%), b_tie_ro: 10 (1.9%), parse: 1.19
        (0.2%), extract_message_metadata: 14 (2.6%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 4.5 (0.8%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 79 (14.5%), check_bayes:
        77 (14.2%), b_tokenize: 8 (1.4%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 2.9 (0.5%), b_tok_touch_all: 53 (9.8%), b_finish: 1.04
        (0.2%), tests_pri_0: 277 (51.0%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 138 (25.4%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 148 (27.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCHSET v3 0/4] fs: Support for LOOKUP_NONBLOCK / RESOLVE_NONBLOCK (Insufficiently faking current?)
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 2/13/21 3:08 PM, Eric W. Biederman wrote:
>> 
>> I have to ask.  Are you doing work to verify that performing
>> path traversals and opening of files yields the same results
>> when passed to io_uring as it does when performed by the caller?
>> 
>> Looking at v5.11-rc7 it appears I can arbitrarily access the
>> io-wq thread in proc by traversing "/proc/thread-self/".
>
> Yes that looks like a bug, it needs similar treatment to /proc/self:
Agreed.


> diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
> index a553273fbd41..e8ca19371a36 100644
> --- a/fs/proc/thread_self.c
> +++ b/fs/proc/thread_self.c
> @@ -17,6 +17,13 @@ static const char *proc_thread_self_get_link(struct dentry *dentry,
>  	pid_t pid = task_pid_nr_ns(current, ns);
>  	char *name;
>  
> +	/*
> +	 * Not currently supported. Once we can inherit all of struct pid,
> +	 * we can allow this.
> +	 */
> +	if (current->flags & PF_KTHREAD)
> +		return ERR_PTR(-EOPNOTSUPP);

I suspect simply testing for PF_IO_WORKER is a better test.  As it is
the delegation to the io_worker not the fact that it is a kernel thread
that causes a problem.

I have a memory of that point being made when the smack_privileged test
and the tomoyo_kernel_service test and how to fix them was being
discussed.

>  	if (!pid)
>  		return ERR_PTR(-ENOENT);
>  	name = kmalloc(10 + 6 + 10 + 1, dentry ? GFP_KERNEL : GFP_ATOMIC);
>
> as was done in this commit:
>
> commit 8d4c3e76e3be11a64df95ddee52e99092d42fc19
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Fri Nov 13 16:47:52 2020 -0700
>
>     proc: don't allow async path resolution of /proc/self components

I suspect that would be better as PF_IO_WORKER as well.

>> Similarly it looks like opening of "/dev/tty" fails to
>> return the tty of the caller but instead fails because
>> io-wq threads don't have a tty.
>> 
>> 
>> There are a non-trivial number of places where current is used in the
>> kernel both in path traversal and in opening files, and I may be blind
>> but I have not see any work to find all of those places and make certain
>> they are safe when called from io_uring.  That worries me as that using
>> a kernel thread instead of a user thread could potential lead to
>> privilege escalation.
>
> I've got a patch queued up for 5.12 that clears ->fs and ->files for the
> thread if not explicitly inherited, and I'm working on similarly
> proactively catching these cases that could potentially be
> problematic.

Any pointers or is this all in a private tree for now?

It is difficult to follow because many of the fixes have not CC'd the
reporters or even the maintainers of the subsystems who have been
affected by this kind of issue.

Eric

