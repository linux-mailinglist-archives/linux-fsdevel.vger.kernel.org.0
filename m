Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BD839D110
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFFThG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:37:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:39050 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhFFThF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:37:05 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lpyYE-00FlQA-8k; Sun, 06 Jun 2021 13:35:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lpyYD-007nKe-97; Sun, 06 Jun 2021 13:35:13 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Sun, 06 Jun 2021 14:34:53 -0500
In-Reply-To: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
        (Bernd Edlinger's message of "Sun, 6 Jun 2021 12:41:18 +0200")
Message-ID: <87mts2kcrm.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lpyYD-007nKe-97;;;mid=<87mts2kcrm.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19tkxyVQPNifWvgwI/68HlKr0bp7WhB3vk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Bernd Edlinger <bernd.edlinger@hotmail.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 388 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 13 (3.3%), b_tie_ro: 11 (2.8%), parse: 1.34
        (0.3%), extract_message_metadata: 20 (5.1%), get_uri_detail_list: 1.34
        (0.3%), tests_pri_-1000: 16 (4.1%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.05 (0.3%), tests_pri_-90: 83 (21.3%), check_bayes:
        80 (20.5%), b_tokenize: 7 (1.8%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 2.7 (0.7%), b_tok_touch_all: 59 (15.2%), b_finish: 1.42
        (0.4%), tests_pri_0: 240 (61.7%), check_dkim_signature: 0.69 (0.2%),
        check_dkim_adsp: 12 (3.1%), poll_dns_idle: 0.57 (0.1%), tests_pri_10:
        2.0 (0.5%), tests_pri_500: 8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] Fix error handling in begin_new_exec
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bernd Edlinger <bernd.edlinger@hotmail.de> writes:

> If get_unused_fd_flags() fails, the error handling is incomplete
> because bprm->cred is already set to NULL, and therefore
> free_bprm will not unlock the cred_guard_mutex.
> Note there are two error conditions which end up here,
> one before and one after bprm->cred is cleared.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yuck.  I wonder if there is a less error prone idiom we could be using
here than testing bprm->cred in free_bprm.  Especially as this lock is
expected to stay held through setup_new_exec.

Something feels too clever here.

> Fixes: b8a61c9e7b4 ("exec: Generic execfd support")
>
> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
> ---
>  fs/exec.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 18594f1..d8af85f 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1396,6 +1396,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  out_unlock:
>  	up_write(&me->signal->exec_update_lock);
> +	if (!bprm->cred)
> +		mutex_unlock(&me->signal->cred_guard_mutex);
> +
>  out:
>  	return retval;
>  }
