Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFFEC166B08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 00:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgBTXjr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 18:39:47 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:43782 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbgBTXjr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:39:47 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4vQ1-0006zU-4k; Thu, 20 Feb 2020 16:39:45 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4vQ0-0006jR-EQ; Thu, 20 Feb 2020 16:39:44 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
References: <20200212200335.GO23230@ZenIV.linux.org.uk>
        <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
        <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=whX7UmXgCKPPvjyQFqBiKw-Zsgj22_rH8epDPoWswAnLA@mail.gmail.com>
        <20200220230758.GT23230@ZenIV.linux.org.uk>
Date:   Thu, 20 Feb 2020 17:37:44 -0600
In-Reply-To: <20200220230758.GT23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Thu, 20 Feb 2020 23:07:58 +0000")
Message-ID: <87mu9c7ruf.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j4vQ0-0006jR-EQ;;;mid=<87mu9c7ruf.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18cMc7gMcKxQtdSwR/g1EJXnhEFC3gu5r8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4768]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 295 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.8%), b_tie_ro: 1.73 (0.6%), parse: 0.73
        (0.2%), extract_message_metadata: 12 (4.0%), get_uri_detail_list: 1.19
        (0.4%), tests_pri_-1000: 16 (5.5%), tests_pri_-950: 1.08 (0.4%),
        tests_pri_-900: 0.90 (0.3%), tests_pri_-90: 23 (7.7%), check_bayes: 22
        (7.4%), b_tokenize: 7 (2.4%), b_tok_get_all: 8 (2.6%), b_comp_prob:
        1.84 (0.6%), b_tok_touch_all: 3.3 (1.1%), b_finish: 0.58 (0.2%),
        tests_pri_0: 228 (77.1%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.3 (0.8%), poll_dns_idle: 0.91 (0.3%), tests_pri_10:
        2.6 (0.9%), tests_pri_500: 7 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/7] proc: Dentry flushing without proc_mnt
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Feb 20, 2020 at 03:02:22PM -0800, Linus Torvalds wrote:
>> On Thu, Feb 20, 2020 at 12:48 PM Eric W. Biederman
>> <ebiederm@xmission.com> wrote:
>> >
>> > Linus, does this approach look like something you can stand?
>> 
>> A couple of worries, although one of them seem to have already been
>> resolved by Al.
>> 
>> I think the real gatekeeper should be Al in general.  But other than
>> the small comments I had, I think this might work just fine.
>> 
>> Al?
>
> I'll need to finish RTFS there; I have initially misread that patch,
> actually - Eric _is_ using that thing both for those directories
> and for sysctl inodes.  And the prototype for that machinery (the
> one he'd pulled from proc_sysctl.c) is playing with pinning superblocks
> way too much; for per-pid directories that's not an issue, but
> for sysctl table removal you are very likely to hit a bunch of
> evictees on the same superblock...

I saw that was possible.  If the broad strokes look correct I don't have
a problem at all with optimizing for the case where many of the entries
are for inodes on the same superblock.  I just had enough other details
on my mind I was afraid if I got a little more clever I would have
introduced a typo somewhere.


I wish I could limit the sysctl parts to just directories, but
unfortunately the sysctl tables don't always give a guarantee that a
directory is what will be removed.  But sysctls do have one name per
inode invarant like fat.  There is no way to express a sysctl
table that doesn't have that invariant.

As for d_find_alias/d_invalidate.

Just for completeness I wanted to write a loop:

	while (dentry = d_find_alias(inode)) {
        	d_invalidate(dentry);
                dput(dentry);
        }

Unfortunately that breaks on directories, because for directories
d_find_alias turns into d_find_any_alias, and continues to return aliases
even when they are unhashed.

It might be nice to write a cousin of d_prune_aliases call
it d_invalidate_aliases that just does that loop the correct way
in dcache.c

Eric
