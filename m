Return-Path: <linux-fsdevel+bounces-9718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6DF844932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8741F274BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369439861;
	Wed, 31 Jan 2024 20:53:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A8638DDB
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734393; cv=none; b=OzFzxpxousJNMnO53p9QtCN7HbQVjXThPUCe297kVi9ESJGuF5/NR1MXZbAvrTAe5RaiMx/m5f3e+wypU2NEcOi9kSwXId/0vNt+H5giSpAQooE2rXzYxs9ELxVrveuutvaykg4Jvb0VfCLBCmzN6K5R4rOnPa9NXcXjX9Xwobk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734393; c=relaxed/simple;
	bh=a9xeRjxhwBRpDypO6xyQ/fsqW9JHBu84hagwRacOxZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHJBlVwT1m2jR0YzG5jugGxjGLQ/sxx7skpSre8/YCX/j+Pz5gU5RYXnAabUQEBS/QAUuxL0BHX+hRargzPRiFrDIaIxLagdrLKcOCAitfT1OcdXCQL51KtmvqkkQ6XjSd2CEfPm9noTMuG/0efXHnQDZ7AUgDyG+BCG/cA2YUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso219247a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734392; x=1707339192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRbR4tcw6ZmMdKHBUsp7le5LvEzpVmQE81VD12TX0W4=;
        b=PRW5S//r8m+xFKT0LNs/MySEyOOj1poNdpzqkQQofhpQyQ/dvnooKs2O9DrlkVG9GJ
         R2mZ7lbMS7otsSVgfPtzQgPSyCaGRKWTAAMxZhKSnBgj8E5eOWw+9OZvztcNNu3Smk4X
         QvIS2KECu8PZMDAQiCkauU6X1miE41xW+L71AJ1t9ghkTYCdf7AIAwjGVjltTDsxiiVh
         lZuBLt2Y69hUbpY3iqpnyni2O9PuBke6NqJAl8E09Liw8QtBKgMNRoq3tlS/hfHvp017
         +qVqCL+IsmbuN1/gylLVLxT5PhSWLZT9dHEfAFySKwkkKPB2GHHIjH4cn0e4Ov2kHeml
         9iCw==
X-Gm-Message-State: AOJu0Yyxj0oqhX/sHjJz5J7ebt8GVM1mDEdVz2cr5ej8eTIZ373NF368
	z5wk07Kyzl7URbJTuLWMe74d6xrGuRFpDVyp6bV/IHe0WF2zRGKm
X-Google-Smtp-Source: AGHT+IF5oFO5T4nJrK6PKziqvstfvoiCOlBsZDG1xx8iaqtYVG5qJ4LyL8So94WAi2GIDJZIvTmQCA==
X-Received: by 2002:a17:90a:b385:b0:295:ec45:9cd8 with SMTP id e5-20020a17090ab38500b00295ec459cd8mr2422981pjr.13.1706734391508;
        Wed, 31 Jan 2024 12:53:11 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090ace8300b00295fb7e7b87sm855977pju.27.2024.01.31.12.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:53:11 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5/6] fs: Propagate write hints to the struct block_device inode
Date: Wed, 31 Jan 2024 12:52:36 -0800
Message-ID: <20240131205237.3540210-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240131205237.3540210-1-bvanassche@acm.org>
References: <20240131205237.3540210-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Write hints applied with F_SET_RW_HINT on a block device affect the
block device inode only. Propagate these hints to the inode associated
with struct block_device because that is the inode used when writing
back dirty pages.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index fc73c5fae43c..cfb52c3a4577 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -319,6 +319,17 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 	inode->i_write_hint = hint;
 	inode_unlock(inode);
 
+	/*
+	 * file->f_mapping->host may differ from inode. As an example,
+	 * blkdev_open() modifies file->f_mapping.
+	 */
+	if (file->f_mapping->host != inode) {
+		inode = file->f_mapping->host;
+		inode_lock(inode);
+		inode->i_write_hint = hint;
+		inode_unlock(inode);
+	}
+
 	return 0;
 }
 

