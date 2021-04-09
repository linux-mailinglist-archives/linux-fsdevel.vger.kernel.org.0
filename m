Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7749035A5D3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 20:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbhDISdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 14:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhDISdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:33:17 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09062C061762;
        Fri,  9 Apr 2021 11:33:03 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j5so5561535wrn.4;
        Fri, 09 Apr 2021 11:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=saDw2irPVKnwGeLPBL5IVZRbilJg+scGi3r1CfJCJow=;
        b=OXmDr1aXvJf/a3kz7C38TwfICyHvUxlX9axM/LerixBCFTRUCDaVNVmBwD+T9CGAho
         aOLKckeM+0ySveicmcSUMX9jabp2y89piHr6MSe0dblaUFNHbrVnwvI5SLzJBXl3TmVN
         3k59Kn04BvidBp25wrRXVmdSoTdqR1Z3vEesQg1mlEWL57fu8USN3c9pYek15o9sBEMG
         y1XozjnVLE0JCHVlugL29CpPLDJkAqhtNn69bwCEx8dSBHgWtKfQdaZvU4L2qVO68n9M
         H7gnkQGOyD0+G/KxPXUCqlAQHvUNnLyCgOzyd5OW23TJIQAuHMEy9T/CkheWcbrVq+A3
         N0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=saDw2irPVKnwGeLPBL5IVZRbilJg+scGi3r1CfJCJow=;
        b=JR4r/fAJiQ/M7NWwlJjN0BWz1NDvej1Z2dp1Ao2cSoSRiruEzeT/UzvHk+rMAzEBTa
         EpiVilNQkb130V27vHcoHXZeG+zdyIdtMvxVdN8i7HJB2PDMTyoNMhHAPveZDdY7VMVY
         FQeMI9MxMQdEmxvQAk+/x8OBdT4SIZXe3aQzU2iGWjd6qs+z+J4bgqKrPYfSH7Kf+1/F
         UKAC3o3HlFDrwQhYioytWd48UvQ9criF0vJ/ta3DHst4R75PhGIF+vH1s4dnulLSAZif
         sp5fZddJukjd7nWbK5gCqVN6uQBNDqqV2Qt2Kggp6hLXfp5fzv7Pzx6JhaRtMBN0LyeW
         hHgw==
X-Gm-Message-State: AOAM530A8/x17yjWTRIyThiIyOcVjbgFtEPMp+5Kb36krpAn+sLxkdxh
        Cls4kArd5O5LlBtaWASZs0U=
X-Google-Smtp-Source: ABdhPJzFt4TtLTS3XnsUPR+FavkCoAIr70NW/H7WXdSYCulbs9GkJPtC7gLRN+KZCdk25O147u6Zbw==
X-Received: by 2002:adf:c452:: with SMTP id a18mr18461159wrg.378.1617993181858;
        Fri, 09 Apr 2021 11:33:01 -0700 (PDT)
Received: from LEGION ([39.46.65.172])
        by smtp.gmail.com with ESMTPSA id v7sm5152025wme.47.2021.04.09.11.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:33:01 -0700 (PDT)
Date:   Fri, 9 Apr 2021 23:32:54 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, hch@lst.de
Cc:     musamaanjum@gmail.com, kernel-janitors@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH] block: initialize variable ret with 0
Message-ID: <20210409183254.GA3534403@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ret variable is not being set if get_capacity returns 0 in very first
try. It should be initialized with 0 for this case.

Addresses-Coverity: ("Uninitialized variable")
Fixes: d3c4a43d92 ("block: refactor blk_drop_partitions")
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 fs/block_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index bb02b4be7f1c..986951bfee85 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1240,7 +1240,7 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
 int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
-- 
2.25.1

