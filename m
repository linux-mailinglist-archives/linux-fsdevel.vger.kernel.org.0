Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006CD626EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 19:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfGHRMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 13:12:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:52349 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGHRMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:12:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hkXC2-0006vl-KJ; Mon, 08 Jul 2019 11:12:46 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hkXC1-0003TO-Pp; Mon, 08 Jul 2019 11:12:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-security-module@vger.kernel.org
References: <155059610368.17079.2220554006494174417.stgit@warthog.procyon.org.uk>
        <155059611887.17079.12991580316407924257.stgit@warthog.procyon.org.uk>
        <c5b901ca-c243-bf80-91be-a794c4433415@I-love.SAKURA.ne.jp>
        <20190708131831.GT17978@ZenIV.linux.org.uk>
Date:   Mon, 08 Jul 2019 12:12:21 -0500
In-Reply-To: <20190708131831.GT17978@ZenIV.linux.org.uk> (Al Viro's message of
        "Mon, 8 Jul 2019 14:18:31 +0100")
Message-ID: <874l3wo3gq.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hkXC1-0003TO-Pp;;;mid=<874l3wo3gq.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX192tN/s3LkYgXUqSFAo72Dnkakbu71PirI=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 465 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 2.3 (0.5%), b_tie_ro: 1.54 (0.3%), parse: 0.78
        (0.2%), extract_message_metadata: 13 (2.9%), get_uri_detail_list: 1.96
        (0.4%), tests_pri_-1000: 11 (2.3%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 26 (5.6%), check_bayes: 25
        (5.4%), b_tokenize: 7 (1.5%), b_tok_get_all: 9 (2.0%), b_comp_prob:
        2.9 (0.6%), b_tok_touch_all: 3.9 (0.8%), b_finish: 0.57 (0.1%),
        tests_pri_0: 397 (85.3%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        1.80 (0.4%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 02/10] vfs: syscall: Add move_mount(2) to move mounts around
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jul 08, 2019 at 09:02:10PM +0900, Tetsuo Handa wrote:
>> Hello, David Howells.
>> 
>> I realized via https://lwn.net/Articles/792622/ that a new set of
>> system calls for filesystem mounting has been added to Linux 5.2. But
>> I feel that LSM modules are not ready to support these system calls.
>> 
>> An example is move_mount() added by this patch. This patch added
>> security_move_mount() LSM hook but none of in-tree LSM modules are
>> providing "LSM_HOOK_INIT(move_mount, ...)" entry. Therefore, currently
>> security_move_mount() is a no-op. At least for TOMOYO, I want to check
>> mount manipulations caused by system calls because allowing mounts on
>> arbitrary location is not acceptable for pathname based access control.
>> What happened? I want TOMOYO to perform similar checks like mount() does.
>
> That would be like tomoyo_check_mount_acl(), right?
>         if (need_dev) {
>                 /* Get mount point or device file. */
>                 if (!dev_name || kern_path(dev_name, LOOKUP_FOLLOW, &path)) {
>                         error = -ENOENT;
>                         goto out;
>                 }
>                 obj.path1 = path;
>                 requested_dev_name = tomoyo_realpath_from_path(&path);
>                 if (!requested_dev_name) {
>                         error = -ENOENT;
>                         goto out;
>                 }
>         } else {
> is an obvious crap for *ALL* cases.  You are doing pathname resolution,
> followed by normalization and checks.  Then the result of said pathname
> resolution is thrown out and it's redone (usually by something in fs/super.c).
> Results of _that_ get used.
>
> Could you spell TOCTOU?  And yes, exploiting that takes a lot less than
> being able to do mount(2) in the first place - just pass it
> /proc/self/fd/69/<some acceptable path>/. with descriptor refering to
> opened root directory.  With ~/<some acceptable path> being a symlink
> to whatever you actually want to hit.  And descriptor 42 being your
> opened homedir.  Now have that call of mount(2) overlap with dup2(42, 69)
> from another thread sharing your descriptor table.  It doesn't take much
> to get the timing right, especially if you can arrange for some other
> activity frequently hitting namespace_sem at least shared (e.g. reading
> /proc/mounts in a loop from another process); that's likely to stall
> mount(2) at the point of lock_mount(), which comes *AFTER* the point
> where LSM hook is stuck into.
>
> Again, *ANY* checks on "dev_name" in ->sb_mount() instances are so much
> snake oil.  Always had been.

Al you do realize that the TOCTOU you are talking about comes the system
call API.  TOMOYO can only be faulted for not playing in their own
sandbox and not reaching out and fixing the vfs implementation details.
Userspace has always had to very careful to only mount filesystems
on paths that root completely controls and won't change.

Further system calls for manipulating the mount tree have historically
done a crap job of validating their inputs.  Relying on the fact that
only root can call them.  So the idea of guarding against root doing
something silly was silly.

So I figure at the end of the day if the new security hooks for the new
mount system calls don't make it possible to remove the TOCTOU that is
on you and Dave.  You two touched that code last after all.

Not updating the new security hooks to at least do as good a job as the
old security hooks is the definition of regression.

So Al.  Please simmer down and take the valid criticism.

Eric
