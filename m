Return-Path: <linux-fsdevel+bounces-36987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E69EBB4F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD782844B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 20:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C57422D4E8;
	Tue, 10 Dec 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgbOsbAu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B422B5A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864296; cv=none; b=D/tdx3sRBxHw8GDKnMi1n64Kbw26HOYHdgWHGHK46TeiQpkJgswr5dIfeWmumb6AHjI7zQZ64Vvu6CZYgi+94qtsEWTUsu+4xMv+YI0gBTjTWpG2A9JZTWnUC+ADHFBBwWzE0XSlACJnYXiHtog+VlNxoqTPa7+hFEk5L1066ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864296; c=relaxed/simple;
	bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtK44QDRk1H6I3f3tIGUnRthStoGYrLcsL8ZDeWfrA//yKvhQLGMs/Q1RDjR6iHU6u3u6Zgy5GjMCMMWblVNd1iYgQq/3atAOF9QfqBKuqDEelzL8m4tAnOqlpUUHbZHNJ3jWcTAXKdbjlax9DMEaFVRnJu0+p0dSIv4NXcvYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgbOsbAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322FFC4CEE5;
	Tue, 10 Dec 2024 20:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733864296;
	bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgbOsbAus531PeJzMa20WQGOtVuNVNYosj60QHaFAvWvprtn8bQikAoEMbwGZT834
	 cPFYPhl9wMbqh5MUFPKV99BbSVTgPPSN6WjYYx1wvyfx5691DtRFu2XZuAPRSr8Kma
	 wmceZF/pkmmZ/W1q7rDRm+RGBdZwcyP8rgWmmOTgH1Bvfp1KA5Zm3DuLINgfxDblk9
	 38YFfPkk0acu3v4aqVfBZ22BHizzL1+zAwKpUy3iPLW/4YR/EVRpbspxEdCmB6W3+R
	 tfCclrL4ckSYF1zDO/NedyUPBHpEZF8xQ7kfAiR2CufXhJK9FAsnk6vqc0bQsLGJBx
	 BPcNhaiQU8Nng==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/5] selftests: remove unneeded include
Date: Tue, 10 Dec 2024 21:58:00 +0100
Message-ID: <20241210-work-mount-rbtree-lockless-v1-4-338366b9bbe4@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
References: <20241210-work-mount-rbtree-lockless-v1-0-338366b9bbe4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=brauner@kernel.org; h=from:subject:message-id; bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHrI5Y+eI8u0Pr61MGe+Ld83O/X/Xps7sjP21rk7ezq u2el+bVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpADdZnZFhhufh+luq+n+XBXqX zu6U8N0889efw9cvOYo52zVWTJc6w/BXYhdLyv9qZnmnJ/nuDTyZfhK6v8MindtvuqRJ6Z1r28k PAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The pidfd header will be included in a sample program and this pulls in
all the mount definitions that would be causing problems.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004df3c7a9d3ebcdab89d5775e9ab9b..3a96053e52e7bbf5f7f85908c2093e9023b1d3d6 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -12,7 +12,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
-#include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 

-- 
2.45.2


