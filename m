Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E263715B8B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 05:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgBMEjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 23:39:52 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49932 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBMEjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:39:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j26Hz-0000O1-MU; Wed, 12 Feb 2020 21:39:47 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j26Hy-0006WH-VI; Wed, 12 Feb 2020 21:39:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <20200210150519.538333-8-gladkov.alexey@gmail.com>
        <87v9odlxbr.fsf@x220.int.ebiederm.org>
        <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
        <87tv3vkg1a.fsf@x220.int.ebiederm.org>
        <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
        <87v9obipk9.fsf@x220.int.ebiederm.org>
        <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
        <20200212200335.GO23230@ZenIV.linux.org.uk>
        <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
        <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
Date:   Wed, 12 Feb 2020 22:37:52 -0600
In-Reply-To: <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 12 Feb 2020 16:48:14 -0800")
Message-ID: <87pnejf6fz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j26Hy-0006WH-VI;;;mid=<87pnejf6fz.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184mp0tBu1N+5TIPW3et7RBWpPrbgy8SaE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3078]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 312 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 5 (1.7%), b_tie_ro: 3.9 (1.2%), parse: 0.80
        (0.3%), extract_message_metadata: 14 (4.5%), get_uri_detail_list: 1.48
        (0.5%), tests_pri_-1000: 23 (7.5%), tests_pri_-950: 1.34 (0.4%),
        tests_pri_-900: 1.21 (0.4%), tests_pri_-90: 33 (10.6%), check_bayes:
        31 (10.0%), b_tokenize: 8 (2.7%), b_tok_get_all: 11 (3.5%),
        b_comp_prob: 4.1 (1.3%), b_tok_touch_all: 4.2 (1.4%), b_finish: 0.96
        (0.3%), tests_pri_0: 221 (70.9%), check_dkim_signature: 0.48 (0.2%),
        check_dkim_adsp: 3.1 (1.0%), poll_dns_idle: 0.28 (0.1%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 6 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Feb 12, 2020 at 1:48 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The good news is proc_flush_task isn't exactly called from process exit.
>> proc_flush_task is called during zombie clean up. AKA release_task.
>
> Yeah, that at least avoids some of the nasty locking while dying debug problems.
>
> But the one I was more worried about was actually the lock contention
> issue with lots of processes. The lock is basically a single global
> lock in many situations - yes, it's technically per-ns, but in a lot
> of cases you really only have one namespace anyway.
>
> And we've had problems with global locks in this area before, notably
> the one you call out:
>
>> Further after proc_flush_task does it's thing the code goes
>> and does "write_lock_irq(&task_list_lock);"
>
> Yeah, so it's not introducing a new issue, but it is potentially
> making something we already know is bad even worse.
>
>> What would be downside of having a mutex for a list of proc superblocks?
>> A mutex that is taken for both reading and writing the list.
>
> That's what the original patch actually was, and I was hoping we could
> avoid that thing.
>
> An rwsem would be possibly better, since most cases by far are likely
> about reading.
>
> And yes, I'm very aware of the task_list_lock, but it's literally why
> I don't want to make a new one.
>
> I'm _hoping_ we can some day come up with something better than
> task_list_lock.

Yes.  I understand that.

I occassionally play with ideas, and converted all of proc to rcu
to help with situation but I haven't come up with anything clearly
better.


All of this is why I was really hoping we could have a change in
strategy and see if we can make the shrinker be able to better prune
proc inodes.



I think I have an alternate idea that could work.  Add some extra code
into proc_task_readdir, that would look for dentries that no longer
point to tasks and d_invalidate them.  With the same logic probably
being called from a few more places as well like proc_pid_readdir,
proc_task_lookup, and proc_pid_lookup.

We could even optimize it and have a process died flag we set in the
superblock.

That would would batch up the freeing work until the next time someone
reads from proc in a way that would create more dentries.  So it would
prevent dentries from reaped zombies from growing without bound.

Hmm.  Given the existence of proc_fill_cache it would really be a good
idea if readdir and lookup performed some of the freeing work as well.
As on readdir we always populate the dcache for all of the directory
entries.

I am booked solid for the next little while but if no one beats me to it
I will try and code something like that up where at least readdir
looks for and invalidates stale dentries.

Eric
