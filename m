Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCEC55733A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiFWGjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 02:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFWGjt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:39:49 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 027D93A1AA;
        Wed, 22 Jun 2022 23:39:48 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id F167C1E80CCC;
        Thu, 23 Jun 2022 14:39:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZAqX8V4n7lug; Thu, 23 Jun 2022 14:39:27 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.33])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id C50FF1E80C7D;
        Thu, 23 Jun 2022 14:39:26 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] mnt: Fix spelling mistake
Date:   Thu, 23 Jun 2022 14:39:35 +0800
Message-Id: <20220623063935.15493-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change 'propgation' to 'propagation'.
Change 'accross' to 'across'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 fs/pnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 1106137c747a..3d2fc1e1eb45 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -565,7 +565,7 @@ int propagate_umount(struct list_head *list)
 				/*
 				 * If the child has already been visited it is
 				 * know that it's entire peer group and all of
-				 * their slaves in the propgation tree for the
+				 * their slaves in the propagation tree for the
 				 * mountpoint has already been visited and there
 				 * is no need to visit this subtree again.
 				 */
@@ -573,7 +573,7 @@ int propagate_umount(struct list_head *list)
 				continue;
 			} else if (child->mnt.mnt_flags & MNT_UMOUNT) {
 				/*
-				 * We have come accross an partially unmounted
+				 * We have come across an partially unmounted
 				 * mount in list that has not been visited yet.
 				 * Remember it has been visited and continue
 				 * about our merry way.
-- 
2.25.1

