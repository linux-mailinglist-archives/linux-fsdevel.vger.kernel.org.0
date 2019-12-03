Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6481710F6E3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfLCFUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:20:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40673 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfLCFUR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:20:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so1205979plp.7;
        Mon, 02 Dec 2019 21:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BHTDtxvEiYFTLiebbwUbRtrN28Hzzvb20uPHKGc+/WM=;
        b=coN/YcmII5tOr2Q6ckP0agsPiESdW+pWZtozn/BhsYMra12t3cXbClaWLS+cfp9AnA
         1iXvHDsFFcByIOacZzq6YFzRNPBPV2yb+bJjSUssmaaqmK7Xisy3DeL8lWi0f+AT7LSa
         yMciqWgWBiRWHfJlZ0dgBMspxHWuIQUU/dL974r1gvMm9EA2+3aWIfBAEhB+bnpuNbBl
         8cvaXcuiaWOtppaVKz2E3FgdVOv2Sd6B4UA0XFFcWSxJJ9J44XD+6mEfAa3Jt/d7CxjQ
         qTsCg/wIPxe37WpHo75dtSK87GgAmc0xHQyZiQS0Om23rFmfLciEvqmmqP4dY0ml6xGg
         WoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BHTDtxvEiYFTLiebbwUbRtrN28Hzzvb20uPHKGc+/WM=;
        b=o/OoZcvgHKVmAZo25DK0Yzd5oIFCIpZX5jN2QWTnWqt6YTTWDxMH1t8Wy/8iALcpA4
         D8k27+h0cDiunJmAI0uc7op4uDPaqJ2wueFRHVCQTgYFVHf8go15aBzk2vFjA8zJWyCr
         88KpXOem/rbX1eG2pS4zHFb+sl++TxCpJxy4T1JJiSasEDBhP2Ss719GI7SDfjJKw9yy
         5/rFhY4qSZC09rtlqkGvWQFBiCUZkaPIcrjD04Juu30lpPSKXFJMRjCCZeEmlQ2ZqVgs
         bbz8ipxou0h3tw3xNWJlA7bRGZKf97t1wCTpLufDdduMNRkCMQrAPRhI4BXaBozjZeFz
         Yrdw==
X-Gm-Message-State: APjAAAX0IuMDI4mPStq6e5STZRaZkX7Kkbrzne/OzATL0do1P9xzAUR0
        L+CXHePHZiepBHTR0dt2tbPBlOYA
X-Google-Smtp-Source: APXvYqzDUQDg8PpScRL9lZwSvsaG9MSdLQfAhziXjGNzRZ1xxpRQtar4Ed+lPQvxhnXbzn7pjW25Ww==
X-Received: by 2002:a17:90a:b384:: with SMTP id e4mr3453562pjr.108.1575350416011;
        Mon, 02 Dec 2019 21:20:16 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h9sm1451915pgk.84.2019.12.02.21.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 21:20:15 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de
Subject: [PATCH v2 5/6] fs: Delete timespec64_trunc()
Date:   Mon,  2 Dec 2019 21:19:44 -0800
Message-Id: <20191203051945.9440-6-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no more callers to the function remaining.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 fs/inode.c         | 24 ------------------------
 include/linux/fs.h |  1 -
 2 files changed, 25 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index fef457a42882..12c9e38529c9 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2145,30 +2145,6 @@ void inode_nohighmem(struct inode *inode)
 }
 EXPORT_SYMBOL(inode_nohighmem);
 
-/**
- * timespec64_trunc - Truncate timespec64 to a granularity
- * @t: Timespec64
- * @gran: Granularity in ns.
- *
- * Truncate a timespec64 to a granularity. Always rounds down. gran must
- * not be 0 nor greater than a second (NSEC_PER_SEC, or 10^9 ns).
- */
-struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran)
-{
-	/* Avoid division in the common cases 1 ns and 1 s. */
-	if (gran == 1) {
-		/* nothing */
-	} else if (gran == NSEC_PER_SEC) {
-		t.tv_nsec = 0;
-	} else if (gran > 1 && gran < NSEC_PER_SEC) {
-		t.tv_nsec -= t.tv_nsec % gran;
-	} else {
-		WARN(1, "illegal file time granularity: %u", gran);
-	}
-	return t;
-}
-EXPORT_SYMBOL(timespec64_trunc);
-
 /**
  * timestamp_truncate - Truncate timespec to a granularity
  * @t: Timespec
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..46dd7e6f6d73 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1575,7 +1575,6 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
-extern struct timespec64 timespec64_trunc(struct timespec64 t, unsigned gran);
 extern struct timespec64 current_time(struct inode *inode);
 
 /*
-- 
2.17.1

