Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D45815A1D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgBLHVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:31 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgBLHVa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492100; x=1613028100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sKKMbBUq06x3XlUxvd0H3BtwariMwcOhdgYDbALvWYg=;
  b=psYEEPYt9eQZ4z9EUPunTNOe7VBOBoRmMFzP3blf0VsZ/kRh4IHAyf8M
   UnvJiMEzU+AlsScz1juU87MMB08sLtlbkv5Dd/pHkJ+fAicn1KKVFZIwG
   gEZND7Le6MmiNjCQDnEvkqWDROW8fUpxNMyQVvh5SCI8WFVINqb3DAazK
   THHhKa1T6tc4OF0sF9XtV7WztBD/oX9wXH81/mS84UkWkTRWL4zKl9s5e
   s/GxHhxECJOh4HKc1fdy6uvQ2WIkHxGZGtHQP27muUrVq1SlY08UCHt0g
   uWMADOZb+rypfMtW9fchhMEteO/2w4++6Zmt0rCgfO2mW6JU9Z4El5I4q
   w==;
IronPort-SDR: ufS8WLDrzodLumPZJYbHaY1ohyS+MYnXQXR4cyactjpbNQGjwqRrJrEj7sP+Jd399RNeznBa3b
 a8Qq7kfO3QdSo82UBkcQVzDSV8Cp+6wzVWUoJ03O/dosw8UDRRtCURDCaBGZbJdbnNC5iiInQd
 clyimo90ulTwcb5RZlWtwVTh2z1Kz6PtSJnh5Z5Rw+QcHYC/rUoJZJxDlRnnH5iV6jvaxIk+Nu
 w4qgY3fqr+5eZq3pr3s95PZI7fcXk9bLW2HZJTlY2qpUmkMMXqZdXYlYWh87/gMF7RjvebSfl7
 CUU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448942"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:40 +0800
IronPort-SDR: rrFDwAiAcQieAkDbcWKOa8AUjX9NE3b7TWcxYl01fTE7lFd4hti5jRgeJgUB7TnInE0CZqxkp7
 Ma37ifpllDXnTw+nhHbMKAnBkQL6NF4DaOiWjAZGxmZS4KlTbs0ipqd6mLNPjvz4aZmaHQltqh
 e4D8Z67D4swJ42UCBRjBI7TuQuVEwjkQzRgihKPAwKwdn4ufPZlaWYk5G/OZA9XYJThqEBXnjk
 4mO3Vu5tIMiYVd9JLhOEmTKxqkM0Xyye4q0r8Njcg9JXegBnEfoMAV+1c26F41RPYIqe8WZlR3
 GGTon05WFzvnmJapEgnopAo5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:19 -0800
IronPort-SDR: lnFZFpzGm6HOlofahB3IVz9SaDZCJbSXwIIL1MOgeP39Q1COCtNt3u5LCz+XOoaG7rBOqR+Ttk
 1YTj7Ta0lgUYQik92jwddaw3C3HjqT8gYDi8LLpOSzgl1tbaHyC+Cyo2RCCDIeDieDcydUdriS
 csVQnXTVfAFzMDhag3xVWP1tQ7xw1tVnXN1XtSgQMZrOuawq8JsOhVu1D6onhWX6jlL7tTHVjX
 HHLx8VKUFUvMq80rkEJCvJSG94wZnWbisIPQO2TQxYnH3LZiUTi1zVvIwr1fg87Wcnzm9lGjuR
 gvA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 17/21] btrfs: factor out found_extent()
Date:   Wed, 12 Feb 2020 16:20:44 +0900
Message-Id: <20200212072048.629856-18-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out found_extent() from find_free_extent_update_loop(). This
function is called when a proper extent is found and before returning from
find_free_extent().  Hook functions like found_extent_clustered() should
save information for a next allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 276c12392a85..f3fa7869389b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3724,6 +3724,30 @@ static void release_block_group(struct btrfs_block_group *block_group,
 	btrfs_release_block_group(block_group, delalloc);
 }
 
+static void found_extent_clustered(struct find_free_extent_ctl *ffe_ctl,
+				   struct btrfs_key *ins)
+{
+	struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
+
+	if (!ffe_ctl->use_cluster && last_ptr) {
+		spin_lock(&last_ptr->lock);
+		last_ptr->window_start = ins->objectid;
+		spin_unlock(&last_ptr->lock);
+	}
+}
+
+static void found_extent(struct find_free_extent_ctl *ffe_ctl,
+			 struct btrfs_key *ins)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		found_extent_clustered(ffe_ctl, ins);
+		break;
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3750,11 +3774,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		return 1;
 
 	if (ins->objectid) {
-		if (!use_cluster && last_ptr) {
-			spin_lock(&last_ptr->lock);
-			last_ptr->window_start = ins->objectid;
-			spin_unlock(&last_ptr->lock);
-		}
+		found_extent(ffe_ctl, ins);
 		return 0;
 	}
 
-- 
2.25.0

