Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794053EDA7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 18:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhHPQEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 12:04:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:38182 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhHPQET (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 12:04:19 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:56994)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mFf5V-008sNR-KP; Mon, 16 Aug 2021 10:03:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:49330 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mFf5R-005nsx-0Q; Mon, 16 Aug 2021 10:03:45 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man <linux-man@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <20210813220120.502058-1-mtk.manpages@gmail.com>
Date:   Mon, 16 Aug 2021 11:03:03 -0500
In-Reply-To: <20210813220120.502058-1-mtk.manpages@gmail.com> (Michael
        Kerrisk's message of "Sat, 14 Aug 2021 00:01:20 +0200")
Message-ID: <87r1et1io8.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mFf5R-005nsx-0Q;;;mid=<87r1et1io8.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DLKLLUTGqLFcrA8tD3cIu4LO2LsP2u5o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong,XM_B_SpammyTLD
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Michael Kerrisk <mtk.manpages@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3584 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.3%), b_tie_ro: 9 (0.3%), parse: 2.1 (0.1%),
        extract_message_metadata: 17 (0.5%), get_uri_detail_list: 3.8 (0.1%),
        tests_pri_-1000: 7 (0.2%), tests_pri_-950: 1.47 (0.0%),
        tests_pri_-900: 1.14 (0.0%), tests_pri_-90: 2163 (60.4%), check_bayes:
        2154 (60.1%), b_tokenize: 11 (0.3%), b_tok_get_all: 10 (0.3%),
        b_comp_prob: 3.9 (0.1%), b_tok_touch_all: 2109 (58.8%), b_finish: 16
        (0.4%), tests_pri_0: 1333 (37.2%), check_dkim_signature: 1.00 (0.0%),
        check_dkim_adsp: 3.4 (0.1%), poll_dns_idle: 1.00 (0.0%), tests_pri_10:
        4.2 (0.1%), tests_pri_500: 38 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCHi, man-pages] mount_namespaces.7: More clearly explain "locked mounts"
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michael Kerrisk <mtk.manpages@gmail.com> writes:

> For a long time, this manual page has had a brief discussion of
> "locked" mounts, without clearly saying what this concept is, or
> why it exists. Expand the discussion with an explanation of what
> locked mounts are, why mounts are locked, and some examples of the
> effect of locking.
>
> Thanks to Christian Brauner for a lot of help in understanding
> these details.
>
> Reported-by: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
> ---
>
> Hello Eric and others,
>
> After some quite helpful info from Chrstian Brauner, I've expanded
> the discussion of locked mounts (a concept I didn't really have a
> good grasp on) in the mount_namespaces(7) manual page. I would be
> grateful to receive review comments, acks, etc., on the patch below.
> Could you take a look please?
>
> Cheers,
>
> Michael
>
>  man7/mount_namespaces.7 | 73 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/man7/mount_namespaces.7 b/man7/mount_namespaces.7
> index e3468bdb7..97427c9ea 100644
> --- a/man7/mount_namespaces.7
> +++ b/man7/mount_namespaces.7
> @@ -107,6 +107,62 @@ operation brings across all of the mounts from the original
>  mount namespace as a single unit,
>  and recursive mounts that propagate between
>  mount namespaces propagate as a single unit.)
> +.IP
> +In this context, "may not be separated" means that the mounts
> +are locked so that they may not be individually unmounted.
> +Consider the following example:
> +.IP
> +.RS
> +.in +4n
> +.EX
> +$ \fBsudo mkdir /mnt/dir\fP
> +$ \fBsudo sh \-c \(aqecho "aaaaaa" > /mnt/dir/a\(aq\fP
> +$ \fBsudo mount \-\-bind -o ro /some/path /mnt/dir\fP
> +$ \fBls /mnt/dir\fP   # Former contents of directory are invisible

Do we want a more motivating example such as a /proc/sys?

It has been common to mount over /proc files and directories that can be
written to by the global root so that users in a mount namespace may not
touch them.


> +.EE
> +.in
> +.RE
> +.IP
> +The above steps, performed in a more privileged user namespace,
> +have created a (read-only) bind mount that
> +obscures the contents of the directory
> +.IR /mnt/dir .
> +For security reasons, it should not be possible to unmount
> +that mount in a less privileged user namespace,
> +since that would reveal the contents of the directory
> +.IR /mnt/dir .
 > +.IP
> +Suppose we now create a new mount namespace
> +owned by a (new) subordinate user namespace.
> +The new mount namespace will inherit copies of all of the mounts
> +from the previous mount namespace.
> +However, those mounts will be locked because the new mount namespace
> +is owned by a less privileged user namespace.
> +Consequently, an attempt to unmount the mount fails:
> +.IP
> +.RS
> +.in +4n
> +.EX
> +$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
> +               \fBstrace \-o /tmp/log \e\fP
> +               \fBumount /mnt/dir\fP
> +umount: /mnt/dir: not mounted.
> +$ \fBgrep \(aq^umount\(aq /tmp/log\fP
> +umount2("/mnt/dir", 0)     = \-1 EINVAL (Invalid argument)
> +.EE
> +.in
> +.RE
> +.IP
> +The error message from
> +.BR mount (8)
> +is a little confusing, but the
> +.BR strace (1)
> +output reveals that the underlying
> +.BR umount2 (2)
> +system call failed with the error
> +.BR EINVAL ,
> +which is the error that the kernel returns to indicate that
> +the mount is locked.

Do you want to mention that you can unmount the entire subtree?  Either
with pivot_root if it is locked to "/" or with
"umount -l /path/to/propagated/directory".

>  .IP *
>  The
>  .BR mount (2)
> @@ -128,6 +184,23 @@ settings become locked
>  when propagated from a more privileged to
>  a less privileged mount namespace,
>  and may not be changed in the less privileged mount namespace.
> +.IP
> +This point can be illustrated by a continuation of the previous example.
> +In that example, the bind mount was marked as read-only.
> +For security reasons,
> +it should not be possible to make the mount writable in
> +a less privileged namespace, and indeed the kernel prevents this,
> +as illustrated by the following:
> +.IP
> +.RS
> +.in +4n
> +.EX
> +$ \fBsudo unshare \-\-user \-\-map\-root\-user \-\-mount \e\fP
> +               \fBmount \-o remount,rw /mnt/dir\fP
> +mount: /mnt/dir: permission denied.
> +.EE
> +.in
> +.RE
>  .IP *
>  .\" (As of 3.18-rc1 (in Al Viro's 2014-08-30 vfs.git#for-next tree))
>  A file or directory that is a mount point in one namespace that is not

Eric
