Return-Path: <linux-fsdevel+bounces-20908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEB8FAAD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081CD28202F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1F71422B7;
	Tue,  4 Jun 2024 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuRhARNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6684013FD9D;
	Tue,  4 Jun 2024 06:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717482600; cv=none; b=AO4ofHV1gLUb+Z19I9rzQQexA6Rqm2i0Y5KnYbxRx7mrMfvuJvBkgXrM/UTyZqNQRWPWZ4D7d9GRLoCdOuIl/tPmDwWhs1AqV1XgI750yFd0l89MeVBM2+/QSTTR8SvmgsL+9IeFg85qDMEkpJyywxmGzJ0ppryuJlOPqidzuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717482600; c=relaxed/simple;
	bh=C/wJBaI+Nf//FLZ9qNdBqF9DbNgygnVG1KR7x04B2gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4iCpkQhVkZQ0UQP9X8rWsofVa1Gn37rVU/Bnu17PoHHe3vCtrkU5D6nMYapzkpQ0eAlZkv6NeMTS5diezFYX9PdwC/nmXPsfyfzbDkyfnzbit3Scn3G/OOc8ISi43VckRMyEOkFeJXktntr14CT0MkqlXWF8Qlh4ccQJPIDTNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuRhARNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1B5EC4AF1C;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717482600;
	bh=C/wJBaI+Nf//FLZ9qNdBqF9DbNgygnVG1KR7x04B2gE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YuRhARNoR25hcvBkcNAUTgIhqRJKKbjGFRg5liFLM0brTj9UeK2wwzFmJKrQxqamc
	 YhMzrvdgZoCRZbKxCTWmdcZt2armObHFKIjVKcN1WF6i9MiP2m/MI7MpPSdr3xq4nA
	 buulh7QU9cov1UYJgez+xfYAOHl9uM1tSLfzv+zZlxQY9KTT98QMdcX/neht+YmmeU
	 H9B/eFwudfX3UzBWsvd+61dvQtpkEI3yt+h0Vjfk0gqmTsFoBqx86m44y1LZOhoNYC
	 udGaz9SUc07Z1u4LvBlpX5M7ELIQxpco4xgdtKDzFgP3nkuvOc63yqwPmbmR2cff7t
	 JJ6h+s+XI3Xkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8318C27C54;
	Tue,  4 Jun 2024 06:29:59 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Tue, 04 Jun 2024 08:29:25 +0200
Subject: [PATCH 7/8] sysctl: Remove ctl_table sentinel code comments
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-jag-sysctl_remset-v1-7-2df7ecdba0bd@samsung.com>
References: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
In-Reply-To: <20240604-jag-sysctl_remset-v1-0-2df7ecdba0bd@samsung.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
 Kent Overstreet <kent.overstreet@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=zTe/Mj/k43FhBaGgdPaFYoMPRIHkDQfZ6H7/ug1O6Cc=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGZetGUkSr3CVpnP54k/+9PHKhfTTA69nKuVw
 AbWrpNS33D41YkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmXrRlAAoJELqXzVK3
 lkFPCvYMAIUVsRJA74OqhAoo95LSMr9pMo00Icg5tPkk1tZPCHQkgj4cL2Zu2V5jRGwRSkLxp5H
 IR0HctTp2+yGtKeGn8qj4XbwZ1GKTdx2q8M7n61gfVtpwl28bbKBSCCdOBFet1Z/RjdfO7qztoE
 iqAoUGKhJ4gsokBwKCrCTFgKTFDOD+B/B0cVwfcFRYVxtxTf5kmtg7MlAOY+Jtu/e8SLt85+h+G
 qgaRnRK7WRFMhZpfhgYzt02oNXWGlM/cmg/oo5Jbw/oEvgvrEngxgzuwmKQpfugA0KyBDBLyV0J
 xRQlthY/U1hjOXj80QnD1wSXjQe85phvjRlxf36FOsL+TjkQvUf0Qgk1WDbuYwHsJpxk3avhU7n
 iF/b0D1fc+BUB06Ux0PTitZBh39pLgo+UsK2yLw215oBiL9sRILV+rwI03Mr3BOyAsxWImkNmUY
 jVhQLyQ2SE7sBmT6Q6jBK9ea/2wQ2/WOFtIjQk0eGHHJy4Yvc8q3GoGbYPe3jxNFcKzMnX+Iuw6
 GA=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Remove the mention of a "zero terminated entry" from the
__register_sysctl_table function doc.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 2ef23d2c3496..806700b70dea 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1306,7 +1306,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * @table_size : The number of elements in table
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array. A completely 0 filled entry terminates the table.
+ * array.
  *
  * The members of the &struct ctl_table structure are used as follows:
  * procname - the name of the sysctl file under /proc/sys. Set to %NULL to not

-- 
2.43.0



