Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6824F1CFD28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgELSWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:22:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46509 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELSWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:22:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jYZYL-0006pL-CA; Tue, 12 May 2020 18:22:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs: remove redundant assignment to variable ret
Date:   Tue, 12 May 2020 19:22:53 +0100
Message-Id: <20200512182253.223249-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable ret is being assigned a value that is never read and it
is being updated later with a new value. The assignment is redundant
and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index b0a511bef4a0..6674c2af26ef 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -2052,7 +2052,6 @@ SYSCALL_DEFINE5(watch_sb,
 		if (drop_s_count)
 			put_super(s);
 	} else {
-		ret = -EBADSLT;
 		down_write(&s->s_umount);
 		ret = remove_watch_from_object(s->s_watchers, wqueue,
 					       s->s_unique_id, false);
-- 
2.25.1

