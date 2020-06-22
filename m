Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D61203A81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 17:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgFVPRi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 11:17:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39900 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgFVPRh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:17:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnOCV-0005Cb-Cu; Mon, 22 Jun 2020 09:17:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jnOCR-0000y0-78; Mon, 22 Jun 2020 09:17:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin\@oracle.com" <joe.jin@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
        <20200618233958.GV8681@bombadil.infradead.org>
        <877dw3apn8.fsf@x220.int.ebiederm.org>
        <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
        <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
        <CAK7LNARr4aWTUqcS5TGdQ-7C_u=PFQVMMuakQ2Oro3-43fYu9w@mail.gmail.com>
Date:   Mon, 22 Jun 2020 10:13:09 -0500
In-Reply-To: <CAK7LNARr4aWTUqcS5TGdQ-7C_u=PFQVMMuakQ2Oro3-43fYu9w@mail.gmail.com>
        (Masahiro Yamada's message of "Mon, 22 Jun 2020 14:33:39 +0900")
Message-ID: <87366n3zi2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jnOCR-0000y0-78;;;mid=<87366n3zi2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZgWqSSIIIXle/OLCQxkd+7UIjr08oNT0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2696]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Masahiro Yamada <masahiroy@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3821 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (0.3%), b_tie_ro: 11 (0.3%), parse: 0.81
        (0.0%), extract_message_metadata: 13 (0.3%), get_uri_detail_list: 1.66
        (0.0%), tests_pri_-1000: 13 (0.3%), tests_pri_-950: 1.03 (0.0%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 73 (1.9%), check_bayes: 71
        (1.9%), b_tokenize: 6 (0.2%), b_tok_get_all: 8 (0.2%), b_comp_prob:
        2.9 (0.1%), b_tok_touch_all: 51 (1.3%), b_finish: 0.80 (0.0%),
        tests_pri_0: 510 (13.3%), check_dkim_signature: 0.57 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 3174 (83.1%),
        tests_pri_10: 1.68 (0.0%), tests_pri_500: 3193 (83.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc dentries
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Masahiro Yamada <masahiroy@kernel.org> writes:

> On Fri, Jun 19, 2020 at 11:14 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>>
>> Junxiao Bi <junxiao.bi@oracle.com> reported:
>> > When debugging some performance issue, i found that thousands of threads exit
>> > around same time could cause a severe spin lock contention on proc dentry
>> > "/proc/$parent_process_pid/task/", that's because threads needs to clean up
>> > their pid file from that dir when exit.
>>
>> Matthew Wilcox <willy@infradead.org> reported:
>> > We've looked at a few different ways of fixing this problem.
>>
>> The flushing of the proc dentries from the dcache is an optmization,
>> and is not necessary for correctness.  Eventually cache pressure will
>> cause the dentries to be freed even if no flushing happens.  Some
>> light testing when I refactored the proc flushg[1] indicated that at
>> least the memory footprint is easily measurable.
>>
>> An optimization that causes a performance problem due to a thundering
>> herd of threads is no real optimization.
>>
>> Modify the code to only flush the /proc/<tgid>/ directory when all
>> threads in a process are killed at once.  This continues to flush
>> practically everything when the process is reaped as the threads live
>> under /proc/<tgid>/task/<tid>.
>>
>> There is a rare possibility that a debugger will access /proc/<tid>/,
>> which this change will no longer flush, but I believe such accesses
>> are sufficiently rare to not be observed in practice.
>>
>> [1] 7bc3e6e55acf ("proc: Use a list of inodes to flush from proc")
>> Link: https://lkml.kernel.org/r/54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com
>
>
>> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
>
> I did not report this.

Thank you for catching this.

I must have cut&pasted the wrong email address by mistake.

My apologies.

Eric
