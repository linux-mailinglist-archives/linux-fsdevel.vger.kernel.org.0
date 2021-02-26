Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E83326032
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 10:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhBZJhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 04:37:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36886 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZJhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614332239; x=1645868239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hT5t8N9+1eafwIxw5Z/2lU8vPYtbe54WI5/O9RtLDqQ=;
  b=LygYnrwgulcFfYAm8dMPl+MQlFvOKh8tRQsIk9Vx596KoD6V562ZyhHZ
   FUuW+nRIb9sPSKYF56Fya+/i1XY5wBgcJAyzh9PYsA6v6MHUpdyurWjWW
   0Au0liV23CsECwQnk38HzsqhkVbf6v1tEw0909EbROkXRx3uE8b5uAy3J
   h+NwfVNUcQ2BkFnmiJEARLFN/VsXU5Mu5CRpDP2BQQXmikEixagWhxqya
   SqkpgqAHaztbHvP9Ya4bga9pwu7hmyxVGJtRAikixRuAJrd85i0KinUdE
   PBtliU5EnJlpV1UDUzM1UkMrqL0ovmfbPtcBkDozw28Kh1dH7BpUc3ZzD
   Q==;
IronPort-SDR: otu9uoHpNrbL1TslNo3zG9DkTnS/qQD6visVGoFIzKxjOwoTelJO7T8ghbszSPdSWFdWOjSVyt
 JufEY1koZQeBpMGVg3QbnNDR4mnQY7+b747IoWGscMemccPoOQVdE+ccdQbFZE6zSxiLsm+LyF
 2pD3v8Ic+bbTdQYxdSwqdPikxMrgsn7qerqwq3Px9rRJVmRDj8ZTrO41V5JrBHXNJaefmvu67W
 izkHEHRPLYMmfJgQ9D5eg9rIYI847Vjsdlg59ny+3Qo4fi2Lym+mIYwe0C8no3smmRnEryND7r
 SZg=
X-IronPort-AV: E=Sophos;i="5.81,208,1610380800"; 
   d="scan'208";a="162045397"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2021 17:35:34 +0800
IronPort-SDR: /Jx6IOo8eELqGLY4d3tqzWKYySasKA1m7DFRsDhx2WnVZMj5946QYoYgws9yYMD4ptbf307IWs
 +52ASnwLwb5esbxtq9jaJ4ReofiFi0yWtyxUKZm0nW7j2ttNvghI9sRw0ocBz1MioHBkaivLm7
 EGTiWDHk/iCPTLoceY6xrGPfcykRmfbb6Tt2V2cKAkMko0MWoR9/4SxbOSSSPVEplwe9N3AmMI
 u9DTxTqzGD550SXgw6rjIHWc1Bpcg219HMHNPAM09zLI1y81QyD8yCn4f2RQiUBY5SP1mytZqg
 edrb9FcVNjjWTHePZ6AE80SV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2021 01:18:47 -0800
IronPort-SDR: KVPvnn8FqPPI3MOwHBgw975ZAYAc+WIyq7kQuCMuXcO58SUwPTQSsZt5dRunR1J66o1Fp04CEU
 RvT3IZOclR6liGqAm67zs9RsjL6ZkxEebNBQGTRB0UsbW78ib2QUT4MJyTFfeaYfisGMFcgDyE
 JCHwuEKfM+3Wx8WIGAmSa6k4URPSYgv8HAUQDH5dlXyNbYcHbgFhP4O5GEK/ME2deFNJV8pI+X
 GqWYGFhWWITye5DRuFhyDKgpgmCTKsjQxpqU5USO9t6lkp7tRbf9lkAsOUupA1RSY71YCPRDGz
 lFY=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.63.216])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Feb 2021 01:35:33 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/3] btrfs: zoned: do not account freed region of read-only block group as zone_unusable
Date:   Fri, 26 Feb 2021 18:34:38 +0900
Message-Id: <a2006373b8dc2e13e902f846ee7b2c5a9444fcb6.1614331998.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614331998.git.naohiro.aota@wdc.com>
References: <cover.1614331998.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We migrate zone unusable bytes to read-only bytes when a block group is set
to read-only, and account all the free region as bytes_readonly. Thus, we
should not increase block_group->zone_unusable when the block group is
read-only.

Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 711a6a751ae9..81835153f747 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2555,7 +2555,12 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	to_unusable = size - to_free;
 
 	ctl->free_space += to_free;
-	block_group->zone_unusable += to_unusable;
+	/*
+	 * If the block group is read-only, we should account freed
+	 * space into bytes_readonly.
+	 */
+	if (!block_group->ro)
+		block_group->zone_unusable += to_unusable;
 	spin_unlock(&ctl->tree_lock);
 	if (!used) {
 		spin_lock(&block_group->lock);
-- 
2.30.1

