Return-Path: <linux-fsdevel+bounces-386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5867CA662
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 13:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6761C209DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD33B22F1A;
	Mon, 16 Oct 2023 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A8WyhgO0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5D14283
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 11:14:03 +0000 (UTC)
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94000F5;
	Mon, 16 Oct 2023 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=+lDdM
	FEigMrqHpaFKAPZrvj/+p5FNluVPO9zqeyMo1g=; b=A8WyhgO0E+RtKNNjoLxYd
	q+i+YxS8dD0kJCwuyb53BPcn5a6MsNWdRqr/T98tcGfEen97w6K2+2O9hv1TzUx3
	S4xhIGqDq7thy/SrV5/HyTNNZHMJy5lFaegN+dF2VasRSFAXQEDD3wIFIag3W7h7
	IDJ1zAdehVZvqKsd8EH1bY=
Received: from localhost.localdomain (unknown [106.13.245.201])
	by zwqz-smtp-mta-g1-3 (Coremail) with SMTP id _____wDXz5_lGi1lA1vjAg--.43446S2;
	Mon, 16 Oct 2023 19:13:43 +0800 (CST)
From: gaoyusong <a869920004@163.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gaoyusong <a869920004@163.com>
Subject: [PATCH] fs: Fix typo in access_override_creds()
Date: Mon, 16 Oct 2023 11:13:40 +0000
Message-Id: <20231016111340.785413-1-a869920004@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXz5_lGi1lA1vjAg--.43446S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFy7GFW3Kr43Zr43Zr4kCrg_yoWxCwc_Cw
	4Iyr48Grs8tryIywn8WanYyF1Sg34FyF1rG34xJry3KryfZ3ZxuryDKrn7JrWUWr47K3s8
	Xrn8ZFWDZF4I9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNdb1DUUUUU==
X-Originating-IP: [106.13.245.201]
X-CM-SenderInfo: zdywmmasqqiki6rwjhhfrp/1tbiRQkL6WDu2Q2VAwAAsi
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix typo in access_override_creds(), modify
non-RCY to non-RCU.

Signed-off-by: gaoyusong <a869920004@163.com>
---
 fs/open.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 98f6601fbac6..72eb20a8256a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -442,7 +442,7 @@ static const struct cred *access_override_creds(void)
 	 * 'get_current_cred()' function), that will clear the
 	 * non_rcu field, because now that other user may be
 	 * expecting RCU freeing. But normal thread-synchronous
-	 * cred accesses will keep things non-RCY.
+	 * cred accesses will keep things non-RCU.
 	 */
 	override_cred->non_rcu = 1;
 
-- 
2.34.1


