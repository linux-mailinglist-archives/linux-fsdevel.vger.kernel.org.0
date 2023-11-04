Return-Path: <linux-fsdevel+bounces-1977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA47E1144
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 23:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5DCB20F21
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Nov 2023 22:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E20225110;
	Sat,  4 Nov 2023 22:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFqovksI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD21CAB2
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Nov 2023 22:11:26 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E86D69;
	Sat,  4 Nov 2023 15:11:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507962561adso4307839e87.0;
        Sat, 04 Nov 2023 15:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699135883; x=1699740683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YT/ZfnvFyYr1kv1f5K6t5f8NLfO8EWfoMm/vZrwqkMg=;
        b=DFqovksIrLy68REtYwQW4lXZ5wQc6TZckMPnozkD8SUmBndAhCGFsk93rXIda26EVH
         z1sXXGO8VC91lfbJnzGBhS4Ixu3+stC7Rj3ato3/fBri6mImJ1ebcS3arJ3Hr4vM76sb
         S4gC03LF/1YSZGfMyyMLUE2A5vwK185IZ01SFF1cMs4gKNh7A17LpBYSgbPw4dXOHyE4
         hzNISItPdWiCB4jN7eMHMomxfVPEknDg67lrBPmA8mWozqvE4klbI6Mefg145/gfuvdF
         K0OhUBKoWcSe7Cxd15xE8io8oLYxl+gTkNjT09TB1DfRWvRImAlg0zzztKLF0kwQzMRI
         o6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699135883; x=1699740683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YT/ZfnvFyYr1kv1f5K6t5f8NLfO8EWfoMm/vZrwqkMg=;
        b=lFHQNXhAFO9hAtJ418ehru0RbzEcW3usF5THikJjrDi3PPXf6trTgyRUXWPXjlMDnz
         w4v0uKsIWGLm/faprMADggNg0WKiU7KjKjVIA9ky6e0RdgER5ESryOVZRebkAHgpfnz4
         t44aeTrmDE5cRSPDJTwI4g/HOAxG94HDPaccyNhhdfQk3tGTsBxjZCEA0dLtSWw8MWO+
         GvUCzzMfClSRyQH08stcFss3nbRF0eRW2lsqa9R+jgCxS9zA7x17m8J6sre/Ea7aZUNi
         Wvet1T6w6HDdXJ3Bqgqd+kMXrM51MvQ2Dkb8M8Nax1HvgylVmAN1WxXKBsaOO7fhHtmH
         /srg==
X-Gm-Message-State: AOJu0YzEXJzk+8/e8EfBtRpEoZEUFPktN+wXG4zSkeZTvlbVRNsquvTj
	BogP7dL+PXELzfcCx5qMN9wQjNZ2xBM=
X-Google-Smtp-Source: AGHT+IHmoj+k3BhNUgXHqoNUCS95avlDGTk3fpjkHgDfO6ejSJislZJT6stl5C4BaPWv1hB/YpA6RA==
X-Received: by 2002:ac2:5626:0:b0:507:9ff6:75b6 with SMTP id b6-20020ac25626000000b005079ff675b6mr17381071lff.50.1699135883081;
        Sat, 04 Nov 2023 15:11:23 -0700 (PDT)
Received: from f.. (cst-prg-81-17.cust.vodafone.cz. [46.135.81.17])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7d14b000000b00534e791296bsm2492487edo.37.2023.11.04.15.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 15:11:22 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: remove a redundant might_sleep in wait_on_inode
Date: Sat,  4 Nov 2023 23:11:17 +0100
Message-Id: <20231104221117.2584708-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wait_on_bit already does it.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/writeback.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 083387c00f0c..6d0a14f7019d 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -193,7 +193,6 @@ void inode_io_list_del(struct inode *inode);
 /* writeback.h requires fs.h; it, too, is not included from here. */
 static inline void wait_on_inode(struct inode *inode)
 {
-	might_sleep();
 	wait_on_bit(&inode->i_state, __I_NEW, TASK_UNINTERRUPTIBLE);
 }
 
-- 
2.39.2


