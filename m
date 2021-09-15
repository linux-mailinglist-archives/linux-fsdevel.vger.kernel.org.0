Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0F40CB9D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhIORY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 13:24:26 -0400
Received: from sandeen.net ([63.231.237.45]:33374 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhIORYY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 13:24:24 -0400
Received: by sandeen.net (Postfix, from userid 500)
        id 75109877; Wed, 15 Sep 2021 12:22:53 -0500 (CDT)
From:   Eric Sandeen <sandeen@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     dan.j.williams@intel.com
Subject: [PATCH 1/3] xfs: remove dax EXPERIMENTAL warning
Date:   Wed, 15 Sep 2021 12:22:39 -0500
Message-Id: <1631726561-16358-2-git-send-email-sandeen@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As there seems to be no significant outstanding concern about
dax on xfs at this point, remove the scary EXPERIMENTAL
warning when in use.

(dax+reflink is still unimplemented, but that can be considered
a future feature, and doesn't require a warning for the
non-reflink usecase.)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/xfs/xfs_super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index c4e0cd1..0c71dbb 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1594,9 +1594,6 @@ struct proc_xfs_info {
 	if (xfs_has_dax_always(mp)) {
 		bool rtdev_is_dax = false, datadev_is_dax;
 
-		xfs_warn(mp,
-		"DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
-
 		datadev_is_dax = xfs_buftarg_is_dax(sb, mp->m_ddev_targp);
 		if (mp->m_rtdev_targp)
 			rtdev_is_dax = xfs_buftarg_is_dax(sb,
-- 
1.8.3.1

