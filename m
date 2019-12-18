Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A14123EC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 06:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfLRFQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 00:16:41 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37231 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 00:16:41 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so884482otn.4;
        Tue, 17 Dec 2019 21:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jxIZEY/aFZUkloIpwcQQE/QdtpYBJOYCZWZIB95mXbs=;
        b=AoMZzl4ppz48arRxwPu4AXUi72SLcE+Dp62BvnPSNvVm8llJeEvuhpgci/h8xjrzBW
         dPXLr2OIA0lmm4N0mt8Bl6WRmq4TQGJ8486lQH4DOFzIxDAwHcYwbp5ZhRZjXVo3NJ2X
         VjfU5CU0/xHRaj8pfUZv9P9iGu5eUREx5DI6A3mkksUMkMSKYCPpBlWS8/3xO9hpRZPX
         KLJ7R1YIylLfMELIF1JrfMd4ND+DYUE8DGLU6fkB43aWPhz8DzJliUF2qalOxVo3UD2u
         2XEasxXavk/T+gzOlD6/gDSPgULbi2q+FaQ1XVN3jMoQE3omQF47iYvgPhtXbBywU7n8
         96Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jxIZEY/aFZUkloIpwcQQE/QdtpYBJOYCZWZIB95mXbs=;
        b=j5MTBIWDHOk6NuCT6C/6n9Z0L/wypcYC0jGuwc9i3WCJ3rDa0vFUbXlkVw+Rf5HsyM
         qDCCsR0jQ3EKhAKX94mGLNZVBtLSYKisFK7+uj3+iRlDQNIVSb94QI1RTYEW8mDxmqbp
         qQK2pTrBPxAopaSSKQ0+rBgEbWRw4Y+Xdl4x9SvvCAj3dZSTQgd57R/F26oJd285tRsw
         U+RRLtQACD3XmBn+skn40DGhXXCzaVcUnF3udVugT2WQf3GzD5dQhLst1HbClXRfWflb
         YAZVeobhLtXEUJGcCxWhrktw3uWncqqEjcTRSTwZzTq/UhbTpj22B0hHcAzimZ6XXjxV
         gGYA==
X-Gm-Message-State: APjAAAW7m9JAaxIXm2IewGZ7ZfupRNsikXRIpeCBr58TA98aqyBu26aO
        UvJHkK6nx+NkGCv0ptLbQ96qZHdsHEk=
X-Google-Smtp-Source: APXvYqyeXme4O32ZAqaYA7kbJZpHKSaKZe08BaL8nBxgdQ54YO/NhLpYSQWG3JTMjctgcYIAvxYy5A==
X-Received: by 2002:a9d:590b:: with SMTP id t11mr596526oth.161.1576646200046;
        Tue, 17 Dec 2019 21:16:40 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id a65sm411947otb.68.2019.12.17.21.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 21:16:39 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] vfs: Adjust indentation in remap_verify_area
Date:   Tue, 17 Dec 2019 22:16:35 -0700
Message-Id: <20191218051635.38347-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218035055.GG4203@ZenIV.linux.org.uk>
References: <20191218035055.GG4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Clang's -Wmisleading-indentation caught an instance in remap_verify_area
where there was a trailing space after a tab. Remove it to get rid of
the warning.

Fixes: 04b38d601239 ("vfs: pull btrfs clone API to vfs layer")
Link: https://github.com/ClangBuiltLinux/linux/issues/828
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Trim warning and simplify patch explanation.

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

