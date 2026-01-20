Return-Path: <linux-fsdevel+bounces-74750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JW6CYMQcGlyUwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:32:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A501E4DD73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF06FB0A713
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 22:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8C73E95A4;
	Tue, 20 Jan 2026 22:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcNQf6wY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9573D6672
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949475; cv=none; b=A1cWGogplkjDINEnjJo7+YAg8/tlgFSd38Nb/vIAfS5X8JL5jI8UhiS2LgSw2iQWpmL9pgCH330Qj1loFeG5t71RlgSXLowwlBzRWcA5MyS5ij5QNZE+rb57XmRjt0TvM9et3Ug5GO0z03hbpwBi+TANSJWwakuTz3v7IN8UlPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949475; c=relaxed/simple;
	bh=AYroCb1EO27QYVUUhrKBCM1sUq90eLOIaqujHAAtYm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iIp7tqHzh9/sbrUZXu9VBqOpmwJMyqRRMhKT+3STpNhQaafBt1hzeDouzXFexTlNh28rpkPDUMRMQKi9aJxkQkMUJJSblmhA7uGJ0nloZWPO2yk2sqb8BUeEjhDlKmWunl5qA0tietaxAgGkiC7ZVqHeTxLUKE/g4w95IM4RGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcNQf6wY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0c09bb78cso2330905ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768949472; x=1769554272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV1FLvl5FJPzRSys+Ts+xp9pJWexKByDE3N3YYQ82Tw=;
        b=YcNQf6wYfzxFjOEbdkeglqQ0wTaMcp8/tHnYTfMAsi6RK9d4uhvJ7ql9JCMTHvj+Gv
         J+WtmiJlgWjHQIXMHzerlF74tAU8ZbsaFyD1k/8plw4YfdSxGTE5nBZiDDorUHJZli+e
         HXSQ+90oRIYFRfNB5iL2yIfRW88lMYZvDt7Xs9tbROJkyzvOWt99ZoXl7dXfH8WYrZiO
         Z3ojrd9ydob+k03xwguLI3ba98rjilTAX7oSwNyLZZqLopjXekAAJ8KaKkuwLxjLaIuZ
         5ITVPHr4DJrF9GmPXAznZrjMw5jAT1ZTFUREibhfjUwRBaYHJ72hzcjPFfUhpuKaijjo
         8t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768949472; x=1769554272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wV1FLvl5FJPzRSys+Ts+xp9pJWexKByDE3N3YYQ82Tw=;
        b=jU3soNFUcxD3pKNpW8WYBtwYc8yP2NI4RkKpC/XhZtZP/UeQLIYmFH5HczRCmwz7/T
         KLGB9xXpR6hdAwvtMohF4jleuzZP/icc166as8KkxxH9suSHmXrSkIdH1qnfjxp1ajX9
         SnCgFl+8glkpuZGUvfbHpYXWTD1QRUDyCgotw6TxfK1QzHhVh2yPQjbtSJkFv6bYAUcB
         I6KBxAN2x0P8NZQsRiyk2TZ7DJSfMkrTbvgOsoXdl/nIlud0hwL1tpRbbyECulP8vS6K
         awgyAPhwR36Q2/WZfpBBXnpEKYKxcclD9Cb59GTd8ghjbJ7ITQUTNwrgeIv2NB7HJn0z
         8avw==
X-Forwarded-Encrypted: i=1; AJvYcCUQbTlZkwjLHTaNVjhPZe1Ygq6kPVISSy1RxCMmVBKdinctk/uvMCrSRhPgObrPwToY8CpbmKXllaYnbFdq@vger.kernel.org
X-Gm-Message-State: AOJu0YzmNOKBqwi7coodveUeKf9VFHNFBSKrK82806dM6/mCg/9fPI17
	2LjPfyFnVxNE7Z5FX01FdRjfkIaN/89fxXZbbmtw2guWtLiVBpmgNu4N
X-Gm-Gg: AZuq6aJwX17KR/CNpZcL82wf4AvRF+39wIhzkR38meEmCMU99HHdb0fQzg3VsrZIw99
	8eKIl+ATJ6UMaHO5B6WqCF4ad+aShu3ZEVHOd0KVdMh7WVhIMvRMT0WRECu4+Z+qfPGaM440zGc
	c7XkPBFe1wGNxY1txWl2SZiyqH4htKTLURd3eKnlOuCD3MH42+yoNu6v6Q8kAXgb6Tj/mdB6YWS
	jjNbV6rN5Xr1IMLc9spbd1Jg8ABRp6cxdJfQkiN0nN5hmRpiWhLRdFy65+BSYtUPzeR3iSkC9WF
	YR3MBmtVquQlYtmLGdoAqDuJuB5w8Mj/9wmmboal2K8zwyG6RdKQt5HY7AP06ngXIdmaPWp+Uqd
	ZhLzUOPplS+sn7hWBRxnbMjtAvSx6OzIdEWq4+v9fI5PVy29A0lqqc6Xnzv2bHdI5IOCvy9uEx6
	s2uXchJg==
