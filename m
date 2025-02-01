Return-Path: <linux-fsdevel+bounces-40540-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D423A24BD3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 21:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0815164ADE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 20:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B81CEADC;
	Sat,  1 Feb 2025 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="qeXkitTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB264502A;
	Sat,  1 Feb 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738443090; cv=none; b=sBFYjrJeTyHV7Mkdo3S0aFyZzumktS4/VugKqGmLU1C+TUKdHlTQ/wodidqCKeDLQ88r8A8lFJepBaAQLNkqTi0OBDaVR+IF08QSPwHvRAVJ7WiPhv2NMdQFFgq0k6g89x+V3gT/iqgq4XFJpO3cN1tJFgFrytG64u89Ucb3Iac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738443090; c=relaxed/simple;
	bh=/9KROOA7f0hl5qdYHY27d9wiQ7eLsfWMe/sY9xLIldY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=toylEIdI7JIYnzgrMoq4LTSea7V7hJP3yfUiJcfazEBZOtd1ehztnp2P7OjnDlFnJZ7TaAyKFtm9Qkv9dq3DCajnFKE0susuYYomMtzwXkFyYrOnSRV1nd+r0mfNDhSSFVaajQmzRe3qcoAhpj0YTyRa4lSx+Bn01VjXyBTR/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=qeXkitTI; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 98F00177202; Sat,  1 Feb 2025 20:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1738443087; bh=/9KROOA7f0hl5qdYHY27d9wiQ7eLsfWMe/sY9xLIldY=;
	h=Date:From:To:Subject:From;
	b=qeXkitTI/7GFZ2FApdi/I9o2ZxgaYoH70FCsBLOH1baRAqKZKT7+0gwEb0YLGT4jI
	 KVXvUQsuijo6ZQDDenaXV1aFp9vyh4opM66OZHNTpFVXpVfsp1dz7A3PkV876OdpTK
	 Eq1Hzt4tQbnHFbge0rSoc+I1o4kiXVT1VMsu4TT7lzPR/gIgJfYupST+09bOaP8VVu
	 UaqTfsplSnlRy03yOV4RxeRMlzG2OIdnTbeqFVp48OxJe0jwhUL52fGrRZvEi2eSwn
	 IquOzirA5eC0Z5C3NZugT6DG3cMGM5y2ZoqrZQypefYJlYOqrVCw8bzWxm0LkFYJg/
	 JwIhhHATc1dbw==
Date: Sat, 1 Feb 2025 20:51:27 +0000
From: Nir Lichtman <nir@lichtman.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kees@kernel.org, ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exec: improve clarity of comment regarding pid save-asides
Message-ID: <20250201205127.GA1191798@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: Current comment regarding saving aside the old pid and old vpid
is very vague, especially when considering that it is unexpected that
execve can actually kill the current process.

Solution: Improve the description of the comment explaining more
in-depth the reasoning behind.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Nir Lichtman <nir@lichtman.org>
---
 fs/exec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..343c435b00ee 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1792,7 +1792,14 @@ static int exec_binprm(struct linux_binprm *bprm)
 	pid_t old_pid, old_vpid;
 	int ret, depth;
 
-	/* Need to fetch pid before load_binary changes it */
+	/*
+	 * Need to save aside the current thread pid and vpid
+	 * since if the current thread is not a thread group leader
+	 * the logic in de_thread kills the current thread and all
+	 * other threads in the current thread group, except the leader.
+	 * The new program will execute in the leader, with the leader pid
+	 * ("man 2 clone" CLONE_THREAD flag for more info)
+	 */
 	old_pid = current->pid;
 	rcu_read_lock();
 	old_vpid = task_pid_nr_ns(current, task_active_pid_ns(current->parent));
-- 
2.39.5


