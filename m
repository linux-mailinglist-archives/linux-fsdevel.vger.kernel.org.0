Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 672BC13880
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 11:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfEDJqM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 May 2019 05:46:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38968 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfEDJqM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 May 2019 05:46:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so9333774wmk.4;
        Sat, 04 May 2019 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5YhmT25K8XX07nrGhSFEcxH6PFWKiVj8FEoiwNFPytU=;
        b=BOp0Tvf7Djq5AHFQjNYGfcmQ5zwB8eIIbJ6au6gggaXOyKgZZKsmqX6gaHPUKEITHK
         XwArTQhFI4UDc6+r5pQEFG2KezECELniZisoTrZ7h2GVcOOyqzGI3ROaPz5E6ZCWoJzT
         KJG36AJhNGU3AKIiBU+SuISLxP9MyxNHffm0xa31aIRsWi0xqn1ZoqjdwALj7dm+0iCd
         cfbmT0zU6+pPe9kwvVj4SeH0rquFN/veJeaBoqxux8UH0oHVt1QO/6P4JYmuXCbEc2ld
         mlDuvdyJsnOis/IWybfpEqs99uPoKbooNn2Emsycm2UtaVdaViSwJNnKsbpKgTQCK3ay
         wBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5YhmT25K8XX07nrGhSFEcxH6PFWKiVj8FEoiwNFPytU=;
        b=rrCk+5sl28NOWQ+EeOCLlk/fPnDGFOG4z4E99dtohToyyFW+hGa+xq3W6QL2H5arQ9
         3eldbFvF2ZaSipo7fnCdT0lwcrYyMn1XtciCiJ0VG5IudHCrF/Gat+l2d40zAeM/ulFO
         c4CjcGzx1KSw6+Zlb/08R7+awYl8BQbhImE3OzqN2ETAYwB5jhyu690QJxKUsEGuyMF8
         YkL+9lLw1BIaHQEfksqqlwml5C/C3frl/3Iy8/lJnzkiHj5c6gZWODSwYDagpHwhUNRO
         ZfpgFm2CB+pco2FCfUKDYeENhqxU96FRbfrlXD8RfD1XnwUZYfOrU4u41qtJ4ol07g2l
         v7Pw==
X-Gm-Message-State: APjAAAWlPKwMM/Dw1BMMzSxrnTGzLZXgvYa1Joo2+9gcd++lqhPfHO27
        b+B+ZxTXnloKDQiEWNvJBUI=
X-Google-Smtp-Source: APXvYqzct3O1AJZ7vm+dMw81PPmq/a2MsCbi0t6I+XUFcUPPyZsj/lTVOdYeeBbsEl89XxANsE8Law==
X-Received: by 2002:a1c:cc10:: with SMTP id h16mr9856469wmb.39.1556963170471;
        Sat, 04 May 2019 02:46:10 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-179-250-108.red.bezeqint.net. [79.179.250.108])
        by smtp.gmail.com with ESMTPSA id o6sm7624806wre.60.2019.05.04.02.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 02:46:09 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Changed unsigned param type to unsigned int
Date:   Sat,  4 May 2019 05:45:49 -0400
Message-Id: <20190504094549.10021-3-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504094549.10021-1-carmeli.tamir@gmail.com>
References: <20190504094549.10021-1-carmeli.tamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tamir <carmeli.tamir@gmail.com>

Fixed a checkpatch warning for usage of unsigned type.
Submitted as different patch in the series since it's not related
to the change, just wanted to fix checkpatch warnings from it.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 fs/filesystems.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index f12b98f2f079..561fd7787822 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -46,7 +46,8 @@ void put_filesystem(struct file_system_type *fs)
 	module_put(fs->owner);
 }
 
-static struct file_system_type *find_filesystem(const char *name, unsigned len)
+static struct file_system_type *find_filesystem(const char *name,
+		unsigned int len)
 {
 	struct file_system_type *p;
 
-- 
2.19.1

