Return-Path: <linux-fsdevel+bounces-62396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFF7B912BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 14:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37EBE189E4AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335DE309EF9;
	Mon, 22 Sep 2025 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SovP/9kD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA34238C07;
	Mon, 22 Sep 2025 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758544972; cv=none; b=eAVQj2i+3Z39fgpitrwEGzct8dogKlTXvWxC9lJs/38jHGOjxL4Qt13ynN6LvH/9Tvh30TF01th0x33cI2vm37mmmOxGHGEyK6w+5ybe4oPwBIiaUubpew5jIqkSJaV5esqJlOToZNUGt+oE0fQfUJt3pfbWc9QMl6lCr8Ol+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758544972; c=relaxed/simple;
	bh=6j1YGAAdB33ZNWVzjRjTKedVTDWodDiSmGf3HmSt51U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHDkREamGD0gLeoCD1aBa/zUn/tJ+f9WVXHqs0QD5Btf8WhmcsVjctGHkgDaKaj9O8WWxM5cXqt0pqBfzxSUUxHHBVkdG4goBQ8KRrdxrw5Pf6MOMsVLs55wx5PiSM3uTM0dTU/SMvxvyX1j6zIOO1FEEYbNk2BhiELkmvzwigQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SovP/9kD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0A5C4CEF0;
	Mon, 22 Sep 2025 12:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758544972;
	bh=6j1YGAAdB33ZNWVzjRjTKedVTDWodDiSmGf3HmSt51U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SovP/9kDca9qx8CXw2wyAIAEY+Zkuj5oULyEI7/nbZnpp+lsn2RIOmqR+k2owX1qa
	 zoSYkOSqzo6OkmER5+uiRoJQsdXSzZ4MGWCOk/0vUo2z6CKENuJtm1wA1/jvbHXyZL
	 hRIF/T88mNb/TXISnLNRs2WyDzohbQfFj55eqbQnGhSqTCQcJCD1axZS+5+AFnHUGn
	 WBe34lf/Vja228QE1H0RV4jBep6hAjhmP+M/oG8qpquq+1LTPZxRZU/i7H6YMDQ9QJ
	 SqYcdJv7y6zZblX9z9UXz0ECgplZFMrb8Vr7W/dmUVaNChFFJcyGh0sZ755/Pb6nVe
	 KxmY6A4huxwFA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 22 Sep 2025 14:42:35 +0200
Subject: [PATCH 1/3] cgroup: add missing ns_common include
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-work-namespace-ns_common-fixes-v1-1-3c26aeb30831@kernel.org>
References: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
In-Reply-To: <20250922-work-namespace-ns_common-fixes-v1-0-3c26aeb30831@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=621; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6j1YGAAdB33ZNWVzjRjTKedVTDWodDiSmGf3HmSt51U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRcdHEO+bTy2CrPC7Ud7AvPRQW3VzPs9OPefbB5igprh
 7yOqO27jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInw5TMy3D35MM2o3sTiIpNR
 uRjTrdU7K18sCPbe1CIVufyI897QSYwMT0p3tmzJrPLynZToFLpnyp3+V/+fm1eaZTxS2hkp8uk
 ODwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add the missing include of the ns_common header.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cgroup_namespace.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/cgroup_namespace.h b/include/linux/cgroup_namespace.h
index b7dbf4d623d2..81ccbdee425b 100644
--- a/include/linux/cgroup_namespace.h
+++ b/include/linux/cgroup_namespace.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_CGROUP_NAMESPACE_H
 #define _LINUX_CGROUP_NAMESPACE_H
 
+#include <linux/ns_common.h>
+
 struct cgroup_namespace {
 	struct ns_common	ns;
 	struct user_namespace	*user_ns;

-- 
2.47.3


