Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE33B0DC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 21:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFVTpS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 15:45:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232631AbhFVTpS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 15:45:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7757608FE;
        Tue, 22 Jun 2021 19:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624390982;
        bh=6pPcATNpiKvVpcsoTuMfmganPavsZFx87xngTk9YLXE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ki9mZTmuEfN65nJCdmUdfAKbeZd74NHkrT9wAxHO8NRaQO/Ww4dL2q+wprunUDUAY
         l+KD2H4tIUhy3kWu5aVpOkuTgjKACbU4dn/Q6Se3xl7Vrd6pTf9/N9M6loXoFaAWzX
         eZxcPGv7PbiDFOpAHIyeUnnK2rfCTx4oKEJVHfvAMBv2nh7kAGlVWJMY5m6KvOEvak
         vbz5KaEDAlYdLqRWEHhMT1UZ9vfYt/GJaQmWfzKmtYXL6Y4wBGYQsa31wqiRlNi/WG
         jJKySn++1JJLkWlhSR33rD5TMqu/uVYFCcPCnN9+sMmZdRohOq8XfzV9SThKN0xWot
         +/I5JfVEFSk9A==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Jens Axboe :" <axboe@kernel.dk>
Subject: [PATCH] vfs: explicitly include fileattr.h dependency
Date:   Tue, 22 Jun 2021 12:43:00 -0700
Message-Id: <20210622194300.2617430-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

linux/fileattr.h has an implicit requirement that linux/fs.h be included
first. Make that dependency explicit.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe: <axboe@kernel.dk>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/fileattr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 9e37e063ac69..34e153172a85 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_FILEATTR_H
 #define _LINUX_FILEATTR_H
 
+#include <linux/fs.h>
+
 /* Flags shared betwen flags/xflags */
 #define FS_COMMON_FL \
 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
-- 
2.25.4

