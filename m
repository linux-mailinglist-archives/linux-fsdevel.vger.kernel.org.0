Return-Path: <linux-fsdevel+bounces-30283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45FF988B76
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EEB1F241EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17821179654;
	Fri, 27 Sep 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="brfgxVOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FABA1C2449
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469959; cv=none; b=JCrOnNv2VJE0Y/1VHKgigx4Awj50kjdsL9Zeg9mMKcLZ9SM+dfwY2MoKHjvKDx7Guc8moNY72cZ27kt6npBmx6GXm3qPDEi4+ceSMLVZ8yVQw/0U0fkOv0wK5Yp4kXPndECSBHfXQXttZn0Td+bY7JdNupleHQyjXn5xUQsr+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469959; c=relaxed/simple;
	bh=/X4btuxiMxcMdVg5txBuKbMPLcmKuhHU9rTmuTsR6wk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQYUa+CdXa+v7jXDRO3FdfWDziFOt+7yEDFfkRooYi50imGgYcsRBEBJm2uqm6b0MuiJQ9A6BdAU56/HOXxuJmvu0xGygRzTQwlwf0bV3NfLU3c15zcvuYFH59RcbuQUlWLdIqkFBNlbUnRSnmOBcW/PdVSHg44WCIlKlKV4dC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=brfgxVOw; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e116d2f5f7fso2910439276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469957; x=1728074757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0K9wQJTZMdHk5RPuj5mV3fh+1GCFuX7VNn+gD+3fGs=;
        b=brfgxVOwFKgKQ15X6C4LzPgZ55ZmGxLr7b0NWkFuVVrWrFb72hzNa5VNBl77VR5wgC
         ek+rOLhEy4KJ11jiYYoy77wbuT0gwFjuFfoaIKfJ5mQPB3fwj1JnULRlGVBb6p/DAP2d
         7bWhsglF/oYkwmamO2dqGtgJRZtLYLJzgBHgJ4R/tJzq7M1k+dAFLr9g0I0vrn0TqWb7
         mQPxtzihSHJb1z6w5Vf15CoAMxb+0P56QcNbtZVF6o//CpV7m1Gt6msRtKt8FpgDBZm/
         f/B/UiK5zQIP/cd7BhX0E6xj2MdoJX0hPUNyLNLCQ6ThKDuM7UImM18KFJYiTSD/YjrK
         UWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469957; x=1728074757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0K9wQJTZMdHk5RPuj5mV3fh+1GCFuX7VNn+gD+3fGs=;
        b=TTsxRQvGg6WxjUQlLmHzrNqtJVO96pZNTGQ1A/60lpwU2bLPY20A0xgZLr2OSgfO2s
         fIMVkXdlaACmAcC5P0DkmWn92j4LmXUxaD0ZRbEu/g/PaycaxKUpu/i7tM3A1rFxiMgE
         BOJg1jpIlFd1IqVs0ZeZCFy4uZgbyQjqd9+9OTaW5jI1kBr5pEw1MUv6jto+Q1zhuHNw
         a8kEtcyYucNoB8P1Q0i6RAO4hDWYWztH9/TJYZwcESCgJS+85dfbH4dKctvWYgRnpVvZ
         q26XiVw4n5VuSG1/1ELB7tYvbJ3ym7X3CSUQEuNsiKpX3rjyHNeSwkqFQcjaGc2eFxU3
         kDmA==
X-Gm-Message-State: AOJu0YxbcdLf3dqnVkhyJADPE9IILz/1eRJhUhp5HJ6dSyQa8oCmDABI
	wM61wAZsWCHOxxlohPAaiuGiA0Otgz0Jti/vksl1BcIRJljkrwSoTGO/lEKKyOPBI8P6aco3ht1
	T
X-Google-Smtp-Source: AGHT+IHEOT+gbpWjlnphQaGIJw+BFPcdoGlY4ZPBdz2DOtjKmOCO0zCeAg5YYjuzYO+HJC3BZldx6A==
X-Received: by 2002:a05:6902:13c9:b0:e20:2da6:ed7e with SMTP id 3f1490d57ef6-e25e5d9c859mr3619933276.28.1727469956868;
        Fri, 27 Sep 2024 13:45:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e6c314f0sm602154276.54.2024.09.27.13.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:56 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Subject: [PATCH v3 10/10] fuse: convert fuse_notify_store to use folios
Date: Fri, 27 Sep 2024 16:45:01 -0400
Message-ID: <877bb686a99010b19778570591de923296626896.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727469663.git.josef@toxicpanda.com>
References: <cover.1727469663.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function creates pages in an inode and copies data into them,
update the function to use a folio instead of a page, and use the
appropriate folio helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4c58113eb6a1..5b011c8fa9d6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1654,24 +1654,28 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 	num = outarg.size;
 	while (num) {
+		struct folio *folio;
 		struct page *page;
 		unsigned int this_num;
 
-		err = -ENOMEM;
-		page = find_or_create_page(mapping, index,
-					   mapping_gfp_mask(mapping));
-		if (!page)
+		folio = __filemap_get_folio(mapping, index,
+					    FGP_LOCK|FGP_ACCESSED|FGP_CREAT,
+					    mapping_gfp_mask(mapping));
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			goto out_iput;
-
-		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		err = fuse_copy_page(cs, &page, offset, this_num, 0);
-		if (!PageUptodate(page) && !err && offset == 0 &&
-		    (this_num == PAGE_SIZE || file_size == end)) {
-			zero_user_segment(page, this_num, PAGE_SIZE);
-			SetPageUptodate(page);
 		}
-		unlock_page(page);
-		put_page(page);
+
+		page = &folio->page;
+		this_num = min_t(unsigned, num, folio_size(folio) - offset);
+		err = fuse_copy_page(cs, &page, offset, this_num, 0);
+		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
+		    (this_num == folio_size(folio) || file_size == end)) {
+			folio_zero_range(folio, this_num, folio_size(folio));
+			folio_mark_uptodate(folio);
+		}
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (err)
 			goto out_iput;
-- 
2.43.0


