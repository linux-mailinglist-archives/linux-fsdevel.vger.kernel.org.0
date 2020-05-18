Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5DA1D791C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgERNBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 09:01:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44414 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 09:01:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jafO5-0005ha-50; Mon, 18 May 2020 07:00:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jafO3-0003dN-W5; Mon, 18 May 2020 07:00:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+c1af344512918c61362c@syzkaller.appspotmail.com>,
        jmorris@namei.org, linux-next@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <87lfltcbc4.fsf@x220.int.ebiederm.org>
        <20200518111716.2896385-1-gladkov.alexey@gmail.com>
        <871rnh78di.fsf@x220.int.ebiederm.org>
        <20200518125648.robgr7mud7esao2o@comp-core-i7-2640m-0182e6>
Date:   Mon, 18 May 2020 07:57:16 -0500
In-Reply-To: <20200518125648.robgr7mud7esao2o@comp-core-i7-2640m-0182e6>
        (Alexey Gladkov's message of "Mon, 18 May 2020 14:56:48 +0200")
Message-ID: <87pnb15rkj.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jafO3-0003dN-W5;;;mid=<87pnb15rkj.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+7voJjdUzm6K/RfqhwLgvU8mZCtMfUl1k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 648 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.32
        (0.2%), extract_message_metadata: 12 (1.8%), get_uri_detail_list: 1.33
        (0.2%), tests_pri_-1000: 20 (3.1%), tests_pri_-950: 1.70 (0.3%),
        tests_pri_-900: 1.45 (0.2%), tests_pri_-90: 116 (18.0%), check_bayes:
        114 (17.5%), b_tokenize: 18 (2.8%), b_tok_get_all: 9 (1.3%),
        b_comp_prob: 3.6 (0.6%), b_tok_touch_all: 79 (12.2%), b_finish: 1.05
        (0.2%), tests_pri_0: 363 (56.0%), check_dkim_signature: 0.74 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.34 (0.1%), tests_pri_10:
        3.7 (0.6%), tests_pri_500: 113 (17.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] proc: proc_pid_ns takes super_block as an argument
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> On Mon, May 18, 2020 at 07:08:57AM -0500, Eric W. Biederman wrote:
>> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
>> 
>> > The proc_pid_ns() can be used for both inode and dentry. To avoid making
>> > two identical functions, change the argument type of the proc_pid_ns().
>> >
>> > Link: https://lore.kernel.org/lkml/c3461e26-1407-2262-c709-dac0df3da2d0@i-love.sakura.ne.jp/
>> > Reported-by: syzbot+c1af344512918c61362c@syzkaller.appspotmail.com
>> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
>> 
>> So overall this looks good.
>> 
>> However, the description leaves a little bit to be desired as it does
>> not describe why it is bad to use dentry->d_sb.  A fixes tag would be
>> nice if for no other reason than to help anyone who decides to backport
>> this.
>
> OK. I will add it.

Thank you.  It really helps to have the full description of why in
the commit comments.

>> And can you please compile test this?
>> 
>> There is a very silly typo in proc that keeps this from compiling.
>
> I compiled the kernel with this patch and ran the kernel, but accidentally
> did not check children_seq_show(). Sorry.

Yes, children_seq_show is behind a sneaky CONFIG option.

Eric
