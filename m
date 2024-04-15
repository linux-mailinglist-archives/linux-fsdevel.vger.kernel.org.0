Return-Path: <linux-fsdevel+bounces-16939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4538A53D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4451F20F08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B2F81AD7;
	Mon, 15 Apr 2024 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dd7ZzrxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F8F80C1D;
	Mon, 15 Apr 2024 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191353; cv=none; b=q4vR2aixvmncfI3vsQ2rk+MnkleUa5ozWClosPHwulJyML3SiK/jcJ6XteAFG/Mj8G+K5Boidm+YFlITk+ll22NB75qzZi/HdCwECaUH7xR0jXB2dhPtenkSt+o5DOvZytWQmdEfbZexIWHnGyeZROX27VUMjqw3nhbC9BB5LUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191353; c=relaxed/simple;
	bh=8sb7TK+lrIcWs9R2APPbPPRQpoTDuiDeqYNL9OCdmAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcqkvLg54qK6Wvn2CUGIBS7XIVorWEwd6V0sfYlk//HcZH3SWR2tsdHtENC6KvtB152xY7g4YSU5x/lGEF+vySgWJAYINnsWyOlplKL6yxwJiskkdoJlVsfhgazzMNlB0e8i1HOnk2+BvZcYxktTxB3n8yMwnNPtvkKUJmFWhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dd7ZzrxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9C9C113CC;
	Mon, 15 Apr 2024 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191353;
	bh=8sb7TK+lrIcWs9R2APPbPPRQpoTDuiDeqYNL9OCdmAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dd7ZzrxXKXPK17FXtJLFUpwaFw/PljDKeZc/4rr0VW1dY5zAM809z8obMdEbkijMf
	 /NlfDYpNSGN12Iplc+7c2peC5M5ldGKmiP9n0cnMpLUqmXa1nsSCQj7hAI8pRogz10
	 3ZJrV9bF0QOft80l0Qc+6G5Sw6QOlXmShlDVLpas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCH 6.8 114/172] fs/proc: remove redundant comments from /proc/bootconfig
Date: Mon, 15 Apr 2024 16:20:13 +0200
Message-ID: <20240415142003.855718755@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141959.976094777@linuxfoundation.org>
References: <20240415141959.976094777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhenhua Huang <quic_zhenhuah@quicinc.com>

commit fbbdc255fbee59b4207a5398fdb4f04590681a79 upstream.

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

Link: https://lore.kernel.org/all/20240409044358.1156477-1-paulmck@kernel.org/

Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: <linux-trace-kernel@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
index 902b326e1e56..e5635a6b127b 100644
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
2.44.0




