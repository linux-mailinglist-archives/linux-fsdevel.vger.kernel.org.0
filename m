Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9066229746C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 18:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbgJWQgh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 12:36:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbgJWQdu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:50 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5694C246B2;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470828;
        bh=+yokCfZBHZQZytH1I9mxcfAei7oyJOP+8TqDL5TGlyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0vWuH2Bni0XYil9FSemA/qforpzTLOg0gEYlG/7z+4OVU9nhiHSj9E6sPBM8Q6yO
         MVRNBIqUfhLCl8n/RhXV3tUyRb6tFuL0FbQo2LjR2aHIf5YF7KuVIB7uDEtotcvXUY
         pnArGmA62L3xdQIC3+cmJ3QPyvcGJrHGnV20Vtuw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Ax0-8z; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 36/56] locks: fix a typo at a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:23 +0200
Message-Id: <901134db80ae9763d3ce2bc42faa1b2105c29d7f.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

locks_delete_lock -> locks_delete_block

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 1f84a03601fe..f3c3ce82a455 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -750,7 +750,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
 }
 
 /**
- *	locks_delete_lock - stop waiting for a file lock
+ *	locks_delete_block - stop waiting for a file lock
  *	@waiter: the lock which was waiting
  *
  *	lockd/nfsd need to disconnect the lock while working on it.
-- 
2.26.2

