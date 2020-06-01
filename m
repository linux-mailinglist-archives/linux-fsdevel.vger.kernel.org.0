Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5B1EA676
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFAPFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 11:05:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:35358 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAPFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:05:17 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jfm03-0000SP-Ip; Mon, 01 Jun 2020 09:05:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jfm02-0004wi-68; Mon, 01 Jun 2020 09:05:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        keescook@chromium.org, yzaikin@google.com
References: <20200531112444.GA25164@noodle>
Date:   Mon, 01 Jun 2020 10:01:18 -0500
In-Reply-To: <20200531112444.GA25164@noodle> (Boris Sukholitko's message of
        "Sun, 31 May 2020 14:24:44 +0300")
Message-ID: <871rmyn83l.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jfm02-0004wi-68;;;mid=<871rmyn83l.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+teQ2SrwboPr+1B+zF3gcX9MNLf1u45Us=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4940]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Boris Sukholitko <boris.sukholitko@broadcom.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 746 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.48
        (0.2%), extract_message_metadata: 19 (2.6%), get_uri_detail_list: 3.2
        (0.4%), tests_pri_-1000: 7 (1.0%), tests_pri_-950: 1.76 (0.2%),
        tests_pri_-900: 1.47 (0.2%), tests_pri_-90: 224 (30.0%), check_bayes:
        217 (29.1%), b_tokenize: 13 (1.8%), b_tok_get_all: 50 (6.8%),
        b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 147 (19.8%), b_finish: 0.84
        (0.1%), tests_pri_0: 465 (62.4%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 1.90 (0.3%), poll_dns_idle: 0.38 (0.1%),
        tests_pri_10: 2.4 (0.3%), tests_pri_500: 7 (0.9%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] get_subdir: do not drop new subdir if returning it
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Boris Sukholitko <boris.sukholitko@broadcom.com> writes:

> In testing of our kernel (based on 4.19, tainted, sorry!) on our aarch64 based hardware
> we've come upon the following oops (lightly edited to omit irrelevant
> details):


I don't doubt you are seeing problems.

I need to refresh my knowledge of that code to know for certain but I am
not yet convinced this is the problem.

I don't see any reason that the assertion your code makes would
necessarily be a problem.

Why can't a directory only have a single entry?

I am not saying you are wrong.  Just that I have not looked enough to
verify there is an invariant being violated there.


A very confusiong part of this situation is the fact he code has been
stable for quite a while.  I would have suspected someone's fuzzer to
trigger problems on something other than aarch64.  Especially if
registering and unregistering a network device is enough to cause this.
As that can be performed as non-root.

Eric

> The crash is in the call to count_subheaders(header->ctl_table_arg).
>
> Although the header (being in x19 == 0xffffffc01f0d6030) looks like a
> normal kernel pointer, ctl_table_arg (x0 == 0x0000000000007a12) looks
> invalid.
>
> Trying to find the issue, we've started tracing header allocation being
> done by kzalloc in __register_sysctl_table and header freeing being done
> in drop_sysctl_table.
>
> Then we've noticed headers being freed which where not allocated before.
> The faulty freeing was done on parent->header at the end of
> drop_sysctl_table.
>
> The invariant on __register_sysctl_table seems to be that non-empty
> parent dir should have its header.nreg > 1. By failing this invariant
> (see WARN_ON hunk in the patch) we've come upon the conclusion that
> something is fishy with nreg counting.
>
> The root cause seems to be dropping new subdir in get_subdir function.
> Here are the new subdir adventures leading to the invariant failure
> above:
>
> 1. new subdir comes to being with nreg == 1
> 2. the nreg is being incremented in the found clause, nreg == 2
> 3. nreg is being decremented by the if (new) drop, nreg == 1
> 4. coming out of get_subdir, insert_header increments nreg: nreg == 2
> 5. nreg is being decremented at the end of __register_sysctl_table
>
> The fix seems to be avoiding step 3 if new subdir is the one being
> returned. The patch does this and also adds warning for the nreg
> invariant.
> ---
>  fs/proc/proc_sysctl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b6f5d459b087..12fa5803dcb3 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1010,7 +1010,7 @@ static struct ctl_dir *get_subdir(struct ctl_dir *dir,
>  			namelen, namelen, name, PTR_ERR(subdir));
>  	}
>  	drop_sysctl_table(&dir->header);
> -	if (new)
> +	if (new && new != subdir)
>  		drop_sysctl_table(&new->header);
>  	spin_unlock(&sysctl_lock);
>  	return subdir;
> @@ -1334,6 +1334,7 @@ struct ctl_table_header *__register_sysctl_table(
>  		goto fail_put_dir_locked;
>  
>  	drop_sysctl_table(&dir->header);
> +	WARN_ON(dir->header.nreg < 2);
>  	spin_unlock(&sysctl_lock);
>  
>  	return header;
