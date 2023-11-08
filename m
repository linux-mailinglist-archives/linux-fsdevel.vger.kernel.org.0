Return-Path: <linux-fsdevel+bounces-2384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D881C7E5462
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BA21C208CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 10:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3A14F85;
	Wed,  8 Nov 2023 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GwFfXdtI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5E13ACE
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Nov 2023 10:47:53 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873C4C34;
	Wed,  8 Nov 2023 02:47:53 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6bd20c30831so1253907b3a.1;
        Wed, 08 Nov 2023 02:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699440473; x=1700045273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbWdFo7miza+LJDE+FII5IkRlW+z6I8tgEOAp/fAi2E=;
        b=GwFfXdtI3flLgMpYFmUw+vDgxlxNNeJwujMESIjPeXEF2zIbAPoI/V8pm3Hh8/2aCW
         jPKK/gUPhWsXSfOBnjtcXmP4FEvYmncwk5qYdPRrXKDdKeC1Eoe+LvYvXRIj/XFFUBjY
         XTXhGTllhMcc1l4983UMzv/XgKm6DUF6glbm6S1AyjbKbj/q0/M7NmJkwuj3mlmlZwxc
         W2Vr81KFTIn+hC7J9E0w1aN/Gtud5RTsn26631boJwOwsV40I1I6k1gcaScPzg/E/HCO
         Z7SkPOZhufa861+h4KYBmjNSXam6dqHPy0zktUtK5qhBq5z/rTnIeiOGgPCci/X0QmEu
         VQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699440473; x=1700045273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbWdFo7miza+LJDE+FII5IkRlW+z6I8tgEOAp/fAi2E=;
        b=HpVdu4Z020ZIYjDqzyPkMrRbNhVH/H1aqfrDCydwJ/5vBdyeKIHy8bw9cAXPEH80O7
         o1YRRch0vx0gt4w4o6Xm5Ncp7Np7kuePTW/rutoFkMT6sB2z1p0a07w1a2PoJpgppPML
         z2YMAajXTHCptJjeY6u/+Y3ML4YHhVyDKm3b4hR9Ae6tw7XL3cYtZsYd1eBWjSWXgKc8
         tQHzAEZAXRRumlmS5Z9906I6e6lQQnWhM/yh035DGt+TyvOwnxx7tKmOWf+niMGEG6y5
         tuyd+7aJA27iSmgtYA7VpRKhMIt2vrQaLs8bcqW0ogZbZ49OXYph7DK+Hl3PmiNbKDVJ
         SF0A==
X-Gm-Message-State: AOJu0YymcfQRLw8MHhHT+BJG0gzuTOkxjLcwv4qqe3i8p7+r2s6EvaV4
	YPRDyve1tUDAkCz5mEafBOE=
X-Google-Smtp-Source: AGHT+IEakTnfI52C8pPf0ICMAQ0OdKNwvumwvOelYpYlFppmk3T3eTha1MxYy4JkbmVoaKhG3s9jxw==
X-Received: by 2002:a62:ab12:0:b0:68f:c8b3:3077 with SMTP id p18-20020a62ab12000000b0068fc8b33077mr1611102pff.1.1699440472652;
        Wed, 08 Nov 2023 02:47:52 -0800 (PST)
Received: from abhinav.. ([103.75.161.208])
        by smtp.gmail.com with ESMTPSA id fm26-20020a056a002f9a00b00694fee1011asm8617933pfb.208.2023.11.08.02.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 02:47:52 -0800 (PST)
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
Date: Wed,  8 Nov 2023 16:17:30 +0530
Message-Id: <20231108104730.1007713-1-singhabhinav9051571833@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108101518.e4nriftavrhw45xk@quack3>
References: <20231108101518.e4nriftavrhw45xk@quack3>
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


