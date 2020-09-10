Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10EC265035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Sep 2020 22:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgIJUIA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 16:08:00 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50192 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgIJUGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:06:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kGSqJ-0035dM-Rh; Thu, 10 Sep 2020 14:06:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kGSqI-0000wG-QO; Thu, 10 Sep 2020 14:06:51 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-fsdevel@vger.kernel.org
References: <20200708142409.8965-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <1596027885-4730-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <20200910035750.GX1236603@ZenIV.linux.org.uk>
        <dae15011-24b0-b382-218a-c988b435fb5c@i-love.sakura.ne.jp>
        <20200910112524.GY1236603@ZenIV.linux.org.uk>
Date:   Thu, 10 Sep 2020 15:06:34 -0500
In-Reply-To: <20200910112524.GY1236603@ZenIV.linux.org.uk> (Al Viro's message
        of "Thu, 10 Sep 2020 12:25:24 +0100")
Message-ID: <878sdh5rcl.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kGSqI-0000wG-QO;;;mid=<878sdh5rcl.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19XWNGdrM+px272aSjcsNQq7ILIxB7VncU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,T_XMDrugObfuBody_08,
        XMSlimDrugH,XMSubLong,XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4965]
        *  1.0 XMSlimDrugH Weight loss drug headers
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 689 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.3%), b_tie_ro: 8 (1.1%), parse: 1.47 (0.2%),
        extract_message_metadata: 25 (3.6%), get_uri_detail_list: 3.8 (0.5%),
        tests_pri_-1000: 7 (1.1%), tests_pri_-950: 1.71 (0.2%),
        tests_pri_-900: 1.49 (0.2%), tests_pri_-90: 141 (20.4%), check_bayes:
        138 (20.1%), b_tokenize: 13 (1.8%), b_tok_get_all: 75 (10.9%),
        b_comp_prob: 4.5 (0.7%), b_tok_touch_all: 43 (6.2%), b_finish: 0.80
        (0.1%), tests_pri_0: 264 (38.2%), check_dkim_signature: 0.78 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 219 (31.7%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 232 (33.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] fput: Allow calling __fput_sync() from !PF_KTHREAD thread.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Sep 10, 2020 at 02:26:46PM +0900, Tetsuo Handa wrote:
>> Thank you for responding. I'm also waiting for your response on
>> "[RFC PATCH] pipe: make pipe_release() deferrable." at 
>> https://lore.kernel.org/linux-fsdevel/7ba35ca4-13c1-caa3-0655-50d328304462@i-love.sakura.ne.jp/
>> and "[PATCH] splice: fix premature end of input detection" at 
>> https://lore.kernel.org/linux-block/cf26a57e-01f4-32a9-0b2c-9102bffe76b2@i-love.sakura.ne.jp/ .
>> 
>> > 
>> > NAK.  The reason to defer is *NOT* to bypass that BUG_ON() - we really do not
>> > want that thing done on anything other than extremely shallow stack.
>> > Incidentally, why is that thing ever done _not_ in a kernel thread context?
>> 
>> What does "that thing" refer to? acct_pin_kill() ? blob_to_mnt() ?
>> I don't know the reason because I'm not the author of these functions.
>
> 	The latter.  What I mean, why not simply do that from inside of
> fork_usermode_driver()?

Because that is a stupid place to do the work.  The usermode driver is
currently allowed to die and the kernel be respawned when needed.  Which
means there is not a 1 to 1 relationship between blob_to_mnt and
fork_usermode_driver.

As for the current code being racy, it is approxiamtely as racy as the
current code to load files init an initrd.  AKA no one has ever observed
any problems in practice but if you squint you can see where maybe
something could happen.

I think there is a stronger argument for finding a way to guarantee
that flush_delayed_fput will wait until any scheduled delayed_fput_work
will complete.  As that is the race Tetsuo is complaining about,
and it does also appear to also be present in populate_rootfs.


Flushing the fput is needed to ensure the writable struct file is
completely gone before an exec opens file file and calles
deny_write_access.

> umd_setup is stored in sub_info->init and
> eventually called from call_usermodehelper_exec_async(), right before
> the created kernel thread is about to call kernel_execve() and stop
> being a kernel thread...

I think you are suggesting calling __fput_sync in umd_setup.  Instead
of calling fput from blob_to_mnt.

To have a special case that only applies the first time a function is
called is possible but it is awkward, and likely more error prone.



I moved all of the user mode driver code out of exec and out of the user
mode helper code as the user mode driver code is essentially unused at
present.  The bpf folks really want to try and make it work so I wrote
something that is not completely insane so they can have their chance to
try.  I really suspect it will go the way of all of the migration of
the early kernel init code to userspace with klibc.  With the practical
details overwhelming things and making it not work or worth it in
practice.  Time will tell.


I hope that is enough context to understand what is going on there.

Eric
