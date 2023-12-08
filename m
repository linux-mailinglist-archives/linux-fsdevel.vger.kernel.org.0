Return-Path: <linux-fsdevel+bounces-5331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8980A945
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391C21C20361
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EA338DED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CatVrtpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696C219BF
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 07:10:59 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E63833F18B
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Dec 2023 15:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702048255;
	bh=ahAq0bs9SRy7utEnw9I8X1oqpnFPhDexGIr3W8i6/sw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=CatVrtpZrcObP5NmBZXNcuu+kVYta66jeEl/icCoVAfsyteMV1C3ePanF3HVa1Im4
	 cbuFZD9EEEPB/7DTTT0hqGNabO/rKY8NB+LyNEIoDIVcIjVfC+8LgjCuKEjinoOx3u
	 fqz92mTvTH3lHEeRaFwmnUfZ5sce+OSBzNh0Y7FoVm3z+zvSRvC653re9Er9N7gY7x
	 OXK0svbPb7kLugfUWdUfJkzJK0+GDiUKTnFPifwzU9j2dCmKe72qm4fI2L6CxnmM+k
	 EWXcg3Idx96TJbtn1BnI8yJXzC/ojGrrVJ2zF0DjuoDfsPjXNT1Ofkz/1x51xTDZx9
	 CYncbxzulFuCQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1d38492da7so123837466b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Dec 2023 07:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048255; x=1702653055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahAq0bs9SRy7utEnw9I8X1oqpnFPhDexGIr3W8i6/sw=;
        b=BdR6pFX3DzDnZrJHJiWvlqYfpieWW9F8oMOR6zKrwPJzJlXVeI72Po84z6jTFRbSfb
         rcUViEOb29YieoFkFEAHhIW8PpMRvaUW9Jrp+n4chTAGGD0HecagKXg5Gd7xB63fi2cH
         gHdtDGSXZYcmVDj9Hed2+wgNn2YDbqsbARIKji23bRICuna/nWVCAJfQC8YRrDcOV3N4
         qfLmtmMHrI27TelyaqMfh56+e0X+QavG4NKbyCnM4CR0H127rwUk4PxjuMMBpL2I8LEC
         JqR/h51XvWn24Q4Q0fqkdIBKwOx7wtiJ9GSeS/JoIfzf0abKWmT9mqZuXD/1nmX6tG+2
         /B5w==
X-Gm-Message-State: AOJu0Yx4ct3uhpzVpAjZN8fT82fWTewSAmMo3cYfl7wHtvMIRak5/GVk
	5gtlbaUTRt929PXPB65olb/xn8yO0whY4nYLIO+Acqcr7xC24S7fXdRfQu06q4xFggWmbyaUeME
	fBQM63sup2bha+qW6fJgQ7pQel+t1LGI5rdqLSq1M+bk=
X-Received: by 2002:a17:907:7882:b0:a19:d40a:d225 with SMTP id ku2-20020a170907788200b00a19d40ad225mr30584ejc.241.1702048255601;
        Fri, 08 Dec 2023 07:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyDTKMZuA0UGfAukUeYUoKzCBZlXeHl6o7b0W3kpy7uvNruLx3UuUJq41J0yRgruhRHcmDAg==
X-Received: by 2002:a17:907:7882:b0:a19:d40a:d225 with SMTP id ku2-20020a170907788200b00a19d40ad225mr30582ejc.241.1702048255312;
        Fri, 08 Dec 2023 07:10:55 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:8624:a300:c1aa:a6b2:15a4:a9b9])
        by smtp.gmail.com with ESMTPSA id vi12-20020a170907d40c00b00a1a8d03347csm1120847ejc.13.2023.12.08.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:10:54 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: super: use GFP_KERNEL instead of GFP_USER for super block allocation
Date: Fri,  8 Dec 2023 16:10:22 +0100
Message-Id: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to use a GFP_USER flag for struct super_block allocation
in the alloc_super(). Instead, let's use GFP_KERNEL for that.

From the memory management perspective, the only difference between
GFP_USER and GFP_KERNEL is that GFP_USER allocations are tied to a cpuset,
while GFP_KERNEL ones are not.

There is no real issue and this is not a candidate to go to the stable,
but let's fix it for a consistency sake.

Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 076392396e72..6fe482371633 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -323,7 +323,7 @@ static void destroy_unused_super(struct super_block *s)
 static struct super_block *alloc_super(struct file_system_type *type, int flags,
 				       struct user_namespace *user_ns)
 {
-	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = kzalloc(sizeof(struct super_block), GFP_KERNEL);
 	static const struct super_operations default_op;
 	int i;
 
-- 
2.34.1


