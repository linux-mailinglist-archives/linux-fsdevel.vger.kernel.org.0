Return-Path: <linux-fsdevel+bounces-3193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA97F0F68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 10:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3041C210CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A17125A6;
	Mon, 20 Nov 2023 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyh/JBPr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219F88F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 01:51:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-407da05f05aso12459425e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 01:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700473875; x=1701078675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MZKc8pb/s+Fn8qCyGqru14gZ0/TpymXTT3FVYVlHlJQ=;
        b=eyh/JBPrVaryx13zjb1+u1NppPFocT1XtnvdGXjFtvzlvw/ZS9gDpBwnb/6JEiLayN
         SKWF98AO24EQrScIdG2Q5fGW/eQ8l10CD/2c0rQ1LwlurHXoXZ9LMo9TiGR6eF/sM06c
         XdSp1Vi6YS7VdFoWPuSJeR7/6519OigS9lGEx7tzx1HJHHQ9XcjQwvUcRGY74yjBv19n
         iN5jjKfp1DpLyZL1dc+s9T1JVrDuBO4GjR/mDUZukIjZbq/xG1+D7cCPyDbCDZGPYVGw
         4a3U31FhYNR8MKMUfGy8NyM2ggESSJWsv9EdInuENe+AArNa/x1rn4lkhwGMtCN/ecC+
         Qb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700473875; x=1701078675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZKc8pb/s+Fn8qCyGqru14gZ0/TpymXTT3FVYVlHlJQ=;
        b=CcB6Pr4GIyEJCFN4iUKmTyyn9TVr+ij/ERU8c8ZTLO7iKczmuFNUS5PnR+yQIyMq+3
         TCawKnPBy/VIiC9VkofJKQsCClqHGJd3ejV5/5XWj88emjUgAVoheilBmEdzNxJX27Li
         ZZCJ9KT5jHCaW0zJ3dtC4KhHlaMSH88nOFsO1x0fT8wgpB0L+EnyT8BydGE0A1Rp6ntd
         94ItN2cptbTBism3wr/AlHBFiHruyPd39LJ/ofHx3/NEf6+bSvWqDG7NX3k17B1+fi+9
         yK6gGkHELweqN4JarNIbaixHAFvZ2cXnvp8GNQGGUg+wTsuunM6xi+GXEiguWTEOrUjr
         IJkQ==
X-Gm-Message-State: AOJu0YyvRKRZONj4NZblv9Q/fsYawZ10YXaHU3yY1TlMOKpdBlx7sHuF
	z9L9iJlYI1YOiig5iWgOIjk=
X-Google-Smtp-Source: AGHT+IGxK186VBipWRshpRbl53kD1TkGs6yU5rV8nMg/wl4M8795hOnV3gFMtT1RMLOkvW6PW6x0bg==
X-Received: by 2002:a05:600c:4f55:b0:402:f55c:faee with SMTP id m21-20020a05600c4f5500b00402f55cfaeemr5513188wmq.26.1700473875178;
        Mon, 20 Nov 2023 01:51:15 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b004064288597bsm12934425wmq.30.2023.11.20.01.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 01:51:14 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] coda: change locking order in coda_file_write_iter()
Date: Mon, 20 Nov 2023 11:51:10 +0200
Message-Id: <20231120095110.2199218-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coda host file is a backing file for the coda inode on a different
filesystem than the coda inode.

Change the locking order to take the coda inode lock before taking
the backing host file freeze protection, same as in ovl_write_iter()
and in network filesystems that use cachefiles.

Link: https://lore.kernel.org/r/CAOQ4uxjcnwuF1gMxe64WLODGA_MyAy8x-DtqkCUxqVQKk3Xbng@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Jan,

Can you please ack this patch so that I can add it to my series
and send to Christian?

Thanks,
Amir.

 fs/coda/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coda/file.c b/fs/coda/file.c
index 16acc58311ea..e62315c37386 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -79,14 +79,14 @@ coda_file_write_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (ret)
 		goto finish_write;
 
-	file_start_write(host_file);
 	inode_lock(coda_inode);
+	file_start_write(host_file);
 	ret = vfs_iter_write(cfi->cfi_container, to, &iocb->ki_pos, 0);
 	coda_inode->i_size = file_inode(host_file)->i_size;
 	coda_inode->i_blocks = (coda_inode->i_size + 511) >> 9;
 	inode_set_mtime_to_ts(coda_inode, inode_set_ctime_current(coda_inode));
-	inode_unlock(coda_inode);
 	file_end_write(host_file);
+	inode_unlock(coda_inode);
 
 finish_write:
 	venus_access_intent(coda_inode->i_sb, coda_i2f(coda_inode),
-- 
2.34.1


