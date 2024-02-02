Return-Path: <linux-fsdevel+bounces-10093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09A847A9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4243DB28860
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07F8172C;
	Fri,  2 Feb 2024 20:39:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DC7C6CE
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906396; cv=none; b=lDUILScEKXMBLDlR2Z293GydwH4LtqynyEpZ+u4Liz1UXlDxPohkUa17fIuGmtXWHlL6iHhPcKF+f0mtDI1K2StvqkOigIWY5CCTAZP4xOXbuDqQ4aHdMaiPqwtTox6pnQJOt10P+a5Ao+qPiQK25FWqa4qyUqqNcg3TrsXvt88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906396; c=relaxed/simple;
	bh=rN1qgUmr/T0syCmx7kkbGHIYOGFl1jyWjb1TKufdMCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEN82UaWvYugXqWme5O/GECn3SOPt3S+e2rSrciJJWcldKRC7oURzknWBDPkHUH2Ev4FyS4mODIljnB/loNPhLgBeiFmZ9NLhsr8eBVguvgdCThGkvfQ5yfDoYQPwL6xgvaiglh9OWW90zpqSZn+O+84zTNfm5kwcgYdg2qdiCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2053503a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906395; x=1707511195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SiZkNE1v6XzMx7eeMAJZVstqO211OcktCVNeMOZAwY=;
        b=xJPziBQJ+YJ/EA2NrrL+sM5Yaz516u7Md+OAj8hVClWWlnOjHk6JNp2BRUwKMuYIU4
         5C3o8uswJkn8wTgfzPbprQlExdhSaikDNYqpBQQuCSQJZ1TnouD3NR/d5RDgqygBRav6
         y8wb2ntjBdjnDuIakDSFznKWYeG6X1A9lfBUvTqJOFw89zp+RyUNfmhfkCMbED6H65k5
         sudhB0mVcQ39qWaSArI7sZMmA1kNp1WpjqxmnBmwjgJ4/zBct8zlNaNNzier2FxdtyaQ
         VYwapXmHkT7Iw29ZzNHzSh5NuKhOb7kNUHwhAEklSDurHcSaVo0r21SaMBaenZHoTKCU
         KI2Q==
X-Gm-Message-State: AOJu0YzyRzpUESONbB04UOjPjBVY2WltQcbhg6Tv+EEj5HbMaWAEn8XD
	rCom7kBeLvaq8Vi+g8Rn3XTu+t8+lmYQk2k94pT767XJLdTpnr0X
X-Google-Smtp-Source: AGHT+IE/ehT9S8XOB4W313tHi41jjWmAMJ8GypHaBU/yJ/t/Ljdm2u95PKJCBiKCSkBx4SoNSNeryg==
X-Received: by 2002:a05:6a20:93a7:b0:19e:4e58:5026 with SMTP id x39-20020a056a2093a700b0019e4e585026mr3429805pzh.4.1706906394779;
        Fri, 02 Feb 2024 12:39:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoW9o83NMK+HaZMvie+BLaf8jj7qq+AMOoD13R+HfjHRufNAYe1UYQHLG2FMW4cRmGB/aBuNOfBnj6oXjpaBaz/ZZHHR3tKGZjYYlqgOrqoNdIGuyqK/L3D/tskEUuJzELth1JizgeouM0n9QS8Yh5bifx1kIb3miwlfl44SCwpYvBOFfCZtTVAcw9P4ScVgtqdO3kxQSaEgE5aojmhfrmgC58HGTSZ0HKoEhMOx0WpLqLV897b6rVLtr/dWySnyJ0BvM8AdRerynFjXrpfqClSrwLdoY=
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:4cc3:4ab5:7d2:ddc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm2239678pgg.73.2024.02.02.12.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:39:54 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 5/6] fs: Propagate write hints to the struct block_device inode
Date: Fri,  2 Feb 2024 12:39:24 -0800
Message-ID: <20240202203926.2478590-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202203926.2478590-1-bvanassche@acm.org>
References: <20240202203926.2478590-1-bvanassche@acm.org>
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

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/fcntl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 00be0a710bba..8eb6d64a985b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -317,6 +317,13 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 
 	WRITE_ONCE(inode->i_write_hint, hint);
 
+	/*
+	 * file->f_mapping->host may differ from inode. As an example,
+	 * blkdev_open() modifies file->f_mapping.
+	 */
+	if (file->f_mapping->host != inode)
+		WRITE_ONCE(file->f_mapping->host->i_write_hint, hint);
+
 	return 0;
 }
 

