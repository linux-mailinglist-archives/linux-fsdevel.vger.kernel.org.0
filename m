Return-Path: <linux-fsdevel+bounces-49211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B89EAB94CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 05:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29397A04416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF3214A60;
	Fri, 16 May 2025 03:30:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44A282EE;
	Fri, 16 May 2025 03:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747366239; cv=none; b=Iug4tZzVjssrM0Gk3PtxcLh7RE2TboEpH9jyxDuDvs3qFNqNPSspY3wd+P80S8k68wj4syDyI42ZdOJxSwmKaOPaOOFN4i0AtTufMEo/Gzq4x50yO/Ot3cHdAKd/Aew7+GHf4cMUroRLSAfWGP1O94pOskrtzXdM6iKlswIdNWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747366239; c=relaxed/simple;
	bh=kj3vdow+mdOm5xpvaRyV/+K4yhb8mkFxYSd4rw6WDXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQFToFeKskhBzUnkWjH4jkOCyS+EbVftxmDC/fFsquWU2JpzswIGqxUHz3+JprvXIaVunqZ4Ob4wxpdddjKfjbYMBKsGxhNfitNZ/evN403fhOTnaz1v/q+5NBy9CFgUxqE6+hZoO6u4emNPDZGG/0YCdWz2B6Bv3Psvq9gMgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZzCJp5rHHzYQtsr;
	Fri, 16 May 2025 11:30:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 14F591A01A0;
	Fri, 16 May 2025 11:30:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHq19YsSZoQlwyMg--.53744S4;
	Fri, 16 May 2025 11:30:33 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yangerkun@huawei.com,
	wozizhi@huaweicloud.com
Subject: [PATCH] fs: Rename the parameter of mnt_get_write_access()
Date: Fri, 16 May 2025 11:21:47 +0800
Message-Id: <20250516032147.3350598-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHq19YsSZoQlwyMg--.53744S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4DGFy3Zr1UKFW7uryUJrb_yoW8ZF17pF
	yfKFyDGr4IyF12gr1DAa9xJayrG348CFW7t34fWw43ZFyDZr1aga40gr1jqr18Zr92vry8
	ur4kA34fXry7t37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

Rename the parameter in mnt_get_write_access() from "m" to "mnt" for
consistency between declaration and implementation.

Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 fs/namespace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1b466c54a357..b1b679433ab3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -483,7 +483,7 @@ static int mnt_is_readonly(struct vfsmount *mnt)
  */
 /**
  * mnt_get_write_access - get write access to a mount without freeze protection
- * @m: the mount on which to take a write
+ * @mnt: the mount on which to take a write
  *
  * This tells the low-level filesystem that a write is about to be performed to
  * it, and makes sure that writes are allowed (mnt it read-write) before
@@ -491,13 +491,13 @@ static int mnt_is_readonly(struct vfsmount *mnt)
  * frozen. When the write operation is finished, mnt_put_write_access() must be
  * called. This is effectively a refcount.
  */
-int mnt_get_write_access(struct vfsmount *m)
+int mnt_get_write_access(struct vfsmount *mnt)
 {
-	struct mount *mnt = real_mount(m);
+	struct mount *m = real_mount(mnt);
 	int ret = 0;
 
 	preempt_disable();
-	mnt_inc_writers(mnt);
+	mnt_inc_writers(m);
 	/*
 	 * The store to mnt_inc_writers must be visible before we pass
 	 * MNT_WRITE_HOLD loop below, so that the slowpath can see our
@@ -505,7 +505,7 @@ int mnt_get_write_access(struct vfsmount *m)
 	 */
 	smp_mb();
 	might_lock(&mount_lock.lock);
-	while (READ_ONCE(mnt->mnt.mnt_flags) & MNT_WRITE_HOLD) {
+	while (READ_ONCE(m->mnt.mnt_flags) & MNT_WRITE_HOLD) {
 		if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			cpu_relax();
 		} else {
@@ -530,8 +530,8 @@ int mnt_get_write_access(struct vfsmount *m)
 	 * read-only.
 	 */
 	smp_rmb();
-	if (mnt_is_readonly(m)) {
-		mnt_dec_writers(mnt);
+	if (mnt_is_readonly(mnt)) {
+		mnt_dec_writers(m);
 		ret = -EROFS;
 	}
 	preempt_enable();
-- 
2.39.2


