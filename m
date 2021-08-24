Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6BE3F594B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 09:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbhHXHoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 03:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhHXHoZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:44:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A81CC06129D;
        Tue, 24 Aug 2021 00:43:08 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 22so22170842qkg.2;
        Tue, 24 Aug 2021 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v0zN6fAfCNsBN+MEmM4m4+akuba+lUc7VwA0N3vR/5o=;
        b=Dftl+NDHHnCf/rU7NXDt0v9/mwsIKRRmcLqIccUkS5geGe0hi6UaMgn5ZpoX5MigwX
         hnOFkQw/VZ/SnnuDX/ghOCyaXlPWT5kfnt5nhTZam2USURe8TGzCvdd/5KTqJkvJ4BNf
         nV/Thx9NJ3kCPAjG6UYC5akYPtq+Pj/N6twtj3yZCNJt2ha4amlCBVAeF2EQEToQxDLa
         4ePOpIh3x0wiOs9KVOa1eqaQiIVkgCXxqCjLbGO7cpF6Q4JP+Trr0g9AW46PfD7JuhoB
         PB2W0dN+DYXEwNNBrCdGM94LdipU7Z53+z3mVGOxtpPdDHPzRTjyc5R+nqaUTcTeV4+0
         27jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v0zN6fAfCNsBN+MEmM4m4+akuba+lUc7VwA0N3vR/5o=;
        b=bnY7M/xwbS6Z2qqbgYkAHrPrAsUPoYxRLmgsPhurSrzxvRNUDO6eX6HQqiyFz1i/K1
         8W39YVBxI+35kxhZwdnQ25Rx2xWf9N0Wriatod8lF0x1NwIbvQCOto+Q1QK57mLYqexn
         NiAwzSXJohhe1GzgztLhB85ZgQWl3HoHJlrrfRGAR+0fhh6Tz/Vhtd5h5t3JTbwmPZAB
         bnQAlwsADSrt8/1sjCIqtOK9CATK9YF4XGtHSkdEsz9xgmdFX8pAbzmPs+ZhK3/sHfUh
         +8WnBBQaS9/kJBYNXZO6tCVHyBJRdkAW7SAr3650u3CdkBdTJCCfaXeWG2ia59QOkqwq
         RNVQ==
X-Gm-Message-State: AOAM530rDS3p6GQc72VB+qQSWHtfJglHeSj+G1feHmT3S6xwEFCMT+Vg
        Y471MtWUdHcSK1en8YBG2XFZT/hL0y4=
X-Google-Smtp-Source: ABdhPJzbA0BzwhA0Or+2ZDagSEXrfU1nQBPHF+V4XgLoHPs+QLDT4xS7RkX2tMZ/i22WoG3D3y+nMQ==
X-Received: by 2002:a37:506:: with SMTP id 6mr25265537qkf.15.1629790987355;
        Tue, 24 Aug 2021 00:43:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p187sm10207069qkd.101.2021.08.24.00.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:43:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ran.xiaokai@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] fs: remove unused local variable inode
Date:   Tue, 24 Aug 2021 00:43:00 -0700
Message-Id: <20210824074300.62216-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: CGEL <ran.xiaokai@zte.com.cn>

due to commit 3efee0567b4a ("fs: remove mandatory file locking support"),
local variable "inode" should be removed to avoid build warning.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: CGEL <ran.xiaokai@zte.com.cn>
---
 fs/remap_range.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index ec6d26c526b3..6d4a9beaa097 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -99,8 +99,6 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 			     bool write)
 {
-	struct inode *inode = file_inode(file);
-
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
 
-- 
2.25.1

