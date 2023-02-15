Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCEF697D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 14:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjBONji (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 08:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjBONjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:39:36 -0500
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F2B17176;
        Wed, 15 Feb 2023 05:39:31 -0800 (PST)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7BA172147;
        Wed, 15 Feb 2023 13:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468119;
        bh=9wqkiqZrKzwvHdcnP28A5rK4lq/9iHl1Vg0imvVpMVU=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=Ia28Fr2nrEgu9o91Mm/j9Nk0suXbvwp5Ungw2+T/I62WuyZZxsRQYsnbeJiKDIZkW
         s4cSvy0NEpsRforX3ljS87lVdtjOtEH+KjpMTa7ooJPW4ynlFlPGtyalELiiKnyHXk
         r87EWCdPsPnKLCvtgLVFqJFdD1lD6AQeBn7g/MKQ=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C6A9D1E70;
        Wed, 15 Feb 2023 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1676468369;
        bh=9wqkiqZrKzwvHdcnP28A5rK4lq/9iHl1Vg0imvVpMVU=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=qbEqalBfsq1XbhHoWk3MYbtRL3DCq2NLl4F+AkuHeQuHIQwYHaCas/wWEdDf0HIix
         5SKMBWL2yHYWeH2Nq2328+9MD13m3JR7mmtLIy/QCwvRJTCgKxKXxO4vPsxFlb325y
         qFSbRK3JZpOHCfeEJFOHqoEBerOYdXP8LEW6YsE8=
Received: from [192.168.211.36] (192.168.211.36) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 15 Feb 2023 16:39:29 +0300
Message-ID: <83fcdf79-dbb0-e693-cc66-877f3bb22eac@paragon-software.com>
Date:   Wed, 15 Feb 2023 17:39:28 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: [PATCH 09/11] fs/ntfs3: Code formatting and refactoring
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
In-Reply-To: <d7c91201-5e09-5c06-3283-7887f5a5b7f1@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.211.36]
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

