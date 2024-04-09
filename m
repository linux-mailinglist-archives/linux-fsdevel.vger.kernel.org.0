Return-Path: <linux-fsdevel+bounces-16409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B8E89D195
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 06:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED421C23CBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 04:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7954654776;
	Tue,  9 Apr 2024 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRu3Bevp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0192B2DD;
	Tue,  9 Apr 2024 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712637840; cv=none; b=KYvFTUuymI75vFs/E1etxtqmHHJ6ogrcFjW2uq2PxAd4XPWpgfVrwWUHRsCYwawovJm3P8VxIuawMFMU1zLZazcBGHdUFFtlx96bTLO2xXCWqy3Txjh2ycdwi+ZUmBjaQs9My/Rwc/6B3836dK9G6n0fYaEVs08c4a+oy3oGKds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712637840; c=relaxed/simple;
	bh=leBEXkCaK3+c0BDJTMQ4LEGGdKWqrrDOjns+gsQwv74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ix5rZMK26rqUCOGlgN8oKOvj98iliJbKnFXC4a9gknzcuVQa+WL+o30WPWXxnm3vihm6c1x7HiLeQAKqXLj3/7XxGUI6wUVjH3txnxupZPIL4I8U8qhms4jrzi57m3K6CPatSjIS07mAWAw8T7H+eS+fvdN2xpvr9FHnTwrb3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRu3Bevp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4DFC433F1;
	Tue,  9 Apr 2024 04:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712637840;
	bh=leBEXkCaK3+c0BDJTMQ4LEGGdKWqrrDOjns+gsQwv74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aRu3BevpJC52+U4MlDu1y6ru0D6MgY5T0BAc87twzgNRRZ6A9UFLNMDomkHATVMl7
	 0AYqHHBBTamsVtcgw7ekAJ/kiKEqEDB7q8P2uPUcIi6fLOfP43h3KqMs13Dz80nGE+
	 cEjrVT8fDHZHD6pswn6Tyr/uqq4Qr2d5vVuSvR3kx7KzIRmFpCkyQwJsVECHj6Fj2I
	 Qp+lxSsNUuqZA4roJp/+pOvLKdQSHagc8cp8AWjxNQs030n8tNJGdHt9KqhIV3d3pO
	 G9zbnnCOisFCMaOeSQbem33/YMHqYh05/92Nf/TMquH3Y5T7mZBUSodoNcC+gulfd5
	 Q8lxe+o6QGM4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2A875CE12F2; Mon,  8 Apr 2024 21:44:00 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 fs/proc/bootconfig 1/2] fs/proc: remove redundant comments from /proc/bootconfig
Date: Mon,  8 Apr 2024 21:43:57 -0700
Message-Id: <20240409044358.1156477-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
References: <b1ab4893-46cb-4611-80d8-e05f32305d61@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenhua Huang <quic_zhenhuah@quicinc.com>

commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
/proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.

/proc/bootconfig shows boot_command_line[] multiple times following
every xbc key value pair, that's duplicated and not necessary.
Remove redundant ones.

Output before and after the fix is like:
key1 = value1
*bootloader argument comments*
key2 = value2
*bootloader argument comments*
key3 = value3
*bootloader argument comments*
...

key1 = value1
key2 = value2
key3 = value3
*bootloader argument comments*
...

Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 fs/proc/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 902b326e1e560..e5635a6b127b0 100644
--- a/fs/proc/bootconfig.c
+++ b/fs/proc/bootconfig.c
@@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
 				break;
 			dst += ret;
 		}
-		if (ret >= 0 && boot_command_line[0]) {
-			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
-				       boot_command_line);
-			if (ret > 0)
-				dst += ret;
-		}
+	}
+	if (ret >= 0 && boot_command_line[0]) {
+		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
+			       boot_command_line);
+		if (ret > 0)
+			dst += ret;
 	}
 out:
 	kfree(key);
-- 
2.40.1


