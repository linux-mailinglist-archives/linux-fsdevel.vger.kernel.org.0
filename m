Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EF93B982A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 23:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhGAVcu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 1 Jul 2021 17:32:50 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:56374 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhGAVct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:32:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lz4GH-00CpMw-6s; Thu, 01 Jul 2021 15:30:17 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:51248 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lz4GG-00BSx2-16; Thu, 01 Jul 2021 15:30:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     =?utf-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
Cc:     "mingo\@kernel.org" <mingo@kernel.org>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "christian.brauner\@ubuntu.com" <christian.brauner@ubuntu.com>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "ohkwon1043\@gmail.com" <ohkwon1043@gmail.com>,
        "linux-fsdevel\@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960@epcms1p6>
        <20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960@epcms1p6>
Date:   Thu, 01 Jul 2021 16:30:08 -0500
In-Reply-To: <20210701133458epcms1p68e9eb9bd0eee8903ba26679a37d9d960@epcms1p6>
        (=?utf-8?B?Iuq2jOyYpO2biCIncw==?= message of "Thu, 01 Jul 2021 22:34:58
 +0900")
Message-ID: <8735sxoh7j.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lz4GG-00BSx2-16;;;mid=<8735sxoh7j.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+smKkMX3KmnngliXe32SDrbemFpTMFVKU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4877]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?;=ea=b6=8c=ec=98=a4=ed=9b=88 <ohoono.kwon@samsung.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 524 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 9 (1.6%), b_tie_ro: 7 (1.4%), parse: 1.07 (0.2%),
        extract_message_metadata: 12 (2.3%), get_uri_detail_list: 1.31 (0.2%),
        tests_pri_-1000: 6 (1.1%), tests_pri_-950: 1.34 (0.3%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 50 (9.5%), check_bayes: 48
        (9.2%), b_tokenize: 7 (1.3%), b_tok_get_all: 5 (1.0%), b_comp_prob:
        2.2 (0.4%), b_tok_touch_all: 31 (5.9%), b_finish: 0.72 (0.1%),
        tests_pri_0: 257 (49.1%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 3.2 (0.6%), poll_dns_idle: 164 (31.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 182 (34.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] connector: send event on write to /proc/[pid]/comm
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

권오훈 <ohoono.kwon@samsung.com> writes:

> While comm change event via prctl has been reported to proc connector by
> 'commit f786ecba4158 ("connector: add comm change event report to proc
> connector")', connector listeners were missing comm changes by explicit
> writes on /proc/[pid]/comm.
>
> Let explicit writes on /proc/[pid]/comm report to proc connector.

Is connector really useful?  I am under the impression that connector
did not get much if any real uptake of users.

I know the impression that connector is not used and that there
are generally better mechanisms for what it provides has led to
connector not getting any namespace support.  Similarly bugs
like the one you just have found persist.

If connector is actually useful then it is worth fixing little things
like this.  But if no one is really using connector I suspect a better
patch direction would be to start figuring out how to deprecate and
remove connector.

Eric


> Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
> ---
>  fs/proc/base.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9cbd915025ad..3e1e6b56aa96 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -95,6 +95,7 @@
>  #include <linux/posix-timers.h>
>  #include <linux/time_namespace.h>
>  #include <linux/resctrl.h>
> +#include <linux/cn_proc.h>
>  #include <trace/events/oom.h>
>  #include "internal.h"
>  #include "fd.h"
> @@ -1674,8 +1675,10 @@ static ssize_t comm_write(struct file *file, const char __user *buf,
>  	if (!p)
>  		return -ESRCH;
>  
> -	if (same_thread_group(current, p))
> +	if (same_thread_group(current, p)) {
>  		set_task_comm(p, buffer);
> +		proc_comm_connector(p);
> +	}
>  	else
>  		count = -EINVAL;
