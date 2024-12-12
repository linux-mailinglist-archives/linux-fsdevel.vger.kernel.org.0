Return-Path: <linux-fsdevel+bounces-37153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5799EE610
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1351286B76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D914211706;
	Thu, 12 Dec 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbh90pF/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDADE2153E3
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004588; cv=none; b=eCMt6khjnrbaou/XSdi6s8Xd68Q0AvHteTXbB+3hKELKk6RCXN95JM6RunKY1fjMeVGRp9jtyTmQFgYc/GYwz5e4mPyCen/cYSPjJ8Oxs7inTPemWQshjsWiycIvqoStpT6OfTM7mIwS2ZVa1ojcConAkL0OQQE4QmPNsM+5J5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004588; c=relaxed/simple;
	bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OgPaNp9w/FQmyBkymKEKY02EO3NjgZ2r6RU48Z3/cTyjzfdNYAeyYliV0VzuzmBiwJccQER6hnUFD+5MrjLsVIrN26cdMa/la8c21fEg7Td6lej7BjI9ekbB7LepVdwvGotlAi/qzMm99o4tDcYUe76IF/FYzUv77SpCOUMGKJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbh90pF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDD7C4CED0;
	Thu, 12 Dec 2024 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734004588;
	bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gbh90pF/5WL3sVoSkydIiaWU83nAn/6xqFJvtj/E62JvnryTIEYgEaRqTD+RRo3hV
	 Bcuc5/z+i0Na0qxH0w5Pl1VSHFpdnlVj14Va4bNtVm9xsJT8Qb9RrzcHn3X3HTrqrB
	 3cc7PjSSDJAI2HBlpb6/ZEreBRaxYDkBcVGQUKTd52HM+K1A92+1q720TUpHc5V0Kw
	 7xcgIfbYAs0FB5tnBMJxDmae83ikmSp5ldxAuLldxgWwGDHqwvXo0Z2TBkltzaOkIi
	 FPDSAuEbNQACWqjRK7kCp2RMY5ngdqYZChVMT45brTXmaz+1ahoAWCdacmESK0EGOJ
	 VupwS6DTeld9w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Dec 2024 12:56:06 +0100
Subject: [PATCH v2 7/8] selftests: remove unneeded include
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-work-mount-rbtree-lockless-v2-7-4fe6cef02534@kernel.org>
References: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
In-Reply-To: <20241212-work-mount-rbtree-lockless-v2-0-4fe6cef02534@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, 
 Peter Ziljstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=731; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7v4bOxKWz5L9zkkJvMX4FPAPpL80DWtTdu+GzAsXCsI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRHnY+Zuze8XLJG75Teeo+7uoX+Uu/d5OXnz5Xe55O98
 fi9Ew4HOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbi08nIsF8iR0ZWZJbDhqh0
 PhdVZ82T/o+e/N25Mz4l5s3JswzPXBn+WV9b5cBe1V7qcO3JqZspS6e5tFp77Dx5X84w2FVT72Q
 XAwA=
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


