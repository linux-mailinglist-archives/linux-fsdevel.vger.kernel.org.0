Return-Path: <linux-fsdevel+bounces-78589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJh/IE2BoGn6kQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:22:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E391AC41A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8956530BECDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E144244B670;
	Thu, 26 Feb 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkKW0TcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898F426D18
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122172; cv=none; b=jyN/Hv6C6FPOdlG6vQjLqJu5oZtteS7Cn4e1uFn1VLRlNGhqz2zREov9j9HRpp6jU2Narg7+ze4zxzhHbeiTGzDdYYOWqdM3pGeYqBMDHn4OD+5eCvKBSJHVCjvMizcaftm7nSA8zEWM90ogAtarHcVvzsk2/fl41FC14quMAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122172; c=relaxed/simple;
	bh=mGwXJxQ8B9+61F8/VPcfgs6XYDIXRha1M1Q+adyZkxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfpoKEliWx0K324++UwK77B1+aeMUlllNt9WAu+XmdYHeXskqB6T8BorR+5DiQXhHUvRV10vQyZXIzQtmLoujK2mRmNAMkMbb+141K5VV3KKmntTjGWy6474jY+RJkBtR0ygcZt4khCRv/PZjdPN9CfhRV+Gmw5zuwyFi1AHicQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkKW0TcO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7986fb839f5so8960107b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 08:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772122166; x=1772726966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtssGMmgpsS0GlJdNGMxqurgMvcq6MJjd3dPtJY3SVc=;
        b=ZkKW0TcOoLZUPtOuXL19MBosyrwtx4L34DQfFdD5C7q5TXDyK6C7+6XBWMjR8Qx86e
         kfnTWsblnqP9PvI8cFL8GGdzTZfmTGPCGtheXsgac7wFIdnjSY5cpf9H8H5fvg2z4Uea
         h4tWyHKZyw5rl//4PEm+0H01LqRb4gTKEJqSyPOOcMnHrbEcw26UTStgYDCapS38GZ8b
         ni7W61YMVGoZftbs8l9o9q2UREPyFacfCIDgABVlRnvuYLdOSTuDwM1Dh4rsP2ffeyD3
         CCbGvzSoOCD8INuWeo/AOy+hewL6azcj+0E+zsAO3amX60gjjtAQ3tbY5D2DwGVMEJUT
         qWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772122166; x=1772726966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OtssGMmgpsS0GlJdNGMxqurgMvcq6MJjd3dPtJY3SVc=;
        b=F0vllCkeipuLtH9ps/CxF7f2uFMkTRaD4w/9rvX90HkxlXnC7oCS7YzBiOt14uc0yA
         7vjFMxCVRgChgsGpP+inxJ98/mk7f7jPIP5Qokpj/Zpt/bzcdoA93OhivIcRTdIfkfWL
         cQeRMPNqR7GW84kPb0SC4sI8iG5EIemmS7El9QLh9p/A8o5qLqntQ1zzuYoG8guYY+W0
         Ax8hvG+sF9cuuKqnCaNc2xiLvP4NLRnkciIayEp3oY8m/tomFwWv10dPph8kfAu5FSu4
         fzwEfKu8YY36X9MgFrgbDbiPAuVaMR1/XPrkh1aA2Dxer61qzb8yqz4Fpv3pEtL5Dr4v
         pEIA==
X-Gm-Message-State: AOJu0YxhSaDC/L6jX//434vTSJVkcpfUCmQDu2GTHzmo9RqG69omYrag
	75xuinMZzgu1/tq1fZU77kq8PLEowFfHmZoQxRSuZsfngnJzxQMWWk7tGNjAsC6x/uU=
X-Gm-Gg: ATEYQzyw9CZRzM9w2kFSB33TP4/EBSTB1LvL5nRslaqNlUkBW+Q8NVa1bId1SHwgOq8
	IOHK9O7DZ1tuZYwv3SfnceWn7c2emomYBhcoy/bQTe/p8/Pi0+x4jH9scuN0WVKOXtAtbKOR97+
	UQQ0s68aPIJQJmaEa9INY3gqAiJIg3QMcMqHaHEY7bHUdbNJBM5RvcNF/2jCwn2MinjwNyzfHRY
	zjeVyRQG+o2C0sOhbPQxZVQUEEpqwWfZlk5JZeqfs5k6cquJbNoFYrLeomVNyZve86jebmhsNh5
	0OpePfzscpgWVqp3Vwwf/VC6rCApnfQfAVr2gxq01hLPzt20koFK5uVPMWn6Kxo0CztQheoxxdW
	+OX8kyWj36aG41ndng6vZ209/AQ3QNiyAB7Vldq+NrtjLA/4zOZ3oXCFYjNRAgVOEFr5TO3NXG/
	stO+Qx6udBMSKuB1AidVxJnWEz7ud9HI7RKcBE/q5tBuhEY7hzML3Z17PvxiclPcaIseVdeMGTX
	ZqZiW2WX1jFBKLj/S9342ZL
X-Received: by 2002:a05:690c:d8a:b0:797:ddf2:7cac with SMTP id 00721157ae682-798291548e2mr177249357b3.63.1772122166458;
        Thu, 26 Feb 2026 08:09:26 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876cb9f19sm10225967b3.53.2026.02.26.08.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:09:26 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 2/3] ntfs: Add missing error code
Date: Thu, 26 Feb 2026 10:09:05 -0600
Message-ID: <20260226160906.7175-3-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226160906.7175-1-ethantidmore06@gmail.com>
References: <20260226160906.7175-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78589-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24E391AC41A
X-Rspamd-Action: no action

If ntfs_attr_iget() fails no error code is assigned to be returned.

Detected by Smatch:
fs/ntfs/attrib.c:2665 ntfs_attr_add() warn:
missing error code 'err'

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/ntfs/attrib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index e260540eb7c5..71ad870eceac 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -2661,6 +2661,7 @@ int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
 	/* Open new attribute and resize it. */
 	attr_vi = ntfs_attr_iget(VFS_I(ni), type, name, name_len);
 	if (IS_ERR(attr_vi)) {
+		err = PTR_ERR(attr_vi);
 		ntfs_error(sb, "Failed to open just added attribute");
 		goto rm_attr_err_out;
 	}
-- 
2.53.0


