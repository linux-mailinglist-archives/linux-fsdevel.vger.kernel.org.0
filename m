Return-Path: <linux-fsdevel+bounces-72811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D54BD03F22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D9734756B0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E5835CBB4;
	Thu,  8 Jan 2026 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="S2xWMhad"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DE3C1FDF
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767865287; cv=none; b=Kg03ptVFYw8O/XQhdOzuaO5HsOjDh5k8LVKirwNjSYofKZVgGEms7io7OgY9Igzi3R2LVt2x7krf6YzOl8+DcFqCbvhYftc33ueUiM7pBjJUlr6TiInsrP9x2FVjYbe8IJ0E99Yy9j4aTa6wgSVi819hFWpb0fy65ghE1V/vIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767865287; c=relaxed/simple;
	bh=z8uuooh91RjFWtNJ78SLIUD278PPcKo7E5fB24ortS0=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GLjAe6X5Jfx+a+dyGA9thH7zIedPHwt5F/EYSqv5/qkWLqTsfMSiM8I9f2IBslozUzy3YP6gvZ7vtKi2otjepk8ufUOBLFcSChX2Svy1bsWooTEby+huJ1eXNFGnnl9MPkUs0U7ltESWWH0iz3SweFL/oQL3Yuz4gltvJ7tCGs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=S2xWMhad; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1767865264; bh=kr+PGLZ1A3LBDxvkvV8WMVHWLNR4gVDepQz4ot11vNM=;
	h=From:To:Cc:Subject:Date;
	b=S2xWMhadO8dWEhHIyjrgRIk8SaNQlIIwIVd7UeDkqDsFX0bFRoNahKu+/h09BrkX1
	 QJAbw6BOf7tqBvqCU3FUUc0vYB5j3p6EDY+YwdwvRYmqBVpjF7rHXz4ZbhizjkMAWW
	 DT+hqlID2K5kY/u89DWm7B44aZiESShwBdDS/1QA=
Received: from OptiPlex-9020.. ([58.32.209.43])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id A4286EB3; Thu, 08 Jan 2026 17:41:02 +0800
X-QQ-mid: xmsmtpt1767865262t25jbo5av
Message-ID: <tencent_E7EF2CBD4DBC5CC047C3EB74D3C52A55C905@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlDz5j7ZqL7yqk7qk8LsguH5PVOFjWhyXvMP0xIKbQJHkQfuFBcq
	 /7jEamKkIKabmgwC6Hj+KwIx3baxybecDeWCChs5vd4YuKvW9sC0fiUdLuCgAyVaUQdVfka6WobG
	 ZdzmxSEW8dDPYmqvFwGcle6p4z2BESzp+svwbiebfpzztUZOA5DMc14as19JGQJvHsGWQo9TAqwy
	 wDlVpgEsIxvBXksOGYesiKiQ/dx1OlbftHSuUbuOTCgfLNchAUi4NbtjxhCtbbWJuxTdgahjyuB6
	 nAjyr0YM8mazUGIlUtUKzVmzA59Pj+9Q5eGmXz3U6okDqzJLkjTNZscRnD3ACUJ/co5TdhtHweHD
	 oPqzxfKUlTzCh0ViQVlsBowT3iA+Cl0i+YLwIqj4O4isTh64wSLa6Yk9Oj03R1Rm0MrjVstjkUhn
	 JlTrKOKkXbjrWa0lwg+z9RVEjm745d75Yio6prR2gfSyv2oWm3TftSfPDCJdknM4HdK/PvUOdl5n
	 /R6sbxucFS3YT2glF0+IAkdGGerhwC5w6M/s0mMEwrLZLtTstMDWJRwJxnsOpWRZgu49hRSa25/K
	 dYXRm8LLn5IofNuAOZs5Q2LtMS9PTNsZzeej5HhEsAuqMSYrCivD34wjLleGW1At4Q3vlXCNv0zD
	 m0BbiUHcYOI7LdTvXCH8bHPdt0mCT8t9sf1fxBZu/gPZckIqj7Ygq4omqakIPWRFgoGuYD3MF9ej
	 UO9QQCUYTqcIwCbLfLaAP01mqe8uY349MzkmJQKtT32M2KvF80SKZEGQOMZtF1aatdnYENhSU5d1
	 1NJPPC0XblykS7mYMbs1m3dRsqGdKL4duuqZoy1jsWZG0qwL7g4HI7jNcG3cUvG/Lw9MQSeUjxyZ
	 lxgnLelB59lWGMdwIVz3COxYrpEi0Tth8xB26+2uiF69TXPqinJFL4wtpgvNLFrGpj2oZ6kNsK7b
	 1WF7YQ1Yb/066+cZpew0iXCJR0C/aZWQjunUIakJoobtOmwT5BS1EdebPJol4DgQ1+YSVPcUqPk0
	 DG+6IXCZ4UPsW5e0dH/7ivWRD0S3I=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: yuling-dong@qq.com
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	Yuling Dong <yuling-dong@qq.com>
Subject: [PATCH v1] exfat: reduce unnecessary writes during mmap write
Date: Thu,  8 Jan 2026 17:38:57 +0800
X-OQ-MSGID: <20260108093857.462560-2-yuling-dong@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuling Dong <yuling-dong@qq.com>

During mmap write, exfat_page_mkwrite() currently extends
valid_size to the end of the VMA range. For a large mapping,
this can push valid_size far beyond the page that actually
triggered the fault, resulting in unnecessary writes.

valid_size only needs to extend to the start of the page
being written, because when the page is written, valid_size
will be extended to the end of the page.

Signed-off-by: Yuling Dong <yuling-dong@qq.com>
---
 fs/exfat/file.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 536c8078f0c1..83f9bebb49f3 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -707,21 +707,17 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
 {
 	int err;
-	struct vm_area_struct *vma = vmf->vma;
-	struct file *file = vma->vm_file;
-	struct inode *inode = file_inode(file);
+	struct inode *inode = file_inode(vmf->vma->vm_file);
 	struct exfat_inode_info *ei = EXFAT_I(inode);
-	loff_t start, end;
+	loff_t new_valid_size;
 
 	if (!inode_trylock(inode))
 		return VM_FAULT_RETRY;
 
-	start = ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	end = min_t(loff_t, i_size_read(inode),
-			start + vma->vm_end - vma->vm_start);
+	new_valid_size = (loff_t)vmf->pgoff << PAGE_SHIFT;
 
-	if (ei->valid_size < end) {
-		err = exfat_extend_valid_size(inode, end);
+	if (ei->valid_size < new_valid_size) {
+		err = exfat_extend_valid_size(inode, new_valid_size);
 		if (err < 0) {
 			inode_unlock(inode);
 			return vmf_fs_error(err);
-- 
2.43.0


