Return-Path: <linux-fsdevel+bounces-19174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087748C1005
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 14:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA1D1C221F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B9C13B5B4;
	Thu,  9 May 2024 12:57:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793D147C72;
	Thu,  9 May 2024 12:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259446; cv=none; b=cUerYtyR6K9d22ttYGdiYDMmlSG4J/IrW531XpWdsl7ZRUP4zSH+IBtqGcYYvQM3GZ74H5SsGlA900HoQB5pBbdlC6LZWGFugIfqrBRjq5L1MqArxvtZ77LHcHkfbBA+WRBWw7r/7iQJ7QXYoDLbUcui2D35VEqljhgqE3s81mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259446; c=relaxed/simple;
	bh=mYMjMEAUKh44Zl6t2hYm68iMO3BZjSBLKzOpqis9l8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gl9VQBe/ciIpzl5YesKNmN7a9TR++OcF/WI6D777896dPTs7HWICihz6CbojSY3XMakrxD+67ma0LsnZ07Pd9lN9BRyYMH4LcTIZE7iRpo7dPwrOfTKo9H+fqy6Fpd9CtUfIWEhVWN5c/wIc5UTBNHT5LuTO0PqBswUN8inm/LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so1538116a12.0;
        Thu, 09 May 2024 05:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715259443; x=1715864243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tj5n/47UwDomI75HyIwdPYAf/haThSqq9uY0sQZVmo=;
        b=WL/msjGFt7tIsnOiVfgbh8fmawJWXJQBVDj/u9EoN0pZpkyj8fJie3ruO9SanMpG6s
         wptmjNptEdqx8ARVQn6CSCIBf7g5/eedOypirIGVxz/DLNbLGJDPVq9GTyncXtuFJIoS
         NgWRbO82HaEQBW1JaUMgQZuVYguLF4tVrFMSkit/plHDFgx2WvOFpPywgMeRJvNO+gvd
         1de0EI+JE1pWsrrbOuT3riWCk0hXXQcNEg2AXO62cBJ/wRl86QlLDHonOhkX4OA5Ezo5
         ZnRQFJyAmwWYYWQQJ0lQ9dM4u3w/9PPw0W6NhE3iGHM603JnXhDWWnmCEoaY3x+otosh
         SNfw==
X-Forwarded-Encrypted: i=1; AJvYcCVXEu6fUHTNTgdpBZNv83XN5X+WZ4ydItdtlnCBQ1ExLaWhaFO6my2WCaZOH0Nb5PP73kX/mL5DtvcOrbfbxUGBpWTVXa57jWqax4XpEkHpqwI+hmCQGBUUHKcw3e8R7EVUGjgazSC1iQk4qg==
X-Gm-Message-State: AOJu0Ywj4mFmjzcHnWeMoK0AL4/yBVCR2B0I34xZC+78RKCzQYpjjAc/
	0AEQmfkULG833qAWYxdcXvo9WbTBZeRKh3jP2imALi24UzD1YwN+
X-Google-Smtp-Source: AGHT+IFV2g5bUVgpaI72nMB9ictt4O/7oKOb6bfAnfLncyGvTqLaF03/IMUJiDAiP/OJLecumpuO+A==
X-Received: by 2002:a05:6402:1487:b0:572:99fa:1095 with SMTP id 4fb4d7f45d1cf-57332949554mr2155993a12.18.1715259443034;
        Thu, 09 May 2024 05:57:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfb83sm672852a12.46.2024.05.09.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:57:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: paulmck@kernel.org,
	linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fuse: annotate potential data-race in num_background
Date: Thu,  9 May 2024 05:57:15 -0700
Message-ID: <20240509125716.1268016-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data race occurs when two concurrent data paths potentially access
fuse_conn->num_background simultaneously.

Specifically, fuse_request_end() accesses and modifies ->num_background
while holding the bg_lock, whereas fuse_readahead() reads
->num_background without acquiring any lock beforehand. This potential
data race is flagged by KCSAN:

	BUG: KCSAN: data-race in fuse_readahead [fuse] / fuse_request_end [fuse]

	read-write to 0xffff8883a6666598 of 4 bytes by task 113809 on cpu 39:
	fuse_request_end (fs/fuse/dev.c:318) fuse
	fuse_dev_do_write (fs/fuse/dev.c:?) fuse
	fuse_dev_write (fs/fuse/dev.c:?) fuse
	...

	read to 0xffff8883a6666598 of 4 bytes by task 113787 on cpu 8:
	fuse_readahead (fs/fuse/file.c:1005) fuse
	read_pages (mm/readahead.c:166)
	page_cache_ra_unbounded (mm/readahead.c:?)
	...

	value changed: 0x00000001 -> 0x00000000

Annotated the reader with READ_ONCE() and the writer with WRITE_ONCE()
to avoid such complaint from KCSAN.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/fuse/dev.c  | 6 ++++--
 fs/fuse/file.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3ec8bb5e68ff..8e63dba49eff 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -282,6 +282,7 @@ void fuse_request_end(struct fuse_req *req)
 	struct fuse_mount *fm = req->fm;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_iqueue *fiq = &fc->iq;
+	unsigned int num_background;
 
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
@@ -301,7 +302,8 @@ void fuse_request_end(struct fuse_req *req)
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
-		if (fc->num_background == fc->max_background) {
+		num_background = READ_ONCE(fc->num_background);
+		if (num_background == fc->max_background) {
 			fc->blocked = 0;
 			wake_up(&fc->blocked_waitq);
 		} else if (!fc->blocked) {
@@ -315,7 +317,7 @@ void fuse_request_end(struct fuse_req *req)
 				wake_up(&fc->blocked_waitq);
 		}
 
-		fc->num_background--;
+		WRITE_ONCE(fc->num_background, num_background - 1);
 		fc->active_background--;
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b57ce4157640..07331889bbf3 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1002,7 +1002,7 @@ static void fuse_readahead(struct readahead_control *rac)
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
 
-		if (fc->num_background >= fc->congestion_threshold &&
+		if (READ_ONCE(fc->num_background) >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
 			/*
 			 * Congested and only async pages left, so skip the
-- 
2.43.0


