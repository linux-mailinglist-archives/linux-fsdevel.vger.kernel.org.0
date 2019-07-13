Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33EE581BD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfHENFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 09:05:30 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:29895 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfHENF3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:05:29 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190805130527epoutp0152d6572f8ad785a33ac372852ec081be~4CJnDugTR1533215332epoutp019
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2019 13:05:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190805130527epoutp0152d6572f8ad785a33ac372852ec081be~4CJnDugTR1533215332epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1565010327;
        bh=FP8ux3OTkd8fvlaQBEXL6CEm156hOz8+Jh5icRMsf2w=;
        h=From:To:Subject:Date:References:From;
        b=Y2CBe7wx7zFATsaDqua9S3ytj3SsP/DTKMdF6XrpY8R369Ygc3mlfgBXhr0Uyp61I
         3b0brzSLX/M6fDIScU8cwz8q7uGfS9/zUXSziqAT1KSOj2AwyceEFwGF4cQ6/W+G/Q
         qf3kfpOKepke2rNIJVntlUWv0QZAIDambNqPvyUc=
Received: from epsnrtp5.localdomain (unknown [182.195.42.166]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190805130526epcas1p13714bd330f18070470fd72da935125e3~4CJmfFlAc0752407524epcas1p1v;
        Mon,  5 Aug 2019 13:05:26 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.165]) by
        epsnrtp5.localdomain (Postfix) with ESMTP id 462J0P2j3GzMqYkc; Mon,  5 Aug
        2019 13:05:25 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.35.04075.599284D5; Mon,  5 Aug 2019 22:05:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190805130524epcas1p27a4845fccaf66da2eb0b391bfe4da75f~4CJk_2iBo2928429284epcas1p2p;
        Mon,  5 Aug 2019 13:05:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190805130524epsmtrp191fef8ddceb5d0a126efa4e56f69aa57~4CJk_KbVS1992919929epsmtrp1N;
        Mon,  5 Aug 2019 13:05:24 +0000 (GMT)
X-AuditID: b6c32a36-b49ff70000000feb-d5-5d482995ff7c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.F5.03706.499284D5; Mon,  5 Aug 2019 22:05:24 +0900 (KST)
Received: from localhost.localdomain (unknown [10.88.100.192]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190805130524epsmtip1bad200ba0aa478eb9d18115bdd9e2181~4CJkz3cfV2632326323epsmtip1y;
        Mon,  5 Aug 2019 13:05:24 +0000 (GMT)
From:   Jungseung Lee <js07.lee@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list),
        js07.lee@gmail.com, js07.lee@samsung.com
