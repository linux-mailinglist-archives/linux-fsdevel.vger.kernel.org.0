Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4AB454573
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 12:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhKQLQ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 06:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhKQLQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:16:29 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86BDC061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 03:13:30 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n85so2316154pfd.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 03:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sfC+c1tGsoQPS19UI2YZsHPHS1vHNgy/iigPOpIrjWQ=;
        b=C3bxxKDZC3Hrg81fmI7Dj5vgyXA/sNFyVBGJ6OFtP1ZvAZ+kuNRhGkDgJQaytTDsG5
         QujMbRh45aVwokHeqWj8+j8ER5w7wyHOrx663doeJqRrqDplmwCKr/RqCCUjFVlHZ8aY
         UBUmhaggoEM1t9Xl2qi9rqiE8BjJTO1eMI1ZTv3XHLdTG0lQ881+RflQUZrxlQ8J1ESU
         3ADrPnc/k96JbblbHcblfLC9qC0sJSwUwFQdTe6BsX6usaNQ3Pv1OVGaEn9gMXHWX84P
         7/QzPnoaI1JHS56M/4wmLh7POEERfWpXMvsXEVWxQIZSxEVtxXHVUj1L9xICpzzG0qNH
         WEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sfC+c1tGsoQPS19UI2YZsHPHS1vHNgy/iigPOpIrjWQ=;
        b=39BWkonOIrrI8KnJ7CtXz3h5rlgVXsFyqlpcHi1Dpqc2D6fJMcT7+kYnKi704727f6
         lRG7CXYO4w3OSBXlAX10AbDF3BSHiYac2E801qd39AXz3iszrubt/BuuLoQL6vbnovLz
         tn5/Q42F1eE+Gac6wmrpkjxqYB0Vb4j2Teaj2jAMSTd0ajqXH6n67wlopHBcOZ2b5+cI
         aIm1zYTlU9KIoE7rA3Lh8HtzsuLo1+LU8YNLsCMLGx/FbywLHb8N2cmx/8tVPr04b19n
         +JWz1PrFWD1jSgrJ7yNrZwLOc49e+rfuW+mhCaOssqPNp/vvh0EUTy71Rv6DdRBIhLv8
         URqQ==
X-Gm-Message-State: AOAM530+ecu57iBpYn5xty17BcZ8KOZAVsoBQ6RfqfYwgTd1xiNyeEOx
        UtWMBqpm7osA6zeDAJyoxH6SliUvoTg=
X-Google-Smtp-Source: ABdhPJwDWF+ZFvkkwjNSL6U/8JCk9yKfGH6EtD4LggfoowHWKf4OshdiCGQiyevqWvnQwfcuxiaB9w==
X-Received: by 2002:a63:b252:: with SMTP id t18mr4627864pgo.19.1637147610047;
        Wed, 17 Nov 2021 03:13:30 -0800 (PST)
Received: from overlay ([202.3.77.210])
        by smtp.gmail.com with ESMTPSA id 7sm17221714pgk.55.2021.11.17.03.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:13:29 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:43:26 +0530
From:   rohitsd1409 <rohitsd1409@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] inode_dio_begin comment fixed.
Message-ID: <20211117111326.GA4306@overlay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_dio_begin and inode_dio_end have same comment "This is called once
we have finished processing ...". This comment is applicable only for
inode_dio_end and someone copy pasted it for inode_dio_begin also.
Hence, updated the comment for inode_dio_begin by adding correct
explanation.
---
 include/linux/fs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1cb616fc1105..2fb075da88a4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3282,8 +3282,7 @@ void inode_dio_wait(struct inode *inode);
  * inode_dio_begin - signal start of a direct I/O requests
  * @inode: inode the direct I/O happens on
  *
- * This is called once we've finished processing a direct I/O request,
- * and is used to wake up callers waiting for direct I/O to be quiesced.
+ * This is called once we've started processing a direct I/O request.
  */
 static inline void inode_dio_begin(struct inode *inode)
 {
-- 
2.17.1

