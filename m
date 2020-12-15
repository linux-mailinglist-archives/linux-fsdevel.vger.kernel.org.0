Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE852DB6D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 00:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgLOXBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Dec 2020 18:01:23 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:52558 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgLOXBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:01:22 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpJJB-00Cr0W-8O; Tue, 15 Dec 2020 16:00:41 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpJJA-00DF5y-4a; Tue, 15 Dec 2020 16:00:40 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Date:   Tue, 15 Dec 2020 16:59:55 -0600
Message-ID: <871rfqad5g.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kpJJA-00DF5y-4a;;;mid=<871rfqad5g.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18d/z009bY1BPlfEudhSL19wCY815OZZBk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,T_XMDrugObfuBody_08,
        XMSubMetaSxObfu_03,XMSubMetaSx_00,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 526 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (2.2%), b_tie_ro: 10 (1.9%), parse: 1.08
        (0.2%), extract_message_metadata: 5 (1.0%), get_uri_detail_list: 2.5
        (0.5%), tests_pri_-1000: 4.1 (0.8%), tests_pri_-950: 1.51 (0.3%),
        tests_pri_-900: 1.17 (0.2%), tests_pri_-90: 193 (36.7%), check_bayes:
        191 (36.3%), b_tokenize: 8 (1.6%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 169 (32.1%), b_finish: 1.15
        (0.2%), tests_pri_0: 289 (55.0%), check_dkim_signature: 0.74 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.36 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] exec fixes for v5.11-rc1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Please pull the exec-for-v5.11 branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-for-v5.11

   HEAD: 9ee1206dcfb9d56503c0de9f8320f7b29c795867 exec: Move io_uring_task_cancel after the point of no return

This set of changes ultimately fixes the interaction of posix file lock
and exec.  Fundamentally most of the change is just moving where
unshare_files is called during exec, and tweaking the users of
files_struct so that the count of files_struct is not unnecessarily
played with.

Along the way fcheck and related helpers were renamed to more accurately
reflect what they do.

There were also many other small changes that fell out, as this is the
first time in a long time much of this code has been touched.


There is a minor conflict with parallel changes to the bpf task_iter
code.  The changes don't fundamentally conflict but both are removing
code from same areas of the same function.


Benchmarks haven't turned up any practical issues but Al Viro has
observed a possibility for a lot of pounding on task_lock.  So I have
some changes in progress to convert put_files_struct to always rcu free
files_struct.  That wasn't ready for the merge window so that will have
to wait until next time.


Eric W. Biederman (28):
      exec: Don't open code get_close_on_exec
      exec: Move unshare_files to fix posix file locking during exec
      exec: Simplify unshare_files
      exec: Remove reset_files_struct
      kcmp: In kcmp_epoll_target use fget_task
      bpf: In bpf_task_fd_query use fget_task
      proc/fd: In proc_fd_link use fget_task
      file: Rename __fcheck_files to files_lookup_fd_raw
      file: Factor files_lookup_fd_locked out of fcheck_files
      file: Replace fcheck_files with files_lookup_fd_rcu
      file: Rename fcheck lookup_fd_rcu
      file: Implement task_lookup_fd_rcu
      proc/fd: In tid_fd_mode use task_lookup_fd_rcu
      kcmp: In get_file_raw_ptr use task_lookup_fd_rcu
      file: Implement task_lookup_next_fd_rcu
      proc/fd: In proc_readfd_common use task_lookup_next_fd_rcu
      bpf/task_iter: In task_file_seq_get_next use task_lookup_next_fd_rcu
      proc/fd: In fdinfo seq_show don't use get_files_struct
      file: Merge __fd_install into fd_install
      file: In f_dupfd read RLIMIT_NOFILE once.
      file: Merge __alloc_fd into alloc_fd
      file: Rename __close_fd to close_fd and remove the files parameter
      file: Replace ksys_close with close_fd
      file: Rename __close_fd_get_file close_fd_get_file
      file: Remove get_files_struct
      exec: Move unshare_files and guarantee files_struct.count is correct
      coredump: Document coredump code exclusively used by cell spufs
      exec: Move io_uring_task_cancel after the point of no return

 Documentation/filesystems/files.rst          |   8 +-
 arch/powerpc/platforms/cell/spufs/coredump.c |   2 +-
 drivers/android/binder.c                     |   2 +-
 fs/autofs/dev-ioctl.c                        |   5 +-
 fs/binfmt_elf.c                              |   2 +
 fs/coredump.c                                |   6 +-
 fs/exec.c                                    |  39 ++++-----
 fs/file.c                                    | 124 +++++++++++++--------------
 fs/io_uring.c                                |   2 +-
 fs/locks.c                                   |  14 +--
 fs/notify/dnotify/dnotify.c                  |   2 +-
 fs/open.c                                    |   2 +-
 fs/proc/fd.c                                 |  48 ++++-------
 include/linux/fdtable.h                      |  40 +++++----
 include/linux/syscalls.h                     |  12 ---
 kernel/bpf/syscall.c                         |  20 +----
 kernel/bpf/task_iter.c                       |  44 +++-------
 kernel/fork.c                                |  12 +--
 kernel/kcmp.c                                |  29 ++-----
 19 files changed, 161 insertions(+), 252 deletions(-)

Eric
