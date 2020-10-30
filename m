Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948622A0714
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgJ3Nxu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:50 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgJ3NxH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065986; x=1635601986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwCyCSgZeSZMQFnd6hq7J9UTcWKFUZUiN9m/ZFj6hDs=;
  b=EGLoqAstI/qiBxsFP4wAfhvEwIkJ3eLHrdBDvg1zaaoJekfzOimOEWMf
   m4hg4dX0fray3Sl+YJMp7c1H0QgRqL2srdEbtM/HnW6qZeDfm+Ih+BtMl
   UwL725IxkgbDna7+cVY5FoQ9mInMgSXPldRAzLgczZ10jfSHOJ09jFSDF
   7AwgEcZoM8uIIoz+EIcRhgSadr5Y54qJRwndWW+3HSXgAZIScA1HAfDyr
   Q3hQ19TKbePeBeqFylFy7UigtxkTF/e/HgKOkqwuCG01e4s0YbxAMT9BF
   LUXFv14HGO5ve7+PVLr/ocJDXNrigm7ARUlsVh1HkCpKO8nqS1PNVNpi4
   A==;
IronPort-SDR: bZeyqme/q4PJsX3GzDBYF/kf7mX2tq5P7N7fouaN7V9gQ0+C5vM0CxqlfN5SlTYrlo+Ll5gGcB
 SLAxg+viKWcwgyWJWzA0fEXUUFkf+bLVMBtVsoo5dOX0A3yF419wpXDFK/f3ePOE5nBFYQH47W
 Jfe8UAMH1lmE2qSNZC4+mQ3BCc6MIpauQB4f0E4n18t5zWgno7E4DnLmTCUSKkxaooYh/8rb0Y
 iJ2VCgCCexEnQvP2Raq/pOrYmAPwKrPw5M+pQ0HT5vf8lNr7DXVxJf4b90dIiEHbsVeamYWP0h
 d18=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806632"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:57 +0800
IronPort-SDR: xq6e/61wUPKynYAHfTHymFD/9UW31lVZzJgkdzMBc7yFwSUG4mBRC8flqpLdWx1/5cj7dxebyD
 kyS0uNR1FJMOW2Uqce452mkKAh2dyrRrqWNtUVyt2XchG07fjzoCNcY6H8/zPkKMfLWRQ9moBJ
 EUkXFwubeu+XGy+LaEELGGi/bIHKQdqmkd0Xf+VHEyrnQ0fmytDc0t4TKnMWzY5+R8PVVjEkfK
 rAByv1n0MoJb5iJOEPXQ4C5YfnnD9cM4MVR1L9WwF0fdnc+AcZG8RT6j32blVorgmDn6Ojcwei
 HVAjqRHcMLFUQldY92AuOsrC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:11 -0700
IronPort-SDR: vmNGjZF5/c0XMdnfClCYhLXdBXqLGu6VvPNLvBsLr89QqM3yefwoq18jKGa/mhVu56QnSOzZHt
 OVIWrWSFvMACLSmFaUoZ1+xpgJPkRGH8hFG1OyinOcIXrsdtjswGTVphmn7ocMj5JM09OTh5Mf
 CiPsplKF7N9l3dCyQfUf1wlMEkqxyr5MO7uCfMTGmDoyWap/h5lVyVtZyXUcGlsd+q9eSCrOCG
 uetLedvts0b2viPHU2ToXZmBdFO2vsfx/fvd5FFP/70EQvpcSFmzK23EgZWcfu3GvwFqN4c0aB
 OQ8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:56 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9 29/41] btrfs: wait existing extents before truncating
Date:   Fri, 30 Oct 2020 22:51:36 +0900
Message-Id: <764d5b98df15deecef0541f872ee6df756986d46.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
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
index fdc367a39194..de8b58abed1d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4955,6 +4955,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
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

