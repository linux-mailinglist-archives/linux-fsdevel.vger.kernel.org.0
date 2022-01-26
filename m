Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6148649CFA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 17:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiAZQ03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 11:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243113AbiAZQ02 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 11:26:28 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jan 2022 08:26:27 PST
Received: from mail-out-2.itc.rwth-aachen.de (mail-out-2.itc.rwth-aachen.de [IPv6:2a00:8a60:1:e501::5:47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1B5C06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 08:26:27 -0800 (PST)
X-IPAS-Result: =?us-ascii?q?A2AgAADjdPFh/6QagoZaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBSAQBAQELAYFRKIIEaoRJjm6CB4l8knWBfAsBAQEBAQEBAQEIAT8CB?=
 =?us-ascii?q?AEBhQWDYAIlNgcOAQIEAQEBAQMCAwEBAQEBAQMBAQYBAQEBAQEFBIEchS9Gh?=
 =?us-ascii?q?kIBKQ8BRiwDAQIDAiYCEgQzCA4KBAWGGwGtd3qBMYEBiFaBJwkBgQYqAYcrh?=
 =?us-ascii?q?y6CKYEVg2iHXYJlBJFrBgGBDkyYJqd1gigHghBUZKALliYCkVEBlkimOwIEA?=
 =?us-ascii?q?gQFAhaBZwGCDjM+gzhRFwIPjiwWji5BMjgCBgEKAQEDCYI6gwomE4ouAQE?=
IronPort-Data: A9a23:kwIvzaDCoMuEnRVW/0fiw5YqxClBgxIJ4kV8jS/XYbTApD4i0zQOm
 GMdXzyBb/uPN2rxKtt+OYrg/UgCsJCGztY2OVdlrnsFo1CmCCbmLYnDch2gb3v6wunrFh8PA
 xA2M4GYRCwMZiaA4E/ra9ANlFEkvU2ybuOU5NXsZ2YhFWeIdA970Ug5w7dj3NYy6TSEK1rlV
 e3a8pW31GCNhmYc3lI8s8pvfzs24ZweEBtB1rAPTagjUG32zhH5P7pDTU2FFEYUd6EPdgKMb
 7uZkOvprjuxEyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhw+5Vy
 t9w8reJSA4qOYGWneJMDwEDKnQrVUFG0OevzXmXq9OPz0DWNmCwhvwoFl4qPcgR9qB7DAmi9
 9RBc2xLN0vbwbjohuvlFoGAhex6RCXvFIYWtXd91nfWF/E9WrjZXLnKoNZR1zc9gIZCEJ4yY
 uJANmM1N06dOkEn1lE/Cr4g38nrjXLGSDBDlnCLga8w/nnMw1kkuFTqGJ+PEjCQfu1Ln1yfj
 nDL+WXnRBUbMsGPjz2f/TSxhYfnkCn6VY4fDriQ5vtrm0aSwWpVAxoTPXO4rPSigUm5WPpUK
 1YT/yszqO417kPDZt38WQCo5XCfshMCVt54DeI38keOx7DS7gLfAXILJgOtc/Q8q9M2SCxvz
 QPMlpXzGiBv9bSZD36QnluJkQ6P1eEuBTdqTUc5ocEtubEPfKlbYsrzc+te
IronPort-HdrOrdr: A9a23:oby10KCVY8wInYjlHemX55DYdb4zR+YMi2TC1yhKJiC9Vvbo9f
 xG+85rsCMc6QxhO03I9urrBEDtex7hHP1OgbX5X43CYOCOggLBR72KhbGSpAEIcBeRygcy78
 tdmuRFebnN5Q8Qt7eC3ODuKadH/OW6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,318,1635199200"; 
   d="scan'208,223";a="171232514"
Received: from rwthex-s4-a.rwth-ad.de ([134.130.26.164])
  by mail-in-2.itc.rwth-aachen.de with ESMTP; 26 Jan 2022 17:25:21 +0100
Received: from localhost (2a02:908:1066:22e0:95a5:b322:26dd:ff8d) by
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 26 Jan 2022 17:25:20 +0100
Date:   Wed, 26 Jan 2022 17:25:20 +0100
From:   Magnus =?utf-8?B?R3Jvw58=?= <magnus.gross@rwth-aachen.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
CC:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <YfF18Dy85mCntXrx@fractal.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/2.1.5 (31b18ae9) (2021-12-30)
X-Originating-IP: [2a02:908:1066:22e0:95a5:b322:26dd:ff8d]
X-ClientProxiedBy: rwthex-s1-b.rwth-ad.de (2a00:8a60:1:e500::26:153) To
 rwthex-s4-a.rwth-ad.de (2a00:8a60:1:e500::26:164)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
Date: Wed, 26 Jan 2022 16:35:07 +0100
Subject: [PATCH] elf: Relax assumptions about vaddr ordering
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 5f501d555653 ("binfmt_elf: reintroduce using
MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().

Specifically consider an ELF binary with the following PT_LOAD segments:

Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000

Note how the last segment is actually the first segment and vice versa.

Since total_mapping_size() only computes the difference between the
first and the last segment in the order that they appear, it will return
a size of 0 in this case, thus causing load_elf_binary() to fail, which
did not happen before that change.

Strictly speaking total_mapping_size() made that assumption already
before that patch, but the issue did not appear because the old
load_addr_set guards never allowed this call to total_mapping_size().

Instead of fixing this by reverting to the old load_addr_set logic, we
fix this by comparing the correct first and last segments in
total_mapping_size().

Signed-off-by: Magnus Groß <magnus.gross@rwth-aachen.de>
---
 fs/binfmt_elf.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f8c7f26f1fbb..0caaad9eddd1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -402,19 +402,29 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 static unsigned long total_mapping_size(const struct elf_phdr *cmds, int nr)
 {
 	int i, first_idx = -1, last_idx = -1;
+	unsigned long min_vaddr = ULONG_MAX, max_vaddr = 0;
 
 	for (i = 0; i < nr; i++) {
 		if (cmds[i].p_type == PT_LOAD) {
-			last_idx = i;
-			if (first_idx == -1)
+			/*
+			 * The PT_LOAD segments are not necessarily ordered
+			 * by vaddr. Make sure that we get the segment with
+			 * minimum vaddr (maximum vaddr respectively)
+			 */
+			if (cmds[i].p_vaddr <= min_vaddr) {
 				first_idx = i;
+				min_vaddr = cmds[i].p_vaddr;
+			}
+			if (cmds[i].p_vaddr >= max_vaddr) {
+				last_idx = i;
+				max_vaddr = cmds[i].p_vaddr;
+			}
 		}
 	}
 	if (first_idx == -1)
 		return 0;
 
-	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
-				ELF_PAGESTART(cmds[first_idx].p_vaddr);
+	return max_vaddr + cmds[last_idx].p_memsz - ELF_PAGESTART(min_vaddr);
 }
 
 static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
-- 
2.34.1
