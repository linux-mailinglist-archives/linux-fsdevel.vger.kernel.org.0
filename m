Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8B30491C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387537AbhAZF37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:29:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33029 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbhAZCk7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628859; x=1643164859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j0EWFLd0YVg9PnzQoQvxkFICOjN0HWzrNeMzZ6iJiaE=;
  b=GXEokJEJoBHvUzOdMjrzIbIQ73Ku5DUqYTmDveXrwlZix0iFDMv0hhdv
   olqLD495UpHqRL7HkSGbdcynE9Dw1DUkkD8Vply/eB5EVwkTiEU4gLXcR
   qMP9JzOcJ+40wzxP190ZZ6ymEc9rOuobz8YjIScEv/CcV04TcaBE+2Bfq
   hlBmSxLYuG52ztP7qpCRG9JbKkKX05CGXuMo/uzDX/lHpvlVSCAXZ8pYN
   NTDskFwky7o6+tW36dsKM0mQEk14yALv1SvEZLq9mmnLWMOf3nEv4NsWs
   RGS1oyGiQAUW+Ony60TfZURGaqZlOnpCZNHWfiVPfoBeuJY0R/00H2hx1
   g==;
IronPort-SDR: 9nUp3QNPXBXrkljaXBPO2m1YJHZDABIqf9EXfEnys7pYRsQipgv9CrHR0XX5/qEOjMiO0qssSU
 NMJTYC8jWC4/9RjI5rZzfYwtjLW4UIZxi6gJ0cwVuJAiHxd178BYrDgej368jwvtekapsZ4F+P
 TMKQDNmYeYOONF8vMB2mI5Jarx3iiOSO1v/Pfkq1FFjHF0EWPUiDQ0JTvudBoaLebRPl7DfM7a
 1uJcQ/YfATzJGMWDhej9rIdzsBy07rDIFLYpB6NIVthAaqE+nGdCqDef6iIwBrcWX+T9+TrNUN
 JE0=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483569"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:52 +0800
IronPort-SDR: CYIDFRa0CIyJNytJOFUiOahm7NgC7Mkc0dkRB3bbCfLAUK4N84whmA/Rz5NcY+jolFXqAWxeDF
 nlZ8o7bOO88m1qvauqR+T+xreeXaoBOrj9lzRXXORhu9JUmE25F3hcd2uRUMXvE6lE2QuiF99x
 tTRoDmky46Biilay7HIX3hhXRgk5mhnBk2icHLU+sDQ19uHwuONVs8A6EkJhYGev5Ehfc3X1IV
 LbYCIdxG+pa6r8/upE81ytbvFf9kGvzLRH0zde54t7A6wZVDEa3oYrEbfpD+8xu0fmn50Yo35f
 23o/cOytVwEQZvKnAfJ+Z4V1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:18 -0800
IronPort-SDR: MXxqvCYH5A/InhK+760NThT0W0ZGWOmfnZkyK1c1plG2NR8N+DsopklFs0lYOYAQnq75Qs3mq7
 sm5t5lVwVdKnIMAMkCLhZCrx6CBgLu08hCaoTUYm6vcDyTuVHLWTpQEa9jhju6KkaOpkd+yi6S
 wmE83+EkkkmeycKmNzU9HXpRhEyf+AnRqlbNinW2OH1hzqrxRVB9pG153Atccvg1tzex/l+Vqd
 mUlRYQFtUJhmH5QQbelgBi6JFGG0YzJpDCqO53YBBFngvMdD6/zyC99OffaRkFLNy3bD92FoeF
 5Cs=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:50 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 31/42] btrfs: wait existing extents before truncating
Date:   Tue, 26 Jan 2021 11:25:09 +0900
Message-Id: <43dc46a32f060ab1e76cb0a7d98e517de2a73356.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6d43aaa1f537..5b8f97469964 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5171,6 +5171,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_is_zoned(fs_info)) {
+			ret = btrfs_wait_ordered_range(
+				inode,
+				ALIGN(newsize, fs_info->sectorsize),
+				(u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.27.0

