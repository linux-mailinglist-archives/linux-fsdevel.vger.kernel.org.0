Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29F44A4EC9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 19:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358001AbiAaSqo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 13:46:44 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53156 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357874AbiAaSqa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:46:30 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:38410)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbh7-006cJB-Hq; Mon, 31 Jan 2022 11:46:29 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:56348 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nEbh6-007mDY-95; Mon, 31 Jan 2022 11:46:29 -0700
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
Date:   Mon, 31 Jan 2022 12:46:22 -0600
In-Reply-To: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 31 Jan 2022 12:44:53 -0600")
Message-ID: <87zgnbn3pd.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nEbh6-007mDY-95;;;mid=<87zgnbn3pd.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18iCW0pefaKEDCWcsCb444djzFslpKfK24=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_SCC_BODY_TEXT_LINE,T_TooManySym_01,XMNoVowels,
        XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 704 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.6%), b_tie_ro: 2.9 (0.4%), parse: 1.69
        (0.2%), extract_message_metadata: 13 (1.8%), get_uri_detail_list: 4.2
        (0.6%), tests_pri_-1000: 10 (1.5%), tests_pri_-950: 1.10 (0.2%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 96 (13.7%), check_bayes:
        95 (13.5%), b_tokenize: 14 (2.0%), b_tok_get_all: 12 (1.7%),
        b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 63 (9.0%), b_finish: 0.79
        (0.1%), tests_pri_0: 563 (80.0%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 1.13 (0.2%), tests_pri_10:
        2.7 (0.4%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/5] coredump: Snapshot the vmas in do_coredump
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Move the call of dump_vma_snapshot and kvfree(vma_meta) out of the
individual coredump routines into do_coredump itself.  This makes
the code less error prone and easier to maintain.

Make the vma snapshot available to the coredump routines
in struct coredump_params.  This makes it easier to
change and update what is captures in the vma snapshot
and will be needed for fixing fill_file_notes.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_elf.c          | 20 +++++++-------------
 fs/binfmt_elf_fdpic.c    | 18 ++++++------------
 fs/coredump.c            | 36 ++++++++++++++++++++----------------
 include/linux/coredump.h |  6 +++---
 4 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 605017eb9349..4822b04154e1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2169,8 +2169,7 @@ static void fill_extnum_info(struct elfhdr *elf, struct elf_shdr *shdr4extnum,
 static int elf_core_dump(struct coredump_params *cprm)
 {
 	int has_dumped = 0;
-	int vma_count, segs, i;
-	size_t vma_data_size;
+	int segs, i;
 	struct elfhdr elf;
 	loff_t offset = 0, dataoff;
 	struct elf_note_info info = { };
@@ -2178,16 +2177,12 @@ static int elf_core_dump(struct coredump_params *cprm)
 	struct elf_shdr *shdr4extnum = NULL;
 	Elf_Half e_phnum;
 	elf_addr_t e_shoff;
-	struct core_vma_metadata *vma_meta;
-
-	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, &vma_data_size))
-		return 0;
 
 	/*
 	 * The number of segs are recored into ELF header as 16bit value.
 	 * Please check DEFAULT_MAX_MAP_COUNT definition when you modify here.
 	 */
-	segs = vma_count + elf_core_extra_phdrs();
+	segs = cprm->vma_count + elf_core_extra_phdrs();
 
 	/* for notes section */
 	segs++;
@@ -2226,7 +2221,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
-	offset += vma_data_size;
+	offset += cprm->vma_data_size;
 	offset += elf_core_extra_data_size();
 	e_shoff = offset;
 
@@ -2246,8 +2241,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 		goto end_coredump;
 
 	/* Write program headers for segments dump */
-	for (i = 0; i < vma_count; i++) {
-		struct core_vma_metadata *meta = vma_meta + i;
+	for (i = 0; i < cprm->vma_count; i++) {
+		struct core_vma_metadata *meta = cprm->vma_meta + i;
 		struct elf_phdr phdr;
 
 		phdr.p_type = PT_LOAD;
@@ -2284,8 +2279,8 @@ static int elf_core_dump(struct coredump_params *cprm)
 	/* Align to page */
 	dump_skip_to(cprm, dataoff);
 
-	for (i = 0; i < vma_count; i++) {
-		struct core_vma_metadata *meta = vma_meta + i;
+	for (i = 0; i < cprm->vma_count; i++) {
+		struct core_vma_metadata *meta = cprm->vma_meta + i;
 
 		if (!dump_user_range(cprm, meta->start, meta->dump_size))
 			goto end_coredump;
@@ -2302,7 +2297,6 @@ static int elf_core_dump(struct coredump_params *cprm)
 end_coredump:
 	free_note_info(&info);
 	kfree(shdr4extnum);
-	kvfree(vma_meta);
 	kfree(phdr4note);
 	return has_dumped;
 }
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index c6f588dc4a9d..1a25536b0120 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1465,7 +1465,7 @@ static bool elf_fdpic_dump_segments(struct coredump_params *cprm,
 static int elf_fdpic_core_dump(struct coredump_params *cprm)
 {
 	int has_dumped = 0;
-	int vma_count, segs;
+	int segs;
 	int i;
 	struct elfhdr *elf = NULL;
 	loff_t offset = 0, dataoff;
@@ -1480,8 +1480,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	elf_addr_t e_shoff;
 	struct core_thread *ct;
 	struct elf_thread_status *tmp;
-	struct core_vma_metadata *vma_meta = NULL;
-	size_t vma_data_size;
 
 	/* alloc memory for large data structures: too large to be on stack */
 	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
@@ -1491,9 +1489,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!psinfo)
 		goto end_coredump;
 
-	if (dump_vma_snapshot(cprm, &vma_count, &vma_meta, &vma_data_size))
-		goto end_coredump;
-
 	for (ct = current->signal->core_state->dumper.next;
 					ct; ct = ct->next) {
 		tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
@@ -1513,7 +1508,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	tmp->next = thread_list;
 	thread_list = tmp;
 
-	segs = vma_count + elf_core_extra_phdrs();
+	segs = cprm->vma_count + elf_core_extra_phdrs();
 
 	/* for notes section */
 	segs++;
@@ -1558,7 +1553,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 	/* Page-align dumped data */
 	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
 
-	offset += vma_data_size;
+	offset += cprm->vma_data_size;
 	offset += elf_core_extra_data_size();
 	e_shoff = offset;
 
@@ -1578,8 +1573,8 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		goto end_coredump;
 
 	/* write program headers for segments dump */
-	for (i = 0; i < vma_count; i++) {
-		struct core_vma_metadata *meta = vma_meta + i;
+	for (i = 0; i < cprm->vma_count; i++) {
+		struct core_vma_metadata *meta = cprm->vma_meta + i;
 		struct elf_phdr phdr;
 		size_t sz;
 
@@ -1628,7 +1623,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 
 	dump_skip_to(cprm, dataoff);
 
-	if (!elf_fdpic_dump_segments(cprm, vma_meta, vma_count))
+	if (!elf_fdpic_dump_segments(cprm, cprm->vma_meta, cprm->vma_count))
 		goto end_coredump;
 
 	if (!elf_core_write_extra_data(cprm))
@@ -1652,7 +1647,6 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
 		thread_list = thread_list->next;
 		kfree(tmp);
 	}
-	kvfree(vma_meta);
 	kfree(phdr4note);
 	kfree(elf);
 	kfree(psinfo);
diff --git a/fs/coredump.c b/fs/coredump.c
index 1c060c0a2d72..def2a0c9cb14 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -53,6 +53,8 @@
 
 #include <trace/events/sched.h>
 
+static bool dump_vma_snapshot(struct coredump_params *cprm);
+
 static int core_uses_pid;
 static unsigned int core_pipe_limit;
 static char core_pattern[CORENAME_MAX_SIZE] = "core";
@@ -531,6 +533,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * by any locks.
 		 */
 		.mm_flags = mm->flags,
+		.vma_meta = NULL,
 	};
 
 	audit_core_dumps(siginfo->si_signo);
@@ -745,6 +748,9 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			pr_info("Core dump to |%s disabled\n", cn.corename);
 			goto close_fail;
 		}
+		if (!dump_vma_snapshot(&cprm))
+			goto close_fail;
+
 		file_start_write(cprm.file);
 		core_dumped = binfmt->core_dump(&cprm);
 		/*
@@ -758,6 +764,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 			dump_emit(&cprm, "", 1);
 		}
 		file_end_write(cprm.file);
+		kvfree(cprm.vma_meta);
 	}
 	if (ispipe && core_pipe_limit)
 		wait_for_dump_helpers(cprm.file);
@@ -1082,14 +1089,11 @@ static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
  * Under the mmap_lock, take a snapshot of relevant information about the task's
  * VMAs.
  */
-int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
-		      struct core_vma_metadata **vma_meta,
-		      size_t *vma_data_size_ptr)
+static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma, *gate_vma;
 	struct mm_struct *mm = current->mm;
 	int i;
-	size_t vma_data_size = 0;
 
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1097,36 +1101,36 @@ int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
 	 * mmap_lock in read mode.
 	 */
 	if (mmap_write_lock_killable(mm))
-		return -EINTR;
+		return false;
 
+	cprm->vma_data_size = 0;
 	gate_vma = get_gate_vma(mm);
-	*vma_count = mm->map_count + (gate_vma ? 1 : 0);
+	cprm->vma_count = mm->map_count + (gate_vma ? 1 : 0);
 
-	*vma_meta = kvmalloc_array(*vma_count, sizeof(**vma_meta), GFP_KERNEL);
-	if (!*vma_meta) {
+	cprm->vma_meta = kvmalloc_array(cprm->vma_count, sizeof(*cprm->vma_meta), GFP_KERNEL);
+	if (!cprm->vma_meta) {
 		mmap_write_unlock(mm);
-		return -ENOMEM;
+		return false;
 	}
 
 	for (i = 0, vma = first_vma(current, gate_vma); vma != NULL;
 			vma = next_vma(vma, gate_vma), i++) {
-		struct core_vma_metadata *m = (*vma_meta) + i;
+		struct core_vma_metadata *m = cprm->vma_meta + i;
 
 		m->start = vma->vm_start;
 		m->end = vma->vm_end;
 		m->flags = vma->vm_flags;
 		m->dump_size = vma_dump_size(vma, cprm->mm_flags);
 
-		vma_data_size += m->dump_size;
+		cprm->vma_data_size += m->dump_size;
 	}
 
 	mmap_write_unlock(mm);
 
-	if (WARN_ON(i != *vma_count)) {
-		kvfree(*vma_meta);
-		return -EFAULT;
+	if (WARN_ON(i != cprm->vma_count)) {
+		kvfree(cprm->vma_meta);
+		return false;
 	}
 
-	*vma_data_size_ptr = vma_data_size;
-	return 0;
+	return true;
 }
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 2ee1460a1d66..7d05370e555e 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -23,6 +23,9 @@ struct coredump_params {
 	loff_t written;
 	loff_t pos;
 	loff_t to_skip;
+	int vma_count;
+	size_t vma_data_size;
+	struct core_vma_metadata *vma_meta;
 };
 
 /*
@@ -35,9 +38,6 @@ extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
 extern int dump_align(struct coredump_params *cprm, int align);
 int dump_user_range(struct coredump_params *cprm, unsigned long start,
 		    unsigned long len);
-int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
-		      struct core_vma_metadata **vma_meta,
-		      size_t *vma_data_size_ptr);
 extern void do_coredump(const kernel_siginfo_t *siginfo);
 #else
 static inline void do_coredump(const kernel_siginfo_t *siginfo) {}
-- 
2.29.2

