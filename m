Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB88E59AF64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiHTSNB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiHTSM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:12:58 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19E73FA3C
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=qUxCNhcqCYTHTQj3KCybTvh8q4QjTCrfzT8zBH27rNA=; b=SwMldMlWiZ+ZpylSYUn6zcbSnh
        vAgZ7uVeHOrT59SZzjT+sSyFb3qoHLo17K1JCAeJN3NWCl3kOGbF98cMhzH3WnmKKaUxZImqevYHZ
        IVzPCOLtg1M7hQ2wEZS11mf18HrstDHcIrHrTQi1duYopL/xatwJLFeUD+S862TvHdNX0OJAuOqlP
        CWow9QLWr8NwqgerZESU4H6YI0+RULUvUwu/qoG4VdPkw4VKVMGC4HQiF/BKkCKdlnTf9WvDenzsm
        bZlLWCENIKyXnEX+zOXtf8Wm12qD6uThcQIkY2RWTAunrFi8dMIOYO9gPu5afi1dZ1ph6eX629Xr8
        xiXVxtSg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxs-006RVh-6P
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:56 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/11] do_sys_name_to_handle(): constify path
Date:   Sat, 20 Aug 2022 19:12:47 +0100
Message-Id: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <YwEjnoTgi7K6iijN@ZenIV>
References: <YwEjnoTgi7K6iijN@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6630c69c23a2..f2bc27d1975e 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -14,7 +14,7 @@
 #include "internal.h"
 #include "mount.h"
 
-static long do_sys_name_to_handle(struct path *path,
+static long do_sys_name_to_handle(const struct path *path,
 				  struct file_handle __user *ufh,
 				  int __user *mnt_id)
 {
-- 
2.30.2

