Return-Path: <linux-fsdevel+bounces-74749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJIRC8EJcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:03:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C38D4D718
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A68CB094C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A3B3ED11B;
	Tue, 20 Jan 2026 22:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUiAqTJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC2340282
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949474; cv=none; b=UUxpF6FHTGDsNGn8GK5o6PHsB/FVtgrigiji9jCoWxvg8Pl8WYBXxgaot1FQjDK3AtIK2ac3YDJYG7zdcxH+rJZvCRBhSteeoatH75hdomm7p1kfH+tE6EGboJm7lpmC/gkCW6X2QudTzOMVcWbGdAh/ZBvTVy+SQr2pMPpwP4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949474; c=relaxed/simple;
	bh=VzRQCGM50J+njlqf0011QAIVfAQBYeek6DQj7029zbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsGBzzf+HB7nN4axfkagsOTPmGCbXwSyPpa1bmMbZf8SVX/KQlpicvg5aYq5yyM6eaBJh2OVDtqqCTL19+t3GhfRREngqbc0xll0sBLdEj5rh5ZpiM9UuJB30YGUnpn2y2NeHh7desdbGA/HaUqBAlB3jCUpAED8X0mcKCtvyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUiAqTJ4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d6f647e2so57549825ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768949471; x=1769554271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQbxnbG+/XuiOc2+4QYnbBxa06J/G5CPY6EhR06mV7s=;
        b=eUiAqTJ4tv8a6WO8d+FluxrfW+8o/IWBAgrJNbR10OThRHJbvgcj39Kk8ItOVUJ03j
         b0HqlPu/Pl6CYM6FFGtzYbTP2OddgR9hWfjuh6Kd/A/0olhlwSdG/+yE/WP/iKa9/Q9w
         eUFcO8oNkLLotij2V/mGp/+AGDK3xP6sGhGo2jS7wKnj/gEKTMX3TPHAf8BjqGuDWROo
         79S+nxejWLiL4hUMFhpRu8aq+C/QKmWuLquNZPp2iSmIx5cOruRjoBFLQD0CADjyYzbh
         tAYogYWlnjJ2sH/e/gevDG6Zz/2x9RDuX5Zya9AwTwnou4r2JwPNrAe8Cg7TkPz/hWLR
         9F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768949471; x=1769554271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bQbxnbG+/XuiOc2+4QYnbBxa06J/G5CPY6EhR06mV7s=;
        b=rc1bpdRZ9denduXTSXnu2CkqgaUTJAiFh6LAGJvpjN98kMxGVKxZd5hUT/VXaALOaq
         ES5pGNlGrCtyvbo7XEei2AHoS/5yPxZqUsncOQBnS9i8GAkcb3hRGzFYOc4R+FlRC/ng
         /12B5sMfT+3BA7xpbLvtgPjKUk2h0T+fJW/v6eDNsyJYJFeX2LYea3PQLOw+NwpN2ZMo
         xriBqN8FYMXAGn4UU6XVtTqSiFDk3cfECbXrA2A1b8Ayxgx6rPIxU4QaTshhjEUYhfYY
         ZomjIxajFh4fS5FGIuwntRD87VaExaw61jkHfWmHJyemFYwPOexNqhbc4J2rGYXyH7tz
         xNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT7dY40HlgLUakFhCERXzUjeoP18ID4XDvEkssoNW/oLD59OEmhuA+aK1XVEgkrcb66zoWKCOd+sh0EQA0@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFPABkeITlPKWycqmV68ob/fUktm+A23NmyiMKjnttjqudskl
	a36Wnl2MvdCvvePmzFlFFJXs4OrusiUnbXd6Z/oZu90XnFMdAxqcX1Bm