X-Received: by 2002:a17:903:41c4:b0:2a7:80bf:3125 with SMTP id d9443c01a7336-2a780bf31eemr19147145ad.13.1768949472108;
        Tue, 20 Jan 2026 14:51:12 -0800 (PST)
Received: from localhost ([2a03:2880:ff:1d::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce693sm117758015ad.36.2026.01.20.14.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 14:51:11 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: jefflexu@linux.alibaba.com,
	luochunsheng@ustc.edu,
	djwong@kernel.org,
	horst@birthelmer.de,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/4] fuse: simplify logic in fuse_notify_store() and fuse_retrieve()
Date: Tue, 20 Jan 2026 14:44:47 -0800
Message-ID: <20260120224449.1847176-3-joannelkoong@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-74750-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,alibaba.com:email]
X-Rspamd-Queue-Id: A501E4DD73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplify the folio parsing logic in fuse_notify_store() and
fuse_retrieve().

In particular, calculate the index by tracking pos, which allows us to
remove calculating nr_pages, and use "pos" in place of outarg's offset
field.

Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7558ff337413..9cbd5b64d9c9 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1765,10 +1765,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	struct address_space *mapping;
 	u64 nodeid;
 	int err;
-	pgoff_t index;
-	unsigned int offset;
 	unsigned int num;
 	loff_t file_size;
+	loff_t pos;
 	loff_t end;
 
 	if (size < sizeof(outarg))
@@ -1785,7 +1784,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		return -EINVAL;
 
 	nodeid = outarg.nodeid;
-	num = min(outarg.size, MAX_LFS_FILESIZE - outarg.offset);
+	pos = outarg.offset;
+	num = min(outarg.size, MAX_LFS_FILESIZE - pos);
 
 	down_read(&fc->killsb);
 
@@ -1795,10 +1795,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		goto out_up_killsb;
 
 	mapping = inode->i_mapping;
-	index = outarg.offset >> PAGE_SHIFT;
-	offset = outarg.offset & ~PAGE_MASK;
 	file_size = i_size_read(inode);
-	end = outarg.offset + num;
+	end = pos + num;
 	if (end > file_size) {
 		file_size = end;
 		fuse_write_update_attr(inode, file_size, num);
@@ -1808,19 +1806,18 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		struct folio *folio;
 		unsigned int folio_offset;
 		unsigned int nr_bytes;
-		unsigned int nr_pages;
+		pgoff_t index = pos >> PAGE_SHIFT;
 
 		folio = filemap_grab_folio(mapping, index);
 		err = PTR_ERR(folio);
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
-		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
-		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+		folio_offset = offset_in_folio(folio, pos);
+		nr_bytes = min(num, folio_size(folio) - folio_offset);
 
 		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
-		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
+		if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
 		    (nr_bytes == folio_size(folio) || file_size == end)) {
 			folio_zero_segment(folio, nr_bytes, folio_size(folio));
 			folio_mark_uptodate(folio);
@@ -1831,9 +1828,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (err)
 			goto out_iput;
 
+		pos += nr_bytes;
 		num -= nr_bytes;
-		offset = 0;
-		index += nr_pages;
 	}
 
 	err = 0;
@@ -1865,7 +1861,6 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 {
 	int err;
 	struct address_space *mapping = inode->i_mapping;
-	pgoff_t index;
 	loff_t file_size;
 	unsigned int num;
 	unsigned int offset;
@@ -1876,15 +1871,16 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	size_t args_size = sizeof(*ra);
 	struct fuse_args_pages *ap;
 	struct fuse_args *args;
+	loff_t pos = outarg->offset;
 
-	offset = outarg->offset & ~PAGE_MASK;
+	offset = offset_in_page(pos);
 	file_size = i_size_read(inode);
 
 	num = min(outarg->size, fc->max_write);
-	if (outarg->offset > file_size)
+	if (pos > file_size)
 		num = 0;
-	else if (num > file_size - outarg->offset)
-		num = file_size - outarg->offset;
+	else if (num > file_size - pos)
+		num = file_size - pos;
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
@@ -1907,31 +1903,27 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	args->in_pages = true;
 	args->end = fuse_retrieve_end;
 
-	index = outarg->offset >> PAGE_SHIFT;
-
 	while (num && ap->num_folios < num_pages) {
 		struct folio *folio;
 		unsigned int folio_offset;
 		unsigned int nr_bytes;
-		unsigned int nr_pages;
+		pgoff_t index = pos >> PAGE_SHIFT;
 
 		folio = filemap_get_folio(mapping, index);
 		if (IS_ERR(folio))
 			break;
 
-		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		folio_offset = offset_in_folio(folio, pos);
 		nr_bytes = min(folio_size(folio) - folio_offset, num);
-		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 		ap->folios[ap->num_folios] = folio;
 		ap->descs[ap->num_folios].offset = folio_offset;
 		ap->descs[ap->num_folios].length = nr_bytes;
 		ap->num_folios++;
 
-		offset = 0;
+		pos += nr_bytes;
 		num -= nr_bytes;
 		total_len += nr_bytes;
-		index += nr_pages;
 	}
 	ra->inarg.offset = outarg->offset;
 	ra->inarg.size = total_len;
-- 
2.47.3


