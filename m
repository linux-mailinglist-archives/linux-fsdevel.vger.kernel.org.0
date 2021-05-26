Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93609390ED1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 05:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhEZDZ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 23:25:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37108 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhEZDZ1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 23:25:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1llk8m-009FJV-6g; Tue, 25 May 2021 21:23:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1llk8l-0005ks-42; Tue, 25 May 2021 21:23:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, ojeda@kernel.org,
        johan@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        masahiroy@kernel.org, Menglong Dong <dong.menglong@zte.com.cn>,
        joe@perches.com, Jens Axboe <axboe@kernel.dk>, hare@suse.de,
        Jan Kara <jack@suse.cz>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        f.fainelli@gmail.com, arnd@arndb.de,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        wangkefeng.wang@huawei.com, Barret Rhoden <brho@google.com>,
        mhiramat@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        vbabka@suse.cz, Alexander Potapenko <glider@google.com>,
        pmladek@suse.com, Chris Down <chris@chrisdown.name>,
        jojing64@gmail.com, terrelln@fb.com, geert@linux-m68k.org,
        mingo@kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, jeyu@kernel.org
References: <20210525141524.3995-1-dong.menglong@zte.com.cn>
        <20210525141524.3995-3-dong.menglong@zte.com.cn>
        <m18s42odgz.fsf@fess.ebiederm.org>
        <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com>
Date:   Tue, 25 May 2021 22:23:09 -0500
In-Reply-To: <CADxym3a5nsuw2hiDF=ZS51Wpjs-i_VW+OGd-sgGDVrKYw2AiHQ@mail.gmail.com>
        (Menglong Dong's message of "Wed, 26 May 2021 09:51:22 +0800")
Message-ID: <m11r9umb4y.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1llk8l-0005ks-42;;;mid=<m11r9umb4y.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19UEqCr4Wgg2PYoJNFhlS45Ajf4X6WIQe0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMSubLong,XM_B_Phish66,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Menglong Dong <menglong8.dong@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 561 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (2.1%), b_tie_ro: 10 (1.8%), parse: 1.27
        (0.2%), extract_message_metadata: 14 (2.5%), get_uri_detail_list: 2.6
        (0.5%), tests_pri_-1000: 15 (2.7%), tests_pri_-950: 1.21 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 91 (16.2%), check_bayes:
        90 (16.0%), b_tokenize: 13 (2.3%), b_tok_get_all: 11 (2.0%),
        b_comp_prob: 3.5 (0.6%), b_tok_touch_all: 59 (10.5%), b_finish: 0.91
        (0.2%), tests_pri_0: 402 (71.8%), check_dkim_signature: 0.76 (0.1%),
        check_dkim_adsp: 2.4 (0.4%), poll_dns_idle: 0.63 (0.1%), tests_pri_10:
        3.2 (0.6%), tests_pri_500: 16 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 2/3] init/do_cmounts.c: introduce 'user_root' for initramfs
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Menglong Dong <menglong8.dong@gmail.com> writes:

> On Wed, May 26, 2021 at 2:50 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
> ......
>>
>> What is the flow where docker uses an initramfs?
>>
>> Just thinking about this I am not being able to connect the dots.
>>
>> The way I imagine the world is that an initramfs will be used either
>> when a linux system boots for the first time, or an initramfs would
>> come from the distribution you are running inside a container.  In
>> neither case do I see docker being in a position to add functionality
>> to the initramfs as docker is not responsible for it.
>>
>> Is docker doing something creating like running a container in a VM,
>> and running some directly out of the initramfs, and wanting that code
>> to exactly match the non-VM case?
>>
>> If that is the case I think the easy solution would be to actually use
>> an actual ramdisk where pivot_root works.
>
> In fact, nowadays, initramfs is widely used by embedded devices in the
> production environment, which makes the whole system run in ram.
>
> That make sense. First, running in ram will speed up the system. The size
> of the system won't be too large for embedded devices, which makes this
> idea work. Second, this will reduce the I/O of disk devices, which can
> extend the life of the disk. Third, RAM is getting cheaper.
>
> So in this scene, Docker runs directly in initramfs.

That is the piece of the puzzle I was missing.  An small system
with it's root in an initramfs.

>> I really don't see why it makes sense for docker to be a special
>> snowflake and require kernel features that no other distribution does.
>>
>> It might make sense to create a completely empty filesystem underneath
>> an initramfs, and use that new rootfs as the unchanging root of the
>> mount tree, if it can be done with a trivial amount of code, and
>> generally make everything cleaner.
>>
>> As this change sits it looks like a lot of code to handle a problem
>> in the implementation of docker.   Which quite frankly will be a pain
>> to have to maintain if this is not a clean general feature that
>> other people can also use.
>>
>
> I don't think that it's all for docker, pivot_root may be used by other
> users in the above scene. It may work to create an empty filesystem, as you
> mentioned above. But I don't think it's a good idea to make all users,
> who want to use pivot_root, do that. After all, it's not friendly to
> users.
>
> As for the code, it may look a lot, but it's not complex. Maybe a clean
> up for the code I add can make it better?

If we are going to do this something that is so small and clean it can
be done unconditionally always.

I will see if I can dig in and look at little more.  I think there is
a reason Al Viro and H. Peter Anvin implemeted initramfs this way.
Perhaps it was just a desire to make pivot_root unnecessary.

Container filesystem setup does throw a bit of a wrench in the works as
unlike a initramfs where you can just delete everything there is not
a clean way to get rid of a root filesystem you don't need without
pivot_root.


The net request as I understand it: Make the filesystem the initramfs
lives in be an ordinary filesystem so it can just be used as the systems
primary filesystem.

There might be technical reasons why that is a bad idea and userspace
would be requested to move everything into another ramfs manually (which
would have the same effect).  But it is take a good look to see if it
can be accomplished cleanly.

Eric
