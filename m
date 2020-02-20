Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 997B51668D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgBTUsa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 15:48:30 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:59842 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgBTUsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:48:30 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4skE-0001ri-62; Thu, 20 Feb 2020 13:48:26 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4skD-00085Y-Cz; Thu, 20 Feb 2020 13:48:26 -0700
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
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
Date:   Thu, 20 Feb 2020 14:46:25 -0600
In-Reply-To: <87pnejf6fz.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 12 Feb 2020 22:37:52 -0600")
Message-ID: <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j4skD-00085Y-Cz;;;mid=<871rqpaswu.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/Q6NKhmM+yXD+yJ+hS7KlJi2ul8+5zveY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4907]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 392 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (0.7%), b_tie_ro: 1.97 (0.5%), parse: 1.00
        (0.3%), extract_message_metadata: 3.0 (0.8%), get_uri_detail_list:
        0.95 (0.2%), tests_pri_-1000: 4.4 (1.1%), tests_pri_-950: 1.37 (0.4%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 28 (7.1%), check_bayes: 26
        (6.7%), b_tokenize: 9 (2.2%), b_tok_get_all: 7 (1.9%), b_comp_prob:
        2.5 (0.6%), b_tok_touch_all: 4.3 (1.1%), b_finish: 0.78 (0.2%),
        tests_pri_0: 334 (85.4%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.1 (0.8%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        1.97 (0.5%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/7] proc: Dentry flushing without proc_mnt
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Just because it is less of a fundamental change and less testing I went
and looked at updating proc_flush_task to use a list as Al suggested.

If we can stand an sget/deactivate_super pair for every dentry we want
to invalidate I think I have something.

Comments from anyone will be appreciated I gave this some light testing
and the code is based on something similar already present in proc so
I think there is a high chance this code is correct but I could easily
be wrong.

Linus, does this approach look like something you can stand?

Eric

Eric W. Biederman (7):
      proc: Rename in proc_inode rename sysctl_inodes sibling_inodes
      proc: Generalize proc_sys_prune_dcache into proc_prune_siblings_dcache
      proc: Mov rcu_read_(lock|unlock) in proc_prune_siblings_dcache
      proc: Use d_invalidate in proc_prune_siblings_dcache
      proc: Clear the pieces of proc_inode that proc_evict_inode cares about
      proc: Use a list of inodes to flush from proc
      proc: Ensure we see the exit of each process tid exactly once

 fs/exec.c               |   5 +--
 fs/proc/base.c          | 111 ++++++++++++++++--------------------------------
 fs/proc/inode.c         |  60 +++++++++++++++++++++++---
 fs/proc/internal.h      |   4 +-
 fs/proc/proc_sysctl.c   |  45 +++-----------------
 include/linux/pid.h     |   2 +
 include/linux/proc_fs.h |   4 +-
 kernel/exit.c           |   4 +-
 kernel/pid.c            |  16 +++++++
 9 files changed, 124 insertions(+), 127 deletions(-)


