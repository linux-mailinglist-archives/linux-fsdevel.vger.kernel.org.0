Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D392B1740E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgB1UU4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 15:20:56 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:58806 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgB1UU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:20:56 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7m7y-0006J6-Sk; Fri, 28 Feb 2020 13:20:54 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j7m7x-0002pK-QT; Fri, 28 Feb 2020 13:20:54 -0700
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
        <878skmsbyy.fsf_-_@x220.int.ebiederm.org>
Date:   Fri, 28 Feb 2020 14:18:43 -0600
In-Reply-To: <878skmsbyy.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Fri, 28 Feb 2020 14:17:41 -0600")
Message-ID: <87wo86qxcs.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j7m7x-0002pK-QT;;;mid=<87wo86qxcs.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/GoFUi05+QdGnxptjvdL+9xjBop5u87I=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 576 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.0 (0.5%), b_tie_ro: 2.0 (0.4%), parse: 1.15
        (0.2%), extract_message_metadata: 21 (3.7%), get_uri_detail_list: 1.81
        (0.3%), tests_pri_-1000: 41 (7.1%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 32 (5.5%), check_bayes: 30
        (5.2%), b_tokenize: 11 (1.9%), b_tok_get_all: 9 (1.6%), b_comp_prob:
        2.7 (0.5%), b_tok_touch_all: 4.6 (0.8%), b_finish: 0.73 (0.1%),
        tests_pri_0: 459 (79.8%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.58 (0.1%), tests_pri_10:
        3.0 (0.5%), tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/3] uml: Create a private mount of proc for mconsole
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The mconsole code only ever accesses proc for the initial pid
namespace.  Instead of depending upon the proc_mnt which is
for proc_flush_task have uml create it's own mount of proc
instead.

This allows proc_flush_task to evolve and remove the
need for having a proc_mnt to do it's job.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/um/drivers/mconsole_kern.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index e8f5c81c2c6c..30575bd92975 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -36,6 +36,8 @@
 #include "mconsole_kern.h"
 #include <os.h>
 
+static struct vfsmount *proc_mnt = NULL;
+
 static int do_unlink_socket(struct notifier_block *notifier,
 			    unsigned long what, void *data)
 {
@@ -123,7 +125,7 @@ void mconsole_log(struct mc_request *req)
 
 void mconsole_proc(struct mc_request *req)
 {
-	struct vfsmount *mnt = init_pid_ns.proc_mnt;
+	struct vfsmount *mnt = proc_mnt;
 	char *buf;
 	int len;
 	struct file *file;
@@ -134,6 +136,10 @@ void mconsole_proc(struct mc_request *req)
 	ptr += strlen("proc");
 	ptr = skip_spaces(ptr);
 
+	if (!mnt) {
+		mconsole_reply(req, "Proc not available", 1, 0);
+		goto out;
+	}
 	file = file_open_root(mnt->mnt_root, mnt, ptr, O_RDONLY, 0);
 	if (IS_ERR(file)) {
 		mconsole_reply(req, "Failed to open file", 1, 0);
@@ -683,6 +689,24 @@ void mconsole_stack(struct mc_request *req)
 	with_console(req, stack_proc, to);
 }
 
+static int __init mount_proc(void)
+{
+	struct file_system_type *proc_fs_type;
+	struct vfsmount *mnt;
+
+	proc_fs_type = get_fs_type("proc");
+	if (!proc_fs_type)
+		return -ENODEV;
+
+	mnt = kern_mount(proc_fs_type);
+	put_filesystem(proc_fs_type);
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	proc_mnt = mnt;
+	return 0;
+}
+
 /*
  * Changed by mconsole_setup, which is __setup, and called before SMP is
  * active.
@@ -696,6 +720,8 @@ static int __init mconsole_init(void)
 	int err;
 	char file[UNIX_PATH_MAX];
 
+	mount_proc();
+
 	if (umid_file_name("mconsole", file, sizeof(file)))
 		return -1;
 	snprintf(mconsole_socket_name, sizeof(file), "%s", file);
-- 
2.25.0

