Return-Path: <linux-fsdevel+bounces-995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 754EE7D4A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 10:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4F9FB21126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7394D219E9;
	Tue, 24 Oct 2023 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SNEB0fqk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8921114
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 08:34:13 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0810810E0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:10 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id 006d021491bc7-5842ea6f4d5so2247646eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698136449; x=1698741249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzccM6C4HLhaCIv/SAdijHFdTidMSXBWQyZ1w5RDJYw=;
        b=SNEB0fqkUuNyllJMMihVQAlGEvxlD846I1ZA7TkiLKmn/zyiO9QTOKglOHgTOcy7cw
         YaQlyKeiffS0uBl0lsyehChNpguuAEKJpZsQ442epIy4bfYmwaCX82TCvQ9KN0h3NGUV
         mxBJaH2rWV1QYqjdWxijJtnCIpnOTP9hu7rIzjFqVqMUYJZUP42NmhsYjTqDZpdFVIa2
         rH4ZlQYIjLZVgBGvDx1lkWCUz+ETFTNWdf3q5XYEi5MWtUfNqfG7SY9kwJI6VQ7LHvzy
         ccFB3SBBXl2A7Qla4vYnkGr+P0ogb5fKONd6b26qNaUv4Jvq4fW3EDpC0hAgGT5zTGbV
         NUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136449; x=1698741249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzccM6C4HLhaCIv/SAdijHFdTidMSXBWQyZ1w5RDJYw=;
        b=Yq8YfcmOw86LGtIB33Gv3WhvaY5Vfdu6G7/K3Vb5LYKOOHkf5XzfBV/EL4yQjePvBg
         +YdH3X+FBOrFqcMkgQhlF2xEPvNv8LV/3HoR+zjbAOqvNv2/yhlW2DhucChBy0WPZgsF
         djEvmmWlRaiQzM9nKRnnSn/l3iZrMM/br0tvd//KkGioQkx0VWAM+vOokGGldv3G9Ry+
         Khs9VmAz8g3lKJfMESXbZtRyp7fOcaKo0rAcNCkdNwInlZAApT+Ol/jIU8BoFjgm1VDz
         5xw80rcPOLu/6wM4+FDmuqtSOu8A4/DmqjH9ZEYv/BmsFvuSzG8P5+TeaBHy1c0cnjPv
         xGXg==
X-Gm-Message-State: AOJu0YxE0vkbFkzLiiRCIOjOfvkgWre06/ziLz+53fFNW7Skq7fVDg+e
	0F9NoyJCKi4QsEmfOe3Etn2WLg==
X-Google-Smtp-Source: AGHT+IFL9wgTTdwcf5iN1EU6ZDwg7/3PqxSbUY7aeR+GMticX3N3Q7oIRaxH4CtsM5Y8o0vT2v0b1Q==
X-Received: by 2002:a05:6358:810c:b0:168:d6cd:7b2e with SMTP id p12-20020a056358810c00b00168d6cd7b2emr7924030rwk.29.1698136449463;
        Tue, 24 Oct 2023 01:34:09 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id y21-20020aa79af5000000b0068be348e35fsm7236977pfp.166.2023.10.24.01.34.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Oct 2023 01:34:09 -0700 (PDT)
From: Peng Zhang <zhangpeng.00@bytedance.com>
To: Liam.Howlett@oracle.com,
	corbet@lwn.net,
	akpm@linux-foundation.org,
	willy@infradead.org,
	brauner@kernel.org,
	surenb@google.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com,
	npiggin@gmail.com,
	peterz@infradead.org,
	oliver.sang@intel.com,
	mst@redhat.com
Cc: zhangpeng.00@bytedance.com,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 09/10] maple_tree: Preserve the tree attributes when destroying maple tree
Date: Tue, 24 Oct 2023 16:32:57 +0800
Message-Id: <20231024083258.65750-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When destroying maple tree, preserve its attributes and then turn it
into an empty tree. This allows it to be reused without needing to be
reinitialized.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6704b5c507b2..b9e238e7a7af 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6765,7 +6765,7 @@ void __mt_destroy(struct maple_tree *mt)
 	if (xa_is_node(root))
 		mte_destroy_walk(root, mt);
 
-	mt->ma_flags = 0;
+	mt->ma_flags = mt_attr(mt);
 }
 EXPORT_SYMBOL_GPL(__mt_destroy);
 
-- 
2.20.1


