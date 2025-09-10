Return-Path: <linux-fsdevel+bounces-60804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC1BB51A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DA75E3220
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AF0393DDB;
	Wed, 10 Sep 2025 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrHoFTzX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ECE33A00F;
	Wed, 10 Sep 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515206; cv=none; b=drIF5IbQseZCe7I7ozsgYdUh1QBtH8vbZnfMJrC94Ka76rAQEMRrXOMNixl3uqioLPMgZOCaRimBl4EjAUkjn4stAvPX+R2DJT+VWlSp/wBIuR6SUOVsAHo6ymlsK8/734enu9I+n553QSkXNTVd8u2C4ixbzOT+UHH7tSMsf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515206; c=relaxed/simple;
	bh=gbS2ymyvQLhpBSZHty4/HJL9CBgNRefAr9z2qgMgDus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qqHRpWv2Hin7PSIsaTbQyHl7hy++UvjfBUd2tt7UYS8O0V4lNtIwLOXLCiRpHXSQFOtLJLY2T0lsvnNHIoldMwsoPXWibTN0hQutPgcBECOxP2x6VryHxa+hhR+GzDChLNxrV8atNdbFX+7eSC2MRh4wYy5neZLT+lDnLKHDo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrHoFTzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385A6C4CEF8;
	Wed, 10 Sep 2025 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515205;
	bh=gbS2ymyvQLhpBSZHty4/HJL9CBgNRefAr9z2qgMgDus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WrHoFTzXH0e/Em4vInRV5aEDw73hGv+cCIsKqhe0lF+mhsJ0Qm2gVpbz/DxaSczcd
	 WkYIHhLlWZoUFSg1thfftu9+vqe9+GlOjeQ9S75FJQ6a1gyn3GNEE9BRAWWye/5cM9
	 SEC+I7Fp5m8CBBK+iKkVZIMljXpOQvn7GyZRrswtEw8zLJdwA2XpQZlOAIP5TYAcC+
	 +2vxSBPgP/5sP17Zg3JGYtERYdjjm51t/XguHlXBUreFu0gmNyfI/KW10OYhK2c/5E
	 MAIzLqjFLSI55Lk0FDlvshDncouVGrAoumlcAiQApmEqxJpvtiKC4sHdl8L/eKQKRp
	 WrcGgBSdb6KdA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:15 +0200
Subject: [PATCH 30/32] tools: update nsfs.h uapi header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-30-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gbS2ymyvQLhpBSZHty4/HJL9CBgNRefAr9z2qgMgDus=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OX0c/qo4Lq6fO6Tr8baU7fk3My6d9zE9vQ5pgWez
 KdFV1WEd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEcxLD/xTzq+0O1Xfnb133
 jnXhw1VdL5z6tQ3+c6Xfm/E4/MLhwt2MDH9vXVt6KPh6mrFdlG2I+y75Jk3DzekrGRZ/453GXPj
 MgxUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Update the nsfs.h tools header to the uapi/nsfs.h header so we can rely
on it in the selftests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/include/uapi/linux/nsfs.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/nsfs.h b/tools/include/uapi/linux/nsfs.h
index 34127653fd00..f7c21840cc09 100644
--- a/tools/include/uapi/linux/nsfs.h
+++ b/tools/include/uapi/linux/nsfs.h
@@ -16,8 +16,6 @@
 #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
-/* Get the id for a mount namespace */
-#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
 /* Translate pid from target pid namespace into the caller's pid namespace. */
 #define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
 /* Return thread-group leader id of pid in the callers pid namespace. */
@@ -42,4 +40,25 @@ struct mnt_ns_info {
 /* Get previous namespace. */
 #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
 
+/* Retrieve namespace identifiers. */
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
+#define NS_GET_NETNS_ID		_IOR(NSIO, 13, __u64)
+#define NS_GET_CGROUPNS_ID	_IOR(NSIO, 14, __u64)
+#define NS_GET_IPCNS_ID		_IOR(NSIO, 15, __u64)
+#define NS_GET_UTSNS_ID		_IOR(NSIO, 16, __u64)
+#define NS_GET_PIDNS_ID		_IOR(NSIO, 17, __u64)
+#define NS_GET_TIMENS_ID	_IOR(NSIO, 18, __u64)
+#define NS_GET_USERNS_ID	_IOR(NSIO, 19, __u64)
+
+enum init_ns_ino {
+	IPC_NS_INIT_INO		= 0xEFFFFFFFU,
+	UTS_NS_INIT_INO		= 0xEFFFFFFEU,
+	USER_NS_INIT_INO	= 0xEFFFFFFDU,
+	PID_NS_INIT_INO		= 0xEFFFFFFCU,
+	CGROUP_NS_INIT_INO	= 0xEFFFFFFBU,
+	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
+	NET_NS_INIT_INO		= 0xEFFFFFF9U,
+	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
+};
+
 #endif /* __LINUX_NSFS_H */

-- 
2.47.3


