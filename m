Return-Path: <linux-fsdevel+bounces-4821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD51804509
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 03:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859061F203F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4AF8F53
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:35:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 53728B4;
	Mon,  4 Dec 2023 17:46:41 -0800 (PST)
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 702F7605727E4;
	Tue,  5 Dec 2023 09:46:15 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	ebiederm@xmission.com,
	keescook@chromium.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?fs:=20exec:=20Remove=20unnecessary=20=E2=80=98N?= =?UTF-8?q?ULL=E2=80=99=20values=20from=20mm?=
Date: Tue,  5 Dec 2023 09:46:12 +0800
Message-Id: <20231205014612.99243-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mm is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 6518e33ea813c..b01d2d40ace03 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -368,7 +368,7 @@ static bool valid_arg_len(struct linux_binprm *bprm, long len)
 static int bprm_mm_init(struct linux_binprm *bprm)
 {
 	int err;
-	struct mm_struct *mm = NULL;
+	struct mm_struct *mm;
 
 	bprm->mm = mm = mm_alloc();
 	err = -ENOMEM;
-- 
2.18.2


