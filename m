Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F58ED73D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 02:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfKDBqp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 20:46:45 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39818 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728825AbfKDBqo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:46:44 -0500
Received: from mr5.cc.vt.edu (mr5.cc.vt.edu [IPv6:2607:b400:92:8400:0:72:232:758b])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41kh7Q025912
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:43 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41kcVi020018
        for <linux-fsdevel@vger.kernel.org>; Sun, 3 Nov 2019 20:46:43 -0500
Received: by mail-qt1-f197.google.com with SMTP id h15so6721564qtn.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Nov 2019 17:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qTxGEwNV+Sk0SeHWmPXlOLn4RKQVFhpEvTO0Y4n51KM=;
        b=otac18CwoDWc0kq9k7t6wiLE2hxfa7B4K/QN3PhLkwse6wDcoXUw6kqCKMN3C8z5LE
         AnlBsJu/95UNNQoLtQZjVnFa44I5GCp6un5weY1ezCwOnZcJmPffMKIsNuIjNojBTuq1
         aKxdfrlUl+PoAMXuCrubWUEskZEagfTuYMxTh3tr1mZpq/7SvYK6PxGTxUUCR5ig9P3D
         2kmV5yszcAJ/4oAWrRh96fjKV5BZpDr+vYbsFUJI7cwAQE+mBptQjU1fhDRtq1fMKj43
         X74PMsKVDvJtrUGoX+kdQC8N7i6bt9BIWw4CBRoeBnnnAHkCqmqkMTz4fpuWckdrPYnp
         sx3Q==
X-Gm-Message-State: APjAAAUnb6INvzOJUoDJMy8YkoGIfRHBdOT2jRlSGt+ZBynCWPmq+VHw
        icIdNLOxqqR/xwqlTiqZSURHcN99oZkxnrC8pUS1DrLMkF3oJTUtUX+X4XArnBkfvW/+HBwDlm0
        +t2d4mFeIQuFZ3DepTzhYgcIy9lsh60HHjntV
X-Received: by 2002:a37:94e:: with SMTP id 75mr11659248qkj.49.1572831998704;
        Sun, 03 Nov 2019 17:46:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNOdjoS+XWcHbmgBG9GQ0EzR72CJJzmH1aqr3uutJM0tM9TeQrkLe8PfSFtpgshzvA329kuQ==
X-Received: by 2002:a37:94e:: with SMTP id 75mr11659237qkj.49.1572831998459;
        Sun, 03 Nov 2019 17:46:38 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:46:37 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/10] staging: exfat: Correct return code
Date:   Sun,  3 Nov 2019 20:45:05 -0500
Message-Id: <20191104014510.102356-10-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use -ENOTEMPTY rather than -EEXIST for attempting to remove
a directory that still has files in it.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index a97a61a60517..e2254d45ef6e 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2167,7 +2167,7 @@ static int ffsRemoveDir(struct inode *inode, struct file_id_t *fid)
 	clu_to_free.flags = fid->flags;
 
 	if (!is_dir_empty(sb, &clu_to_free)) {
-		ret = -EEXIST;
+		ret = -ENOTEMPTY;
 		goto out;
 	}
 
-- 
2.24.0.rc1

