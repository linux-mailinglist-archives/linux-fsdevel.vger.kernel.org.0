Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D61145CB39
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 18:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbhKXRmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 12:42:18 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54300 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhKXRmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:42:18 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:50392)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpwEZ-006s6u-Sb; Wed, 24 Nov 2021 10:39:04 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37296 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mpwEX-001yqe-P2; Wed, 24 Nov 2021 10:39:03 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, <akpm@linux-foundation.org>,
        <keescook@chromium.org>, <yzaikin@google.com>,
        <peterz@infradead.org>, <gregkh@linuxfoundation.org>,
        <pjt@google.com>, <liu.hailong6@zte.com.cn>,
        <andriy.shevchenko@linux.intel.com>, <sre@kernel.org>,
        <penguin-kernel@i-love.sakura.ne.jp>, <pmladek@suse.com>,
        <senozhatsky@chromium.org>, <wangqing@vivo.com>, <bcrl@kvack.org>,
        <viro@zeniv.linux.org.uk>, <jack@suse.cz>, <amir73il@gmail.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211123202347.818157-1-mcgrof@kernel.org>
        <20211123202347.818157-3-mcgrof@kernel.org>
        <87k0gygnq4.fsf@email.froward.int.ebiederm.org>
        <a2d657e4-617a-ff4b-1334-928560701589@huawei.com>
Date:   Wed, 24 Nov 2021 11:38:19 -0600
In-Reply-To: <a2d657e4-617a-ff4b-1334-928560701589@huawei.com> (Xiaoming Ni's
        message of "Wed, 24 Nov 2021 15:05:00 +0800")
Message-ID: <87zgpte9o4.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mpwEX-001yqe-P2;;;mid=<87zgpte9o4.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Xf0UUXzrti+jLXb9ArHgo3yK3Y4ykjLI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XM_B_SpammyWords,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Xiaoming Ni <nixiaoming@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1234 ms - load_scoreonly_sql: 0.16 (0.0%),
        signal_user_changed: 15 (1.2%), b_tie_ro: 12 (1.0%), parse: 2.1 (0.2%),
         extract_message_metadata: 22 (1.8%), get_uri_detail_list: 4.3 (0.4%),
        tests_pri_-1000: 9 (0.7%), tests_pri_-950: 1.91 (0.2%),
        tests_pri_-900: 1.61 (0.1%), tests_pri_-90: 166 (13.4%), check_bayes:
        156 (12.7%), b_tokenize: 14 (1.1%), b_tok_get_all: 12 (1.0%),
        b_comp_prob: 4.2 (0.3%), b_tok_touch_all: 121 (9.8%), b_finish: 1.26
        (0.1%), tests_pri_0: 995 (80.6%), check_dkim_signature: 0.95 (0.1%),
        check_dkim_adsp: 3.4 (0.3%), poll_dns_idle: 0.51 (0.0%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 13 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/9] sysctl: Move some boundary constants from sysctl.c to sysctl_vals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Xiaoming Ni <nixiaoming@huawei.com> writes:

> On 2021/11/24 12:51, Eric W. Biederman wrote:
>> Luis Chamberlain <mcgrof@kernel.org> writes:
>>
>>> From: Xiaoming Ni <nixiaoming@huawei.com>
>>>
>>> sysctl has helpers which let us specify boundary values for a min or
>>> max int value. Since these are used for a boundary check only they don't
>>> change, so move these variables to sysctl_vals to avoid adding duplicate
>>> variables. This will help with our cleanup of kernel/sysctl.c.
>>
>> Ouch.
>>
>> I kind of, sort of, have to protest.
>>
>> Where the macros that use sysctl_vals don't have a type they have caused
>> mysterious code breakage because people did not realize they can not be
>> used with sysctls that take a long instead of an int.
>>
>> This came up with when the internal storage for ucounts see
>> kernel/ucount.c changed from an int to a long.  We were quite a while
>> tracking what was going on until we realized that the code could not use
>> SYSCTL_ZERO and SYSCTL_INT_MAX and that we had to defined our own thatSYSCTL_ZERO and SYSCTL_ZERO involve dozens of files and are used in hundreds of places.
>> were long.
>>
> static unsigned long zero_ul;
> static unsigned long one_ul = 1;
> static unsigned long long_max = LONG_MAX;
> EXPORT_SYMBOL(proc_doulongvec_minmax);
>
> Yes, min/max of type unsigned long is used in multiple sysctl
> interfaces. It is necessary to add an unsigned long sysctl_val array
> to avoid repeated definitions in different .c files.
>
>> So before we extend something like this can we please change the
>> macro naming convention so that it includes the size of the type
>> we want.
>>
> The int type is the most widely used type. By default, numeric
> constants are also of the int type. SYSCTL_ZERO and SYSCTL_ZERO
> involve dozens of files and are used in hundreds of places. Whether
> only non-int macros need to be named with their type size?
>
>>
>> I am also not a fan of sysctl_vals living in proc_sysctl.  They
>> have nothing to do with the code in that file.  They would do much
>> better in kernel/sysctl.c close to the helpers that use them.
>>
> yes
>

Looking a little more.  I think it makes sense to do something like:

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 1fa2b69c6fc3..c299009421ea 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -121,8 +121,8 @@ struct ctl_table {
        struct ctl_table *child;        /* Deprecated */
        proc_handler *proc_handler;     /* Callback for text formatting */
        struct ctl_table_poll *poll;
-       void *extra1;
-       void *extra2;
+       long min;
+       long max;
 } __randomize_layout;

Nearly every use of .extra1 and .extra2 are for min and max values.
A long takes the same storage as a void * parameter.

So it would be a net saving in storage as you don't have separate
storage for the values anywhere.

There are a few cases where .extra1 is used for something else
so keeping a "void *extra" field will probably be needed.

By finishing the removal of the child field adding a "void *extra"
field can be done at no storage cost.

Having the min and max parameters in the structure has the major
advantage that there is no redirection, and no fancy games.  People
can just read the value from the structure initializer.  Plus a
conversion from int to long won't requiring changing the min and
max constants.

So really I think instead of doubling down on the error prone case
that we have and extending sysctl_vals we should just get rid of
it entirely.

It is a bit more work to make that change but the long term result is
much better.

Any chance we can do that for a cleanup instead of extending sysctl_vals?

Eric
