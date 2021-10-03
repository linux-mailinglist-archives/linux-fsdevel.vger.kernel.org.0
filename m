Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D95420188
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Oct 2021 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhJCMZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Oct 2021 08:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhJCMZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Oct 2021 08:25:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B8386187D;
        Sun,  3 Oct 2021 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633263812;
        bh=jrJq9ewHQ7xvcPvGQTwNfqyqw+JixFYhwnQlpsl5L3s=;
        h=From:To:Cc:Subject:Date:From;
        b=HpmYeDLlo/MeIafgbq40IZGCusmmUWqCpwQECtqF88QALrM6ZhjgeBLc8SvsX/lvc
         5EEs4ognKs570YjoU0KEdFkruM9KR5b7CebyWV9HMxbNsgcwGSL7t62Bfrtzh4v0A/
         IuHjEyrBFpmrO3yq1pBChl2eFPPecB1qadKB/oXlTeUEhk/z/fsGNKKIPtOIJNMZEb
         nyE1B9trfnuW4CBv/geWMTvC9f1+wJOiBdqDTh1l8Psu0VXI8kFilx5zSgcbEHo0b5
         Sr/6sI14dwZJLWlAJiEK6qx1u+s1hcM49b+f68rdcgGO6hmyh/N8q9pUb2AMQrlw3Z
         N8doOKSdPUjUw==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     alx.manpages@gmail.com, mtk.manpages@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v2] mount.2: note that mandatory locking is now fully deprecated
Date:   Sun,  3 Oct 2021 08:23:30 -0400
Message-Id: <20211003122330.10664-1-jlayton@kernel.org>
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
 man2/mount.2 | 2 ++
 1 file changed, 2 insertions(+)

v2: use semantic newline, per Alejandro's suggestion

diff --git a/man2/mount.2 b/man2/mount.2
index bedd39e68a68..302baf6ebeb8 100644
--- a/man2/mount.2
+++ b/man2/mount.2
@@ -196,6 +196,8 @@ this mount option requires the
 capability and a kernel configured with the
 .B CONFIG_MANDATORY_FILE_LOCKING
 option.
+Mandatory locking has been fully deprecated in v5.15 kernels, so
+this flag should be considered deprecated.
 .TP
 .B MS_NOATIME
 Do not update access times for (all types of) files on this filesystem.
-- 
2.31.1

