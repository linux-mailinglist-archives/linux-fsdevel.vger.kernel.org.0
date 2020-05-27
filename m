Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE5DE1E4651
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbgE0Opq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 10:45:46 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55694 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbgE0Opq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 10:45:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdxJQ-0000II-2h; Wed, 27 May 2020 08:45:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdxJP-0001YS-1X; Wed, 27 May 2020 08:45:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     adobriyan@gmail.com, christian@brauner.io,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com, guro@fb.com,
        walken@google.com, avagin@gmail.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200527141155.47554-1-pilgrimtao@gmail.com>
Date:   Wed, 27 May 2020 09:41:53 -0500
In-Reply-To: <20200527141155.47554-1-pilgrimtao@gmail.com> (Kaitao Cheng's
        message of "Wed, 27 May 2020 22:11:55 +0800")
Message-ID: <87k10x5tji.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jdxJP-0001YS-1X;;;mid=<87k10x5tji.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZJUROciTO0oQgmo8Eq5PTszzMpNU4F40=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4979]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kaitao Cheng <pilgrimtao@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 632 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 9 (1.4%), parse: 1.33 (0.2%),
         extract_message_metadata: 4.4 (0.7%), get_uri_detail_list: 1.45
        (0.2%), tests_pri_-1000: 6 (0.9%), tests_pri_-950: 1.94 (0.3%),
        tests_pri_-900: 1.50 (0.2%), tests_pri_-90: 90 (14.2%), check_bayes:
        88 (13.9%), b_tokenize: 8 (1.3%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 2.5 (0.4%), b_tok_touch_all: 67 (10.7%), b_finish: 0.92
        (0.1%), tests_pri_0: 495 (78.3%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 0.94 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] proc/base: Skip assignment to len when there is no error on d_path in do_proc_readlink.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kaitao Cheng <pilgrimtao@gmail.com> writes:

> we don't need {len = PTR_ERR(pathname)} when IS_ERR(pathname) is false,
> it's better to move it into if(IS_ERR(pathname)){}.

Please look at the generated code.

I believe you will find that your change will generate worse assembly.

Eric


> Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
> ---
>  fs/proc/base.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d86c0afc8a85..9509e0d42610 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1753,9 +1753,10 @@ static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
>  		return -ENOMEM;
>  
>  	pathname = d_path(path, tmp, PAGE_SIZE);
> -	len = PTR_ERR(pathname);
> -	if (IS_ERR(pathname))
> +	if (IS_ERR(pathname)) {
> +		len = PTR_ERR(pathname);
>  		goto out;
> +	}
>  	len = tmp + PAGE_SIZE - 1 - pathname;
>  
>  	if (len > buflen)
