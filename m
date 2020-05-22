Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52B41DE829
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 May 2020 15:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgEVNh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 May 2020 09:37:29 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46074 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgEVNh2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 May 2020 09:37:28 -0400
Received: by mail-ej1-f66.google.com with SMTP id yc10so13006947ejb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 06:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DXQbAVIezwUgZoEJqI/3S+f81KCHQknceGMZ/Yh690=;
        b=dkKN/Ubqt9Lqk5j2U+Mj5tOD6/Z/XLQ0mvw2Cyb31B54OMBRdfFG/A75wGMvqjzY6s
         2R4mTkgTk52H3uBzSzTahRK/u4hf0/7YC9Jp17VuqQfl5Nv8fUM7/ZVtMX99pRA+k+34
         XTu7eY/tD43Fw/EJ++bofqPq2DdwBITf+3gJ+ENMuqmBagL94eI5ZQQIRWeM7wQ1ZVIN
         B9lZS6x9+FgRd5CO6ovCaknOoBEsVUY/T/44J7+ZeC0WizhWI19iOyYKw3iZcXfXDcUr
         +DuhDEexHgtTuuidsIDe5lrvWwnHuJroCq6CnPPqzimVh6Ys56jHkL0FtSY4MX+waVeW
         9vlg==
X-Gm-Message-State: AOAM531BgZyzO5Terf5vZpK6puTyJufkSQRkADEkIcAasu0gwWcDzVwR
        8XLvzWVy8W4JrKzQUVaUm1/gdwmGXvQ=
X-Google-Smtp-Source: ABdhPJx9lqmlcB4YkzyQKD3Gs9PoXMEL7qfCPj6b2HpXqE+hvixbo7zj8aewSbX4werR3x9QwsvVRA==
X-Received: by 2002:a17:906:6d10:: with SMTP id m16mr8026450ejr.84.1590154645578;
        Fri, 22 May 2020 06:37:25 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id g21sm7191261edw.9.2020.05.22.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 06:37:24 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Subject: [PATCH] fs: Remove duplicated flag from VALID_OPEN_FLAGS
Date:   Fri, 22 May 2020 13:37:23 +0000
Message-Id: <20200522133723.1091937-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Krzysztof Wilczyński <kw@linux.com>

Also, remove extra tab after the FASYNC flag, and keep line under 80
characters.  This also resolves the following Coccinelle warning:

  include/linux/fcntl.h:11:13-21: duplicated argument to & or |

And following checkpatch.pl warning:

  WARNING: line over 80 characters
  #10: FILE: include/linux/fcntl.h:10:
  +	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY
        | O_TRUNC | \

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 include/linux/fcntl.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 7bcdcf4f6ab2..be3e445eba18 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -7,9 +7,9 @@
 
 /* List of all valid flags for the open/openat flags argument: */
 #define VALID_OPEN_FLAGS \
-	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
-	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
-	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
+	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | \
+	 O_TRUNC | O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
+	 FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
 /* List of all valid flags for the how->upgrade_mask argument: */
-- 
2.26.2

