Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE853347D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 20:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhCJTYP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 14:24:15 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:45748 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhCJTXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 14:23:38 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK4Qe-004tqH-NV; Wed, 10 Mar 2021 12:23:32 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK4Qc-000rmA-Vd; Wed, 10 Mar 2021 12:23:32 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@linux.microsoft.com>
References: <20210310181857.401675-1-mic@digikod.net>
        <20210310181857.401675-2-mic@digikod.net>
Date:   Wed, 10 Mar 2021 13:23:35 -0600
In-Reply-To: <20210310181857.401675-2-mic@digikod.net> (=?utf-8?Q?=22Micka?=
 =?utf-8?Q?=C3=ABl_Sala=C3=BCn=22's?=
        message of "Wed, 10 Mar 2021 19:18:57 +0100")
Message-ID: <m17dmeq0co.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lK4Qc-000rmA-Vd;;;mid=<m17dmeq0co.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19S/7ngoYSiqgP0zhuPuu98BieLUm0rlgg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,T_XMDrugObfuBody_08,
        XMSubLong,XM_B_SpammyTLD,XM_B_SpammyWords,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?****;Micka=c3=abl Sala=c3=bcn <mic@digikod.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 1166 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.4 (0.3%), b_tie_ro: 2.3 (0.2%), parse: 1.50
        (0.1%), extract_message_metadata: 62 (5.3%), get_uri_detail_list: 8
        (0.6%), tests_pri_-1000: 79 (6.8%), tests_pri_-950: 1.07 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 444 (38.1%), check_bayes:
        419 (35.9%), b_tokenize: 23 (2.0%), b_tok_get_all: 13 (1.2%),
        b_comp_prob: 5 (0.5%), b_tok_touch_all: 373 (32.0%), b_finish: 0.72
        (0.1%), tests_pri_0: 557 (47.8%), check_dkim_signature: 0.50 (0.0%),
        check_dkim_adsp: 2.1 (0.2%), poll_dns_idle: 0.61 (0.1%), tests_pri_10:
        2.8 (0.2%), tests_pri_500: 10 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 1/1] fs: Allow no_new_privs tasks to call chroot(2)
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mickaël Salaün <mic@digikod.net> writes:

> From: Mickaël Salaün <mic@linux.microsoft.com>
>
> Being able to easily change root directories enable to ease some
> development workflow and can be used as a tool to strengthen
> unprivileged security sandboxes.  chroot(2) is not an access-control
> mechanism per se, but it can be used to limit the absolute view of the
> filesystem, and then limit ways to access data and kernel interfaces
> (e.g. /proc, /sys, /dev, etc.).
>
> Users may not wish to expose namespace complexity to potentially
> malicious processes, or limit their use because of limited resources.
> The chroot feature is much more simple (and limited) than the mount
> namespace, but can still be useful.  As for containers, users of
> chroot(2) should take care of file descriptors or data accessible by
> other means (e.g. current working directory, leaked FDs, passed FDs,
> devices, mount points, etc.).  There is a lot of literature that discuss
> the limitations of chroot, and users of this feature should be aware of
> the multiple ways to bypass it.  Using chroot(2) for security purposes
> can make sense if it is combined with other features (e.g. dedicated
> user, seccomp, LSM access-controls, etc.).
>
> One could argue that chroot(2) is useless without a properly populated
> root hierarchy (i.e. without /dev and /proc).  However, there are
> multiple use cases that don't require the chrooting process to create
> file hierarchies with special files nor mount points, e.g.:
> * A process sandboxing itself, once all its libraries are loaded, may
>   not need files other than regular files, or even no file at all.
> * Some pre-populated root hierarchies could be used to chroot into,
>   provided for instance by development environments or tailored
>   distributions.
> * Processes executed in a chroot may not require access to these special
>   files (e.g. with minimal runtimes, or by emulating some special files
>   with a LD_PRELOADed library or seccomp).
>
> Allowing a task to change its own root directory is not a threat to the
> system if we can prevent confused deputy attacks, which could be
> performed through execution of SUID-like binaries.  This can be
> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
> prctl(2).  To only affect this task, its filesystem information must not
> be shared with other tasks, which can be achieved by not passing
> CLONE_FS to clone(2).  A similar no_new_privs check is already used by
> seccomp to avoid the same kind of security issues.  Furthermore, because
> of its security use and to avoid giving a new way for attackers to get
> out of a chroot (e.g. using /proc/<pid>/root), an unprivileged chroot is
> only allowed if the new root directory is the same or beneath the
> current one.  This still allows a process to use a subset of its
> legitimate filesystem to chroot into and then further reduce its view of
> the filesystem.
>
> This change may not impact systems relying on other permission models
> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on
> such systems may require to update their security policies.
>
> Only the chroot system call is relaxed with this no_new_privs check; the
> init_chroot() helper doesn't require such change.
>
> Allowing unprivileged users to use chroot(2) is one of the initial
> objectives of no_new_privs:
> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html
> This patch is a follow-up of a previous one sent by Andy Lutomirski, but
> with less limitations:
> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.1327858005.git.luto@amacapital.net/
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20210310181857.401675-2-mic@digikod.net
> ---
>
> Changes since v1:
> * Replace custom is_path_beneath() with existing path_is_under().

