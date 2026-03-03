Return-Path: <linux-fsdevel+bounces-79184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBONGX7Cpmn3TQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:14:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80E1ED8D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 12:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3426231208E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8772A3E3D9E;
	Tue,  3 Mar 2026 11:05:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D373C3C02;
	Tue,  3 Mar 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535921; cv=none; b=gwYb0REnt2qS3jlCY1MNppULxYBi7S1iym8S3oHWVicK5xxhHTtNL5MsBdFYIGY9YzfClnRqDS2ZH3zqVYdDa/3G8VVjD37pXz+6ymrDucHp/VXUhQocGj36xWrvqkLiK5vtf8TApjm+3e3vYkZwjTkOd1c3AGhq5f0n8QmBsVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535921; c=relaxed/simple;
	bh=5SXMiqNXjstBsPZB4qRMHa8k5bfBUk0bxZ+NJlNJHjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZpoQ5QAWaMWNRyogflzApCe/Bw4B/RwNoZp7gNeIGY7E9ucbiYBBGvFt+AMXCzffQi83GU0DvQv4BxYWkoH0HncqHookp2WTox83H68nLIrU13w6O1GhwkwHBgZswB4rbF6uLRPTEWsbiWWD6CIynNSVdTgUT8nl+hHASYic28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69a6bf0e-c2c6-7f0000032729-7f0000019cba-1
	for <multiple-recipients>; Tue, 03 Mar 2026 11:59:26 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue,  3 Mar 2026 11:59:26 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: Philipp Hahn <phahn-oss@avm.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exfat: Drop dead assignment of num_clusters
Date: Tue,  3 Mar 2026 11:59:15 +0100
Message-ID: <36b3573bb3e4277ad448852479f2cfea7a8ba902.1772534707.git.p.hahn@avm.de>
In-Reply-To: <cover.1772534707.git.p.hahn@avm.de>
References: <cover.1772534707.git.p.hahn@avm.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: FRITZ! Technology GmbH, Berlin, Germany
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1772535566-04D8BF88-94FC74DF/0/0
X-purgate-type: clean
X-purgate-size: 648
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: BC80E1ED8D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79184-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.912];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-fsdevel@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:mid,avm.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

num_clusters is not used naywhere afterwards. Remove assignment.

Found by static code analysis using Klocwork.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/exfat/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 2fb2d2d5d503a..d17ef2f9a7e2b 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -213,7 +213,6 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 					return -EIO;
 		}
 
-		num_clusters += num_to_be_allocated;
 		*clu = new_clu.dir;
 
 		inode->i_blocks += EXFAT_CLU_TO_B(num_to_be_allocated, sbi) >> 9;
-- 
2.43.0


