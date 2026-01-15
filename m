Return-Path: <linux-fsdevel+bounces-73876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC63D22695
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 06:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF09C302F2DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 05:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC622D77E5;
	Thu, 15 Jan 2026 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zlNCuf/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71D242D62
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 05:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768453628; cv=none; b=Y4DV/EcoigujiihJTJX34KklkgoLUq4cdnVeSPz5QNQhkw+ZJVv4m9jMw0zMBmfXl80cHpvMgcyymyqtkTdwk1aPLYoqrGo3tkW/+0g5CqkSvOWonicW+ZidLdg9gNUWaBcwAGJ9AjfyedV7XYTJFz1dPn42ojLdR030VshVdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768453628; c=relaxed/simple;
	bh=IlzYl0QKTdQQHUq1YEpSgF8RFFBHiv/8iDhnyDKl/9M=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=JmeuKjwn3hahZuDoCJTlZW64axm5C2sxYC/Z/hlUbJXic+2xYArT3oZamyrbsVtvlsJCCQmXlefgjjgWtW8+q+QduN1jibAa6eIynq01FWVZ+jn4JhX7xdY/ib2Rb8lwRBHc+SdxqBqBvK9xVY6fgFsDNPx0ZVJxtZJUMzbu6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zlNCuf/U; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1768453620; bh=aOTA/+iIS/z7AqRpnPbpw0UTpz/CQLNQeYGk3U02NMg=;
	h=From:To:Cc:Subject:Date;
	b=zlNCuf/U8mXihiXjEQ9z9rijnlXZ/jNZek1riYoilG+aTU2cxPmdrueTLUoG1/2nj
	 Y4jnMm7W8prz4ROKJRB54K0RHk7XbmDj5wvow0JPEh+a7Kc2kG9OwOSphtvvjv3LB/
	 tiAoBCQUvsSbfli2OM+N1TOfVAd9ztCZu+Rnr1d0=
Received: from OptiPlex-9020.. ([58.32.209.43])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 1BB2B40F; Thu, 15 Jan 2026 13:06:59 +0800
X-QQ-mid: xmsmtpt1768453619tr7cnuu43
Message-ID: <tencent_193FC4B3056834124EE55CC25255FCE4D309@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQl/cjU590m9iRxak44sfYGQhcSRk7HHjcNKHLiu56lR+P5SaoUPF
	 Ck58VfY9uioJW7LPAorzyW9U7z98xDmh03X4+v1QXoQ81AEgVRTdBpTinOxaAvKfP/N4Wg6C4Zre
	 CKZCmbVcUKxlHpmPrEyxUYGR3sezX5aTZjHMP/bccVEEiU/8Xi89VoMvmYM2cXZ7KekXnE2PjSyr
	 GOJfZ40Ozyiqe6yuw7qWZQjpSy92pXoBI2nQEIGiM3bdX9jZZIh4pCyJ8061dPwjuVVTWHYy/ZbR
	 KpeGdIPrlkNhZJsLle8SRHJsMIg/bWchMtyAvXF4BpWTnEqR+nVOi8Hq2ai2RtgiMmKoiP7oTwVr
	 KUBUMx0yuBVWAG/C+ysY7J5PIvCWnpuxuENznl8JAG8q8cnEfiOWJS7RuWs8Bc9SGiv4N5nvCR2c
	 jmJRU+s60xu/8+8NIEhGmoGKGfLAurZz/mGHqQxC6zb2r3JqypEu/TdNnx1ZlfN51ZzcSAmmj5N0
	 +YPtyqKvsoig9asyz45udPqbhZqmHC07fuLbXRpHbMCIPOoiJwzwwj1pGqoKtuHIS4ax3pmk/+LF
	 N+C7TDqubwg67IpkALZ1ugG/9Czl8ROzS96Gug/zMJogLTOxdwFpOkIEIdlU8jzuZ0Os8HI7Hb8b
	 7fHWDmUS4O3oBstUOxRKrU5QJkQTpAXTA1ah77vZBMyRGAV4SY/4m0vnAag3h4hrrxO6KwQCMfNg
	 /CGbCqjoGWPJr88wkbX+1Vz/H7rmd4wEpKGbe21Z8pUd/zU8rGHtV438hPoS+zpfuQi3Cz7coiF1
	 UDRbBC2a4KMZjuOZ5qkAi4g7SLIaqkLzdACJPp1pxRodbomjxoIPT2FYtggO8XeEqK5PwpUsT6K9
	 XctcKetZ6egTXExOPjHzIf4zgZtZ6m/5XNo1oXDnrdV1xOMxzcFXDVXd01MsuCjdmGALBtYGMs6T
	 cthEBWtQcbBmmxFIrYNz8Mj3pH9cH3/BIAo0pZsC2w8QBkhWmGsjWeLovNtk+Halaoww3k+Yd+/Y
	 Qv+avgCrBU1eJ7O8TC/C4Kie9o7SM=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: yuling-dong@qq.com
To: linkinjeon@kernel.org,
	Yuezhang.Mo@sony.com,
	sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org,
	willy@infradead.org,
	Yuling Dong <yuling-dong@qq.com>
Subject: [PATCH v2] exfat: reduce unnecessary writes during mmap write
Date: Thu, 15 Jan 2026 13:05:23 +0800
X-OQ-MSGID: <20260115050521.1035059-3-yuling-dong@qq.com>
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

valid_size only needs to extend to the end of the page
being written.

Signed-off-by: Yuling Dong <yuling-dong@qq.com>
---
 fs/exfat/file.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 536c8078f0c1..2977524beaf4 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -707,21 +707,18 @@ static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
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
+	new_valid_size = ((loff_t)vmf->pgoff + 1) << PAGE_SHIFT;
+	new_valid_size = min(new_valid_size, i_size_read(inode));
 
-	if (ei->valid_size < end) {
-		err = exfat_extend_valid_size(inode, end);
+	if (ei->valid_size < new_valid_size) {
+		err = exfat_extend_valid_size(inode, new_valid_size);
 		if (err < 0) {
 			inode_unlock(inode);
 			return vmf_fs_error(err);
-- 
2.43.0


