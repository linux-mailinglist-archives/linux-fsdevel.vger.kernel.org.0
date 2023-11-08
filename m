Return-Path: <linux-fsdevel+bounces-2352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A0B7E4FC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 05:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C61C20D8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 04:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77FBCA63;
	Wed,  8 Nov 2023 04:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp1xYs8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7459C8CC
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 04:46:05 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147629C;
	Tue,  7 Nov 2023 20:46:05 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc4d306fe9so13908995ad.0;
        Tue, 07 Nov 2023 20:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699418764; x=1700023564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AccMyh+RlaZEsXK1ML+1emsIzpOUjcybMBaau+EZXEI=;
        b=kp1xYs8KSwaefefmuV50oj4qLTm2LOIdOUcEqGCQ9dJ2AxLv4zBnlw2i9TEVacpbF2
         XOg1LKZa8AmXXFsEoWKgsXHjMmJucPutWDNI7M9P1AH6CrM3b8jEKdzmHCDGjlxhmJRx
         Z7p6bVRGzAxmWeO/2f6AROL+7GLBPCcD3uAcCDth4pAw2ZiRx8OD+j0oDaaDI7bEx8rp
         TSRbBNnK70+7EuwaT7yprSQQSrL6dv+QzXRooN3CDyToInfuJMpTpOyTnrs7sbUKqgpP
         AMHAmwuWVlH2KXs8zzSOCziWFWk+/T3jPT8Ou8tU9HGD/yt8IeH16Sv08509lBghKW09
         Wtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699418764; x=1700023564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AccMyh+RlaZEsXK1ML+1emsIzpOUjcybMBaau+EZXEI=;
        b=F6JStSv5bUuLt3MXMMofvAMbVlyH84X7wlioYEsbr2W3k+VwLxqk+h906bDmSkHQft
         rb5BHgQPSBa1Ncpk1fa5SGq0i2iJdTHJKcaWy1tul/SWLaevKSdbE+VQLSwaLC57ybti
         Sv3hj295q0KsRs8Gc1Bfwqn8w9YkSs1bsIs8QJCYekA3qzIUvxsZOw6uqZJ952q7F1v5
         2rPYaYDjcjlFofzMowhgwSFpJaLe6avBb4Q3o+JPO+64XgcvJVvyL9K+Qr7RIqOH9K/W
         UzY+ofgH63WzXDhniCg2m1vCRs298zGIZQB6+c79+sPbLE6JbU3Nqpx74BxP6X+a4h9U
         HTRA==
X-Gm-Message-State: AOJu0YyrWOEtTsC8ujNC3R5Q6xaV/1wJ0Sv/IafqcgbQEyxGcQbMWMRG
	C0aMJzJ82ujJ9boxGJqeAc8=
X-Google-Smtp-Source: AGHT+IHTBdEucosqnOg7K+garwd4Fwx8/Q/fzzgOpu7ehbtJq8I2JmalwcBjZ5QvjkrmGKJFEj/H8g==
X-Received: by 2002:a17:902:d2c4:b0:1cc:277f:b4f6 with SMTP id n4-20020a170902d2c400b001cc277fb4f6mr1000152plc.6.1699418764403;
        Tue, 07 Nov 2023 20:46:04 -0800 (PST)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id n15-20020a170903110f00b001cc32261bdcsm666079plh.248.2023.11.07.20.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 20:46:04 -0800 (PST)
From: Abhinav Singh <singhabhinav9051571833@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	dan.j.williams@intel.com,
	willy@infradead.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Abhinav Singh <singhabhinav9051571833@gmail.com>
Subject: [PATCH] fs : Fix warning using plain integer as NULL
Date: Wed,  8 Nov 2023 10:15:50 +0530
Message-Id: <20231108044550.1006555-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sparse static analysis tools generate a warning with this message
"Using plain integer as NULL pointer". In this case this warning is
being shown because we are trying to initialize  pointer to NULL using
integer value 0.

Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>
---
 fs/dax.c       | 2 +-
 fs/direct-io.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 3380b43cb6bb..423fc1607dfa 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1128,7 +1128,7 @@ static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
 	/* zero the edges if srcmap is a HOLE or IOMAP_UNWRITTEN */
 	bool zero_edge = srcmap->flags & IOMAP_F_SHARED ||
 			 srcmap->type == IOMAP_UNWRITTEN;
-	void *saddr = 0;
+	void *saddr = NULL;
 	int ret = 0;
 
 	if (!zero_edge) {
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 20533266ade6..60456263a338 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1114,7 +1114,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	loff_t offset = iocb->ki_pos;
 	const loff_t end = offset + count;
 	struct dio *dio;
-	struct dio_submit sdio = { 0, };
+	struct dio_submit sdio = { NULL, };
 	struct buffer_head map_bh = { 0, };
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
-- 
2.39.2


