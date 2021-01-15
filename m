Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56A2F7842
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 13:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbhAOMEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 07:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbhAOMEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:04:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068FC061757;
        Fri, 15 Jan 2021 04:03:52 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id jx16so12894923ejb.10;
        Fri, 15 Jan 2021 04:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DZKL8N3bCOLd5d6DHEQ8H/r2ag/CUrBRkfKsXkDdZC4=;
        b=PH5nw1CRQzbcVNiXb/+ZTZ+co58w9pO7JBjqbwHzJc2SkQkCi2t9JsJUuJYDuNDHok
         lgWIHNrXKQjb3BddFMR3ZuR0wZ5Vel68eSGj63YsXPTi51wjTUCeUCc0uCgmSkGa/xtA
         KOx07y75aC8sgiQX9jVBC6bV6I3xmv7xGZv9NP8pv2WyfhraP5M1aeh6Vallki1P9GCd
         f9PcE4SIFZxqGJdd3jEpq+6GgW3hrmGhWe7lCIfYqguVyIQbsQkTFO6N7bRe/1619X0f
         0ZH/2mn9ABBlrxu2GAwaPLEKCOIjCW9TfOP7lHbfTMgZbPjNZinDRyhWHKJdOnDdq14Y
         29Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DZKL8N3bCOLd5d6DHEQ8H/r2ag/CUrBRkfKsXkDdZC4=;
        b=EdBQWaIW1ERHiqFGCJsol/pVu697m/k6fNsiXvRAyTE2y9sRvRyIzXY+clrHYSEtiQ
         qtCy37rjKIwlWO1+MegQfYnKkj3LDgMDK4gExzIe0a9orr5p3Zb2cNfsJM23RyEzpjxQ
         64tHlYJabaKfq4xO8omO47vJ2lBbh2I7Om1PXRJta6rVyWjIwhpan9Xzh+5kO/eKJYNh
         vOmihyDpQp+vfOtW+7Hbd6OPLz4q8Kn4MMiS26Y6LNekzkLRuMsztfDCiSS2AYmmInnx
         gfdMJYu5cHXIIA7OT6JqiOO+y3URliXIgaZhG+WozSzG6ZX1dPw+C5vpusePA1DLAVUq
         jLlA==
X-Gm-Message-State: AOAM53112KkVgmqnBxE1E3c/Pf3udEIZLMrcl4n3Lwpo3bPD6ZSNQ5An
        GsTtStg5eFcwi/JcmLlAdhw=
X-Google-Smtp-Source: ABdhPJyPPqMVbBEXYP+7LoChiNf3GY+blJP0XXqz/DGs5XIuWOLFIH8d3yAEmudH9WjagMJorCBlyA==
X-Received: by 2002:a17:906:d87:: with SMTP id m7mr8452658eji.108.1610712231381;
        Fri, 15 Jan 2021 04:03:51 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d39:a000:7c85:8e80:b862:a8bf])
        by smtp.gmail.com with ESMTPSA id m5sm3228350eja.11.2021.01.15.04.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:03:50 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Daniel Colascione <dancol@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Eric Biggers <ebiggers@google.com>,
        Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fs: anon_inodes: rephrase to appropriate kernel-doc
Date:   Fri, 15 Jan 2021 13:03:42 +0100
Message-Id: <20210115120342.8849-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit e7e832ce6fa7 ("fs: add LSM-supporting anon-inode interface") adds
more kerneldoc description, but also a few new warnings on
anon_inode_getfd_secure() due to missing parameter descriptions.

Rephrase to appropriate kernel-doc for anon_inode_getfd_secure().

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/anon_inodes.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/anon_inodes.c b/fs/anon_inodes.c
index 023337d65a03..a280156138ed 100644
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -202,13 +202,20 @@ int anon_inode_getfd(const char *name, const struct file_operations *fops,
 EXPORT_SYMBOL_GPL(anon_inode_getfd);
 
 /**
- * Like anon_inode_getfd(), but creates a new !S_PRIVATE anon inode rather than
- * reuse the singleton anon inode, and calls the inode_init_security_anon() LSM
- * hook. This allows the inode to have its own security context and for a LSM
- * to reject creation of the inode.  An optional @context_inode argument is
- * also added to provide the logical relationship with the new inode.  The LSM
- * may use @context_inode in inode_init_security_anon(), but a reference to it
- * is not held.
+ * anon_inode_getfd_secure - Like anon_inode_getfd(), but creates a new
+ * !S_PRIVATE anon inode rather than reuse the singleton anon inode, and calls
+ * the inode_init_security_anon() LSM hook. This allows the inode to have its
+ * own security context and for a LSM to reject creation of the inode.
+ *
+ * @name:    [in]    name of the "class" of the new file
+ * @fops:    [in]    file operations for the new file
+ * @priv:    [in]    private data for the new file (will be file's private_data)
+ * @flags:   [in]    flags
+ * @context_inode:
+ *           [in]    the logical relationship with the new inode (optional)
+ *
+ * The LSM may use @context_inode in inode_init_security_anon(), but a
+ * reference to it is not held.
  */
 int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
 			    void *priv, int flags,
-- 
2.17.1

