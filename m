Return-Path: <linux-fsdevel+bounces-37249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770709EFFCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 00:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF5D168608
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 23:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED081DED40;
	Thu, 12 Dec 2024 23:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/wyPSWO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D799F1DE884
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734044654; cv=none; b=uuXeVH+p2iu3CdPRI0wV+D+E/PQWIgIPI5GCmq61MKnt4bVf00d6ybxd3UQlXStE04D+sCSKRZOKQe9Lrtw+P8Hb29MApHUS2Xcw1fP5HevKJmebWR891SQ1RJcXtw+GxR8GtewvBdsHESc9DroRzr0fNO2kyrXZBw35k2Sgook=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734044654; c=relaxed/simple;
	bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+jbOJTgrdXIkfunZnMrevtLGiyRW5tu/LRQ1xUU4vJjhmjJ7ZO8n/aBgAb2SkEzDOHijm8zTGNbRsqkgJOGCVkzyRzG1LPfC0M4pTh5OUDVNMy52jAJ12V2V+M7HE4yM9CCoNE2KgIo9qWdZ5w4hGm2OTNqYBofeVkQwkh96hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/wyPSWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038EEC4CECE;
	Thu, 12 Dec 2024 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734044654;
	bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r/wyPSWORS18nJSbcBGbV/xGcoyNaVKq+7Mo0e7DB6N1pgueFG1q0ulHEs59ypTIS
	 kUnjOKDQB/cyEYAJgkoAxcLuYtQLgDlEob1VEM+YzPd53ctsTO1xDW1lL3n6HUD9qo
	 lbZywBUadCj5LYFMjQDfYTh1vpnFvUFdwhaflDmz0QHHuymDMN/Vs9QbEPO8SCRcAx
	 sxUaZTZzy5ycszKdtYQxPcQq/f8LawKetR+wWt6GGnJkofosyCRDu/d/yKOS5LdxhF
	 QhtsDiKeXcCMo8zlsZtqIcw1H/vY4d9xhpplsSac9Mf+iBImSudJlHq1mrdE4tur+s
	 qu/CvR7qQxzTg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 13 Dec 2024 00:03:48 +0100
Subject: [PATCH v3 09/10] selftests: remove unneeded include
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-work-mount-rbtree-lockless-v3-9-6e3cdaf9b280@kernel.org>
References: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
In-Reply-To: <20241213-work-mount-rbtree-lockless-v3-0-6e3cdaf9b280@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHZ98ymWjgLxx/eaLykpm/3vVfE9vx4u0d00Rbm7g93
 8uS3u4p7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIVmOG/x6ZgpbrHzh2s2sa
 bTlo6Jv6d4XksbvVZve3Hjxue/jU788M/wwSz/I0PU7mED/0hU/KSWjvrm6Xt7e1udMDLz+7dI2
 ZhwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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