Subject: [PATCH] fs/binfmt_elf.c: remove unnecessary white space.
Date:   Sun, 14 Jul 2019 08:53:44 +0900
Message-Id: <20190713235344.24683-1-js07.lee@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7bCmvu5UTY9Yg5ftghZz1q9hs/g75x2T
        xaObv1kt9uw9yWJxedccNovzf4+zOrB57Jx1l93jxIzfLB59W1YxenzeJOex6clbpgDWqByb
        jNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKALlBTKEnNK
        gUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhgYFesWJucWleel6yfm5VoYGBkamQJUJORl3
        jixgKXitXfGo/z5LA+N5pS5GTg4JAROJC2+XMYHYQgI7GCW23xbrYuQCsj8xSuxb1cIM4Xxj
        lHizbQsjTMfrAx+hEnsZJRreT2SEcD4zSvz+8YANpIpNQEvixu9NrCAJEYFGJonvm7aCLREW
        cJTY9nYpC4jNIqAqseveITCbV8BS4t31N1Ar5CVWbzgAtkJC4COrxP6d75kgEi4S71p3skLY
        whKvjm9hh7ClJF72t0HZxRI7V05kh2huYZR4tHwJVMJY4t3btUBTOTiYBTQl1u/ShwgrSuz8
        PRdsMbMAn8S7rz2sICUSArwSHW1CECVKEm8etLBA2BISFx73Qp3gIXF10iJmSODFSrxqfMA4
        gVFmFsKCBYyMqxjFUguKc9NTiw0LjJCjZhMjOC1pme1gXHTO5xCjAAejEg+vgqx7rBBrYllx
        Ze4hRgkOZiUR3kJmoBBvSmJlVWpRfnxRaU5q8SFGU2DoTWSWEk3OB6bMvJJ4Q1MjY2NjCxMz
        czNTYyVx3oU/LGKFBNITS1KzU1MLUotg+pg4OKUaGDmjGuYV7nStObD87kKHm2u1ih03v3lm
        7it1+qSb+n1esdrX8R/u1zmvtNhf9c1IqeLqSaaA6C+imknbWW5tiC6btZU5f+ZKtaSEez2b
        hbOm7TpYfPf7JifHNTfavKZfWx178/KjnL1pdZdd31yP1jpbc4Jx8Zodh9zubdfznRqs+WHN
        nVlCT4qVWIozEg21mIuKEwFDNReFYQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSnO4UTY9Yg3MftC3mrF/DZvF3zjsm
        i0c3f7Na7Nl7ksXi8q45bBbn/x5ndWDz2DnrLrvHiRm/WTz6tqxi9Pi8Sc5j05O3TAGsUVw2
        Kak5mWWpRfp2CVwZd44sYCl4rV3xqP8+SwPjeaUuRk4OCQETidcHPjJ3MXJxCAnsZpSY+ecI
        M0RCQuLRzi8sXYwcQLawxOHDxRA1Hxklfv05xAJSwyagJXHj9yZWkISIQCuTRPPmo0wgCWEB
        R4ltb5eCFbEIqErsugfRwCtgKfHu+htGiAXyEqs3HGCewMi9gJFhFaNkakFxbnpusWGBYV5q
        uV5xYm5xaV66XnJ+7iZGcJBoae5gvLwk/hCjAAejEg/vCSn3WCHWxLLiytxDjBIczEoivIXM
        QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8T/OORQoJpCeWpGanphakFsFkmTg4pRoYZ3Ev13Lb
        2fFhqnac23K2LQbrfims+Wy7cZrCo5jvdgcE/2r4pza6s7C3l8ScymePfveU8R/LqcInv3Yt
        P7zZ7H+GKLevZKP4wWPzBSaxM3WuV9pz7bxf+EvPadnXvWJMri9qYtyuJ3b7m790cb5s37Jv
        poW2ykr/lSTKtBJ37Nqoa/acP7NZiaU4I9FQi7moOBEAtHRDiQ4CAAA=
X-CMS-MailID: 20190805130524epcas1p27a4845fccaf66da2eb0b391bfe4da75f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190805130524epcas1p27a4845fccaf66da2eb0b391bfe4da75f
References: <CGME20190805130524epcas1p27a4845fccaf66da2eb0b391bfe4da75f@epcas1p2.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 - spaces before tabs,
 - spaces at the end of lines,
 - multiple blank lines,
 - redundant blank lines,
 fix it.

Signed-off-by: Jungseung Lee <js07.lee@samsung.com>
---
 fs/binfmt_elf.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index cec3b4146440..5ba1944e3ce1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -235,7 +235,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	} while (0)
 
 #ifdef ARCH_DLINFO
-	/* 
+	/*
 	 * ARCH_DLINFO must come first so PPC can do its special alignment of
 	 * AUXV.
 	 * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT() in
@@ -294,7 +294,6 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	sp = (elf_addr_t __user *)bprm->p;
 #endif
 
-
 	/*
 	 * Grow the stack manually; some architectures have a limit on how
 	 * far ahead a user-space access may be in order to grow the stack.
@@ -344,7 +343,6 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 }
 
 #ifndef elf_map
-
 static unsigned long elf_map(struct file *filep, unsigned long addr,
 		const struct elf_phdr *eppnt, int prot, int type,
 		unsigned long total_size)
@@ -383,7 +381,6 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 
 	return(map_addr);
 }
-
 #endif /* !elf_map */
 
 static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
@@ -456,7 +453,6 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 }
 
 #ifndef CONFIG_ARCH_BINFMT_ELF_STATE
