Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5341ECA5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 13:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354104AbhJAL7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 07:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhJAL7K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:59:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4BFC6124D;
        Fri,  1 Oct 2021 11:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633089446;
        bh=X3AOlVRw1jqUcrP+EEw/jyBATlTa51fb5d6ZQwOM0Ek=;
        h=From:To:Cc:Subject:Date:From;
        b=gTM5Mh6ScZDJsOONrizrn4P1a7zjRIMMqQp0RgP/FhbHqO8GVgGXkg5iRiZkQ2azN
         ZL8k6Sx3nqPUxrji7pS2aqUM9BY9ozn40wEVsd9mu0APBmOlpZlMaFoSjUb4eIw6xn
         sjJNuSQAx6JQNwIt0sPkd2B0Apzn8n6Xf/+VtAgJ+TxQaT2p9kXNRvELt7ZTGLtBYO
         ZoIs52+45MfuyPHj/BsOYn8LGxR0g41WSV3AirSAsNFjtWFxUuzhKwnnk6bpDV+8Th
         xI1ueur4Lb6YUuCfzX/kdi5EVjngaHWijrCSCQL1zUrQANgloUrAbv3LfggkxngtcY
         1qEA3mpxWAbXg==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     alx.manpages@gmail.com, mtk.manpages@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] mount.2: note that mandatory locking is now fully deprecated
Date:   Fri,  1 Oct 2021 07:57:24 -0400
Message-Id: <20211001115724.16392-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This support has been fully removed from the kernel as of v5.15.

Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man2/mount.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/mount.2 b/man2/mount.2
index bedd39e68a68..a7ae65fb0142 100644
--- a/man2/mount.2
+++ b/man2/mount.2
@@ -195,7 +195,8 @@ this mount option requires the
 .B CAP_SYS_ADMIN
 capability and a kernel configured with the
 .B CONFIG_MANDATORY_FILE_LOCKING
-option.
+option. Mandatory locking has been fully deprecated in v5.15 kernels, so
+this flag should be considered deprecated.
 .TP
 .B MS_NOATIME
 Do not update access times for (all types of) files on this filesystem.
-- 
2.31.1

