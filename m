Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F614229FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 04:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfETChF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 May 2019 22:37:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40746 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfETChF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 May 2019 22:37:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so6433666pfn.7;
        Sun, 19 May 2019 19:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nrSr6Am16kmGIEuLJled7IsP9Oyyyt3xELUMFjlkK5k=;
        b=PXkbfvwxwRZk3FGE9Zjl1lpRl7t55m8qWNAob55aJ1zwu/+RFy0nDeDaBL+u4sMVVN
         T1W2egxiu/dE2HFpowEIwfG8FBN7CaIkN/SFqBcFmYzKdLTzGEMzGhYDeWqR0AiwudKQ
         RkQmnM3SAMDWqkWtMZmeRtfyzOt4yzSUNRRMcA3uk82Wt4miiyE97JKc+3zvCUUJRl3p
         0PXoT1tywIsMU6g71rXXqC3tJCn3GDiYr+tgLZaU6lHKWTagj694p7iJ8GY1USuY3aI1
         yVR3lsoYO/Kcc0rvBYLHldLuNYxFDPYVbKCe90U5i1fjOGxwobHJnBIfK3ldqRaAZhQa
         am5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nrSr6Am16kmGIEuLJled7IsP9Oyyyt3xELUMFjlkK5k=;
        b=TIVrlm1mWiLB6hWxcvT7kA1Rky1Q97JEXnkKZsj9YT/0rENbCF0tJ7kZZmbCfFrOeF
         4kGRtl7KLtdC/3yxYjTKVdd+xQNjsQICsArIMGdDXowuX1AyfuSPLOdPRoGZ9QDR2fYo
         gUf7hloWcXVw8zE/oXtUuzW2d01nYlxJe7kdYrYtfMmYZQjHrMKfW6tq1wnQHxsSFEBr
         bdtM4x1A4p2YvUYDwR7rUnamicrGOL4ZuxLJ5bgxg+xXOSjZsavlMRy+w7hpXbhB5T2H
         041fFJj9jMTG6Jl9uwuSN1FYpGAlS3GAbcfjM1jk9wQ+k++gZI1uveoQqebIWCAjiVMj
         sn5w==
X-Gm-Message-State: APjAAAWuL8MeF5R4uCGvyRk21VI2QyECv5jAUpQ256l1gh6GoOXlZEPK
        3GgO8wLe+dmhYfPQSyhuo6A=
X-Google-Smtp-Source: APXvYqynZLBrOuiY+rqmbAyelozM4NiqvXHpIPcx6yrj/C9yNReTmgHH9ADWIT97diX3emBOTZFoEQ==
X-Received: by 2002:a63:6647:: with SMTP id a68mr56396851pgc.292.1558319824658;
        Sun, 19 May 2019 19:37:04 -0700 (PDT)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id s77sm30287127pfa.63.2019.05.19.19.37.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 May 2019 19:37:03 -0700 (PDT)
From:   Weitao Hou <houweitaoo@gmail.com>
To:     mcgrof@kernel.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>
Subject: [PATCH v2] kernel: fix typos and some coding style in comments
Date:   Mon, 20 May 2019 10:37:00 +0800
Message-Id: <20190520023700.8472-1-houweitaoo@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fix lenght to length

Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
---
Changes in v2:
  - fix space before tab warnings
---
 kernel/sysctl.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 943c89178e3d..f78f725f225e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -187,17 +187,17 @@ extern int no_unaligned_warning;
  * enum sysctl_writes_mode - supported sysctl write modes
  *
  * @SYSCTL_WRITES_LEGACY: each write syscall must fully contain the sysctl value
- * 	to be written, and multiple writes on the same sysctl file descriptor
- * 	will rewrite the sysctl value, regardless of file position. No warning
- * 	is issued when the initial position is not 0.
+ *	to be written, and multiple writes on the same sysctl file descriptor
+ *	will rewrite the sysctl value, regardless of file position. No warning
+ *	is issued when the initial position is not 0.
  * @SYSCTL_WRITES_WARN: same as above but warn when the initial file position is
- * 	not 0.
+ *	not 0.
  * @SYSCTL_WRITES_STRICT: writes to numeric sysctl entries must always be at
- * 	file position 0 and the value must be fully contained in the buffer
- * 	sent to the write syscall. If dealing with strings respect the file
- * 	position, but restrict this to the max length of the buffer, anything
- * 	passed the max lenght will be ignored. Multiple writes will append
- * 	to the buffer.
+ *	file position 0 and the value must be fully contained in the buffer
+ *	sent to the write syscall. If dealing with strings respect the file
+ *	position, but restrict this to the max length of the buffer, anything
+ *	passed the max length will be ignored. Multiple writes will append
+ *	to the buffer.
  *
  * These write modes control how current file position affects the behavior of
  * updating sysctl values through the proc interface on each write.
-- 
2.18.0