Neither is_path_beneath nor path_is_under really help prevent escapes,
as except for open files and files accessible from proc chroot already
disallows going up.  The reason is the path is resolved with the current
root before switching to it.

My brain was fuzzy.  I had the classic escape scenario confused.
It isn't chroot("../../..");

The actual classic chroot escape is.
chdir("/");
chroot("/somedir");
chdir("../../../..");

Your change would disallow changing the root directory, but it doesn't
much help as all files in the mount namespace are visible anyway.

Furthermore changing chdir to ensure it's path is at or beneath the
current root would cause regressions in existing userspace programs
so we can't do that.

Plus you are trying to rely on changing the definition of chroot to make
it safe (not just changing the permission checks).  That is also
confusing and makes it difficult to analyze because people's previous
analysis gets confused.


Eric

> ---
>  fs/open.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/fs/open.c b/fs/open.c
> index e53af13b5835..280dbff25b25 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  #include <linux/fs.h>
> +#include <linux/path.h>
>  #include <linux/personality.h>
>  #include <linux/pagemap.h>
>  #include <linux/syscalls.h>
> @@ -546,15 +547,31 @@ SYSCALL_DEFINE1(chroot, const char __user *, filename)
>  	if (error)
>  		goto dput_and_out;
>  
> +	/*
> +	 * Changing the root directory for the calling task (and its future
> +	 * children) requires that this task has CAP_SYS_CHROOT in its
> +	 * namespace, or be running with no_new_privs and not sharing its
> +	 * fs_struct and not escaping its current root directory.  As for
> +	 * seccomp, checking no_new_privs avoids scenarios where unprivileged
> +	 * tasks can affect the behavior of privileged children.  Lock the path
> +	 * to protect against TOCTOU race between path_is_under() and
> +	 * set_fs_root().  No need to lock the root because it is not possible
> +	 * to rename it beneath itself.
> +	 */
>  	error = -EPERM;
> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
> -		goto dput_and_out;
> +	inode_lock(d_inode(path.dentry));
> +	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
> +			!(task_no_new_privs(current) && current->fs->users == 1
> +				&& path_is_under(&path, &current->fs->root)))
> +		goto unlock_and_out;
>  	error = security_path_chroot(&path);
>  	if (error)
> -		goto dput_and_out;
> +		goto unlock_and_out;
>  
>  	set_fs_root(current->fs, &path);
>  	error = 0;
> +unlock_and_out:
> +	inode_unlock(d_inode(path.dentry));
>  dput_and_out:
>  	path_put(&path);
>  	if (retry_estale(error, lookup_flags)) {