-
 /**
  * struct arch_elf_state - arch-specific ELF loading state
  *
@@ -522,7 +518,6 @@ static inline int arch_check_elf(struct elfhdr *ehdr, bool has_interp,
 	/* Dummy implementation, always proceed */
 	return 0;
 }
-
 #endif /* !CONFIG_ARCH_BINFMT_ELF_STATE */
 
 static inline int make_prot(u32 p_flags)
@@ -542,7 +537,6 @@ static inline int make_prot(u32 p_flags)
    so we keep this separate.  Technically the library read function
    is only provided so that we can read a.out libraries that have
    an ELF header */
-
 static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 		struct file *interpreter, unsigned long *interp_map_addr,
 		unsigned long no_base, struct elf_phdr *interp_elf_phdata)
@@ -669,7 +663,6 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
  * These are the functions used to load ELF style executables and shared
  * libraries.  There is no binary dependent code anywhere else.
  */
-
 static int load_elf_binary(struct linux_binprm *bprm)
 {
 	struct file *interpreter = NULL; /* to shut gcc up */
@@ -697,7 +690,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		retval = -ENOMEM;
 		goto out_ret;
 	}
-	
+
 	/* Get the exec-header */
 	loc->elf_ex = *((struct elfhdr *)bprm->buf);
 
@@ -866,7 +859,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 				 executable_stack);
 	if (retval < 0)
 		goto out_free_dentry;
-	
+
 	elf_bss = 0;
 	elf_brk = 0;
 
@@ -888,7 +881,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 
 		if (unlikely (elf_brk > elf_bss)) {
 			unsigned long nbyte;
-	            
+
 			/* There was a PT_LOAD segment with p_memsz > p_filesz
 			   before this one. Map anonymous pages, if needed,
 			   and clear the area.  */
@@ -1462,7 +1455,7 @@ static void fill_elf_note_phdr(struct elf_phdr *phdr, int sz, loff_t offset)
 	phdr->p_align = 0;
 }
 
-static void fill_note(struct memelfnote *note, const char *name, int type, 
+static void fill_note(struct memelfnote *note, const char *name, int type,
 		unsigned int sz, void *data)
 {
 	note->name = name;
@@ -1514,7 +1507,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 {
 	const struct cred *cred;
 	unsigned int i, len;
-	
+
 	/* first copy the parameters from user space */
 	memset(psinfo, 0, sizeof(struct elf_prpsinfo));
 
@@ -1548,7 +1541,7 @@ static int fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
 	SET_GID(psinfo->pr_gid, from_kgid_munged(cred->user_ns, cred->gid));
 	rcu_read_unlock();
 	strncpy(psinfo->pr_fname, p->comm, sizeof(psinfo->pr_fname));
-	
+
 	return 0;
 }
 
@@ -1945,8 +1938,8 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 	t->num_notes = 0;
 
 	fill_prstatus(&t->prstatus, p, signr);
-	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);	
-	
+	elf_core_copy_task_regs(p, &t->prstatus.pr_reg);
+
 	fill_note(&t->notes[0], "CORE", NT_PRSTATUS, sizeof(t->prstatus),
 		  &(t->prstatus));
 	t->num_notes++;
@@ -1967,7 +1960,7 @@ static int elf_dump_thread_status(long signr, struct elf_thread_status *t)
 		t->num_notes++;
 		sz += notesize(&t->notes[2]);
 	}
-#endif	
+#endif
 	return sz;
 }
 
@@ -2205,7 +2198,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 
 	/*
 	 * We no longer stop all VM operations.
-	 * 
+	 *
 	 * This is because those proceses that could possibly change map_count
 	 * or the mmap / vma pages are now blocked in do_exit on current
 	 * finishing this core dump.
@@ -2214,7 +2207,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 	 * the map_count or the pages allocated. So no possibility of crashing
 	 * exists while dumping the mm->vm_next areas to the core file.
 	 */
-  
+
 	/* alloc memory for large data structures: too large to be on stack */
 	elf = kmalloc(sizeof(*elf), GFP_KERNEL);
 	if (!elf)
-- 
2.17.1

