Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FBE6118AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiJ1REP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiJ1RD7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:03:59 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4117C74D;
        Fri, 28 Oct 2022 10:02:59 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BB693218D;
        Fri, 28 Oct 2022 17:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976418;
        bh=/mJlfZpKQiISMX08oxRpKAnkO7e2Q5yFIpcw3wftSqA=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=o/smmKU0axmJVk+bWKQYA8tJM7Bcix5OROTciVjH4DN5LHz7y+htVHZ0pj667fdnw
         20CJztmqj5p0wPVUPm9qFr9SpqMNLQz1QM7Ryr01t7EAlLvbtzvqILonk1BJB2loZq
         oYVjgy+VPls0jpJQvLUiYAFf2PiRwD7wSl1BOb6U=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id B3FFDDD;
        Fri, 28 Oct 2022 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666976577;
        bh=/mJlfZpKQiISMX08oxRpKAnkO7e2Q5yFIpcw3wftSqA=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=ok6hQPEiCLvCjCtq1SSO+CfMUFC+fzXIKSX7vR9jqK2GOvwf+cJJsxzg7Da4XLSae
         9GJZ/Wg6RJ9wYjFOSMDYJe2QQnJjEAQKrYhjyc/KAicmIuptR69nS53FJ0B/oqp5Jp
         6XgwLZc+J8GUc1D8K/xV2iV2NdGTY8AYlKLuKVus=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 28 Oct 2022 20:02:57 +0300
Message-ID: <c318809e-df14-c03c-b122-8a84f979331c@paragon-software.com>
Date:   Fri, 28 Oct 2022 20:02:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 03/14] fs/ntfs3: Fix wrong indentations
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
In-Reply-To: <fc5957cc-a71b-cfa3-f291-cb63b23800d1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Also simplifying code.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/fslog.c | 3 +--
  fs/ntfs3/index.c | 8 ++++----
  fs/ntfs3/inode.c | 8 +++++---
  3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 5289c25b1ee4..e61545b9772e 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -4824,8 +4824,7 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
  		goto out;
  	}
  	attr = oa->attr;
-	t64 = le64_to_cpu(attr->nres.alloc_size);
-	if (size > t64) {
+	if (size > le64_to_cpu(attr->nres.alloc_size)) {
  		attr->nres.valid_size = attr->nres.data_size =
  			attr->nres.alloc_size = cpu_to_le64(size);
  	}
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index bc9ab93db1d0..a2e1e07b5bb8 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -625,9 +625,8 @@ void fnd_clear(struct ntfs_fnd *fnd)
  static int fnd_push(struct ntfs_fnd *fnd, struct indx_node *n,
  		    struct NTFS_DE *e)
  {
-	int i;
+	int i = fnd->level;
  
-	i = fnd->level;
  	if (i < 0 || i >= ARRAY_SIZE(fnd->nodes))
  		return -EINVAL;
  	fnd->nodes[i] = n;
@@ -2121,9 +2120,10 @@ static int indx_get_entry_to_replace(struct ntfs_index *indx,
  	fnd->de[level] = e;
  	indx_write(indx, ni, n, 0);
  
-	/* Check to see if this action created an empty leaf. */
-	if (ib_is_leaf(ib) && ib_is_empty(ib))
+	if (ib_is_leaf(ib) && ib_is_empty(ib)) {
+		/* An empty leaf. */
  		return 0;
+	}
  
  out:
  	fnd_clear(fnd);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 18edbc7b35df..df0d30a3218a 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1810,11 +1810,12 @@ static int ntfs_translate_junction(const struct super_block *sb,
  
  	/* Make translated path a relative path to mount point */
  	strcpy(translated, "./");
-	++link_path;	/* Skip leading / */
+	++link_path; /* Skip leading / */
  	for (tl_len = sizeof("./") - 1; *link_path; ++link_path) {
  		if (*link_path == '/') {
  			if (PATH_MAX - tl_len < sizeof("../")) {
-				ntfs_err(sb, "Link path %s has too many components",
+				ntfs_err(sb,
+					 "Link path %s has too many components",
  					 link_path);
  				err = -EINVAL;
  				goto out;
@@ -1830,7 +1831,8 @@ static int ntfs_translate_junction(const struct super_block *sb,
  		++target_start;
  
  	if (!*target_start) {
-		ntfs_err(sb, "Link target (%s) missing drive separator", target);
+		ntfs_err(sb, "Link target (%s) missing drive separator",
+			 target);
  		err = -EINVAL;
  		goto out;
  	}
-- 
2.37.0


