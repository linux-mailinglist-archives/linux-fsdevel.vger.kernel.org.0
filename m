Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AF3A8993
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 21:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFOTfj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 15:35:39 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41654 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhFOTfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:35:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltEoR-00FcZ9-Jh; Tue, 15 Jun 2021 13:33:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ltEoQ-00FCWx-Iw; Tue, 15 Jun 2021 13:33:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org
References: <20210615162346.16032-1-avagin@gmail.com>
Date:   Tue, 15 Jun 2021 14:33:20 -0500
In-Reply-To: <20210615162346.16032-1-avagin@gmail.com> (Andrei Vagin's message
        of "Tue, 15 Jun 2021 09:23:46 -0700")
Message-ID: <877diuq5xb.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ltEoQ-00FCWx-Iw;;;mid=<877diuq5xb.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18fPznuT9OQnyAy9vxmYnMlBimMoJi+D8s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4500]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andrei Vagin <avagin@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 308 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (3.4%), b_tie_ro: 9 (3.0%), parse: 0.77 (0.2%),
         extract_message_metadata: 11 (3.5%), get_uri_detail_list: 0.99 (0.3%),
         tests_pri_-1000: 13 (4.3%), tests_pri_-950: 1.18 (0.4%),
        tests_pri_-900: 1.02 (0.3%), tests_pri_-90: 78 (25.4%), check_bayes:
        77 (25.0%), b_tokenize: 5 (1.6%), b_tok_get_all: 5 (1.6%),
        b_comp_prob: 1.68 (0.5%), b_tok_touch_all: 62 (20.2%), b_finish: 0.84
        (0.3%), tests_pri_0: 181 (58.7%), check_dkim_signature: 0.48 (0.2%),
        check_dkim_adsp: 2.8 (0.9%), poll_dns_idle: 0.97 (0.3%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec/binfmt_script: trip zero bytes from the buffer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrei Vagin <avagin@gmail.com> writes:

> Without this fix, if we try to run a script that contains only the
> interpreter line, the interpreter is executed with one extra empty
> argument.
>
> The code is written so that i_end has to be set to the end of valuable
> data in the buffer.

Out of curiosity how did you spot this change in behavior?

> Fixes: ccbb18b67323 ("exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC")
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  fs/binfmt_script.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/binfmt_script.c b/fs/binfmt_script.c
> index 1b6625e95958..e242680f96e1 100644
> --- a/fs/binfmt_script.c
> +++ b/fs/binfmt_script.c
> @@ -68,6 +68,9 @@ static int load_script(struct linux_binprm *bprm)
>  		if (!next_terminator(i_end, buf_end))
>  			return -ENOEXEC;
>  		i_end = buf_end;
> +		/* Trim zero bytes from i_end */
> +		while (i_end[-1] == 0)
> +			i_end--;
>  	}
>  	/* Trim any trailing spaces/tabs from i_end */
>  	while (spacetab(i_end[-1]))