X-Gm-Gg: AZuq6aK2yaHZ0auHVzjQj5Eu6v+Z9Zzz83LQ48CMDFpMNfZSmU45eLAp9a+BdrAVL8l
	aiZLFwxFBy+HxIqkhSAcM4P+o10CA47MAZ+tOoWx3DrvnMCqC3ZzvPmyYybHPpgev43PsjY9UeG
	XNBVZRNQgR/nn9EpSXO87cNfds5tKPCjwRItfA82mA+WTDURjRY/ESVnJ1g9AenmT2dN+8ML6UH
	88JsCHYpuI0JMGWwb1ilBfSdo3Q/hCCeAC/IHDAQPaGLfjaVPDbxUlR7ncZ/VPl3TFJtN+ShC21
	AWnWw1fMzd6mj1lblmCHcLNmLjOxCjLzIpHYYNEMLeckjFabQqy6IrbttvjIUR2yNAiNAO9CjM/
	ZP0Q6M/UB5Xech6b23JL8iGJtFN4DhdZlXim1p4wpJ64UTjqt2jqK/bxeINtSWgMuwne6MH1nCc
	fbfleZ6Q==
X-Received: by 2002:a17:902:da88:b0:2a0:c5a6:c8df with SMTP id d9443c01a7336-2a768d751a1mr29621345ad.21.1768949470640;
        Tue, 20 Jan 2026 14:51:10 -0800 (PST)
Received: from localhost ([2a03:2880:ff:56::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190d14cfsm135166585ad.38.2026.01.20.14.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:51:10 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: jefflexu@linux.alibaba.com,
	luochunsheng@ustc.edu,
	djwong@kernel.org,
	horst@birthelmer.de,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/4] fuse: validate outarg offset and size in notify store/retrieve
Date: Tue, 20 Jan 2026 14:44:46 -0800
Message-ID: <20260120224449.1847176-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260120224449.1847176-1-joannelkoong@gmail.com>
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74749-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8C38D4D718
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add validation checking for outarg offset and outarg size values passed
in by the server. MAX_LFS_FILESIZE is the maximum file size supported.
The fuse_notify_store_out and fuse_notify_retrieve_out structs take in
a uint64_t offset.

Add logic to ensure:
* outarg.offset is less than MAX_LFS_FILESIZE
* outarg.offset + outarg.size cannot exceed MAX_LFS_FILESIZE
* potential uint64_t overflow is fixed when adding outarg.offset and
  outarg.size.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6d59cbc877c6..7558ff337413 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1781,7 +1781,11 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	if (size - sizeof(outarg) != outarg.size)
 		return -EINVAL;
 
+	if (outarg.offset >= MAX_LFS_FILESIZE)
+		return -EINVAL;
+
 	nodeid = outarg.nodeid;
+	num = min(outarg.size, MAX_LFS_FILESIZE - outarg.offset);
 
 	down_read(&fc->killsb);
 
@@ -1794,13 +1798,12 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	index = outarg.offset >> PAGE_SHIFT;
 	offset = outarg.offset & ~PAGE_MASK;
 	file_size = i_size_read(inode);
-	end = outarg.offset + outarg.size;
+	end = outarg.offset + num;
 	if (end > file_size) {
 		file_size = end;
-		fuse_write_update_attr(inode, file_size, outarg.size);
+		fuse_write_update_attr(inode, file_size, num);
 	}
 
-	num = outarg.size;
 	while (num) {
 		struct folio *folio;
 		unsigned int folio_offset;
@@ -1880,7 +1883,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	num = min(outarg->size, fc->max_write);
 	if (outarg->offset > file_size)
 		num = 0;
-	else if (outarg->offset + num > file_size)
+	else if (num > file_size - outarg->offset)
 		num = file_size - outarg->offset;
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -1962,6 +1965,9 @@ static int fuse_notify_retrieve(struct fuse_conn *fc, unsigned int size,
 
 	fuse_copy_finish(cs);
 
+	if (outarg.offset >= MAX_LFS_FILESIZE)
+		return -EINVAL;
+
 	down_read(&fc->killsb);
 	err = -ENOENT;
 	nodeid = outarg.nodeid;
-- 
2.47.3


