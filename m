Return-Path: <linux-fsdevel+bounces-15955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23689625B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B9D1F25A4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBE17BCE;
	Wed,  3 Apr 2024 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aAaHfe5b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB914F70;
	Wed,  3 Apr 2024 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110590; cv=none; b=a91UvHuOO3SdHyS1WhohOJR36j90D9CHk9hw/eLcBTpevmA4OLG7MlUQJVEZZGAeSn87vE7grNLWBHHYkUfft4UzoEHfke1Q1T4TwP+hgSSmk2FpYaG3XLbBHc8ux1gP87jvAEBFDAEzgSZDveLKUgcckeIT+8dm+Yke4GIdPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110590; c=relaxed/simple;
	bh=/mxN8H4HfV7JABW4Te432WPH6daYeWBceHea3twjMLM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=omoiahcPBevfnmSlFDAgaegJ3zJ936fM76pvBxZdehlLClzor26zotvfAr7uUa4pGEJwnGSm/L5aBQH+SmeW0877qC54plABbQkCuXU5Zp943d7NYPvGN+k59Fq/e43ASvjn0+UynrgN7EpJZPagHp7nk5fkRky0DwLbhq/sF9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aAaHfe5b; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712110580; bh=ayMG5kPQyrq+8jbtAodeuRBjRi8R0ZuYWiPfYDs0A34=;
	h=From:To:Cc:Subject:Date;
	b=aAaHfe5b5gUJG5SLXJdPdLM5+JJSV6qDXhowhdgzoqg5YOksjxp74ppb74tTYNTGH
	 6afNCoeyui6dRjew6BkBHgcUA70gIx7NcN2otvjv5WbP06nkCixxLOFCSYrjGpva+1
	 goJCLpAahBUmI0it/yB+VLY5HLVFtI3tSdAXsn6g=
Received: from localhost.localdomain ([153.3.164.50])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 28B83A6E; Wed, 03 Apr 2024 10:10:11 +0800
X-QQ-mid: xmsmtpt1712110211t0yxkh2ev
Message-ID: <tencent_5E187BD0A61BA28605E85405F15228254D0A@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6vlv/ICY8TgGx/eAkz6B+6WYW0Fyip6dA9nbTAMktxVIHkJVNf7
	 /qgVBr13Tr0pnzOGDRUO+imITOgybbwGqCPCWx1l5sNIMBN030FXqhXIcuyCPy+U2wWLCA6Y//a1
	 X+pPp2bwvopAsl7+YcseK/bZ8YIL1a9WRUYfgUlFXDRjVvPnsCoRyXsywRCSygAeuh+rheiBjr8n
	 e3GNL44yiWYtMSA/z0QlB4oDUN3CZdZvxgQ8KwQ7DJ3lvcd5VWZOOGTJqtbLX2w5pvvRBdQz3/cF
	 6JfhQpgnlDxadKmaCtgFC0akIXzmR6cXopvN8zU/VhziGWk2GtFim2Rfz0OrXWaPeaxUvU0c0D5E
	 hTGv3imEXzbGBmgcQje1xS360PoFRhRCjMpPxpOHizK55Od5SaWMPWUJIQJIFJI6H+Daq7foK0k/
	 aOO84kOtSJySjk/AMDu5bMFlr8v+l3YnHf+HxMA80amXsbupS1R7Hi+eyUvv3XZX/5bcHzBGRII5
	 pPb92Nz+Brv/wOg4GIuwCiGh8DCi0sJQyJ17ruHxc3I5JhPGr+TDe157nPTfZfYT36z+JyG4GoOX
	 Tz7ctL6pYeksRLp6lNheZlbmMlt0ZtlkAFQpDy9Sfvt4Rr6G8fQUnZQ1G9AS2P+OtNGBswgWxNux
	 5JdGzlXVwbXJIiUKUrTmZgVob5nb7Luy2lelKBCuSrWqfoORJu0yBNWkzCu6smrYp3LhUD8KYVtc
	 cXTv/k/aReGTc2OuX9bRWa3kjQxhbxivFC3FUQTwBb+tbWZYPBBzK4XPMGRbfYZwEl4UyMZRTzjK
	 UoYWmeHxaeSrGvzXtYr7yoAEbMFTeoX74HQsXXcq0JwjDECWB7o5j0jyWGa6j9xs/LYnmLZdEWky
	 r45NTgljWNl6RmL1a7752NElIFnswoFi3tdvSXa5sN4YUa991fPARneISEx96bW/xisMfbH79Tml
	 b0hARrFd7tzRZfnYj6XdZt+gnkcJcGNlvWpYTG5Yq+w3qJcijaYl42u5My6mCsIhaor54BL9M=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/dcache: Re-use value stored to dentry->d_flags instead of re-reading
Date: Wed,  3 Apr 2024 10:10:08 +0800
X-OQ-MSGID: <20240403021008.47028-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the __d_clear_type_and_inode() writes the value flags to
dentry->d_flags, then immediately re-reads it in order to use it in a if
statement. This re-read is useless because no other update to 
dentry->d_flags can occur at this point.

This commit therefore re-use flags in the if statement instead of
re-reading dentry->d_flags.


Signed-off-by: linke li <lilinke99@qq.com>
---
 fs/dcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b813528fb147..79da415d7995 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -355,7 +355,7 @@ static inline void __d_clear_type_and_inode(struct dentry *dentry)
 	flags &= ~DCACHE_ENTRY_TYPE;
 	WRITE_ONCE(dentry->d_flags, flags);
 	dentry->d_inode = NULL;
-	if (dentry->d_flags & DCACHE_LRU_LIST)
+	if (flags & DCACHE_LRU_LIST)
 		this_cpu_inc(nr_dentry_negative);
 }
 
-- 
2.39.3 (Apple Git-146)


