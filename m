Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44675DDAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 07:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGCFHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 01:07:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33650 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfGCFHr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 01:07:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4so565525pgk.0;
        Tue, 02 Jul 2019 22:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC7vgfyqe3Eg8Fe1+cMp4HakvNx6nu/Qukkr/Zk8t/0=;
        b=srbeKWsd0T/FmFJeZxZX7XrU5K3lDCf5qczxFm+i5RUqeXG+OCfkkW8149MtSQhKj6
         fGwbnqWrgmJBZAwS3AApMwK4kUnwtbbSqz+TmPLM8OqtnnGEpoboCbl11ftNyPRqtbrt
         bGa2KdPXks6Erg/8ptcXNZ4juObXOCcoOC/UyzTUO3Y3oH10eD4NzKWsKHpB6bdPSoeb
         S3yBjKhYISR5UqcCEVzYfkDcKqoZvtiodtB6SNlE0bgk+S4+AjPVoZuyfbSl5wRvevKs
         QscFbuAeKVUlK0eFhG1hplIswYg2zzIrOYcjT31zSA4Qwc2453gf/MCKild1aDXyYq13
         gLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC7vgfyqe3Eg8Fe1+cMp4HakvNx6nu/Qukkr/Zk8t/0=;
        b=uFgaTTku+7otAnaT306kTE9Q5qzldMdlSMXhgO07jvsdaDrKkBYyMu46PrD1Xf9+71
         P5GicNWHyPGEtVbYiUcIxbqR59y5pnIlO7V8qTo59ReiOqMyolzzm7W3/aMLgfdiJm7N
         qfQAQWqqx5CRaMkZ0ofAvmgZqVue+JPJgKSkdQokeaHTp6ODDVrg1ymrUCkiXkauPGg0
         MxZlTi+7IJBbAuUFUnm+XLd/a16Otw3FW/rGnGmjjVcHp9IRhFHVhpC3l6wKiRrzKqJT
         W8TGY0Fb+7sYUxwB2vDYDOAFkQwpBMJBjQ0GPXZoW4gv2v4QgeRYPfIq4fuHAJjcMFFI
         NCeg==
X-Gm-Message-State: APjAAAXCKPZHNYPh/xc5vxis/TyaMSbxtj3Q1bY4HnNphC3UPiHiRzJC
        NhBes6cywukpp9SoBoEEl7yThfnf
X-Google-Smtp-Source: APXvYqzaXU3faS5JxOfTe2eOA7XoPTCkRS8vgP7gCgNPRUQr40ZbYSPxaM3Z7U4pYHyaX7bZGuIuwQ==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr9819718pjb.37.1562130466964;
        Tue, 02 Jul 2019 22:07:46 -0700 (PDT)
Received: from localhost.localdomain ([175.223.36.210])
        by smtp.gmail.com with ESMTPSA id v184sm831351pgd.34.2019.07.02.22.07.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 22:07:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] posix_acl: fix stale posix_acl_update_mode() comment
Date:   Wed,  3 Jul 2019 14:07:40 +0900
Message-Id: <20190703050740.13730-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_change_ok() was renamed to setattr_prepare() in 4.8-rc1.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 fs/posix_acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 84ad1c90d535..a76aa995a95d 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -637,7 +637,7 @@ EXPORT_SYMBOL_GPL(posix_acl_create);
  * file mode, set *acl to NULL to indicate that no ACL should be set.
  *
  * As with chmod, clear the setgit bit if the caller is not in the owning group
- * or capable of CAP_FSETID (see inode_change_ok).
+ * or capable of CAP_FSETID (see setattr_prepare).
  *
  * Called from set_acl inode operations.
  */
-- 
2.22.0

