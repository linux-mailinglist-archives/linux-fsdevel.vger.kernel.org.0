Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C815B5E64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiILQj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 12:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILQjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:39:23 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A842222AC;
        Mon, 12 Sep 2022 09:39:22 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 055772265;
        Mon, 12 Sep 2022 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663000641;
        bh=k1qhfi942LE6et0zq9FDdggKuBLOcG1Kzr/POuv/F9w=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=VECAkElB4j3C9MnLL7fUB58mtTdpPtNMIDC7Ail0aFvOwf2QsVZarsXMqa7SiwQSY
         tRk/7GoRc6L58P2FaEoKZ+wT8+BnPmP6b8qZrqifjHvYZHRZEZtm7VlhJnjy2ZLTfF
         hsvKdbuje0b2ozaE7ZnMChrAYDAvncsvvtJGV9zo=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id AC2DD22FE;
        Mon, 12 Sep 2022 16:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1663000760;
        bh=k1qhfi942LE6et0zq9FDdggKuBLOcG1Kzr/POuv/F9w=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ZUyYOR9NMBKInXXOIIOZNPUM8MAVqRQ5n6Kummmv3Y3xq7jwFfA4qisbK758Nbo9U
         SOhWV0nbgkSpzCsgup64/vGqL4FUa/IcwAy8vv1c+6FtAJ1/bkHkKLtbuac3Po/IBi
         iXQshGkpAWgPuGflFfLkAO9Jd5ibYBY/DwcCoaLY=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 12 Sep 2022 19:39:20 +0300
Message-ID: <c1fd8894-aaba-c5ff-57f2-480c480880f7@paragon-software.com>
Date:   Mon, 12 Sep 2022 19:39:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 1/3] fs/ntfs3: Add comments about cluster size
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
In-Reply-To: <59960918-0adb-6d53-2d77-8172e666bf40@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds additional info about CONFIG_NTFS3_64BIT_CLUSTER

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/frecord.c |  2 +-
  fs/ntfs3/record.c  |  4 ++++
  fs/ntfs3/super.c   | 24 +++++++++++++++++++++++++++
  3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 381a38a06ec2..b752d83cf460 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -557,7 +557,7 @@ static int ni_repack(struct ntfs_inode *ni)
  		}
  
  		if (!mi_p) {
-			/* Do not try if not enogh free space. */
+			/* Do not try if not enough free space. */
  			if (le32_to_cpu(mi->mrec->used) + 8 >= rs)
  				continue;
  
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 7d2fac5ee215..c8741cfa421f 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -537,6 +537,10 @@ bool mi_resize_attr(struct mft_inode *mi, struct ATTRIB *attr, int bytes)
  	return true;
  }
  
+/*
+ * Pack runs in MFT record.
+ * If failed record is not changed.
+ */
  int mi_pack_runs(struct mft_inode *mi, struct ATTRIB *attr,
  		 struct runs_tree *run, CLST len)
  {
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 47012c9bf505..86ff55133faf 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -21,6 +21,30 @@
   * https://docs.microsoft.com/en-us/windows/wsl/file-permissions
   * It stores uid/gid/mode/dev in xattr
   *
+ * ntfs allows up to 2^64 clusters per volume.
+ * It means you should use 64 bits lcn to operate with ntfs.
+ * Implementation of ntfs.sys uses only 32 bits lcn.
+ * Default ntfs3 uses 32 bits lcn too.
+ * ntfs3 built with CONFIG_NTFS3_64BIT_CLUSTER (ntfs3_64) uses 64 bits per lcn.
+ *
+ *
+ *     ntfs limits, cluster size is 4K (2^12)
+ * -----------------------------------------------------------------------------
+ * | Volume size   | Clusters | ntfs.sys | ntfs3  | ntfs3_64 | mkntfs | chkdsk |
+ * -----------------------------------------------------------------------------
+ * | < 16T, 2^44   |  < 2^32  |  yes     |  yes   |   yes    |  yes   |  yes   |
+ * | > 16T, 2^44   |  > 2^32  |  no      |  no    |   yes    |  yes   |  yes   |
+ * ----------------------------------------------------------|------------------
+ *
+ * To mount large volumes as ntfs one should use large cluster size (up to 2M)
+ * The maximum volume size in this case is 2^32 * 2^21 = 2^53 = 8P
+ *
+ *     ntfs limits, cluster size is 2M (2^31)
+ * -----------------------------------------------------------------------------
+ * | < 8P, 2^54    |  < 2^32  |  yes     |  yes   |   yes    |  yes   |  yes   |
+ * | > 8P, 2^54    |  > 2^32  |  no      |  no    |   yes    |  yes   |  yes   |
+ * ----------------------------------------------------------|------------------
+ *
   */
  
  #include <linux/blkdev.h>
-- 
2.37.0


