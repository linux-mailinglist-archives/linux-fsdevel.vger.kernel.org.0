Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD06D1059
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfJINkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 09:40:14 -0400
Received: from mout02.posteo.de ([185.67.36.66]:43773 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfJINkN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:40:13 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 143072400FC
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2019 15:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1570627927; bh=plU/GfgV967eLyEzwZya4nodnB+xNb/gF0tf3BfvIwM=;
        h=From:To:Cc:Subject:Date:From;
        b=KEFipBZ5KNskKclsLQSNcQqqL6+y4196RiqhTnXg+aSXBGhS9gdxtHeJxv0vysJQ9
         5rxFwOBR675zvK7qFVF3atCV4KP4fS+kPwC6PnqC+6A+acPHnV6SeSjnjN1Bzi4xKW
         GZyn8gJN4nqB+xX8ydoeq2+3fFdXl5qq7TY+9uYTwpk4U6PswQsRbQLIc5a0/TvNJP
         0OEOj7uBQZ88U8kcmV6Tc7+PaXz94h5fbEptD7E7ptN0+7Fqsiow1OMVQL/Z6Mze18
         B291yUX13ofHApbakOIVrxX0gBG1r1afeRUyE1qC+y2tC8yKotFwnaxS+dn5hnar7Z
         LPws8yG7Xjk0g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 46pFWB5Nbbz9rxK;
        Wed,  9 Oct 2019 15:32:06 +0200 (CEST)
From:   philipp.ammann@posteo.de
To:     linux-fsdevel@vger.kernel.org
Cc:     Andreas Schneider <asn@cryptomilk.org>
Subject: [PATCH 1/6] Return a valid count in count_used_clusters()
Date:   Wed,  9 Oct 2019 15:31:52 +0200
Message-Id: <20191009133157.14028-2-philipp.ammann@posteo.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009133157.14028-1-philipp.ammann@posteo.de>
References: <20191009133157.14028-1-philipp.ammann@posteo.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Andreas Schneider <asn@cryptomilk.org>

Signed-off-by: Andreas Schneider <asn@cryptomilk.org>
---
 drivers/staging/exfat/exfat_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index b3e9cf725cf5..eef9e2726b6b 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -482,6 +482,9 @@ s32 exfat_count_used_clusters(struct super_block *sb)
 		}
 	}
 
+	if ((p_fs->num_clusters - 2) < (s32)count)
+		count = p_fs->num_clusters - 2;
+
 	return count;
 }
 
-- 
2.21.0

