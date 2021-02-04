Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A339A30F0F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhBDKex (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:34:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhBDKdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434811; x=1643970811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31ceDJu2kLyRBJSxuPw51RxbKy7EDLDCYjcUDI+Ih0c=;
  b=iK/4ap8s5vRcfZH1mo/7BWobxGqXKBnCRbZfI6zSugxO50peQZva0RHJ
   eTsBzVIQ4q5q76CzrRGGvcm2B92H3t1vHNRp7oEH66EovK25WOTqYwwRm
   BlZ1GquEP5CJf/rI1hAH8ECPnngv9TlXiQ6NUotghUa3wBZngRO37PzsA
   xwzl0URKiS1fCfjufXxcdeVOcZzJK2XyBrgELiT9u2s+eYYnW7LGK/B6j
   bw+j2Tt9JbH+Tlm3tL1OuUb+Y5hLzP1sgcXzMHg1sY47xNL6uzy1vXIFm
   FfEemlt24L/ruJOEMPt20VQCyZh8+0M9xCI5dWYCucpDGeqcPqtt4ZMSE
   A==;
IronPort-SDR: tnaOEmcMNeipcyXOMY60qH+uYVsKk3Bnue0vGtzE5oLeAR1Kz2mUXCs4c1MdYrr8d8rai7J2eO
 1jBf2TMcBon8ENA8wadO30KqhX6lla8kSon0Gz3n6vvy/qVw+6trOusZUCkks4xvH6/aqz/I+P
 5GC6bWBJl1LBdu+BoLRbzPCS5nJlAO6ufpAsuxjURUcgklLpLdJy8v4lWlZdYaBPVVTgl7yx9K
 1diayeP6vHcdQHTJD5ifZeSLOKQWHyO8mxpMZMGHzULqruRh3WwE+6t1QKSEI3I42UMe7mNnTZ
 Jl4=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108084"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:55 +0800
IronPort-SDR: OVHgJQ3bgR41zYSJtU8G9HsmI1A9EX4o+e7nH5UKseXmTwwqRtI2hvJODy+mZvQkqVkO8cCpW9
 KrjKP1V76y8vmNathwoqjz/11/9q/swaay3ZGQCI33gRR1Z1+l3fh1STcqggE323uI8x5vAVaI
 HLo1hRkO1mn3qTf+ybDoIFKvqdQOiydIW+72j3KirRkDJZc6Hug9vNfkil6Odm87pDm8BIZ3uj
 TJt0J2KGJfQBCGIHhple/Is8md2jfQOmykiXUESeXsfNuSt+4YwdcGbsR9I+Uws2I1+iNaFV0e
 bROZygCmSq9dgDnbt8aCN90A
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:57 -0800
IronPort-SDR: bhAZBBYJgUmAD9uq0Cj8A+j6Yx8yy9iAZR6FiU0YSA0oaDRAvPm87oTrdCc+iixOqoWes79nNV
 Z1nAnYQ/lRLKr8HVq2j/5z1LzQea8rO/+fPXPNCmVEI+DqSXSBJ3xnEM9yKtfVOcrFSPOteHUK
 n8IMottmv1ZC09PPFuFVhycjM1TjpEMQQqIQdtVx4HUXm6QevwUQeoMqIQ+zFb1kR/RffaOmw5
 4mAamcEc91TykVLeMnPqjV8n+DC1vM0zqpPrrpMkzkJuV6o8ktzfXjWwoEXzVqmY8i4o3uIJu6
 4sM=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:53 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 42/42] btrfs: zoned: enable to mount ZONED incompat flag
Date:   Thu,  4 Feb 2021 19:22:21 +0900
Message-Id: <7c375b7f63706927869c142b2bb408828472445f.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the ZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount ZONED flagged file
system.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6f4b493625ef..3bc00aed13b2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -298,7 +298,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.30.0

