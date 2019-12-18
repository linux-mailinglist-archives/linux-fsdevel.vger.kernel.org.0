Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3489F123DD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 04:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfLRDX4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 22:23:56 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39870 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLRDX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 22:23:56 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so569600oty.6;
        Tue, 17 Dec 2019 19:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJSztDb6lmjtiPRyrZHre6U5L8vb56EP0EHTbsoCZLM=;
        b=umPb6nIBc/8XzsMDpHLfJLDR1gkHY/9oi9DYqytuN3R9jLYK12hgZqsFiq0warXmpS
         PfvfAtpmdEAV0BtyRj+KwzBQC94TjqEwN0fkoV6BWWhAg/6D4XaHOpYCXhlAANJlhKu+
         jNpL+Txxrz2rDdRirq4nYV7h91SayAVtPkhqsUg+fp3K2JDRai0W43Myl5MSIRwPFbZI
         7D8rO+gtU3rqVqk/65wensWNfmf09sB8rc4ikN4TMqjQ8NQOx9tW5pEqDIH47YCmBnsl
         IuHEPrelWFXXAMopWu/p+hz/dVoHVr5J49xtXCRmsL9I70s3MOq+ti6M0R4h6/8zATa0
         09IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZJSztDb6lmjtiPRyrZHre6U5L8vb56EP0EHTbsoCZLM=;
        b=ZT7JQ/K8X1WenAEjuAJnhg8t+BMC3NegUMPbmyBWavVdqKxjiTeO643Yg9JK4cRhZz
         D3uch2DGdqIpx//PwsrRAFyuj4h7zD9U/kHeRUEQXQH1Yv8l7WVkgUOG04yymVzVyVBZ
         LudY52jOJS7vWUxrRPYNBXjK6sfkvUQA0NGQZIb+4ysWulgSyycc3I+/Vt7+PR+E4Bb4
         8wafZHt4VozgqzQzThP9zpdHAvz7ELT7cYF6o+bBEJgmmFkioCsTr3OtJRkFFZl1FdcT
         eU/C2BOxb4e5d3OG4EZ82HIRnme7V9OMwOFhuztn/mXGSllO1GYOnizNOoSPIcL/fqvi
         5hyg==
X-Gm-Message-State: APjAAAVEvXzI2RQxQVkWYxVYz2dVGyitpJ6LotabiklY3ey8JK/UGol2
        ZLqw/J2IMHWtf9eXP0TBXS8=
X-Google-Smtp-Source: APXvYqwVuU1HngrwuNmts8TRaP4tz4igqm7IJo96dSuIZ6iDrArt07ZS4EmzDIZYEUANsy0W9w6ETQ==
X-Received: by 2002:a9d:6f82:: with SMTP id h2mr135306otq.69.1576639435270;
        Tue, 17 Dec 2019 19:23:55 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l1sm353857oic.22.2019.12.17.19.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 19:23:54 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] vfs: Adjust indentation in remap_verify_area
Date:   Tue, 17 Dec 2019 20:23:51 -0700
Message-Id: <20191218032351.5920-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clang warns:

../fs/read_write.c:1760:3: warning: misleading indentation; statement is
not part of the previous 'if' [-Wmisleading-indentation]
         if (unlikely((loff_t) (pos + len) < 0))
         ^
../fs/read_write.c:1757:2: note: previous statement is here
        if (unlikely(pos < 0 || len < 0))
        ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Link: https://github.com/ClangBuiltLinux/linux/issues/828
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 fs/read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587f5bc1..c71e863163bd 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1757,7 +1757,7 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
 
-	 if (unlikely((loff_t) (pos + len) < 0))
+	if (unlikely((loff_t) (pos + len) < 0))
 		return -EINVAL;
 
 	if (unlikely(inode->i_flctx && mandatory_lock(inode))) {
-- 
2.24.1

