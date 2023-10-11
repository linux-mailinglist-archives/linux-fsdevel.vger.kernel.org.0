Return-Path: <linux-fsdevel+bounces-32-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B967C4934
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 07:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE141C20F15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 05:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C8BD30E;
	Wed, 11 Oct 2023 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhxywmPI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B5F354F6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 05:29:00 +0000 (UTC)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9D9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 22:28:58 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d8195078f69so6913657276.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 22:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697002137; x=1697606937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B8Dos0Ptcxa6doVZ1kenTbMRjL+eUum6LGOuV/RzAUI=;
        b=DhxywmPIKS5GinOCSadpE0lQuHXiN8oU4A6kMVaqV+JxUdBT/cLvB37+3BbYe0jjNa
         zqsnlHQSORxchJJJvTzKqiYBDbfNIrYvKXiRtTi7DGsX9XQ4WG3vc6cvqrLDcfjR9z5d
         VVForbBbJ08f83EuK0YKuIccOj0yMKnoiyOVnbzgsopzYkCf54JrOtZXoP0gfMfSxxOf
         qHGXGKT61jd7Ze/xJ+YN9UDQB7KhYnoZw27E8ImSvoYBryBxoy0N5+9bUwM8pOQkDcXR
         S4sZMWg1PNR5+TccWsWAZsDwPgwwedyocHscnHlkNhAWclxUZxTOQYjLN5MLIL+AVpO8
         x+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697002137; x=1697606937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B8Dos0Ptcxa6doVZ1kenTbMRjL+eUum6LGOuV/RzAUI=;
        b=kIboBAlQk3qsZ6bL1fThBJq6kActY/D8GlJUlPe8u31OJqwYvfWYYj0ihnePqnYHuL
         +TWGwDInPdGB2agJNo3kNpvlfeflejsoVdMMzCoQYnaUea08PxqYMw/23lbP5N17fm5z
         KAEbfQ2KcyrmRb0IgGhYiZ1WShQjn19PRzHDOQOEKp7s9n0NYB0WvRVg1Dx8TwsEbJrk
         MPY8YkPkCsc26FLR9LhROiHKGhp+st9ziT6l/SEuE0atlc00EDkCGbGb9pfcvInyQHMo
         Ar4Mm70vh0O52G0TadwuJMhPD3zGf9g2Op284lUe+7yszA5yZ/nhLA2i4S2qyLJwQuny
         fo6g==
X-Gm-Message-State: AOJu0Yxmb/QGQS2j8dflPXPZIHZDs37fQf+PebJhG9scHmJxrBJTmzd3
	aXFnDgJD4qgq3rs1Kom+Cg==
X-Google-Smtp-Source: AGHT+IE7qhmwoNt3lGVvQeQNASQGSqFySjx+y7ZWZSivTKhqaB1M4hoc8wasdg9sqxeaqZbguNwV/w==
X-Received: by 2002:a05:6902:202:b0:d91:fdb:afd4 with SMTP id j2-20020a056902020200b00d910fdbafd4mr17586340ybs.16.1697002137508;
        Tue, 10 Oct 2023 22:28:57 -0700 (PDT)
Received: from localhost.localdomain ([116.235.164.130])
        by smtp.gmail.com with ESMTPSA id v9-20020a62a509000000b0069029a3196dsm9134015pfm.184.2023.10.10.22.28.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2023 22:28:57 -0700 (PDT)
From: Mo Zou <lostzoumo@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Mo Zou <lostzoumo@gmail.com>
Subject: [PATCH] Documentation: fs: fix directory locking proofs
Date: Wed, 11 Oct 2023 13:28:15 +0800
Message-Id: <20231011052815.15022-1-lostzoumo@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 28eceeda130f ("fs: Lock moved directories") acquires locks also for
directories when they are moved and updates the deadlock-freedom proof
to claim "a linear ordering of the objects - A < B iff (A is an ancestor
of B) or (B is an ancestor of A and ptr(A) < ptr(B))". This claim,
however, is not correct. Because cross-directory rename may acquire two
parents (old parent and new parent) and two child directories (source
and target) and the ordering between old parent and target (or new parent
and source) may not fall into the above cases, i.e. ptr(old parent) <
ptr(target) may not hold. We should revert to previous description that
"at any moment we have a partial ordering of the objects - A < B iff A is
an ancestor of B".

Signed-off-by: Mo Zou <lostzoumo@gmail.com>
---
 Documentation/filesystems/directory-locking.rst | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/directory-locking.rst b/Documentation/filesystems/directory-locking.rst
index dccd61c7c5c3..5b26ecd9f0db 100644
--- a/Documentation/filesystems/directory-locking.rst
+++ b/Documentation/filesystems/directory-locking.rst
@@ -67,9 +67,8 @@ If no directory is its own ancestor, the scheme above is deadlock-free.
 
 Proof:
 
-	First of all, at any moment we have a linear ordering of the
-	objects - A < B iff (A is an ancestor of B) or (B is not an ancestor
-        of A and ptr(A) < ptr(B)).
+	First of all, at any moment we have a partial ordering of the
+	objects - A < B iff A is an ancestor of B.
 
 	That ordering can change.  However, the following is true:
 
-- 
2.30.1 (Apple Git-130)


