Return-Path: <linux-fsdevel+bounces-6914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A014181E59B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 08:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEB51C21D38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8A4C618;
	Tue, 26 Dec 2023 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eT1wPAVg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDCC4C3DD;
	Tue, 26 Dec 2023 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703575342; bh=wDSHVDigzFATqQyESr8XDuZAlMa8xKB4R2CE0qELoo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eT1wPAVgM7R5seU2RlNax8gpAO/H214MJdWDJaSjyxhr6Zi0L7ZSVlqj7zA3YS8XS
	 cnMy82iJFSqMVyji6QtixjgCznzvWImqWES92XPXM5r5KXMqY62K1oAIgu3X8tO4o+
	 zqt5i4dstg3lLW2kTOng+5O8W8NcyagM59mU4z2U=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 40902CF1; Tue, 26 Dec 2023 15:16:09 +0800
X-QQ-mid: xmsmtpt1703574969tmhlgnqaf
Message-ID: <tencent_9EA7E746DE92DBC66049A62EDF6ED64CA706@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnH0jOC261k90JCg//lbwJX/8/EDGnYlBvstu5hGpamjVET6kJWy
	 YW5lVulxZv+VlJDUOaIWt0vtQ0hEigHgtdmkpfQtwYEW1KPWIjI1fMfL/b92ooqSSUFn+lKlq7Pq
	 QZBizuEI7mVZoD9OeIFNGmHy9YBbUGGDtG6Xoyb+QIyUDnI3XoUr5o6nxRi2qeNoD+82nFRwguLZ
	 zX4/XvBOLnBCLMqGYqm1PJw9g+a5DXWdP7M91MlPchL0kQQN1erk3mgtVfVdQVfEymLPZ9AS5Uwc
	 YbZw8WwVNwFz8jWZmGTKDX/19h/YHydNvR+zC2h0TSOA5v9N0RlnBCkvZyMFr/YtLflAqIGVeOkr
	 OFIkJJYnmtFNYTAohCLpanizs5eKxfgAespSyyXnDRuHGG4SlHV7wjNINj68bms+C+H3SFg1gMdb
	 +ufIdQ3M3mTOjF1WNV/eM91Y5FPYv1ux0kYr8WRQQkpYT4QaF8bCbCEeg+olmHxsX38a+bl++jkB
	 SuCTtAYD+FSvXRNxxpewFybcHKqGRKc6+9A5cZbWrFR16GUYj8kwCsMxA03S9JfFlHQZl0EBcRRI
	 S2gsc1XkBWggP77AEnT4pSu8ArckIb21038GuUDgJarLPkjNIPVYxeghf0hhnt9xTNcu/PXDjJ57
	 biYCuQDLOkfkEW7TchZfkp5YDG575tNDOA0GSva1HhH2KC+6885PN9iWsKJxUpzTKVFerwy5nHhS
	 VEaBFZVbv0PAZZ5oQJ7t3cmJuzFlVTvhBt4YjnSxUaRzPiBqzMXddqz0HfRCSWxOP/avvVysRlys
	 u13k6K8r6CgzOyakd3qa5yc25x6uGK4LgBSVubvArCSsyjccZz/1FgZIDwH/0CeudB8EeM7it9Ub
	 eWKpvZ35t25FPank5bt54nP9meduanQhdWahGHpg8jR1jYUtYCQUQKDlwxFtMIdnrW6iYlXIrZ
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	bvanassche@acm.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yi.zhang@huawei.com
Subject: [PATCH] reiserfs: fix uninit-value in comp_keys
Date: Tue, 26 Dec 2023 15:16:09 +0800
X-OQ-MSGID: <20231226071608.1262673-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000434c71060d5b6808@google.com>
References: <000000000000434c71060d5b6808@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpu_key was not initialized in reiserfs_delete_solid_item(), which triggered
this issue.

Reported-and-tested-by: syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/reiserfs/stree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 2138ee7d271d..5faf702f8d15 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -1407,7 +1407,7 @@ void reiserfs_delete_solid_item(struct reiserfs_transaction_handle *th,
 	INITIALIZE_PATH(path);
 	int item_len = 0;
 	int tb_init = 0;
-	struct cpu_key cpu_key;
+	struct cpu_key cpu_key = {};
 	int retval;
 	int quota_cut_bytes = 0;
 
-- 
2.43.0


