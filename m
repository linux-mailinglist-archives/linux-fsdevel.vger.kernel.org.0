Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1538722F56A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 18:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbgG0Qco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 12:32:44 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:58066 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgG0Qcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:32:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k063O-0005DQ-1Z; Mon, 27 Jul 2020 10:32:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k063M-0005L4-S3; Mon, 27 Jul 2020 10:32:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <20200727141411.203770-1-gladkov.alexey@gmail.com>
        <20200727141411.203770-3-gladkov.alexey@gmail.com>
Date:   Mon, 27 Jul 2020 11:29:36 -0500
In-Reply-To: <20200727141411.203770-3-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Mon, 27 Jul 2020 16:14:11 +0200")
Message-ID: <87blk0ncpb.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k063M-0005L4-S3;;;mid=<87blk0ncpb.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HvToJCGgqP/yRDgtU2woGKqvlS5lpgrM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4953]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 343 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.3%), b_tie_ro: 10 (2.8%), parse: 1.43
        (0.4%), extract_message_metadata: 4.7 (1.4%), get_uri_detail_list: 2.1
        (0.6%), tests_pri_-1000: 3.4 (1.0%), tests_pri_-950: 1.33 (0.4%),
        tests_pri_-900: 0.97 (0.3%), tests_pri_-90: 70 (20.3%), check_bayes:
        68 (19.8%), b_tokenize: 6 (1.8%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 1.73 (0.5%), b_tok_touch_all: 50 (14.6%), b_finish: 1.12
        (0.3%), tests_pri_0: 230 (67.3%), check_dkim_signature: 0.54 (0.2%),
        check_dkim_adsp: 2.6 (0.7%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.2 (0.7%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v1 2/2] Show /proc/self/net only for CAP_NET_ADMIN
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> Show /proc/self/net only for CAP_NET_ADMIN if procfs is mounted with
> subset=pid option in user namespace. This is done to avoid possible
> information leakage.
>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> ---
>  fs/proc/proc_net.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
> index dba63b2429f0..11fa2c4b3529 100644
> --- a/fs/proc/proc_net.c
> +++ b/fs/proc/proc_net.c
> @@ -275,6 +275,12 @@ static struct net *get_proc_task_net(struct inode *dir)
>  	struct task_struct *task;
>  	struct nsproxy *ns;
>  	struct net *net = NULL;
> +	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
> +
> +	if ((fs_info->pidonly == PROC_PIDONLY_ON) &&
> +	    (current_user_ns() != &init_user_ns) &&
> +	    !capable(CAP_NET_ADMIN))
> +		return net;
>
>  	rcu_read_lock();
>  	task = pid_task(proc_pid(dir), PIDTYPE_PID);

Hmm.

I see 3 options going forward.

1) We just make PROC_PIDONLY_ON mean the net directory does not exist.
   No permission checks just always fail.

2) Move the permission checks into opendir/readdir and whichever
   is the appropriate method there and always allow the dentries
   to be cached.

3) Simply cache the mounters credentials and make access to the
   net directories contingent of the permisions of the mounter of
   proc.  Something like the code below.

static struct net *get_proc_task_net(struct inode *dir)
{
	struct task_struct *task;
	struct nsproxy *ns;
	struct net *net = NULL;

	rcu_read_lock();
	task = pid_task(proc_pid(dir), PIDTYPE_PID);
	if (task != NULL) {
		task_lock(task);
		ns = task->nsproxy;
		if (ns != NULL)
			net = get_net(ns->net_ns);
		task_unlock(task);
	}
	rcu_read_unlock();
	if ((fs_info->pidonly == PROC_PIDONLY_ON) &&
            !security_capable(fs_info->mounter_cred,
			      net->user_ns, CAP_SYS_ADMIN,
			      CAP_OPT_NONE)) {
		put_net(net);
		net = NULL;
	}
	return net;
}

Eric
