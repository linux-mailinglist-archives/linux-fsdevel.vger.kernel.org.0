Return-Path: <linux-fsdevel+bounces-13031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B321586A4F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41941C22DA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 01:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6041DDF1;
	Wed, 28 Feb 2024 01:23:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DFFBEA;
	Wed, 28 Feb 2024 01:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083395; cv=none; b=YFfTV2aGjVda5esK1rfU+5FzsTVj0zTV+9jAxhIBCpuOhonJ1DAUDG2rkiGjVPU6TZJ0Ldi/jAMnTfX7It/7w9DOTDlzs5J9WaeEuSh7kNXMIt1wGuPELbygg+/mRqR5Y70H61e/9myZQLzk4iu1hO3R8OMrxqDWJIkjJ9LBOdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083395; c=relaxed/simple;
	bh=T+yVge9mGzkBG9/MMKYIx3R2pe6wng5e7vxmjci1zjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHQx0WvIj/IcQHGB8KYJCEzf9FsZnyvznc6CKNUj7eCRANggemOSCbj4b3wOLAMV/y9jqsTAspMd2sEr6vRPKAK8EzlFwYt13lbbkb5UW4iFrI2whQxlZ8ClM+wm6XFKuwbSxMPs1UZ4uscoFxQOCsF+309fyNnIXK1rV8+SbEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TkxS94jBdz4f3kFH;
	Wed, 28 Feb 2024 09:23:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id DB3F61A0283;
	Wed, 28 Feb 2024 09:23:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDX8gv7it5lqQx6FQ--.57137S7;
	Wed, 28 Feb 2024 09:23:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tim.c.chen@linux.intel.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] fs/writeback: correct comment of __wakeup_flusher_threads_bdi
Date: Wed, 28 Feb 2024 17:19:57 +0800
Message-Id: <20240228091958.288260-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240228091958.288260-1-shikemeng@huaweicloud.com>
References: <20240228091958.288260-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDX8gv7it5lqQx6FQ--.57137S7
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8Zw4kZr4xXr45ZFykAFb_yoWfZwb_XF
	W8tr4DCrZI9Fn8Ja4xZ3Z3tFyvg3ykCF15uF4fKF98J3WY9rn7Zr4kZFWDGr1j9ayUuFWx
	G3srXr4jyrZI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r126s0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC
	64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM2
	8EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq
	3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jstxDUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Commit e8e8a0c6c9bfc ("writeback: move nr_pages == 0 logic to one
location") removed parameter nr_pages of __wakeup_flusher_threads_bdi
and we try to writeback all dirty pages in __wakeup_flusher_threads_bdi
now. Just correct stale comment.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index c98684e9e6ba..7e344a4e727e 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2332,8 +2332,7 @@ void wb_workfn(struct work_struct *work)
 }
 
 /*
- * Start writeback of `nr_pages' pages on this bdi. If `nr_pages' is zero,
- * write back the whole world.
+ * Start writeback of all dirty pages on this bdi.
  */
 static void __wakeup_flusher_threads_bdi(struct backing_dev_info *bdi,
 					 enum wb_reason reason)
-- 
2.30.0


