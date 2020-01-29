Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B911914CED8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 17:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgA2Q7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 11:59:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46181 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbgA2Q7i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:59:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id z124so45310pgb.13;
        Wed, 29 Jan 2020 08:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v2M483Nb+iZkWZmPc4XRqpPz0Lt+K12nY/QlfnPGK2M=;
        b=mJu7NoGudWfCS8cD7W26V3T2ehy3yTffZ9Ef64UIY4yUU8URmZvnIZ0z2FBILyF7KF
         x7z1pA49lxyD7b0NMenTv0yCa697NCxI7tz6Zj/YgjIPmB0Ps6Pgjdh0EweDi8FEGJqx
         Sf2B1od5u3Ei/D1WibtvEhJqqv517GwBoPnfv+Ib+NL9dtFkyunT9UdIBrlAmWs0f/Z0
         J9rszrLfnIyxPf4yAJ1eA+Khju15+BMsEYrY99WXcKLHDQlJz7dq9RPp0lmOCt/Tdr7P
         B23U7u46R+Iw4Lgyda7ghaolzEii6pyIKMSDFVYE4u55cLJlWcP1ID+bR6WSiQ7dDky0
         cCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v2M483Nb+iZkWZmPc4XRqpPz0Lt+K12nY/QlfnPGK2M=;
        b=fzAmZCq0vY3u3FadWU7r5VrAxr+ZsxPZeh3MyhsACSifJrPkOUu1oZ32U0x92Ln6rK
         +N3V3lqpezsN3X9Bgvg/hmCOa63H1TDolVF/+V/8sVkpS0ZHPTrJ9JVawxGMVrhaBy9Y
         F6+OFVkH5GeP+O8Bt1KyZ5bvW2v4rNy93Cl49ClFJhDxwMIzu72nD3FbuVcX2XhIogcK
         w5xEzev4nNd0DYzxCQ5enfixJyfLJGBRvJY9hrNVbdc3zVDx2NMNzdmkO9OQFINhpU73
         68+fWlGWOw/Udq+tSv7ejfyzzisxJHUwd4TJgORVZYYsp962vHzT5Rdx1FnkW2HyHmlJ
         +Xlg==
X-Gm-Message-State: APjAAAV2wLrhbz3PWbhFSj8UbvTBkL9aRopK78V/3IckGKYenncFd7Pt
        baj1aOp9AocJOj9Z4/nJyO8=
X-Google-Smtp-Source: APXvYqw/2sgeGJUjeHgta0fESRcIDWKcAefrypgb55KtWV4ikjhcQ+MRA6SEB/hicXdUbOEGXGWRHw==
X-Received: by 2002:a63:fb05:: with SMTP id o5mr32245884pgh.355.1580317177241;
        Wed, 29 Jan 2020 08:59:37 -0800 (PST)
Received: from localhost.localdomain ([2405:205:c92f:3ccd:49ce:a9e3:28b5:cf94])
        by smtp.gmail.com with ESMTPSA id f8sm3223610pfn.2.2020.01.29.08.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:59:36 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 08/19] staging: exfat: Rename variable 'FatType' to 'fat_type'
Date:   Wed, 29 Jan 2020 22:28:21 +0530
Message-Id: <20200129165832.10574-9-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200129165832.10574-1-pragat.pandya@gmail.com>
References: <20200129165832.10574-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase.
Change all occurrences of identifier "FatType" to "fat_type"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 55405dcbf8f7..8e01f011ef27 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -242,7 +242,7 @@ struct dev_info_t {
 };
 
 struct vol_info_t {
-	u32      FatType;
+	u32      fat_type;
 	u32      ClusterSize;
 	u32      NumClusters;
 	u32      FreeClusters;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index e51abb9b3826..6278fc3eac19 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -494,7 +494,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	if (p_fs->used_clusters == UINT_MAX)
 		p_fs->used_clusters = p_fs->fs_func->count_used_clusters(sb);
 
-	info->FatType = p_fs->vol_type;
+	info->fat_type = p_fs->vol_type;
 	info->ClusterSize = p_fs->cluster_size;
 	info->NumClusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
 	info->UsedClusters = p_fs->used_clusters;
@@ -3348,7 +3348,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 			return -EIO;
 
 	} else {
-		info.FatType = p_fs->vol_type;
+		info.fat_type = p_fs->vol_type;
 		info.ClusterSize = p_fs->cluster_size;
 		info.NumClusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
-- 
2.17.1

