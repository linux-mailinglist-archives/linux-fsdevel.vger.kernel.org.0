Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D750103C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 14:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731332AbfKTNnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 08:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730153AbfKTNng (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:43:36 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C6A22529;
        Wed, 20 Nov 2019 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257415;
        bh=VjXyEzf6lsm69woqW0wxohup8cZsSX1WZPFKLuG6ML8=;
        h=From:To:Cc:Subject:Date:From;
        b=xjQrrIXa6v2xmhFf5IeJA4RZOAiLpjsYQdxnkTtrIuw5Nb8Bjec84w7zYzXNfurqC
         Wx3IMp9fXtg1M1fA5ce2iBIAvKrp+ZE7P+GonQMlyYHCyL391K//SQkelDYmGgZmcz
         Hpuq2o1Qsq3v3pgxk6NEM7fao7fGhT2geLh28qg0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:43:32 +0800
Message-Id: <20191120134332.16650-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 fs/fuse/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 0635cba19971..eb2a585572dc 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -34,7 +34,7 @@ config VIRTIO_FS
 	select VIRTIO
 	help
 	  The Virtio Filesystem allows guests to mount file systems from the
-          host.
+	  host.
 
 	  If you want to share files between guests or with the host, answer Y
-          or M.
+	  or M.
-- 
2.17.1

