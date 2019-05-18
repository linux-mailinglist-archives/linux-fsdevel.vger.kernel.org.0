Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1711D22318
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2019 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfERKRZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 May 2019 06:17:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44120 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfERKRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 May 2019 06:17:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so4467449pgv.11;
        Sat, 18 May 2019 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uDC/BsmQRtlfHZE6W82svAARTtrMl8uipvRjlKfZYe0=;
        b=jqMAAxVvQLoa/iVodlF6BKQjTM50dqttnz1gCJ80+4xf6TatP3V4+9+YPkAzYrRmxb
         xPhNDKjHSc48GkcY5nfmH0xjFCNvuini0wJ/vetIVSGXbgMJWcy51lX1KnOkvV4Ti5E7
         lSXx39FVpYuSA3V4FGbFiflMgGTsrR2mEjnefPuXe6IGL3sPNcx7nYGBEHOHZVFGRY40
         JHE0q36J5pPuUp6m2wHFxcdaDrDRrZEp98ajT7njN0Es66Rz1n9gJftEsfCJ0tjVaNq4
         34cZis/DuOzOJ2T8t186ksT1HL0a037yCE3Z8TqBAxETKR3ET+VWidZ7R8B/sMvFepSY
         WyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uDC/BsmQRtlfHZE6W82svAARTtrMl8uipvRjlKfZYe0=;
        b=YpsMoHG9ndzOnNOtXR3gIF0Xw83sbgZhEOP8iVI9BisEnHywXnqTdsvI0a/0p8U5Rf
         NOrDY+yha52p4uxAXswrh20/RWv5uHlXCoKIwnZtodA8n2t98QMrUuCPQLevPbQqm9rh
         /dt+XLfbEaI3kGGq8vytGRY74WlUJXY78oFmv5ErNv7tDDSEC65VL3BG7XlFsOjkb9JB
         LX3bnVX7qlqJLmGqxWsc9OVzTA2py4iHvlz9xDIkeUH4gbcQ8UwxOV+9pD30OmM6m++3
         c9PS4e+nebDbTsx27ELFa/yG1usXpbT5c+fTO7WwVfkvHrG0BHIFoI2RKr6V8ZYuuXgo
         /iIQ==
X-Gm-Message-State: APjAAAUPyyepC0J/b8zrMBMA1tA8sxnuFen3o1bBRFnXoZ8ORFlcinRF
        gafiHqmdIftSWJmucsfDCv4=
X-Google-Smtp-Source: APXvYqyaKiMIlnNNyEKoqJPkqF8SgkjJDjXeymXjTiwGLNXPpPC1W/Rl4Gg1vy7rWTYjoYwLcYwSrg==
X-Received: by 2002:a63:d345:: with SMTP id u5mr58810026pgi.83.1558174644590;
        Sat, 18 May 2019 03:17:24 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id d15sm36399381pfm.186.2019.05.18.03.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 03:17:23 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     mcgrof@kernel.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH] kernel: fix typos and some coding style in comments
Date:   Sat, 18 May 2019 18:16:28 +0800
Message-Id: <20190518101628.14633-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fix lenght to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
 kernel/sysctl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 943c89178e3d..0736a1d580df 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -187,17 +187,17 @@ extern int no_unaligned_warning;
  * enum sysctl_writes_mode - supported sysctl write modes
  *
  * @SYSCTL_WRITES_LEGACY: each write syscall must fully contain the sysctl value
- * 	to be written, and multiple writes on the same sysctl file descriptor
- * 	will rewrite the sysctl value, regardless of file position. No warning
- * 	is issued when the initial position is not 0.
+ * to be written, and multiple writes on the same sysctl file descriptor
+ * will rewrite the sysctl value, regardless of file position. No warning
+ * is issued when the initial position is not 0.
  * @SYSCTL_WRITES_WARN: same as above but warn when the initial file position is
- * 	not 0.
+ * not 0.
  * @SYSCTL_WRITES_STRICT: writes to numeric sysctl entries must always be at
- * 	file position 0 and the value must be fully contained in the buffer
- * 	sent to the write syscall. If dealing with strings respect the file
- * 	position, but restrict this to the max length of the buffer, anything
- * 	passed the max lenght will be ignored. Multiple writes will append
- * 	to the buffer.
+ * file position 0 and the value must be fully contained in the buffer
+ * sent to the write syscall. If dealing with strings respect the file
+ * position, but restrict this to the max length of the buffer, anything
+ * passed the max length will be ignored. Multiple writes will append
+ * to the buffer.
  *
  * These write modes control how current file position affects the behavior of
  * updating sysctl values through the proc interface on each write.
-- 
2.18.0

