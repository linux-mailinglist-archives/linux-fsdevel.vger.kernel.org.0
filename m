Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8365515829F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgBJShQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:37:16 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33098 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBJShP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:37:15 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so4136966pfn.0;
        Mon, 10 Feb 2020 10:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kCL9QcX2KJtyxfPizFGD83Z8ooNVX2oTvcxNkikn/Ts=;
        b=dj5je7hvcEUczA33TOqtQ+y470CpD8/evhLPIhyNFsLBVvdOuDoALrm4qPp44LIV+n
         cFhJfmAp0GoCzYDPko1mb+BQGvZj8IR+bpqayC2NvaQ5O4R3a9ul7S0jQnY57XYkEuqm
         Hrn+vkKPeaqVERaRhWBi9GnKmfUkk1C0qKTdgkXy0sMC8zec9opfbnvolF2AJpDOYdx9
         ZkNJ1NCxMJ6AFGE2ZBUZnMzFfRVqRI2Woifi7rRGp/BiAk2DCZ4Vi4XMNVycT0bXaUm4
         x+972fcP3l2k1x30FILf1y9v9LleXgNBa9SO23d7NBfGp9YyOMygH7pcZvzsAzfaXnJn
         z6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kCL9QcX2KJtyxfPizFGD83Z8ooNVX2oTvcxNkikn/Ts=;
        b=E42Fjbj/NkKxWKkuX7DUrPdHdrKT1LHLSB3qRV114M4yfCDh6f+04ixAAWKrtYTAzG
         eLQUNL7p5NaQ+RSI1X14a+LDRCpZkEx+AgASFbpTVW2+n34BWw4jRcGU+e39+3TBIPJo
         P+DPkStv2DsQSydE3+lULZX9Gl180iWUdzDiwRG1TEVc1fUvY+f+XEHvz6wdw+SvoPKY
         fWS30KV38LuF6PgyubvIhp9Qdej0u6e/Qiy7FjI+sQccB98olJ8Ac9d0mPwk53Yy75Ed
         6UYVNHhlmf0wKlHxWZ+Ul1DtTkWmxYDEv8+TgIrSywrP292DRpTaGHtlJdVQVN1MoA85
         vnwg==
X-Gm-Message-State: APjAAAWjBqJpalzsnegfGccoWmSlLaUJB/78M2THwsMPZYfP5k40/q5u
        PMPM7paU+ef8OGxr8z7k3/M=
X-Google-Smtp-Source: APXvYqzGxQerJUOOggWdedxuKYWqVlTZmLjKxvVUTa0jHue0GqKzY9ljHH6k3xo3o3HQwp+pM7ssPg==
X-Received: by 2002:a63:3e09:: with SMTP id l9mr3025858pga.149.1581359834735;
        Mon, 10 Feb 2020 10:37:14 -0800 (PST)
Received: from localhost.localdomain ([2405:204:8308:74f3:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id gc1sm124922pjb.20.2020.02.10.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 10:37:14 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH v2 09/19] staging: exfat: Rename variable 'ClusterSize' to 'cluster_size'
Date:   Tue, 11 Feb 2020 00:05:48 +0530
Message-Id: <20200210183558.11836-10-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210183558.11836-1-pragat.pandya@gmail.com>
References: <20200207094612.GA562325@kroah.com>
 <20200210183558.11836-1-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of identifier "ClusterSize" to "cluster_size"

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat.h       | 2 +-
 drivers/staging/exfat/exfat_super.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 43c40addf5a5..c6e3981cc370 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -243,7 +243,7 @@ struct dev_info_t {
 
 struct vol_info_t {
 	u32      fat_type;
-	u32      ClusterSize;
+	u32      cluster_size;
 	u32      NumClusters;
 	u32      FreeClusters;
 	u32      UsedClusters;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 7b5be94a0bb7..cac5631d0f11 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -495,7 +495,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 		p_fs->used_clusters = exfat_count_used_clusters(sb);
 
 	info->fat_type = p_fs->vol_type;
-	info->ClusterSize = p_fs->cluster_size;
+	info->cluster_size = p_fs->cluster_size;
 	info->NumClusters = p_fs->num_clusters - 2; /* clu 0 & 1 */
 	info->UsedClusters = p_fs->used_clusters;
 	info->FreeClusters = info->NumClusters - info->UsedClusters;
@@ -3346,7 +3346,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 	} else {
 		info.fat_type = p_fs->vol_type;
-		info.ClusterSize = p_fs->cluster_size;
+		info.cluster_size = p_fs->cluster_size;
 		info.NumClusters = p_fs->num_clusters - 2;
 		info.UsedClusters = p_fs->used_clusters;
 		info.FreeClusters = info.NumClusters - info.UsedClusters;
@@ -3356,7 +3356,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	}
 
 	buf->f_type = sb->s_magic;
-	buf->f_bsize = info.ClusterSize;
+	buf->f_bsize = info.cluster_size;
 	buf->f_blocks = info.NumClusters;
 	buf->f_bfree = info.FreeClusters;
 	buf->f_bavail = info.FreeClusters;
-- 
2.17.1

