Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5821AE588
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbgDQTJA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Apr 2020 15:09:00 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41364 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730159AbgDQTI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:08:56 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPWMA-0001fW-Vt; Fri, 17 Apr 2020 13:08:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jPWM9-0002Jc-Oz; Fri, 17 Apr 2020 13:08:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>
References: <20200409123752.1070597-1-gladkov.alexey@gmail.com>
        <20200409123752.1070597-8-gladkov.alexey@gmail.com>
Date:   Fri, 17 Apr 2020 14:05:50 -0500
In-Reply-To: <20200409123752.1070597-8-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Thu, 9 Apr 2020 14:37:51 +0200")
Message-ID: <87imhyaq5t.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jPWM9-0002Jc-Oz;;;mid=<87imhyaq5t.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18mi3tx9WzkSqqVKApsnvyPLwyDMV1zckg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4925]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 806 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.3%), b_tie_ro: 9 (1.2%), parse: 1.20 (0.1%),
         extract_message_metadata: 15 (1.9%), get_uri_detail_list: 5.0 (0.6%),
        tests_pri_-1000: 14 (1.8%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.19 (0.1%), tests_pri_-90: 168 (20.9%), check_bayes:
        165 (20.5%), b_tokenize: 23 (2.8%), b_tok_get_all: 71 (8.8%),
        b_comp_prob: 4.0 (0.5%), b_tok_touch_all: 64 (7.9%), b_finish: 0.94
        (0.1%), tests_pri_0: 580 (71.9%), check_dkim_signature: 1.07 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.24 (0.0%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RESEND v11 7/8] proc: use human-readable values for hidepid
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> The hidepid parameter values are becoming more and more and it becomes
> difficult to remember what each new magic number means.

So I relooked at the code.  And I think I was misreading things.
However I think it is a legitimate concern.

Can you please mention in your description of this change that
switching from fsparam_u32 to fs_param_string is safe even when
using the new mount api because fsparam_u32 and fs_param_string
both are sent from userspace with "fsconfig(fd, FSCONFIG_SET_STRING, ...)".

Or words to that effect.  Ideally you will even manually test that case
to confirm.

Thank you,
Eric


> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> Reviewed-by: Alexey Dobriyan <adobriyan@gmail.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  Documentation/filesystems/proc.txt | 52 +++++++++++++++---------------
>  fs/proc/inode.c                    | 15 ++++++++-
>  fs/proc/root.c                     | 38 +++++++++++++++++++---
>  3 files changed, 74 insertions(+), 31 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index bd0e0ab85048..af47672cb2cb 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -2025,28 +2025,28 @@ The following mount options are supported:
>  	gid=		Set the group authorized to learn processes information.
>  	subset=		Show only the specified subset of procfs.
>  
> -hidepid=0 means classic mode - everybody may access all /proc/<pid>/ directories
> -(default).
> -
> -hidepid=1 means users may not access any /proc/<pid>/ directories but their
> -own.  Sensitive files like cmdline, sched*, status are now protected against
> -other users.  This makes it impossible to learn whether any user runs
> -specific program (given the program doesn't reveal itself by its behaviour).
> -As an additional bonus, as /proc/<pid>/cmdline is unaccessible for other users,
> -poorly written programs passing sensitive information via program arguments are
> -now protected against local eavesdroppers.
> -
> -hidepid=2 means hidepid=1 plus all /proc/<pid>/ will be fully invisible to other
> -users.  It doesn't mean that it hides a fact whether a process with a specific
> -pid value exists (it can be learned by other means, e.g. by "kill -0 $PID"),
> -but it hides process' uid and gid, which may be learned by stat()'ing
> -/proc/<pid>/ otherwise.  It greatly complicates an intruder's task of gathering
> -information about running processes, whether some daemon runs with elevated
> -privileges, whether other user runs some sensitive program, whether other users
> -run any program at all, etc.
> -
> -hidepid=4 means that procfs should only contain /proc/<pid>/ directories
> -that the caller can ptrace.
> +hidepid=off or hidepid=0 means classic mode - everybody may access all
> +/proc/<pid>/ directories (default).
> +
> +hidepid=noaccess or hidepid=1 means users may not access any /proc/<pid>/
> +directories but their own.  Sensitive files like cmdline, sched*, status are now
> +protected against other users.  This makes it impossible to learn whether any
> +user runs specific program (given the program doesn't reveal itself by its
> +behaviour).  As an additional bonus, as /proc/<pid>/cmdline is unaccessible for
> +other users, poorly written programs passing sensitive information via program
> +arguments are now protected against local eavesdroppers.
> +
> +hidepid=invisible or hidepid=2 means hidepid=noaccess plus all /proc/<pid>/ will
> +be fully invisible to other users.  It doesn't mean that it hides a fact whether
> +a process with a specific pid value exists (it can be learned by other means,
> +e.g. by "kill -0 $PID"), but it hides process' uid and gid, which may be learned
> +by stat()'ing /proc/<pid>/ otherwise.  It greatly complicates an intruder's task
> +of gathering information about running processes, whether some daemon runs with
> +elevated privileges, whether other user runs some sensitive program, whether
> +other users run any program at all, etc.
> +
> +hidepid=ptraceable or hidepid=4 means that procfs should only contain
> +/proc/<pid>/ directories that the caller can ptrace.
>  
>  gid= defines a group authorized to learn processes information otherwise
>  prohibited by hidepid=.  If you use some daemon like identd which needs to learn
> @@ -2093,8 +2093,8 @@ creates a new procfs instance. Mount options affect own procfs instance.
>  It means that it became possible to have several procfs instances
>  displaying tasks with different filtering options in one pid namespace.
>  
> -# mount -o hidepid=2 -t proc proc /proc
> -# mount -o hidepid=1 -t proc proc /tmp/proc
> +# mount -o hidepid=invisible -t proc proc /proc
> +# mount -o hidepid=noaccess -t proc proc /tmp/proc
>  # grep ^proc /proc/mounts
> -proc /proc proc rw,relatime,hidepid=2 0 0
> -proc /tmp/proc proc rw,relatime,hidepid=1 0 0
> +proc /proc proc rw,relatime,hidepid=invisible 0 0
> +proc /tmp/proc proc rw,relatime,hidepid=noaccess 0 0
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index e6577ce6027b..d38a9e592352 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -24,6 +24,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/mount.h>
> +#include <linux/bug.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -165,6 +166,18 @@ void proc_invalidate_siblings_dcache(struct hlist_head *inodes, spinlock_t *lock
>  		deactivate_super(old_sb);
>  }
>  
> +static inline const char *hidepid2str(int v)
> +{
> +	switch (v) {
> +		case HIDEPID_OFF: return "off";
> +		case HIDEPID_NO_ACCESS: return "noaccess";
> +		case HIDEPID_INVISIBLE: return "invisible";
> +		case HIDEPID_NOT_PTRACEABLE: return "ptraceable";
> +	}
> +	WARN_ONCE(1, "bad hide_pid value: %d\n", v);
> +	return "unknown";
> +}
> +
>  static int proc_show_options(struct seq_file *seq, struct dentry *root)
>  {
>  	struct proc_fs_info *fs_info = proc_sb_info(root->d_sb);
> @@ -172,7 +185,7 @@ static int proc_show_options(struct seq_file *seq, struct dentry *root)
>  	if (!gid_eq(fs_info->pid_gid, GLOBAL_ROOT_GID))
>  		seq_printf(seq, ",gid=%u", from_kgid_munged(&init_user_ns, fs_info->pid_gid));
>  	if (fs_info->hide_pid != HIDEPID_OFF)
> -		seq_printf(seq, ",hidepid=%u", fs_info->hide_pid);
> +		seq_printf(seq, ",hidepid=%s", hidepid2str(fs_info->hide_pid));
>  	if (fs_info->pidonly != PROC_PIDONLY_OFF)
>  		seq_printf(seq, ",subset=pid");
>  
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index dbcd96f07c7a..c6caae9e4308 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -45,7 +45,7 @@ enum proc_param {
>  
>  static const struct fs_parameter_spec proc_fs_parameters[] = {
>  	fsparam_u32("gid",	Opt_gid),
> -	fsparam_u32("hidepid",	Opt_hidepid),
> +	fsparam_string("hidepid",	Opt_hidepid),
>  	fsparam_string("subset",	Opt_subset),
>  	{}
>  };
> @@ -58,6 +58,37 @@ static inline int valid_hidepid(unsigned int value)
>  		value == HIDEPID_NOT_PTRACEABLE);
>  }
>  
> +static int proc_parse_hidepid_param(struct fs_context *fc, struct fs_parameter *param)
> +{
> +	struct proc_fs_context *ctx = fc->fs_private;
> +	struct fs_parameter_spec hidepid_u32_spec = fsparam_u32("hidepid", Opt_hidepid);
> +	struct fs_parse_result result;
> +	int base = (unsigned long)hidepid_u32_spec.data;
> +
> +	if (param->type != fs_value_is_string)
> +		return invalf(fc, "proc: unexpected type of hidepid value\n");
> +
> +	if (!kstrtouint(param->string, base, &result.uint_32)) {
> +		if (!valid_hidepid(result.uint_32))
> +			return invalf(fc, "proc: unknown value of hidepid - %s\n", param->string);
> +		ctx->hidepid = result.uint_32;
> +		return 0;
> +	}
> +
> +	if (!strcmp(param->string, "off"))
> +		ctx->hidepid = HIDEPID_OFF;
> +	else if (!strcmp(param->string, "noaccess"))
> +		ctx->hidepid = HIDEPID_NO_ACCESS;
> +	else if (!strcmp(param->string, "invisible"))
> +		ctx->hidepid = HIDEPID_INVISIBLE;
> +	else if (!strcmp(param->string, "ptraceable"))
> +		ctx->hidepid = HIDEPID_NOT_PTRACEABLE;
> +	else
> +		return invalf(fc, "proc: unknown value of hidepid - %s\n", param->string);
> +
> +	return 0;
> +}
> +
>  static int proc_parse_subset_param(struct fs_context *fc, char *value)
>  {
>  	struct proc_fs_context *ctx = fc->fs_private;
> @@ -97,9 +128,8 @@ static int proc_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  
>  	case Opt_hidepid:
> -		if (!valid_hidepid(result.uint_32))
> -			return invalf(fc, "proc: unknown value of hidepid.\n");
> -		ctx->hidepid = result.uint_32;
> +		if (proc_parse_hidepid_param(fc, param))
> +			return -EINVAL;
>  		break;
>  
>  	case Opt_subset:
