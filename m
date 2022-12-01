Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B2763F40A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiLAPe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiLAPd7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:33:59 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE691144;
        Thu,  1 Dec 2022 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669908800; i=@fujitsu.com;
        bh=N56u62cITdKOZ72UbsVRhOqgpDhCsAHPIjg3XTUEUqo=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=ZqX9Ng/A5FRaOBokMqIa1rXjoF/vL4mEWMY9qBs6VW9pt/CrHzwlPyE0l++hjl5/y
         dtYF0f14NOEulZWC7nEIWnb0MVrKLdXclRd4PbV0I3QmTfGl6qOnbvHaWRalVL75Vs
         /9PQhTnveAm247+CIRT9N4gAExtzOGHADFYJt0qw0rWWprL4i+1sk7fVBv4KXws/5L
         1j1sveZ9b55rwjadsclvaaNYq9IvzA0uqiVTdNMrSm1CDhcb+YkMxU22Y1NWU/K1DQ
         w1ywzpvnWTBiguOaldpkj/8aOEh+GrjOwwMhxfVDEmcKWNDYcgQXPm2lGbyvFEpbBG
         74+OhpNxjmhvw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleJIrShJLcpLzFFi42Kxs+FI1LU/2ZF
  s8OuMssWc9WvYLKZPvcBoseXYPUaLy0/4LPbsPclicXnXHDaLXX92sFus/PGH1YHD49QiCY/F
  e14yeWxa1cnmcWLGbxaPF5tnMnp83iQXwBbFmpmXlF+RwJpx8d4FpoIVXBWXn89gbmB8ztHFy
  MUhJLCFUaJxywVmCGc5k8SMwyvZIJw9jBLTv01i7GLk5GAT0JG4sOAvaxcjB4eIQLXEraVsIG
  FmgQyJ41f+MIPYwgJuEp9vPwezWQRUJOa3H2QFsXkFXCV+d95hAbElBBQkpjx8D1bDCRR/+Xc
  jO4gtJOAicb35IDNEvaDEyZlPWCDmS0gcfPGCGWSthICSxMzueIgxFRKzZrUxQdhqElfPbWKe
  wCg4C0n3LCTdCxiZVjGaFqcWlaUW6RrpJRVlpmeU5CZm5uglVukm6qWW6panFpfoGuollhfrp
  RYX6xVX5ibnpOjlpZZsYgTGSkoxy+wdjD1L/+gdYpTkYFIS5dXe15EsxJeUn1KZkVicEV9Ump
  NafIhRhoNDSYI3ZQ9QTrAoNT21Ii0zBxi3MGkJDh4lEV6+Y0Bp3uKCxNzizHSI1ClGY461DQf
  2MnNMnf1vP7MQS15+XqqUOG/gcaBSAZDSjNI8uEGwdHKJUVZKmJeRgYFBiKcgtSg3swRV/hWj
  OAejkjDvtm1AU3gy80rg9r0COoUJ6JRIsTaQU0oSEVJSDUx7StSUf/q9cbwdxXSDReDKiie6G
  nqBtyar6LrxKldu2lt5SVzgbDqn6lOrxxP2SGje/nAus+VBsc3PhntM/VyH1uuvs5xy/5yHC5
  fQ8bBV663V9sSf3eL3vWWJqJd9uu57ceE8h2v5TUfj3Dq7uSJ6C55+iJundn7ngu77p7+GtNi
  7S79nvWO2r9pddZXyx1nT/rX26ruuWfjRKn3HdLv4mUZsOpePGMrd7Ht7o1dTz08iLXtqzUqH
  uwv/aiUbyQVW7znk+/6K2IMVUdErJrH2dCx9kbd0VY7unK+zPKxtncqd7ETXpOY7lcbN2P1h5
  xKFhMVB7J1WbO8m7mz6/qQjoyF1yqceVxc+9fh5/5VYijMSDbWYi4oTActQn4KiAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-20.tower-585.messagelabs.com!1669908799!42492!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23032 invoked from network); 1 Dec 2022 15:33:19 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-20.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:33:19 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 297E81001A3;
        Thu,  1 Dec 2022 15:33:19 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 1D4EB10019E;
        Thu,  1 Dec 2022 15:33:19 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:33:15 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2 8/8] xfs: remove restrictions for fsdax and reflink
Date:   Thu, 1 Dec 2022 15:32:53 +0000
Message-ID: <1669908773-207-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the basic function for fsdax and reflink has been implemented,
remove the restrictions of them for widly test.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/xfs/xfs_ioctl.c | 4 ----
 fs/xfs/xfs_iops.c  | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 1f783e979629..13f1b2add390 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1138,10 +1138,6 @@ xfs_ioctl_setattr_xflags(
 	if ((fa->fsx_xflags & FS_XFLAG_REALTIME) && xfs_is_reflink_inode(ip))
 		ip->i_diflags2 &= ~XFS_DIFLAG2_REFLINK;
 
-	/* Don't allow us to set DAX mode for a reflinked file for now. */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
-		return -EINVAL;
-
 	/* diflags2 only valid for v3 inodes. */
 	i_flags2 = xfs_flags2diflags2(ip, fa->fsx_xflags);
 	if (i_flags2 && !xfs_has_v3inodes(mp))
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 2e10e1c66ad6..bf0495f7a5e1 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1185,10 +1185,6 @@ xfs_inode_supports_dax(
 	if (!S_ISREG(VFS_I(ip)->i_mode))
 		return false;
 
-	/* Only supported on non-reflinked files. */
-	if (xfs_is_reflink_inode(ip))
-		return false;
-
 	/* Block size must match page size */
 	if (mp->m_sb.sb_blocksize != PAGE_SIZE)
 		return false;
-- 
2.38.1

