Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0033659797
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiL3L1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 06:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbiL3L1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 06:27:05 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D8E140C0;
        Fri, 30 Dec 2022 03:27:04 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id DF32E20EE;
        Fri, 30 Dec 2022 11:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672399410;
        bh=ETfFUvoUKgLpON3I17vb6pr52MbHQUStImHG554hLLg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=m3uMIOY07QexW/QEC03Gg3hzd1eiQr6WHOX28Wlpvv/DQ0welfS7ZlvIn0FA2yTeG
         8c9BvZsLlZ5lPi2kQjLtpmMa11MfEveTuX3HM0dkq34E4C7o3rDCsh9z6LNRNXfPtJ
         pJAeW6hfWuFrWihLbj6dvwoD5diqRIXlT+f9e8zM=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 770FF212E;
        Fri, 30 Dec 2022 11:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1672399622;
        bh=ETfFUvoUKgLpON3I17vb6pr52MbHQUStImHG554hLLg=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=d+FBdD87msNX675SNfkxg1MWCFE8S9NyJJzohNw8KyCFe/YydT3wivc9wFNptdAyF
         u0H0UVDLkLjZET1sRa/MM6EdA2Cm3xCLSy/V/X1sMGSnAY1Trb4nObxTfAKxLFclzI
         BqV+/25izhjLXiOsOuTmLC1FmROtJNErsi/ZS5ZY=
Received: from [192.168.211.146] (192.168.211.146) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Dec 2022 14:27:01 +0300
Message-ID: <ee705b24-865b-26ff-157d-4cb2a303a962@paragon-software.com>
Date:   Fri, 30 Dec 2022 15:27:01 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: [PATCH 5/5] fs/ntfs3: Refactoring of various minor issues
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <b06828df-f9b9-1c5d-d6db-05839bad7016@paragon-software.com>
In-Reply-To: <b06828df-f9b9-1c5d-d6db-05839bad7016@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.146]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Removed unused macro.
Changed null pointer checking.
Fixed inconsistent indenting.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/bitmap.c  | 3 ++-
  fs/ntfs3/frecord.c | 2 +-
  fs/ntfs3/fsntfs.c  | 6 ++++--
  fs/ntfs3/namei.c   | 2 +-
  fs/ntfs3/ntfs.h    | 3 ---
  5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 723fb64e6531..393c726ef17a 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -658,7 +658,8 @@ int wnd_init(struct wnd_bitmap *wnd, struct 
super_block *sb, size_t nbits)
      if (!wnd->bits_last)
          wnd->bits_last = wbits;

-    wnd->free_bits = kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | 
__GFP_NOWARN);
+    wnd->free_bits =
+        kcalloc(wnd->nwnd, sizeof(u16), GFP_NOFS | __GFP_NOWARN);
      if (!wnd->free_bits)
          return -ENOMEM;

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 912eeb3d3471..1103d4d9a497 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1645,7 +1645,7 @@ struct ATTR_FILE_NAME *ni_fname_name(struct 
ntfs_inode *ni,
  {
      struct ATTRIB *attr = NULL;
      struct ATTR_FILE_NAME *fname;
-       struct le_str *fns;
+    struct le_str *fns;

      if (le)
          *le = NULL;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 1f36e89dcff7..342938704cfd 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2599,8 +2599,10 @@ static inline bool is_reserved_name(struct 
ntfs_sb_info *sbi,
      if (len == 4 || (len > 4 && le16_to_cpu(name[4]) == '.')) {
          port_digit = le16_to_cpu(name[3]);
          if (port_digit >= '1' && port_digit <= '9')
-            if (!ntfs_cmp_names(name, 3, COM_NAME, 3, upcase, false) ||
-                !ntfs_cmp_names(name, 3, LPT_NAME, 3, upcase, false))
+            if (!ntfs_cmp_names(name, 3, COM_NAME, 3, upcase,
+                        false) ||
+                !ntfs_cmp_names(name, 3, LPT_NAME, 3, upcase,
+                        false))
                  return true;
      }

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 3db34d5c03dc..53ddea219e37 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -93,7 +93,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, 
struct dentry *dentry,
       * If the MFT record of ntfs inode is not a base record, 
inode->i_op can be NULL.
       * This causes null pointer dereference in d_splice_alias().
       */
-    if (!IS_ERR(inode) && inode->i_op == NULL) {
+    if (!IS_ERR_OR_NULL(inode) && !inode->i_op) {
          iput(inode);
          inode = ERR_PTR(-EINVAL);
      }
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 86ea1826d099..90151e56c122 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -435,9 +435,6 @@ static inline u64 attr_svcn(const struct ATTRIB *attr)
      return attr->non_res ? le64_to_cpu(attr->nres.svcn) : 0;
  }

-/* The size of resident attribute by its resident size. */
-#define BYTES_PER_RESIDENT(b) (0x18 + (b))
-
  static_assert(sizeof(struct ATTRIB) == 0x48);
  static_assert(sizeof(((struct ATTRIB *)NULL)->res) == 0x08);
  static_assert(sizeof(((struct ATTRIB *)NULL)->nres) == 0x38);
-- 
2.34.1

