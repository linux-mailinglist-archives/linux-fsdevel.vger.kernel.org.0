Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19112E04E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgLVDwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46466 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgLVDwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609133; x=1640145133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FlPdWIqtYD5Xxqc/lXmoy2E+ERH2oUzLhki0CTMZK1A=;
  b=kZsdPq4nmLG45Xbdd1UnRBoILlNjF42YX4KtCmnYBrUQdjTYoPhllnh1
   3OembAFRtslWGnJ6FI3InidszPpjpiS2gu3UXI0rtHeU950ow0i9kqPwm
   ajwpOhP+zFaHHL0Pf5BacB9KvLTmpFiVOFT0LYI8rbX/McSt2hYUAh1vR
   L+85Hx9pOKSIfJq8jNVsA+17khetBKebN6UlMN85m+hz6Ke6D1QJEwnzS
   n7FcGtdQC3nnMaxt6rgyP+ZfFhAfXj4GP7r273qNKZgOiXkLxMNSb3zC8
   FX/VjrL0NVcdwZCzxQMPKzIQ7ZSVNuh0iGfIKRyt3MqQKET8r7gLDQfmM
   w==;
IronPort-SDR: tLPwYvfGTVnCpDiWYb+IE7Y5wtvrxAHeh3p7EAkhX7S0UnLn8uSd4I1uCf5zXA6Y17SnaGJmWI
 ZBr+OCHpZ5LJWShHE2Z9wZWhZ2ifTg4jsnk8/5MlmAzLZ9tB8v810dsZuEY/RE1Fatgaho4ydV
 9Uky+O/EumaMTKQdfiQ8BjS/bIgE14Awt4+yeYfpSW+7ZPCBS+3XpP2v6kQ6UaJ6Z2Jd5ot53g
 wjdvP0VC488NA/UvKnctFxNq8FCMeHwaAv60XGl1PwP55++NuMaWzzNYP5HigiGVEzYwN7g1aU
 66o=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193731"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:32 +0800
IronPort-SDR: 0D5PeZUHVnV4btp99cfcFo0wrnFZ4cUfldkU8edrQr7neXVa0+Q3ykgtEznR7bxCIOc3vbjlW+
 PMMlPJe6P6PAOqPkStV34Na6a9/exBwTjRyJufdtLt09xjaVWeLhsbblywUhRsZ2uE2WyuhzgD
 BPMCHQdbdTW8243HO90g/Fy5Oh2Kbl6kNFHdcoWSyPWqKZ+yXlC4PbDO77DqOZ0KaxKuIPUtpV
 e4JwwJW+itH2HVKL0SWu99CChEMwMP466ChE3zIk5TKFAw5Tb+zvs+E9ACPniBBw1z8BlCSQv5
 txYM+qhnic2FsnM00+coHb3m
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:43 -0800
IronPort-SDR: qDSeSD3IE8hgUaV1F4PKc53mdmhAUnjnFHpK75J04TFq3YlUXGEwnGzANJOm7VIhuKo82a6iN+
 BPu988H9iat3nEVyjq4H8FZBl40uJjUiJjfs6dPdsTHNmXrjS2p8qRSTYHt8hZVxV1eC2liBFZ
 nDQO7pZz5JFi4D9/KyHkQZb50cHAPeCk9/6yRt8eCqMVPAScHKo8/KCnOVQaoHsJB5lOen/5hg
 5QE4GX8M7qBfSVT7JnBpxIdOwvLKGPJgWfY2qRggX0UkVCzHzIMM5WHWJC4WTyTtXgQxUecfKo
 Qg8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:31 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v11 05/40] btrfs: release path before calling into btrfs_load_block_group_zone_info
Date:   Tue, 22 Dec 2020 12:48:58 +0900
Message-Id: <8fa3073375cf26759f9c5d3ce083c64d573ad9a6.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Since we have no write pointer in conventional zones, we cannot determine
allocation offset from it. Instead, we set the allocation offset after the
highest addressed extent. This is done by reading the extent tree in
btrfs_load_block_group_zone_info(). However, this function is called from
btrfs_read_block_groups(), so the read lock for the tree node can
recursively taken.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b8bbdd95743e..69e1b24bbbad 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1839,6 +1839,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		return -ENOMEM;
 
 	read_block_group_item(cache, path, key);
+	btrfs_release_path(path);
 
 	set_free_space_tree_thresholds(cache);
 
@@ -2009,7 +2010,6 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 			goto error;
 		key.objectid += key.offset;
 		key.offset = 0;
-		btrfs_release_path(path);
 	}
 	btrfs_release_path(path);
 
-- 
2.27.0

