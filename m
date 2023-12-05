Return-Path: <linux-fsdevel+bounces-4823-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11780450B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 03:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8B91C20A05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743CD285
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Dec 2023 02:36:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 03614F0;
	Mon,  4 Dec 2023 17:51:44 -0800 (PST)
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 68526605812FF;
	Tue,  5 Dec 2023 09:51:42 +0800 (CST)
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
Subject: [PATCH] =?UTF-8?q?fs:=20exec:=20Remove=20unnecessary=20=E2=80=98N?= =?UTF-8?q?ULL=E2=80=99=20values=20from=20vma?=
Date: Tue,  5 Dec 2023 09:51:39 +0800
Message-Id: <20231205015139.99501-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vma is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index b01d2d40ace03..cae37330e7442 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -253,7 +253,7 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
 static int __bprm_mm_init(struct linux_binprm *bprm)
 {
 	int err;
-	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm = bprm->mm;
 
 	bprm->vma = vma = vm_area_alloc(mm);
-- 
2.18.2


