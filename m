Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56861EEC1F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 22:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgFDUh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 16:37:28 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39988 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgFDUh1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:37:27 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwc9-00064N-Lz; Thu, 04 Jun 2020 14:37:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwc8-0000m9-GV; Thu, 04 Jun 2020 14:37:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200604200413.587896-1-gladkov.alexey@gmail.com>
Date:   Thu, 04 Jun 2020 15:33:25 -0500
In-Reply-To: <20200604200413.587896-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Thu, 4 Jun 2020 22:04:11 +0200")
Message-ID: <87ftbah8q2.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jgwc8-0000m9-GV;;;mid=<87ftbah8q2.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+vjCBiGzqIgIt/FfYuiYQafWqnnlO4w2E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=8.0 tests=ALL_TRUSTED,BAYES_20,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.0608]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 352 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (1.1%), b_tie_ro: 2.7 (0.8%), parse: 0.71
        (0.2%), extract_message_metadata: 3.0 (0.8%), get_uri_detail_list:
        1.59 (0.5%), tests_pri_-1000: 2.8 (0.8%), tests_pri_-950: 0.98 (0.3%),
        tests_pri_-900: 0.78 (0.2%), tests_pri_-90: 55 (15.7%), check_bayes:
        54 (15.4%), b_tokenize: 6 (1.8%), b_tok_get_all: 8 (2.3%),
        b_comp_prob: 1.94 (0.6%), b_tok_touch_all: 35 (10.0%), b_finish: 0.63
        (0.2%), tests_pri_0: 271 (77.1%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.91 (0.3%), tests_pri_10:
        1.71 (0.5%), tests_pri_500: 5 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] proc: use subset option to hide some top-level procfs entries
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> Greetings!
>
> Preface
> -------
> This patch set can be applied over:
>
> git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git d35bec8a5788

I am not going to seriously look at this for merging until after the
merge window closes. 

Have you thought about the possibility of relaxing the permission checks
to mount proc such that we don't need to verify there is an existing
mount of proc?  With just the subset pids I think this is feasible.  It
might not be worth it at this point, but it is definitely worth asking
the question.  As one of the benefits early propopents of the idea of a
subset of proc touted was that they would not be as restricted as they
are with today's proc.

I ask because this has a bearing on the other options you are playing
with.

Do we want to find a way to have the benefit of relaxed permission
checks while still including a few more files.

> Overview
> --------
> Directories and files can be created and deleted by dynamically loaded modules.
> Not all of these files are virtualized and safe inside the container.
>
> However, subset=pid is not enough because many containers wants to have
> /proc/meminfo, /proc/cpuinfo, etc. We need a way to limit the visibility of
> files per procfs mountpoint.

Is it desirable to have meminfo and cpuinfo as they are today or do
people want them to reflect the ``container'' context.   So that
applications like the JVM don't allocation too many cpus or don't try
and consume too much memory, or run on nodes that cgroups current make
unavailable.

Are there any users or planned users of this functionality yet?

I am concerned that you might be adding functionality that no one will
ever use that will just add code to the kernel that no one cares about,
that will then accumulate bugs.  Having had to work through a few of
those cases to make each mount of proc have it's own super block I am
not a great fan of adding another one.

If the runc, lxc and other container runtime folks can productively use
such and option to do useful things and they are sensible things to do I
don't have any fundamental objection.  But I do want to be certain this
is a feature that is going to be used.

Eric


> Introduced changes
> ------------------
> Allow to specify the names of files and directories in the subset= parameter and
> thereby make a whitelist of top-level permitted names.
>
>
> Alexey Gladkov (2):
>   proc: use subset option to hide some top-level procfs entries
>   docs: proc: update documentation about subset= parameter
>
>  Documentation/filesystems/proc.rst |  6 +++
>  fs/proc/base.c                     | 15 +++++-
>  fs/proc/generic.c                  | 75 +++++++++++++++++++++------
>  fs/proc/inode.c                    | 18 ++++---
>  fs/proc/internal.h                 | 12 +++++
>  fs/proc/root.c                     | 81 ++++++++++++++++++++++++------
>  include/linux/proc_fs.h            | 11 ++--
>  7 files changed, 175 insertions(+), 43 deletions(-)
