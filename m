Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AD547C361
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Dec 2021 16:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhLUP40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Dec 2021 10:56:26 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:50522 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236690AbhLUP4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:56:25 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:33234)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzhV1-003gN3-Uw; Tue, 21 Dec 2021 08:56:24 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:49674 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mzhUz-00H9yH-EX; Tue, 21 Dec 2021 08:56:22 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Waiman Long <longman@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Vivier <laurent@vivier.eu>,
        YunQiang Su <ysu@wavecomp.com>, Helge Deller <deller@gmx.de>
References: <20211221021744.864115-1-longman@redhat.com>
Date:   Tue, 21 Dec 2021 09:55:55 -0600
In-Reply-To: <20211221021744.864115-1-longman@redhat.com> (Waiman Long's
        message of "Mon, 20 Dec 2021 21:17:44 -0500")
Message-ID: <87lf0e7y0k.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mzhUz-00H9yH-EX;;;mid=<87lf0e7y0k.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.161.49;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18U2aPtJ7SsPDwfN7xIrscU+68zQg5I4G0=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Waiman Long <longman@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 728 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 14 (2.0%), b_tie_ro: 12 (1.6%), parse: 1.13
        (0.2%), extract_message_metadata: 4.6 (0.6%), get_uri_detail_list:
        1.97 (0.3%), tests_pri_-1000: 3.8 (0.5%), tests_pri_-950: 1.43 (0.2%),
        tests_pri_-900: 1.23 (0.2%), tests_pri_-90: 316 (43.4%), check_bayes:
        314 (43.1%), b_tokenize: 8 (1.1%), b_tok_get_all: 10 (1.4%),
        b_comp_prob: 3.0 (0.4%), b_tok_touch_all: 287 (39.5%), b_finish: 1.23
        (0.2%), tests_pri_0: 365 (50.2%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 3.5 (0.5%), poll_dns_idle: 1.63 (0.2%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: Make suid_dumpable apply to SUID/SGID binaries irrespective of invoking users
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> The begin_new_exec() function checks for SUID or SGID binaries by
> comparing effective uid and gid against real uid and gid and using
> the suid_dumpable sysctl parameter setting only if either one of them
> differs.
>
> In the special case that the uid and/or gid of the SUID/SGID binaries
> matches the id's of the user invoking it, the suid_dumpable is not
> used and SUID_DUMP_USER will be used instead. The documentation for the
> suid_dumpable sysctl parameter does not include that exception and so
> this will be an undocumented behavior.
>
> Eliminate this undocumented behavior by adding a flag in the linux_binprm
> structure to designate a SUID/SGID binary and use it for determining
> if the suid_dumpable setting should be applied or not.

I see that you are making the code match the documentation.
What harm/problems does this mismatch cause in practice?
What is the motivation for this change?

I am trying to see the motivation but all I can see is that
in the case where suid and sgid do nothing in practice the code
does not change dumpable.  The point of dumpable is to refuse to
core dump when it is not safe.  In this case since nothing happened
in practice it is safe.

So how does this matter in practice.  If there isn't a good
motivation my feel is that it is the documentation that needs to be
updated rather than the code.

There are a lot of warts to the suid/sgid handling during exec.  This
just doesn't look like one of them.

Eric


> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/exec.c               | 6 +++---
>  include/linux/binfmts.h | 5 ++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 537d92c41105..60e02e678fb6 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1344,9 +1344,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	 * is wrong, but userspace depends on it. This should be testing
>  	 * bprm->secureexec instead.
>  	 */
> -	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP ||
> -	    !(uid_eq(current_euid(), current_uid()) &&
> -	      gid_eq(current_egid(), current_gid())))
> +	if (bprm->interp_flags & BINPRM_FLAGS_ENFORCE_NONDUMP || bprm->is_sugid)
>  		set_dumpable(current->mm, suid_dumpable);
>  	else
>  		set_dumpable(current->mm, SUID_DUMP_USER);
> @@ -1619,11 +1617,13 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
>  	if (mode & S_ISUID) {
>  		bprm->per_clear |= PER_CLEAR_ON_SETID;
>  		bprm->cred->euid = uid;
> +		bprm->is_sugid = 1;
>  	}
>  
>  	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
>  		bprm->per_clear |= PER_CLEAR_ON_SETID;
>  		bprm->cred->egid = gid;
> +		bprm->is_sugid = 1;
>  	}
>  }
>  
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 049cf9421d83..6d9893c59085 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -41,7 +41,10 @@ struct linux_binprm {
>  		 * Set when errors can no longer be returned to the
>  		 * original userspace.
>  		 */
> -		point_of_no_return:1;
> +		point_of_no_return:1,
> +
> +		/* Is a SUID or SGID binary? */
> +		is_sugid:1;
>  #ifdef __alpha__
>  	unsigned int taso:1;
>  #endif
