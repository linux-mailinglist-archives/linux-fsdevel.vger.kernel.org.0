Return-Path: <linux-fsdevel+bounces-61076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3AFB54CB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2328C175340
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2658F350D77;
	Fri, 12 Sep 2025 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLoLkczJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E671302767;
	Fri, 12 Sep 2025 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678162; cv=none; b=u+fIMBQMZfLVcsqDJxhaNGXqzMADxCcYaWpxJLkCvep0DaPp+t1z7pM53bhpRK0g3vPhZ8CL9i6/VATZW8BTR3Qj8I21GjaH1F7lONZV7XJKpGDQmvJQfAXiKVk7/fHybgT5ScvVOXEtEBHH2WUN5rEjtYczS+ukmxnKnrrYEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678162; c=relaxed/simple;
	bh=s091dkqnEzx9CL2LoT2nl9luwY4Kb2KRFzrPBhLqf40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKN1DKtGGO/C6r8fhLUZnZmiDgpUM6Q24l7JknZUBENWNzCji3M0P+nFH9/LdQEdayGtHEN6t1pPK8CMMmthbatecTnohVqHDgzym/9VvrH471106xVXeql6cRL3JhSI4akt8q9AC4nQ3/vOrqUWwivKs7iwNkS24V06w4jO8S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLoLkczJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AC1C4CEF1;
	Fri, 12 Sep 2025 11:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678161;
	bh=s091dkqnEzx9CL2LoT2nl9luwY4Kb2KRFzrPBhLqf40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CLoLkczJuz94n7zrgUFY3xUGVFVf94W81uIfSEiT/9hjR2orXrxkP38K3ym+2XK88
	 dz9oNqEBB3gx5eUfVEv1IfC3WutC7PjhbvRy81cRMMiO94n0jbRWqcCiRg7kM4q4i/
	 nIAQ5+Bjc/YdsXxd7/6JzzH7065F+0dhGDbthMV6j/J0bQd92Rz1el85gQurmZT4bv
	 x5uQQWlKRVMzk+Am6Ur561nCnX2XpzeQ6VO7F4Dh8sRQDNxXkpWl8kAKjuZu4mSNth
	 DJ1xCSCrJichBuCxXWSMW/aHHHKGk0shslO0RiUQSyW0KXzvUKcYON5yxnBu90xQN7
	 BZBwLJ79VDwSQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:54 +0200
Subject: [PATCH v2 31/33] tools: update nsfs.h uapi header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-31-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=brauner@kernel.org;
 h=from:subject:message-id; bh=s091dkqnEzx9CL2LoT2nl9luwY4Kb2KRFzrPBhLqf40=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zx65fKhRVcSZwe2y23f5rtttdunT1svLS0tj/tpN
 NX9u+Yh/45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ/DnG8L/6hfDpNyp51gxW
 n851NOdHsF17UiHYylpV+fT6HeddetoM/6skD4vb18R1nMxaLWb5blPwqwbOf2cWhszb3+P256r
 CMRYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Update the nsfs.h tools header to the uapi/nsfs.h header so we can rely
on it in the selftests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/include/uapi/linux/nsfs.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/nsfs.h b/tools/include/uapi/linux/nsfs.h
index 34127653fd00..33c9b578b3b2 100644
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
@@ -42,4 +40,19 @@ struct mnt_ns_info {
 /* Get previous namespace. */
 #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
 
+/* Retrieve namespace identifiers. */
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
+#define NS_GET_ID		_IOR(NSIO, 13, __u64)
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


