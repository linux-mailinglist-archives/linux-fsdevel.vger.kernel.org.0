Return-Path: <linux-fsdevel+bounces-44896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883F7A6E3F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 21:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A402171633
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 20:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BB1B4248;
	Mon, 24 Mar 2025 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rywrObxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C533157A46;
	Mon, 24 Mar 2025 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742847070; cv=none; b=cQENmgrTIbO/m08A68w1ONnYnlZ7CffJhtN7IbcCiNMBYjAUzXngK09KfpdpCFwgoeHrjWIUQZ+2iEbb4KXgCNhnpCOk+Z0Zsm8xp/pqS4O5hq7bd8iY+GH1UlUuG497HnNiR3ZlIR76MC0MBDvdURK8bocCT+81nACgy55i7KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742847070; c=relaxed/simple;
	bh=Gn5wfqsdTg1pXDcCJCEM+rXwyK0EQsgqeOcG4tszqnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QLYUNuajgvQJYgiYX2NaiHDwaLngHGBDWjRgIEQyQTGqPvhVrVfNn93g0elB2pmmv2/MdpH26UcB8XF4VcveEAhEz8GZPAPI319Eg3frZfrVjb7GX7/tiru4MVefnxJHjRQqDqX2l7QHpLd3GCR3L98LXluYudhSylTUC+VLYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rywrObxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F32C4CEDD;
	Mon, 24 Mar 2025 20:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742847069;
	bh=Gn5wfqsdTg1pXDcCJCEM+rXwyK0EQsgqeOcG4tszqnE=;
	h=From:Date:Subject:To:Cc:From;
	b=rywrObxmwYPkcNeBmbolmbjUbDA9Rd6eP1WMfILmwYYcW4jv9MhutxK7moLt9Q3Ck
	 7Tj6R2aVeGipQOJE6wQ/xRrP68XijqlJ8LkZwaS57pcKR8m+LAyH0yGSlfLQyIEKfo
	 0RWAPKXvngrHXxs94yW9/FvcCyYNSqWLLGN1ivt01UESiR5m927ffXaOfO1Fmxv3gh
	 A/BR3x5CQeefBQ0uvrH13yP/7KzNUihFrvUYVurYv7Gxe/xwKd5N0OiMDsyM0T1MF8
	 vc4qAvJWif0zGUkpLT3CXkcBJc3LXh0M6503E6x77j2Q6ix2ywrIkx1BdvvJ77IfQz
	 po4L+Mbq9B0JQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 24 Mar 2025 16:11:03 -0400
Subject: [PATCH] netfs: add Paulo as maintainer and remove myself as
 Reviewer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-master-v1-1-e2dd2fdb15b4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFe84WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMT3dzE4pLUIl1Tg0QL01TzNAtzUwsloOKCotS0zAqwQdGxtbUAF2g
 Wg1gAAAA=
X-Change-ID: 20250324-master-50a85e7f8758
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=957; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Gn5wfqsdTg1pXDcCJCEM+rXwyK0EQsgqeOcG4tszqnE=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn4bxbKFzFjdJAGXy3sHo/I0yftZpLUC2AQU9xL
 AHRREEar1qJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ+G8WwAKCRAADmhBGVaC
 FbY3D/9KqZwlmB8nJ5KpZUrrLdpAXl1ekPbjBhz6vV6xotsNv1NWQkfYnFjJxga0RVXB6OfLkEy
 M9bskr1zAHZZ9Nhay1nILBegDT+ITM841deu5YKAvBsWC9okIOcTv5orkrnpj7MFYCkasRVymS7
 GzcghO7cj0+aILYfZNfAZTvBcWrbr2QAZi8ToEpjnlgJkavpqCye1nXeVY9ITr0UQEElxtVhUbX
 O4VPk2mWvZwMcDzpa/TUIXMV+MJfcMZ7oLaMe6BPWmXFtbgXgVyJW/B3NJmTTSZVXXAWmpWCwt/
 cwWwkCMpAf9ohHGszhCTVnI256dCGUpflN0vsT4ZLQbXwGTDt6ly3F3DibhTIMIzJnty9wwwSNy
 kHcYrg+cIOOjJ8o2jLwuVM7j9rn4YBwijM0t7yWHrOq0TH3A1FIU1YSXa71iLGKFHDLByJIIuwH
 98Qiz3Co+aBxI14lNYTtIA+jq76aOWHbawWIeAMckLIHCGQGkIHH1wJcj5wH9GMLZVWDq7vFl68
 6AklRcVxEqRTJkOeQPVaQmbwI+96rvtAFaecLwll05OgTA2xEuctkWihSodQPC/EJT3P2jQvuVP
 EM3pFAvepWHoZuKPIYiTp7+TvPCDYsl4OUb4AGiJ4Gt51KOerL5+VnZw/g0fLV9/k4Pv9CTcEAH
 k4tHMaPPtSAO6Iw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

My role has changed since I originally agreed to help with netfs, and
I'm no longer providing a lot of value here. Luckily, Paulo has agreed
to step in as co-maintainer.

Acked-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00e94bec401e1b2fd9d3a01f158d66291cd3c30f..f44ebf6ccfa082a8567de649d09c78ef9ad22c82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8938,7 +8938,7 @@ F:	include/linux/iomap.h
 
 FILESYSTEMS [NETFS LIBRARY]
 M:	David Howells <dhowells@redhat.com>
-R:	Jeff Layton <jlayton@kernel.org>
+M:	Paulo Alcantara <pc@manguebit.com>
 L:	netfs@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported

---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250324-master-50a85e7f8758

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


