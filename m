Return-Path: <linux-fsdevel+bounces-19400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826098C49A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 00:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E3F1F22990
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 22:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6284037;
	Mon, 13 May 2024 22:37:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F826D51A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639849; cv=none; b=SvxPjrQEdO5tdnsR4aM0L5I5PRHn4A3M8t06gPUmrZrSLL9IlcJFvO/UZr5WKbAhW0rBTicaOK0BGLowZwYzU4bu7RYz4la7HYMvxFVzTKcEGgK1nxpQikbcLKbeKlp9vyh0hSKjHJnZhM7QVhMPWREZ3MJPcDRtWspQjiRHKTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639849; c=relaxed/simple;
	bh=abvJx/E02/uvLUUK+sesZcN09gYhp54P9GDH1fTJFLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJ5ClYMp9vrpNc786sYrMTSE5Yj7U5bl4AhaP/hNLqI1eO3zg3HI1CYEGdvabOc42QDB0XDx+2PpZEVroukOrHwj6ZffVjG1CKcbAZoKMK+p9TwwzEQXP/s1hInfOg9gQGhI8c33k+UW8nKRSXAqWxayGASXoxpRMm0BVe0t4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2db17e8767cso70880081fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 15:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715639846; x=1716244646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvX7Ks56vFr7AkQVdCsCuefdZoY+WWnVyA0kARE5pxY=;
        b=QjxoxiwFTgxmEUO+i9/3mOqCrQEdj63MYmRST4voMkkgubOcxgRDdoFeXqo/5CDZdv
         TJVt1BOuEPEjBtdwj9jBXgOuTwthbEN01i0qgmS4kKff4dlnMHMDXi/4HsNfnTTftkIB
         3mTCSci0/01s9WC5LFx+AKw/b6Ctuv/oYca3DbGDDoh+5Oa9NU6qxOppQvWPEmZhejAj
         ZWD4r9wYYtQIwTd+E4dm7jpVGfRjwo132g3ClOVcipHqPakuAUAtNwru9enEMKhvb3NU
         CB/zSBcU6/sUhecqZHha06aJr4SJlxHYFyeophVaCoFMJtoQ+9fQ/TvOpvYDHdCwYfUa
         LrRg==
X-Gm-Message-State: AOJu0YwJBGj752PPE9d7C9SwTPY2ZPSNE1zy9/XBsFm/ZoG0zs3NU5aJ
	foqw1EWpt9dWHsPZAQrRX6OW4UJUMN8+u0+GUtn9OtYotlmYafLofgPbCkq4
X-Google-Smtp-Source: AGHT+IG0dc1Kajq2Lb3FynlAebgmza/pSRDbOhC3TT2bYZsvRsxSqqKwjtLlWjxmIHdNoAL1pvDPuw==
X-Received: by 2002:a2e:7805:0:b0:2e1:bdfd:ce70 with SMTP id 38308e7fff4ca-2e51fd2dd0amr82550191fa.6.1715639846245;
        Mon, 13 May 2024 15:37:26 -0700 (PDT)
Received: from nuc.fritz.box (p200300f6f718be00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f718:be00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c3229b5sm6691200a12.79.2024.05.13.15.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 15:37:25 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: enable support for large folios
Date: Tue, 14 May 2024 00:37:18 +0200
Message-Id: <20240513223718.29657-1-jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Enable large folio support on zonefs.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 37080ec516e8..3c5b4c3a0c3e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -662,6 +662,7 @@ static struct inode *zonefs_get_file_inode(struct inode *dir,
 	inode->i_op = &zonefs_file_inode_operations;
 	inode->i_fop = &zonefs_file_operations;
 	inode->i_mapping->a_ops = &zonefs_file_aops;
+	mapping_set_large_folios(inode->i_mapping);
 
 	/* Update the inode access rights depending on the zone condition */
 	zonefs_inode_update_mode(inode);
-- 
2.35.3


