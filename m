Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 629401740D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 21:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgB1UTz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 15:19:55 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58168 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1UTz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:19:55 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7m6v-00068n-3K; Fri, 28 Feb 2020 13:19:49 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7m6u-0002fJ-0Y; Fri, 28 Feb 2020 13:19:48 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
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
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <871rqk2brn.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 14:17:41 -0600
In-Reply-To: <871rqk2brn.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Mon, 24 Feb 2020 10:25:16 -0600")
Message-ID: <878skmsbyy.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7m6u-0002fJ-0Y;;;mid=<878skmsbyy.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184o7/7/rMRoEK9hF/5tZ1Qs2V3r2fvMT0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XM_Multi_Part_URI
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3769]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 XM_Multi_Part_URI URI: Long-Multi-Part URIs
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 640 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.0 (0.6%), b_tie_ro: 2.9 (0.5%), parse: 0.85
        (0.1%), extract_message_metadata: 3.3 (0.5%), get_uri_detail_list:
        1.50 (0.2%), tests_pri_-1000: 4.6 (0.7%), tests_pri_-950: 1.35 (0.2%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 29 (4.5%), check_bayes: 27
        (4.3%), b_tokenize: 8 (1.3%), b_tok_get_all: 9 (1.5%), b_comp_prob:
        2.5 (0.4%), b_tok_touch_all: 4.0 (0.6%), b_finish: 0.83 (0.1%),
        tests_pri_0: 581 (90.7%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 0.96 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/3] proc: Actually honor the mount options
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Proc mount option handling is broken, and it has been since I
accidentally broke it in the middle 2006.

The problem is that because we perform an internal mount of proc
before user space mounts proc all of the mount options that user
specifies when mounting proc are ignored.

You can set those mount options with a remount but that is rather
surprising.

This most directly affects android which is using hidpid=2 by default.

Now that the sysctl system call support has been removed, and we have
settled on way of flushing proc dentries when a process exits without
using proc_mnt, there is an simple and easy fix.

a) Give UML mconsole it's own private mount of proc to use.
b) Stop creating the internal mount of proc

We still need Alexey Gladkov's full patch to get proc mount options to
work inside of UML, and to be generally useful.  This set of changes
is just enough to get them working as well as they have in the past.

If anyone sees any problem with this code please let me know.

Otherwise I plan to merge these set of fixes through my tree.

Link: https://lore.kernel.org/lkml/87r21tuulj.fsf@x220.int.ebiederm.org/
Link: https://lore.kernel.org/lkml/871rqk2brn.fsf_-_@x220.int.ebiederm.org/
Link: https://lore.kernel.org/lkml/20200210150519.538333-1-gladkov.alexey@gmail.com/
Link: https://lore.kernel.org/lkml/20180611195744.154962-1-astrachan@google.com/
Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns.")

Eric W. Biederman (3):
      uml: Don't consult current to find the proc_mnt in mconsole_proc
      uml: Create a private mount of proc for mconsole
      proc: Remove the now unnecessary internal mount of proc

 arch/um/drivers/mconsole_kern.c | 28 +++++++++++++++++++++++++++-
 fs/proc/root.c                  | 36 ------------------------------------
 include/linux/pid_namespace.h   |  2 --
 include/linux/proc_ns.h         |  5 -----
 kernel/pid.c                    |  8 --------
 kernel/pid_namespace.c          |  7 -------
 6 files changed, 27 insertions(+), 59 deletions(-)

Eric