Added minor refactoring.
Added and fixed some comments.
In some places, the code has been reformatted to fit into 80 columns.
clang-format-12 was used to format code according kernel's .clang-format.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/attrib.c  | 17 +++++-----
  fs/ntfs3/bitmap.c  | 22 ++++++-------
  fs/ntfs3/file.c    | 25 ++++++++-------
  fs/ntfs3/frecord.c | 37 ++++++++++------------
  fs/ntfs3/fslog.c   | 77 +++++++++++++++++++++++-----------------------
  fs/ntfs3/fsntfs.c  | 13 ++++----
  fs/ntfs3/index.c   | 28 +++++++++--------
  fs/ntfs3/inode.c   | 33 ++++++++++----------
  fs/ntfs3/lznt.c    | 10 +++---
  fs/ntfs3/namei.c   |  4 +--
  fs/ntfs3/ntfs_fs.h |  9 +++---
  fs/ntfs3/record.c  |  9 +++---
  fs/ntfs3/run.c     |  6 ++--
  fs/ntfs3/super.c   | 70 ++++++++++++++++++++++-------------------
  fs/ntfs3/xattr.c   |  4 +--
  15 files changed, 186 insertions(+), 178 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 5e6bafb10f42..0b8bc66377db 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -405,8 +405,8 @@ int attr_set_size(struct ntfs_inode *ni, enum 
ATTR_TYPE type,
      int err = 0;
      struct ntfs_sb_info *sbi = ni->mi.sbi;
      u8 cluster_bits = sbi->cluster_bits;
-    bool is_mft =
-        ni->mi.rno == MFT_REC_MFT && type == ATTR_DATA && !name_len;
+    bool is_mft = ni->mi.rno == MFT_REC_MFT && type == ATTR_DATA &&
+              !name_len;
      u64 old_valid, old_size, old_alloc, new_alloc, new_alloc_tmp;
      struct ATTRIB *attr = NULL, *attr_b;
      struct ATTR_LIST_ENTRY *le, *le_b;
@@ -531,11 +531,10 @@ int attr_set_size(struct ntfs_inode *ni, enum 
ATTR_TYPE type,
              pre_alloc = 0;
              if (type == ATTR_DATA && !name_len &&
                  sbi->options->prealloc) {
-                pre_alloc =
-                    bytes_to_cluster(
-                        sbi,
-                        get_pre_allocated(new_size)) -
-                    new_alen;
+                pre_alloc = bytes_to_cluster(
+                            sbi, get_pre_allocated(
+                                 new_size)) -
+                        new_alen;
              }

              /* Get the last LCN to allocate from. */
@@ -573,8 +572,8 @@ int attr_set_size(struct ntfs_inode *ni, enum 
ATTR_TYPE type,
              err = attr_allocate_clusters(
                  sbi, run, vcn, lcn, to_allocate, &pre_alloc,
                  is_mft ? ALLOCATE_MFT : ALLOCATE_DEF, &alen,
-                is_mft ? 0
-                       : (sbi->record_size -
+                is_mft ? 0 :
+                           (sbi->record_size -
                        le32_to_cpu(rec->used) + 8) /
                               3 +
                           1,
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 393c726ef17a..9a6c6a09d70c 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -40,9 +40,9 @@ static struct kmem_cache *ntfs_enode_cachep;

  int __init ntfs3_init_bitmap(void)
  {
-    ntfs_enode_cachep =
-        kmem_cache_create("ntfs3_enode_cache", sizeof(struct e_node), 0,
-                  SLAB_RECLAIM_ACCOUNT, NULL);
+    ntfs_enode_cachep = kmem_cache_create("ntfs3_enode_cache",
+                          sizeof(struct e_node), 0,
+                          SLAB_RECLAIM_ACCOUNT, NULL);
      return ntfs_enode_cachep ? 0 : -ENOMEM;
  }

@@ -286,9 +286,9 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, 
size_t bit, size_t len,
          if (wnd->uptodated != 1) {
              /* Check bits before 'bit'. */
              ib = wnd->zone_bit == wnd->zone_end ||
-                         bit < wnd->zone_end
-                     ? 0
-                     : wnd->zone_end;
+                         bit < wnd->zone_end ?
+                       0 :
+                       wnd->zone_end;

              while (bit > ib && wnd_is_free_hlp(wnd, bit - 1, 1)) {
                  bit -= 1;
@@ -297,9 +297,9 @@ static void wnd_add_free_ext(struct wnd_bitmap *wnd, 
size_t bit, size_t len,

              /* Check bits after 'end_in'. */
              ib = wnd->zone_bit == wnd->zone_end ||
-                         end_in > wnd->zone_bit
-                     ? wnd->nbits
-                     : wnd->zone_bit;
+                         end_in > wnd->zone_bit ?
+                       wnd->nbits :
+                       wnd->zone_bit;

              while (end_in < ib && wnd_is_free_hlp(wnd, end_in, 1)) {
                  end_in += 1;
@@ -417,8 +417,8 @@ static void wnd_remove_free_ext(struct wnd_bitmap 
*wnd, size_t bit, size_t len)
              return;
          n3 = rb_first(&wnd->count_tree);
          wnd->extent_max =
-            n3 ? rb_entry(n3, struct e_node, count.node)->count.key
-               : 0;
+            n3 ? rb_entry(n3, struct e_node, count.node)->count.key :
+                   0;
          return;
      }

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 09b7931e6be3..a10a905ec7ce 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -22,20 +22,21 @@ static int ntfs_ioctl_fitrim(struct ntfs_sb_info 
*sbi, unsigned long arg)
  {
      struct fstrim_range __user *user_range;
      struct fstrim_range range;
+    struct block_device *dev;
      int err;

      if (!capable(CAP_SYS_ADMIN))
          return -EPERM;

-    if (!bdev_max_discard_sectors(sbi->sb->s_bdev))
+    dev = sbi->sb->s_bdev;
+    if (!bdev_max_discard_sectors(dev))
          return -EOPNOTSUPP;

      user_range = (struct fstrim_range __user *)arg;
      if (copy_from_user(&range, user_range, sizeof(range)))
          return -EFAULT;

-    range.minlen = max_t(u32, range.minlen,
-                 bdev_discard_granularity(sbi->sb->s_bdev));
+    range.minlen = max_t(u32, range.minlen, bdev_discard_granularity(dev));

      err = ntfs_trim_fs(sbi, &range);
      if (err < 0)
@@ -190,8 +191,8 @@ static int ntfs_zero_range(struct inode *inode, u64 
vbo, u64 vbo_to)

      for (; idx < idx_end; idx += 1, from = 0) {
          page_off = (loff_t)idx << PAGE_SHIFT;
-        to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off)
-                             : PAGE_SIZE;
+        to = (page_off + PAGE_SIZE) > vbo_to ? (vbo_to - page_off) :
+                                 PAGE_SIZE;
          iblock = page_off >> inode->i_blkbits;

          page = find_or_create_page(mapping, idx,
@@ -564,13 +565,14 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          ni_unlock(ni);
      } else {
          /* Check new size. */
+        u8 cluster_bits = sbi->cluster_bits;

          /* generic/213: expected -ENOSPC instead of -EFBIG. */
          if (!is_supported_holes) {
              loff_t to_alloc = new_size - inode_get_bytes(inode);

              if (to_alloc > 0 &&
-                (to_alloc >> sbi->cluster_bits) >
+                (to_alloc >> cluster_bits) >
                      wnd_zeroes(&sbi->used.bitmap)) {
                  err = -ENOSPC;
                  goto out;
@@ -591,7 +593,7 @@ static long ntfs_fallocate(struct file *file, int 
mode, loff_t vbo, loff_t len)
          }

          if (is_supported_holes) {
-            CLST vcn = vbo >> sbi->cluster_bits;
+            CLST vcn = vbo >> cluster_bits;
              CLST cend = bytes_to_cluster(sbi, end);
              CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
              CLST lcn, clen;
@@ -1049,8 +1051,8 @@ static ssize_t ntfs_file_write_iter(struct kiocb 
*iocb, struct iov_iter *from)
      if (ret)
          goto out;

-    ret = is_compressed(ni) ? ntfs_compress_write(iocb, from)
-                : __generic_file_write_iter(iocb, from);
+    ret = is_compressed(ni) ? ntfs_compress_write(iocb, from) :
+                    __generic_file_write_iter(iocb, from);

  out:
      inode_unlock(inode);
@@ -1102,8 +1104,9 @@ static int ntfs_file_release(struct inode *inode, 
struct file *file)
      int err = 0;

      /* If we are last writer on the inode, drop the block reservation. */
-    if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
-                      atomic_read(&inode->i_writecount) == 1)) {
+    if (sbi->options->prealloc &&
+        ((file->f_mode & FMODE_WRITE) &&
+         atomic_read(&inode->i_writecount) == 1)) {
          ni_lock(ni);
          down_write(&ni->file.run_lock);

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 9e7dfee303e8..481219f2a7cf 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -76,8 +76,8 @@ struct ATTR_STD_INFO *ni_std(struct ntfs_inode *ni)
      const struct ATTRIB *attr;

      attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);
-    return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO))
-            : NULL;
+    return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO)) :
+                NULL;
  }

  /*
@@ -91,8 +91,8 @@ struct ATTR_STD_INFO5 *ni_std5(struct ntfs_inode *ni)

      attr = mi_find_attr(&ni->mi, NULL, ATTR_STD, NULL, 0, NULL);

-    return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5))
-            : NULL;
+    return attr ? resident_data_ex(attr, sizeof(struct ATTR_STD_INFO5)) :
+                NULL;
  }

  /*
@@ -1439,8 +1439,8 @@ int ni_insert_nonresident(struct ntfs_inode *ni, 
enum ATTR_TYPE type,
      int err;
      CLST plen;
      struct ATTRIB *attr;
-    bool is_ext =
-        (flags & (ATTR_FLAG_SPARSED | ATTR_FLAG_COMPRESSED)) && !svcn;
+    bool is_ext = (flags & (ATTR_FLAG_SPARSED | ATTR_FLAG_COMPRESSED)) &&
+              !svcn;
      u32 name_size = ALIGN(name_len * sizeof(short), 8);
      u32 name_off = is_ext ? SIZEOF_NONRESIDENT_EX : SIZEOF_NONRESIDENT;
      u32 run_off = name_off + name_size;
@@ -1756,9 +1756,9 @@ int ni_new_attr_flags(struct ntfs_inode *ni, enum 
FILE_ATTRIBUTE new_fa)
      }

      /* Resize nonresident empty attribute in-place only. */
-    new_asize = (new_aflags & (ATTR_FLAG_COMPRESSED | ATTR_FLAG_SPARSED))
-                ? (SIZEOF_NONRESIDENT_EX + 8)
-                : (SIZEOF_NONRESIDENT + 8);
+    new_asize = (new_aflags & (ATTR_FLAG_COMPRESSED | ATTR_FLAG_SPARSED)) ?
+                  (SIZEOF_NONRESIDENT_EX + 8) :
+                  (SIZEOF_NONRESIDENT + 8);

      if (!mi_resize_attr(mi, attr, new_asize - le32_to_cpu(attr->size)))
          return -EOPNOTSUPP;
@@ -2965,14 +2965,14 @@ bool ni_remove_name_undo(struct ntfs_inode 
*dir_ni, struct ntfs_inode *ni,
  {
      struct ntfs_sb_info *sbi = ni->mi.sbi;
      struct ATTRIB *attr;
-    u16 de_key_size = de2 ? le16_to_cpu(de2->key_size) : 0;
+    u16 de_key_size;

      switch (undo_step) {
      case 4:
+        de_key_size = le16_to_cpu(de2->key_size);
          if (ni_insert_resident(ni, de_key_size, ATTR_NAME, NULL, 0,
-                       &attr, NULL, NULL)) {
+                       &attr, NULL, NULL))
              return false;
-        }
          memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de2 + 1, de_key_size);

          mi_get_ref(&ni->mi, &de2->ref);
@@ -2981,19 +2981,16 @@ bool ni_remove_name_undo(struct ntfs_inode 
*dir_ni, struct ntfs_inode *ni,
          de2->flags = 0;
          de2->res = 0;

-        if (indx_insert_entry(&dir_ni->dir, dir_ni, de2, sbi, NULL,
-                      1)) {
+        if (indx_insert_entry(&dir_ni->dir, dir_ni, de2, sbi, NULL, 1))
              return false;
-        }
          fallthrough;

      case 2:
          de_key_size = le16_to_cpu(de->key_size);

          if (ni_insert_resident(ni, de_key_size, ATTR_NAME, NULL, 0,
-                       &attr, NULL, NULL)) {
+                       &attr, NULL, NULL))
              return false;
-        }

          memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de + 1, de_key_size);
          mi_get_ref(&ni->mi, &de->ref);
@@ -3162,9 +3159,9 @@ static bool ni_update_parent(struct ntfs_inode 
*ni, struct NTFS_DUP_INFO *dup,
              u64 data_size = le64_to_cpu(attr->nres.data_size);
              __le64 valid_le;

-            dup->alloc_size = is_attr_ext(attr)
-                          ? attr->nres.total_size
-                          : attr->nres.alloc_size;
+            dup->alloc_size = is_attr_ext(attr) ?
+                            attr->nres.total_size :
+                            attr->nres.alloc_size;
              dup->data_size = attr->nres.data_size;

              if (new_valid > data_size)
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index bf7396447284..57762c5fe68b 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -827,10 +827,10 @@ static inline struct RESTART_TABLE 
*extend_rsttbl(struct RESTART_TABLE *tbl,

      memcpy(rt + 1, tbl + 1, esize * used);

-    rt->free_goal = free_goal == ~0u
-                ? cpu_to_le32(~0u)
-                : cpu_to_le32(sizeof(struct RESTART_TABLE) +
-                          free_goal * esize);
+    rt->free_goal = free_goal == ~0u ?
+                      cpu_to_le32(~0u) :
+                      cpu_to_le32(sizeof(struct RESTART_TABLE) +
+                        free_goal * esize);

      if (tbl->first_free) {
          rt->first_free = tbl->first_free;
@@ -1089,9 +1089,9 @@ static inline u64 base_lsn(struct ntfs_log *log,
              (lsn < (lsn_to_vbo(log, h_lsn) & ~log->page_mask) ? 1 : 0))
             << log->file_data_bits) +
            ((((is_log_record_end(hdr) &&
-              h_lsn <= le64_to_cpu(hdr->record_hdr.last_end_lsn))
-                 ? le16_to_cpu(hdr->record_hdr.next_record_off)
-                 : log->page_size) +
+              h_lsn <= le64_to_cpu(hdr->record_hdr.last_end_lsn)) ?
+                   le16_to_cpu(hdr->record_hdr.next_record_off) :
+                   log->page_size) +
              lsn) >>
             3);

@@ -1298,9 +1298,9 @@ static void log_init_pg_hdr(struct ntfs_log *log, 
u32 sys_page_size,
      if (!log->clst_per_page)
          log->clst_per_page = 1;

-    log->first_page = major_ver >= 2
-                  ? 0x22 * page_size
-                  : ((sys_page_size << 1) + (page_size << 1));
+    log->first_page = major_ver >= 2 ?
+                    0x22 * page_size :
+                    ((sys_page_size << 1) + (page_size << 1));
      log->major_ver = major_ver;
      log->minor_ver = minor_ver;
  }
@@ -1512,20 +1512,19 @@ static u32 current_log_avail(struct ntfs_log *log)
       * have to compute the free range.
       * If there is no oldest lsn then start at the first page of the file.
       */
-    oldest_off = (log->l_flags & NTFSLOG_NO_OLDEST_LSN)
-                 ? log->first_page
-                 : (log->oldest_lsn_off & ~log->sys_page_mask);
+    oldest_off = (log->l_flags & NTFSLOG_NO_OLDEST_LSN) ?
+                   log->first_page :
+                   (log->oldest_lsn_off & ~log->sys_page_mask);

      /*
       * We will use the next log page offset to compute the next free page.
       * If we are going to reuse this page go to the next page.
       * If we are at the first page then use the end of the file.
       */
-    next_free_off = (log->l_flags & NTFSLOG_REUSE_TAIL)
-                ? log->next_page + log->page_size
-                : log->next_page == log->first_page
-                      ? log->l_size
-                      : log->next_page;
+    next_free_off = (log->l_flags & NTFSLOG_REUSE_TAIL) ?
+                      log->next_page + log->page_size :
+            log->next_page == log->first_page ? log->l_size :
+                                  log->next_page;

      /* If the two offsets are the same then there is no available 
space. */
      if (oldest_off == next_free_off)
@@ -1535,9 +1534,9 @@ static u32 current_log_avail(struct ntfs_log *log)
       * this range from the total available pages.
       */
      free_bytes =
-        oldest_off < next_free_off
-            ? log->total_avail_pages - (next_free_off - oldest_off)
-            : oldest_off - next_free_off;
+        oldest_off < next_free_off ?
+                  log->total_avail_pages - (next_free_off - oldest_off) :
+                  oldest_off - next_free_off;

      free_bytes >>= log->page_bits;
      return free_bytes * log->reserved;
@@ -1671,8 +1670,8 @@ static int last_log_lsn(struct ntfs_log *log)
      }

      best_lsn1 = first_tail ? base_lsn(log, first_tail, first_file_off) 
: 0;
-    best_lsn2 =
-        second_tail ? base_lsn(log, second_tail, second_file_off) : 0;
+    best_lsn2 = second_tail ? base_lsn(log, second_tail, second_file_off) :
+                    0;

      if (first_tail && second_tail) {
          if (best_lsn1 > best_lsn2) {
@@ -1767,8 +1766,8 @@ static int last_log_lsn(struct ntfs_log *log)

      page_cnt = page_pos = 1;

-    curpage_off = seq_base == log->seq_num ? min(log->next_page, page_off)
-                           : log->next_page;
+    curpage_off = seq_base == log->seq_num ? min(log->next_page, 
page_off) :
+                               log->next_page;

      wrapped_file =
          curpage_off == log->first_page &&
@@ -1826,9 +1825,9 @@ static int last_log_lsn(struct ntfs_log *log)
                  le64_to_cpu(cur_page->record_hdr.last_end_lsn) &&
              ((lsn_cur >> log->file_data_bits) +
               ((curpage_off <
-               (lsn_to_vbo(log, lsn_cur) & ~log->page_mask))
-                  ? 1
-                  : 0)) != expected_seq) {
+               (lsn_to_vbo(log, lsn_cur) & ~log->page_mask)) ?
+                    1 :
+                    0)) != expected_seq) {
              goto check_tail;
          }

@@ -2642,9 +2641,10 @@ static inline bool check_index_root(const struct 
ATTRIB *attr,
  {
      bool ret;
      const struct INDEX_ROOT *root = resident_data(attr);
-    u8 index_bits = le32_to_cpu(root->index_block_size) >= 
sbi->cluster_size
-                ? sbi->cluster_bits
-                : SECTOR_SHIFT;
+    u8 index_bits = le32_to_cpu(root->index_block_size) >=
+                    sbi->cluster_size ?
+                      sbi->cluster_bits :
+                      SECTOR_SHIFT;
      u8 block_clst = root->index_block_clst;

      if (le32_to_cpu(attr->res.data_size) < sizeof(struct INDEX_ROOT) ||
@@ -3683,7 +3683,8 @@ static int do_action(struct ntfs_log *log, struct 
OPEN_ATTR_ENRTY *oe,

      if (a_dirty) {
          attr = oa->attr;
-        err = ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes, 0);
+        err = ntfs_sb_write_run(sbi, oa->run1, vbo, buffer_le, bytes,
+                    0);
          if (err)
              goto out;
      }
@@ -3768,11 +3769,10 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      if (!log)
          return -ENOMEM;

-    memset(&rst_info, 0, sizeof(struct restart_info));
-
      log->ni = ni;
      log->l_size = l_size;
      log->one_page_buf = kmalloc(page_size, GFP_NOFS);
+
      if (!log->one_page_buf) {
          err = -ENOMEM;
          goto out;
@@ -3783,6 +3783,7 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      log->page_bits = blksize_bits(page_size);

      /* Look for a restart area on the disk. */
+    memset(&rst_info, 0, sizeof(struct restart_info));
      err = log_read_rst(log, l_size, true, &rst_info);
      if (err)
          goto out;
@@ -3859,10 +3860,10 @@ int log_replay(struct ntfs_inode *ni, bool 
*initialized)
      log->init_ra = !!rst_info.vbo;

      /* If we have a valid page then grab a pointer to the restart area. */
-    ra2 = rst_info.valid_page
-              ? Add2Ptr(rst_info.r_page,
-                le16_to_cpu(rst_info.r_page->ra_off))
-              : NULL;
+    ra2 = rst_info.valid_page ?
+                Add2Ptr(rst_info.r_page,
+                  le16_to_cpu(rst_info.r_page->ra_off)) :
+                NULL;

      if (rst_info.chkdsk_was_run ||
          (ra2 && ra2->client_idx[1] == LFS_NO_CLIENT_LE)) {
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 9ed9dd0d8edf..0a82b1bf3ec2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -172,8 +172,8 @@ int ntfs_fix_post_read(struct NTFS_RECORD_HEADER 
*rhdr, size_t bytes,
      u16 sample, fo, fn;

      fo = le16_to_cpu(rhdr->fix_off);
-    fn = simple ? ((bytes >> SECTOR_SHIFT) + 1)
-            : le16_to_cpu(rhdr->fix_num);
+    fn = simple ? ((bytes >> SECTOR_SHIFT) + 1) :
+                le16_to_cpu(rhdr->fix_num);

      /* Check errors. */
      if ((fo & 1) || fo + fn * sizeof(short) > SECTOR_SIZE || !fn-- ||
@@ -849,14 +849,13 @@ void ntfs_update_mftmirr(struct ntfs_sb_info *sbi, 
int wait)
      u32 blocksize, bytes;
      sector_t block1, block2;

-    if (!sb)
+    /*
+     * sb can be NULL here. In this case sbi->flags should be 0 too.
+     */
+    if (!sb || !(sbi->flags & NTFS_FLAGS_MFTMIRR))
          return;

      blocksize = sb->s_blocksize;
-
-    if (!(sbi->flags & NTFS_FLAGS_MFTMIRR))
-        return;
-
      bytes = sbi->mft.recs_mirr << sbi->record_bits;
      block1 = sbi->mft.lbo >> sb->s_blocksize_bits;
      block2 = sbi->mft.lbo2 >> sb->s_blocksize_bits;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 5d1ec0124137..0a48d2d67219 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -431,8 +431,9 @@ static int scan_nres_bitmap(struct ntfs_inode *ni, 
struct ATTRIB *bitmap,
          if (vbo + blocksize > data_size)
              nbits = 8 * (data_size - vbo);

-        ok = nbits > from ? (*fn)((ulong *)bh->b_data, from, nbits, ret)
-                  : false;
+        ok = nbits > from ?
+                   (*fn)((ulong *)bh->b_data, from, nbits, ret) :
+                   false;
          put_bh(bh);

          if (ok) {
@@ -764,8 +765,7 @@ static struct NTFS_DE *hdr_find_e(const struct 
ntfs_index *indx,
                  return NULL;

              max_idx = 0;
-            table_size = min(table_size * 2,
-                     (int)ARRAY_SIZE(offs));
+            table_size = min(table_size * 2, (int)ARRAY_SIZE(offs));
              goto fill_table;
          }
      } else if (diff2 < 0) {
@@ -1170,8 +1170,10 @@ int indx_find(struct ntfs_index *indx, struct 
ntfs_inode *ni,

          /* Read next level. */
          err = indx_read(indx, ni, de_get_vbn(e), &node);
-        if (err)
+        if (err) {
+            /* io error? */
              return err;
+        }

          /* Lookup entry that is <= to the search value. */
          e = hdr_find_e(indx, &node->index->ihdr, key, key_len, ctx,
@@ -1673,9 +1675,9 @@ static int indx_insert_into_root(struct ntfs_index 
*indx, struct ntfs_inode *ni,
      mi->dirty = true;

      /* Create alloc and bitmap attributes (if not). */
-    err = run_is_empty(&indx->alloc_run)
-              ? indx_create_allocate(indx, ni, &new_vbn)
-              : indx_add_allocate(indx, ni, &new_vbn);
+    err = run_is_empty(&indx->alloc_run) ?
+                indx_create_allocate(indx, ni, &new_vbn) :
+                indx_add_allocate(indx, ni, &new_vbn);

      /* Layout of record may be changed, so rescan root. */
      root = indx_get_root(indx, ni, &attr, &mi);
@@ -1865,9 +1867,9 @@ indx_insert_into_buffer(struct ntfs_index *indx, 
struct ntfs_inode *ni,
      hdr_insert_de(indx,
                (*indx->cmp)(new_de + 1, le16_to_cpu(new_de->key_size),
                     up_e + 1, le16_to_cpu(up_e->key_size),
-                   ctx) < 0
-                  ? hdr2
-                  : hdr1,
+                   ctx) < 0 ?
+                    hdr2 :
+                    hdr1,
                new_de, NULL, ctx);

      indx_mark_used(indx, ni, new_vbn >> indx->idx2vbn_bits);
@@ -2337,8 +2339,8 @@ int indx_delete_entry(struct ntfs_index *indx, 
struct ntfs_inode *ni,
              err = level ? indx_insert_into_buffer(indx, ni, root,
                                    re, ctx,
                                    fnd->level - 1,
-                                  fnd)
-                    : indx_insert_into_root(indx, ni, re, e,
+                                  fnd) :
+                        indx_insert_into_root(indx, ni, re, e,
                                  ctx, fnd, 0);
              kfree(re);

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 752ad17685c0..f64b1e001501 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -262,8 +262,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
          if (!attr->nres.alloc_size)
              goto next_attr;

-        run = ino == MFT_REC_BITMAP ? &sbi->used.bitmap.run
-                        : &ni->file.run;
+        run = ino == MFT_REC_BITMAP ? &sbi->used.bitmap.run :
+                            &ni->file.run;
          break;

      case ATTR_ROOT:
@@ -290,9 +290,9 @@ static struct inode *ntfs_read_mft(struct inode *inode,
          if (err)
              goto out;

-        mode = sb->s_root
-                   ? (S_IFDIR | (0777 & sbi->options->fs_dmask_inv))
-                   : (S_IFDIR | 0777);
+        mode = sb->s_root ?
+                     (S_IFDIR | (0777 & sbi->options->fs_dmask_inv)) :
+                     (S_IFDIR | 0777);
          goto next_attr;

      case ATTR_ALLOC:
@@ -449,8 +449,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
          ni->std_fa &= ~FILE_ATTRIBUTE_DIRECTORY;
          inode->i_op = &ntfs_file_inode_operations;
          inode->i_fop = &ntfs_file_operations;
-        inode->i_mapping->a_ops =
-            is_compressed(ni) ? &ntfs_aops_cmpr : &ntfs_aops;
+        inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
+                                    &ntfs_aops;
          if (ino != MFT_REC_MFT)
              init_rwsem(&ni->file.run_lock);
      } else if (S_ISCHR(mode) || S_ISBLK(mode) || S_ISFIFO(mode) ||
@@ -786,8 +786,8 @@ static ssize_t ntfs_direct_IO(struct kiocb *iocb, 
struct iov_iter *iter)
      }

      ret = blockdev_direct_IO(iocb, inode, iter,
-                 wr ? ntfs_get_block_direct_IO_W
-                    : ntfs_get_block_direct_IO_R);
+                 wr ? ntfs_get_block_direct_IO_W :
+                        ntfs_get_block_direct_IO_R);

      if (ret > 0)
          end = vbo + ret;
@@ -846,7 +846,7 @@ int ntfs_set_size(struct inode *inode, u64 new_size)
  }

  static int ntfs_resident_writepage(struct page *page,
-        struct writeback_control *wbc, void *data)
+                   struct writeback_control *wbc, void *data)
  {
      struct address_space *mapping = data;
      struct ntfs_inode *ni = ntfs_i(mapping->host);
@@ -887,8 +887,8 @@ int ntfs_write_begin(struct file *file, struct 
address_space *mapping,

      *pagep = NULL;
      if (is_resident(ni)) {
-        struct page *page = grab_cache_page_write_begin(
-            mapping, pos >> PAGE_SHIFT);
+        struct page *page =
+            grab_cache_page_write_begin(mapping, pos >> PAGE_SHIFT);

          if (!page) {
              err = -ENOMEM;
@@ -920,9 +920,8 @@ int ntfs_write_begin(struct file *file, struct 
address_space *mapping,
  /*
   * ntfs_write_end - Address_space_operations::write_end.
   */
-int ntfs_write_end(struct file *file, struct address_space *mapping,
-           loff_t pos, u32 len, u32 copied, struct page *page,
-           void *fsdata)
+int ntfs_write_end(struct file *file, struct address_space *mapping, 
loff_t pos,
+           u32 len, u32 copied, struct page *page, void *fsdata)
  {
      struct inode *inode = mapping->host;
      struct ntfs_inode *ni = ntfs_i(inode);
@@ -1605,8 +1604,8 @@ struct inode *ntfs_create_inode(struct 
user_namespace *mnt_userns,
      } else if (S_ISREG(mode)) {
          inode->i_op = &ntfs_file_inode_operations;
          inode->i_fop = &ntfs_file_operations;
-        inode->i_mapping->a_ops =
-            is_compressed(ni) ? &ntfs_aops_cmpr : &ntfs_aops;
+        inode->i_mapping->a_ops = is_compressed(ni) ? &ntfs_aops_cmpr :
+                                    &ntfs_aops;
          init_rwsem(&ni->file.run_lock);
      } else {
          inode->i_op = &ntfs_special_inode_operations;
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 28f654561f27..61e161c7c567 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -296,8 +296,8 @@ static inline ssize_t decompress_chunk(u8 *unc, u8 
*unc_end, const u8 *cmpr,
   */
  struct lznt *get_lznt_ctx(int level)
  {
-    struct lznt *r = kzalloc(level ? offsetof(struct lznt, hash)
-                       : sizeof(struct lznt),
+    struct lznt *r = kzalloc(level ? offsetof(struct lznt, hash) :
+                           sizeof(struct lznt),
                   GFP_NOFS);

      if (r)
@@ -392,9 +392,9 @@ ssize_t decompress_lznt(const void *cmpr, size_t 
cmpr_size, void *unc,
              unc_use = err;
          } else {
              /* This chunk does not contain compressed data. */
-            unc_use = unc_chunk + LZNT_CHUNK_SIZE > unc_end
-                      ? unc_end - unc_chunk
-                      : LZNT_CHUNK_SIZE;
+            unc_use = unc_chunk + LZNT_CHUNK_SIZE > unc_end ?
+                        unc_end - unc_chunk :
+                        LZNT_CHUNK_SIZE;

              if (cmpr_chunk + sizeof(chunk_hdr) + unc_use >
                  cmpr_end) {
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index 8b68ead5cc1f..5d5a251334a1 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -433,8 +433,8 @@ static int ntfs_atomic_open(struct inode *dir, 
struct dentry *dentry,

      inode = ntfs_create_inode(&init_user_ns, dir, dentry, uni, mode, 0,
                    NULL, 0, fnd);
-    err = IS_ERR(inode) ? PTR_ERR(inode)
-                : finish_open(file, dentry, ntfs_file_open);
+    err = IS_ERR(inode) ? PTR_ERR(inode) :
+                    finish_open(file, dentry, ntfs_file_open);
      dput(d);

  out2:
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index b7782107ce8a..9a2d965f183e 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -338,7 +338,7 @@ enum ntfs_inode_mutex_lock_class {
  };

  /*
- * sturct ntfs_inode
+ * struct ntfs_inode
   *
   * Ntfs inode - extends linux inode. consists of one or more MFT inodes.
   */
@@ -697,9 +697,8 @@ int ntfs_get_block(struct inode *inode, sector_t vbn,
             struct buffer_head *bh_result, int create);
  int ntfs_write_begin(struct file *file, struct address_space *mapping,
               loff_t pos, u32 len, struct page **pagep, void **fsdata);
-int ntfs_write_end(struct file *file, struct address_space *mapping,
-           loff_t pos, u32 len, u32 copied, struct page *page,
-           void *fsdata);
+int ntfs_write_end(struct file *file, struct address_space *mapping, 
loff_t pos,
+           u32 len, u32 copied, struct page *page, void *fsdata);
  int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
  int ntfs_sync_inode(struct inode *inode);
  int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
@@ -856,7 +855,7 @@ unsigned long ntfs_names_hash(const u16 *name, 
size_t len, const u16 *upcase,
  /* globals from xattr.c */
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
  struct posix_acl *ntfs_get_acl(struct user_namespace *mnt_userns,
-         struct dentry *dentry, int type);
+                   struct dentry *dentry, int type);
  int ntfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
           struct posix_acl *acl, int type);
  int ntfs_init_acl(struct user_namespace *mnt_userns, struct inode *inode,
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 0603169ee8a0..2a281cead2bc 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -419,10 +419,9 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, 
enum ATTR_TYPE type,
      struct ntfs_sb_info *sbi = mi->sbi;
      u32 used = le32_to_cpu(rec->used);
      const u16 *upcase = sbi->upcase;
-    int diff;

      /* Can we insert mi attribute? */
-    if (used + asize > mi->sbi->record_size)
+    if (used + asize > sbi->record_size)
          return NULL;

      /*
@@ -431,7 +430,7 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, 
enum ATTR_TYPE type,
       */
      attr = NULL;
      while ((attr = mi_enum_attr(mi, attr))) {
-        diff = compare_attr(attr, type, name, name_len, upcase);
+        int diff = compare_attr(attr, type, name, name_len, upcase);

          if (diff < 0)
              continue;
@@ -442,9 +441,11 @@ struct ATTRIB *mi_insert_attr(struct mft_inode *mi, 
enum ATTR_TYPE type,
      }

      if (!attr) {
-        tail = 8; /* Not used, just to suppress warning. */
+        /* Append. */
+        tail = 8;
          attr = Add2Ptr(rec, used - 8);
      } else {
+        /* Insert before 'attr'. */
          tail = used - PtrOffset(rec, attr);
      }

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index a5af71cd8d14..47612d16c027 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -433,9 +433,9 @@ bool run_add_entry(struct runs_tree *run, CLST vcn, 
CLST lcn, CLST len,
              should_add_tail = Tovcn < r->len;

              if (should_add_tail) {
-                tail_lcn = r->lcn == SPARSE_LCN
-                           ? SPARSE_LCN
-                           : (r->lcn + Tovcn);
+                tail_lcn = r->lcn == SPARSE_LCN ?
+                             SPARSE_LCN :
+                             (r->lcn + Tovcn);
                  tail_vcn = r->vcn + Tovcn;
                  tail_len = r->len - Tovcn;
              }
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index d7bec9b28a42..6a412826b43d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -39,10 +39,10 @@
   * To mount large volumes as ntfs one should use large cluster size 
(up to 2M)
   * The maximum volume size in this case is 2^32 * 2^21 = 2^53 = 8P
   *
- *     ntfs limits, cluster size is 2M (2^31)
+ *     ntfs limits, cluster size is 2M (2^21)
   * 
-----------------------------------------------------------------------------
- * | < 8P, 2^54    |  < 2^32  |  yes     |  yes   |   yes |  yes   |  
yes   |
- * | > 8P, 2^54    |  > 2^32  |  no      |  no    |   yes |  yes   |  
yes   |
+ * | < 8P, 2^53    |  < 2^32  |  yes     |  yes   |   yes |  yes   |  
yes   |
+ * | > 8P, 2^53    |  > 2^32  |  no      |  no    |   yes |  yes   |  
yes   |
   * 
----------------------------------------------------------|------------------
   *
   */
@@ -115,9 +115,9 @@ void ntfs_inode_printk(struct inode *inode, const 
char *fmt, ...)
          return;

      /* Use static allocated buffer, if possible. */
-    name = atomic_dec_and_test(&s_name_buf_cnt)
-               ? s_name_buf
-               : kmalloc(sizeof(s_name_buf), GFP_NOFS);
+    name = atomic_dec_and_test(&s_name_buf_cnt) ?
+                 s_name_buf :
+                 kmalloc(sizeof(s_name_buf), GFP_NOFS);

      if (name) {
          struct dentry *de = d_find_alias(inode);
@@ -369,7 +369,8 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
              fc->sb_flags |= SB_POSIXACL;
  #else
-            return invalf(fc, "ntfs3: Support for ACL not compiled in!");
+            return invalf(
+                fc, "ntfs3: Support for ACL not compiled in!");
  #endif
          else
              fc->sb_flags &= ~SB_POSIXACL;
@@ -404,24 +405,29 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)

      ro_rw = sb_rdonly(sb) && !(fc->sb_flags & SB_RDONLY);
      if (ro_rw && (sbi->flags & NTFS_FLAGS_NEED_REPLAY)) {
-        errorf(fc, "ntfs3: Couldn't remount rw because journal is not 
replayed. Please umount/remount instead\n");
+        errorf(fc,
+               "ntfs3: Couldn't remount rw because journal is not 
replayed. Please umount/remount instead\n");
          return -EINVAL;
      }

      new_opts->nls = ntfs_load_nls(new_opts->nls_name);
      if (IS_ERR(new_opts->nls)) {
          new_opts->nls = NULL;
-        errorf(fc, "ntfs3: Cannot load iocharset %s", new_opts->nls_name);
+        errorf(fc, "ntfs3: Cannot load iocharset %s",
+               new_opts->nls_name);
          return -EINVAL;
      }
      if (new_opts->nls != sbi->options->nls)
-        return invalf(fc, "ntfs3: Cannot use different iocharset when 
remounting!");
+        return invalf(
+            fc,
+            "ntfs3: Cannot use different iocharset when remounting!");

      sync_filesystem(sb);

      if (ro_rw && (sbi->volume.flags & VOLUME_FLAG_DIRTY) &&
          !new_opts->force) {
-        errorf(fc, "ntfs3: Volume is dirty and \"force\" flag is not 
set!");
+        errorf(fc,
+               "ntfs3: Volume is dirty and \"force\" flag is not set!");
          return -EINVAL;
      }

@@ -539,10 +545,8 @@ static int ntfs_show_options(struct seq_file *m, 
struct dentry *root)
      struct ntfs_mount_options *opts = sbi->options;
      struct user_namespace *user_ns = seq_user_ns(m);

-    seq_printf(m, ",uid=%u",
-          from_kuid_munged(user_ns, opts->fs_uid));
-    seq_printf(m, ",gid=%u",
-          from_kgid_munged(user_ns, opts->fs_gid));
+    seq_printf(m, ",uid=%u", from_kuid_munged(user_ns, opts->fs_uid));
+    seq_printf(m, ",gid=%u", from_kgid_munged(user_ns, opts->fs_gid));
      if (opts->fmask)
          seq_printf(m, ",fmask=%04o", opts->fs_fmask_inv ^ 0xffff);
      if (opts->dmask)
@@ -699,7 +703,7 @@ static u32 true_sectors_per_clst(const struct 
NTFS_BOOT *boot)
      if (boot->sectors_per_clusters <= 0x80)
          return boot->sectors_per_clusters;
      if (boot->sectors_per_clusters >= 0xf4) /* limit shift to 2MB max */
-        return 1U << -(s8)boot->sectors_per_clusters;
+        return 1U << (-(s8)boot->sectors_per_clusters);
      return -EINVAL;
  }

@@ -717,6 +721,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      struct buffer_head *bh;
      struct MFT_REC *rec;
      u16 fn, ao;
+    u8 cluster_bits;

      sbi->volume.blocks = dev_size >> PAGE_SHIFT;

@@ -784,7 +789,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      if (boot_sector_size != sector_size) {
          ntfs_warn(
              sb,
-            "Different NTFS sector size (%u) and media sector size (%u)",
+            "Different NTFS sector size (%u) and media sector size (%u).",
              boot_sector_size, sector_size);
          dev_size += sector_size - 1;
      }
@@ -792,8 +797,8 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      sbi->cluster_size = boot_sector_size * sct_per_clst;
      sbi->cluster_bits = blksize_bits(sbi->cluster_size);

-    sbi->mft.lbo = mlcn << sbi->cluster_bits;
-    sbi->mft.lbo2 = mlcn2 << sbi->cluster_bits;
+    sbi->mft.lbo = mlcn << cluster_bits;
+    sbi->mft.lbo2 = mlcn2 << cluster_bits;

      /* Compare boot's cluster and sector. */
      if (sbi->cluster_size < boot_sector_size)
@@ -804,7 +809,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
          /* No way to use ntfs_get_block in this case. */
          ntfs_err(
              sb,
-            "Failed to mount 'cause NTFS's cluster size (%u) is less 
than media sector size (%u)",
+            "Failed to mount 'cause NTFS's cluster size (%u) is less 
than media sector size (%u).",
              sbi->cluster_size, sector_size);
          goto out;
      }
@@ -840,18 +845,18 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
          gb0 = format_size_gb(dev_size, &mb0);
          ntfs_warn(
              sb,
-            "RAW NTFS volume: Filesystem size %u.%02u Gb > volume size 
%u.%02u Gb. Mount in read-only",
+            "RAW NTFS volume: Filesystem size %u.%02u Gb > volume size 
%u.%02u Gb. Mount in read-only.",
              gb, mb, gb0, mb0);
          sb->s_flags |= SB_RDONLY;
      }

-    clusters = sbi->volume.size >> sbi->cluster_bits;
+    clusters = sbi->volume.size >> cluster_bits;
  #ifndef CONFIG_NTFS3_64BIT_CLUSTER
      /* 32 bits per cluster. */
      if (clusters >> 32) {
          ntfs_notice(
              sb,
-            "NTFS %u.%02u Gb is too big to use 32 bits per cluster",
+            "NTFS %u.%02u Gb is too big to use 32 bits per cluster.",
              gb, mb);
          goto out;
      }
@@ -885,17 +890,17 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
      sbi->volume.blocks = sbi->volume.size >> sb->s_blocksize_bits;

      /* Maximum size for normal files. */
-    sbi->maxbytes = (clusters << sbi->cluster_bits) - 1;
+    sbi->maxbytes = (clusters << cluster_bits) - 1;

  #ifdef CONFIG_NTFS3_64BIT_CLUSTER
-    if (clusters >= (1ull << (64 - sbi->cluster_bits)))
+    if (clusters >= (1ull << (64 - cluster_bits)))
          sbi->maxbytes = -1;
      sbi->maxbytes_sparse = -1;
      sb->s_maxbytes = MAX_LFS_FILESIZE;
  #else
      /* Maximum size for sparse file. */
-    sbi->maxbytes_sparse = (1ull << (sbi->cluster_bits + 32)) - 1;
-    sb->s_maxbytes = 0xFFFFFFFFull << sbi->cluster_bits;
+    sbi->maxbytes_sparse = (1ull << (cluster_bits + 32)) - 1;
+    sb->s_maxbytes = 0xFFFFFFFFull << cluster_bits;
  #endif

      /*
@@ -903,7 +908,7 @@ static int ntfs_init_from_boot(struct super_block 
*sb, u32 sector_size,
       * It would be nice if we are able to allocate 1/8 of
       * total clusters for MFT but not more then 512 MB.
       */
-    sbi->zone_max = min_t(CLST, 0x20000000 >> sbi->cluster_bits, 
clusters >> 3);
+    sbi->zone_max = min_t(CLST, 0x20000000 >> cluster_bits, clusters >> 3);

      err = 0;

@@ -1433,7 +1438,7 @@ static const struct fs_context_operations 
ntfs_context_ops = {
  };

  /*
- * ntfs_init_fs_context - Initialize spi and opts
+ * ntfs_init_fs_context - Initialize sbi and opts
   *
   * This will called when mount/remount. We will first initialize
   * options so that if remount we can use just that.
@@ -1506,7 +1511,8 @@ static int __init init_ntfs_fs(void)
      if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
          pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
      if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
-        pr_notice("ntfs3: Warning: Activated 64 bits per cluster. 
Windows does not support this\n");
+        pr_notice(
+            "ntfs3: Warning: Activated 64 bits per cluster. Windows 
does not support this\n");
      if (IS_ENABLED(CONFIG_NTFS3_LZX_XPRESS))
          pr_info("ntfs3: Read-only LZX/Xpress compression included\n");

@@ -1549,7 +1555,9 @@ MODULE_DESCRIPTION("ntfs3 read/write filesystem");
  MODULE_INFO(behaviour, "Enabled Linux POSIX ACLs support");
  #endif
  #ifdef CONFIG_NTFS3_64BIT_CLUSTER
-MODULE_INFO(cluster, "Warning: Activated 64 bits per cluster. Windows 
does not support this");
+MODULE_INFO(
+    cluster,
+    "Warning: Activated 64 bits per cluster. Windows does not support 
this");
  #endif
  #ifdef CONFIG_NTFS3_LZX_XPRESS
  MODULE_INFO(compression, "Read-only lzx/xpress compression included");
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 95c479d7ebba..0a6d2ec8c340 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -23,8 +23,8 @@

  static inline size_t unpacked_ea_size(const struct EA_FULL *ea)
  {
-    return ea->size ? le32_to_cpu(ea->size)
-            : ALIGN(struct_size(ea, name,
+    return ea->size ? le32_to_cpu(ea->size) :
+                ALIGN(struct_size(ea, name,
                          1 + ea->name_len +
                              le16_to_cpu(ea->elength)),
                  4);
-- 
2.34.1

