Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694C4A4ED5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357895AbiAaSr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:47:59 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:59644 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357716AbiAaSro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:47:44 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:42370)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbiI-00HXSu-1F; Mon, 31 Jan 2022 11:47:43 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:56392 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbiG-007mQf-FJ; Mon, 31 Jan 2022 11:47:41 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
        <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
Date:   Mon, 31 Jan 2022 12:47:34 -0600
In-Reply-To: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 31 Jan 2022 12:44:53 -0600")
Message-ID: <87iltzn3nd.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEbiG-007mQf-FJ;;;mid=<87iltzn3nd.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oGpZ9UFLzbnQWhkV7XiMYkWr0BtePZic=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_SCC_BODY_TEXT_LINE,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 547 ms - load_scoreonly_sql: 0.12 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.6%), parse: 1.14 (0.2%),
         extract_message_metadata: 17 (3.0%), get_uri_detail_list: 3.0 (0.6%),
        tests_pri_-1000: 24 (4.4%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 77 (14.0%), check_bayes:
        75 (13.7%), b_tokenize: 21 (3.8%), b_tok_get_all: 12 (2.1%),
        b_comp_prob: 4.8 (0.9%), b_tok_touch_all: 34 (6.2%), b_finish: 1.00
        (0.2%), tests_pri_0: 403 (73.7%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 3.6 (0.7%), poll_dns_idle: 0.41 (0.1%), tests_pri_10:
        1.89 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 5/5] coredump: Use the vma snapshot in fill_files_note
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Matthew Wilcox reported that there is a missing mmap_lock in
file_files_note that could possibly lead to a user after free.

Solve this by using the existing vma snapshot for consistency
and to avoid the need to take the mmap_lock anywhere in the
coredump code except for dump_vma_snapshot.

Update the dump_vma_snapshot to capture vm_pgoff and vm_file
that are neeeded by fill_files_note.

Add free_vma_snapshot to free the captured values of vm_file.

Reported-by: Matthew Wilcox <willy@infradead.org>
Link: https://lkml.kernel.org/r/20220131153740.2396974-1-willy@infradead.org
Cc: stable@vger.kernel.org
Fixes: a07279c9a8cd ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain file names of mapped files")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_elf.c          | 19 ++++++++++---------
 fs/coredump.c            | 22 +++++++++++++++++++++-
 include/linux/coredump.h |  2 ++
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 272032b1f9a2..5fcaa01d211e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1619,14 +1619,14 @@ static void fill_siginfo_note(struct memelfnote *note, user_siginfo_t *csigdata,
  *   long file_ofs
  * followed by COUNT filenames in ASCII: "FILE1" NUL "FILE2" NUL...
  */
-static int fill_files_note(struct memelfnote *note)
+static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned count, size, names_ofs, remaining, n;
 	user_long_t *data;
 	user_long_t *start_end_ofs;
 	char *name_base, *name_curpos;
+	int i;
 
 	/* *Estimated* file count and total data size needed */
 	count = mm->map_count;
@@ -1651,11 +1651,12 @@ static int fill_files_note(struct memelfnote *note)
 	name_base = name_curpos = ((char *)data) + names_ofs;
 	remaining = size - names_ofs;
 	count = 0;
-	for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
+	for (i = 0; i < cprm->vma_count; i++) {
+		struct core_vma_metadata *m = &cprm->vma_meta[i];
 		struct file *file;
 		const char *filename;
 
-		file = vma->vm_file;
+		file = m->file;
 		if (!file)
 			continue;
 		filename = file_path(file, name_curpos, remaining);
@@ -1675,9 +1676,9 @@ static int fill_files_note(struct memelfnote *note)
 		memmove(name_curpos, filename, n);
 		name_curpos += n;
 
-		*start_end_ofs++ = vma->vm_start;
-		*start_end_ofs++ = vma->vm_end;
-		*start_end_ofs++ = vma->vm_pgoff;
+		*start_end_ofs++ = m->start;
+		*start_end_ofs++ = m->end;
+		*start_end_ofs++ = m->pgoff;
 		count++;
 	}
 
@@ -1887,7 +1888,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	fill_auxv_note(&info->auxv, current->mm);
 	info->size += notesize(&info->auxv);
 
-	if (fill_files_note(&info->files) == 0)
+	if (fill_files_note(&info->files, cprm) == 0)
 		info->size += notesize(&info->files);
 
 	return 1;
@@ -2076,7 +2077,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 	fill_auxv_note(info->notes + 3, current->mm);
 	info->numnote = 4;
 
-	if (fill_files_note(info->notes + info->numnote) == 0) {
+	if (fill_files_note(info->notes + info->numnote, cprm) == 0) {
 		info->notes_files = info->notes + info->numnote;
 		info->numnote++;
 	}
diff --git a/fs/coredump.c b/fs/coredump.c
index c5e7d63525c6..6a97a8ea7295 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -54,6 +54,7 @@
 #include <trace/events/sched.h>
 
 static bool dump_vma_snapshot(struct coredump_params *cprm);
+static void free_vma_snapshot(struct coredump_params *cprm);
 
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
@@ -764,7 +765,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			dump_emit(&cprm, "", 1);
 		}
 		file_end_write(cprm.file);
-		kvfree(cprm.vma_meta);
+		free_vma_snapshot(&cprm);
 	}
 	if (ispipe && core_pipe_limit)
 		wait_for_dump_helpers(cprm.file);
@@ -1085,6 +1086,20 @@ static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
 	return gate_vma;
 }
 
+static void free_vma_snapshot(struct coredump_params *cprm)
+{
+	if (cprm->vma_meta) {
+		int i;
+		for (i = 0; i < cprm->vma_count; i++) {
+			struct file *file = cprm->vma_meta[i].file;
+			if (file)
+				fput(file);
+		}
+		kvfree(cprm->vma_meta);
+		cprm->vma_meta = NULL;
+	}
+}
+
 /*
  * Under the mmap_lock, take a snapshot of relevant information about the task's
  * VMAs.
@@ -1121,6 +1136,11 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
 		m->end = vma->vm_end;
 		m->flags = vma->vm_flags;
 		m->dump_size = vma_dump_size(vma, cprm->mm_flags);
+		m->pgoff = vma->vm_pgoff;
+
+		m->file = vma->vm_file;
+		if (m->file)
+			get_file(m->file);
 
 		cprm->vma_data_size += m->dump_size;
 	}
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 7d05370e555e..08a1d3e7e46d 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -12,6 +12,8 @@ struct core_vma_metadata {
 	unsigned long start, end;
 	unsigned long flags;
 	unsigned long dump_size;
+	unsigned long pgoff;
+	struct file   *file;
 };
 
 struct coredump_params {
-- 
2.29.2

