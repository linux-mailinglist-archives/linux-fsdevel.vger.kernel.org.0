Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7243E5A256A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Aug 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiHZKGl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Aug 2022 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbiHZKGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:06:11 -0400
X-Greylist: delayed 239 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Aug 2022 03:05:10 PDT
Received: from mxout.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5013052DD7
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 03:05:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id 75F803D3B167
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508070;
        bh=8GaQ+BQxQwmLfFAY3UwtrZ/d9W9sEVE4MVV/IE9XSnA=;
        h=From:To:Cc:Subject:Date;
        b=LasDV7CTYN7QMKnInMJUanUZfMWgg6phgF/fhU1l8pJkNsduEvUbdDb0MMiL0POfn
         vE6U99KOeiL/fCkG5hqR5OQ39YqAl1MSDj/GfIovxj0pdXZ0HOPrEqs+5RM7oq1qxh
         lGrBu4NJgLPzfMgMGa7ibC3e+F9+tUaqryFtX4mI=
Received: from fx302 (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id F18983D3B0B8;
        Fri, 26 Aug 2022 12:01:09 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <1510e.630899e5.72c6a.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx302.security-mail.net (Postfix) with ESMTPS id 7347F3D3B165;
        Fri, 26 Aug 2022 12:01:09 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 5A1F127E02FA;
        Fri, 26 Aug 2022 12:01:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 439C427E0392;
        Fri, 26 Aug 2022 12:01:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 439C427E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508069;
        bh=xq2h1CH6VTuibgIykByVr3mMAa1GYI+GOILmH7S2DtY=;
        h=From:To:Date:Message-Id;
        b=W60DOFbm7ZFHvA/oTIYXhaFgSAZDaB0Ffvpqc9bwqSBXUQbp0jyqQof5CB+8obqFi
         9Id+IkysVeDY6N6oUtKGv3+FwmI1jkg+jOZVTGporocg3+XqZOFtZsDKQ4v4yml+zs
         sOn9OHF0DwyEi9lMQBjBTBGABxZnGS+aV6U7n2lM=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y7IGJxT_wypX; Fri, 26 Aug 2022 12:01:09 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 2B85A27E02FA;
        Fri, 26 Aug 2022 12:01:09 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/afs: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:36 +0200
Message-Id: <20220826100052.22945-8-jmaselbas@kalray.eu>
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

CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 fs/afs/flock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/flock.c b/fs/afs/flock.c
index c4210a3964d8..801fe305878f 100644
--- a/fs/afs/flock.c
+++ b/fs/afs/flock.c
@@ -152,7 +152,7 @@ static void afs_next_locker(struct afs_vnode *vnode, int error)
 }
 
 /*
- * Kill off all waiters in the the pending lock queue due to the vnode being
+ * Kill off all waiters in the pending lock queue due to the vnode being
  * deleted.
  */
 static void afs_kill_lockers_enoent(struct afs_vnode *vnode)
-- 
2.17.1

