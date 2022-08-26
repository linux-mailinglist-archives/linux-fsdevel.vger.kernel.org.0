Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D9D5A2567
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245432AbiHZKGt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245405AbiHZKGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:06:18 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B665CA407F
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 03:05:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id CDC8124BD0FA
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508068;
        bh=AuIUPtDG7EP5rSMVhlxZvrX9iTAUSf0vV72kLeZiS2I=;
        h=From:To:Cc:Subject:Date;
        b=lPICwcWN7YWeKZtLuGQI3pwdHwDdp8GwJKc6rqGrMUriZDVEOuInO3TmG9AAWxdAV
         A5HzSrZOhZEhy4gmBIjBLp+lopUhnahGzumJw2Q0cQaQxprTYzhzotMzgg6uGix86B
         nVnX8KKwJYxfsAEkFAQwVOJSSsgFfP0S6D1t/kr4=
Received: from fx301 (localhost [127.0.0.1])
        by fx301.security-mail.net (Postfix) with ESMTP id 181C124BD07B;
        Fri, 26 Aug 2022 12:01:08 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <17d21.630899e3.507b4.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx301.security-mail.net (Postfix) with ESMTPS id 97CE324BD125;
        Fri, 26 Aug 2022 12:01:07 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 3557C27E0396;
        Fri, 26 Aug 2022 12:01:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 1EB1727E0392;
        Fri, 26 Aug 2022 12:01:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 1EB1727E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508067;
        bh=Myu8SMkijdecTs03PTrW2IgGc9cWDLAdsLPOgTch5Dc=;
        h=From:To:Date:Message-Id;
        b=RAqOonkLYCYKGpzj+Vm7+4eDQPSOlG+ymCge7/xERFwVwKMMW++S4PQgW38+ah/Vy
         XwxFAh+PYVfPcwcwrTQahkys48kIdDBbpTPVExUoTUWagGbZ1ahZ/8aGOXuTMB6cT6
         x+dnY8c/QONd2NRIInBNem/7f+wuXbA0QWPTsRmc=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vElzBLQjMoGP; Fri, 26 Aug 2022 12:01:07 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 0441C27E02FA;
        Fri, 26 Aug 2022 12:01:07 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:35 +0200
Message-Id: <20220826100052.22945-7-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove redundant word `the`.

CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..6e946ed4c133 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3069,7 +3069,7 @@ extern void evict_inodes(struct super_block *sb);
 void dump_mapping(const struct address_space *);
 
 /*
- * Userspace may rely on the the inode number being non-zero. For example, glibc
+ * Userspace may rely on the inode number being non-zero. For example, glibc
  * simply ignores files with zero i_ino in unlink() and other places.
  *
  * As an additional complication, if userspace was compiled with
-- 
2.17.1

