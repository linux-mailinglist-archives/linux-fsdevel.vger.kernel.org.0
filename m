Return-Path: <linux-fsdevel+bounces-78428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGkEIDimn2mHdAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:47:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39A19FECD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F33D23012E93
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 01:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6DF34E770;
	Thu, 26 Feb 2026 01:47:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3262E5D17;
	Thu, 26 Feb 2026 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070442; cv=none; b=MhoHW5JUFEKhpevNsI9oCL5yn7izmpG2wqjcr4t1ttAx0oFIdaP0300KFTq9+O8jGsG2oKbbXRMnXUBuqn+3zCBohmy3yyRlnWcZQVze7/h0w12sR4WU8S0z/H8oLukpPf2j5tqyIFxqOeQ4Udnqui14RLVu0HIVqznlSlqRQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070442; c=relaxed/simple;
	bh=v5zZml0769cjL+M1SDd9qXppeDXg/NUxM5UX8jRJPiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VyX8F+257Ck12P7IYjWyKSeroU7Pk4sRLdj3L/V2PPJjpIBga1XtUguOFCE0a0O0dzxuk4nMefZsZEtK43BD0ysdY+I/qjfg+eg486pKxgMGdRPY/WqW5J2Fuhi9JmwBDh5Dcq3I5QiMHutUcfU3uHf/RNhhoff1NSE4IedcJZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADH5t0ipp9pKCNWCQ--.47726S2;
	Thu, 26 Feb 2026 09:47:14 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: linkinjeon@kernel.org
Cc: hyc.lee@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ntfs: Remove unneeded semicolon
Date: Thu, 26 Feb 2026 09:45:28 +0800
Message-Id: <20260226014528.3499348-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADH5t0ipp9pKCNWCQ--.47726S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWr1ktw4xGr1rWF48CFyfWFg_yoWxXrg_Aa
	1xKayxZrWDArn8K3Z8GFZYqFsIqw40yr1UuryxtFs8Jayjyw45JryvqFWrZ3y5ury5ZrZ8
	Gw1UKrW5ur13WjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JU9L05UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-78428-lists,linux-fsdevel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nichen@iscas.ac.cn,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,iscas.ac.cn];
	NEURAL_HAM(-0.00)[-0.856];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B39A19FECD
X-Rspamd-Action: no action

Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
semantic patch at scripts/coccinelle/misc/semicolon.cocci.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 fs/ntfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 3f559df4856b..830dfc5aed2d 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1337,7 +1337,7 @@ static bool load_and_init_upcase(struct ntfs_volume *vol)
 				addr, size);
 		kunmap_local(addr);
 		folio_put(folio);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
-- 
2.25.1


