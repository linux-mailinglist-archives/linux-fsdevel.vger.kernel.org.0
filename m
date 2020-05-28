Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F311E6358
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390858AbgE1OH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 10:07:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42554 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390757AbgE1OH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 10:07:57 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeJCN-0002MY-6A; Thu, 28 May 2020 08:07:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jeJCL-0004E2-Lz; Thu, 28 May 2020 08:07:55 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Boris Sukholitko <boris.sukholitko@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, keescook@chromium.org,
        yzaikin@google.com
References: <20200527104848.GA7914@nixbox>
        <20200527125805.GI11244@42.do-not-panic.com>
        <20200528080812.GA21974@noodle>
Date:   Thu, 28 May 2020 09:04:02 -0500
In-Reply-To: <20200528080812.GA21974@noodle> (Boris Sukholitko's message of
        "Thu, 28 May 2020 11:08:12 +0300")
Message-ID: <874ks02m25.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jeJCL-0004E2-Lz;;;mid=<874ks02m25.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19K7BK82p5HqBBQT8H06qW4vjlSYZI2hz4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,TR_XM_PhishingBody,
        T_TM2_M_HEADER_IN_MSG,XM_B_Phish66 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Boris Sukholitko <boris.sukholitko@broadcom.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1097 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 14 (1.3%), b_tie_ro: 11 (1.0%), parse: 2.7 (0.2%),
         extract_message_metadata: 27 (2.5%), get_uri_detail_list: 5 (0.5%),
        tests_pri_-1000: 9 (0.8%), tests_pri_-950: 2.1 (0.2%), tests_pri_-900:
        1.67 (0.2%), tests_pri_-90: 248 (22.6%), check_bayes: 239 (21.8%),
        b_tokenize: 21 (1.9%), b_tok_get_all: 14 (1.2%), b_comp_prob: 6 (0.6%),
         b_tok_touch_all: 194 (17.7%), b_finish: 1.02 (0.1%), tests_pri_0: 773
        (70.5%), check_dkim_signature: 0.65 (0.1%), check_dkim_adsp: 2.4
        (0.2%), poll_dns_idle: 0.32 (0.0%), tests_pri_10: 3.6 (0.3%),
        tests_pri_500: 9 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] __register_sysctl_table: do not drop subdir
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Boris Sukholitko <boris.sukholitko@broadcom.com> writes:

> On Wed, May 27, 2020 at 12:58:05PM +0000, Luis Chamberlain wrote:
>> Eric since you authored the code which this code claism to fix, your
>> review would be appreciated.
>> 
>> On Wed, May 27, 2020 at 01:48:48PM +0300, Boris Sukholitko wrote:
>> > Successful get_subdir returns dir with its header.nreg properly
>> > adjusted. No need to drop the dir in that case.
>> 
>> This commit log is not that clear to me
>> can you explain what happens
>> without this patch, and how critical it is to fix it. How did you
>> notice this issue?
>
> Apologies for being too terse with my explanation. I'll try to expand
> below.
>
> In testing of our kernel (based on 4.19, tainted, sorry!) on our aarch64 based hardware
> we've come upon the following oops (lightly edited to omit irrelevant
> details):

How does your 4.19 proc_sysctl.c compare with the latest proc-sysctl.c?
Have you backported all of the most recent bug fixes?

