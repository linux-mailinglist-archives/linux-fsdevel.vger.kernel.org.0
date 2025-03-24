Return-Path: <linux-fsdevel+bounces-44885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7306FA6E0DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4011892458
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Mar 2025 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3EF264606;
	Mon, 24 Mar 2025 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K60BGnuU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3E6261596;
	Mon, 24 Mar 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837569; cv=none; b=GYijyf53espSP00wdVEkIwZ8koWshxvNqD6dW5JR9defH/4XiQ+XIM++vZaLpZy6iHz8nClRJiYsmRwiO5WSPycmjlfUqZMPZFYjdj0PzpL32fOTPx/9nPXxBCZ2EfWcI709iRmfpQTQko7xxYy7eHkZ/4EXssv0WbrsoLfk2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837569; c=relaxed/simple;
	bh=HXXm0dVfnMHkhVgi4tYT3nr41Hbzq9B55LlNyrxFu6E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZJq92mQIfsIlrCiqHfC6P/AAdWv+hRGospwwdhzoYOcThiDInWjExD83jd0Csjcpiz94nSFvP8pyI7Ue84vQfP6HW+P6O3PNtQjBlCTu0eJzeMozvVZZbYdft+/8kHNmZeHkPs/KaiwKmKGiEjRB1O8ETLvETnnB8J/kuXlxjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K60BGnuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F597C4CEDD;
	Mon, 24 Mar 2025 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742837568;
	bh=HXXm0dVfnMHkhVgi4tYT3nr41Hbzq9B55LlNyrxFu6E=;
	h=From:To:Cc:Subject:Date:From;
	b=K60BGnuUSyaee96EfMy4kudiGhhn68RP9nO9HNctuBAzVA3aQ2ifjqFLb9OlTbLMP
	 BFZBdqzovqbxY1ileJTg8xa8Qac4G4fIyfil51SqGRfvdTI6GvW1yvveThHg6Pld+w
	 NBv61npHWBeZy9IgLqWOf0CQ7U8F3N4zjQH48A6KQkR9LLJlLthlUMqygfKdmxykMQ
	 X9AWEX7az0Hr4iy3T30ZwQ8vqb+ZXf7SEALTgn2ie1JTEQl2K81aY8qsB37DwX8bi2
	 PO5+eAb057tqMp1CDobRJ2cihSABOnNZy8PCxmKyy0MUa3eQRpwwQScod9vyZcwfLA
	 v/oCrc9QHrqXw==
From: Arnd Bergmann <arnd@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] exportfs: add module description
Date: Mon, 24 Mar 2025 18:32:26 +0100
Message-Id: <20250324173242.1501003-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Every loadable module should have a description, to avoid a warning such as:

WARNING: modpost: missing MODULE_DESCRIPTION() in fs/exportfs/exportfs.o

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/exportfs/expfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index b5845c4846b8..8a5f42c620af 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -608,4 +608,5 @@ struct dentry *exportfs_decode_fh(struct vfsmount *mnt, struct fid *fid,
 }
 EXPORT_SYMBOL_GPL(exportfs_decode_fh);
 
+MODULE_DESCRIPTION("Code mapping from inodes to NFS file handles");
 MODULE_LICENSE("GPL");
-- 
2.39.5


