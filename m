Return-Path: <linux-fsdevel+bounces-36984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C319EBB4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 21:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909671889C13
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7E722B8A3;
	Tue, 10 Dec 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohl3R311"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE4922B5A0
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2024 20:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864291; cv=none; b=LGdBZA9FWFjAj4SLLifzzENx7nofhETL+2D0VgqGDUOgvaNavTB8AJG65uf2Ju39CMVaVNkQmq22vL2dlMGRcVAYm4L6cF+rltg9OcKZvSYuoqIE0Refzx/0+4rxtQLduSlqxw6ETQLb2SHfLsQ/PyhIQF8fCTtfgjtPlsijg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864291; c=relaxed/simple;
	bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jc0uqYm6YD1U0mKTik+SW4VJSS4L7ZU7g3w+Qr/ZlYYiBdh2Z4IaYex9C8SJvDYQyPdPnMZ0UnCwGArpJp6gM/D8wwpwGIbuZeiIgjNxvFNJgOFI/8P3v08imhnluRk0xVXMjHuA2X917bT6axqvbqDuOgTjk1Ldwjhtq7tzOow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohl3R311; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1FB3C4CEDF;
	Tue, 10 Dec 2024 20:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733864291;
	bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohl3R311bMXmES2lHe7e5X+Aagz3dAm4svaOf0A6Ge11BOMmX7/wr3DpinOKAsG9q
	 tYl/1PWU6VrrOvbwv7BBOkWJiTuP04vQAiiYgu7sruH8LuS4LifrYVxHyyH18fVkuJ
	 ckj3U1rCiNbDEAxUO08wTStfRntSdKxqNyhB6RAsvzKsbJBz/d4qRDJ/fncf6jiDVi
	 bJzJttcTtZaFdsiPvUTMpht+2TQycGw7xPToY5MpAyJGRAKA1sKzkyBhZn94FaOCYg
	 jqYMKuwJFzJFNlUAe5Vo6If48antZBcddwok3jESeLyAo1aqMq17S1ls2pKdXxPKbb
	 Y4K2tn0PXWVvw==
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] mount: remove inlude/nospec.h include
Date: Tue, 10 Dec 2024 21:57:57 +0100
Message-ID: <20241210-work-mount-rbtree-lockless-v1-1-338366b9bbe4@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=545; i=brauner@kernel.org; h=from:subject:message-id; bh=fU88zLcq6ecPFqxhMBQ+2G9JGuR1hEfsB9CdeCQqDmY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHrA5/sc3EvXPesdvb7nywze2u+bwnb+MhZtHzl1cbV L16vl94akcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEQjsZ/qdbb/3e96Jq/YsL t9X9V0jtd+MwWRm0tMn9z9V3jVev32Jk+O+w2XP1pFpPrcN1a3Ye0mC+ruJccNSjVHV6Ys7B84F HjjMCAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

It's not needed, so remove it.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3fee7d97df2a84a69438a677933654..c3dbe6a7ab6b1c77c2693cc75941da89fa921048 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -32,7 +32,6 @@
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
 #include <linux/mnt_idmapping.h>
-#include <linux/nospec.h>
 
 #include "pnode.h"
 #include "internal.h"

-- 
2.45.2


