Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522B31B5B40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 14:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgDWMTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 08:19:22 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33428 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgDWMTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:19:21 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRap5-00048z-2F; Thu, 23 Apr 2020 06:19:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jRap3-0005q7-LI; Thu, 23 Apr 2020 06:19:18 -0600
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
References: <20200419141057.621356-3-gladkov.alexey@gmail.com>
        <20200423112858.95820-1-gladkov.alexey@gmail.com>
Date:   Thu, 23 Apr 2020 07:16:07 -0500
In-Reply-To: <20200423112858.95820-1-gladkov.alexey@gmail.com> (Alexey
        Gladkov's message of "Thu, 23 Apr 2020 13:28:58 +0200")
Message-ID: <87lfmmz9bs.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jRap3-0005q7-LI;;;mid=<87lfmmz9bs.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+iR9pVq9wAKGMb1dkjvzvzUUF2IrtP4AY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexey Gladkov <gladkov.alexey@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 666 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.6%), b_tie_ro: 2.9 (0.4%), parse: 1.19
        (0.2%), extract_message_metadata: 4.8 (0.7%), get_uri_detail_list: 2.6
        (0.4%), tests_pri_-1000: 4.4 (0.7%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.82 (0.1%), tests_pri_-90: 318 (47.7%), check_bayes:
        316 (47.5%), b_tokenize: 10 (1.5%), b_tok_get_all: 12 (1.9%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 288 (43.3%), b_finish: 0.83
        (0.1%), tests_pri_0: 317 (47.5%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.91 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v13 2/7] proc: allow to mount many instances of proc in one pid namespace
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


I took a quick look and there is at least one other use in security/tomoyo/realpath.c:

static char *tomoyo_get_local_path(struct dentry *dentry, char * const buffer,
				   const int buflen)
{
	struct super_block *sb = dentry->d_sb;
	char *pos = tomoyo_get_dentry_path(dentry, buffer, buflen);

	if (IS_ERR(pos))
		return pos;
	/* Convert from $PID to self if $PID is current thread. */
	if (sb->s_magic == PROC_SUPER_MAGIC && *pos == '/') {
		char *ep;
		const pid_t pid = (pid_t) simple_strtoul(pos + 1, &ep, 10);

		if (*ep == '/' && pid && pid ==
		    task_tgid_nr_ns(current, sb->s_fs_info)) {
			pos = ep - 5;
			if (pos < buffer)
				goto out;
			memmove(pos, "/self", 5);
		}
		goto prepend_filesystem_name;
	}

Can you make the fixes to locks.c and tomoyo a couple of standalone
fixes that should be inserted before your patch?

On the odd chance there is a typo they will bisect better, as well
as just keeping this patch and it's description from expanding in size.
So that things are small enough for people to really look at and review.

The fix itself looks fine.

Thank you,
Eric


Alexey Gladkov <gladkov.alexey@gmail.com> writes:

> Fixed getting proc_pidns in the lock_get_status() and locks_show() directly from
> the superblock, which caused a crash:
>
> === arm64 ===
> [12140.366814] LTP: starting proc01 (proc01 -m 128)
> [12149.580943] ==================================================================
> [12149.589521] BUG: KASAN: out-of-bounds in pid_nr_ns+0x2c/0x90 pid_nr_ns at kernel/pid.c:456
> [12149.595939] Read of size 4 at addr 1bff000bfa8c0388 by task = proc01/50298
> [12149.603392] Pointer tag: [1b], memory tag: [fe]
>
> [12149.610906] CPU: 69 PID: 50298 Comm: proc01 Tainted: G L 5.7.0-rc2-next-20200422 #6
> [12149.620585] Hardware name: HPE Apollo 70 /C01_APACHE_MB , BIOS L50_5.13_1.11 06/18/2019
> [12149.631074] Call trace:
> [12149.634304]  dump_backtrace+0x0/0x22c
> [12149.638745]  show_stack+0x28/0x34
> [12149.642839]  dump_stack+0x104/0x194
> [12149.647110]  print_address_description+0x70/0x3a4
> [12149.652576]  __kasan_report+0x188/0x238
> [12149.657169]  kasan_report+0x3c/0x58
> [12149.661430]  check_memory_region+0x98/0xa0
> [12149.666303]  __hwasan_load4_noabort+0x18/0x20
> [12149.671431]  pid_nr_ns+0x2c/0x90
> [12149.675446]  locks_translate_pid+0xf4/0x1a0
> [12149.680382]  locks_show+0x68/0x110
> [12149.684536]  seq_read+0x380/0x930
> [12149.688604]  pde_read+0x5c/0x78
> [12149.692498]  proc_reg_read+0x74/0xc0
> [12149.696813]  __vfs_read+0x84/0x1d0
> [12149.700939]  vfs_read+0xec/0x124
> [12149.704889]  ksys_read+0xb0/0x120
> [12149.708927]  __arm64_sys_read+0x54/0x88
> [12149.713485]  do_el0_svc+0x128/0x1dc
> [12149.717697]  el0_sync_handler+0x150/0x250
> [12149.722428]  el0_sync+0x164/0x180
>
> [12149.728672] Allocated by task 1:
> [12149.732624]  __kasan_kmalloc+0x124/0x188
> [12149.737269]  kasan_kmalloc+0x10/0x18
> [12149.741568]  kmem_cache_alloc_trace+0x2e4/0x3d4
> [12149.746820]  proc_fill_super+0x48/0x1fc
> [12149.751377]  vfs_get_super+0xcc/0x170
> [12149.755760]  get_tree_nodev+0x28/0x34
> [12149.760143]  proc_get_tree+0x24/0x30
> [12149.764439]  vfs_get_tree+0x54/0x158
> [12149.768736]  do_mount+0x80c/0xaf0
> [12149.772774]  __arm64_sys_mount+0xe0/0x18c
> [12149.777504]  do_el0_svc+0x128/0x1dc
> [12149.781715]  el0_sync_handler+0x150/0x250
> [12149.786445]  el0_sync+0x164/0x180

> diff --git a/fs/locks.c b/fs/locks.c
> index b8a31c1c4fff..399c5dbb72c4 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2823,7 +2823,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  {
>  	struct inode *inode = NULL;
>  	unsigned int fl_pid;
> -	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
> +	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
>  
>  	fl_pid = locks_translate_pid(fl, proc_pidns);
>  	/*
> @@ -2901,7 +2901,7 @@ static int locks_show(struct seq_file *f, void *v)
>  {
>  	struct locks_iterator *iter = f->private;
>  	struct file_lock *fl, *bfl;
> -	struct pid_namespace *proc_pidns = file_inode(f->file)->i_sb->s_fs_info;
> +	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file));
>  
>  	fl = hlist_entry(v, struct file_lock, fl_link);
>  

Eric