> 000:50:01.133 Unable to handle kernel paging request at virtual address 0000000000007a12
> 000:50:02.209 Process brctl (pid: 14467, stack limit = 0x00000000bcf7a578)
> 000:50:02.209 CPU: 1 PID: 14467 Comm: brctl Tainted: P                  4.19.122 #1
> 000:50:02.209 Hardware name: Broadcom-v8A (DT)
> 000:50:02.209 pstate: 60000005 (nZCv daif -PAN -UAO)
> 000:50:02.209 pc : unregister_sysctl_table+0x1c/0xa0
> 000:50:02.209 lr : unregister_net_sysctl_table+0xc/0x20
> 000:50:02.209 sp : ffffff800e5ab9e0
> 000:50:02.209 x29: ffffff800e5ab9e0 x28: ffffffc016439ec0 
> 000:50:02.209 x27: 0000000000000000 x26: ffffff8008804078 
> 000:50:02.209 x25: ffffff80087b4dd8 x24: ffffffc015d65000 
> 000:50:02.209 x23: ffffffc01f0d6010 x22: ffffffc01f0d6000 
> 000:50:02.209 x21: ffffffc0166c4eb0 x20: 00000000000000bd 
> 000:50:02.209 x19: ffffffc01f0d6030 x18: 0000000000000400 
> 000:50:02.256 x17: 0000000000000000 x16: 0000000000000000 
> 000:50:02.256 x15: 0000000000000400 x14: 0000000000000129 
> 000:50:02.256 x13: 0000000000000001 x12: 0000000000000030 
> 000:50:02.256 x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f 
> 000:50:02.256 x9 : feff646663687161 x8 : ffffffffffffffff 
> 000:50:02.256 x7 : fefefefefefefefe x6 : 0000000000008080 
> 000:50:02.256 x5 : 00000000ffffffff x4 : ffffff8008905c38 
> 000:50:02.256 x3 : ffffffc01f0d602c x2 : 00000000000000bd 
> 000:50:02.256 x1 : ffffffc01f0d60c0 x0 : 0000000000007a12 
> 000:50:02.256 Call trace:
> 000:50:02.256  unregister_sysctl_table+0x1c/0xa0
> 000:50:02.256  unregister_net_sysctl_table+0xc/0x20
> 000:50:02.256  __devinet_sysctl_unregister.isra.0+0x2c/0x60
> 000:50:02.256  inetdev_event+0x198/0x510
> 000:50:02.256  notifier_call_chain+0x58/0xa0
> 000:50:02.303  raw_notifier_call_chain+0x14/0x20
> 000:50:02.303  call_netdevice_notifiers_info+0x34/0x80
> 000:50:02.303  rollback_registered_many+0x384/0x600
> 000:50:02.303  unregister_netdevice_queue+0x8c/0x110
> 000:50:02.303  br_dev_delete+0x8c/0xa0
> 000:50:02.303  br_del_bridge+0x44/0x70
> 000:50:02.303  br_ioctl_deviceless_stub+0xcc/0x310
> 000:50:02.303  sock_ioctl+0x194/0x3f0
> 000:50:02.303  compat_sock_ioctl+0x678/0xc00
> 000:50:02.303  __arm64_compat_sys_ioctl+0xf0/0xcb0
> 000:50:02.303  el0_svc_common+0x70/0x170
> 000:50:02.303  el0_svc_compat_handler+0x1c/0x30
> 000:50:02.303  el0_svc_compat+0x8/0x18
> 000:50:02.303 Code: a90153f3 aa0003f3 f9401000 b40000c0 (f9400001) 
>
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
> From this we've started to suspect some infelicity in header.nreg
> refcounting, thus leading us the __register_sysctl_table fix in the
> patch.
>
> Here is more detailed explanation of the fix.
>
> The current __register_sysctl_table logic looks like:
>
> 1. We start with some root dir, incrementing its header.nreg.
>
> 2. Then we find suitable dir using get_subdir function.
>
> 3. get_subdir decrements nreg on the parent dir and increments it on the
>    dir being returned. See found label there.
>
> 4. We decrement dir's header.nreg for the symmetry with step 1.
>
> IMHO, the bug is on step 4. If another dir is being returned by
> get_subdir we decrement its nreg. I.e. the returned dir nreg stays 1
> despite having children added to it.
>
> This leads eventually to the innocent parent header being freed.
>

But the insertion of children in insert_header also increases the count
so it does not look like that should be true.

>> If you don't apply this patch what issue do you see?
>
> For some unexplained reason, the crashes are very rare and require
> stressing the system while creating and destroing network interfaces.
>
>> 
>> Do we test for it? Can we?
>> 
>
> With some printk tracing the issue is easy to see while doing simple
> brctl addbr / delbr to create and destroy bridge interface.
>
> Probably there is some SLUB debug option which may allow to catch the
> faulty free.

I see some recent (within the last year) fixes to proc_sysctl.c in this
area.  Do you have those?  It looks like bridge up and down is stressing
this code.  Either those most recent fixes are wrong, your kernel is
missing them or this needs some more investigation.

Eric
